Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWAZUPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWAZUPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWAZUPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:15:32 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:60541 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751412AbWAZUPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:15:31 -0500
Message-ID: <43D92DD6.6090607@cosmosbay.com>
Date: Thu, 26 Jan 2006 21:15:18 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: dipankar@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Paul E.McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 2/2] fix file counting
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com> <20060126184233.GF4166@in.ibm.com>
In-Reply-To: <20060126184233.GF4166@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------000101060209070307050500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000101060209070307050500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dipankar Sarma a écrit :
> The way we do file struct accounting is not very suitable for batched
> freeing. For scalability reasons, file accounting was constructor/destructor
> based. This meant that nr_files was decremented only when
> the object was removed from the slab cache. This is
> susceptible to slab fragmentation. With RCU based file structure,
> consequent batched freeing and a test program like Serge's,
> we just speed this up and end up with a very fragmented slab -
> 
> llm22:~ # cat /proc/sys/fs/file-nr
> 587730  0       758844
> 
> At the same time, I see only a 2000+ objects in filp cache.
> The following patch I fixes this problem. 
> 
> This patch changes the file counting by removing the filp_count_lock.
> Instead we use a separate atomic_t, nr_files, for now and all
> accesses to it are through get_nr_files() api. In the sysctl
> handler for nr_files, we populate files_stat.nr_files before returning
> to user.
> 
> Counting files as an when they are created and destroyed (as opposed
> to inside slab) allows us to correctly count open files with RCU.
> 
> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> ---

Well...

I am using a patch that seems sligthly better : It removes the filp_count_lock 
as yours but introduces a percpu variable, and a lazy nr_files . (Its value 
can be off with a delta of +/- 16*num_possible_cpus()

Pros :
  - No more delay caused by the slab dtor hack (like your patch)
  - No more ping pongs in SMP/NUMA machines because of the nr_files being 
constantly modified.
  - litle memory footprint of NR_CPUS*4 bytes
  - No more cli/sti games (because of filp ctor/dtor spinlock_bh)
  - Moves files_stat definition in a new file (include/linux/files_stat.h)

Cons : The lazy nr_files value in SMP, but who cares ? Do we want the exact 
value displayed in /proc/sys/fs/file-nr ?

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------000101060209070307050500
Content-Type: text/plain;
 name="nr_files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nr_files.patch"

--- linux-2.6.16-rc1-mm3/include/linux/fs.h	2006-01-26 21:42:54.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/include/linux/fs.h	2006-01-26 21:46:44.000000000 +0100
@@ -29,12 +29,6 @@
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
 /* And dynamically-tunable limits and defaults: */
-struct files_stat_struct {
-	int nr_files;		/* read only */
-	int nr_free_files;	/* read only */
-	int max_files;		/* tunable */
-};
-extern struct files_stat_struct files_stat;
 
 struct inodes_stat_t {
 	int nr_inodes;
--- linux-2.6.16-rc1-mm3/include/linux/files_stat.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/include/linux/files_stat.h	2006-01-26 21:26:08.000000000 +0100
@@ -0,0 +1,34 @@
+#ifndef _LINUX_FILES_STAT_H
+#define _LINUX_FILES_STAT_H
+/*
+ * nr_files uses a percpu_counter to reduce atomic ops and/or cli/sti
+ * Using a percpu_counter is lazy, but we dont need exact values,
+ * and can consider max_files as a lazy limit, at least for SMP machines.
+ */
+#include <linux/percpu_counter.h>
+
+struct files_stat_struct {
+    /*
+     * WARNING : The 3 first fields of this structure
+     * must be of int type :_nr_files, nr_free_files, max_files
+     * in this exact order.
+     * (see kernel/sysctl.c )
+     */
+    int _nr_files;	/* rd only, updated when reading /proc/sys/fs/file-nr */
+    int nr_free_files;	/* rd only , obsolete */
+    int max_files;	/* rw (/proc/sys/fs/file-max) */
+	atomic_t nr_files;
+};
+extern struct files_stat_struct files_stat;
+
+static inline int get_nr_files(void)
+{
+	return atomic_read(&files_stat.nr_files);
+}
+
+static inline int get_max_files(void)
+{
+	return files_stat.max_files;
+}
+
+#endif /* _LINUX_FILES_STAT_H */
--- linux-2.6.16-rc1-mm3/fs/file_table.c	2006-01-26 21:42:53.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/fs/file_table.c	2006-01-26 21:48:27.000000000 +0100
@@ -19,10 +19,12 @@
 #include <linux/capability.h>
 #include <linux/cdev.h>
 #include <linux/fsnotify.h>
+#include <linux/files_stat.h>
 
 /* sysctl tunables... */
-struct files_stat_struct files_stat = {
-	.max_files = NR_FILE
+__cacheline_aligned_in_smp struct files_stat_struct files_stat = {
+	.max_files = NR_FILE,
+	.nr_files = ATOMIC_INIT(0)
 };
 
 EXPORT_SYMBOL(files_stat); /* Needed by unix.o */
@@ -30,35 +32,33 @@
 /* public. Not pretty! */
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
 
-static DEFINE_SPINLOCK(filp_count_lock);
-
-/* slab constructors and destructors are called from arbitrary
- * context and must be fully threaded - use a local spinlock
- * to protect files_stat.nr_files
- */
-void filp_ctor(void *objp, struct kmem_cache *cachep, unsigned long cflags)
-{
-	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR) {
-		unsigned long flags;
-		spin_lock_irqsave(&filp_count_lock, flags);
-		files_stat.nr_files++;
-		spin_unlock_irqrestore(&filp_count_lock, flags);
+#ifdef CONFIG_SMP
+#define NR_FILES_THRESHOLD 16
+static DEFINE_PER_CPU(int, nr_files);
+static void add_nr_files(int delta)
+{
+	int *local;
+	preempt_disable();
+	local = &__get_cpu_var(nr_files);
+	*local += delta;
+	if (*local > NR_FILES_THRESHOLD || *local < -NR_FILES_THRESHOLD) {
+		atomic_add(*local, &files_stat.nr_files);
+		*local = 0;
 	}
+	preempt_enable();
 }
-
-void filp_dtor(void *objp, struct kmem_cache *cachep, unsigned long dflags)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&filp_count_lock, flags);
-	files_stat.nr_files--;
-	spin_unlock_irqrestore(&filp_count_lock, flags);
-}
+#define dec_nr_files() add_nr_files(-1)
+#define inc_nr_files() add_nr_files(1)
+#else
+# define dec_nr_files() atomic_dec(&files_stat.nr_files)
+# define inc_nr_files() atomic_inc(&files_stat.nr_files)
+#endif
 
 static inline void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
 	kmem_cache_free(filp_cachep, f);
+	dec_nr_files();
 }
 
 static inline void file_free(struct file *f)
@@ -75,11 +75,13 @@
 	struct task_struct *tsk;
 	static int old_max;
 	struct file * f;
+	int nr_files;
 
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (files_stat.nr_files >= files_stat.max_files &&
+	nr_files = get_nr_files();
+	if (nr_files >= files_stat.max_files &&
 				!capable(CAP_SYS_ADMIN))
 		goto over;
 
@@ -91,6 +93,7 @@
 	if (security_file_alloc(f))
 		goto fail_sec;
 
+	inc_nr_files();
 	tsk = current;
 	INIT_LIST_HEAD(&f->f_u.fu_list);
 	atomic_set(&f->f_count, 1);
@@ -103,10 +106,10 @@
 
 over:
 	/* Ran out of filps - report that */
-	if (files_stat.nr_files > old_max) {
+	if (nr_files > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n",
 					files_stat.max_files);
-		old_max = files_stat.nr_files;
+		old_max = nr_files;
 	}
 	goto fail;
 
--- linux-2.6.16-rc1-mm3/kernel/sysctl.c	2006-01-26 21:42:54.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/kernel/sysctl.c	2006-01-26 19:40:04.000000000 +0100
@@ -46,6 +46,7 @@
 #include <linux/syscalls.h>
 #include <linux/nfs_fs.h>
 #include <linux/acpi.h>
+#include <linux/files_stat.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
@@ -131,6 +132,9 @@
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
 
+static int proc_dointvec_files_stat(ctl_table *table, int write, struct file *filp,
+			     void __user *buffer, size_t *lenp, loff_t *ppos);
+
 static ctl_table root_table[];
 static struct ctl_table_header root_table_header =
 	{ root_table, LIST_HEAD_INIT(root_table_header.ctl_entry) };
@@ -920,7 +924,7 @@
 		.data		= &files_stat,
 		.maxlen		= 3*sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_dointvec_files_stat,
 	},
 	{
 		.ctl_name	= FS_MAXFILE,
@@ -1754,6 +1758,12 @@
     return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,
 		    	    NULL,NULL);
 }
+static int proc_dointvec_files_stat(ctl_table *table, int write, struct file *filp,
+			     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+    files_stat._nr_files = get_nr_files();
+    return proc_dointvec(table,write,filp,buffer,lenp,ppos);
+}
 
 #define OP_SET	0
 #define OP_AND	1
--- linux-2.6.16-rc1-mm3/net/unix/af_unix.c	2006-01-26 21:42:54.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/net/unix/af_unix.c	2006-01-26 19:19:07.000000000 +0100
@@ -100,6 +100,7 @@
 #include <linux/net.h>
 #include <linux/in.h>
 #include <linux/fs.h>
+#include <linux/files_stat.h>
 #include <linux/slab.h>
 #include <asm/uaccess.h>
 #include <linux/skbuff.h>
@@ -547,7 +548,7 @@
 	struct sock *sk = NULL;
 	struct unix_sock *u;
 
-	if (atomic_read(&unix_nr_socks) >= 2*files_stat.max_files)
+	if (atomic_read(&unix_nr_socks) >= 2*get_max_files())
 		goto out;
 
 	sk = sk_alloc(PF_UNIX, GFP_KERNEL, &unix_proto, 1);
--- linux-2.6.16-rc1-mm3/fs/dcache.c	2006-01-26 21:42:53.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/fs/dcache.c	2006-01-26 21:15:11.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/files_stat.h>
 
 /* #define DCACHE_DEBUG 1 */
 
@@ -1738,7 +1739,7 @@
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	dcache_init(mempages);
 	inode_init(mempages);
--- linux-2.6.16-rc1-mm3/include/linux/file.h	2006-01-26 21:42:54.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/include/linux/file.h	2006-01-26 21:45:23.000000000 +0100
@@ -79,9 +79,6 @@
 extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
-struct kmem_cache;
-extern void filp_ctor(void * objp, struct kmem_cache *cachep, unsigned long cflags);
-extern void filp_dtor(void * objp, struct kmem_cache *cachep, unsigned long dflags);
 
 extern struct file ** alloc_fd_array(int);
 extern void free_fd_array(struct file **, int);

--------------000101060209070307050500--
