Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWGCUpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWGCUpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWGCUpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:45:22 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:31154 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751256AbWGCUpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:45:18 -0400
Message-ID: <44A98241.2040705@oracle.com>
Date: Mon, 03 Jul 2006 13:46:57 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, viro@zeniv.linux.org.uk
Subject: [Ubuntu PATCH] fix VFS nr_files accounting
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lkml discussion: http://thread.gmane.org/gmane.linux.kernel/385438/focus=385478

Already in -mm?

From: Dipankar Sarma <dipankar@in.ibm.com>

Ubuntu patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=5ce2ed3a63172c6ce0b97069e449960c2d538623

---
 fs/dcache.c              |    2 -
 fs/file_table.c          |   86 +++++++++++++++++------------------------------
 include/linux/file.h     |    2 +
 include/linux/fs.h       |    1 
 include/linux/rcupdate.h |    6 ---
 kernel/rcupdate.c        |   49 +++++++++++++-------------
 kernel/sysctl.c          |    5 --
 net/unix/af_unix.c       |    2 -
 8 files changed, 62 insertions(+), 91 deletions(-)

--- linux-2617-g21.orig/fs/dcache.c
+++ linux-2617-g21/fs/dcache.c
@@ -1765,7 +1765,7 @@ void __init vfs_caches_init(unsigned lon
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
 
 	dcache_init(mempages);
 	inode_init(mempages);
--- linux-2617-g21.orig/fs/file_table.c
+++ linux-2617-g21/fs/file_table.c
@@ -19,67 +19,52 @@
 #include <linux/capability.h>
 #include <linux/cdev.h>
 #include <linux/fsnotify.h>
-#include <linux/sysctl.h>
-#include <linux/percpu_counter.h>
-
-#include <asm/atomic.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
 	.max_files = NR_FILE
 };
 
-/* public. Not pretty! */
-__cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
-
-static struct percpu_counter nr_files __cacheline_aligned_in_smp;
+EXPORT_SYMBOL(files_stat); /* Needed by unix.o */
 
-static inline void file_free_rcu(struct rcu_head *head)
-{
-	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
-	kmem_cache_free(filp_cachep, f);
-}
+/* public. Not pretty! */
+ __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
 
-static inline void file_free(struct file *f)
-{
-	percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
-}
+static DEFINE_SPINLOCK(filp_count_lock);
 
-/*
- * Return the total number of open files in the system
+/* slab constructors and destructors are called from arbitrary
+ * context and must be fully threaded - use a local spinlock
+ * to protect files_stat.nr_files
  */
-static int get_nr_files(void)
+void filp_ctor(void *objp, struct kmem_cache *cachep, unsigned long cflags)
 {
-	return percpu_counter_read_positive(&nr_files);
+	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		unsigned long flags;
+		spin_lock_irqsave(&filp_count_lock, flags);
+		files_stat.nr_files++;
+		spin_unlock_irqrestore(&filp_count_lock, flags);
+	}
 }
 
-/*
- * Return the maximum number of open files in the system
- */
-int get_max_files(void)
+void filp_dtor(void *objp, struct kmem_cache *cachep, unsigned long dflags)
 {
-	return files_stat.max_files;
+	unsigned long flags;
+	spin_lock_irqsave(&filp_count_lock, flags);
+	files_stat.nr_files--;
+	spin_unlock_irqrestore(&filp_count_lock, flags);
 }
-EXPORT_SYMBOL_GPL(get_max_files);
 
-/*
- * Handle nr_files sysctl
- */
-#if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
-int proc_nr_files(ctl_table *table, int write, struct file *filp,
-                     void __user *buffer, size_t *lenp, loff_t *ppos)
+static inline void file_free_rcu(struct rcu_head *head)
 {
-	files_stat.nr_files = get_nr_files();
-	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
+	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
+	kmem_cache_free(filp_cachep, f);
 }
-#else
-int proc_nr_files(ctl_table *table, int write, struct file *filp,
-                     void __user *buffer, size_t *lenp, loff_t *ppos)
+
+static inline void file_free(struct file *f)
 {
-	return -ENOSYS;
+	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
-#endif
 
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or
@@ -94,20 +79,14 @@ struct file *get_empty_filp(void)
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
-		/*
-		 * percpu_counters are inaccurate.  Do an expensive check before
-		 * we go and fail.
-		 */
-		if (percpu_counter_sum(&nr_files) >= files_stat.max_files)
-			goto over;
-	}
+	if (files_stat.nr_files >= files_stat.max_files &&
+				!capable(CAP_SYS_ADMIN))
+		goto over;
 
 	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
 	if (f == NULL)
 		goto fail;
 
-	percpu_counter_inc(&nr_files);
 	memset(f, 0, sizeof(*f));
 	if (security_file_alloc(f))
 		goto fail_sec;
@@ -124,10 +103,10 @@ struct file *get_empty_filp(void)
 
 over:
 	/* Ran out of filps - report that */
-	if (get_nr_files() > old_max) {
+	if (files_stat.nr_files > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n",
-					get_max_files());
-		old_max = get_nr_files();
+					files_stat.max_files);
+		old_max = files_stat.nr_files;
 	}
 	goto fail;
 
@@ -299,5 +278,4 @@ void __init files_init(unsigned long mem
 	if (files_stat.max_files < NR_FILE)
 		files_stat.max_files = NR_FILE;
 	files_defer_init();
-	percpu_counter_init(&nr_files, 0);
 } 
--- linux-2617-g21.orig/include/linux/file.h
+++ linux-2617-g21/include/linux/file.h
@@ -80,6 +80,8 @@ extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
 struct kmem_cache;
+extern void filp_ctor(void * objp, struct kmem_cache *cachep, unsigned long cflags);
+extern void filp_dtor(void * objp, struct kmem_cache *cachep, unsigned long dflags);
 
 extern struct file ** alloc_fd_array(int);
 extern void free_fd_array(struct file **, int);
--- linux-2617-g21.orig/include/linux/fs.h
+++ linux-2617-g21/include/linux/fs.h
@@ -34,7 +34,6 @@ struct files_stat_struct {
 	int max_files;		/* tunable */
 };
 extern struct files_stat_struct files_stat;
-extern int get_max_files(void);
 
 struct inodes_stat_t {
 	int nr_inodes;
--- linux-2617-g21.orig/include/linux/rcupdate.h
+++ linux-2617-g21/include/linux/rcupdate.h
@@ -98,17 +98,13 @@ struct rcu_data {
 	long  	       	batch;           /* Batch # for current RCU batch */
 	struct rcu_head *nxtlist;
 	struct rcu_head **nxttail;
-	long            qlen; 	 	 /* # of queued callbacks */
+	long            count; /* # of queued items */
 	struct rcu_head *curlist;
 	struct rcu_head **curtail;
 	struct rcu_head *donelist;
 	struct rcu_head **donetail;
-	long		blimit;		 /* Upper limit on a processed batch */
 	int cpu;
 	struct rcu_head barrier;
-#ifdef CONFIG_SMP
-	long		last_rs_qlen;	 /* qlen during the last resched */
-#endif
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
--- linux-2617-g21.orig/kernel/rcupdate.c
+++ linux-2617-g21/kernel/rcupdate.c
@@ -66,8 +66,14 @@ static struct rcu_ctrlblk rcu_bh_ctrlblk
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
 
+static atomic_t rcu_barrier_cpu_count;
+static DEFINE_MUTEX(rcu_barrier_mutex);
+static struct completion rcu_barrier_completion;
+
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
+static int maxbatch = 10000;
+#if 0
 static int blimit = 10;
 static int qhimark = 10000;
 static int qlowmark = 100;
@@ -75,10 +81,6 @@ static int qlowmark = 100;
 static int rsinterval = 1000;
 #endif
 
-static atomic_t rcu_barrier_cpu_count;
-static DEFINE_MUTEX(rcu_barrier_mutex);
-static struct completion rcu_barrier_completion;
-
 #ifdef CONFIG_SMP
 static void force_quiescent_state(struct rcu_data *rdp,
 			struct rcu_ctrlblk *rcp)
@@ -105,6 +107,7 @@ static inline void force_quiescent_state
 	set_need_resched();
 }
 #endif
+#endif
 
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
@@ -129,13 +132,17 @@ void fastcall call_rcu(struct rcu_head *
 	rdp = &__get_cpu_var(rcu_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
-	if (unlikely(++rdp->qlen > qhimark)) {
-		rdp->blimit = INT_MAX;
-		force_quiescent_state(rdp, &rcu_ctrlblk);
-	}
+
+	if (unlikely(++rdp->count > 10000))
+		set_need_resched();
+
 	local_irq_restore(flags);
 }
 
+static atomic_t rcu_barrier_cpu_count;
+static struct semaphore rcu_barrier_sema;
+static struct completion rcu_barrier_completion;
+
 /**
  * call_rcu_bh - Queue an RCU for invocation after a quicker grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -164,12 +171,12 @@ void fastcall call_rcu_bh(struct rcu_hea
 	rdp = &__get_cpu_var(rcu_bh_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
-
-	if (unlikely(++rdp->qlen > qhimark)) {
-		rdp->blimit = INT_MAX;
-		force_quiescent_state(rdp, &rcu_bh_ctrlblk);
-	}
-
+	rdp->count++;
+/*
+ *  Should we directly call rcu_do_batch() here ?
+ *  if (unlikely(rdp->count > 10000))
+ *      rcu_do_batch(rdp);
+ */
 	local_irq_restore(flags);
 }
 
@@ -241,12 +248,10 @@ static void rcu_do_batch(struct rcu_data
 		next = rdp->donelist = list->next;
 		list->func(list);
 		list = next;
-		rdp->qlen--;
-		if (++count >= rdp->blimit)
+		rdp->count--;
+		if (++count >= maxbatch)
 			break;
 	}
-	if (rdp->blimit == INT_MAX && rdp->qlen <= qlowmark)
-		rdp->blimit = blimit;
 	if (!rdp->donelist)
 		rdp->donetail = &rdp->donelist;
 	else
@@ -535,7 +540,6 @@ static void rcu_init_percpu_data(int cpu
 	rdp->quiescbatch = rcp->completed;
 	rdp->qs_pending = 0;
 	rdp->cpu = cpu;
-	rdp->blimit = blimit;
 }
 
 static void __devinit rcu_online_cpu(int cpu)
@@ -621,12 +625,7 @@ void synchronize_rcu(void)
 	wait_for_completion(&rcu.completion);
 }
 
-module_param(blimit, int, 0);
-module_param(qhimark, int, 0);
-module_param(qlowmark, int, 0);
-#ifdef CONFIG_SMP
-module_param(rsinterval, int, 0);
-#endif
+module_param(maxbatch, int, 0);
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
 EXPORT_SYMBOL_GPL(call_rcu);
--- linux-2617-g21.orig/kernel/sysctl.c
+++ linux-2617-g21/kernel/sysctl.c
@@ -49,9 +49,6 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-extern int proc_nr_files(ctl_table *table, int write, struct file *filp,
-                     void __user *buffer, size_t *lenp, loff_t *ppos);
-
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
@@ -971,7 +968,7 @@ static ctl_table fs_table[] = {
 		.data		= &files_stat,
 		.maxlen		= 3*sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= &proc_nr_files,
+		.proc_handler	= &proc_dointvec,
 	},
 	{
 		.ctl_name	= FS_MAXFILE,
--- linux-2617-g21.orig/net/unix/af_unix.c
+++ linux-2617-g21/net/unix/af_unix.c
@@ -570,7 +570,7 @@ static struct sock * unix_create1(struct
 	struct sock *sk = NULL;
 	struct unix_sock *u;
 
-	if (atomic_read(&unix_nr_socks) >= 2*get_max_files())
+	if (atomic_read(&unix_nr_socks) >= 2*files_stat.max_files)
 		goto out;
 
 	sk = sk_alloc(PF_UNIX, GFP_KERNEL, &unix_proto, 1);

