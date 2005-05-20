Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVETPEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVETPEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVETPEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:04:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:61312 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261449AbVETPDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:03:41 -0400
Date: Fri, 20 May 2005 10:03:22 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [updated patch 2/7] BSD Secure Levels: bd_claim fixes
Message-ID: <20050520150322.GA5534@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us> <20050519205525.GB16215@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519205525.GB16215@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> There's absolutely no point at all to use open_by_devnum if you
> already have an inode or file that you can get the struct
> block_device from easily.

Al Viro wrote:
> OK, these applied to the original.  Now to the patched version:
>
> a) ->file_permission() is called on every write(2).  So you get an
> open() for each write().  And only one matching close()
> (aka. blkdev_put())
>
> b) ->file_permission() is *not* called on mmap() path.  So much for
> protection, exclusion, etc.
>
> c) you get bd_claim() on each write(); subsequent ones work just
> fine, since you use the same holder.  On close() you undo one of
> those.  Leaving the rest there, with holder pointing to
> freed-and-soon-to-be-reused struct file.

This patch makes another attempt at enforcing the the ``no write to
mounted block device'' BSD Secure Levels rule, but as you can see,
it's not perfect.  Namely, if you were to open and mmap a block device
for writing, and then if someone were to mount that block device, the
application with the mmap could still write to the file.  Given the
current placement of the hooks, it is not obvious to us how this might
best be avoided (i.e., with minimum breakage for user apps).

Christoph/Al: Please look this over and let us know if you think this
patch correctly addresses all the pertinent issues.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-19 16:33:20.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-20 09:09:56.000000000 -0500
@@ -27,6 +27,7 @@
 #include <linux/mount.h>
 #include <linux/capability.h>
 #include <linux/time.h>
+#include <linux/mman.h>
 #include <linux/proc_fs.h>
 #include <linux/kobject.h>
 #include <linux/crypto.h>
@@ -489,35 +490,48 @@
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
-	struct block_device *bdev = NULL;
-	dev_t dev = inode->i_rdev;
-	bdev = open_by_devnum(dev, FMODE_WRITE);
-	if (bdev) {
-		if (bd_claim(bdev, &holder)) {
-			blkdev_put(bdev);
+	if (filp->f_dentry->d_inode->i_bdev) {
+		if (bd_claim(filp->f_dentry->d_inode->i_bdev, filp)) {
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
+/**
+ * Security for writes to block devices is regulated by this seclvl
+ * function.  Deny all writes to block devices in seclvl 2.  In
+ * seclvl 1, we only deny writes to *mounted* block devices.
+ */
+static int seclvl_file_permission(struct file *filp, int mask)
 {
-	if (inode && S_ISBLK(inode->i_mode) && inode->i_security == current) {
-		struct block_device *bdev = inode->i_bdev;
-		if (bdev) {
-			bd_release(bdev);
-			blkdev_put(bdev);
-			inode->i_security = NULL;
+	if (filp->f_security != NULL || filp->f_dentry == NULL)
+		return 0;
+	if (current->pid != 1 && S_ISBLK(filp->f_dentry->d_inode->i_mode)
+	    && (mask & MAY_WRITE)) {
+		switch (seclvl) {
+		case 2:
+			seclvl_printk(1, KERN_WARNING, "Write to block device "
+				      "denied in secure level [%d]\n", seclvl);
+			return -EPERM;
+		case 1:
+			if (seclvl_bd_claim(filp)) {
+				seclvl_printk(1, KERN_WARNING, "Write to "
+					      "mounted block device denied in "
+					      "secure level [%d]\n",
+					      seclvl);
+				return -EPERM;
+			}
 		}
 	}
+	return 0;
 }
 
 /**
@@ -525,22 +539,37 @@
  * function.  Deny all writes to block devices in seclvl 2.  In
  * seclvl 1, we only deny writes to *mounted* block devices.
  */
-static int
-seclvl_inode_permission(struct inode *inode, int mask, struct nameidata *nd)
+static int seclvl_file_mmap(struct file *filp, unsigned long reqprot,
+			    unsigned long prot, unsigned long flags)
 {
-	if (current->pid != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
+	struct block_device *bdev = NULL;
+	/* This may be called for anonymous memory regions */
+	if (filp == NULL || filp->f_security != NULL 
+	    || filp->f_dentry == NULL) {
+		return 0;
+	}
+	if (current->pid != 1 && S_ISBLK(filp->f_dentry->d_inode->i_mode)
+	    && (prot & PROT_WRITE)) {
 		switch (seclvl) {
 		case 2:
 			seclvl_printk(1, KERN_WARNING, "Write to block device "
 				      "denied in secure level [%d]\n", seclvl);
 			return -EPERM;
 		case 1:
-			if (seclvl_bd_claim(inode)) {
-				seclvl_printk(1, KERN_WARNING,
-					      "Write to mounted block device "
-					      "denied in secure level [%d]\n",
-					      seclvl);
-				return -EPERM;
+			bdev = filp->f_dentry->d_inode->i_bdev;
+			if (bdev) {
+				if (bd_claim(bdev, filp)) {
+					/* Mounted block device */
+					seclvl_printk(1, KERN_WARNING,
+						      "Write to mounted block "
+						      "device denied in secure"
+						      " level [%d]\n", seclvl);
+					return -EPERM;
+				} else {
+					/* No reason to hold the claim */
+					bd_release(bdev);
+					filp->f_security = filp;
+				}
 			}
 		}
 	}
@@ -566,15 +595,16 @@
 	return 0;
 }
 
-/* release busied block devices */
+/**
+ * Release busied block devices.
+ */
 static void seclvl_file_free_security(struct file *filp)
 {
-	struct dentry *dentry = filp->f_dentry;
-	struct inode *inode = NULL;
-
-	if (dentry) {
-		inode = dentry->d_inode;
-		seclvl_bd_release(inode);
+	if (filp->f_security != NULL) {
+		struct block_device *bdev = filp->f_dentry->d_inode->i_bdev;
+		if (bdev)
+			bd_release(bdev);
+		filp->f_security = NULL;
 	}
 }
 
@@ -597,7 +627,8 @@
 static struct security_operations seclvl_ops = {
 	.ptrace = seclvl_ptrace,
 	.capable = seclvl_capable,
-	.inode_permission = seclvl_inode_permission,
+	.file_permission = seclvl_file_permission,
+	.file_mmap = seclvl_file_mmap,
 	.inode_setattr = seclvl_inode_setattr,
 	.file_free_security = seclvl_file_free_security,
 	.settime = seclvl_settime,

