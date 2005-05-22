Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVEVRXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVEVRXK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 13:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVEVRXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 13:23:10 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:18699 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261841AbVEVRWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 13:22:31 -0400
To: miklos@szeredi.hu
CC: jamie@shareable.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Sun, 22 May 2005 10:08:39 +0200)
Subject: [RFC][PATCH] /proc/dead_mounts support (Was: [RFC][PATCH] rbind across ...)
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1DZtsk-00015A-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 22 May 2005 19:04:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a better idea:
> 
>  - create a "dead_mounts" namespace.
>  - chain each detached mount's ->mnt_list on dead_mounts->list
>  - set mnt_namespace to dead_mounts
>  - export the list via proc through the usual mount list interface
> 
> The last would be a nice bonus: I've always wanted to see the list of
> detached, but not-yet destroyed mounts.

Here's a patch that does this.  It needs all the other namespace
patches, so I made a diff against 2.6.12-rc4-mm2 in case anybody wants
to try it:

  http://www.inf.bme.hu/~mszeredi/patches/patch-2.6.12-rc4-mm2-szm1

It works for me(TM).

Miklos

Index: linux/include/linux/proc_fs.h
===================================================================
--- linux.orig/include/linux/proc_fs.h	2005-05-22 16:09:37.000000000 +0200
+++ linux/include/linux/proc_fs.h	2005-05-22 16:09:45.000000000 +0200
@@ -127,6 +127,7 @@ extern struct dentry *proc_lookup(struct
 extern struct file_operations proc_kcore_operations;
 extern struct file_operations proc_kmsg_operations;
 extern struct file_operations ppc_htab_operations;
+extern struct file_operations proc_dead_mounts_operations;
 
 /*
  * proc_tty.c
Index: linux/fs/proc/proc_misc.c
===================================================================
--- linux.orig/fs/proc/proc_misc.c	2005-05-22 16:09:37.000000000 +0200
+++ linux/fs/proc/proc_misc.c	2005-05-22 16:09:45.000000000 +0200
@@ -652,6 +652,9 @@ void __init proc_misc_init(void)
 		create_proc_read_entry(p->name, 0, NULL, p->read_proc, NULL);
 
 	proc_symlink("mounts", NULL, "self/mounts");
+	entry = create_proc_entry("dead_mounts", S_IRUSR, &proc_root);
+	if (entry)
+		entry->proc_fops = &proc_dead_mounts_operations;
 
 	/* And now for trickier ones */
 	entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
Index: linux/fs/namespace.c
===================================================================
--- linux.orig/fs/namespace.c	2005-05-22 16:09:45.000000000 +0200
+++ linux/fs/namespace.c	2005-05-22 16:12:23.000000000 +0200
@@ -42,6 +42,7 @@ static inline int sysfs_init(void)
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
+static struct namespace *dead_mounts;
 
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
@@ -175,6 +176,8 @@ clone_mnt(struct vfsmount *old, struct d
 void __mntput(struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
+	list_del(&mnt->mnt_list);
+	spin_unlock(&vfsmount_lock);
 	dput(mnt->mnt_root);
 	free_vfsmnt(mnt);
 	deactivate_super(sb);
@@ -240,7 +243,10 @@ static int show_vfsmnt(struct seq_file *
 
 	mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
 	seq_putc(m, ' ');
-	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
+	if (mnt->mnt_namespace != dead_mounts)
+		seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
+	else
+		seq_puts(m, "(detached)");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
 	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
@@ -265,6 +271,71 @@ struct seq_operations mounts_op = {
 	.show	= show_vfsmnt
 };
 
+/* /proc/dead_mounts needs slightly different handling than above */
+static void *dead_m_start(struct seq_file *m, loff_t *pos)
+{
+	struct namespace *n = m->private;
+	struct vfsmount *res = NULL;
+	struct list_head *p;
+	loff_t l = *pos;
+
+	spin_lock(&vfsmount_lock);
+	list_for_each(p, &n->list)
+		if (!l--) {
+			res = mntget(list_entry(p, struct vfsmount, mnt_list));
+			break;
+		}
+	spin_unlock(&vfsmount_lock);
+	return res;
+}
+
+static void *dead_m_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct namespace *n = m->private;
+	struct vfsmount *curr = v;
+	struct vfsmount *res = NULL;
+	struct list_head *p;
+
+	(*pos)++;
+	spin_lock(&vfsmount_lock);
+	p = curr->mnt_list.next;
+	if (p != &n->list)
+		res = mntget(list_entry(p, struct vfsmount, mnt_list));
+	spin_unlock(&vfsmount_lock);
+	mntput(curr);
+	return res;
+}
+
+static void dead_m_stop(struct seq_file *m, void *v)
+{
+	struct vfsmount *curr = v;
+	mntput(curr);
+}
+
+static struct seq_operations dead_mounts_op = {
+	.start	= dead_m_start,
+	.next	= dead_m_next,
+	.stop	= dead_m_stop,
+	.show	= show_vfsmnt
+};
+
+static int dead_mounts_open(struct inode *inode, struct file *file)
+{
+	int ret = seq_open(file, &dead_mounts_op);
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		m->private = dead_mounts;
+	}
+	return ret;
+}
+
+struct file_operations proc_dead_mounts_operations = {
+	.open		= dead_mounts_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 /**
  * may_umount_tree - check if a mount tree is busy
  * @mnt: root of mount tree
@@ -343,14 +414,13 @@ static void umount_tree(struct vfsmount 
 	LIST_HEAD(kill);
 
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		list_del(&p->mnt_list);
-		list_add(&p->mnt_list, &kill);
-		p->mnt_namespace = NULL;
+		list_move(&p->mnt_list, &kill);
+		p->mnt_namespace = dead_mounts;
 	}
 
 	while (!list_empty(&kill)) {
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
-		list_del_init(&mnt->mnt_list);
+		list_move_tail(&mnt->mnt_list, &dead_mounts->list);
 		list_del_init(&mnt->mnt_fslink);
 		if (mnt->mnt_parent == mnt) {
 			spin_unlock(&vfsmount_lock);
@@ -447,7 +517,7 @@ static int do_umount(struct vfsmount *mn
 	}
 	retval = -EBUSY;
 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
-		if (!list_empty(&mnt->mnt_list))
+		if (mnt->mnt_namespace != dead_mounts)
 			umount_tree(mnt);
 		retval = 0;
 	}
@@ -842,8 +912,8 @@ static void expire_mount(struct vfsmount
 		struct nameidata old_nd;
 
 		/* delete from the namespace */
-		list_del_init(&mnt->mnt_list);
-		mnt->mnt_namespace = NULL;
+		list_move_tail(&mnt->mnt_list, &dead_mounts->list);
+		mnt->mnt_namespace = dead_mounts;
 		detach_mnt(mnt, &old_nd);
 		spin_unlock(&vfsmount_lock);
 		path_release(&old_nd);
@@ -1387,6 +1457,14 @@ static void __init init_mount_tree(void)
 	namespace->root = mnt;
 	mnt->mnt_namespace = namespace;
 
+	dead_mounts = kmalloc(sizeof(struct namespace), GFP_KERNEL);
+	if (!dead_mounts)
+		panic("Can't allocate dead_mounts namespace");
+	atomic_set(&dead_mounts->count, 1);
+	INIT_LIST_HEAD(&dead_mounts->list);
+	init_rwsem(&dead_mounts->sem);
+	dead_mounts->root = NULL;
+
 	init_task.namespace = namespace;
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
Index: linux/include/linux/mount.h
===================================================================
--- linux.orig/include/linux/mount.h	2005-05-22 16:09:37.000000000 +0200
+++ linux/include/linux/mount.h	2005-05-22 16:09:45.000000000 +0200
@@ -46,11 +46,12 @@ static inline struct vfsmount *mntget(st
 }
 
 extern void __mntput(struct vfsmount *mnt);
+extern spinlock_t vfsmount_lock;
 
 static inline void _mntput(struct vfsmount *mnt)
 {
 	if (mnt) {
-		if (atomic_dec_and_test(&mnt->mnt_count))
+		if (atomic_dec_and_lock(&mnt->mnt_count, &vfsmount_lock))
 			__mntput(mnt);
 	}
 }
@@ -75,7 +76,5 @@ extern int do_add_mount(struct vfsmount 
 
 extern void mark_mounts_for_expiry(struct list_head *mounts);
 
-extern spinlock_t vfsmount_lock;
-
 #endif
 #endif /* _LINUX_MOUNT_H */
