Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVBGToA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVBGToA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBGThX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:37:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43235 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261264AbVBGTb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:31:57 -0500
Date: Mon, 7 Feb 2005 13:31:30 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8)
Message-ID: <20050207193129.GB834@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050207192108.GA776@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20050207192108.GA776@halcrow.us>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the third in a series of eight patches to the BSD Secure
Levels LSM.  It moves the claim on the block device from the inode
struct to the file struct in order to address a potential
circumvention of the control via hard links to block devices.  Thanks
to Serge Hallyn for pointing this out.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_bd_claim.patch"

Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
===================================================================
--- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 15:36:43.925683472 -0600
+++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 16:41:55.075098384 -0600
@@ -487,46 +487,35 @@
 	return 0;
 }
 
-/* claim the blockdev to exclude mounters, release on file close */
-static int seclvl_bd_claim(struct inode *inode)
+/**
+ * Claim the blockdev to exclude mounters; release on file close.
+ */
+static int seclvl_bd_claim(struct file * filp)
 {
 	int holder;
 	struct block_device *bdev = NULL;
-	dev_t dev = inode->i_rdev;
+	dev_t dev = filp->f_dentry->d_inode->i_rdev;
 	bdev = open_by_devnum(dev, FMODE_WRITE);
 	if (bdev) {
 		if (bd_claim(bdev, &holder)) {
 			blkdev_put(bdev);
 			return -EPERM;
 		}
-		/* claimed, mark it to release on close */
-		inode->i_security = current;
+		/* Claimed; mark it to release on close */
+		filp->f_security = current;
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
+static int seclvl_file_permission(struct file * filp, int mask)
 {
-	if (current->pid != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
+	if (current->pid != 1 && S_ISBLK(filp->f_dentry->d_inode->i_mode)
+	    && (mask & MAY_WRITE)) {
 		switch (seclvl) {
 		case 2:
 			seclvl_printk(1, KERN_WARNING "%s: Write to block "
@@ -534,7 +523,7 @@
 				      __FUNCTION__, seclvl);
 			return -EPERM;
 		case 1:
-			if (seclvl_bd_claim(inode)) {
+			if (seclvl_bd_claim(filp)) {
 				seclvl_printk(1, KERN_WARNING "%s: Write to "
 					      "mounted block device denied in "
 					      "secure level [%d]\n",
@@ -549,7 +538,7 @@
 /**
  * The SUID and SGID bits cannot be set in seclvl >= 1
  */
-static int seclvl_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+static int seclvl_inode_setattr(struct dentry * dentry, struct iattr * iattr)
 {
 	if (seclvl > 0) {
 		if (dentry && dentry->d_inode
@@ -599,15 +588,23 @@
         return 0;
 }
 
-/* release busied block devices */
-static void seclvl_file_free_security(struct file *filp)
+/**
+ * Release busied block devices.
+ */
+static void seclvl_file_free_security(struct file * filp)
 {
-	struct dentry *dentry = filp->f_dentry;
-	struct inode *inode = NULL;
-
-	if (dentry) {
-		inode = dentry->d_inode;
-		seclvl_bd_release(inode);
+	struct dentry * dentry = filp->f_dentry;
+	if (dentry && (filp->f_mode & FMODE_WRITE)) {
+		struct inode * inode = dentry->d_inode;
+		if (inode && S_ISBLK(inode->i_mode)
+		    && filp->f_security == current) {
+			struct block_device *bdev = inode->i_bdev;
+			if (bdev) {
+				bd_release(bdev);
+				blkdev_put(bdev);
+				filp->f_security = NULL;
+			}
+		}
 	}
 }
 
@@ -630,7 +627,7 @@
 static struct security_operations seclvl_ops = {
 	.ptrace = seclvl_ptrace,
 	.capable = seclvl_capable,
-	.inode_permission = seclvl_inode_permission,
+	.file_permission = seclvl_file_permission,
 	.inode_setattr = seclvl_inode_setattr,
 	.inode_mknod = seclvl_inode_mknod,
 	.inode_create = seclvl_inode_create,

--24zk1gE8NUlDmwG9--
