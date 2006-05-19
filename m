Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWESPrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWESPrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWESPrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:47:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:697 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932363AbWESPrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:47:15 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/14] FS-Cache: Avoid ENFILE checking for kernel-specific open files [try #10]
Date: Fri, 19 May 2006 16:47:03 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060519154703.11791.59304.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com>
References: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to avoid ENFILE checking for kernel specific open files, such
as are used by the CacheFiles module.

After, for example, tarring up a kernel source tree over the network, the
CacheFiles module may easily have 20000+ files open in the backing filesystem,
thus causing all non-root processes to be given error ENFILE when they try to
open a file, socket, pipe, etc..

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/sysctl/fs.txt |    6 ++++-
 fs/file_table.c             |   48 +++++++++++++++++++++++++++++++++++--------
 fs/open.c                   |   20 ++++++++++++++++++
 include/linux/file.h        |    1 -
 include/linux/fs.h          |   10 +++++++++
 include/linux/sysctl.h      |    1 +
 kernel/sysctl.c             |   11 ++++++++++
 7 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
index 0b62c62..ead15f0 100644
--- a/Documentation/sysctl/fs.txt
+++ b/Documentation/sysctl/fs.txt
@@ -71,7 +71,7 @@ you might want to raise the limit.
 
 ==============================================================
 
-file-max & file-nr:
+file-max, file-nr & file-kernel:
 
 The kernel allocates file handles dynamically, but as yet it
 doesn't free them again.
@@ -88,6 +88,10 @@ close to the maximum, but the number of 
 significantly greater than 0, you've encountered a peak in your 
 usage of file handles and you don't need to increase the maximum.
 
+The value in file-kernel denotes the number of internal file handles
+that the kernel has open.  These do not contribute to ENFILE
+accounting.
+
 ==============================================================
 
 inode-max, inode-nr & inode-state:
diff --git a/fs/file_table.c b/fs/file_table.c
index bcea199..0b42be9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -30,10 +30,13 @@ struct files_stat_struct files_stat = {
 	.max_files = NR_FILE
 };
 
+struct files_kernel_stat_struct files_kernel_stat;
+
 /* public. Not pretty! */
 __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
+static atomic_t nr_kernel_files;
 
 static inline void file_free_rcu(struct rcu_head *head)
 {
@@ -43,7 +46,10 @@ static inline void file_free_rcu(struct 
 
 static inline void file_free(struct file *f)
 {
-	percpu_counter_dec(&nr_files);
+	if (f->f_kernel_flags & FKFLAGS_NO_ENFILE)
+		atomic_dec(&nr_kernel_files);
+	else
+		percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
@@ -74,45 +80,64 @@ int proc_nr_files(ctl_table *table, int 
 	files_stat.nr_files = get_nr_files();
 	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
 }
+int proc_files_kernel(ctl_table *table, int write, struct file *filp,
+		      void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	files_kernel_stat.nr_kernel_files = atomic_read(&nr_kernel_files);
+	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
+}
 #else
 int proc_nr_files(ctl_table *table, int write, struct file *filp,
                      void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
+int proc_files_kernel(ctl_table *table, int write, struct file *filp,
+		      void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
 #endif
 
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or
  * we run out of memory.
  */
-struct file *get_empty_filp(void)
+struct file *get_empty_kernel_filp(unsigned short kflags)
 {
 	struct task_struct *tsk;
 	static int old_max;
 	struct file * f;
 
 	/*
-	 * Privileged users can go above max_files
+	 * Privileged users can go above max_files and internal kernel users
+	 * can avoid it completely
 	 */
-	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
+	if (!(kflags & FKFLAGS_NO_ENFILE) &&
+	    get_nr_files() >= files_stat.max_files &&
+	    !capable(CAP_SYS_ADMIN)
+	    ) {
 		/*
-		 * percpu_counters are inaccurate.  Do an expensive check before
-		 * we go and fail.
+		 * percpu_counters are inaccurate.  Do an expensive
+		 * check before we go and fail.
 		 */
 		if (percpu_counter_sum(&nr_files) >= files_stat.max_files)
 			goto over;
 	}
 
-	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
+	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
 	if (f == NULL)
 		goto fail;
 
-	percpu_counter_inc(&nr_files);
-	memset(f, 0, sizeof(*f));
+	if (kflags & FKFLAGS_NO_ENFILE)
+		atomic_inc(&nr_kernel_files);
+	else
+		percpu_counter_inc(&nr_files);
+
 	if (security_file_alloc(f))
 		goto fail_sec;
 
+	f->f_kernel_flags = kflags;
 	tsk = current;
 	INIT_LIST_HEAD(&f->f_u.fu_list);
 	atomic_set(&f->f_count, 1);
@@ -138,6 +163,11 @@ fail:
 	return NULL;
 }
 
+struct file *get_empty_filp(void)
+{
+	return get_empty_kernel_filp(0);
+}
+
 EXPORT_SYMBOL(get_empty_filp);
 
 void fastcall fput(struct file *file)
diff --git a/fs/open.c b/fs/open.c
index 33fba83..e171ae5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -974,6 +974,26 @@ struct file *dentry_open(struct dentry *
 EXPORT_SYMBOL(dentry_open);
 
 /*
+ * open a specifically in-kernel file
+ */
+struct file *dentry_open_kernel(struct dentry *dentry, struct vfsmount *mnt, int flags)
+{
+	int error;
+	struct file *f;
+
+	error = -ENFILE;
+	f = get_empty_kernel_filp(FKFLAGS_NO_ENFILE);
+	if (f == NULL) {
+		dput(dentry);
+		mntput(mnt);
+		return ERR_PTR(error);
+	}
+
+	return __dentry_open(dentry, mnt, flags, f, NULL);
+}
+EXPORT_SYMBOL_GPL(dentry_open_kernel);
+
+/*
  * Find an empty file descriptor entry, and mark it busy.
  */
 int get_unused_fd(void)
diff --git a/include/linux/file.h b/include/linux/file.h
index 9f7c251..da7be8f 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -79,7 +79,6 @@ extern void FASTCALL(set_close_on_exec(u
 extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
-struct kmem_cache;
 
 extern struct file ** alloc_fd_array(int);
 extern void free_fd_array(struct file **, int);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1720be7..28511d3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -34,7 +34,11 @@ struct files_stat_struct {
 	int nr_free_files;	/* read only */
 	int max_files;		/* tunable */
 };
+struct files_kernel_stat_struct {
+	int nr_kernel_files;	/* read only */
+};
 extern struct files_stat_struct files_stat;
+extern struct files_kernel_stat_struct files_kernel_stat;
 extern int get_max_files(void);
 
 struct inodes_stat_t {
@@ -70,6 +74,8 @@ #define FMODE_PWRITE	FMODE_PREAD	/* Thes
    behavior for cross-node execution/opening_for_writing of files */
 #define FMODE_EXEC	16
 
+#define FKFLAGS_NO_ENFILE	1	/* kernel internal file (ignored for ENFILE accounting) */
+
 #define RW_MASK		1
 #define RWA_MASK	2
 #define READ 0
@@ -640,6 +646,7 @@ struct file {
 	atomic_t		f_count;
 	unsigned int 		f_flags;
 	mode_t			f_mode;
+	unsigned short		f_kernel_flags;
 	loff_t			f_pos;
 	struct fown_struct	f_owner;
 	unsigned int		f_uid, f_gid;
@@ -1382,6 +1389,7 @@ extern long do_sys_open(int fdf, const c
 			int mode);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
+extern struct file * dentry_open_kernel(struct dentry *, struct vfsmount *, int);
 extern int filp_close(struct file *, fl_owner_t id);
 extern char * getname(const char __user *);
 
@@ -1583,6 +1591,7 @@ static inline void insert_inode_hash(str
 }
 
 extern struct file * get_empty_filp(void);
+extern struct file * get_empty_kernel_filp(unsigned short fkflags);
 extern void file_move(struct file *f, struct list_head *list);
 extern void file_kill(struct file *f);
 struct bio;
@@ -1608,6 +1617,7 @@ extern ssize_t generic_file_direct_write
 		unsigned long *, loff_t, loff_t *, size_t, size_t);
 extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
+extern int generic_file_buffered_write_one_kernel_page(struct file *, pgoff_t, struct page *);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 76eaeff..8a0d4f8 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -787,6 +787,7 @@ enum
 	FS_AIO_NR=18,	/* current system-wide number of aio requests */
 	FS_AIO_MAX_NR=19,	/* system-wide maximum number of aio requests */
 	FS_INOTIFY=20,	/* inotify submenu */
+	FS_FILE_KERNEL=21,	/* int: number of internal kernel files */
 };
 
 /* /proc/sys/fs/quota/ */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e82726f..f849104 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -53,6 +53,9 @@ #include <asm/processor.h>
 extern int proc_nr_files(ctl_table *table, int write, struct file *filp,
                      void __user *buffer, size_t *lenp, loff_t *ppos);
 
+extern int proc_files_kernel(ctl_table *table, int write, struct file *filp,
+                     void __user *buffer, size_t *lenp, loff_t *ppos);
+
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
@@ -956,6 +959,14 @@ static ctl_table fs_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= FS_FILE_KERNEL,
+		.procname	= "file-kernel",
+		.data		= &files_stat,
+		.maxlen		= 1*sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_files_kernel,
+	},
+	{
 		.ctl_name	= FS_DENTRY,
 		.procname	= "dentry-state",
 		.data		= &dentry_stat,

