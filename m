Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVI3BAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVI3BAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVI3BAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:00:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:58030 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932534AbVI3BAk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:00:40 -0400
Date: Thu, 29 Sep 2005 20:00:38 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ppc64: EEH Avoid racing reports of errors
Message-ID: <20050930010038.GF6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930004800.GL29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



06-eeh-report-race.patch

When a PCI slot is isolated, all PCI functions under that slot are affected.
If hese functions have separate device drivers, the EEH isolation event
might be reported multiple times. This patch adds a lock to prevent the 
racing of such multiple reports. It also marks every device under the slot
as having experienced an EEH event, so that multiple reports may be 
recognized more easily.

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-09-29 16:06:33.567867154 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-09-29 16:06:39.106090510 -0500
@@ -96,6 +96,9 @@
 
 static int eeh_subsystem_enabled;
 
+/* Lock to avoid races due to multiple reports of an error */
+static DEFINE_SPINLOCK(confirm_error_lock);
+
 /* Buffer for reporting slot-error-detail rtas calls */
 static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
 static DEFINE_SPINLOCK(slot_errbuf_lock);
@@ -544,6 +547,55 @@
 	return pa | (token & (PAGE_SIZE-1));
 }
 
+/** 
+ * Return the "partitionable endpoint" (pe) under which this device lies
+ */
+static struct device_node * find_device_pe(struct device_node *dn)
+{
+	while ((dn->parent) && PCI_DN(dn->parent) &&
+	      (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
+		dn = dn->parent;
+	}
+	return dn;
+}
+
+/** Mark all devices that are peers of this device as failed.
+ *  Mark the device driver too, so that it can see the failure
+ *  immediately; this is critical, since some drivers poll
+ *  status registers in interrupts ... If a driver is polling,
+ *  and the slot is frozen, then the driver can deadlock in
+ *  an interrupt context, which is bad.
+ */
+
+static inline void __eeh_mark_slot (struct device_node *dn)
+{
+	while (dn) {
+		PCI_DN(dn)->eeh_mode |= EEH_MODE_ISOLATED;
+
+		if (dn->child)
+			__eeh_mark_slot (dn->child);
+		dn = dn->sibling;
+	}
+}
+
+static inline void __eeh_clear_slot (struct device_node *dn)
+{
+	while (dn) {
+		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_ISOLATED;
+		if (dn->child)
+			__eeh_clear_slot (dn->child);
+		dn = dn->sibling;
+	}
+}
+
+static inline void eeh_clear_slot (struct device_node *dn)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&confirm_error_lock, flags);
+	__eeh_clear_slot (dn);
+	spin_unlock_irqrestore(&confirm_error_lock, flags);
+}
+
 /**
  * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
  * @dn device node
@@ -567,6 +619,8 @@
 	int reset_state;
 	struct eeh_event  *event;
 	struct pci_dn *pdn;
+	struct device_node *pe_dn;
+	int rc = 0;
 
 	__get_cpu_var(total_mmio_ffs)++;
 
@@ -594,10 +648,14 @@
 		return 0;
 	}
 
-	/*
-	 * If we already have a pending isolation event for this
-	 * slot, we know it's bad already, we don't need to check...
+	/* If we already have a pending isolation event for this
+	 * slot, we know it's bad already, we don't need to check.
+	 * Do this checking under a lock; as multiple PCI devices
+	 * in one slot might report errors simultaneously, and we
+	 * only want one error recovery routine running.
 	 */
+	spin_lock_irqsave(&confirm_error_lock, flags);
+	rc = 1;
 	if (pdn->eeh_mode & EEH_MODE_ISOLATED) {
 		atomic_inc(&eeh_fail_count);
 		if (atomic_read(&eeh_fail_count) >= EEH_MAX_FAILS) {
@@ -606,7 +664,7 @@
 				rets[0] = -1;	/* reset state unknown */
 			eeh_panic(dev, rets[0]);
 		}
-		return 0;
+		goto dn_unlock;
 	}
 
 	/*
@@ -623,7 +681,8 @@
 		printk(KERN_WARNING "EEH: read_slot_reset_state() failed; rc=%d dn=%s\n",
 		       ret, dn->full_name);
 		__get_cpu_var(false_positives)++;
-		return 0;
+		rc = 0;
+		goto dn_unlock;
 	}
 
 	/* If EEH is not supported on this device, punt. */
@@ -631,25 +690,33 @@
 		printk(KERN_WARNING "EEH: event on unsupported device, rc=%d dn=%s\n",
 		       ret, dn->full_name);
 		__get_cpu_var(false_positives)++;
-		return 0;
+		rc = 0;
+		goto dn_unlock;
 	}
 
 	/* If not the kind of error we know about, punt. */
 	if (rets[0] != 2 && rets[0] != 4 && rets[0] != 5) {
 		__get_cpu_var(false_positives)++;
-		return 0;
+		rc = 0;
+		goto dn_unlock;
 	}
 
 	/* Note that config-io to empty slots may fail;
 	 * we recognize empty because they don't have children. */
 	if ((rets[0] == 5) && (dn->child == NULL)) {
 		__get_cpu_var(false_positives)++;
-		return 0;
+		rc = 0;
+		goto dn_unlock;
 	}
 
-	/* prevent repeated reports of this failure */
-	pdn->eeh_mode |= EEH_MODE_ISOLATED;
-	 __get_cpu_var(slot_resets)++;
+	__get_cpu_var(slot_resets)++;
+ 
+	/* Avoid repeated reports of this failure, including problems
+	 * with other functions on this device, and functions under
+	 * bridges. */
+	pe_dn = find_device_pe (dn);
+	__eeh_mark_slot (pe_dn);
+	spin_unlock_irqrestore(&confirm_error_lock, flags);
 
 	reset_state = rets[0];
 
@@ -678,10 +745,14 @@
 	if (rets[0] != 5) dump_stack();
 	schedule_work(&eeh_event_wq);
 
-	return 0;
+	return 1;
+
+dn_unlock:
+	spin_unlock_irqrestore(&confirm_error_lock, flags);
+	return rc;
 }
 
-EXPORT_SYMBOL(eeh_dn_check_failure);
+EXPORT_SYMBOL_GPL(eeh_dn_check_failure);
 
 /**
  * eeh_check_failure - check if all 1's data is due to EEH slot freeze
@@ -820,6 +891,7 @@
 	struct device_node *phb, *np;
 	struct eeh_early_enable_info info;
 
+	spin_lock_init(&confirm_error_lock);
 	spin_lock_init(&slot_errbuf_lock);
 
 	np = of_find_node_by_path("/rtas");
