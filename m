Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275378AbTHNTaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275385AbTHNT37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:29:59 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:8616 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S275378AbTHNT3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:29:50 -0400
Subject: [PATCH] SELinux inode security init
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1060889381.13964.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Aug 2003 15:29:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.0-test3-bk reworks the SELinux module code that
handles inodes initialized before the policy is initially loaded to also
cover the case where a pseudo filesystem such as selinuxfs or nfsd 
directly populate themselves.  The list of inode security structures
is split into per-superblock lists associated with each superblock
security structure, and the initialization is performed by superblock_doinit. 

 security/selinux/hooks.c          |   62 +++++++++++++++++++-------------------
 security/selinux/include/objsec.h |    2 +
 2 files changed, 34 insertions(+), 30 deletions(-)

Index: linux-2.6/security/selinux/hooks.c
diff -u linux-2.6/security/selinux/hooks.c:1.67 linux-2.6/security/selinux/hooks.c:1.68
--- linux-2.6/security/selinux/hooks.c:1.67	Tue Aug 12 14:29:53 2003
+++ linux-2.6/security/selinux/hooks.c	Wed Aug 13 14:12:19 2003
@@ -84,9 +84,6 @@
 
 /* Lists of inode and superblock security structures initialized
    before the policy was loaded. */
-static LIST_HEAD(inode_security_head);
-static spinlock_t inode_security_lock = SPIN_LOCK_UNLOCKED;
-
 static LIST_HEAD(superblock_security_head);
 static spinlock_t sb_security_lock = SPIN_LOCK_UNLOCKED;
 
@@ -148,14 +145,15 @@
 static void inode_free_security(struct inode *inode)
 {
 	struct inode_security_struct *isec = inode->i_security;
+	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
 	if (!isec || isec->magic != SELINUX_MAGIC)
 		return;
 
-	spin_lock(&inode_security_lock);
+	spin_lock(&sbsec->isec_lock);
 	if (!list_empty(&isec->list))
 		list_del_init(&isec->list);
-	spin_unlock(&inode_security_lock);
+	spin_unlock(&sbsec->isec_lock);
 
 	inode->i_security = NULL;
 	kfree(isec);
@@ -207,6 +205,8 @@
 	memset(sbsec, 0, sizeof(struct superblock_security_struct));
 	init_MUTEX(&sbsec->sem);
 	INIT_LIST_HEAD(&sbsec->list);
+	INIT_LIST_HEAD(&sbsec->isec_head);
+	spin_lock_init(&sbsec->isec_lock);
 	sbsec->magic = SELINUX_MAGIC;
 	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
@@ -325,6 +325,29 @@
 
 	/* Initialize the root inode. */
 	rc = inode_doinit_with_dentry(sb->s_root->d_inode, sb->s_root);
+
+	/* Initialize any other inodes associated with the superblock, e.g.
+	   inodes created prior to initial policy load or inodes created
+	   during get_sb by a pseudo filesystem that directly 
+	   populates itself. */
+	spin_lock(&sbsec->isec_lock);
+next_inode:
+	if (!list_empty(&sbsec->isec_head)) {
+		struct inode_security_struct *isec =
+				list_entry(sbsec->isec_head.next,
+				           struct inode_security_struct, list);
+		struct inode *inode = isec->inode;
+		spin_unlock(&sbsec->isec_lock);
+		inode = igrab(inode);
+		if (inode) {
+			inode_doinit(inode);
+			iput(inode);
+		}
+		spin_lock(&sbsec->isec_lock);
+		list_del_init(&isec->list);
+		goto next_inode;
+	}
+	spin_unlock(&sbsec->isec_lock);
 out:
 	up(&sbsec->sem);
 	return rc;
@@ -447,14 +470,14 @@
 		goto out;
 
 	sbsec = inode->i_sb->s_security;
-	if (!sbsec || !sbsec->initialized) {
+	if (!sbsec->initialized) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
-		spin_lock(&inode_security_lock);
+		spin_lock(&sbsec->isec_lock);
 		if (list_empty(&isec->list))
-			list_add(&isec->list, &inode_security_head);
-		spin_unlock(&inode_security_lock);
+			list_add(&isec->list, &sbsec->isec_head);
+		spin_unlock(&sbsec->isec_lock);
 		goto out;
 	}
 
@@ -3382,27 +3405,6 @@
 		goto next_sb;
 	}
 	spin_unlock(&sb_security_lock);
-
-	/* Set up any inodes initialized prior to the policy load. */
-	printk(KERN_INFO "SELinux:  Setting up existing inodes.\n");
-	spin_lock(&inode_security_lock);
-next_inode:
-	if (!list_empty(&inode_security_head)) {
-		struct inode_security_struct *isec =
-				list_entry(inode_security_head.next,
-				           struct inode_security_struct, list);
-		struct inode *inode = isec->inode;
-		spin_unlock(&inode_security_lock);
-		inode = igrab(inode);
-		if (inode) {
-			inode_doinit(inode);
-			iput(inode);
-		}
-		spin_lock(&inode_security_lock);
-		list_del_init(&isec->list);
-		goto next_inode;
-	}
-	spin_unlock(&inode_security_lock);
 }
 
 /* SELinux requires early initialization in order to label
Index: linux-2.6/security/selinux/include/objsec.h
diff -u linux-2.6/security/selinux/include/objsec.h:1.1.1.1 linux-2.6/security/selinux/include/objsec.h:1.10
--- linux-2.6/security/selinux/include/objsec.h:1.1.1.1	Tue Aug 12 09:05:09 2003
+++ linux-2.6/security/selinux/include/objsec.h	Wed Aug 13 14:12:23 2003
@@ -66,6 +66,8 @@
 	unsigned char initialized;      /* initialization flag */
 	unsigned char proc;             /* proc fs */
 	struct semaphore sem;
+	struct list_head isec_head;
+	spinlock_t isec_lock;
 };
 
 struct msg_security_struct {


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

