Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbUKDWRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbUKDWRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKDWOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:14:06 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:35048 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262461AbUKDV7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:59:38 -0500
Subject: Re: [RFC] [PATCH] [4/6] LSM Stacking: seclvl LSM stacking support
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1099609795.2096.20.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:09:55 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds stacking support to the BSD Secure Level LSM.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc1-bk12-stack/security/seclvl.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/security/seclvl.c	2004-11-02
20:28:47.000000000 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/seclvl.c	2004-11-03
23:01:08.478130544 -0600
@@ -58,6 +58,8 @@
 MODULE_PARM_DESC(verbosity, "Initial verbosity level (0 or 1; defaults
to "
 		 "0, which is Quiet)");
 
+static int seclvl_idx;
+
 /**
  * Optional password which can be passed in to bring seclvl to 0
  * (i.e., for halt/reboot).  Defaults to NULL (the passwd attribute
@@ -498,7 +500,7 @@
 			return -EPERM;
 		}
 		/* claimed, mark it to release on close */
-		inode->i_security = current;
+		inode->i_security[seclvl_idx] = current;
 	}
 	return 0;
 }
@@ -506,12 +508,12 @@
 /* release the blockdev if you claimed it */
 static void seclvl_bd_release(struct inode *inode)
 {
-	if (inode && S_ISBLK(inode->i_mode) && inode->i_security == current) {
+	if (inode && S_ISBLK(inode->i_mode) && inode->i_security[seclvl_idx]
== current) {
 		struct block_device *bdev = inode->i_bdev;
 		if (bdev) {
 			bd_release(bdev);
 			blkdev_put(bdev);
-			inode->i_security = NULL;
+			inode->i_security[seclvl_idx] = NULL;
 		}
 	}
 }
@@ -697,11 +699,12 @@
 			      "seclvl: Failure registering with the "
 			      "kernel.\n");
 		/* try registering with primary module */
-		rc = mod_reg_security(MY_NAME, &seclvl_ops);
-		if (rc) {
+		seclvl_idx = mod_reg_security(MY_NAME, &seclvl_ops);
+		if (seclvl_idx < 0) {
 			seclvl_printk(0, KERN_ERR, "seclvl: Failure "
 				      "registering with primary security "
 				      "module.\n");
+			rc = seclvl_idx;
 			goto exit;
 		}		/* if primary module registered */
 		secondary = 1;


