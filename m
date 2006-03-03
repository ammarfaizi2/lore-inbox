Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752134AbWCCBsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbWCCBsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWCCBsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:33 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:32493 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1752134AbWCCBsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:23 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 11/15] EDAC: edac_mc_add_mc() fix [2/2]
Date: Thu, 2 Mar 2006 17:48:09 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.09413.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 2 of a 2-part patch set.

Fix edac_mc_add_mc() so it cleans up properly if call to
edac_create_sysfs_mci_device() fails.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.c	2006-02-27 17:06:17.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c	2006-02-27 17:06:37.000000000 -0800
@@ -1438,8 +1438,6 @@ EXPORT_SYMBOL(edac_mc_add_mc);
 /* FIXME - should a warning be printed if no error detection? correction? */
 int edac_mc_add_mc(struct mem_ctl_info *mci)
 {
-	int rc = 1;
-
 	debugf0("%s()\n", __func__);
 #ifdef CONFIG_EDAC_DEBUG
 	if (edac_debug_level >= 3)
@@ -1459,7 +1457,7 @@ int edac_mc_add_mc(struct mem_ctl_info *
 	down(&mem_ctls_mutex);
 
 	if (add_mc_to_global_list(mci))
-		goto finish;
+		goto fail0;
 
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
@@ -1467,20 +1465,22 @@ int edac_mc_add_mc(struct mem_ctl_info *
         if (edac_create_sysfs_mci_device(mci)) {
                 edac_mc_printk(mci, KERN_WARNING,
 			       "failed to create sysfs device\n");
-		/* FIXME - should there be an error code and unwind? */
-                goto finish;
+                goto fail1;
         }
 
 	/* Report action taken */
 	edac_mc_printk(mci, KERN_INFO, "Giving out device to %s %s: PCI %s\n",
 		       mci->mod_name, mci->ctl_name, pci_name(mci->pdev));
 
+	up(&mem_ctls_mutex);
+	return 0;
 
-	rc = 0;
+fail1:
+	del_mc_from_global_list(mci);
 
-finish:
+fail0:
 	up(&mem_ctls_mutex);
-	return rc;
+	return 1;
 }
 
 
