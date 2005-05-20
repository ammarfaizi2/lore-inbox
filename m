Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVETLBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVETLBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 07:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVETLBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 07:01:25 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:58888 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261412AbVETLBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 07:01:12 -0400
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
CC: linuxram@us.ibm.com, dhowells@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH retry 2] namespace.c: fix race in mark_mounts_for_expiry()
Message-Id: <E1DZ5EX-0003cN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 20 May 2005 13:00:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll get there, I know!

This patch fixes a race found by Ram in mark_mounts_for_expiry() in
fs/namespace.c.

The bug can only be triggered with simultaneous exiting of a process
having a private namespace, and expiry of a mount from within that
namespace.  It's practically impossible to trigger, and I haven't even
tried.  But still, a bug is a bug.

The race happens when put_namespace() is called by another task, while
mark_mounts_for_expiry() is between atomic_read() and get_namespace().
In that case get_namespace() will be called on an already dead
namespace with unforeseeable results.

The solution was suggested by Al Viro, with his own words:

      Instead of screwing with atomic_read() in there, why don't we
      simply do the following:
      	a) atomic_dec_and_lock() in put_namespace()
      	b) __put_namespace() called without dropping lock
      	c) the first thing done by __put_namespace would be
      struct vfsmount *root = namespace->root;
      namespace->root = NULL;
      spin_unlock(...);
      ....
      umount_tree(root);
      ...
      	d) check in mark_... would be simply namespace && namespace->root.
      
      And we are all set; no screwing around with atomic_read(), no magic
      at all.  Dying namespace gets NULL ->root.
      All changes of ->root happen under spinlock.
      If under a spinlock we see non-NULL ->mnt_namespace, it won't be
      freed until we drop the lock (we will set ->mnt_namespace to NULL
      under that lock before we get to freeing namespace).
      If under a spinlock we see non-NULL ->mnt_namespace and
      ->mnt_namespace->root, we can grab a reference to namespace and be
      sure that it won't go away.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/namespace.h
===================================================================
--- linux.orig/include/linux/namespace.h	2005-05-20 12:42:05.000000000 +0200
+++ linux/include/linux/namespace.h	2005-05-20 12:48:56.000000000 +0200
@@ -14,10 +14,12 @@ struct namespace {
 
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
+extern spinlock_t vfsmount_lock;
 
 static inline void put_namespace(struct namespace *namespace)
 {
-	if (atomic_dec_and_test(&namespace->count))
+	if (atomic_dec_and_lock(&namespace->count, &vfsmount_lock))
+		/* releases vfsmount_lock */
 		__put_namespace(namespace);
 }
 
Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-20 11:47:06.000000000 +0200
+++ linux/fs/namespace.c	2005-05-20 12:49:46.000000000 +0200
@@ -869,7 +869,7 @@ void mark_mounts_for_expiry(struct list_
 		/* don't do anything if the namespace is dead - all the
 		 * vfsmounts from it are going away anyway */
 		namespace = mnt->mnt_namespace;
-		if (!namespace || atomic_read(&namespace->count) <= 0)
+		if (!namespace || !namespace->root)
 			continue;
 		get_namespace(namespace);
 
@@ -1450,9 +1450,12 @@ void __init mnt_init(unsigned long mempa
 
 void __put_namespace(struct namespace *namespace)
 {
+	struct vfsmount *root = namespace->root;
+	namespace->root = NULL;
+	spin_unlock(&vfsmount_lock);
 	down_write(&namespace->sem);
 	spin_lock(&vfsmount_lock);
-	umount_tree(namespace->root);
+	umount_tree(root);
 	spin_unlock(&vfsmount_lock);
 	up_write(&namespace->sem);
 	kfree(namespace);
