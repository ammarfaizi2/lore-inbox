Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752133AbWCCBsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbWCCBsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbWCCBsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:35 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:19334 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1752136AbWCCBs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:29 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 13/15] EDAC: kobject/sysfs fixes
Date: Thu, 2 Mar 2006 17:48:13 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.13853.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- After we unregister a kobject, wait for our kobject release method
  to call complete().  This causes us to wait until the kobject
  reference count reaches 0.  Otherwise, a task accessing the EDAC
  sysfs interface can hold the reference count above 0 until after the
  EDAC module has been unloaded.  When the reference count finally
  drops to 0, this will result in an attempt to call our release
  method inside the EDAC module after the module has already been
  unloaded.

- Call edac_remove_sysfs_mci_device() from edac_mc_del_mc() rather
  than from edac_mc_free().  Since edac_mc_add_mc() calls
  edac_create_sysfs_mci_device(), edac_mc_del_mc() should call
  edac_remove_sysfs_mci_device().

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.c	2006-02-27 17:07:06.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c	2006-02-27 17:07:38.000000000 -0800
@@ -131,6 +131,12 @@ static struct sysdev_class edac_class = 
 static struct kobject edac_memctrl_kobj;
 static struct kobject edac_pci_kobj;
 
+/* We use these to wait for the reference counts on edac_memctrl_kobj and
+ * edac_pci_kobj to reach 0.
+ */
+static struct completion edac_memctrl_kobj_complete;
+static struct completion edac_pci_kobj_complete;
+
 /*
  * /sys/devices/system/edac/mc;
  * 	data structures and methods
@@ -233,6 +239,7 @@ static struct memctrl_dev_attribute *mem
 static void edac_memctrl_master_release(struct kobject *kobj)
 {
 	debugf1("%s()\n", __func__);
+	complete(&edac_memctrl_kobj_complete);
 }
 
 static struct kobj_type ktype_memctrl = {
@@ -290,8 +297,12 @@ static void edac_sysfs_memctrl_teardown(
 {
 	debugf0("%s()\n", __func__);
 
-	/* Unregister the MC's kobject */
+	/* Unregister the MC's kobject and wait for reference count to reach
+	 * 0.
+	 */
+	init_completion(&edac_memctrl_kobj_complete);
 	kobject_unregister(&edac_memctrl_kobj);
+	wait_for_completion(&edac_memctrl_kobj_complete);
 
 	/* Unregister the 'edac' object */
 	sysdev_class_unregister(&edac_class);
@@ -538,6 +549,7 @@ static struct edac_pci_dev_attribute *ed
 static void edac_pci_release(struct kobject *kobj)
 {
 	debugf1("%s()\n", __func__);
+	complete(&edac_pci_kobj_complete);
 }
 
 static struct kobj_type ktype_edac_pci = {
@@ -577,8 +589,9 @@ static int edac_sysfs_pci_setup(void)
 static void edac_sysfs_pci_teardown(void)
 {
 	debugf0("%s()\n", __func__);
-
+	init_completion(&edac_pci_kobj_complete);
 	kobject_unregister(&edac_pci_kobj);
+	wait_for_completion(&edac_pci_kobj_complete);
 }
 
 /* EDAC sysfs CSROW data structures and methods */
@@ -764,7 +777,11 @@ static struct csrowdev_attribute *csrow_
 /* No memory to release */
 static void edac_csrow_instance_release(struct kobject *kobj)
 {
+	struct csrow_info *cs;
+
 	debugf1("%s()\n", __func__);
+	cs = container_of(kobj, struct csrow_info, kobj);
+	complete(&cs->kobj_complete);
 }
 
 static struct kobj_type ktype_csrow = {
@@ -1019,11 +1036,10 @@ static struct mcidev_attribute *mci_attr
 static void edac_mci_instance_release(struct kobject *kobj)
 {
 	struct mem_ctl_info *mci;
-	mci = container_of(kobj,struct mem_ctl_info,edac_mci_kobj);
 
-	debugf0("%s() idx=%d calling kfree\n", __func__, mci->mc_idx);
-
-	kfree(mci);
+	mci = to_mci(kobj);
+	debugf0("%s() idx=%d\n", __func__, mci->mc_idx);
+	complete(&mci->kobj_complete);
 }
 
 static struct kobj_type ktype_mci = {
@@ -1088,21 +1104,23 @@ static int edac_create_sysfs_mci_device(
 		}
 	}
 
-	/* Mark this MCI instance as having sysfs entries */
-	mci->sysfs_active = MCI_SYSFS_ACTIVE;
-
 	return 0;
 
 
 	/* CSROW error: backout what has already been registered,  */
 fail1:
 	for ( i--; i >= 0; i--) {
-		if (csrow->nr_pages > 0)
+		if (csrow->nr_pages > 0) {
+			init_completion(&csrow->kobj_complete);
 			kobject_unregister(&mci->csrows[i].kobj);
+			wait_for_completion(&csrow->kobj_complete);
+		}
 	}
 
 fail0:
+	init_completion(&mci->kobj_complete);
 	kobject_unregister(edac_mci_kobj);
+	wait_for_completion(&mci->kobj_complete);
 
 	return err;
 }
@@ -1118,13 +1136,17 @@ static void edac_remove_sysfs_mci_device
 
 	/* remove all csrow kobjects */
 	for (i = 0; i < mci->nr_csrows; i++) {
-		if (mci->csrows[i].nr_pages > 0)
+		if (mci->csrows[i].nr_pages > 0) {
+			init_completion(&mci->csrows[i].kobj_complete);
 			kobject_unregister(&mci->csrows[i].kobj);
+			wait_for_completion(&mci->csrows[i].kobj_complete);
+		}
 	}
 
 	sysfs_remove_link(&mci->edac_mci_kobj, EDAC_DEVICE_SYMLINK);
-
+	init_completion(&mci->kobj_complete);
 	kobject_unregister(&mci->edac_mci_kobj);
+	wait_for_completion(&mci->kobj_complete);
 }
 
 /* END OF sysfs data and methods */
@@ -1296,31 +1318,10 @@ EXPORT_SYMBOL(edac_mc_free);
 /**
  * edac_mc_free:  Free a previously allocated 'mci' structure
  * @mci: pointer to a struct mem_ctl_info structure
- *
- * Free up a previously allocated mci structure
- * A MCI structure can be in 2 states after being allocated
- * by edac_mc_alloc().
- *	1) Allocated in a MC driver's probe, but not yet committed
- *	2) Allocated and committed, by a call to  edac_mc_add_mc()
- * edac_mc_add_mc() is the function that adds the sysfs entries
- * thus, this free function must determine which state the 'mci'
- * structure is in, then either free it directly or
- * perform kobject cleanup by calling edac_remove_sysfs_mci_device().
- *
- * VOID Return
  */
 void edac_mc_free(struct mem_ctl_info *mci)
 {
-	/* only if sysfs entries for this mci instance exist
-	 * do we remove them and defer the actual kfree via
-	 * the kobject 'release()' callback.
- 	 *
-	 * Otherwise, do a straight kfree now.
-	 */
-	if (mci->sysfs_active == MCI_SYSFS_ACTIVE)
-		edac_remove_sysfs_mci_device(mci);
-	else
-		kfree(mci);
+	kfree(mci);
 }
 
 
@@ -1410,7 +1411,8 @@ static void del_mc_from_global_list (str
 EXPORT_SYMBOL(edac_mc_add_mc);
 
 /**
- * edac_mc_add_mc: Insert the 'mci' structure into the mci global list
+ * edac_mc_add_mc: Insert the 'mci' structure into the mci global list and
+ *                 create sysfs entries associated with mci structure
  * @mci: pointer to the mci structure to be added to the list
  *
  * Return:
@@ -1470,7 +1472,8 @@ fail0:
 EXPORT_SYMBOL(edac_mc_del_mc);
 
 /**
- * edac_mc_del_mc:  Remove the specified mci structure from global list
+ * edac_mc_del_mc: Remove sysfs entries for specified mci structure and
+ *                 remove mci structure from global list
  * @mci:	Pointer to struct mem_ctl_info structure
  *
  * Returns:
@@ -1482,6 +1485,7 @@ int edac_mc_del_mc(struct mem_ctl_info *
 	int rc = 1;
 
 	debugf0("MC%d: %s()\n", mci->mc_idx, __func__);
+	edac_remove_sysfs_mci_device(mci);
 	down(&mem_ctls_mutex);
 	del_mc_from_global_list(mci);
 	edac_printk(KERN_INFO, EDAC_MC,
Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.h	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.h	2006-02-27 17:07:38.000000000 -0800
@@ -185,11 +185,6 @@ enum scrub_type {
 #define SCRUB_FLAG_HW_PROG_SRC	BIT(SCRUB_HW_PROG_SRC_CORR)
 #define SCRUB_FLAG_HW_TUN	BIT(SCRUB_HW_TUNABLE)
 
-enum mci_sysfs_status {
-	MCI_SYSFS_INACTIVE = 0,	/* sysfs entries NOT registered */
-	MCI_SYSFS_ACTIVE	/* sysfs entries ARE registered */
-};
-
 /* FIXME - should have notify capabilities: NMI, LOG, PROC, etc */
 
 /*
@@ -299,6 +294,7 @@ struct csrow_info {
 	struct mem_ctl_info *mci;	/* the parent */
 
 	struct kobject kobj;	/* sysfs kobject for this csrow */
+	struct completion kobj_complete;
 
 	/* FIXME the number of CHANNELs might need to become dynamic */
 	u32 nr_channels;
@@ -320,8 +316,6 @@ struct mem_ctl_info {
 	unsigned long scrub_cap;	/* chipset scrub capabilities */
 	enum scrub_type scrub_mode;	/* current scrub mode */
 
-	enum mci_sysfs_status sysfs_active;	/* status of sysfs */
-
 	/* pointer to edac checking routine */
 	void (*edac_check) (struct mem_ctl_info * mci);
 	/*
@@ -359,6 +353,7 @@ struct mem_ctl_info {
 
 	/* edac sysfs device control */
 	struct kobject edac_mci_kobj;
+	struct completion kobj_complete;
 };
 
 
