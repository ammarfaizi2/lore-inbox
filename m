Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVG0UPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVG0UPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVG0UPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:15:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:35736 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262434AbVG0S1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:27:47 -0400
Date: Wed, 27 Jul 2005 13:28:05 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Emily Ratliff <emilyr@us.ibm.com>
Subject: [patch 13/15] lsm stacking v0.3: seclvl: update for stacking
Message-ID: <20050727182805.GN22483@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050727181921.GB22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181921.GB22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add stacking support to the seclvl module.

Note that seclvl is currently unable to prevent it's own unloading, as
it actually claims to do.

Changelog:
	[Jul 26] Updated seclvl to use security_unlink_value to free
	its data when seclvl is unloaded.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 seclvl.c |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 123 insertions(+), 10 deletions(-)

Index: linux-2.6.13-rc3/security/seclvl.c
===================================================================
--- linux-2.6.13-rc3.orig/security/seclvl.c	2005-07-25 14:40:42.000000000 -0500
+++ linux-2.6.13-rc3/security/seclvl.c	2005-07-25 14:56:37.000000000 -0500
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
@@ -485,12 +487,46 @@ static int seclvl_settime(struct timespe
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
+	struct list_head chain;
+};
+
+static LIST_HEAD(seclvl_ichain);
+static DEFINE_SPINLOCK(seclvl_ichain_lock);
+
+static void seclvl_inode_free(struct inode *inode)
+{
+	struct seclvl_i_sec *isec;
+
+	isec = security_del_value_type(&inode->i_security, SECLVL_LSM_ID,
+				struct seclvl_i_sec);
+	if (isec) {
+		spin_lock(&seclvl_ichain_lock);
+		list_del(&isec->chain);
+		spin_unlock(&seclvl_ichain_lock);
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
@@ -498,7 +534,7 @@ static int seclvl_bd_claim(struct inode 
 			return -EPERM;
 		}
 		/* claimed, mark it to release on close */
-		inode->i_security = current;
+		isec->task = current;
 	}
 	return 0;
 }
@@ -506,17 +542,60 @@ static int seclvl_bd_claim(struct inode 
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
 
 /**
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
+	spin_lock(&seclvl_ichain_lock);
+	isec = security_get_value_type(&inode->i_security,
+			SECLVL_LSM_ID, struct seclvl_i_sec);
+	if (isec)
+		goto out;
+	isec = kmalloc(sizeof(struct seclvl_i_sec), GFP_KERNEL);
+	if (!isec)
+		goto out;
+	spin_lock_init(&isec->spinlock);
+	INIT_LIST_HEAD(&isec->chain);
+	list_add(&isec->chain, &seclvl_ichain);
+	security_add_value_type(&inode->i_security, SECLVL_LSM_ID, isec);
+
+out:
+	spin_unlock(&seclvl_ichain_lock);
+	return isec;
+}
+
+/**
  * Security for writes to block devices is regulated by this seclvl
  * function.  Deny all writes to block devices in seclvl 2.  In
  * seclvl 1, we only deny writes to *mounted* block devices.
@@ -524,6 +603,8 @@ static void seclvl_bd_release(struct ino
 static int
 seclvl_inode_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
+	struct seclvl_i_sec *isec;
+
 	if (current->pid != 1 && S_ISBLK(inode->i_mode) && (mask & MAY_WRITE)) {
 		switch (seclvl) {
 		case 2:
@@ -531,13 +612,19 @@ seclvl_inode_permission(struct inode *in
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
@@ -596,6 +683,7 @@ static struct security_operations seclvl
 	.capable = seclvl_capable,
 	.inode_permission = seclvl_inode_permission,
 	.inode_setattr = seclvl_inode_setattr,
+	.inode_free_security = seclvl_inode_free,
 	.file_free_security = seclvl_file_free_security,
 	.settime = seclvl_settime,
 	.sb_umount = seclvl_umount,
@@ -720,6 +808,29 @@ static int __init seclvl_init(void)
 	return rc;
 }
 
+/*
+ * free_ichain: Called when seclvl is unloaded to free all the memory
+ * it has attached to inodes.
+ * First we go through the list and remove the objects from the
+ * object chains (ie inode->i_security).  Then we wait an rcu cycle.
+ * Then we can safely delete the object, as any any stacker m->hook()
+ * loop should have moved on to isec->lsm_list.next.
+ */
+static void free_ichain(void)
+{
+	struct seclvl_i_sec *isec, *n;
+
+	list_for_each_entry_safe(isec, n, &seclvl_ichain, chain) {
+		security_unlink_value(&isec->lsm_list.list);
+	}
+
+	synchronize_rcu();
+	list_for_each_entry_safe(isec, n, &seclvl_ichain, chain) {
+		list_del(&isec->chain);
+		kfree(isec);
+	}
+}
+
 /**
  * Remove the seclvl module.
  */
@@ -738,6 +849,8 @@ static void __exit seclvl_exit(void)
 			      "seclvl: Failure unregistering with the "
 			      "kernel\n");
 	}
+
+	free_ichain();
 }
 
 module_init(seclvl_init);
