Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbVF3UTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbVF3UTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbVF3UTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:19:02 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51086 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263040AbVF3Ttx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:49:53 -0400
Date: Thu, 30 Jun 2005 14:55:45 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: [patch 12/12] lsm stacking v0.2: update seclvl for stacking
Message-ID: <20050630195545.GL23538@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630194458.GA23439@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add stacking support to the seclvl module.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 seclvl.c |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 91 insertions(+), 10 deletions(-)

Index: linux-2.6.13-rc1/security/seclvl.c
===================================================================
--- linux-2.6.13-rc1.orig/security/seclvl.c	2005-06-30 18:22:12.000000000 -0500
+++ linux-2.6.13-rc1/security/seclvl.c	2005-06-30 18:32:38.000000000 -0500
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/security.h>
+#include <linux/security-stack.h>
 #include <linux/netlink.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
@@ -35,6 +36,7 @@
 #include <linux/sysfs.h>
 
 #define SHA1_DIGEST_SIZE 20
+#define SECLVL_LSM_ID 0xF45
 
 /**
  * Module parameter that defines the initial secure level.
@@ -485,12 +487,39 @@ static int seclvl_settime(struct timespe
 	return 0;
 }
 
+/*
+ * A structure which is stored with the inode when a process
+ * has a unmounted block device open for writing.
+ */
+struct seclvl_i_sec {
+	struct security_list lsm_list;
+	struct task_struct *task;
+	spinlock_t spinlock;
+};
+
+static void seclvl_inode_free(struct inode *inode)
+{
+	struct seclvl_i_sec *isec;
+
+	isec = security_del_value_type(&inode->i_security, SECLVL_LSM_ID,
+				struct seclvl_i_sec);
+	if (isec) {
+		if (isec->task == current)
+			isec->task = NULL;
+		kfree(isec);
+	}
+}
+
 /* claim the blockdev to exclude mounters, release on file close */
-static int seclvl_bd_claim(struct inode *inode)
+static int seclvl_bd_claim(struct inode *inode, struct seclvl_i_sec *isec)
 {
 	int holder;
 	struct block_device *bdev = NULL;
 	dev_t dev = inode->i_rdev;
+
+	if (isec->task && isec->task != current)
+		return -EPERM;
+
 	bdev = open_by_devnum(dev, FMODE_WRITE);
 	if (bdev) {
 		if (bd_claim(bdev, &holder)) {
@@ -498,7 +527,7 @@ static int seclvl_bd_claim(struct inode 
 			return -EPERM;
 		}
 		/* claimed, mark it to release on close */
-		inode->i_security = current;
+		isec->task = current;
 	}
 	return 0;
 }
@@ -506,16 +535,59 @@ static int seclvl_bd_claim(struct inode 
 /* release the blockdev if you claimed it */
 static void seclvl_bd_release(struct inode *inode)
 {
-	if (inode && S_ISBLK(inode->i_mode) && inode->i_security == current) {
-		struct block_device *bdev = inode->i_bdev;
-		if (bdev) {
-			bd_release(bdev);
-			blkdev_put(bdev);
-			inode->i_security = NULL;
-		}
+	struct seclvl_i_sec *isec;
+
+	if (inode && S_ISBLK(inode->i_mode)) {
+		isec = security_get_value_type(&inode->i_security,
+				SECLVL_LSM_ID, struct seclvl_i_sec);
+		if (!isec)
+			return;
+		spin_lock(&isec->spinlock);
+		if (isec->task == current) {
+			struct block_device *bdev = inode->i_bdev;
+			if (bdev) {
+				bd_release(bdev);
+				blkdev_put(bdev);
+				isec->task = NULL;
+			}
+ 		}
+		spin_unlock(&isec->spinlock);
 	}
 }
 
+static DEFINE_SPINLOCK(seclvl_new_isec_lock);
+
+/**
+ * Either returns the existing inode isec, or creates a new
+ * isec, places it on the inode->i_security list, and returns
+ * it.
+ * On error, return NULL.
+ */
+static struct seclvl_i_sec *
+seclvl_inode_get_or_alloc(struct inode *inode)
+{
+	struct seclvl_i_sec *isec;
+
+	isec = security_get_value_type(&inode->i_security,
+			SECLVL_LSM_ID, struct seclvl_i_sec);
+	if (isec)
+		return isec;
+	spin_lock(&seclvl_new_isec_lock);
+	isec = security_get_value_type(&inode->i_security,
+			SECLVL_LSM_ID, struct seclvl_i_sec);
+	if (isec)
+		goto out;
+	isec = kmalloc(sizeof(struct seclvl_i_sec), GFP_KERNEL);
+	if (!isec)
+		goto out;
+	spin_lock_init(&isec->spinlock);
+	security_add_value_type(&inode->i_security, SECLVL_LSM_ID, isec);
+
+out:
+	spin_unlock(&seclvl_new_isec_lock);
+	return isec;
+}
+
 /**
  * Security for writes to block devices is regulated by this seclvl
  * function.  Deny all writes to block devices in seclvl 2.  In
@@ -524,6 +596,8 @@ static void seclvl_bd_release(struct ino
 static int
 seclvl_inode_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
+	struct seclvl_i_sec *isec;
+
 	if (current->pid != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
 		switch (seclvl) {
 		case 2:
@@ -531,13 +605,19 @@ seclvl_inode_permission(struct inode *in
 				      "denied in secure level [%d]\n", seclvl);
 			return -EPERM;
 		case 1:
-			if (seclvl_bd_claim(inode)) {
+			isec = seclvl_inode_get_or_alloc(inode);
+			if (!isec)
+				return -ENOMEM;
+			spin_lock(&isec->spinlock);
+			if (seclvl_bd_claim(inode, isec)) {
 				seclvl_printk(1, KERN_WARNING,
 					      "Write to mounted block device "
 					      "denied in secure level [%d]\n",
 					      seclvl);
+				spin_unlock(&isec->spinlock);
 				return -EPERM;
 			}
+			spin_unlock(&isec->spinlock);
 		}
 	}
 	return 0;
@@ -595,6 +675,7 @@ static struct security_operations seclvl
 	.capable = seclvl_capable,
 	.inode_permission = seclvl_inode_permission,
 	.inode_setattr = seclvl_inode_setattr,
+	.inode_free_security = seclvl_inode_free,
 	.file_free_security = seclvl_file_free_security,
 	.settime = seclvl_settime,
 	.sb_umount = seclvl_umount,
