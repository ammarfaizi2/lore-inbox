Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317662AbSFLHXb>; Wed, 12 Jun 2002 03:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317663AbSFLHXa>; Wed, 12 Jun 2002 03:23:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14866 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317662AbSFLHXV>;
	Wed, 12 Jun 2002 03:23:21 -0400
Message-ID: <3D06F7C5.D8496FD2@zip.com.au>
Date: Wed, 12 Jun 2002 00:27:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.LNX.4.44.0206111824050.16686-100000@home.transmeta.com> <3D06F42E.9040602@evision-ventures.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> U¿ytkownik Linus Torvalds napisa³:
> >
> > On Wed, 12 Jun 2002, Rusty Russell wrote:
> >
> >>The only really sane way to implement "CONFIG_SMALL_NO_INLINES" that I
> >>can think of is to have headers do
> >
> >
> > inlines, when used properly, are _not_ larger than not inlining.
> 
> Actually I have monitored linux/include/linux/*.h for improper
> and inadequate inlining. Well what have I to say. In comparision
> to the last time I checked (around 4 years ago) the situation
> got *much* better. I was not able to save more then around 1k of
> code from the kernel...

You looked in the wrong place...

The below patch shrunk 2.4.17-pre2 by 11 kbytes.  That's
a ton of L1 cache, and most of it is fastpath.

 drivers/block/ll_rw_blk.c |   18 ++-------------
 fs/binfmt_elf.c           |    4 +--
 fs/block_dev.c            |    2 -
 fs/dcache.c               |    8 +++---
 fs/inode.c                |    6 ++---
 fs/locks.c                |    8 +++---
 fs/namei.c                |   14 ++++++------
 fs/namespace.c            |   42 ++++++++++++++++++++++++++++++++++++
 fs/open.c                 |    4 +--
 fs/read_write.c           |    2 -
 fs/stat.c                 |    2 -
 fs/super.c                |    2 -
 include/linux/fs_struct.h |   53 +++-------------------------------------------
 kernel/exit.c             |   10 ++++----
 kernel/fork.c             |    4 +--
 kernel/module.c           |    2 -
 kernel/sched.c            |    6 ++---
 kernel/signal.c           |    3 --
 kernel/sys.c              |    2 -
 kernel/timer.c            |    2 -
 lib/rwsem.c               |    4 +--
 mm/filemap.c              |    4 +--
 mm/highmem.c              |    2 -
 mm/memory.c               |    2 -
 mm/mmap.c                 |    4 +--
 mm/slab.c                 |   14 ++++++------

--- linux-2.4.17-pre2/fs/binfmt_elf.c	Sat Oct 20 19:16:59 2001
+++ linux-akpm/fs/binfmt_elf.c	Fri Nov 30 21:21:26 2001
@@ -223,7 +223,7 @@ create_elf_tables(char *p, int argc, int
 
 #ifndef elf_map
 
-static inline unsigned long
+static unsigned long
 elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
 {
 	unsigned long map_addr;
@@ -914,7 +914,7 @@ static int dump_seek(struct file *file, 
  *
  * I think we should skip something. But I am not sure how. H.J.
  */
-static inline int maydump(struct vm_area_struct *vma)
+static int maydump(struct vm_area_struct *vma)
 {
 	/*
 	 * If we may not read the contents, don't allow us to dump
--- linux-2.4.17-pre2/fs/dcache.c	Wed Oct  3 22:57:36 2001
+++ linux-akpm/fs/dcache.c	Fri Nov 30 21:21:26 2001
@@ -56,7 +56,7 @@ static LIST_HEAD(dentry_unused);
 struct dentry_stat_t dentry_stat = {0, 0, 45, 0,};
 
 /* no dcache_lock, please */
-static inline void d_free(struct dentry *dentry)
+static void d_free(struct dentry *dentry)
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
@@ -71,7 +71,7 @@ static inline void d_free(struct dentry 
  * d_iput() operation if defined.
  * Called with dcache_lock held, drops it.
  */
-static inline void dentry_iput(struct dentry * dentry)
+static void dentry_iput(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
@@ -215,7 +215,7 @@ int d_invalidate(struct dentry * dentry)
 
 /* This should be called _only_ with dcache_lock held */
 
-static inline struct dentry * __dget_locked(struct dentry *dentry)
+static struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
 	if (atomic_read(&dentry->d_count) == 1) {
@@ -291,7 +291,7 @@ restart:
  * removed.
  * Called with dcache_lock, drops it and then regains.
  */
-static inline void prune_one_dentry(struct dentry * dentry)
+static void prune_one_dentry(struct dentry * dentry)
 {
 	struct dentry * parent;
 
--- linux-2.4.17-pre2/fs/locks.c	Thu Oct 11 07:52:18 2001
+++ linux-akpm/fs/locks.c	Fri Nov 30 21:21:26 2001
@@ -146,7 +146,7 @@ static struct file_lock *locks_alloc_loc
 }
 
 /* Free a lock which is not in use. */
-static inline void locks_free_lock(struct file_lock *fl)
+static void locks_free_lock(struct file_lock *fl)
 {
 	if (fl == NULL) {
 		BUG();
@@ -422,7 +422,7 @@ static void locks_insert_block(struct fi
 	list_add(&waiter->fl_link, &blocked_list);
 }
 
-static inline
+static
 void locks_notify_blocked(struct file_lock *waiter)
 {
 	if (waiter->fl_notify)
@@ -490,7 +490,7 @@ static inline void _unhash_lock(struct f
  * notify the FS that the lock has been cleared and
  * finally free the lock.
  */
-static inline void _delete_lock(struct file_lock *fl, unsigned int wait)
+static void _delete_lock(struct file_lock *fl, unsigned int wait)
 {
 	fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
 	if (fl->fl_fasync != NULL){
@@ -521,7 +521,7 @@ static void locks_delete_lock(struct fil
  * then delete lock. Essentially useful only in locks_remove_*().
  * Note: this must be called with the semaphore already held!
  */
-static inline void locks_unlock_delete(struct file_lock **thisfl_p)
+static void locks_unlock_delete(struct file_lock **thisfl_p)
 {
 	struct file_lock *fl = *thisfl_p;
 	int (*lock)(struct file *, int, struct file_lock *);
--- linux-2.4.17-pre2/fs/namei.c	Wed Oct 17 14:46:29 2001
+++ linux-akpm/fs/namei.c	Fri Nov 30 21:21:26 2001
@@ -331,7 +331,7 @@ static struct dentry * real_lookup(struc
  * Without that kind of total limit, nasty chains of consecutive
  * symlinks can cause almost arbitrarily long lookups. 
  */
-static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int do_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	int err;
 	if (current->link_count >= 5)
@@ -378,7 +378,7 @@ int follow_up(struct vfsmount **mnt, str
 	return __follow_up(mnt, dentry);
 }
 
-static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
+static int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
 {
 	struct vfsmount *mounted;
 
@@ -401,7 +401,7 @@ int follow_down(struct vfsmount **mnt, s
 	return __follow_down(mnt,dentry);
 }
  
-static inline void follow_dotdot(struct nameidata *nd)
+static void follow_dotdot(struct nameidata *nd)
 {
 	while(1) {
 		struct vfsmount *parent;
@@ -704,7 +704,7 @@ void set_fs_altroot(void)
 }
 
 /* SMP-safe */
-static inline int
+static int
 walk_init_root(const char *name, struct nameidata *nd)
 {
 	read_lock(&current->fs->lock);
@@ -867,7 +867,7 @@ static inline int check_sticky(struct in
  *  8. If we were asked to remove a non-directory and victim isn't one - EISDIR.
  *  9. We can't remove a root or mountpoint.
  */
-static inline int may_delete(struct inode *dir,struct dentry *victim, int isdir)
+static int may_delete(struct inode *dir,struct dentry *victim, int isdir)
 {
 	int error;
 	if (!victim->d_inode || victim->d_parent->d_inode != dir)
@@ -898,7 +898,7 @@ static inline int may_delete(struct inod
  *  3. We should have write and exec permissions on dir
  *  4. We can't do it if dir is immutable (done in permission())
  */
-static inline int may_create(struct inode *dir, struct dentry *child) {
+static int may_create(struct inode *dir, struct dentry *child) {
 	if (child->d_inode)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
@@ -1942,7 +1942,7 @@ out:
 	return len;
 }
 
-static inline int
+static int
 __vfs_follow_link(struct nameidata *nd, const char *link)
 {
 	int res = 0;
--- linux-2.4.17-pre2/fs/open.c	Fri Oct 12 13:48:42 2001
+++ linux-akpm/fs/open.c	Fri Nov 30 21:21:26 2001
@@ -89,7 +89,7 @@ int do_truncate(struct dentry *dentry, l
 	return error;
 }
 
-static inline long do_sys_truncate(const char * path, loff_t length)
+static long do_sys_truncate(const char * path, loff_t length)
 {
 	struct nameidata nd;
 	struct inode * inode;
@@ -155,7 +155,7 @@ asmlinkage long sys_truncate(const char 
 	return do_sys_truncate(path, (long)length);
 }
 
-static inline long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+static long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 {
 	struct inode * inode;
 	struct dentry *dentry;
--- linux-2.4.17-pre2/fs/read_write.c	Sun Aug  5 13:12:41 2001
+++ linux-akpm/fs/read_write.c	Fri Nov 30 21:21:26 2001
@@ -76,7 +76,7 @@ loff_t default_llseek(struct file *file,
 	return retval;
 }
 
-static inline loff_t llseek(struct file *file, loff_t offset, int origin)
+static loff_t llseek(struct file *file, loff_t offset, int origin)
 {
 	loff_t (*fn)(struct file *, loff_t, int);
 	loff_t retval;
--- linux-2.4.17-pre2/fs/stat.c	Thu Sep 13 16:04:43 2001
+++ linux-akpm/fs/stat.c	Fri Nov 30 21:21:26 2001
@@ -16,7 +16,7 @@
 /*
  * Revalidate the inode. This is required for proper NFS attribute caching.
  */
-static __inline__ int
+static int
 do_revalidate(struct dentry *dentry)
 {
 	struct inode * inode = dentry->d_inode;
--- linux-2.4.17-pre2/fs/super.c	Mon Nov 26 11:52:07 2001
+++ linux-akpm/fs/super.c	Fri Nov 30 21:21:26 2001
@@ -314,7 +314,7 @@ static void put_super(struct super_block
 	__put_super(sb);
 }
 
-static inline void write_super(struct super_block *sb)
+static void write_super(struct super_block *sb)
 {
 	lock_super(sb);
 	if (sb->s_root && sb->s_dirt)
--- linux-2.4.17-pre2/fs/inode.c	Fri Nov 30 14:32:14 2001
+++ linux-akpm/fs/inode.c	Fri Nov 30 21:21:26 2001
@@ -178,7 +178,7 @@ repeat:
 	current->state = TASK_RUNNING;
 }
 
-static inline void wait_on_inode(struct inode *inode)
+static void wait_on_inode(struct inode *inode)
 {
 	if (inode->i_state & I_LOCK)
 		__wait_on_inode(inode);
@@ -191,7 +191,7 @@ static inline void write_inode(struct in
 		inode->i_sb->s_op->write_inode(inode, sync);
 }
 
-static inline void __iget(struct inode * inode)
+static void __iget(struct inode * inode)
 {
 	if (atomic_read(&inode->i_count)) {
 		atomic_inc(&inode->i_count);
@@ -245,7 +245,7 @@ static inline void __sync_one(struct ino
 	wake_up(&inode->i_wait);
 }
 
-static inline void sync_one(struct inode *inode, int sync)
+static void sync_one(struct inode *inode, int sync)
 {
 	if (inode->i_state & I_LOCK) {
 		__iget(inode);
--- linux-2.4.17-pre2/fs/block_dev.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/fs/block_dev.c	Fri Nov 30 21:21:26 2001
@@ -344,7 +344,7 @@ struct block_device *bdget(dev_t dev)
 	return bdev;
 }
 
-static inline void __bd_forget(struct inode *inode)
+static void __bd_forget(struct inode *inode)
 {
 	list_del_init(&inode->i_devices);
 	inode->i_bdev = NULL;
--- linux-2.4.17-pre2/kernel/exit.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/kernel/exit.c	Fri Nov 30 21:21:26 2001
@@ -131,7 +131,7 @@ int is_orphaned_pgrp(int pgrp)
 	return will_become_orphaned_pgrp(pgrp, 0);
 }
 
-static inline int has_stopped_jobs(int pgrp)
+static int has_stopped_jobs(int pgrp)
 {
 	int retval = 0;
 	struct task_struct * p;
@@ -211,7 +211,7 @@ void put_files_struct(struct files_struc
 	}
 }
 
-static inline void __exit_files(struct task_struct *tsk)
+static void __exit_files(struct task_struct *tsk)
 {
 	struct files_struct * files = tsk->files;
 
@@ -228,7 +228,7 @@ void exit_files(struct task_struct *tsk)
 	__exit_files(tsk);
 }
 
-static inline void __put_fs_struct(struct fs_struct *fs)
+static void __put_fs_struct(struct fs_struct *fs)
 {
 	/* No need to hold fs->lock if we are killing it */
 	if (atomic_dec_and_test(&fs->count)) {
@@ -249,7 +249,7 @@ void put_fs_struct(struct fs_struct *fs)
 	__put_fs_struct(fs);
 }
 
-static inline void __exit_fs(struct task_struct *tsk)
+static void __exit_fs(struct task_struct *tsk)
 {
 	struct fs_struct * fs = tsk->fs;
 
@@ -296,7 +296,7 @@ void end_lazy_tlb(struct mm_struct *mm)
  * Turn us into a lazy TLB process if we
  * aren't already..
  */
-static inline void __exit_mm(struct task_struct * tsk)
+static void __exit_mm(struct task_struct * tsk)
 {
 	struct mm_struct * mm = tsk->mm;
 
--- linux-2.4.17-pre2/kernel/fork.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/kernel/fork.c	Fri Nov 30 21:21:26 2001
@@ -246,7 +246,7 @@ struct mm_struct * mm_alloc(void)
  * is dropped: either by a lazy thread or by
  * mmput. Free the page directory and the mm.
  */
-inline void __mmdrop(struct mm_struct *mm)
+void __mmdrop(struct mm_struct *mm)
 {
 	if (mm == &init_mm) BUG();
 	pgd_free(mm->pgd);
@@ -359,7 +359,7 @@ fail_nomem:
 	return retval;
 }
 
-static inline struct fs_struct *__copy_fs_struct(struct fs_struct *old)
+static struct fs_struct *__copy_fs_struct(struct fs_struct *old)
 {
 	struct fs_struct *fs = kmem_cache_alloc(fs_cachep, GFP_KERNEL);
 	/* We don't need to lock fs - think why ;-) */
--- linux-2.4.17-pre2/kernel/module.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/kernel/module.c	Fri Nov 30 21:21:26 2001
@@ -254,7 +254,7 @@ void __init init_modules(void)
  * Copy the name of a module from user space.
  */
 
-static inline long
+static long
 get_mod_name(const char *user_name, char **buf)
 {
 	unsigned long page;
--- linux-2.4.17-pre2/kernel/sched.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/kernel/sched.c	Fri Nov 30 21:21:26 2001
@@ -333,7 +333,7 @@ static inline void move_first_runqueue(s
  * "current->state = TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
  */
-static inline int try_to_wake_up(struct task_struct * p, int synchronous)
+static int try_to_wake_up(struct task_struct * p, int synchronous)
 {
 	unsigned long flags;
 	int success = 0;
@@ -449,7 +449,7 @@ signed long schedule_timeout(signed long
  * cleans up all remaining scheduler things, without impacting the
  * common case.
  */
-static inline void __schedule_tail(struct task_struct *prev)
+static void __schedule_tail(struct task_struct *prev)
 {
 #ifdef CONFIG_SMP
 	int policy;
@@ -698,7 +698,7 @@ same_process:
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns zero
  * in this (rare) case, and we handle it by contonuing to scan the queue.
  */
-static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
+static void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
 			 	     int nr_exclusive, const int sync)
 {
 	struct list_head *tmp;
--- linux-2.4.17-pre2/kernel/signal.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/kernel/signal.c	Fri Nov 30 21:21:26 2001
@@ -630,8 +630,7 @@ kill_sl_info(int sig, struct siginfo *in
 	return retval;
 }
 
-inline int
-kill_proc_info(int sig, struct siginfo *info, pid_t pid)
+int kill_proc_info(int sig, struct siginfo *info, pid_t pid)
 {
 	int error;
 	struct task_struct *p;
--- linux-2.4.17-pre2/kernel/sys.c	Tue Sep 18 14:10:43 2001
+++ linux-akpm/kernel/sys.c	Fri Nov 30 21:21:26 2001
@@ -473,7 +473,7 @@ asmlinkage long sys_setgid(gid_t gid)
  * files..
  * Thanks to Olaf Kirch and Peter Benie for spotting this.
  */
-static inline void cap_emulate_setxuid(int old_ruid, int old_euid, 
+static void cap_emulate_setxuid(int old_ruid, int old_euid, 
 				       int old_suid)
 {
 	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
--- linux-2.4.17-pre2/kernel/timer.c	Mon Oct  8 10:41:41 2001
+++ linux-akpm/kernel/timer.c	Fri Nov 30 21:21:26 2001
@@ -119,7 +119,7 @@ void init_timervecs (void)
 
 static unsigned long timer_jiffies;
 
-static inline void internal_add_timer(struct timer_list *timer)
+static void internal_add_timer(struct timer_list *timer)
 {
 	/*
 	 * must be cli-ed when calling this
--- linux-2.4.17-pre2/mm/filemap.c	Mon Nov 26 11:52:07 2001
+++ linux-akpm/mm/filemap.c	Fri Nov 30 21:21:26 2001
@@ -670,7 +670,7 @@ void add_to_page_cache_locked(struct pag
  * This adds a page to the page cache, starting out as locked,
  * owned by us, but unreferenced, not uptodate and with no errors.
  */
-static inline void __add_to_page_cache(struct page * page,
+static void __add_to_page_cache(struct page * page,
 	struct address_space *mapping, unsigned long offset,
 	struct page **hash)
 {
@@ -2220,7 +2220,7 @@ out:
 	return error;
 }
 
-static inline void setup_read_behavior(struct vm_area_struct * vma,
+static void setup_read_behavior(struct vm_area_struct * vma,
 	int behavior)
 {
 	VM_ClearReadHint(vma);
--- linux-2.4.17-pre2/mm/highmem.c	Mon Oct 22 15:01:57 2001
+++ linux-akpm/mm/highmem.c	Fri Nov 30 21:21:26 2001
@@ -233,7 +233,7 @@ static inline void copy_to_high_bh_irq (
 	__restore_flags(flags);
 }
 
-static inline void bounce_end_io (struct buffer_head *bh, int uptodate)
+static void bounce_end_io (struct buffer_head *bh, int uptodate)
 {
 	struct page *page;
 	struct buffer_head *bh_orig = (struct buffer_head *)(bh->b_private);
--- linux-2.4.17-pre2/mm/memory.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/mm/memory.c	Fri Nov 30 21:21:26 2001
@@ -864,7 +864,7 @@ int remap_page_range(unsigned long from,
  *
  * We hold the mm semaphore for reading and vma->vm_mm->page_table_lock
  */
-static inline void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
+static void establish_pte(struct vm_area_struct * vma, unsigned long address, pte_t *page_table, pte_t entry)
 {
 	set_pte(page_table, entry);
 	flush_tlb_page(vma, address);
--- linux-2.4.17-pre2/mm/mmap.c	Mon Nov  5 21:01:12 2001
+++ linux-akpm/mm/mmap.c	Fri Nov 30 21:21:26 2001
@@ -107,7 +107,7 @@ static inline void __remove_shared_vm_st
 	}
 }
 
-static inline void remove_shared_vm_struct(struct vm_area_struct *vma)
+static void remove_shared_vm_struct(struct vm_area_struct *vma)
 {
 	lock_vma_mappings(vma);
 	__remove_shared_vm_struct(vma);
@@ -333,7 +333,7 @@ static void __vma_link(struct mm_struct 
 	__vma_link_file(vma);
 }
 
-static inline void vma_link(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev,
+static void vma_link(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev,
 			    rb_node_t ** rb_link, rb_node_t * rb_parent)
 {
 	lock_vma_mappings(vma);
--- linux-2.4.17-pre2/mm/slab.c	Fri Nov 30 14:32:15 2001
+++ linux-akpm/mm/slab.c	Fri Nov 30 21:21:26 2001
@@ -521,7 +521,7 @@ static inline void kmem_freepages (kmem_
 }
 
 #if DEBUG
-static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
+static void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	if (cachep->flags & SLAB_RED_ZONE) {
@@ -532,7 +532,7 @@ static inline void kmem_poison_obj (kmem
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
-static inline int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
+static int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	void *end;
@@ -1219,7 +1219,7 @@ static inline void kmem_cache_alloc_head
 	}
 }
 
-static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
+static void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
 						slab_t *slabp)
 {
 	void *objp;
@@ -1316,7 +1316,7 @@ void* kmem_cache_alloc_batch(kmem_cache_
 }
 #endif
 
-static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
+static void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
 {
 	unsigned long save_flags;
 	void* objp;
@@ -1392,7 +1392,7 @@ alloc_new_slab_nolock:
 # define CHECK_PAGE(pg)	do { } while (0)
 #endif
 
-static inline void kmem_cache_free_one(kmem_cache_t *cachep, void *objp)
+static void kmem_cache_free_one(kmem_cache_t *cachep, void *objp)
 {
 	slab_t* slabp;
 
@@ -1452,7 +1452,7 @@ static inline void kmem_cache_free_one(k
 }
 
 #ifdef CONFIG_SMP
-static inline void __free_block (kmem_cache_t* cachep,
+static void __free_block (kmem_cache_t* cachep,
 							void** objpp, int len)
 {
 	for ( ; len > 0; len--, objpp++)
@@ -1471,7 +1471,7 @@ static void free_block (kmem_cache_t* ca
  * __kmem_cache_free
  * called with disabled ints
  */
-static inline void __kmem_cache_free (kmem_cache_t *cachep, void* objp)
+static void __kmem_cache_free (kmem_cache_t *cachep, void* objp)
 {
 #ifdef CONFIG_SMP
 	cpucache_t *cc = cc_data(cachep);
--- linux-2.4.17-pre2/drivers/block/ll_rw_blk.c	Mon Nov  5 21:01:11 2001
+++ linux-akpm/drivers/block/ll_rw_blk.c	Fri Nov 30 21:21:26 2001
@@ -420,7 +420,7 @@ void blk_init_queue(request_queue_t * q,
  * Get a free request. io_request_lock must be held and interrupts
  * disabled on the way in.
  */
-static inline struct request *get_request(request_queue_t *q, int rw)
+static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = q->rq + rw;
@@ -460,18 +460,6 @@ static struct request *__get_request_wai
 	return rq;
 }
 
-static inline struct request *get_request_wait(request_queue_t *q, int rw)
-{
-	register struct request *rq;
-
-	spin_lock_irq(&io_request_lock);
-	rq = get_request(q, rw);
-	spin_unlock_irq(&io_request_lock);
-	if (rq)
-		return rq;
-	return __get_request_wait(q, rw);
-}
-
 /* RO fail safe mechanism */
 
 static long ro_bits[MAX_BLKDEV][8];
@@ -497,7 +485,7 @@ void set_device_ro(kdev_t dev,int flag)
 	else ro_bits[major][minor >> 5] &= ~(1 << (minor & 31));
 }
 
-inline void drive_stat_acct (kdev_t dev, int rw,
+void drive_stat_acct (kdev_t dev, int rw,
 				unsigned long nr_sectors, int new_io)
 {
 	unsigned int major = MAJOR(dev);
@@ -546,7 +534,7 @@ static inline void add_request(request_q
 /*
  * Must be called with io_request_lock held and interrupts disabled
  */
-inline void blkdev_release_request(struct request *req)
+void blkdev_release_request(struct request *req)
 {
 	request_queue_t *q = req->q;
 	int rw = req->cmd;
--- linux-2.4.17-pre2/lib/rwsem.c	Tue Jul 10 20:08:51 2001
+++ linux-akpm/lib/rwsem.c	Fri Nov 30 21:21:26 2001
@@ -35,7 +35,7 @@ void rwsemtrace(struct rw_semaphore *sem
  * - the spinlock must be held by the caller
  * - woken process blocks are discarded from the list after having flags zeroised
  */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
+static struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter *waiter;
 	struct list_head *next;
@@ -110,7 +110,7 @@ static inline struct rw_semaphore *__rws
 /*
  * wait for a lock to be granted
  */
-static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
+static struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
 								 struct rwsem_waiter *waiter,
 								 signed long adjustment)
 {
--- linux-2.4.17-pre2/include/linux/fs_struct.h	Fri Jul 13 15:10:44 2001
+++ linux-akpm/include/linux/fs_struct.h	Fri Nov 30 21:21:26 2001
@@ -17,55 +17,10 @@ struct fs_struct {
 	NULL, NULL, NULL, NULL, NULL, NULL \
 }
 
-extern void exit_fs(struct task_struct *);
-extern void set_fs_altroot(void);
-
-/*
- * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
- * It can block. Requires the big lock held.
- */
-
-static inline void set_fs_root(struct fs_struct *fs,
-	struct vfsmount *mnt,
-	struct dentry *dentry)
-{
-	struct dentry *old_root;
-	struct vfsmount *old_rootmnt;
-	write_lock(&fs->lock);
-	old_root = fs->root;
-	old_rootmnt = fs->rootmnt;
-	fs->rootmnt = mntget(mnt);
-	fs->root = dget(dentry);
-	write_unlock(&fs->lock);
-	if (old_root) {
-		dput(old_root);
-		mntput(old_rootmnt);
-	}
-}
-
-/*
- * Replace the fs->{pwdmnt,pwd} with {mnt,dentry}. Put the old values.
- * It can block. Requires the big lock held.
- */
-
-static inline void set_fs_pwd(struct fs_struct *fs,
-	struct vfsmount *mnt,
-	struct dentry *dentry)
-{
-	struct dentry *old_pwd;
-	struct vfsmount *old_pwdmnt;
-	write_lock(&fs->lock);
-	old_pwd = fs->pwd;
-	old_pwdmnt = fs->pwdmnt;
-	fs->pwdmnt = mntget(mnt);
-	fs->pwd = dget(dentry);
-	write_unlock(&fs->lock);
-	if (old_pwd) {
-		dput(old_pwd);
-		mntput(old_pwdmnt);
-	}
-}
-
+void exit_fs(struct task_struct *);
+void set_fs_altroot(void);
+void set_fs_root(struct fs_struct *fs, struct vfsmount *mnt, struct dentry *dentry);
+void set_fs_pwd(struct fs_struct *fs, struct vfsmount *mnt, struct dentry *dentry);
 struct fs_struct *copy_fs_struct(struct fs_struct *old);
 void put_fs_struct(struct fs_struct *fs);
 
--- linux-2.4.17-pre2/fs/namespace.c	Fri Nov 30 14:32:14 2001
+++ linux-akpm/fs/namespace.c	Fri Nov 30 21:21:26 2001
@@ -398,6 +398,48 @@ out:
 }
 
 /*
+ * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
+ * It can block. Requires the big lock held.
+ */
+void set_fs_root(struct fs_struct *fs, struct vfsmount *mnt,
+			struct dentry *dentry)
+{
+	struct dentry *old_root;
+	struct vfsmount *old_rootmnt;
+	write_lock(&fs->lock);
+	old_root = fs->root;
+	old_rootmnt = fs->rootmnt;
+	fs->rootmnt = mntget(mnt);
+	fs->root = dget(dentry);
+	write_unlock(&fs->lock);
+	if (old_root) {
+		dput(old_root);
+		mntput(old_rootmnt);
+	}
+}
+
+/*
+ * Replace the fs->{pwdmnt,pwd} with {mnt,dentry}. Put the old values.
+ * It can block. Requires the big lock held.
+ */
+void set_fs_pwd(struct fs_struct *fs, struct vfsmount *mnt,
+			struct dentry *dentry)
+{
+	struct dentry *old_pwd;
+	struct vfsmount *old_pwdmnt;
+	write_lock(&fs->lock);
+	old_pwd = fs->pwd;
+	old_pwdmnt = fs->pwdmnt;
+	fs->pwdmnt = mntget(mnt);
+	fs->pwd = dget(dentry);
+	write_unlock(&fs->lock);
+	if (old_pwd) {
+		dput(old_pwd);
+		mntput(old_pwdmnt);
+	}
+}
+
+/*
  *	The 2.0 compatible umount. No flags. 
  */
