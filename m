Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVJFXdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVJFXdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVJFXdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:33:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15331 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932081AbVJFXdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:33:24 -0400
Date: Thu, 6 Oct 2005 18:33:20 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 8/22] ppc64: Slot Marking Bugfix
Message-ID: <20051006233320.GI29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


08-eeh-slot-marking-bug.patch

A device that experiences a PCI outage may be just one deivce out 
of many that was affected. In order to avoid repeated reports of 
a failure, the entire tree of affected devices should be marked 
as failed. This patch marks up the entire tree.

Signed-off-by: Linas Vepstas <linas@linas.org>


Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-10-06 17:52:37.399078590 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-10-06 17:53:02.164603746 -0500
@@ -480,32 +480,47 @@
  *  an interrupt context, which is bad.
  */
 
-static inline void __eeh_mark_slot (struct device_node *dn)
+static inline void __eeh_mark_slot (struct device_node *dn, int mode_flag)
 {
 	while (dn) {
-		PCI_DN(dn)->eeh_mode |= EEH_MODE_ISOLATED;
+		if (PCI_DN(dn)) {
+			PCI_DN(dn)->eeh_mode |= mode_flag;
 
-		if (dn->child)
-			__eeh_mark_slot (dn->child);
+			if (dn->child)
+				__eeh_mark_slot (dn->child, mode_flag);
+		}
 		dn = dn->sibling;
 	}
 }
 
-static inline void __eeh_clear_slot (struct device_node *dn)
+void eeh_mark_slot (struct device_node *dn, int mode_flag)
+{
+	dn = find_device_pe (dn);
+	PCI_DN(dn)->eeh_mode |= mode_flag;
+	__eeh_mark_slot (dn->child, mode_flag);
+}
+
+static inline void __eeh_clear_slot (struct device_node *dn, int mode_flag)
 {
 	while (dn) {
-		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_ISOLATED;
-		if (dn->child)
-			__eeh_clear_slot (dn->child);
+		if (PCI_DN(dn)) {
+			PCI_DN(dn)->eeh_mode &= ~mode_flag;
+			PCI_DN(dn)->eeh_check_count = 0;
+			if (dn->child)
+				__eeh_clear_slot (dn->child, mode_flag);
+		}
 		dn = dn->sibling;
 	}
 }
 
-static inline void eeh_clear_slot (struct device_node *dn)
+void eeh_clear_slot (struct device_node *dn, int mode_flag)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&confirm_error_lock, flags);
-	__eeh_clear_slot (dn);
+	dn = find_device_pe (dn);
+	PCI_DN(dn)->eeh_mode &= ~mode_flag;
+	PCI_DN(dn)->eeh_check_count = 0;
+	__eeh_clear_slot (dn->child, mode_flag);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
 
@@ -530,7 +545,6 @@
 	int rets[3];
 	unsigned long flags;
 	struct pci_dn *pdn;
-	struct device_node *pe_dn;
 	int rc = 0;
 
 	__get_cpu_var(total_mmio_ffs)++;
@@ -632,8 +646,7 @@
 	/* Avoid repeated reports of this failure, including problems
 	 * with other functions on this device, and functions under
 	 * bridges. */
-	pe_dn = find_device_pe (dn);
-	__eeh_mark_slot (pe_dn);
+	eeh_mark_slot (dn, EEH_MODE_ISOLATED);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 
 	eeh_send_failure_event (dn, dev, rets[0], rets[2]);
@@ -745,9 +758,6 @@
 		        rc, state, pdn->node->full_name);
 		return;
 	}
-
-	if (state == 0)
-		eeh_clear_slot (pdn->node->parent->child);
 }
 
 /** rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
@@ -766,6 +776,12 @@
 
 #define PCI_BUS_RST_HOLD_TIME_MSEC 250
 	msleep (PCI_BUS_RST_HOLD_TIME_MSEC);
+	
+	/* We might get hit with another EEH freeze as soon as the 
+	 * pci slot reset line is dropped. Make sure we don't miss
+	 * these, and clear the flag now. */
+	eeh_clear_slot (pdn->node, EEH_MODE_ISOLATED);
+
 	rtas_pci_slot_reset (pdn, 0);
 
 	/* After a PCI slot has been reset, the PCI Express spec requires
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci.h	2005-10-06 17:52:37.399078590 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.h	2005-10-06 17:53:02.165603605 -0500
@@ -86,6 +86,13 @@
 
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 
+/**
+ * mark and clear slots: find "partition endpoint" PE and set or 
+ * clear the flags for each subnode of the PE.
+ */
+void eeh_mark_slot (struct device_node *dn, int mode_flag);
+void eeh_clear_slot (struct device_node *dn, int mode_flag);
+
 #endif
 
 #endif /* __PPC_KERNEL_PCI_H__ */
