Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757486AbWLACJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbWLACJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 21:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757639AbWLACJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 21:09:15 -0500
Received: from cantor.suse.de ([195.135.220.2]:8835 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1757486AbWLACJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 21:09:14 -0500
Date: Fri, 1 Dec 2006 03:09:12 +0100
From: Nick Piggin <npiggin@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
Message-ID: <20061201020910.GC455@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de> <20061130072202.GB18004@wotan.suse.de> <20061130072247.GC18004@wotan.suse.de> <20061130113241.GC12579@wotan.suse.de> <87r6vkzinv.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r6vkzinv.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 07:14:28AM +0900, OGAWA Hirofumi wrote:
> 
> quick look. Doesn't this break reiserfs? IIRC, the reiserfs is using
> it for another reason. I was also working for this, but I lost the
> thread of this, sorry.
> 
> I found some another users (affs, hfs, hfsplus). Those seem have same
> problem, but probably those also can use this...
> 
> What do you think?
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> 
> 
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
> 
>  fs/buffer.c                 |   59 +++++++++++++++++---------------------------
>  fs/fat/file.c               |    2 -
>  include/linux/buffer_head.h |    1 
>  3 files changed, 24 insertions(+), 38 deletions(-)
> 
> diff -puN fs/buffer.c~generic_cont_expand-avoid-zero-size fs/buffer.c
> --- linux-2.6/fs/buffer.c~generic_cont_expand-avoid-zero-size	2006-11-13 01:42:01.000000000 +0900
> +++ linux-2.6-hirofumi/fs/buffer.c	2006-11-13 02:16:20.000000000 +0900
> @@ -2004,18 +2004,24 @@ int block_read_full_page(struct page *pa
>  	return 0;
>  }
>  
> -/* utility function for filesystems that need to do work on expanding
> +/*
> + * utility function for filesystems that need to do work on expanding
>   * truncates.  Uses prepare/commit_write to allow the filesystem to
>   * deal with the hole.  
>   */
> -static int __generic_cont_expand(struct inode *inode, loff_t size,
> -				 pgoff_t index, unsigned int offset)
> +int generic_cont_expand(struct inode *inode, loff_t size)
>  {
>  	struct address_space *mapping = inode->i_mapping;
> +	loff_t pos = inode->i_size;
>  	struct page *page;
>  	unsigned long limit;
> +	pgoff_t index;
> +	unsigned int from, to;
> +	void *kaddr;
>  	int err;
>  
> +	WARN_ON(pos >= size);
> +
>  	err = -EFBIG;
>          limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
>  	if (limit != RLIM_INFINITY && size > (loff_t)limit) {
> @@ -2025,11 +2031,18 @@ static int __generic_cont_expand(struct 
>  	if (size > inode->i_sb->s_maxbytes)
>  		goto out;
>  
> +	index = (size - 1) >> PAGE_CACHE_SHIFT;
> +	to = size - ((loff_t)index << PAGE_CACHE_SHIFT);
> +	if (index != (pos >> PAGE_CACHE_SHIFT))
> +		from = 0;
> +	else
> +		from = pos & (PAGE_CACHE_SIZE - 1);
> +
>  	err = -ENOMEM;
>  	page = grab_cache_page(mapping, index);
>  	if (!page)
>  		goto out;
> -	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
> +	err = mapping->a_ops->prepare_write(NULL, page, from, to);
>  	if (err) {
>  		/*
>  		 * ->prepare_write() may have instantiated a few blocks
> @@ -2041,7 +2054,12 @@ static int __generic_cont_expand(struct 
>  		goto out;
>  	}
>  
> -	err = mapping->a_ops->commit_write(NULL, page, offset, offset);
> +	kaddr = kmap_atomic(page, KM_USER0);
> +	memset(kaddr + from, 0, to - from);
> +	flush_dcache_page(page);
> +	kunmap_atomic(kaddr, KM_USER0);
> +
> +	err = mapping->a_ops->commit_write(NULL, page, from, to);

So basically this is changing from having prepare_write do all the
zeroing, to zeroing the last page in generic_cont_expand, so that
we don't have to pass a zero-length to prepare_write?

