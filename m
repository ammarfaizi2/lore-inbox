Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752135AbWCCBtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbWCCBtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbWCCBsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:54 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:39149 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1752137AbWCCBsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:30 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 14/15] EDAC: protect memory controller list
Date: Thu, 2 Mar 2006 17:48:16 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.16264.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix code so we always hold mem_ctls_mutex while we are stepping
  through the list of mem_ctl_info structures.  Otherwise bad things
  may happen if one task is stepping through the list while another
  task is modifying it.  We may eventually want to use reference
  counting to manage the mem_ctl_info structures.  In the meantime we
  may as well fix this bug.

- Don't disable interrupts while we are walking the list of
  mem_ctl_info structures in check_mc_devices().  This is unnecessary.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/amd76x_edac.c	2006-02-27 17:05:48.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/amd76x_edac.c	2006-02-27 17:08:15.000000000 -0800
@@ -314,10 +314,9 @@ static void __devexit amd76x_remove_one(
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_find_mci_by_pdev(pdev)) == NULL)
-		return;
-	if (edac_mc_del_mc(mci))
+	if ((mci = edac_mc_del_mc(pdev)) == NULL)
 		return;
+
 	edac_mc_free(mci);
 }
 
Index: linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e752x_edac.c	2006-02-27 17:05:48.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c	2006-02-27 17:08:15.000000000 -0800
@@ -976,10 +976,7 @@ static void __devexit e752x_remove_one(s
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_find_mci_by_pdev(pdev)) == NULL)
-		return;
-
-	if (edac_mc_del_mc(mci))
+	if ((mci = edac_mc_del_mc(pdev)) == NULL)
 		return;
 
 	pvt = (struct e752x_pvt *) mci->pvt_info;
Index: linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e7xxx_edac.c	2006-02-27 17:05:48.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e7xxx_edac.c	2006-02-27 17:08:15.000000000 -0800
@@ -510,12 +510,12 @@ static void __devexit e7xxx_remove_one(s
 
 	debugf0("%s()\n", __func__);
 
-	if (((mci = edac_mc_find_mci_by_pdev(pdev)) != 0) &&
-	    !edac_mc_del_mc(mci)) {
-		pvt = (struct e7xxx_pvt *) mci->pvt_info;
-		pci_dev_put(pvt->bridge_ck);
-		edac_mc_free(mci);
-	}
+	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+		return;
+
+	pvt = (struct e7xxx_pvt *) mci->pvt_info;
+	pci_dev_put(pvt->bridge_ck);
+	edac_mc_free(mci);
 }
 
 
Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.c	2006-02-27 17:07:38.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c	2006-02-27 17:08:15.000000000 -0800
@@ -1324,11 +1324,7 @@ void edac_mc_free(struct mem_ctl_info *m
 	kfree(mci);
 }
 
-
-
-EXPORT_SYMBOL(edac_mc_find_mci_by_pdev);
-
-struct mem_ctl_info *edac_mc_find_mci_by_pdev(struct pci_dev *pdev)
+static struct mem_ctl_info *find_mci_by_pdev(struct pci_dev *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct list_head *item;
@@ -1355,7 +1351,7 @@ static int add_mc_to_global_list (struct
 		mci->mc_idx = 0;
 		insert_before = &mc_devices;
 	} else {
-		if (edac_mc_find_mci_by_pdev(mci->pdev)) {
+		if (find_mci_by_pdev(mci->pdev)) {
 			edac_printk(KERN_WARNING, EDAC_MC,
 				    "%s (%s) %s %s already assigned %d\n",
 				    mci->pdev->dev.bus_id,
@@ -1474,27 +1470,29 @@ EXPORT_SYMBOL(edac_mc_del_mc);
 /**
  * edac_mc_del_mc: Remove sysfs entries for specified mci structure and
  *                 remove mci structure from global list
- * @mci:	Pointer to struct mem_ctl_info structure
+ * @pdev: Pointer to 'struct pci_dev' representing mci structure to remove.
  *
- * Returns:
- *	0	Success
- *	1 	Failure
+ * Return pointer to removed mci structure, or NULL if device not found.
  */
-int edac_mc_del_mc(struct mem_ctl_info *mci)
+struct mem_ctl_info * edac_mc_del_mc(struct pci_dev *pdev)
 {
-	int rc = 1;
+	struct mem_ctl_info *mci;
 
-	debugf0("MC%d: %s()\n", mci->mc_idx, __func__);
-	edac_remove_sysfs_mci_device(mci);
+	debugf0("MC: %s()\n", __func__);
 	down(&mem_ctls_mutex);
+
+	if ((mci = find_mci_by_pdev(pdev)) == NULL) {
+		up(&mem_ctls_mutex);
+		return NULL;
+	}
+
+	edac_remove_sysfs_mci_device(mci);
 	del_mc_from_global_list(mci);
+	up(&mem_ctls_mutex);
 	edac_printk(KERN_INFO, EDAC_MC,
 		    "Removed device %d for %s %s: PCI %s\n", mci->mc_idx,
 		    mci->mod_name, mci->ctl_name, pci_name(mci->pdev));
-	rc = 0;
-	up(&mem_ctls_mutex);
-
-	return rc;
+	return mci;
 }
 
 
@@ -1973,14 +1971,12 @@ static inline void clear_pci_parity_erro
  */
 static inline void check_mc_devices (void)
 {
-	unsigned long flags;
 	struct list_head *item;
 	struct mem_ctl_info *mci;
 
 	debugf3("%s()\n", __func__);
 
-	/* during poll, have interrupts off */
-	local_irq_save(flags);
+	down(&mem_ctls_mutex);
 
 	list_for_each(item, &mc_devices) {
 		mci = list_entry(item, struct mem_ctl_info, link);
@@ -1989,7 +1985,7 @@ static inline void check_mc_devices (voi
 			mci->edac_check(mci);
 	}
 
-	local_irq_restore(flags);
+	up(&mem_ctls_mutex);
 }
 
 
Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.h	2006-02-27 17:07:38.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.h	2006-02-27 17:08:15.000000000 -0800
@@ -410,14 +410,11 @@ void edac_mc_dump_csrow(struct csrow_inf
 #endif				/* CONFIG_EDAC_DEBUG */
 
 extern int edac_mc_add_mc(struct mem_ctl_info *mci);
-extern int edac_mc_del_mc(struct mem_ctl_info *mci);
+extern struct mem_ctl_info * edac_mc_del_mc(struct pci_dev *pdev);
 
 extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
 					   unsigned long page);
 
-extern struct mem_ctl_info *edac_mc_find_mci_by_pdev(struct pci_dev
-							  *pdev);
-
 extern void edac_mc_scrub_block(unsigned long page,
 				     unsigned long offset, u32 size);
 
Index: linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82860_edac.c	2006-02-27 17:05:48.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c	2006-02-27 17:08:15.000000000 -0800
@@ -237,9 +237,10 @@ static void __devexit i82860_remove_one(
 
 	debugf0("%s()\n", __func__);
 
-	mci = edac_mc_find_mci_by_pdev(pdev);
-	if ((mci != NULL) && (edac_mc_del_mc(mci) == 0))
-		edac_mc_free(mci);
+	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+		return;
+
+	edac_mc_free(mci);
 }
 
 static const struct pci_device_id i82860_pci_tbl[] __devinitdata = {
Index: linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82875p_edac.c	2006-02-27 17:05:48.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c	2006-02-27 17:08:15.000000000 -0800
@@ -452,7 +452,7 @@ static void __devexit i82875p_remove_one
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_find_mci_by_pdev(pdev)) == NULL)
+	if ((mci = edac_mc_del_mc(pdev)) == NULL)
 		return;
 
 	pvt = (struct i82875p_pvt *) mci->pvt_info;
@@ -467,9 +467,6 @@ static void __devexit i82875p_remove_one
 		pci_dev_put(pvt->ovrfl_pdev);
 	}
 
-	if (edac_mc_del_mc(mci))
-		return;
-
 	edac_mc_free(mci);
 }
 
Index: linux-2.6.16-rc5-edac/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/r82600_edac.c	2006-02-27 17:05:48.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/r82600_edac.c	2006-02-27 17:08:15.000000000 -0800
@@ -353,9 +353,10 @@ static void __devexit r82600_remove_one(
 
 	debugf0("%s()\n", __func__);
 
-	if (((mci = edac_mc_find_mci_by_pdev(pdev)) != NULL) &&
-	    !edac_mc_del_mc(mci))
-		edac_mc_free(mci);
+	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+		return;
+
+	edac_mc_free(mci);
 }
 
 
