Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVHYSYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVHYSYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVHYSYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:24:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:64681 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932331AbVHYSYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:24:31 -0400
Date: Thu, 25 Aug 2005 23:49:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to atomic_t
Message-ID: <20050825181935.GA4738@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1124956563.3222.8.camel@laptopd505.fenrus.org> <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org> <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org> <430DA052.9070908@cosmosbay.com> <1124968309.5856.9.camel@npiggin-nld.site> <430DB8FA.4080009@cosmosbay.com> <430DDAF2.6030601@yahoo.com.au> <430DE001.8060604@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <430DE001.8060604@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 05:13:05PM +0200, Eric Dumazet wrote:
> Nick Piggin a écrit :
> 
> >OK, well I would prefer you do the proper atomic operations throughout
> >where it "really matters" in file_table.c, and do your lazy synchronize
> >with just the sysctl exported value.
> >
> 
> But... I got complains about atomic_read(&counter) being 'an atomic op' 
> (untrue), so my second patch just doesnt touch the path where nr_files was 
> read.
> 

Here is a patch that I had done some time ago that uses atomic_t,
yet retains the sysctl handler. Eric, you earlier patch is incorrect
exactly for that reason.

One other thing - the claim that it removes filp_count_lock
from fast path is bogus. The slab constructor/destructors are
called only when we return the free file structs to the page
allocator. That we don't do very often and therefore we
don't acquire the lock - atleast not for every filp open
and close.

This is not to say we don't want a better reference counter like
a per-cpu counter, but there is some difficult stuff there and
the returns need to justify that. I would appreciate if you
or anyone can demonstrate this to be a problem.

The patch below was meant for debugging some suspected problems
with -mm.

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


 fs/dcache.c                  |    2 -
 fs/file_table.c              |   71 ++++++++++++++++++++++++++-----------------
 fs/xfs/linux-2.6/xfs_linux.h |    3 +
 include/linux/file.h         |    2 -
 include/linux/fs.h           |    2 +
 kernel/sysctl.c              |    5 ++-
 net/unix/af_unix.c           |    2 -
 7 files changed, 54 insertions(+), 33 deletions(-)

diff -puN fs/file_table.c~files-scale-file-counting fs/file_table.c
--- linux-2.6.13-rc3-mm3-fixes/fs/file_table.c~files-scale-file-counting	2005-08-09 12:24:27.000000000 +0530
+++ linux-2.6.13-rc3-mm3-fixes-dipankar/fs/file_table.c	2005-08-09 16:42:27.000000000 +0530
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
 
@@ -97,11 +113,12 @@ struct file *get_empty_filp(void)
 	/* f->f_version: 0 */
 	INIT_LIST_HEAD(&f->f_list);
 	f->f_maxcount = INT_MAX;
+	atomic_inc(&nr_files);
 	return f;
 
 over:
 	/* Ran out of filps - report that */
-	if (files_stat.nr_files > old_max) {
+	if (get_nr_files() > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n",
 					files_stat.max_files);
 		old_max = files_stat.nr_files;
diff -puN include/linux/fs.h~files-scale-file-counting include/linux/fs.h
--- linux-2.6.13-rc3-mm3-fixes/include/linux/fs.h~files-scale-file-counting	2005-08-09 15:52:14.000000000 +0530
+++ linux-2.6.13-rc3-mm3-fixes-dipankar/include/linux/fs.h	2005-08-09 16:59:05.000000000 +0530
@@ -36,6 +36,8 @@ struct files_stat_struct {
 	int max_files;		/* tunable */
 };
 extern struct files_stat_struct files_stat;
+extern int get_nr_files(void);
+extern int get_max_files(void);
 
 struct inodes_stat_t {
 	int nr_inodes;
diff -puN fs/xfs/linux-2.6/xfs_linux.h~files-scale-file-counting fs/xfs/linux-2.6/xfs_linux.h
--- linux-2.6.13-rc3-mm3-fixes/fs/xfs/linux-2.6/xfs_linux.h~files-scale-file-counting	2005-08-09 15:58:51.000000000 +0530
+++ linux-2.6.13-rc3-mm3-fixes-dipankar/fs/xfs/linux-2.6/xfs_linux.h	2005-08-09 15:59:36.000000000 +0530
@@ -88,6 +88,7 @@
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/sort.h>
+#include <linux/fs.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
@@ -241,7 +242,7 @@ static inline void set_buffer_unwritten_
 
 /* IRIX uses the current size of the name cache to guess a good value */
 /* - this isn't the same but is a good enough starting point for now. */
-#define DQUOT_HASH_HEURISTIC	files_stat.nr_files
+#define DQUOT_HASH_HEURISTIC	get_nr_files()
 
 /* IRIX inodes maintain the project ID also, zero this field on Linux */
 #define DEFAULT_PROJID	0
diff -puN net/unix/af_unix.c~files-scale-file-counting net/unix/af_unix.c
--- linux-2.6.13-rc3-mm3-fixes/net/unix/af_unix.c~files-scale-file-counting	2005-08-09 15:59:57.000000000 +0530
+++ linux-2.6.13-rc3-mm3-fixes-dipankar/net/unix/af_unix.c	2005-08-09 16:00:26.000000000 +0530
@@ -547,7 +547,7 @@ static struct sock * unix_create1(struct
 	struct sock *sk = NULL;
 	struct unix_sock *u;
 
-	if (atomic_read(&unix_nr_socks) >= 2*files_stat.max_files)
+	if (atomic_read(&unix_nr_socks) >= 2*get_max_files())
 		goto out;
 
 	sk = sk_alloc(PF_UNIX, GFP_KERNEL, &unix_proto, 1);
diff -puN fs/dcache.c~files-scale-file-counting fs/dcache.c
--- linux-2.6.13-rc3-mm3-fixes/fs/dcache.c~files-scale-file-counting	2005-08-09 16:00:50.000000000 +0530
+++ linux-2.6.13-rc3-mm3-fixes-dipankar/fs/dcache.c	2005-08-09 16:01:28.000000000 +0530
@@ -1895,7 +1895,7 @@ void __init vfs_caches_init(unsigned lon
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	dcache_init(mempages);
 	inode_init(mempages);
diff -puN include/linux/file.h~files-scale-file-counting include/linux/file.h
--- linux-2.6.13-rc3-mm3-fixes/include/linux/file.h~files-scale-file-counting	2005-08-09 16:06:46.000000000 +0530
+++ linux-2.6.13-rc3-mm3-fixes-dipankar/include/linux/file.h	2005-08-09 16:07:33.000000000 +0530
@@ -60,8 +60,6 @@ extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
 struct kmem_cache_s;
-extern void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags);
-extern void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags);
 
 extern struct file ** alloc_fd_array(int);
 extern void free_fd_array(struct file **, int);
diff -puN kernel/sysctl.c~files-scale-file-counting kernel/sysctl.c
--- linux-2.6.13-rc3-mm3-fixes/kernel/sysctl.c~files-scale-file-counting	2005-08-09 16:21:27.000000000 +0530
+++ linux-2.6.13-rc3-mm3-fixes-dipankar/kernel/sysctl.c	2005-08-09 16:26:16.000000000 +0530
@@ -49,6 +49,9 @@
 #include <linux/nfs_fs.h>
 #endif
 
+extern int proc_nr_files(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos);
+
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
@@ -881,7 +884,7 @@ static ctl_table fs_table[] = {
 		.data		= &files_stat,
 		.maxlen		= 3*sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_nr_files,
 	},
 	{
 		.ctl_name	= FS_MAXFILE,

_
