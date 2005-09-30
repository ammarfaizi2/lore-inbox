Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVI3A5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVI3A5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVI3A5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:57:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:1987 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932529AbVI3A5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:57:00 -0400
Date: Thu, 29 Sep 2005 19:56:50 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] ppc64: EEH PCI slot error details abstraction
Message-ID: <20050930005650.GD6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930004800.GL29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


04-eeh-slot-error-detail.patch

This patch encapsulates a section of code that reports the EEH event.
The new subroutine can be used in several places to report the eror.

Signed-off-by: Linas Vepstas <linas@linas.org>


Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-09-29 16:05:53.025549160 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-09-29 16:06:25.583986100 -0500
@@ -397,6 +397,28 @@
 /* --------------------------------------------------------------- */
 /* Above lies the PCI Address Cache. Below lies the EEH event infrastructure */
 
+void eeh_slot_error_detail (struct pci_dn *pdn, int severity)
+{
+	unsigned long flags;
+	int rc;
+
+	/* Log the error with the rtas logger */
+	spin_lock_irqsave(&slot_errbuf_lock, flags);
+	memset(slot_errbuf, 0, eeh_error_buf_size);
+
+	rc = rtas_call(ibm_slot_error_detail,
+	               8, 1, NULL, pdn->eeh_config_addr,
+	               BUID_HI(pdn->phb->buid),
+	               BUID_LO(pdn->phb->buid), NULL, 0,
+	               virt_to_phys(slot_errbuf),
+	               eeh_error_buf_size,
+	               severity);
+
+	if (rc == 0)
+		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
+	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
+}
+
 /**
  * eeh_register_notifier - Register to find out about EEH events.
  * @nb: notifier block to callback on events
@@ -454,9 +476,12 @@
 	 * Since the panic_on_oops sysctl is used to halt the system
 	 * in light of potential corruption, we can use it here.
 	 */
-	if (panic_on_oops)
+	if (panic_on_oops) {
+		struct device_node *dn = pci_device_to_OF_node(dev);
+		eeh_slot_error_detail (PCI_DN(dn), 2 /* Permanent Error */);
 		panic("EEH: MMIO failure (%d) on device:%s\n", reset_state,
 		      pci_name(dev));
+	}
 	else {
 		__get_cpu_var(ignored_failures)++;
 		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s\n",
@@ -539,7 +564,7 @@
 	int ret;
 	int rets[3];
 	unsigned long flags;
-	int rc, reset_state;
+	int reset_state;
 	struct eeh_event  *event;
 	struct pci_dn *pdn;
 
@@ -603,20 +628,7 @@
 
 	reset_state = rets[0];
 
-	spin_lock_irqsave(&slot_errbuf_lock, flags);
-	memset(slot_errbuf, 0, eeh_error_buf_size);
-
-	rc = rtas_call(ibm_slot_error_detail,
-	               8, 1, NULL, pdn->eeh_config_addr,
-	               BUID_HI(pdn->phb->buid),
-	               BUID_LO(pdn->phb->buid), NULL, 0,
-	               virt_to_phys(slot_errbuf),
-	               eeh_error_buf_size,
-	               1 /* Temporary Error */);
-
-	if (rc == 0)
-		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
-	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
+	eeh_slot_error_detail (pdn, 1 /* Temporary Error */);
 
 	printk(KERN_INFO "EEH: MMIO failure (%d) on device: %s %s\n",
 	       rets[0], dn->name, dn->full_name);
@@ -783,6 +795,8 @@
 	struct device_node *phb, *np;
 	struct eeh_early_enable_info info;
 
+	spin_lock_init(&slot_errbuf_lock);
+
 	np = of_find_node_by_path("/rtas");
 	if (np == NULL)
 		return;
