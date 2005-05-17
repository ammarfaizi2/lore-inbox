Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVEQP0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVEQP0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEQP0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:26:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:48114 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261575AbVEQPZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:25:53 -0400
Date: Tue, 17 May 2005 10:25:46 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [patch 2/7] BSD Secure Levels: move bd claim from inode to filp
Message-ID: <20050517152545.GA2944@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517152303.GA2814@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second in a series of seven patches to the BSD Secure
Levels LSM.  It moves the claim on the block device from the inode
struct to the file struct in order to address a potential
circumvention of the control via hard links to block devices.  Thanks
to Serge Hallyn for pointing this out.  Chris Wright observed that
using filp as a holder addresses the fact that multiple processes can
share an fd.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-16 16:23:15.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-16 16:27:27.000000000 -0500
@@ -487,46 +487,34 @@
 	return 0;
 }
 
-/* claim the blockdev to exclude mounters, release on file close */
-static int seclvl_bd_claim(struct inode *inode)
+/**
+ * Claim the blockdev to exclude mounters; release on file close.
+ */
+static int seclvl_bd_claim(struct file *filp)
 {
-	int holder;
 	struct block_device *bdev = NULL;
-	dev_t dev = inode->i_rdev;
+	dev_t dev = filp->f_dentry->d_inode->i_rdev;
 	bdev = open_by_devnum(dev, FMODE_WRITE);
 	if (bdev) {
-		if (bd_claim(bdev, &holder)) {
+		if (bd_claim(bdev, filp)) {
 			blkdev_put(bdev);
 			return -EPERM;
 		}
-		/* claimed, mark it to release on close */
-		inode->i_security = current;
+		/* Claimed; mark it to release on close */
+		filp->f_security = filp;
 	}
 	return 0;
 }
 
-/* release the blockdev if you claimed it */
-static void seclvl_bd_release(struct inode *inode)
-{
-	if (inode && S_ISBLK(inode->i_mode) && inode->i_security == current) {
-		struct block_device *bdev = inode->i_bdev;
-		if (bdev) {
-			bd_release(bdev);
-			blkdev_put(bdev);
-			inode->i_security = NULL;
-		}
-	}
-}
-
 /**
  * Security for writes to block devices is regulated by this seclvl
  * function.  Deny all writes to block devices in seclvl 2.  In
  * seclvl 1, we only deny writes to *mounted* block devices.
  */
-static int
-seclvl_inode_permission(struct inode *inode, int mask, struct nameidata *nd)
+static int seclvl_file_permission(struct file *filp, int mask)
 {
-	if (current->pid != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
+	if (current->pid != 1 && S_ISBLK(filp->f_dentry->d_inode->i_mode)
+	    && (mask & MAY_WRITE)) {
 		switch (seclvl) {
 		case 2:
 			seclvl_printk(1, KERN_WARNING "%s: Write to block "
@@ -534,7 +522,7 @@
 				      __FUNCTION__, seclvl);
 			return -EPERM;
 		case 1:
-			if (seclvl_bd_claim(inode)) {
+			if (seclvl_bd_claim(filp)) {
 				seclvl_printk(1, KERN_WARNING "%s: Write to "
 					      "mounted block device denied in "
 					      "secure level [%d]\n",
@@ -565,15 +553,23 @@
 	return 0;
 }
 
-/* release busied block devices */
+/**
+ * Release busied block devices.
+ */
 static void seclvl_file_free_security(struct file *filp)
 {
 	struct dentry *dentry = filp->f_dentry;
-	struct inode *inode = NULL;
-
-	if (dentry) {
-		inode = dentry->d_inode;
-		seclvl_bd_release(inode);
+	if (dentry && (filp->f_mode & FMODE_WRITE)) {
+		struct inode *inode = dentry->d_inode;
+		if (inode && S_ISBLK(inode->i_mode)
+		    && filp->f_security == filp) {
+			struct block_device *bdev = inode->i_bdev;
+			if (bdev) {
+				bd_release(bdev);
+				blkdev_put(bdev);
+				filp->f_security = NULL;
+			}
+		}
 	}
 }
 
@@ -596,7 +592,7 @@
 static struct security_operations seclvl_ops = {
 	.ptrace = seclvl_ptrace,
 	.capable = seclvl_capable,
-	.inode_permission = seclvl_inode_permission,
+	.file_permission = seclvl_file_permission,
 	.inode_setattr = seclvl_inode_setattr,
 	.file_free_security = seclvl_file_free_security,
 	.settime = seclvl_settime,
