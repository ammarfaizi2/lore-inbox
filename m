Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWFPTs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWFPTs5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFPTs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:48:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54188 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751482AbWFPTs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:48:56 -0400
Date: Fri, 16 Jun 2006 12:48:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
cc: Hugh Dickins <hugh@veritas.com>, Jens Axboe <axboe@suse.de>,
       Ingo Molnar <mingo@elte.hu>, Dave Miller <davem@redhat.com>
Subject: Move struct file RCU handling into the slab allocator?
Message-ID: <Pine.LNX.4.64.0606161246210.16400@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we schedule RCU frees for each file we free separately. That has
several drawback against the earlier file handling (in 2.6.5 f.e.) that did
not require RCU callbacks.

1. Excessive number of RCU callbacks can be generated causing long RCU
   queues that in turn cause long latencies.

2. The cache hot object is not preserved between free and realloc. A close
   followed by another open is very fast with the RCU less approach because
   the last freed object is returned by the slab allocator that is
   still cache hot. RCU free means that the object is not immediately
   available again. The new object is cache cold and therefore open/close
   performance tests show a significant degradation with the RCU
   implementation.

One solution to this problem is to move the RCU freeing into the Slab
allocator by specifying SLAB_DESTROY_BY_RCU as an option at slab creation
time. The slab allocator will do RCU frees only when it is necessary
to dispose of whole pages of objects (very rare). So with that approach
we can cut out the RCU overhead almost completely.

However, the slab allocator may return the object for another use even
before the RCU period has expired under SLAB_DESTROY_BY_RCU. This means
there is the very unlikely possibility that the object is going to be
switched under us in sections protected by rcu_read_lock() and
rcu_read_unlock(). So we need to verify that we have acquired the correct
object after establishing a stable object reference (incrementing the
refcounter does that).

I am not that familiar with struct file handling so I may have
left something out or overdone something else. We can certainly optimize
the way we check that we have received the correct object. Also the
constructor sets up only a few fields. It would probably be possible
to move more initializations into the constructor which may reduce the
cachelines touched for the open/close case . And then there is the
question if the identication of the object is safe the way it is right now.

One question is if the overhead of the additional checks offsets the 
benefit we get through reduced RCU processing.

I have tested this on IA64 NUMA with aim7.

Index: linux-2.6.17-rc6-mm2/include/linux/fs.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/fs.h	2006-06-16 11:48:51.787882358 -0700
+++ linux-2.6.17-rc6-mm2/include/linux/fs.h	2006-06-16 12:06:59.669735223 -0700
@@ -718,14 +718,7 @@ struct file_ra_state {
 #define RA_FLAG_EOF		(1UL<<27) /* readahead hits EOF */
 
 struct file {
-	/*
-	 * fu_list becomes invalid after file_free is called and queued via
-	 * fu_rcuhead for RCU freeing
-	 */
-	union {
-		struct list_head	fu_list;
-		struct rcu_head 	fu_rcuhead;
-	} f_u;
+	struct list_head	fu_list;
 	struct dentry		*f_dentry;
 	struct vfsmount         *f_vfsmnt;
 	const struct file_operations	*f_op;
Index: linux-2.6.17-rc6-mm2/fs/file_table.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/file_table.c	2006-06-16 11:48:49.092736849 -0700
+++ linux-2.6.17-rc6-mm2/fs/file_table.c	2006-06-16 12:18:40.947608303 -0700
@@ -36,16 +36,10 @@ __cacheline_aligned_in_smp DEFINE_SPINLO
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
-static inline void file_free_rcu(struct rcu_head *head)
-{
-	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
-	kmem_cache_free(filp_cachep, f);
-}
-
 static inline void file_free(struct file *f)
 {
 	percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
+	kmem_cache_free(filp_cachep, f);
 }
 
 /*
@@ -110,16 +104,21 @@ struct file *get_empty_filp(void)
 		goto fail;
 
 	percpu_counter_inc(&nr_files);
-	memset(f, 0, sizeof(*f));
 	if (security_file_alloc(f))
 		goto fail_sec;
-
+	f->f_dentry = NULL;
+	f->f_vfsmnt = NULL;
+	f->f_op = NULL;
+	f->f_flags = 0;
+	f->f_pos = 0;
+	f->f_version = 0;
+	f->private_data = NULL;
+	f->f_mapping = NULL;
+	atomic_inc(&f->f_count);
 	tsk = current;
-	INIT_LIST_HEAD(&f->f_u.fu_list);
-	atomic_set(&f->f_count, 1);
-	rwlock_init(&f->f_owner.lock);
 	f->f_uid = tsk->fsuid;
 	f->f_gid = tsk->fsgid;
+	f->f_owner.signum = 0;
 	eventpoll_init_file(f);
 	/* f->f_version: 0 */
 	return f;
@@ -203,6 +202,14 @@ struct file fastcall *fget(unsigned int 
 			rcu_read_unlock();
 			return NULL;
 		}
+		/*
+		 * Now we have a stable reference to an object.
+		 * Check if RCU switched it from under us.
+		 */
+		if (unlikely(file != fcheck_files(files, fd))) {
+			put_filp(file);
+			file = NULL;
+		}
 	}
 	rcu_read_unlock();
 
@@ -230,8 +237,17 @@ struct file fastcall *fget_light(unsigne
 		rcu_read_lock();
 		file = fcheck_files(files, fd);
 		if (file) {
-			if (atomic_inc_not_zero(&file->f_count))
-				*fput_needed = 1;
+			if (atomic_inc_not_zero(&file->f_count)) {
+				/*
+				 * Now we have a stable reference to an object.
+				 * Check if RCU switched it from under us.
+				 */
+				if (unlikely(file != fcheck_files(files, fd))) {
+					put_filp(file);
+					file = NULL;
+				} else
+					*fput_needed = 1;
+			}
 			else
 				/* Didn't get the reference, someone's freed */
 				file = NULL;
@@ -257,15 +273,15 @@ void file_move(struct file *file, struct
 	if (!list)
 		return;
 	file_list_lock();
-	list_move(&file->f_u.fu_list, list);
+	list_move(&file->fu_list, list);
 	file_list_unlock();
 }
 
 void file_kill(struct file *file)
 {
-	if (!list_empty(&file->f_u.fu_list)) {
+	if (!list_empty(&file->fu_list)) {
 		file_list_lock();
-		list_del_init(&file->f_u.fu_list);
+		list_del_init(&file->fu_list);
 		file_list_unlock();
 	}
 }
@@ -277,7 +293,7 @@ int fs_may_remount_ro(struct super_block
 	/* Check that no files are currently opened for writing. */
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file *file = list_entry(p, struct file, f_u.fu_list);
+		struct file *file = list_entry(p, struct file, fu_list);
 		struct inode *inode = file->f_dentry->d_inode;
 
 		/* File with pending delete? */
Index: linux-2.6.17-rc6-mm2/fs/dcache.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/dcache.c	2006-06-16 11:48:48.999969160 -0700
+++ linux-2.6.17-rc6-mm2/fs/dcache.c	2006-06-16 12:06:59.671688227 -0700
@@ -1800,6 +1800,21 @@ void __init vfs_caches_init_early(void)
 	inode_init_early();
 }
 
+static void filp_constructor(void *data, struct kmem_cache *cachep,
+			unsigned long flags)
+{
+	struct file *f = data;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) !=
+		SLAB_CTOR_CONSTRUCTOR)
+			return;
+
+	memset(f, 0, sizeof(*f));
+	INIT_LIST_HEAD(&f->fu_list);
+	atomic_set(&f->f_count, 0);
+	rwlock_init(&f->f_owner.lock);
+}
+
 void __init vfs_caches_init(unsigned long mempages)
 {
 	unsigned long reserve;
@@ -1814,7 +1829,8 @@ void __init vfs_caches_init(unsigned lon
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_DESTROY_BY_RCU,
+			filp_constructor, NULL);
 
 	dcache_init(mempages);
 	inode_init(mempages);
Index: linux-2.6.17-rc6-mm2/drivers/char/tty_io.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/char/tty_io.c	2006-06-16 11:48:45.303909104 -0700
+++ linux-2.6.17-rc6-mm2/drivers/char/tty_io.c	2006-06-16 12:06:59.673641231 -0700
@@ -1046,7 +1046,7 @@ static void do_tty_hangup(void *data)
 	check_tty_count(tty, "do_tty_hangup");
 	file_list_lock();
 	/* This breaks for file handles being sent over AF_UNIX sockets ? */
-	list_for_each_entry(filp, &tty->tty_files, f_u.fu_list) {
+	list_for_each_entry(filp, &tty->tty_files, fu_list) {
 		if (filp->f_op->write == redirected_tty_write)
 			cons_filp = filp;
 		if (filp->f_op->write != tty_write)
Index: linux-2.6.17-rc6-mm2/fs/dquot.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/dquot.c	2006-06-16 11:48:49.043911749 -0700
+++ linux-2.6.17-rc6-mm2/fs/dquot.c	2006-06-16 12:06:59.674617733 -0700
@@ -693,7 +693,7 @@ static void add_dquot_ref(struct super_b
 restart:
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file *filp = list_entry(p, struct file, f_u.fu_list);
+		struct file *filp = list_entry(p, struct file, fu_list);
 		struct inode *inode = filp->f_dentry->d_inode;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
 			struct dentry *dentry = dget(filp->f_dentry);
Index: linux-2.6.17-rc6-mm2/security/selinux/selinuxfs.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/security/selinux/selinuxfs.c	2006-06-16 11:48:53.136431615 -0700
+++ linux-2.6.17-rc6-mm2/security/selinux/selinuxfs.c	2006-06-16 12:06:59.676570737 -0700
@@ -966,7 +966,7 @@ static void sel_remove_bools(struct dent
 
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file * filp = list_entry(p, struct file, f_u.fu_list);
+		struct file * filp = list_entry(p, struct file, fu_list);
 		struct dentry * dentry = filp->f_dentry;
 
 		if (dentry->d_parent != de) {
Index: linux-2.6.17-rc6-mm2/fs/super.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/super.c	2006-06-16 11:48:49.739181171 -0700
+++ linux-2.6.17-rc6-mm2/fs/super.c	2006-06-16 12:06:59.676570737 -0700
@@ -518,7 +518,7 @@ static void mark_files_ro(struct super_b
 	struct file *f;
 
 	file_list_lock();
-	list_for_each_entry(f, &sb->s_files, f_u.fu_list) {
+	list_for_each_entry(f, &sb->s_files, fu_list) {
 		if (S_ISREG(f->f_dentry->d_inode->i_mode) && file_count(f))
 			f->f_mode &= ~FMODE_WRITE;
 	}
Index: linux-2.6.17-rc6-mm2/security/selinux/hooks.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/security/selinux/hooks.c	2006-06-16 11:48:53.130572603 -0700
+++ linux-2.6.17-rc6-mm2/security/selinux/hooks.c	2006-06-16 12:06:59.678523741 -0700
@@ -1614,7 +1614,7 @@ static inline void flush_unauthorized_fi
 
 	if (tty) {
 		file_list_lock();
-		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
+		file = list_entry(tty->tty_files.next, typeof(*file), fu_list);
 		if (file) {
 			/* Revalidate access to controlling tty.
 			   Use inode_has_perm on the tty inode directly rather
Index: linux-2.6.17-rc6-mm2/fs/proc/generic.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/proc/generic.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm2/fs/proc/generic.c	2006-06-16 12:06:59.679500243 -0700
@@ -557,7 +557,7 @@ static void proc_kill_inodes(struct proc
 	 */
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file * filp = list_entry(p, struct file, f_u.fu_list);
+		struct file * filp = list_entry(p, struct file, fu_list);
 		struct dentry * dentry = filp->f_dentry;
 		struct inode * inode;
 		const struct file_operations *fops;
