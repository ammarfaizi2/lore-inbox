Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752130AbWCCBw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbWCCBw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbWCCBsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:37 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:12753 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1752135AbWCCBsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:25 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 12/15] EDAC: fix usage of kobject_init(), kobject_put()
Date: Thu, 2 Mar 2006 17:48:11 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.11594.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove calls to kobject_init().  These are unnecessary because
  kobject_register() calls kobject_init().

- Remove extra calls to kobject_put().  When we call
  kobject_unregister(), this releases our reference to the kobject.
  The extra calls to kobject_put() may cause the reference count to
  drop to 0 while a kobject is still in use.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.c	2006-02-27 17:06:37.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c	2006-02-27 17:07:06.000000000 -0800
@@ -261,8 +261,6 @@ static int edac_sysfs_memctrl_setup(void
 	if (!err) {
 		/* Init the MC's kobject */
 		memset(&edac_memctrl_kobj, 0, sizeof (edac_memctrl_kobj));
-		kobject_init(&edac_memctrl_kobj);
-
 		edac_memctrl_kobj.parent = &edac_class.kset.kobj;
 		edac_memctrl_kobj.ktype = &ktype_memctrl;
 
@@ -295,9 +293,6 @@ static void edac_sysfs_memctrl_teardown(
 	/* Unregister the MC's kobject */
 	kobject_unregister(&edac_memctrl_kobj);
 
-	/* release the master edac mc kobject */
-	kobject_put(&edac_memctrl_kobj);
-
 	/* Unregister the 'edac' object */
 	sysdev_class_unregister(&edac_class);
 }
@@ -562,8 +557,6 @@ static int edac_sysfs_pci_setup(void)
 	debugf1("%s()\n", __func__);
 
 	memset(&edac_pci_kobj, 0, sizeof(edac_pci_kobj));
-
-	kobject_init(&edac_pci_kobj);
 	edac_pci_kobj.parent = &edac_class.kset.kobj;
 	edac_pci_kobj.ktype = &ktype_edac_pci;
 
@@ -586,7 +579,6 @@ static void edac_sysfs_pci_teardown(void
 	debugf0("%s()\n", __func__);
 
 	kobject_unregister(&edac_pci_kobj);
-	kobject_put(&edac_pci_kobj);
 }
 
 /* EDAC sysfs CSROW data structures and methods */
@@ -793,7 +785,6 @@ static int edac_create_csrow_object(stru
 
 	/* generate ..../edac/mc/mc<id>/csrow<index>   */
 
-	kobject_init(&csrow->kobj);
 	csrow->kobj.parent = edac_mci_kobj;
 	csrow->kobj.ktype = &ktype_csrow;
 
@@ -1061,7 +1052,6 @@ static int edac_create_sysfs_mci_device(
 	debugf0("%s() idx=%d\n", __func__, mci->mc_idx);
 
 	memset(edac_mci_kobj, 0, sizeof(*edac_mci_kobj));
-	kobject_init(edac_mci_kobj);
 
 	/* set the name of the mc<id> object */
 	err = kobject_set_name(edac_mci_kobj,"mc%d",mci->mc_idx);
@@ -1080,10 +1070,8 @@ static int edac_create_sysfs_mci_device(
 	/* create a symlink for the device */
 	err = sysfs_create_link(edac_mci_kobj, &mci->pdev->dev.kobj,
 				EDAC_DEVICE_SYMLINK);
-	if (err) {
-		kobject_unregister(edac_mci_kobj);
-		return err;
-	}
+	if (err)
+		goto fail0;
 
 	/* Make directories for each CSROW object
 	 * under the mc<id> kobject
@@ -1096,7 +1084,7 @@ static int edac_create_sysfs_mci_device(
 		if (csrow->nr_pages > 0) {
 			err = edac_create_csrow_object(edac_mci_kobj,csrow,i);
 			if (err)
-				goto fail;
+				goto fail1;
 		}
 	}
 
@@ -1107,16 +1095,14 @@ static int edac_create_sysfs_mci_device(
 
 
 	/* CSROW error: backout what has already been registered,  */
-fail:
+fail1:
 	for ( i--; i >= 0; i--) {
-		if (csrow->nr_pages > 0) {
+		if (csrow->nr_pages > 0)
 			kobject_unregister(&mci->csrows[i].kobj);
-			kobject_put(&mci->csrows[i].kobj);
-		}
 	}
 
+fail0:
 	kobject_unregister(edac_mci_kobj);
-	kobject_put(edac_mci_kobj);
 
 	return err;
 }
@@ -1132,16 +1118,13 @@ static void edac_remove_sysfs_mci_device
 
 	/* remove all csrow kobjects */
 	for (i = 0; i < mci->nr_csrows; i++) {
-		if (mci->csrows[i].nr_pages > 0)  {
+		if (mci->csrows[i].nr_pages > 0)
 			kobject_unregister(&mci->csrows[i].kobj);
-			kobject_put(&mci->csrows[i].kobj);
-		}
 	}
 
 	sysfs_remove_link(&mci->edac_mci_kobj, EDAC_DEVICE_SYMLINK);
 
 	kobject_unregister(&mci->edac_mci_kobj);
-	kobject_put(&mci->edac_mci_kobj);
 }
 
 /* END OF sysfs data and methods */
