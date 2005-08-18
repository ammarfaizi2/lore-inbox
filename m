Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVHRJFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVHRJFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVHRJFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:05:39 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:50412 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932134AbVHRJFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:05:38 -0400
Message-ID: <43044F55.4040901@cosmosbay.com>
Date: Thu, 18 Aug 2005 11:05:25 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@linux.intel.com>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Put the very large file_ra_state outside of 'struct file'
References: <20050810164655.GB4162@linux.intel.com> <20050810.135306.79296985.davem@davemloft.net> <20050810211737.GA21581@linux.intel.com> <430391F1.9080900@cosmosbay.com> <20050817211829.GK27628@wotan.suse.de> <4303AEC4.3060901@cosmosbay.com> <20050817215357.GU3996@wotan.suse.de> <4303D90E.2030103@cosmosbay.com>
In-Reply-To: <4303D90E.2030103@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------030705030400050509080401"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 18 Aug 2005 11:05:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705030400050509080401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH]

* struct file cleanup : the very large file_ra_state is now allocated only on demand, using a dedicated "filp_ra_cache" slab.
     machines handling lot of sockets or pipes can save about 80 bytes (or 40 bytes on 32bits platforms) per file.

* private_data : The field is moved close to f_count and f_op fields to speedup sockfd_lookups

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------030705030400050509080401
Content-Type: text/plain;
 name="readahead.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="readahead.patch"

--- linux-2.6.13-rc6/include/linux/fs.h	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/include/linux/fs.h	2005-08-18 10:30:35.000000000 +0200
@@ -586,20 +586,18 @@
 	struct dentry		*f_dentry;
 	struct vfsmount         *f_vfsmnt;
 	struct file_operations	*f_op;
+	void			*private_data;
 	atomic_t		f_count;
 	unsigned int 		f_flags;
 	mode_t			f_mode;
 	loff_t			f_pos;
 	struct fown_struct	f_owner;
 	unsigned int		f_uid, f_gid;
-	struct file_ra_state	f_ra;
 
 	size_t			f_maxcount;
 	unsigned long		f_version;
 	void			*f_security;
 
-	/* needed for tty driver, and maybe others */
-	void			*private_data;
 
 #ifdef CONFIG_EPOLL
 	/* Used by fs/eventpoll.c to link all the hooks to this file */
@@ -1480,7 +1478,10 @@
 	__insert_inode_hash(inode, inode->i_ino);
 }
 
-extern struct file * get_empty_filp(void);
+#define FILP_NO_READ_AHEAD   0
+#define FILP_WITH_READ_AHEAD 1
+extern struct file * get_empty_filp(int need_read_ahead);
+
 extern void file_move(struct file *f, struct list_head *list);
 extern void file_kill(struct file *f);
 struct bio;
@@ -1514,8 +1515,7 @@
 extern void do_generic_mapping_read(struct address_space *mapping,
 				    struct file_ra_state *, struct file *,
 				    loff_t *, read_descriptor_t *, read_actor_t);
-extern void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
+extern void file_ra_state_init(struct file *);
 extern ssize_t generic_file_direct_IO(int rw, struct kiocb *iocb,
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
@@ -1545,12 +1545,16 @@
 }
 #endif
 
+static inline struct file_ra_state *get_ra_state(struct file *f)
+{
+	return (struct file_ra_state *)(f+1);
+}
 static inline void do_generic_file_read(struct file * filp, loff_t *ppos,
 					read_descriptor_t * desc,
 					read_actor_t actor)
 {
 	do_generic_mapping_read(filp->f_mapping,
-				&filp->f_ra,
+				get_ra_state(filp),
 				filp,
 				ppos,
 				desc,
--- linux-2.6.13-rc6/include/linux/slab.h	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/include/linux/slab.h	2005-08-18 09:46:40.000000000 +0200
@@ -125,6 +125,7 @@
 extern kmem_cache_t	*names_cachep;
 extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
+extern kmem_cache_t	*filp_ra_cachep;
 extern kmem_cache_t	*fs_cachep;
 extern kmem_cache_t	*signal_cachep;
 extern kmem_cache_t	*sighand_cachep;
--- linux-2.6.13-rc6/mm/readahead.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/mm/readahead.c	2005-08-18 10:41:13.000000000 +0200
@@ -33,9 +33,10 @@
  * memset *ra to zero.
  */
 void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
+file_ra_state_init(struct file *file)
 {
-	ra->ra_pages = mapping->backing_dev_info->ra_pages;
+	struct file_ra_state *ra = get_ra_state(file);
+	ra->ra_pages = file->f_mapping->host->i_mapping->backing_dev_info->ra_pages;
 	ra->prev_page = -1;
 }
 
--- linux-2.6.13-rc6/mm/filemap.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/mm/filemap.c	2005-08-18 10:46:53.000000000 +0200
@@ -1187,7 +1187,7 @@
 	int error;
 	struct file *file = area->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	struct file_ra_state *ra = &file->f_ra;
+	struct file_ra_state *ra = get_ra_state(file);
 	struct inode *inode = mapping->host;
 	struct page *page;
 	unsigned long size, pgoff;
@@ -1243,7 +1243,7 @@
 			inc_page_state(pgmajfault);
 		}
 		did_readaround = 1;
-		ra_pages = max_sane_readahead(file->f_ra.ra_pages);
+		ra_pages = max_sane_readahead(ra->ra_pages);
 		if (ra_pages) {
 			pgoff_t start = 0;
 
--- linux-2.6.13-rc6/mm/fadvise.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/mm/fadvise.c	2005-08-18 10:44:16.000000000 +0200
@@ -28,6 +28,7 @@
 	struct file *file = fget(fd);
 	struct address_space *mapping;
 	struct backing_dev_info *bdi;
+	struct file_ra_state *ra;
 	loff_t endbyte;
 	pgoff_t start_index;
 	pgoff_t end_index;
@@ -54,15 +55,20 @@
 
 	bdi = mapping->backing_dev_info;
 
+	/*
+	 * FIXME : Are we sure here this 'file' has ra_state available ?
+	 */
+	ra = get_ra_state(file);
+
 	switch (advice) {
 	case POSIX_FADV_NORMAL:
-		file->f_ra.ra_pages = bdi->ra_pages;
+		ra->ra_pages = bdi->ra_pages;
 		break;
 	case POSIX_FADV_RANDOM:
-		file->f_ra.ra_pages = 0;
+		ra->ra_pages = 0;
 		break;
 	case POSIX_FADV_SEQUENTIAL:
-		file->f_ra.ra_pages = bdi->ra_pages * 2;
+		ra->ra_pages = bdi->ra_pages * 2;
 		break;
 	case POSIX_FADV_WILLNEED:
 	case POSIX_FADV_NOREUSE:
--- linux-2.6.13-rc6/fs/file_table.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/file_table.c	2005-08-18 10:46:53.000000000 +0200
@@ -53,16 +53,20 @@
 	spin_unlock_irqrestore(&filp_count_lock, flags);
 }
 
+/*
+ * a file can belong to different kmem_cache (filp_cache or filp_ra_cache),
+ * so let kfree() find it
+ */
 static inline void file_free(struct file *f)
 {
-	kmem_cache_free(filp_cachep, f);
+	kfree(f);
 }
 
 /* Find an unused file structure and return a pointer to it.
  * Returns NULL, if there are no more free file structures or
  * we run out of memory.
  */
-struct file *get_empty_filp(void)
+struct file *get_empty_filp(int need_read_ahead)
 {
 	static int old_max;
 	struct file * f;
@@ -74,11 +78,11 @@
 				!capable(CAP_SYS_ADMIN))
 		goto over;
 
-	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
+	f = kmem_cache_alloc(need_read_ahead ? filp_ra_cachep : filp_cachep, GFP_KERNEL);
 	if (f == NULL)
 		goto fail;
 
-	memset(f, 0, sizeof(*f));
+	memset(f, 0, need_read_ahead ? sizeof(struct file) + sizeof(struct file_ra_state) : sizeof(struct file));
 	if (security_file_alloc(f))
 		goto fail_sec;
 
--- linux-2.6.13-rc6/fs/open.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/open.c	2005-08-18 10:30:35.000000000 +0200
@@ -778,7 +778,7 @@
 	int error;
 
 	error = -ENFILE;
-	f = get_empty_filp();
+	f = get_empty_filp(FILP_WITH_READ_AHEAD);
 	if (!f)
 		goto cleanup_dentry;
 	f->f_flags = flags;
@@ -804,7 +804,7 @@
 	}
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
-	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
+	file_ra_state_init(f);
 
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
--- linux-2.6.13-rc6/fs/dcache.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/dcache.c	2005-08-18 09:48:41.000000000 +0200
@@ -1703,8 +1703,10 @@
 /* SLAB cache for __getname() consumers */
 kmem_cache_t *names_cachep;
 
-/* SLAB cache for file structures */
+/* SLAB cache for file structures without read ahead state data */
 kmem_cache_t *filp_cachep;
+/* SLAB cache for file structures with read ahead state data */
+kmem_cache_t *filp_ra_cachep;
 
 EXPORT_SYMBOL(d_genocide);
 
@@ -1733,6 +1735,9 @@
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
 
+	filp_ra_cachep = kmem_cache_create("filp_ra", sizeof(struct file) + sizeof(struct file_ra_state), 0,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
+
 	dcache_init(mempages);
 	inode_init(mempages);
 	files_init(mempages);
--- linux-2.6.13-rc6/net/socket.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/net/socket.c	2005-08-18 10:30:35.000000000 +0200
@@ -375,7 +375,7 @@
 
 	fd = get_unused_fd();
 	if (fd >= 0) {
-		struct file *file = get_empty_filp();
+		struct file *file = get_empty_filp(FILP_NO_READ_AHEAD);
 
 		if (!file) {
 			put_unused_fd(fd);
--- linux-2.6.13-rc6/fs/eventpoll.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/eventpoll.c	2005-08-18 10:30:35.000000000 +0200
@@ -717,7 +717,7 @@
 
 	/* Get an ready to use file */
 	error = -ENFILE;
-	file = get_empty_filp();
+	file = get_empty_filp(FILP_NO_READ_AHEAD);
 	if (!file)
 		goto eexit_1;
 
--- linux-2.6.13-rc6/kernel/futex.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/kernel/futex.c	2005-08-18 10:30:35.000000000 +0200
@@ -661,7 +661,7 @@
 	ret = get_unused_fd();
 	if (ret < 0)
 		goto out;
-	filp = get_empty_filp();
+	filp = get_empty_filp(FILP_NO_READ_AHEAD);
 	if (!filp) {
 		put_unused_fd(ret);
 		ret = -ENFILE;
--- linux-2.6.13-rc6/mm/shmem.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/mm/shmem.c	2005-08-18 10:30:35.000000000 +0200
@@ -2272,7 +2272,7 @@
 		goto put_memory;
 
 	error = -ENFILE;
-	file = get_empty_filp();
+	file = get_empty_filp(FILP_WITH_READ_AHEAD);
 	if (!file)
 		goto put_dentry;
 
--- linux-2.6.13-rc6/fs/pipe.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/pipe.c	2005-08-18 10:30:35.000000000 +0200
@@ -723,11 +723,11 @@
 	int i,j;
 
 	error = -ENFILE;
-	f1 = get_empty_filp();
+	f1 = get_empty_filp(FILP_NO_READ_AHEAD);
 	if (!f1)
 		goto no_files;
 
-	f2 = get_empty_filp();
+	f2 = get_empty_filp(FILP_NO_READ_AHEAD);
 	if (!f2)
 		goto close_f1;
 
--- linux-2.6.13-rc6/fs/inotify.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/inotify.c	2005-08-18 10:30:35.000000000 +0200
@@ -865,7 +865,7 @@
 	if (fd < 0)
 		return fd;
 
-	filp = get_empty_filp();
+	filp = get_empty_filp(FILP_NO_READ_AHEAD);
 	if (!filp) {
 		ret = -ENFILE;
 		goto out_put_fd;
--- linux-2.6.13-rc6/fs/hugetlbfs/inode.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/hugetlbfs/inode.c	2005-08-18 10:30:35.000000000 +0200
@@ -785,7 +785,7 @@
 		goto out_shm_unlock;
 
 	error = -ENFILE;
-	file = get_empty_filp();
+	file = get_empty_filp(FILP_WITH_READ_AHEAD);
 	if (!file)
 		goto out_dentry;
 
--- linux-2.6.13-rc6/arch/ia64/kernel/perfmon.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/arch/ia64/kernel/perfmon.c	2005-08-18 10:36:28.000000000 +0200
@@ -2157,7 +2157,7 @@
 
 	ret = -ENFILE;
 
-	file = get_empty_filp();
+	file = get_empty_filp(FILP_WITH_READ_AHEAD);
 	if (!file) goto out;
 
 	/*
--- linux-2.6.13-rc6/drivers/infiniband/core/uverbs_main.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/drivers/infiniband/core/uverbs_main.c	2005-08-18 10:30:35.000000000 +0200
@@ -367,7 +367,7 @@
 	if (file->fd < 0)
 		return file->fd;
 
-	filp = get_empty_filp();
+	filp = get_empty_filp(FILP_NO_READ_AHEAD);
 	if (!filp) {
 		put_unused_fd(file->fd);
 		return -ENFILE;
--- linux-2.6.13-rc6/mm/tiny-shmem.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/mm/tiny-shmem.c	2005-08-18 10:30:35.000000000 +0200
@@ -68,7 +68,7 @@
 		goto put_memory;
 
 	error = -ENFILE;
-	file = get_empty_filp();
+	file = get_empty_filp(FILP_WITH_READ_AHEAD);
 	if (!file)
 		goto put_dentry;
 

--------------030705030400050509080401--
