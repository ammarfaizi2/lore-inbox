Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVJPQ3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVJPQ3T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 12:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVJPQ3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 12:29:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:28314 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751174AbVJPQ3S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 12:29:18 -0400
Date: Sun, 16 Oct 2005 21:53:07 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051016162306.GA10410@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <87fyr2ape5.fsf@foo.vault.bofh.ru> <87slv23bw5.fsf@foo.vault.bofh.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87slv23bw5.fsf@foo.vault.bofh.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 09:53:14PM +0400, Serge Belyshev wrote:
> 
> >This problem was reproduced on i386 and amd64 with
> >kernels 2.6.14-rc1 .. 2.6.14-rc4-git4
> 
> Caused by this change:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ab2af1f5005069321c5d130f09cce577b03f43ef
> or
> http://tinyurl.com/cyrou
> 
> aka "[PATCH] files: files struct with RCU"

Linus, I don't think this has anything to do with RCU grace periods
like we discussed previously. I measured on my 3.6GHz x86_64 and
found that open()/close() pair on /dev/null takes about 45500
cycles or 12 microseconds. [Does that sound resonable?]. So
assuing 100 HZ, we can't really queue more than 1660 file
structs to free per 2 timer ticks. In fact, I looked at the
filp slabinfo and we were indeed returning file structures
to slab.

I think this is a known issue I was looking at earlier - the
way we do file struct accounting is not very suitable for batched
freeing. For scalability reasons, file accounting was constructor/destructor
based. This meant that nr_files was decremented only when
the object was removed from the slab cache. This is
susceptible to slab fragmentation. With RCU based file structure,
consequent batched freeing and a test program like Serge's,
we just speed this up and end up with a very fragmented slab -

llm22:~ # cat /proc/sys/fs/file-nr
587730  0       758844

At the same time, I see only a 2000+ objects in filp cache.
To verify this theory, I tried the following experimental patch
I had from before and it fixes this problem. However I run
into my old "bad page state" problem that I have been seeing
since 2.6.9-rc2 in that machine. That needs a separate investigation.

Serge, could you please try the following experimental patch
just to see if file counting is indeed the problem. The patch
is definitely *not* meant for inclusion. Yet. Manfred told me
a while ago that global filp counting caused scalability problems
in some benchmarks - something I haven't been able to verify.

Thanks
Dipankar



This patch changes the file counting by removing the filp_count_lock.
Instead we use a separate atomic_t, nr_files, for now and all
accesses to it are through get_nr_files() api. In the sysctl
handler for nr_files, we populate files_stat.nr_files before returning
to user.

Counting files as an when they are created and destroyed (as opposed
to inside slab) allows us to correctly count open files with RCU.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---



diff -puN fs/dcache.c~files-scale-file-counting fs/dcache.c
--- linux-2.6.14-rc1-test/fs/dcache.c~files-scale-file-counting	2005-10-16 14:03:25.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/fs/dcache.c	2005-10-16 14:03:25.000000000 -0700
@@ -1730,7 +1730,7 @@ void __init vfs_caches_init(unsigned lon
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	dcache_init(mempages);
 	inode_init(mempages);
diff -puN fs/file_table.c~files-scale-file-counting fs/file_table.c
--- linux-2.6.14-rc1-test/fs/file_table.c~files-scale-file-counting	2005-10-16 14:03:25.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/fs/file_table.c	2005-10-16 14:07:20.000000000 -0700
@@ -5,6 +5,7 @@
  *  Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/config.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/file.h>
@@ -18,52 +19,67 @@
 #include <linux/mount.h>
 #include <linux/cdev.h>
 #include <linux/fsnotify.h>
+#include <linux/sysctl.h>
+#include <asm/atomic.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
 	.max_files = NR_FILE
 };
 
-EXPORT_SYMBOL(files_stat); /* Needed by unix.o */
-
 /* public. Not pretty! */
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
 
-static DEFINE_SPINLOCK(filp_count_lock);
+static atomic_t nr_files __cacheline_aligned_in_smp;
 
-/* slab constructors and destructors are called from arbitrary
- * context and must be fully threaded - use a local spinlock
- * to protect files_stat.nr_files
- */
-void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags)
+static inline void file_free_rcu(struct rcu_head *head)
 {
-	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR) {
-		unsigned long flags;
-		spin_lock_irqsave(&filp_count_lock, flags);
-		files_stat.nr_files++;
-		spin_unlock_irqrestore(&filp_count_lock, flags);
-	}
+	struct file *f =  container_of(head, struct file, f_rcuhead);
+	kmem_cache_free(filp_cachep, f);
 }
 
-void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
+static inline void file_free(struct file *f)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&filp_count_lock, flags);
-	files_stat.nr_files--;
-	spin_unlock_irqrestore(&filp_count_lock, flags);
+	atomic_dec(&nr_files);
+	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
 
-static inline void file_free_rcu(struct rcu_head *head)
+/*
+ * Return the total number of open files in the system
+ */
+int get_nr_files(void)
 {
-	struct file *f =  container_of(head, struct file, f_rcuhead);
-	kmem_cache_free(filp_cachep, f);
+	return atomic_read(&nr_files);
 }
 
-static inline void file_free(struct file *f)
+/*
+ * Return the maximum number of open files in the system
+ */
+int get_max_files(void)
 {
-	call_rcu(&f->f_rcuhead, file_free_rcu);
+	return files_stat.max_files;
+}
+
+EXPORT_SYMBOL(get_nr_files);
+EXPORT_SYMBOL(get_max_files);
+
+/*
+ * Handle nr_files sysctl
+ */
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
+int proc_nr_files(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	files_stat.nr_files = get_nr_files();
+	proc_dointvec(table, write, filp, buffer, lenp, ppos);
+}
+#else
+int proc_nr_files(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
 }
+#endif
 
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or
@@ -77,7 +93,7 @@ struct file *get_empty_filp(void)
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (files_stat.nr_files >= files_stat.max_files &&
+	if (get_nr_files() >= files_stat.max_files &&
 				!capable(CAP_SYS_ADMIN))
 		goto over;
 
@@ -96,11 +112,12 @@ struct file *get_empty_filp(void)
 	rwlock_init(&f->f_owner.lock);
 	/* f->f_version: 0 */
 	INIT_LIST_HEAD(&f->f_list);
+	atomic_inc(&nr_files);
 	return f;
 
 over:
 	/* Ran out of filps - report that */
-	if (files_stat.nr_files > old_max) {
+	if (get_nr_files() > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n",
 					files_stat.max_files);
 		old_max = files_stat.nr_files;
diff -puN fs/xfs/linux-2.6/xfs_linux.h~files-scale-file-counting fs/xfs/linux-2.6/xfs_linux.h
--- linux-2.6.14-rc1-test/fs/xfs/linux-2.6/xfs_linux.h~files-scale-file-counting	2005-10-16 14:03:25.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/fs/xfs/linux-2.6/xfs_linux.h	2005-10-16 14:03:25.000000000 -0700
@@ -88,6 +88,7 @@
 #include <linux/proc_fs.h>
 #include <linux/version.h>
 #include <linux/sort.h>
+#include <linux/fs.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
@@ -242,7 +243,7 @@ static inline void set_buffer_unwritten_
 
 /* IRIX uses the current size of the name cache to guess a good value */
 /* - this isn't the same but is a good enough starting point for now. */
-#define DQUOT_HASH_HEURISTIC	files_stat.nr_files
+#define DQUOT_HASH_HEURISTIC	get_nr_files()
 
 /* IRIX inodes maintain the project ID also, zero this field on Linux */
 #define DEFAULT_PROJID	0
diff -puN include/linux/file.h~files-scale-file-counting include/linux/file.h
--- linux-2.6.14-rc1-test/include/linux/file.h~files-scale-file-counting	2005-10-16 14:03:25.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/include/linux/file.h	2005-10-16 14:03:25.000000000 -0700
@@ -60,8 +60,6 @@ extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
 struct kmem_cache_s;
-extern void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags);
-extern void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags);
 
 extern struct file ** alloc_fd_array(int);
 extern void free_fd_array(struct file **, int);
diff -puN include/linux/fs.h~files-scale-file-counting include/linux/fs.h
--- linux-2.6.14-rc1-test/include/linux/fs.h~files-scale-file-counting	2005-10-16 14:03:25.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/include/linux/fs.h	2005-10-16 14:03:25.000000000 -0700
@@ -36,6 +36,8 @@ struct files_stat_struct {
 	int max_files;		/* tunable */
 };
 extern struct files_stat_struct files_stat;
+extern int get_nr_files(void);
+extern int get_max_files(void);
 
 struct inodes_stat_t {
 	int nr_inodes;
diff -puN kernel/sysctl.c~files-scale-file-counting kernel/sysctl.c
--- linux-2.6.14-rc1-test/kernel/sysctl.c~files-scale-file-counting	2005-10-16 14:03:25.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/kernel/sysctl.c	2005-10-16 14:03:25.000000000 -0700
@@ -50,6 +50,9 @@
 #include <linux/nfs_fs.h>
 #endif
 
+extern int proc_nr_files(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos);
+
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
@@ -879,7 +882,7 @@ static ctl_table fs_table[] = {
 		.data		= &files_stat,
 		.maxlen		= 3*sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_nr_files,
 	},
 	{
 		.ctl_name	= FS_MAXFILE,
diff -puN net/unix/af_unix.c~files-scale-file-counting net/unix/af_unix.c
--- linux-2.6.14-rc1-test/net/unix/af_unix.c~files-scale-file-counting	2005-10-16 14:03:25.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/net/unix/af_unix.c	2005-10-16 14:03:25.000000000 -0700
@@ -547,7 +547,7 @@ static struct sock * unix_create1(struct
 	struct sock *sk = NULL;
 	struct unix_sock *u;
 
-	if (atomic_read(&unix_nr_socks) >= 2*files_stat.max_files)
+	if (atomic_read(&unix_nr_socks) >= 2*get_max_files())
 		goto out;
 
 	sk = sk_alloc(PF_UNIX, GFP_KERNEL, &unix_proto, 1);

_
