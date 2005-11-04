Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbVKDAtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbVKDAtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbVKDAtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:49:15 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:39059
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1030574AbVKDAtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:49:01 -0500
Date: Thu, 3 Nov 2005 18:49:01 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 5/42]: ppc64: RTAS error reporting restructuring
Message-ID: <20051104004901.GA26819@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05-eeh-slot-error-detail.patch

This patch encapsulates a section of code that reports the EEH event.
The new subroutine can be used in several places to report the error.

Signed-off-by: Linas Vepstas <linas@linas.org>


Index: linux-2.6.14-git3/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/ppc64/kernel/eeh.c	2005-10-31 12:11:57.134291514 -0600
+++ linux-2.6.14-git3/arch/ppc64/kernel/eeh.c	2005-10-31 12:13:09.282168648 -0600
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
