Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWDTQ7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWDTQ7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWDTQ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:59:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751143AbWDTQ7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:59:46 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific open files
Date: Thu, 20 Apr 2006 17:59:33 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
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

 arch/ia64/kernel/perfmon.c            |    2 +-
 drivers/infiniband/core/uverbs_main.c |    2 +-
 fs/eventpoll.c                        |    2 +-
 fs/file_table.c                       |   36 ++++++++++++++++++++++++---------
 fs/hugetlbfs/inode.c                  |    2 +-
 fs/inotify.c                          |    2 +-
 fs/namei.c                            |    2 +-
 fs/open.c                             |   22 +++++++++++++++++++-
 fs/pipe.c                             |    4 ++--
 include/linux/file.h                  |    1 -
 include/linux/fs.h                    |    8 ++++++-
 kernel/futex.c                        |    2 +-
 kernel/sysctl.c                       |    2 +-
 mm/shmem.c                            |    2 +-
 mm/tiny-shmem.c                       |    2 +-
 net/socket.c                          |    2 +-
 16 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 077f212..f23ab3a 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -2162,7 +2162,7 @@ pfm_alloc_fd(struct file **cfile)
 
 	ret = -ENFILE;
 
-	file = get_empty_filp();
+	file = get_empty_filp(0);
 	if (!file) goto out;
 
 	/*
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index ff092a0..4f7137c 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -525,7 +525,7 @@ struct file *ib_uverbs_alloc_event_file(
 		goto err;
 	}
 
-	filp = get_empty_filp();
+	filp = get_empty_filp(0);
 	if (!filp) {
 		ret = -ENFILE;
 		goto err_fd;
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1b4491c..f774038 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -714,7 +714,7 @@ static int ep_getfd(int *efd, struct ino
 
 	/* Get an ready to use file */
 	error = -ENFILE;
-	file = get_empty_filp();
+	file = get_empty_filp(0);
 	if (!file)
 		goto eexit_1;
 
diff --git a/fs/file_table.c b/fs/file_table.c
index bcea199..300e7c2 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -34,6 +34,7 @@ struct files_stat_struct files_stat = {
 __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
+static atomic_t nr_kernel_files;
 
 static inline void file_free_rcu(struct rcu_head *head)
 {
@@ -43,7 +44,10 @@ static inline void file_free_rcu(struct 
 
 static inline void file_free(struct file *f)
 {
-	percpu_counter_dec(&nr_files);
+	if (!(f->f_kernel_flags & FKFLAGS_KERNEL))
+		percpu_counter_dec(&nr_files);
+	else
+		atomic_dec(&nr_kernel_files);
 	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
@@ -72,6 +76,7 @@ int proc_nr_files(ctl_table *table, int 
                      void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	files_stat.nr_files = get_nr_files();
+	files_stat.nr_kernel_files = atomic_read(&nr_kernel_files);
 	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
 }
 #else
@@ -86,7 +91,7 @@ int proc_nr_files(ctl_table *table, int 
  * Returns NULL, if there are no more free file structures or
  * we run out of memory.
  */
-struct file *get_empty_filp(void)
+struct file *get_empty_filp(int kernel)
 {
 	struct task_struct *tsk;
 	static int old_max;
@@ -95,20 +100,29 @@ struct file *get_empty_filp(void)
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
+	if (!kernel) {
+		if (get_nr_files() >= files_stat.max_files &&
+		    !capable(CAP_SYS_ADMIN)
+		    ) {
+			/*
+			 * percpu_counters are inaccurate.  Do an expensive
+			 * check before we go and fail.
+			 */
+			if (percpu_counter_sum(&nr_files) >=
+			    files_stat.max_files)
+				goto over;
+		}
 	}
 
 	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
 	if (f == NULL)
 		goto fail;
 
-	percpu_counter_inc(&nr_files);
+	if (!kernel)
+		percpu_counter_inc(&nr_files);
+	else
+		atomic_inc(&nr_kernel_files);
+
 	memset(f, 0, sizeof(*f));
 	if (security_file_alloc(f))
 		goto fail_sec;
@@ -117,6 +131,7 @@ struct file *get_empty_filp(void)
 	INIT_LIST_HEAD(&f->f_u.fu_list);
 	atomic_set(&f->f_count, 1);
 	rwlock_init(&f->f_owner.lock);
+	f->f_kernel_flags = kernel ? FKFLAGS_KERNEL : 0;
 	f->f_uid = tsk->fsuid;
 	f->f_gid = tsk->fsgid;
 	eventpoll_init_file(f);
@@ -235,6 +250,7 @@ struct file fastcall *fget_light(unsigne
 	return file;
 }
 
+EXPORT_SYMBOL(fget_light);
 
 void put_filp(struct file *file)
 {
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3a5b4e9..cc27ee8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -770,7 +770,7 @@ struct file *hugetlb_zero_setup(size_t s
 		goto out_shm_unlock;
 
 	error = -ENFILE;
-	file = get_empty_filp();
+	file = get_empty_filp(0);
 	if (!file)
 		goto out_dentry;
 
diff --git a/fs/inotify.c b/fs/inotify.c
index 1f50302..2e66e05 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -939,7 +939,7 @@ asmlinkage long sys_inotify_init(void)
 	if (fd < 0)
 		return fd;
 
-	filp = get_empty_filp();
+	filp = get_empty_filp(0);
 	if (!filp) {
 		ret = -ENFILE;
 		goto out_put_fd;
diff --git a/fs/namei.c b/fs/namei.c
index 96723ae..6713213 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1146,7 +1146,7 @@ static int __path_lookup_intent_open(int
 		unsigned int lookup_flags, struct nameidata *nd,
 		int open_flags, int create_mode)
 {
-	struct file *filp = get_empty_filp();
+	struct file *filp = get_empty_filp(0);
 	int err;
 
 	if (filp == NULL)
diff --git a/fs/open.c b/fs/open.c
index 53ec28c..cea1538 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -962,7 +962,7 @@ struct file *dentry_open(struct dentry *
 	struct file *f;
 
 	error = -ENFILE;
-	f = get_empty_filp();
+	f = get_empty_filp(0);
 	if (f == NULL) {
 		dput(dentry);
 		mntput(mnt);
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
+	f = get_empty_filp(1);
+	if (f == NULL) {
+		dput(dentry);
+		mntput(mnt);
+		return ERR_PTR(error);
+	}
+
+	return __dentry_open(dentry, mnt, flags, f, NULL);
+}
+EXPORT_SYMBOL(dentry_open_kernel);
+
+/*
  * Find an empty file descriptor entry, and mark it busy.
  */
 int get_unused_fd(void)
diff --git a/fs/pipe.c b/fs/pipe.c
index 7fefb10..6081367 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -795,11 +795,11 @@ int do_pipe(int *fd)
 	int i, j;
 
 	error = -ENFILE;
-	f1 = get_empty_filp();
+	f1 = get_empty_filp(0);
 	if (!f1)
 		goto no_files;
 
-	f2 = get_empty_filp();
+	f2 = get_empty_filp(0);
 	if (!f2)
 		goto close_f1;
 
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
index 3de2bfb..979b1d3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -33,6 +33,7 @@ struct files_stat_struct {
 	int nr_files;		/* read only */
 	int nr_free_files;	/* read only */
 	int max_files;		/* tunable */
+	int nr_kernel_files;	/* read only */
 };
 extern struct files_stat_struct files_stat;
 extern int get_max_files(void);
@@ -70,6 +71,8 @@ extern int dir_notify_enable;
    behavior for cross-node execution/opening_for_writing of files */
 #define FMODE_EXEC	16
 
+#define FKFLAGS_KERNEL	1		/* kernel internal file (not accounted) */
+
 #define RW_MASK		1
 #define RWA_MASK	2
 #define READ 0
@@ -640,6 +643,7 @@ struct file {
 	atomic_t		f_count;
 	unsigned int 		f_flags;
 	mode_t			f_mode;
+	unsigned short		f_kernel_flags;
 	loff_t			f_pos;
 	struct fown_struct	f_owner;
 	unsigned int		f_uid, f_gid;
@@ -1377,6 +1381,7 @@ extern long do_sys_open(int fdf, const c
 			int mode);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
+extern struct file * dentry_open_kernel(struct dentry *, struct vfsmount *, int);
 extern int filp_close(struct file *, fl_owner_t id);
 extern char * getname(const char __user *);
 
@@ -1577,7 +1582,7 @@ static inline void insert_inode_hash(str
 	__insert_inode_hash(inode, inode->i_ino);
 }
 
-extern struct file * get_empty_filp(void);
+extern struct file * get_empty_filp(int kernel);
 extern void file_move(struct file *f, struct list_head *list);
 extern void file_kill(struct file *f);
 struct bio;
@@ -1603,6 +1608,7 @@ extern ssize_t generic_file_direct_write
 		unsigned long *, loff_t, loff_t *, size_t, size_t);
 extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
+extern int generic_file_buffered_write_one_kernel_page(struct file *, pgoff_t, struct page *);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
diff --git a/kernel/futex.c b/kernel/futex.c
index 5699c51..7c334f3 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -779,7 +779,7 @@ static int futex_fd(unsigned long uaddr,
 	ret = get_unused_fd();
 	if (ret < 0)
 		goto out;
-	filp = get_empty_filp();
+	filp = get_empty_filp(0);
 	if (!filp) {
 		put_unused_fd(ret);
 		ret = -ENFILE;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e82726f..e8f9b5f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -943,7 +943,7 @@ static ctl_table fs_table[] = {
 		.ctl_name	= FS_NRFILE,
 		.procname	= "file-nr",
 		.data		= &files_stat,
-		.maxlen		= 3*sizeof(int),
+		.maxlen		= 4*sizeof(int),
 		.mode		= 0444,
 		.proc_handler	= &proc_nr_files,
 	},
diff --git a/mm/shmem.c b/mm/shmem.c
index 37eaf42..83bbbe8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2311,7 +2311,7 @@ struct file *shmem_file_setup(char *name
 		goto put_memory;
 
 	error = -ENFILE;
-	file = get_empty_filp();
+	file = get_empty_filp(0);
 	if (!file)
 		goto put_dentry;
 
diff --git a/mm/tiny-shmem.c b/mm/tiny-shmem.c
index f9d6a9c..b014dd5 100644
--- a/mm/tiny-shmem.c
+++ b/mm/tiny-shmem.c
@@ -71,7 +71,7 @@ struct file *shmem_file_setup(char *name
 		goto put_memory;
 
 	error = -ENFILE;
-	file = get_empty_filp();
+	file = get_empty_filp(0);
 	if (!file)
 		goto put_dentry;
 
diff --git a/net/socket.c b/net/socket.c
index 23898f4..9743df2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -377,7 +377,7 @@ static int sock_alloc_fd(struct file **f
 
 	fd = get_unused_fd();
 	if (likely(fd >= 0)) {
-		struct file *file = get_empty_filp();
+		struct file *file = get_empty_filp(0);
 
 		*filep = file;
 		if (unlikely(!file)) {

