Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUDVP3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUDVP3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbUDVP3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:29:45 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:48394 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264101AbUDVP3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:29:34 -0400
Date: Thu, 22 Apr 2004 23:32:39 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-mm1
In-Reply-To: <20040421014544.37942eb4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404222321310.6767@donald.themaw.net>
References: <20040421014544.37942eb4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.7, required 8,
	IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF, REFERENCES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a second attempt at a patch to address Christophs' concerns.

It assumes a 2.6.6-rc2-mm1 tree.

- renamed autofs4_may_umount to __may_umount_tree, made it static
  and moved it to namespace.c.
- added stub function may_umount_tree with description
- altered may_umount to use above stub function and added
  little description
- added may_umount_tree prototype to fs.h
- removed the EXPORT_SYMBOL for vfsmount_lock
- updated expire.c to suit

Andrew,

This is the entire patch again. I hope this won't cause to much 
hastle.

diff -Nur linux-2.6.6-rc1-mm1.orig/fs/autofs4/expire.c linux-2.6.6-rc1-mm1/fs/autofs4/expire.c
--- linux-2.6.6-rc1-mm1.orig/fs/autofs4/expire.c	2004-04-20 23:35:14.000000000 +0800
+++ linux-2.6.6-rc1-mm1/fs/autofs4/expire.c	2004-04-22 21:06:09.000000000 +0800
@@ -45,47 +45,6 @@
 	return 1;
 }
 
-/* Sorry I can't solve the problem without using counts either */
-static int autofs4_may_umount(struct vfsmount *mnt)
-{
-	struct list_head *next;
-	struct vfsmount *this_parent = mnt;
-	int actual_refs;
-	int minimum_refs;
-
-	spin_lock(&vfsmount_lock);
-	actual_refs = atomic_read(&mnt->mnt_count);
-	minimum_refs = 2;
-repeat:
-	next = this_parent->mnt_mounts.next;
-resume:
-	while (next != &this_parent->mnt_mounts) {
-		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
-
-		next = next->next;
-
-		actual_refs += atomic_read(&p->mnt_count);
-		minimum_refs += 2;
-
-		if ( !list_empty(&p->mnt_mounts) ) {
-			this_parent = p;
-			goto repeat;
-		}
-	}
-
-	if (this_parent != mnt) {
-		next = this_parent->mnt_child.next;
-		this_parent = this_parent->mnt_parent;
-		goto resume;
-	}
-	spin_unlock(&vfsmount_lock);
-
-	DPRINTK(("autofs4_may_umount: done actual = %d, minimum = %d\n",
-		 actual_refs, minimum_refs));
-
-	return actual_refs > minimum_refs;
-}
-
 /* Check a mount point for busyness return 1 if not busy, otherwise */
 static int autofs4_check_mount(struct vfsmount *mnt, struct dentry *dentry)
 {
@@ -108,7 +67,7 @@
 		goto done;
 
 	/* The big question */
-	if (autofs4_may_umount(mnt) == 0)
+	if (may_umount_tree(mnt) == 0)
 		status = 1;
 done:
 	DPRINTK(("autofs4_check_mount: returning = %d\n", status));
--- linux-2.6.6-rc1-mm1.orig/fs/namespace.c	2004-04-20 22:08:41.000000000 +0800
+++ linux-2.6.6-rc1-mm1/fs/namespace.c	2004-04-22 21:06:09.000000000 +0800
@@ -37,8 +37,6 @@
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 spinlock_t vfsmount_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
-EXPORT_SYMBOL(vfsmount_lock);
-
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
@@ -262,16 +260,85 @@
 	.show	= show_vfsmnt
 };
 
-/*
+static int __may_umount_tree(struct vfsmount *mnt, int root_mnt_only)
+{
+	struct list_head *next;
+	struct vfsmount *this_parent = mnt;
+	int actual_refs;
+	int minimum_refs;
+
+	spin_lock(&vfsmount_lock);
+	actual_refs = atomic_read(&mnt->mnt_count);
+	minimum_refs = 2;
+
+	if (root_mnt_only) {
+ 		spin_unlock(&vfsmount_lock);
+		if (actual_refs > minimum_refs)
+			return -EBUSY;
+		return 0;
+	}
+
+repeat:
+	next = this_parent->mnt_mounts.next;
+resume:
+	while (next != &this_parent->mnt_mounts) {
+		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
+
+		next = next->next;
+
+		actual_refs += atomic_read(&p->mnt_count);
+		minimum_refs += 2;
+
+		if (!list_empty(&p->mnt_mounts)) {
+			this_parent = p;
+			goto repeat;
+		}
+	}
+
+	if (this_parent != mnt) {
+		next = this_parent->mnt_child.next;
+		this_parent = this_parent->mnt_parent;
+		goto resume;
+	}
+	spin_unlock(&vfsmount_lock);
+
+	if (actual_refs > minimum_refs)
+		return -EBUSY;
+
+	return 0;
+}
+
+/**
+ * may_umount_tree - check if a mount tree is busy
+ * @mnt: root of mount tree
+ *
+ * This is called to check if a tree of mounts has any
+ * open files, pwds, chroots or sub mounts that are
+ * busy.
+ */
+int may_umount_tree(struct vfsmount *mnt)
+{
+	return __may_umount_tree(mnt, 0);
+}
+
+EXPORT_SYMBOL(may_umount_tree);
+
+/**
+ * may_umount - check if a mount point is busy
+ * @mnt: root of mount
+ *
+ * This is called to check if a mount point has any
+ * open files, pwds, chroots or sub mounts. If the
+ * mount has sub mounts this will return busy
+ * regardless of whether the sub mounts are busy.
+ *
  * Doesn't take quota and stuff into account. IOW, in some cases it will
  * give false negatives. The main reason why it's here is that we need
  * a non-destructive way to look for easily umountable filesystems.
  */
 int may_umount(struct vfsmount *mnt)
 {
-	if (atomic_read(&mnt->mnt_count) > 2)
-		return -EBUSY;
-	return 0;
+	return __may_umount_tree(mnt, 1);
 }
 
 EXPORT_SYMBOL(may_umount);
--- linux-2.6.6-rc1-mm1.orig/include/linux/fs.h	2004-04-20 22:08:51.000000000 +0800
+++ linux-2.6.6-rc1-mm1/include/linux/fs.h	2004-04-22 21:58:11.000000000 +0800
@@ -1127,6 +1127,7 @@
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount(struct file_system_type *);
+extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
 
