Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVHRAlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVHRAlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVHRAlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:41:13 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:63701 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751327AbVHRAlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:41:12 -0400
Message-ID: <4303D90E.2030103@cosmosbay.com>
Date: Thu, 18 Aug 2005 02:40:46 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Benjamin LaHaise <bcrl@linux.intel.com>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] struct file cleanup : the very large file_ra_state is now
 allocated only on demand.
References: <20050810164655.GB4162@linux.intel.com> <20050810.135306.79296985.davem@davemloft.net> <20050810211737.GA21581@linux.intel.com> <430391F1.9080900@cosmosbay.com> <20050817211829.GK27628@wotan.suse.de> <4303AEC4.3060901@cosmosbay.com> <20050817215357.GU3996@wotan.suse.de>
In-Reply-To: <20050817215357.GU3996@wotan.suse.de>
Content-Type: multipart/mixed;
 boundary="------------010803070300040707000204"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [62.23.185.226]); Thu, 18 Aug 2005 02:40:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803070300040707000204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andi Kleen a écrit :

> 
>>(because of the insane struct file_ra_state f_ra. I wish this structure 
>>were dynamically allocated only for files that really use it)
> 
> 
> How about you submit a patch for that instead? 
> 
> -Andi

OK, could you please comment this patch ?

The problem of dynamically allocating the readahead state data is that the allocation can fail and should not be fatal.
I made some choices that might be not good.

I also chose not to align "file_ra" slab on SLAB_HWCACHE_ALIGN because the object size is 10*sizeof(long), so alignment would loose 
6*sizeof(long) bytes for each object.


[PATCH]

* struct file cleanup : the very large file_ra_state is now allocated only on demand, using a dedicated "file_ra" slab.
	64bits machines handling lot of sockets can save about 72 bytes per file.
* private_data : The field is moved close to f_count and f_op fields to speedup sockfd_lookups

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>




--------------010803070300040707000204
Content-Type: text/plain;
 name="readahead.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="readahead.patch"

--- linux-2.6.13-rc6/include/linux/fs.h	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/include/linux/fs.h	2005-08-18 01:33:04.000000000 +0200
@@ -586,20 +586,19 @@
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
+	struct file_ra_state	*f_rap;
 
 	size_t			f_maxcount;
 	unsigned long		f_version;
 	void			*f_security;
 
-	/* needed for tty driver, and maybe others */
-	void			*private_data;
 
 #ifdef CONFIG_EPOLL
 	/* Used by fs/eventpoll.c to link all the hooks to this file */
@@ -1514,8 +1513,7 @@
 extern void do_generic_mapping_read(struct address_space *mapping,
 				    struct file_ra_state *, struct file *,
 				    loff_t *, read_descriptor_t *, read_actor_t);
-extern void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
+extern struct file_ra_state *file_ra_state_init(struct file *);
 extern ssize_t generic_file_direct_IO(int rw, struct kiocb *iocb,
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
@@ -1549,8 +1547,10 @@
 					read_descriptor_t * desc,
 					read_actor_t actor)
 {
+	if (filp->f_rap == NULL)
+		file_ra_state_init(filp);
 	do_generic_mapping_read(filp->f_mapping,
-				&filp->f_ra,
+				filp->f_rap,
 				filp,
 				ppos,
 				desc,
--- linux-2.6.13-rc6/include/linux/slab.h	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/include/linux/slab.h	2005-08-18 00:37:59.000000000 +0200
@@ -125,6 +125,7 @@
 extern kmem_cache_t	*names_cachep;
 extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
+extern kmem_cache_t	*ra_cachep;
 extern kmem_cache_t	*fs_cachep;
 extern kmem_cache_t	*signal_cachep;
 extern kmem_cache_t	*sighand_cachep;
--- linux-2.6.13-rc6/mm/readahead.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/mm/readahead.c	2005-08-18 01:14:11.000000000 +0200
@@ -29,14 +29,20 @@
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
 
 /*
- * Initialise a struct file's readahead state.  Assumes that the caller has
- * memset *ra to zero.
+ * Initialise a struct file's readahead state.
  */
-void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
+struct file_ra_state *
+file_ra_state_init(struct file *file)
 {
-	ra->ra_pages = mapping->backing_dev_info->ra_pages;
-	ra->prev_page = -1;
+	struct file_ra_state *ra = kmem_cache_alloc(ra_cachep, GFP_KERNEL);
+
+	if (ra != NULL) {
+		file->f_rap = ra;
+		memset(ra, 0, sizeof(*ra));
+		ra->ra_pages = file->f_mapping->host->i_mapping->backing_dev_info->ra_pages;
+		ra->prev_page = -1;
+	}
+	return ra;
 }
 
 /*
--- linux-2.6.13-rc6/mm/filemap.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/mm/filemap.c	2005-08-18 01:33:58.000000000 +0200
@@ -711,7 +711,7 @@
  * NULL.
  */
 void do_generic_mapping_read(struct address_space *mapping,
-			     struct file_ra_state *_ra,
+			     struct file_ra_state *_rap,
 			     struct file *filp,
 			     loff_t *ppos,
 			     read_descriptor_t *desc,
@@ -727,8 +727,15 @@
 	loff_t isize;
 	struct page *cached_page;
 	int error;
-	struct file_ra_state ra = *_ra;
+	struct file_ra_state ra;
 
+	if (likely(_rap != NULL))
+		ra = *_rap;
+	else {
+		memset(&ra, 0, sizeof(ra));
+		ra.prev_page = -1;
+		ra.ra_pages = default_backing_dev_info.ra_pages;
+	}
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
@@ -908,7 +915,8 @@
 	}
 
 out:
-	*_ra = ra;
+	if (_rap != NULL)
+		*_rap = ra;
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
@@ -1187,12 +1195,15 @@
 	int error;
 	struct file *file = area->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	struct file_ra_state *ra = &file->f_ra;
+	struct file_ra_state *ra = file->f_rap;
 	struct inode *inode = mapping->host;
 	struct page *page;
 	unsigned long size, pgoff;
 	int did_readaround = 0, majmin = VM_FAULT_MINOR;
 
+	if (ra == NULL)
+		ra = file_ra_state_init(file);
+
 	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 
 retry_all:
@@ -1225,14 +1236,16 @@
 			handle_ra_miss(mapping, ra, pgoff);
 			goto no_cached_page;
 		}
-		ra->mmap_miss++;
+		if (ra != NULL) {
+			ra->mmap_miss++;
 
-		/*
-		 * Do we miss much more than hit in this file? If so,
-		 * stop bothering with read-ahead. It will only hurt.
-		 */
-		if (ra->mmap_miss > ra->mmap_hit + MMAP_LOTSAMISS)
-			goto no_cached_page;
+			/*
+			 * Do we miss much more than hit in this file? If so,
+			 * stop bothering with read-ahead. It will only hurt.
+			 */
+			if (ra->mmap_miss > ra->mmap_hit + MMAP_LOTSAMISS)
+				goto no_cached_page;
+		}
 
 		/*
 		 * To keep the pgmajfault counter straight, we need to
@@ -1243,7 +1256,7 @@
 			inc_page_state(pgmajfault);
 		}
 		did_readaround = 1;
-		ra_pages = max_sane_readahead(file->f_ra.ra_pages);
+		ra_pages = max_sane_readahead(ra != NULL ? ra->ra_pages : default_backing_dev_info.ra_pages);
 		if (ra_pages) {
 			pgoff_t start = 0;
 
@@ -1256,7 +1269,7 @@
 			goto no_cached_page;
 	}
 
-	if (!did_readaround)
+	if (!did_readaround && ra != NULL)
 		ra->mmap_hit++;
 
 	/*
--- linux-2.6.13-rc6/mm/fadvise.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/mm/fadvise.c	2005-08-18 01:05:15.000000000 +0200
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
 
+	if ((ra = file->f_rap) == NULL)
+		ra = file_ra_state_init(file);
 	switch (advice) {
 	case POSIX_FADV_NORMAL:
-		file->f_ra.ra_pages = bdi->ra_pages;
+		if (ra != NULL)
+			ra->ra_pages = bdi->ra_pages;
 		break;
 	case POSIX_FADV_RANDOM:
-		file->f_ra.ra_pages = 0;
+		if (ra != NULL)
+			ra->ra_pages = 0;
 		break;
 	case POSIX_FADV_SEQUENTIAL:
-		file->f_ra.ra_pages = bdi->ra_pages * 2;
+		if (ra != NULL)
+			ra->ra_pages = bdi->ra_pages * 2;
 		break;
 	case POSIX_FADV_WILLNEED:
 	case POSIX_FADV_NOREUSE:
--- linux-2.6.13-rc6/fs/open.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/open.c	2005-08-18 01:05:15.000000000 +0200
@@ -804,7 +804,7 @@
 	}
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
-	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
+	f->f_rap = NULL;
 
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
--- linux-2.6.13-rc6/fs/file_table.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/file_table.c	2005-08-18 00:37:59.000000000 +0200
@@ -55,6 +55,8 @@
 
 static inline void file_free(struct file *f)
 {
+	if (f->f_rap != NULL)
+		kmem_cache_free(ra_cachep, f->f_rap);
 	kmem_cache_free(filp_cachep, f);
 }
 
--- linux-2.6.13-rc6/fs/dcache.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/dcache.c	2005-08-18 02:22:56.000000000 +0200
@@ -1705,6 +1705,8 @@
 
 /* SLAB cache for file structures */
 kmem_cache_t *filp_cachep;
+/* SLAB cache for ra structures */
+kmem_cache_t *ra_cachep;
 
 EXPORT_SYMBOL(d_genocide);
 
@@ -1733,6 +1735,9 @@
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
 
+	ra_cachep = kmem_cache_create("file_ra", sizeof(struct file_ra_state), 0,
+			SLAB_PANIC, NULL, NULL);
+
 	dcache_init(mempages);
 	inode_init(mempages);
 	files_init(mempages);

--------------010803070300040707000204--
