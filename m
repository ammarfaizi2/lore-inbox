Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVKXQKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVKXQKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVKXQKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:10:21 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:53769 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751370AbVKXQKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:10:20 -0500
To: akpm@osdl.org
CC: linuxram@us.ibm.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] shared mounts: cleanup
Message-Id: <E1EfJfC-00016e-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 24 Nov 2005 17:09:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small cleanups in shared mounts code.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/pnode.c
===================================================================
--- linux.orig/fs/pnode.c	2005-11-23 17:12:01.000000000 +0100
+++ linux/fs/pnode.c	2005-11-23 17:13:03.000000000 +0100
@@ -103,7 +103,7 @@ static struct vfsmount *propagation_next
 		struct vfsmount *next;
 		struct vfsmount *master = m->mnt_master;
 
-		if ( master == origin->mnt_master ) {
+		if (master == origin->mnt_master) {
 			next = next_peer(m);
 			return ((next == origin) ? NULL : next);
 		} else if (m->mnt_slave.next != &master->mnt_slave_list)
Index: linux/include/linux/mount.h
===================================================================
--- linux.orig/include/linux/mount.h	2005-11-23 17:12:01.000000000 +0100
+++ linux/include/linux/mount.h	2005-11-23 17:13:03.000000000 +0100
@@ -22,7 +22,8 @@
 #define MNT_NOEXEC	0x04
 #define MNT_SHARED	0x10	/* if the vfsmount is a shared mount */
 #define MNT_UNBINDABLE	0x20	/* if the vfsmount is a unbindable mount */
-#define MNT_PNODE_MASK	0x30	/* propogation flag mask */
+
+#define MNT_PNODE_MASK	(MNT_SHARED | MNT_UNBINDABLE)
 
 struct vfsmount {
 	struct list_head mnt_hash;
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-11-23 17:12:01.000000000 +0100
+++ linux/include/linux/fs.h	2005-11-23 17:13:03.000000000 +0100
@@ -103,11 +103,11 @@ extern int dir_notify_enable;
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
 #define MS_PRIVATE	(1<<18)	/* change to private */
 #define MS_SLAVE	(1<<19)	/* change to slave */
 #define MS_SHARED	(1<<20)	/* change to shared */
-#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-11-23 17:12:01.000000000 +0100
+++ linux/fs/namespace.c	2005-11-23 17:13:03.000000000 +0100
@@ -451,7 +451,7 @@ EXPORT_SYMBOL(may_umount);
 void release_mounts(struct list_head *head)
 {
 	struct vfsmount *mnt;
-	while(!list_empty(head)) {
+	while (!list_empty(head)) {
 		mnt = list_entry(head->next, struct vfsmount, mnt_hash);
 		list_del_init(&mnt->mnt_hash);
 		if (mnt->mnt_parent != mnt) {
