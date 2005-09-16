Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbVIPS1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbVIPS1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161241AbVIPS1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:27:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41105 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161233AbVIPS1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:27:00 -0400
Date: Fri, 16 Sep 2005 11:26:20 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 8/10] vfs: shared subtree aware namespaces 
Message-ID: <20050916182620.GA28532@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch that help setup the correct propagation for the mounts under the new
cloned namespace.

Signed by Ram Pai (linuxram@us.ibm.com)

 fs/namespace.c        |   14 ++++++++++++++
 fs/pnode.c            |   17 +++++++++++++++++
 include/linux/pnode.h |    1 +
 3 files changed, 32 insertions(+)

Index: 2.6.13.sharedsubtree/fs/namespace.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/namespace.c
+++ 2.6.13.sharedsubtree/fs/namespace.c
@@ -1572,11 +1572,22 @@ int copy_namespace(int flags, struct tas
 	 * fs_struct, so tsk->fs->lock is not needed.
 	 */
 	p = namespace->root;
 	q = new_ns->root;
 	while (p) {
+		if (IS_MNT_UNCLONABLE(p)) {
+			p = skip_mnt_tree(p);
+			p = next_mnt(p, namespace->root);
+			continue;
+		}
 		q->mnt_namespace = new_ns;
+		/*
+		 * release the reference to q->mnt_master
+		 * held in clone_mnt()
+		 */
+		mntput(q->mnt_master);
+		copy_propagation(p, q);
 		if (fs) {
 			if (p == fs->rootmnt) {
 				rootmnt = p;
 				fs->rootmnt = mntget(q);
 			}
@@ -1949,14 +1960,17 @@ void __init mnt_init(unsigned long mempa
 }
 
 void __put_namespace(struct namespace *namespace)
 {
 	struct vfsmount *root = namespace->root;
+	struct vfsmount *mnt;
 	namespace->root = NULL;
 	spin_unlock(&vfsmount_lock);
 	down_write(&namespace_sem);
 	spin_lock(&vfsmount_lock);
+	list_for_each_entry(mnt, &namespace->list, mnt_list)
+	    do_make_private(mnt);
 	umount_tree(root);
 	spin_unlock(&vfsmount_lock);
 	up_write(&namespace_sem);
 	kfree(namespace);
 }
Index: 2.6.13.sharedsubtree/fs/pnode.c
===================================================================
--- 2.6.13.sharedsubtree.orig/fs/pnode.c
+++ 2.6.13.sharedsubtree/fs/pnode.c
@@ -175,10 +175,27 @@ void pnode_slave_mount(struct vfsmount *
 	first->mnt_master = second->mnt_master;
 	list_add(&first->mnt_slave, &second->mnt_slave);
 	spin_unlock(&vfspnode_lock);
 }
 
+/*
+ * set up the same propagation for mount @new as
+ * that of mount @old'
+ */
+void copy_propagation(struct vfsmount *old, struct vfsmount *new)
+{
+	spin_lock(&vfspnode_lock);
+	new->mnt_master = NULL;
+	if (IS_MNT_SHARED(old))
+		list_add_tail(&new->mnt_share, &old->mnt_share);
+	else if (IS_MNT_SLAVE(old)) {
+		list_add_tail(&new->mnt_slave, &old->mnt_slave);
+		new->mnt_master = old->mnt_master;
+	}
+	spin_unlock(&vfspnode_lock);
+}
+
 static int check_peer(struct vfsmount *start, struct vfsmount *orig)
 {
 	struct vfsmount *m = start;
 	do {
 		m = next_shared(m);
Index: 2.6.13.sharedsubtree/include/linux/pnode.h
===================================================================
--- 2.6.13.sharedsubtree.orig/include/linux/pnode.h
+++ 2.6.13.sharedsubtree/include/linux/pnode.h
@@ -62,6 +62,7 @@ int propagate_commit_mount(struct vfsmou
 int propagate_abort_mount(struct vfsmount *);
 int propagate_prepare_mount(struct vfsmount *, struct dentry *,
 			    struct vfsmount *);
 int propagate_umount(struct vfsmount *);
 int propagate_mount_busy(struct vfsmount *, int);
+void copy_propagation(struct vfsmount *, struct vfsmount *);
 #endif				/* _LINUX_PNODE_H */
