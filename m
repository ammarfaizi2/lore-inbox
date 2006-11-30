Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031553AbWK3WOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031553AbWK3WOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031558AbWK3WOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:14:40 -0500
Received: from mail.parknet.jp ([210.171.160.80]:25867 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1031553AbWK3WOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:14:38 -0500
X-AuthUser: hirofumi@parknet.jp
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
References: <20061130072058.GA18004@wotan.suse.de>
	<20061130072202.GB18004@wotan.suse.de>
	<20061130072247.GC18004@wotan.suse.de>
	<20061130113241.GC12579@wotan.suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 01 Dec 2006 07:14:28 +0900
In-Reply-To: <20061130113241.GC12579@wotan.suse.de> (Nick Piggin's message of "Thu\, 30 Nov 2006 12\:32\:42 +0100")
Message-ID: <87r6vkzinv.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> writes:

> Rework the cont filesystem helpers so that generic_cont_expand does the
> actual work of expanding the file. cont_prepare_write then calls this
> routine if expanding is needed, and retries. Also solves the problem
> where cont_prepare_write would previously hold the target page locked
> while doing not-very-nice things like locking other pages.
>
> Means that zero-length prepare/commit_write pairs are no longer needed
> as an overloaded directive to extend the file, thus cont should operate
> better within the new deadlock-free buffered write code.
>
> Converts fat over to the new cont scheme.
>
> Signed-off-by: Nick Piggin <npiggin@suse.de>
>
>
> Index: linux-2.6/fs/buffer.c
> ===================================================================
> --- linux-2.6.orig/fs/buffer.c
> +++ linux-2.6/fs/buffer.c
> @@ -2004,19 +2004,20 @@ int block_read_full_page(struct page *pa
>  	return 0;
>  }
>  
> -/* utility function for filesystems that need to do work on expanding
> - * truncates.  Uses prepare/commit_write to allow the filesystem to
> - * deal with the hole.  
> +/*
> + * Utility function for filesystems that need to do work on expanding
> + * truncates. For moronic filesystems that do not allow holes in file.
>   */
> -static int __generic_cont_expand(struct inode *inode, loff_t size,
> -				 pgoff_t index, unsigned int offset)
> +int generic_cont_expand(struct inode *inode, loff_t size, loff_t *bytes,
> +						get_block_t *get_block)
>  {
>  	struct address_space *mapping = inode->i_mapping;
> +	unsigned long blocksize = 1 << inode->i_blkbits;
>  	struct page *page;
>  	unsigned long limit;
> -	int err;
> +	int status;
>  
> -	err = -EFBIG;
> +	status = -EFBIG;
>          limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
>  	if (limit != RLIM_INFINITY && size > (loff_t)limit) {
>  		send_sig(SIGXFSZ, current, 0);
> @@ -2025,146 +2026,83 @@ static int __generic_cont_expand(struct 
>  	if (size > inode->i_sb->s_maxbytes)
>  		goto out;
>  
> -	err = -ENOMEM;
> -	page = grab_cache_page(mapping, index);
> -	if (!page)
> -		goto out;
> -	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
> -	if (err) {
> -		/*
> -		 * ->prepare_write() may have instantiated a few blocks
> -		 * outside i_size.  Trim these off again.
> -		 */
> -		unlock_page(page);
> -		page_cache_release(page);
> -		vmtruncate(inode, inode->i_size);
> -		goto out;
> -	}
> +	status = 0;
>  
> -	err = mapping->a_ops->commit_write(NULL, page, offset, offset);
> +	while (*bytes < size) {
> +		unsigned int zerofrom;
> +		unsigned int zeroto;
> +		void *kaddr;
> +		pgoff_t pgpos;
> +
> +		pgpos = *bytes >> PAGE_CACHE_SHIFT;
> +		page = grab_cache_page(mapping, pgpos);
> +		if (!page) {
> +			status = -ENOMEM;
> +			break;
> +		}
> +		/* we might sleep */
> +		if (*bytes >> PAGE_CACHE_SHIFT != pgpos)
> +			goto unlock;
>  
> -	unlock_page(page);
> -	page_cache_release(page);
> -	if (err > 0)
> -		err = 0;
> -out:
> -	return err;
> -}
> +		zerofrom = *bytes & ~PAGE_CACHE_MASK;
> +		if (zerofrom & (blocksize-1))
> +			*bytes = (*bytes + blocksize-1) & (blocksize-1);
>  
> -int generic_cont_expand(struct inode *inode, loff_t size)
> -{
> -	pgoff_t index;
> -	unsigned int offset;
> +		zeroto = PAGE_CACHE_SIZE;
>  
> -	offset = (size & (PAGE_CACHE_SIZE - 1)); /* Within page */
> +		status = __block_prepare_write(inode, page, zerofrom,
> +						zeroto, get_block);
> +		if (status)
> +			goto unlock;
> +		kaddr = kmap_atomic(page, KM_USER0);
> +		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
> +		flush_dcache_page(page);
> +		kunmap_atomic(kaddr, KM_USER0);
> +		status = __block_commit_write(inode, page, zerofrom, zeroto);
>  
> -	/* ugh.  in prepare/commit_write, if from==to==start of block, we
> -	** skip the prepare.  make sure we never send an offset for the start
> -	** of a block
> -	*/
> -	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
> -		/* caller must handle this extra byte. */
> -		offset++;
> +unlock:
> +		unlock_page(page);
> +		page_cache_release(page);
> +		if (status) {
> +			BUG_ON(status == AOP_TRUNCATED_PAGE);
> +			break;
> +		}
>  	}
> -	index = size >> PAGE_CACHE_SHIFT;
>  
> -	return __generic_cont_expand(inode, size, index, offset);
> -}
> -
> -int generic_cont_expand_simple(struct inode *inode, loff_t size)
> -{
> -	loff_t pos = size - 1;
> -	pgoff_t index = pos >> PAGE_CACHE_SHIFT;
> -	unsigned int offset = (pos & (PAGE_CACHE_SIZE - 1)) + 1;
> +	/*
> +	 * No need to use i_size_read() here, the i_size
> +	 * cannot change under us because we hold i_mutex.
> +	 */
> +	if (size > inode->i_size) {
> +		i_size_write(inode, size);
> +		mark_inode_dirty(inode);
> +	}
>  
> -	/* prepare/commit_write can handle even if from==to==start of block. */
> -	return __generic_cont_expand(inode, size, index, offset);
> +out:
> +	return status;
>  }

quick look. Doesn't this break reiserfs? IIRC, the reiserfs is using
it for another reason. I was also working for this, but I lost the
thread of this, sorry.

I found some another users (affs, hfs, hfsplus). Those seem have same
problem, but probably those also can use this...

What do you think?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/buffer.c                 |   59 +++++++++++++++++---------------------------
 fs/fat/file.c               |    2 -
 include/linux/buffer_head.h |    1 
 3 files changed, 24 insertions(+), 38 deletions(-)

diff -puN fs/buffer.c~generic_cont_expand-avoid-zero-size fs/buffer.c
--- linux-2.6/fs/buffer.c~generic_cont_expand-avoid-zero-size	2006-11-13 01:42:01.000000000 +0900
+++ linux-2.6-hirofumi/fs/buffer.c	2006-11-13 02:16:20.000000000 +0900
@@ -2004,18 +2004,24 @@ int block_read_full_page(struct page *pa
 	return 0;
 }
 
-/* utility function for filesystems that need to do work on expanding
+/*
+ * utility function for filesystems that need to do work on expanding
  * truncates.  Uses prepare/commit_write to allow the filesystem to
  * deal with the hole.  
  */
-static int __generic_cont_expand(struct inode *inode, loff_t size,
-				 pgoff_t index, unsigned int offset)
+int generic_cont_expand(struct inode *inode, loff_t size)
 {
 	struct address_space *mapping = inode->i_mapping;
+	loff_t pos = inode->i_size;
 	struct page *page;
 	unsigned long limit;
+	pgoff_t index;
+	unsigned int from, to;
+	void *kaddr;
 	int err;
 
+	WARN_ON(pos >= size);
+
 	err = -EFBIG;
         limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 	if (limit != RLIM_INFINITY && size > (loff_t)limit) {
@@ -2025,11 +2031,18 @@ static int __generic_cont_expand(struct 
 	if (size > inode->i_sb->s_maxbytes)
 		goto out;
 
+	index = (size - 1) >> PAGE_CACHE_SHIFT;
+	to = size - ((loff_t)index << PAGE_CACHE_SHIFT);
+	if (index != (pos >> PAGE_CACHE_SHIFT))
+		from = 0;
+	else
+		from = pos & (PAGE_CACHE_SIZE - 1);
+
 	err = -ENOMEM;
 	page = grab_cache_page(mapping, index);
 	if (!page)
 		goto out;
-	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
+	err = mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err) {
 		/*
 		 * ->prepare_write() may have instantiated a few blocks
@@ -2041,7 +2054,12 @@ static int __generic_cont_expand(struct 
 		goto out;
 	}
 
-	err = mapping->a_ops->commit_write(NULL, page, offset, offset);
+	kaddr = kmap_atomic(page, KM_USER0);
+	memset(kaddr + from, 0, to - from);
+	flush_dcache_page(page);
+	kunmap_atomic(kaddr, KM_USER0);
+
+	err = mapping->a_ops->commit_write(NULL, page, from, to);
 
 	unlock_page(page);
 	page_cache_release(page);
@@ -2051,36 +2069,6 @@ out:
 	return err;
 }
 
-int generic_cont_expand(struct inode *inode, loff_t size)
-{
-	pgoff_t index;
-	unsigned int offset;
-
-	offset = (size & (PAGE_CACHE_SIZE - 1)); /* Within page */
-
-	/* ugh.  in prepare/commit_write, if from==to==start of block, we
-	** skip the prepare.  make sure we never send an offset for the start
-	** of a block
-	*/
-	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
-		/* caller must handle this extra byte. */
-		offset++;
-	}
-	index = size >> PAGE_CACHE_SHIFT;
-
-	return __generic_cont_expand(inode, size, index, offset);
-}
-
-int generic_cont_expand_simple(struct inode *inode, loff_t size)
-{
-	loff_t pos = size - 1;
-	pgoff_t index = pos >> PAGE_CACHE_SHIFT;
-	unsigned int offset = (pos & (PAGE_CACHE_SIZE - 1)) + 1;
-
-	/* prepare/commit_write can handle even if from==to==start of block. */
-	return __generic_cont_expand(inode, size, index, offset);
-}
-
 /*
  * For moronic filesystems that do not allow holes in file.
  * We may have to extend the file.
@@ -3032,7 +3020,6 @@ EXPORT_SYMBOL(fsync_bdev);
 EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(generic_cont_expand);
-EXPORT_SYMBOL(generic_cont_expand_simple);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL(invalidate_bdev);
 EXPORT_SYMBOL(ll_rw_block);
diff -puN include/linux/buffer_head.h~generic_cont_expand-avoid-zero-size include/linux/buffer_head.h
--- linux-2.6/include/linux/buffer_head.h~generic_cont_expand-avoid-zero-size	2006-11-13 01:42:01.000000000 +0900
+++ linux-2.6-hirofumi/include/linux/buffer_head.h	2006-11-13 01:42:01.000000000 +0900
@@ -202,7 +202,6 @@ int block_prepare_write(struct page*, un
 int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
 				loff_t *);
 int generic_cont_expand(struct inode *inode, loff_t size);
-int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
 void block_sync_page(struct page *);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
diff -puN fs/fat/file.c~generic_cont_expand-avoid-zero-size fs/fat/file.c
--- linux-2.6/fs/fat/file.c~generic_cont_expand-avoid-zero-size	2006-11-13 01:42:01.000000000 +0900
+++ linux-2.6-hirofumi/fs/fat/file.c	2006-11-13 01:42:01.000000000 +0900
@@ -143,7 +143,7 @@ static int fat_cont_expand(struct inode 
 	loff_t start = inode->i_size, count = size - inode->i_size;
 	int err;
 
-	err = generic_cont_expand_simple(inode, size);
+	err = generic_cont_expand(inode, size);
 	if (err)
 		goto out;
 
_
