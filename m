Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVGHKc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVGHKc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVGHK1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:27:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:33263 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262476AbVGHK0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:26:11 -0400
Subject: [RFC PATCH 7/8] automounter support for
	shared/slave/private/unclone
From: Ram <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <1120816835.30164.31.camel@localhost>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120816355.30164.16.camel@localhost>
	 <1120816436.30164.19.camel@localhost> <1120816521.30164.22.camel@localhost>
	 <1120816600.30164.25.camel@localhost> <1120816720.30164.28.camel@localhost>
	 <1120816835.30164.31.camel@localhost>
Content-Type: multipart/mixed; boundary="=-UKpRpnDk1aQsDzRZhpPx"
Organization: IBM 
Message-Id: <1120817846.30164.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Jul 2005 03:26:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UKpRpnDk1aQsDzRZhpPx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

adds support for mount/umount propogation for autofs initiated 
operations,

RP


--=-UKpRpnDk1aQsDzRZhpPx
Content-Disposition: attachment; filename=automount.patch
Content-Type: text/x-patch; name=automount.patch
Content-Transfer-Encoding: 7bit

adds support for mount/umount propogation for autofs initiated operations,
RP


Index: 2.6.12/fs/namespace.c
===================================================================
--- 2.6.12.orig/fs/namespace.c
+++ 2.6.12/fs/namespace.c
@@ -205,9 +205,12 @@ struct vfsmount *do_attach_prepare_mnt(s
 	struct vfsmount *child_mnt;
 	struct nameidata nd;
 
-	if (clone_flag)
+	if (clone_flag) {
 		child_mnt = clone_mnt(template_mnt, template_mnt->mnt_root);
-	else
+		spin_lock(&vfsmount_lock);
+		list_del_init(&child_mnt->mnt_fslink);
+		spin_unlock(&vfsmount_lock);
+	} else
 		child_mnt = template_mnt;
 
 	nd.mnt = mnt;
@@ -344,38 +347,16 @@ struct seq_operations mounts_op = {
  * open files, pwds, chroots or sub mounts that are
  * busy.
  */
-//TOBEFIXED
 int may_umount_tree(struct vfsmount *mnt)
 {
-	struct list_head *next;
-	struct vfsmount *this_parent = mnt;
-	int actual_refs;
-	int minimum_refs;
+	int actual_refs=0;
+	int minimum_refs=0;
+	struct vfsmount *p;
 
 	spin_lock(&vfsmount_lock);
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
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		actual_refs += atomic_read(&p->mnt_count);
 		minimum_refs += 2;
-
-		if (!list_empty(&p->mnt_mounts)) {
-			this_parent = p;
-			goto repeat;
-		}
-	}
-
-	if (this_parent != mnt) {
-		next = this_parent->mnt_child.next;
-		this_parent = this_parent->mnt_parent;
-		goto resume;
 	}
 	spin_unlock(&vfsmount_lock);
 
@@ -387,18 +368,18 @@ resume:
 
 EXPORT_SYMBOL(may_umount_tree);
 
-int mount_busy(struct vfsmount *mnt)
+int mount_busy(struct vfsmount *mnt, int refcnt)
 {
 	struct vfspnode *parent_pnode;
 
 	if (mnt == mnt->mnt_parent || !IS_MNT_SHARED(mnt->mnt_parent))
-		return do_refcount_check(mnt, 2);
+		return do_refcount_check(mnt, refcnt);
 
 	parent_pnode = mnt->mnt_parent->mnt_pnode;
 	BUG_ON(!parent_pnode);
 	return pnode_mount_busy(parent_pnode,
 			mnt->mnt_mountpoint,
-			mnt->mnt_root, mnt);
+			mnt->mnt_root, mnt, refcnt);
 }
 
 /**
@@ -416,7 +397,9 @@ int mount_busy(struct vfsmount *mnt)
  */
 int may_umount(struct vfsmount *mnt)
 {
-	return (!mount_busy(mnt));
+	if (mount_busy(mnt,2))
+		return -EBUSY;
+	return 0;
 }
 
 EXPORT_SYMBOL(may_umount);
@@ -435,6 +418,25 @@ void do_detach_mount(struct vfsmount *mn
 	spin_lock(&vfsmount_lock);
 }
 
+void umount_mnt(struct vfsmount *mnt)
+{
+	if (mnt->mnt_parent != mnt &&
+		IS_MNT_SHARED(mnt->mnt_parent)) {
+		struct vfspnode *parent_pnode
+			= mnt->mnt_parent->mnt_pnode;
+		BUG_ON(!parent_pnode);
+		pnode_umount(parent_pnode,
+			mnt->mnt_mountpoint,
+			mnt->mnt_root);
+	} else {
+		if (IS_MNT_SHARED(mnt) || IS_MNT_SLAVE(mnt)) {
+			BUG_ON(!mnt->mnt_pnode);
+			pnode_disassociate_mnt(mnt);
+		}
+		do_detach_mount(mnt);
+	}
+}
+
 void umount_tree(struct vfsmount *mnt)
 {
 	struct vfsmount *p;
@@ -449,21 +451,7 @@ void umount_tree(struct vfsmount *mnt)
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
 		list_del_init(&mnt->mnt_fslink);
-		if (mnt->mnt_parent != mnt &&
-			IS_MNT_SHARED(mnt->mnt_parent)) {
-			struct vfspnode *parent_pnode
-				= mnt->mnt_parent->mnt_pnode;
-			BUG_ON(!parent_pnode);
-			pnode_umount(parent_pnode,
-				mnt->mnt_mountpoint,
-				mnt->mnt_root);
-		} else {
-			if (IS_MNT_SHARED(mnt) || IS_MNT_SLAVE(mnt)) {
-				BUG_ON(!mnt->mnt_pnode);
-				pnode_disassociate_mnt(mnt);
-			}
-			do_detach_mount(mnt);
-		}
+		umount_mnt(mnt);
 	}
 }
 
@@ -558,7 +546,7 @@ int do_umount(struct vfsmount *mnt, int 
 		spin_lock(&vfsmount_lock);
 	}
 	retval = -EBUSY;
-	if (flags & MNT_DETACH || !mount_busy(mnt)) {
+	if (flags & MNT_DETACH || !mount_busy(mnt, 2)) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt);
 		retval = 0;
@@ -964,14 +952,13 @@ struct vfsmount *do_make_mounted(struct 
 	newmnt->mnt_pnode = NULL;
 
 	if (newmnt) {
-		/* put in code for mount expiry */
-		/* TOBEDONE */
-
 		/*
 		 * walk through the mount list of mnt and move
 		 * them under the new mount
 		 */
 		spin_lock(&vfsmount_lock);
+		list_del_init(&newmnt->mnt_fslink);
+
 		list_for_each_entry_safe(child_mnt, next,
 				&mnt->mnt_mounts, mnt_child) {
 
@@ -1412,6 +1399,8 @@ void mark_mounts_for_expiry(struct list_
 	if (list_empty(mounts))
 		return;
 
+	down_write(&namespace_sem);
+
 	spin_lock(&vfsmount_lock);
 
 	/* extract from the expiration list every vfsmount that matches the
@@ -1421,8 +1410,7 @@ void mark_mounts_for_expiry(struct list_
 	 *   cleared by mntput())
 	 */
 	list_for_each_entry_safe(mnt, next, mounts, mnt_fslink) {
-		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
-		    atomic_read(&mnt->mnt_count) != 1)
+		if (!xchg(&mnt->mnt_expiry_mark, 1) || mount_busy(mnt, 1))
 			continue;
 
 		mntget(mnt);
@@ -1430,12 +1418,13 @@ void mark_mounts_for_expiry(struct list_
 	}
 
 	/*
-	 * go through the vfsmounts we've just consigned to the graveyard to
-	 * - check that they're still dead
+	 * go through the vfsmounts we've just consigned to the graveyard
 	 * - delete the vfsmount from the appropriate namespace under lock
 	 * - dispose of the corpse
 	 */
 	while (!list_empty(&graveyard)) {
+		struct super_block *sb;
+
 		mnt = list_entry(graveyard.next, struct vfsmount, mnt_fslink);
 		list_del_init(&mnt->mnt_fslink);
 
@@ -1446,60 +1435,25 @@ void mark_mounts_for_expiry(struct list_
 			continue;
 		get_namespace(namespace);
 
-		spin_unlock(&vfsmount_lock);
-		down_write(&namespace_sem);
-		spin_lock(&vfsmount_lock);
-
-		/* check that it is still dead: the count should now be 2 - as
-		 * contributed by the vfsmount parent and the mntget above */
-		if (atomic_read(&mnt->mnt_count) == 2) {
-			struct vfsmount *xdmnt;
-			struct dentry *xdentry;
-
-			/* delete from the namespace */
-			list_del_init(&mnt->mnt_list);
-			list_del_init(&mnt->mnt_child);
-			list_del_init(&mnt->mnt_hash);
-			mnt->mnt_mountpoint->d_mounted--;
-
-			xdentry = mnt->mnt_mountpoint;
-			mnt->mnt_mountpoint = mnt->mnt_root;
-			xdmnt = mnt->mnt_parent;
-			mnt->mnt_parent = mnt;
-
-			spin_unlock(&vfsmount_lock);
-
-			mntput(xdmnt);
-			dput(xdentry);
-
-			/* now lay it to rest if this was the last ref on the
-			 * superblock */
-			if (atomic_read(&mnt->mnt_sb->s_active) == 1) {
-				/* last instance - try to be smart */
-				lock_kernel();
-				DQUOT_OFF(mnt->mnt_sb);
-				acct_auto_close(mnt->mnt_sb);
-				unlock_kernel();
-			}
-
-			mntput(mnt);
-		} else {
-			/* someone brought it back to life whilst we didn't
-			 * have any locks held so return it to the expiration
-			 * list */
-			list_add_tail(&mnt->mnt_fslink, mounts);
-			spin_unlock(&vfsmount_lock);
+		sb = mnt->mnt_sb;
+		umount_mnt(mnt);
+		/*
+		 * now lay it to rest if this was the last ref on the
+		 * superblock
+		 */
+		if (atomic_read(&sb->s_active) == 1) {
+			/* last instance - try to be smart */
+			lock_kernel();
+			DQUOT_OFF(sb);
+			acct_auto_close(sb);
+			unlock_kernel();
 		}
-
-		up_write(&namespace_sem);
-
 		mntput(mnt);
-		put_namespace(namespace);
 
-		spin_lock(&vfsmount_lock);
+		put_namespace(namespace);
 	}
-
 	spin_unlock(&vfsmount_lock);
+	up_write(&namespace_sem);
 }
 
 EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
Index: 2.6.12/fs/pnode.c
===================================================================
--- 2.6.12.orig/fs/pnode.c
+++ 2.6.12/fs/pnode.c
@@ -230,7 +230,7 @@ pnode_add_member_mnt(struct vfspnode *pn
 
 static int
 vfs_busy(struct vfsmount *mnt, struct dentry *dentry, struct dentry *rootdentry,
-		struct vfsmount *origmnt)
+		struct vfsmount *origmnt, int refcnt)
 {
 	struct vfsmount *child_mnt;
 	int ret=0;
@@ -244,9 +244,9 @@ vfs_busy(struct vfsmount *mnt, struct de
 
 	if (list_empty(&child_mnt->mnt_mounts)) {
 		if (origmnt == child_mnt)
-			ret = do_refcount_check(child_mnt, 3);
+			ret = do_refcount_check(child_mnt, refcnt+1);
 		else
-			ret = do_refcount_check(child_mnt, 2);
+			ret = do_refcount_check(child_mnt, refcnt);
 	}
 	mntput(child_mnt);
 	return ret;
@@ -254,7 +254,7 @@ vfs_busy(struct vfsmount *mnt, struct de
 
 int
 pnode_mount_busy(struct vfspnode *pnode, struct dentry *mntpt, struct dentry *root,
-			struct vfsmount *mnt)
+			struct vfsmount *mnt, int refcnt)
 {
 	int ret=0,traversal;
      	struct vfsmount *slave_mnt, *member_mnt, *t_m;
@@ -271,14 +271,14 @@ pnode_mount_busy(struct vfspnode *pnode,
 			list_for_each_entry_safe(member_mnt,
 				t_m, &pnode->pnode_vfs, mnt_pnode_mntlist) {
 				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_busy(member_mnt, mntpt, root, mnt)))
+				if ((ret = vfs_busy(member_mnt, mntpt, root, mnt, refnt)))
 					goto out;
 				spin_lock(&vfspnode_lock);
 			}
 			list_for_each_entry_safe(slave_mnt,
 				t_m, &pnode->pnode_slavevfs, mnt_pnode_mntlist) {
 				spin_unlock(&vfspnode_lock);
-				if ((ret = vfs_busy(slave_mnt, mntpt, root, mnt)))
+				if ((ret = vfs_busy(slave_mnt, mntpt, root, mnt, refcnt)))
 					goto out;
 				spin_lock(&vfspnode_lock);
 			}
Index: 2.6.12/include/linux/pnode.h
===================================================================
--- 2.6.12.orig/include/linux/pnode.h
+++ 2.6.12/include/linux/pnode.h
@@ -83,6 +83,6 @@ int pnode_prepare_mount(struct vfspnode 
 		struct vfsmount *, struct vfsmount *);
 int pnode_real_mount(struct vfspnode *, int);
 int pnode_umount(struct vfspnode *, struct dentry *, struct dentry *);
-int pnode_mount_busy(struct vfspnode *, struct dentry *, struct dentry *, struct vfsmount *);
+int pnode_mount_busy(struct vfspnode *, struct dentry *, struct dentry *, struct vfsmount *, int);
 #endif /* KERNEL */
 #endif /* _LINUX_PNODE_H */

--=-UKpRpnDk1aQsDzRZhpPx--

