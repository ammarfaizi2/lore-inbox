Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWHAX7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWHAX7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWHAXwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:52:53 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:40395 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750762AbWHAXwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:47 -0400
Subject: [PATCH 06/28] reintroduce list of vfsmounts over superblock
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:44 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235244.964B79E7@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're moving a big chunk of the burden of keeping people from
writing to r/o filesystems from the superblock into the
vfsmount.  This requires that we consult the superblock's
vfsmounts when things like remounts occur.

So, introduce a list of vfsmounts hanging off the superblock.
We'll use this in a bit.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namespace.c        |   12 ++++++++++++
 lxc-dave/fs/super.c            |    1 +
 lxc-dave/include/linux/fs.h    |    1 +
 lxc-dave/include/linux/mount.h |    1 +
 4 files changed, 15 insertions(+)

diff -puN fs/namespace.c~C-reintroduce-list-of-vfsmounts-over-superblock fs/namespace.c
--- lxc/fs/namespace.c~C-reintroduce-list-of-vfsmounts-over-superblock	2006-08-01 16:35:11.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-08-01 16:35:18.000000000 -0700
@@ -78,10 +78,18 @@ struct vfsmount *alloc_vfsmnt(const char
 	return mnt;
 }
 
+void add_mount_to_sb_list(struct vfsmount *mnt, struct super_block *sb)
+{
+	spin_lock(&vfsmount_lock);
+	list_add(&mnt->mnt_sb_list, &sb->s_vfsmounts);
+	spin_unlock(&vfsmount_lock);
+}
+
 int simple_set_mnt(struct vfsmount *mnt, struct super_block *sb)
 {
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
+	add_mount_to_sb_list(mnt, sb);
 	return 0;
 }
 
@@ -89,6 +97,9 @@ EXPORT_SYMBOL(simple_set_mnt);
 
 void free_vfsmnt(struct vfsmount *mnt)
 {
+	spin_lock(&vfsmount_lock);
+	list_del(&mnt->mnt_sb_list);
+	spin_unlock(&vfsmount_lock);
 	kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
 }
@@ -242,6 +253,7 @@ static struct vfsmount *clone_mnt(struct
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
+		add_mount_to_sb_list(mnt, sb);
 
 		if (flag & CL_SLAVE) {
 			list_add(&mnt->mnt_slave, &old->mnt_slave_list);
diff -puN fs/super.c~C-reintroduce-list-of-vfsmounts-over-superblock fs/super.c
--- lxc/fs/super.c~C-reintroduce-list-of-vfsmounts-over-superblock	2006-08-01 16:35:11.000000000 -0700
+++ lxc-dave/fs/super.c	2006-08-01 16:35:18.000000000 -0700
@@ -67,6 +67,7 @@ static struct super_block *alloc_super(s
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_files);
+		INIT_LIST_HEAD(&s->s_vfsmounts);
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
diff -puN include/linux/fs.h~C-reintroduce-list-of-vfsmounts-over-superblock include/linux/fs.h
--- lxc/include/linux/fs.h~C-reintroduce-list-of-vfsmounts-over-superblock	2006-08-01 16:35:17.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-08-01 16:35:18.000000000 -0700
@@ -962,6 +962,7 @@ struct super_block {
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
+	struct list_head	s_vfsmounts;
 	struct list_head	s_files;
 
 	struct block_device	*s_bdev;
diff -puN include/linux/mount.h~C-reintroduce-list-of-vfsmounts-over-superblock include/linux/mount.h
--- lxc/include/linux/mount.h~C-reintroduce-list-of-vfsmounts-over-superblock	2006-08-01 16:35:11.000000000 -0700
+++ lxc-dave/include/linux/mount.h	2006-08-01 16:35:18.000000000 -0700
@@ -40,6 +40,7 @@ struct vfsmount {
 	struct dentry *mnt_mountpoint;	/* dentry of mountpoint */
 	struct dentry *mnt_root;	/* root of the mounted tree */
 	struct super_block *mnt_sb;	/* pointer to superblock */
+	struct list_head mnt_sb_list;	/* list of all mounts on same sb */
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	atomic_t mnt_count;
_
