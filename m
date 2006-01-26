Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWAZSnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWAZSnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWAZSnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:43:13 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:385 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751361AbWAZSnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:43:12 -0500
Date: Fri, 27 Jan 2006 00:12:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Paul E.McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [patch 2/2] fix file counting
Message-ID: <20060126184233.GF4166@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126184127.GE4166@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The way we do file struct accounting is not very suitable for batched
freeing. For scalability reasons, file accounting was constructor/destructor
based. This meant that nr_files was decremented only when
the object was removed from the slab cache. This is
susceptible to slab fragmentation. With RCU based file structure,
consequent batched freeing and a test program like Serge's,
we just speed this up and end up with a very fragmented slab -

llm22:~ # cat /proc/sys/fs/file-nr
587730  0       758844

At the same time, I see only a 2000+ objects in filp cache.
The following patch I fixes this problem. 

This patch changes the file counting by removing the filp_count_lock.
Instead we use a separate atomic_t, nr_files, for now and all
accesses to it are through get_nr_files() api. In the sysctl
handler for nr_files, we populate files_stat.nr_files before returning
to user.

Counting files as an when they are created and destroyed (as opposed
to inside slab) allows us to correctly count open files with RCU.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---




 fs/dcache.c          |    2 -
 fs/file_table.c      |   79 ++++++++++++++++++++++++++++++---------------------
 include/linux/file.h |    2 -
 include/linux/fs.h   |    2 +
 kernel/sysctl.c      |    5 ++-
 net/unix/af_unix.c   |    2 -
 6 files changed, 56 insertions(+), 36 deletions(-)

diff -puN fs/dcache.c~fix-file-counting fs/dcache.c
--- linux-2.6.16-rc1-rcu/fs/dcache.c~fix-file-counting	2006-01-26 00:38:47.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/fs/dcache.c	2006-01-26 00:38:47.000000000 +0530
@@ -1734,7 +1734,7 @@ void __init vfs_caches_init(unsigned lon
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	dcache_init(mempages);
 	inode_init(mempages);
diff -puN fs/file_table.c~fix-file-counting fs/file_table.c
--- linux-2.6.16-rc1-rcu/fs/file_table.c~fix-file-counting	2006-01-26 00:38:47.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/fs/file_table.c	2006-01-26 01:23:28.000000000 +0530
@@ -5,6 +5,7 @@
  *  Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/config.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/file.h>
@@ -19,52 +20,67 @@
 #include <linux/capability.h>
 #include <linux/cdev.h>
 #include <linux/fsnotify.h>
-
+#include <linux/sysctl.h>
+#include <asm/atomic.h>
+  
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
 	.max_files = NR_FILE
 };
 
-EXPORT_SYMBOL(files_stat); /* Needed by unix.o */
-
 /* public. Not pretty! */
- __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
+__cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
+  
+static atomic_t nr_files __cacheline_aligned_in_smp;
 
-static DEFINE_SPINLOCK(filp_count_lock);
+static inline void file_free_rcu(struct rcu_head *head)
+{
+	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
+	kmem_cache_free(filp_cachep, f);
+}
 
-/* slab constructors and destructors are called from arbitrary
- * context and must be fully threaded - use a local spinlock
- * to protect files_stat.nr_files
+static inline void file_free(struct file *f)
+{
+	atomic_dec(&nr_files);
+	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
+}
+  
+/*
+ * Return the total number of open files in the system
  */
-void filp_ctor(void *objp, struct kmem_cache *cachep, unsigned long cflags)
+int get_nr_files(void)
 {
-	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR) {
-		unsigned long flags;
-		spin_lock_irqsave(&filp_count_lock, flags);
-		files_stat.nr_files++;
-		spin_unlock_irqrestore(&filp_count_lock, flags);
-	}
+	return atomic_read(&nr_files);
 }
 
-void filp_dtor(void *objp, struct kmem_cache *cachep, unsigned long dflags)
+/*
+ * Return the maximum number of open files in the system
+ */
+int get_max_files(void)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&filp_count_lock, flags);
-	files_stat.nr_files--;
-	spin_unlock_irqrestore(&filp_count_lock, flags);
+	return files_stat.max_files;
 }
 
-static inline void file_free_rcu(struct rcu_head *head)
+EXPORT_SYMBOL(get_nr_files);
+EXPORT_SYMBOL(get_max_files);
+
+/*
+ * Handle nr_files sysctl
+ */
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
+int proc_nr_files(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
-	kmem_cache_free(filp_cachep, f);
+	files_stat.nr_files = get_nr_files();
+	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
 }
-
-static inline void file_free(struct file *f)
+#else
+int proc_nr_files(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos)
 {
-	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
+	return -ENOSYS;
 }
+#endif
 
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or
@@ -78,7 +94,7 @@ struct file *get_empty_filp(void)
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (files_stat.nr_files >= files_stat.max_files &&
+	if (get_nr_files() >= files_stat.max_files &&
 				!capable(CAP_SYS_ADMIN))
 		goto over;
 
@@ -97,14 +113,15 @@ struct file *get_empty_filp(void)
 	rwlock_init(&f->f_owner.lock);
 	/* f->f_version: 0 */
 	INIT_LIST_HEAD(&f->f_u.fu_list);
+	atomic_inc(&nr_files);
 	return f;
 
 over:
 	/* Ran out of filps - report that */
-	if (files_stat.nr_files > old_max) {
+	if (get_nr_files() > old_max) {
 		printk(KERN_INFO "VFS: file-max limit %d reached\n",
-					files_stat.max_files);
-		old_max = files_stat.nr_files;
+					get_max_files());
+		old_max = get_nr_files();
 	}
 	goto fail;
 
diff -puN include/linux/file.h~fix-file-counting include/linux/file.h
--- linux-2.6.16-rc1-rcu/include/linux/file.h~fix-file-counting	2006-01-26 00:38:47.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/include/linux/file.h	2006-01-26 01:17:36.000000000 +0530
@@ -60,8 +60,6 @@ extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
 struct kmem_cache;
-extern void filp_ctor(void * objp, struct kmem_cache *cachep, unsigned long cflags);
-extern void filp_dtor(void * objp, struct kmem_cache *cachep, unsigned long dflags);
 
 extern struct file ** alloc_fd_array(int);
 extern void free_fd_array(struct file **, int);
diff -puN include/linux/fs.h~fix-file-counting include/linux/fs.h
--- linux-2.6.16-rc1-rcu/include/linux/fs.h~fix-file-counting	2006-01-26 00:38:47.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/include/linux/fs.h	2006-01-26 00:38:48.000000000 +0530
@@ -35,6 +35,8 @@ struct files_stat_struct {
 	int max_files;		/* tunable */
 };
 extern struct files_stat_struct files_stat;
+extern int get_nr_files(void);
+extern int get_max_files(void);
 
 struct inodes_stat_t {
 	int nr_inodes;
diff -puN kernel/sysctl.c~fix-file-counting kernel/sysctl.c
--- linux-2.6.16-rc1-rcu/kernel/sysctl.c~fix-file-counting	2006-01-26 00:38:47.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/kernel/sysctl.c	2006-01-26 00:38:48.000000000 +0530
@@ -52,6 +52,9 @@
 #include <linux/nfs_fs.h>
 #endif
 
+extern int proc_nr_files(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos);
+
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
@@ -900,7 +903,7 @@ static ctl_table fs_table[] = {
 		.data		= &files_stat,
 		.maxlen		= 3*sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_nr_files,
 	},
 	{
 		.ctl_name	= FS_MAXFILE,
diff -puN net/unix/af_unix.c~fix-file-counting net/unix/af_unix.c
--- linux-2.6.16-rc1-rcu/net/unix/af_unix.c~fix-file-counting	2006-01-26 00:38:47.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/net/unix/af_unix.c	2006-01-26 00:38:48.000000000 +0530
@@ -547,7 +547,7 @@ static struct sock * unix_create1(struct
 	struct sock *sk = NULL;
 	struct unix_sock *u;
 
-	if (atomic_read(&unix_nr_socks) >= 2*files_stat.max_files)
+	if (atomic_read(&unix_nr_socks) >= 2*get_max_files())
 		goto out;
 
 	sk = sk_alloc(PF_UNIX, GFP_KERNEL, &unix_proto, 1);

_
