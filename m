Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317447AbSFLKub>; Wed, 12 Jun 2002 06:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSFLKua>; Wed, 12 Jun 2002 06:50:30 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35339 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317447AbSFLKuT>; Wed, 12 Jun 2002 06:50:19 -0400
Message-ID: <3D072767.7030300@evision-ventures.com>
Date: Wed, 12 Jun 2002 12:50:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 inline abuse...
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060008060004060407080409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008060004060407080409
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch is trying to address the most obvious
abuses or inadequacies in the usage of the inline attribute
to functions. Many of the remaining usages should be removed
as well since apparently GCC got really good at figuring out
on its own whatever it makes sense to inline a function or not.

Since the patch isn't very big I didn't bother to split
it up in to a series of "micropatches".
However if you "insist" I could provide this.

And well here are the "before/after" diet images:


wto cze 11 10:56:03 CEST 2002

Size before:

[root@kozaczek linux]# size vmlinux
    text    data     bss     dec     hex filename
1482859  249992  255852 1988703  1e585f vmlinux

    text    data     bss     dec     hex filename
1476379  249992  255852 1982223  1e3f0f vmlinux

No question it's worth it. The above numbers should
be higher with older GCC version, which where not that
eager to inline functions on they own.

--------------060008060004060407080409
Content-Type: text/plain;
 name="inline-2.5.21.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inline-2.5.21.diff"

diff -urN linux-2.5.21/drivers/block/elevator.c linux/drivers/block/elevator.c
--- linux-2.5.21/drivers/block/elevator.c	2002-06-09 07:31:17.000000000 +0200
+++ linux/drivers/block/elevator.c	2002-06-12 12:13:53.000000000 +0200
@@ -378,18 +378,36 @@
 		e->elevator_merge_req_fn(rq, next);
 }
 
-/*
- * add_request and next_request are required to be supported, naturally
- */
-void __elv_add_request(request_queue_t *q, struct request *rq,
-			  struct list_head *insert_here)
+struct request *elv_next_request(request_queue_t *q)
 {
-	q->elevator.elevator_add_req_fn(q, rq, insert_here);
-}
+	struct request *rq;
 
-struct request *__elv_next_request(request_queue_t *q)
-{
-	return q->elevator.elevator_next_req_fn(q);
+	while ((rq = q->elevator.elevator_next_req_fn(q))) {
+		rq->flags |= REQ_STARTED;
+
+		if (&rq->queuelist == q->last_merge)
+			q->last_merge = NULL;
+
+		if ((rq->flags & REQ_DONTPREP) || !q->prep_rq_fn)
+			break;
+
+		/*
+		 * all ok, break and return it
+		 */
+		if (!q->prep_rq_fn(q, rq))
+			break;
+
+		/*
+		 * prep said no-go, kill it
+		 */
+		blkdev_dequeue_request(rq);
+		if (end_that_request_first(rq, 0, rq->nr_sectors))
+			BUG();
+
+		end_that_request_last(rq);
+	}
+
+	return rq;
 }
 
 void elv_remove_request(request_queue_t *q, struct request *rq)
@@ -421,6 +439,5 @@
 EXPORT_SYMBOL(elevator_linus);
 EXPORT_SYMBOL(elevator_noop);
 
-EXPORT_SYMBOL(__elv_add_request);
-EXPORT_SYMBOL(__elv_next_request);
+EXPORT_SYMBOL(elv_next_request);
 EXPORT_SYMBOL(elv_remove_request);
diff -urN linux-2.5.21/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.21/drivers/block/ll_rw_blk.c	2002-06-09 07:27:22.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-06-12 12:15:54.000000000 +0200
@@ -1110,7 +1110,7 @@
  * Get a free request. queue lock must be held and interrupts
  * disabled on the way in.
  */
-static inline struct request *get_request(request_queue_t *q, int rw)
+static struct request *get_request(request_queue_t *q, int rw)
 {
 	struct request *rq = NULL;
 	struct request_list *rl = q->rq + rw;
@@ -1233,16 +1233,15 @@
  * queue lock is held and interrupts disabled, as we muck with the
  * request queue list.
  */
-static inline void add_request(request_queue_t * q, struct request * req,
+static inline void add_request(request_queue_t * q, struct request * rq,
 			       struct list_head *insert_here)
 {
-	drive_stat_acct(req, req->nr_sectors, 1);
+	drive_stat_acct(rq, rq->nr_sectors, 1);
 
-	/*
-	 * elevator indicated where it wants this request to be
-	 * inserted at elevator_merge time
+	/* Elevator indicated where it wants this request to be
+	 * inserted at elevator_merge time.
 	 */
-	__elv_add_request(q, req, insert_here);
+	q->elevator.elevator_add_req_fn(q, rq, insert_here);
 }
 
 /*
@@ -1816,7 +1815,7 @@
 extern int stram_device_init (void);
 #endif
 
-inline void blk_recalc_rq_segments(struct request *rq)
+void blk_recalc_rq_segments(struct request *rq)
 {
 	struct bio *bio;
 	int nr_phys_segs, nr_hw_segs;
@@ -1836,7 +1835,7 @@
 	rq->nr_hw_segments = nr_hw_segs;
 }
 
-inline void blk_recalc_rq_sectors(struct request *rq, int nsect)
+void blk_recalc_rq_sectors(struct request *rq, int nsect)
 {
 	if (rq->flags & REQ_CMD) {
 		rq->hard_sector += nsect;
diff -urN linux-2.5.21/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux-2.5.21/fs/binfmt_elf.c	2002-06-09 07:29:40.000000000 +0200
+++ linux/fs/binfmt_elf.c	2002-06-12 09:31:44.000000000 +0200
@@ -44,8 +44,8 @@
 
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
-static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
-extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
+static unsigned long elf_map(struct file *, unsigned long, struct elf_phdr *, int, int);
+extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
 extern void dump_thread(struct pt_regs *, struct user *);
 
 #ifndef elf_addr_t
@@ -241,9 +241,8 @@
 }
 
 #ifndef elf_map
-
-static inline unsigned long
-elf_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+static unsigned long
+elf_map(struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
 {
 	unsigned long map_addr;
 
@@ -254,8 +253,7 @@
 	up_write(&current->mm->mmap_sem);
 	return(map_addr);
 }
-
-#endif /* !elf_map */
+#endif
 
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
@@ -319,11 +317,11 @@
 	    if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
 	    vaddr = eppnt->p_vaddr;
 	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
-	    	elf_type |= MAP_FIXED;
+		elf_type |= MAP_FIXED;
 
 	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
 	    if (BAD_ADDR(map_addr))
-	    	goto out_close;
+		goto out_close;
 
 	    if (!load_addr_set && interp_elf_ex->e_type == ET_DYN) {
 		load_addr = map_addr - ELF_PAGESTART(vaddr);
@@ -917,7 +915,7 @@
  *
  * I think we should skip something. But I am not sure how. H.J.
  */
-static inline int maydump(struct vm_area_struct *vma)
+static int maydump(struct vm_area_struct *vma)
 {
 	/*
 	 * If we may not read the contents, don't allow us to dump
diff -urN linux-2.5.21/fs/block_dev.c linux/fs/block_dev.c
--- linux-2.5.21/fs/block_dev.c	2002-06-09 07:30:05.000000000 +0200
+++ linux/fs/block_dev.c	2002-06-12 10:21:12.000000000 +0200
@@ -347,7 +347,7 @@
 	return bdev;
 }
 
-static inline void __bd_forget(struct inode *inode)
+static void __bd_forget(struct inode *inode)
 {
 	list_del_init(&inode->i_devices);
 	inode->i_bdev = NULL;
diff -urN linux-2.5.21/fs/dcache.c linux/fs/dcache.c
--- linux-2.5.21/fs/dcache.c	2002-06-09 07:27:28.000000000 +0200
+++ linux/fs/dcache.c	2002-06-12 09:35:20.000000000 +0200
@@ -54,7 +54,7 @@
 struct dentry_stat_t dentry_stat = {0, 0, 45, 0,};
 
 /* no dcache_lock, please */
-static inline void d_free(struct dentry *dentry)
+static void d_free(struct dentry *dentry)
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
@@ -69,7 +69,7 @@
  * d_iput() operation if defined.
  * Called with dcache_lock held, drops it.
  */
-static inline void dentry_iput(struct dentry * dentry)
+static void dentry_iput(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
@@ -213,7 +213,7 @@
 
 /* This should be called _only_ with dcache_lock held */
 
-static inline struct dentry * __dget_locked(struct dentry *dentry)
+static struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
 	if (atomic_read(&dentry->d_count) == 1) {
@@ -298,7 +298,7 @@
  * removed.
  * Called with dcache_lock, drops it and then regains.
  */
-static inline void prune_one_dentry(struct dentry * dentry)
+static void prune_one_dentry(struct dentry * dentry)
 {
 	struct dentry * parent;
 
@@ -717,7 +717,7 @@
 	return res;
 }
 
-static inline struct list_head * d_hash(struct dentry * parent, unsigned long hash)
+static struct list_head * d_hash(struct dentry * parent, unsigned long hash)
 {
 	hash += (unsigned long) parent / L1_CACHE_BYTES;
 	hash = hash ^ (hash >> D_HASHBITS);
@@ -1006,7 +1006,7 @@
  * then no longer matches the actual (corrupted) string of the target.
  * The hash value has to match the hash queue that the dentry is on..
  */
-static inline void switch_names(struct dentry * dentry, struct dentry * target)
+static void switch_names(struct dentry * dentry, struct dentry * target)
 {
 	const unsigned char *old_name, *new_name;
 
diff -urN linux-2.5.21/fs/locks.c linux/fs/locks.c
--- linux-2.5.21/fs/locks.c	2002-06-09 07:29:12.000000000 +0200
+++ linux/fs/locks.c	2002-06-12 09:39:52.000000000 +0200
@@ -153,7 +153,7 @@
 }
 
 /* Free a lock which is not in use. */
-static inline void locks_free_lock(struct file_lock *fl)
+static void locks_free_lock(struct file_lock *fl)
 {
 	if (fl == NULL) {
 		BUG();
@@ -501,7 +501,7 @@
  * notify the FS that the lock has been cleared and
  * finally free the lock.
  */
-static inline void _delete_lock(struct file_lock *fl)
+static void _delete_lock(struct file_lock *fl)
 {
 	fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
 	if (fl->fl_fasync != NULL){
diff -urN linux-2.5.21/fs/namei.c linux/fs/namei.c
--- linux-2.5.21/fs/namei.c	2002-06-09 07:28:50.000000000 +0200
+++ linux/fs/namei.c	2002-06-12 11:10:31.000000000 +0200
@@ -280,7 +280,7 @@
 }
 
 /*for fastwalking*/
-static inline void unlock_nd(struct nameidata *nd)
+static void unlock_nd(struct nameidata *nd)
 {
 	struct vfsmount *mnt = nd->old_mnt;
 	struct dentry *dentry = nd->old_dentry;
@@ -293,7 +293,7 @@
 	mntput(mnt);
 }
 
-static inline void lock_nd(struct nameidata *nd)
+static void lock_nd(struct nameidata *nd)
 {
 	spin_lock(&dcache_lock);
 	nd->old_mnt = nd->mnt;
@@ -391,7 +391,7 @@
  * Without that kind of total limit, nasty chains of consecutive
  * symlinks can cause almost arbitrarily long lookups. 
  */
-static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int do_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	int err;
 	if (current->link_count >= 5)
@@ -399,7 +399,7 @@
 	if (current->total_link_count >= 40)
 		goto loop;
 	if (need_resched()) {
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		schedule();
 	}
 	current->link_count++;
@@ -447,7 +447,7 @@
 	return res;
 }
 
-static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
+int follow_down(struct vfsmount **mnt, struct dentry **dentry)
 {
 	struct vfsmount *mounted;
 
@@ -465,12 +465,7 @@
 	return 0;
 }
 
-int follow_down(struct vfsmount **mnt, struct dentry **dentry)
-{
-	return __follow_down(mnt,dentry);
-}
- 
-static inline void follow_dotdot(struct vfsmount **mnt, struct dentry **dentry)
+static void follow_dotdot(struct vfsmount **mnt, struct dentry **dentry)
 {
 	while(1) {
 		struct vfsmount *parent;
@@ -818,9 +813,56 @@
 	}
 }
 
+/*
+ * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
+ * It can block. Requires the big lock held.
+ */
+void set_fs_root(struct fs_struct *fs,
+	struct vfsmount *mnt,
+	struct dentry *dentry)
+{
+	struct dentry *old_root;
+	struct vfsmount *old_rootmnt;
+	write_lock(&fs->lock);
+	spin_lock(&dcache_lock);
+	old_root = fs->root;
+	old_rootmnt = fs->rootmnt;
+	fs->rootmnt = mntget(mnt);
+	fs->root = dget(dentry);
+	spin_unlock(&dcache_lock);
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
+void set_fs_pwd(struct fs_struct *fs,
+	struct vfsmount *mnt,
+	struct dentry *dentry)
+{
+	struct dentry *old_pwd;
+	struct vfsmount *old_pwdmnt;
+	write_lock(&fs->lock);
+	spin_lock(&dcache_lock);
+	old_pwd = fs->pwd;
+	old_pwdmnt = fs->pwdmnt;
+	fs->pwdmnt = mntget(mnt);
+	fs->pwd = dget(dentry);
+	spin_unlock(&dcache_lock);
+	write_unlock(&fs->lock);
+	if (old_pwd) {
+		dput(old_pwd);
+		mntput(old_pwdmnt);
+	}
+}
+
 /* SMP-safe */
-static inline int
-walk_init_root(const char *name, struct nameidata *nd)
+static int walk_init_root(const char *name, struct nameidata *nd)
 {
 	read_lock(&current->fs->lock);
 	if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
@@ -977,10 +1019,10 @@
 }
 
 /*
- * It's inline, so penalty for filesystems that don't use sticky bit is
- * minimal.
+ * It is no longer inline, since GCC got really good at what's really worth
+ * inlining.
  */
-static inline int check_sticky(struct inode *dir, struct inode *inode)
+static int check_sticky(struct inode *dir, struct inode *inode)
 {
 	if (!(dir->i_mode & S_ISVTX))
 		return 0;
@@ -992,7 +1034,7 @@
 }
 
 /*
- *	Check whether we can remove a link victim from directory dir, check
+ *  Check whether we can remove a link victim from directory dir, check
  *  whether the type of victim is right.
  *  1. We can't do it if dir is read-only (done in permission())
  *  2. We should have write and exec permissions on dir
@@ -1008,7 +1050,7 @@
  *  8. If we were asked to remove a non-directory and victim isn't one - EISDIR.
  *  9. We can't remove a root or mountpoint.
  */
-static inline int may_delete(struct inode *dir,struct dentry *victim, int isdir)
+static int may_delete(struct inode *dir,struct dentry *victim, int isdir)
 {
 	int error;
 	if (!victim->d_inode || victim->d_parent->d_inode != dir)
@@ -1033,7 +1075,7 @@
 	return 0;
 }
 
-/*	Check whether we can create an object with dentry child in directory
+/*  Check whether we can create an object with dentry child in directory
  *  dir.
  *  1. We can't do it if child already exists (open has special treatment for
  *     this case, but since we are inlined it's OK)
@@ -1041,7 +1083,7 @@
  *  3. We should have write and exec permissions on dir
  *  4. We can't do it if dir is immutable (done in permission())
  */
-static inline int may_create(struct inode *dir, struct dentry *child) {
+static int may_create(struct inode *dir, struct dentry *child) {
 	if (child->d_inode)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
@@ -1061,10 +1103,10 @@
 
 	if (f & O_NOFOLLOW)
 		retval &= ~LOOKUP_FOLLOW;
-	
+
 	if ((f & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL))
 		retval &= ~LOOKUP_FOLLOW;
-	
+
 	if (f & O_DIRECTORY)
 		retval |= LOOKUP_DIRECTORY;
 
@@ -1298,7 +1340,7 @@
 		error = -ELOOP;
 		if (flag & O_NOFOLLOW)
 			goto exit_dput;
-		while (__follow_down(&nd->mnt,&dentry) && d_mountpoint(dentry));
+		while (follow_down(&nd->mnt,&dentry) && d_mountpoint(dentry));
 	}
 	error = -ENOENT;
 	if (!dentry->d_inode)
@@ -1937,7 +1979,7 @@
 	return error;
 }
 
-static inline int do_rename(const char * oldname, const char * newname)
+static int do_rename(const char * oldname, const char * newname)
 {
 	int error = 0;
 	struct dentry * old_dir, * new_dir;
@@ -2049,8 +2091,7 @@
 	return len;
 }
 
-static inline int
-__vfs_follow_link(struct nameidata *nd, const char *link)
+int vfs_follow_link(struct nameidata *nd, const char *link)
 {
 	int res = 0;
 	char *name;
@@ -2084,11 +2125,6 @@
 	return PTR_ERR(link);
 }
 
-int vfs_follow_link(struct nameidata *nd, const char *link)
-{
-	return __vfs_follow_link(nd, link);
-}
-
 /* get the link contents into pagecache */
 static char *page_getlink(struct dentry * dentry, struct page **ppage)
 {
@@ -2128,7 +2164,7 @@
 {
 	struct page *page = NULL;
 	char *s = page_getlink(dentry, &page);
-	int res = __vfs_follow_link(nd, s);
+	int res = vfs_follow_link(nd, s);
 	if (page) {
 		kunmap(page);
 		page_cache_release(page);
diff -urN linux-2.5.21/fs/open.c linux/fs/open.c
--- linux-2.5.21/fs/open.c	2002-06-09 07:26:54.000000000 +0200
+++ linux/fs/open.c	2002-06-12 10:15:01.000000000 +0200
@@ -90,7 +90,7 @@
 	return err;
 }
 
-static inline long do_sys_truncate(const char * path, loff_t length)
+static long do_sys_truncate(const char * path, loff_t length)
 {
 	struct nameidata nd;
 	struct inode * inode;
@@ -156,7 +156,7 @@
 	return do_sys_truncate(path, (long)length);
 }
 
-static inline long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+static long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 {
 	struct inode * inode;
 	struct dentry *dentry;
diff -urN linux-2.5.21/fs/seq_file.c linux/fs/seq_file.c
--- linux-2.5.21/fs/seq_file.c	2002-06-09 07:30:56.000000000 +0200
+++ linux/fs/seq_file.c	2002-06-12 11:58:16.000000000 +0200
@@ -276,6 +276,18 @@
         return 0;
 }
 
+int seq_puts(struct seq_file *m, const char *s)
+{
+	int len = strlen(s);
+	if (m->count + len < m->size) {
+		memcpy(m->buf + m->count, s, len);
+		m->count += len;
+		return 0;
+	}
+	m->count = m->size;
+	return -1;
+}
+
 int seq_printf(struct seq_file *m, const char *f, ...)
 {
 	va_list args;
diff -urN linux-2.5.21/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.5.21/include/linux/blk.h	2002-06-09 07:28:39.000000000 +0200
+++ linux/include/linux/blk.h	2002-06-12 12:13:46.000000000 +0200
@@ -49,38 +49,6 @@
 		elv_remove_request(req->q, req);
 }
 
-extern inline struct request *elv_next_request(request_queue_t *q)
-{
-	struct request *rq;
-
-	while ((rq = __elv_next_request(q))) {
-		rq->flags |= REQ_STARTED;
-
-		if (&rq->queuelist == q->last_merge)
-			q->last_merge = NULL;
-
-		if ((rq->flags & REQ_DONTPREP) || !q->prep_rq_fn)
-			break;
-
-		/*
-		 * all ok, break and return it
-		 */
-		if (!q->prep_rq_fn(q, rq))
-			break;
-
-		/*
-		 * prep said no-go, kill it
-		 */
-		blkdev_dequeue_request(rq);
-		if (end_that_request_first(rq, 0, rq->nr_sectors))
-			BUG();
-
-		end_that_request_last(rq);
-	}
-
-	return rq;
-}
-
 #define _elv_add_request_core(q, rq, where, plug)			\
 	do {								\
 		if ((plug))						\
@@ -96,7 +64,7 @@
 } while (0)
 
 #define elv_add_request(q, rq, back) _elv_add_request((q), (rq), (back), 1)
-	
+
 #if defined(MAJOR_NR) || defined(IDE_DRIVER)
 
 /*
diff -urN linux-2.5.21/include/linux/elevator.h linux/include/linux/elevator.h
--- linux-2.5.21/include/linux/elevator.h	2002-06-09 07:26:51.000000000 +0200
+++ linux/include/linux/elevator.h	2002-06-12 12:13:49.000000000 +0200
@@ -38,9 +38,7 @@
 /*
  * block elevator interface
  */
-extern void __elv_add_request(request_queue_t *, struct request *,
-			      struct list_head *);
-extern struct request *__elv_next_request(request_queue_t *);
+extern struct request *elv_next_request(request_queue_t *);
 extern void elv_merge_cleanup(request_queue_t *, struct request *, int);
 extern int elv_merge(request_queue_t *, struct request **, struct bio *);
 extern void elv_merge_requests(request_queue_t *, struct request *,
diff -urN linux-2.5.21/include/linux/fs_struct.h linux/include/linux/fs_struct.h
--- linux-2.5.21/include/linux/fs_struct.h	2002-06-09 07:27:40.000000000 +0200
+++ linux/include/linux/fs_struct.h	2002-06-12 11:10:33.000000000 +0200
@@ -22,56 +22,8 @@
 
 extern void exit_fs(struct task_struct *);
 extern void set_fs_altroot(void);
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
-	spin_lock(&dcache_lock);
-	old_root = fs->root;
-	old_rootmnt = fs->rootmnt;
-	fs->rootmnt = mntget(mnt);
-	fs->root = dget(dentry);
-	spin_unlock(&dcache_lock);
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
-	spin_lock(&dcache_lock);
-	old_pwd = fs->pwd;
-	old_pwdmnt = fs->pwdmnt;
-	fs->pwdmnt = mntget(mnt);
-	fs->pwd = dget(dentry);
-	spin_unlock(&dcache_lock);
-	write_unlock(&fs->lock);
-	if (old_pwd) {
-		dput(old_pwd);
-		mntput(old_pwdmnt);
-	}
-}
+extern void set_fs_root(struct fs_struct *, struct vfsmount *, struct dentry *);
+extern void set_fs_pwd(struct fs_struct *, struct vfsmount *, struct dentry *);
 
 struct fs_struct *copy_fs_struct(struct fs_struct *old);
 void put_fs_struct(struct fs_struct *fs);
diff -urN linux-2.5.21/include/linux/quotaops.h linux/include/linux/quotaops.h
--- linux-2.5.21/include/linux/quotaops.h	2002-06-09 07:28:19.000000000 +0200
+++ linux/include/linux/quotaops.h	2002-06-12 12:25:08.000000000 +0200
@@ -190,7 +190,7 @@
 #define DQUOT_SYNC(sb)				do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
-extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	inode_add_bytes(inode, nr);
@@ -198,14 +198,14 @@
 	return 0;
 }
 
-extern __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	inode_add_bytes(inode, nr);
@@ -213,21 +213,21 @@
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	inode_sub_bytes(inode, nr);
 	unlock_kernel();
 }
 
-extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
diff -urN linux-2.5.21/include/linux/seq_file.h linux/include/linux/seq_file.h
--- linux-2.5.21/include/linux/seq_file.h	2002-06-09 07:29:53.000000000 +0200
+++ linux/include/linux/seq_file.h	2002-06-12 11:58:06.000000000 +0200
@@ -43,19 +43,8 @@
 	return -1;
 }
 
-static inline int seq_puts(struct seq_file *m, const char *s)
-{
-	int len = strlen(s);
-	if (m->count + len < m->size) {
-		memcpy(m->buf + m->count, s, len);
-		m->count += len;
-		return 0;
-	}
-	m->count = m->size;
-	return -1;
-}
-
-int seq_printf(struct seq_file *, const char *, ...)
+extern int seq_puts(struct seq_file *m, const char *s);
+extern int seq_printf(struct seq_file *, const char *, ...)
 	__attribute__ ((format (printf,2,3)));
 
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
diff -urN linux-2.5.21/kernel/exit.c linux/kernel/exit.c
--- linux-2.5.21/kernel/exit.c	2002-06-09 07:28:48.000000000 +0200
+++ linux/kernel/exit.c	2002-06-12 10:27:22.000000000 +0200
@@ -27,7 +27,7 @@
 
 int getrusage(struct task_struct *, int, struct rusage *);
 
-static inline void __unhash_process(struct task_struct *p)
+void unhash_process(struct task_struct *p)
 {
 	struct dentry *proc_dentry;
 	write_lock_irq(&tasklist_lock);
@@ -72,13 +72,6 @@
 	put_task_struct(p);
 }
 
-/* we are using it only for SMP init */
-
-void unhash_process(struct task_struct *p)
-{
-	return __unhash_process(p);
-}
-
 /*
  * This checks not only the pgrp, but falls back on the pid if no
  * satisfactory pgrp is found. I dunno - gdb doesn't work correctly
@@ -310,7 +303,7 @@
 	}
 }
 
-static inline void __exit_files(struct task_struct *tsk)
+void exit_files(struct task_struct *tsk)
 {
 	struct files_struct * files = tsk->files;
 
@@ -322,12 +315,7 @@
 	}
 }
 
-void exit_files(struct task_struct *tsk)
-{
-	__exit_files(tsk);
-}
-
-static inline void __put_fs_struct(struct fs_struct *fs)
+void put_fs_struct(struct fs_struct *fs)
 {
 	/* No need to hold fs->lock if we are killing it */
 	if (atomic_dec_and_test(&fs->count)) {
@@ -343,12 +331,7 @@
 	}
 }
 
-void put_fs_struct(struct fs_struct *fs)
-{
-	__put_fs_struct(fs);
-}
-
-static inline void __exit_fs(struct task_struct *tsk)
+void exit_fs(struct task_struct *tsk)
 {
 	struct fs_struct * fs = tsk->fs;
 
@@ -356,15 +339,10 @@
 		task_lock(tsk);
 		tsk->fs = NULL;
 		task_unlock(tsk);
-		__put_fs_struct(fs);
+		put_fs_struct(fs);
 	}
 }
 
-void exit_fs(struct task_struct *tsk)
-{
-	__exit_fs(tsk);
-}
-
 /*
  * We can use these to temporarily drop into
  * "lazy TLB" mode and back.
@@ -395,7 +373,7 @@
  * Turn us into a lazy TLB process if we
  * aren't already..
  */
-static inline void __exit_mm(struct task_struct * tsk)
+void exit_mm(struct task_struct * tsk)
 {
 	struct mm_struct * mm = tsk->mm;
 
@@ -412,11 +390,6 @@
 	}
 }
 
-void exit_mm(struct task_struct *tsk)
-{
-	__exit_mm(tsk);
-}
-
 /*
  * Send signals to all our closest relatives so that they know
  * to properly mourn us..
@@ -538,11 +511,11 @@
 
 fake_volatile:
 	acct_process(code);
-	__exit_mm(tsk);
+	exit_mm(tsk);
 
 	sem_exit();
-	__exit_files(tsk);
-	__exit_fs(tsk);
+	exit_files(tsk);
+	exit_fs(tsk);
 	exit_namespace(tsk);
 	exit_sighand(tsk);
 	exit_thread();
diff -urN linux-2.5.21/kernel/fork.c linux/kernel/fork.c
--- linux-2.5.21/kernel/fork.c	2002-06-09 07:27:21.000000000 +0200
+++ linux/kernel/fork.c	2002-06-12 10:30:41.000000000 +0200
@@ -293,7 +293,7 @@
  * is dropped: either by a lazy thread or by
  * mmput. Free the page directory and the mm.
  */
-inline void __mmdrop(struct mm_struct *mm)
+void __mmdrop(struct mm_struct *mm)
 {
 	if (mm == &init_mm) BUG();
 	pgd_free(mm->pgd);
@@ -408,7 +408,7 @@
 	return retval;
 }
 
-static inline struct fs_struct *__copy_fs_struct(struct fs_struct *old)
+struct fs_struct *copy_fs_struct(struct fs_struct *old)
 {
 	struct fs_struct *fs = kmem_cache_alloc(fs_cachep, GFP_KERNEL);
 	/* We don't need to lock fs - think why ;-) */
@@ -433,18 +433,13 @@
 	return fs;
 }
 
-struct fs_struct *copy_fs_struct(struct fs_struct *old)
-{
-	return __copy_fs_struct(old);
-}
-
 static inline int copy_fs(unsigned long clone_flags, struct task_struct * tsk)
 {
 	if (clone_flags & CLONE_FS) {
 		atomic_inc(&current->fs->count);
 		return 0;
 	}
-	tsk->fs = __copy_fs_struct(current->fs);
+	tsk->fs = copy_fs_struct(current->fs);
 	if (!tsk->fs)
 		return -1;
 	return 0;
diff -urN linux-2.5.21/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.21/kernel/ksyms.c	2002-06-09 18:43:30.000000000 +0200
+++ linux/kernel/ksyms.c	2002-06-12 11:58:55.000000000 +0200
@@ -519,6 +519,7 @@
 EXPORT_SYMBOL(daemonize);
 EXPORT_SYMBOL(csum_partial); /* for networking and md */
 EXPORT_SYMBOL(seq_escape);
+EXPORT_SYMBOL(seq_puts);
 EXPORT_SYMBOL(seq_printf);
 EXPORT_SYMBOL(seq_open);
 EXPORT_SYMBOL(seq_release);
diff -urN linux-2.5.21/kernel/module.c linux/kernel/module.c
--- linux-2.5.21/kernel/module.c	2002-06-09 07:27:45.000000000 +0200
+++ linux/kernel/module.c	2002-06-12 10:32:01.000000000 +0200
@@ -256,7 +256,7 @@
  * Copy the name of a module from user space.
  */
 
-static inline long
+static long
 get_mod_name(const char *user_name, char **buf)
 {
 	unsigned long page;
diff -urN linux-2.5.21/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.21/kernel/timer.c	2002-06-09 07:28:28.000000000 +0200
+++ linux/kernel/timer.c	2002-06-12 10:40:30.000000000 +0200
@@ -127,7 +127,7 @@
 
 static unsigned long timer_jiffies;
 
-static inline void internal_add_timer(struct timer_list *timer)
+static void internal_add_timer(struct timer_list *timer)
 {
 	/*
 	 * must be cli-ed when calling this
@@ -197,7 +197,7 @@
 			__builtin_return_address(0));
 }
 
-static inline int detach_timer (struct timer_list *timer)
+static inline int detach_timer(struct timer_list *timer)
 {
 	if (!timer_pending(timer))
 		return 0;
diff -urN linux-2.5.21/lib/rwsem.c linux/lib/rwsem.c
--- linux-2.5.21/lib/rwsem.c	2002-06-09 07:26:50.000000000 +0200
+++ linux/lib/rwsem.c	2002-06-12 11:04:50.000000000 +0200
@@ -35,7 +35,7 @@
  * - the spinlock must be held by the caller
  * - woken process blocks are discarded from the list after having flags zeroised
  */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
+static struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter *waiter;
 	struct list_head *next;
@@ -110,7 +110,7 @@
 /*
  * wait for a lock to be granted
  */
-static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
+static struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
 								 struct rwsem_waiter *waiter,
 								 signed long adjustment)
 {
diff -urN linux-2.5.21/mm/filemap.c linux/mm/filemap.c
--- linux-2.5.21/mm/filemap.c	2002-06-09 07:28:49.000000000 +0200
+++ linux/mm/filemap.c	2002-06-12 10:42:45.000000000 +0200
@@ -1631,7 +1631,7 @@
 	return 0;
 }
 
-static inline void setup_read_behavior(struct vm_area_struct * vma,
+static void setup_read_behavior(struct vm_area_struct * vma,
 	int behavior)
 {
 	VM_ClearReadHint(vma);
diff -urN linux-2.5.21/mm/highmem.c linux/mm/highmem.c
--- linux-2.5.21/mm/highmem.c	2002-06-09 07:26:59.000000000 +0200
+++ linux/mm/highmem.c	2002-06-12 10:46:00.000000000 +0200
@@ -290,7 +290,7 @@
 	}
 }
 
-static inline void bounce_end_io(struct bio *bio, mempool_t *pool)
+static void bounce_end_io(struct bio *bio, mempool_t *pool)
 {
 	struct bio *bio_orig = bio->bi_private;
 	struct bio_vec *bvec, *org_vec;
diff -urN linux-2.5.21/mm/slab.c linux/mm/slab.c
--- linux-2.5.21/mm/slab.c	2002-06-09 07:31:17.000000000 +0200
+++ linux/mm/slab.c	2002-06-12 10:56:07.000000000 +0200
@@ -533,7 +533,7 @@
 }
 
 /* Interface to system's page release. */
-static inline void kmem_freepages (kmem_cache_t *cachep, void *addr)
+static void kmem_freepages(kmem_cache_t *cachep, void *addr)
 {
 	unsigned long i = (1<<cachep->gfporder);
 	struct page *page = virt_to_page(addr);
@@ -551,7 +551,7 @@
 }
 
 #if DEBUG
-static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
+static void kmem_poison_obj(kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	if (cachep->flags & SLAB_RED_ZONE) {
@@ -562,7 +562,7 @@
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
-static inline int kmem_check_poison_obj (kmem_cache_t *cachep, void *addr)
+static int kmem_check_poison_obj(kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	void *end;
@@ -1363,7 +1363,16 @@
 }
 #endif
 
-static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
+
+/**
+ * kmem_cache_alloc - Allocate an object
+ * @cachep: The cache to allocate from.
+ * @flags: See kmalloc().
+ *
+ * Allocate an object from this cache.  The flags are only relevant
+ * if the cache has no available objects.
+ */
+void * kmem_cache_alloc(kmem_cache_t *cachep, int flags)
 {
 	unsigned long save_flags;
 	void* objp;
@@ -1548,19 +1557,6 @@
 }
 
 /**
- * kmem_cache_alloc - Allocate an object
- * @cachep: The cache to allocate from.
- * @flags: See kmalloc().
- *
- * Allocate an object from this cache.  The flags are only relevant
- * if the cache has no available objects.
- */
-void * kmem_cache_alloc (kmem_cache_t *cachep, int flags)
-{
-	return __kmem_cache_alloc(cachep, flags);
-}
-
-/**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
@@ -1588,7 +1584,7 @@
 	for (; csizep->cs_size; csizep++) {
 		if (size > csizep->cs_size)
 			continue;
-		return __kmem_cache_alloc(flags & GFP_DMA ?
+		return kmem_cache_alloc(flags & GFP_DMA ?
 			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
 	}
 	return NULL;

--------------060008060004060407080409--

