Return-Path: <linux-kernel-owner+w=401wt.eu-S1751011AbXANOZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbXANOZl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 09:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXANOZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 09:25:41 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:20839 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbXANOZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 09:25:40 -0500
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 6/10] mm: be sure to trim blocks
References: <20070113011159.9449.4327.sendpatchset@linux.site>
	<20070113011255.9449.33228.sendpatchset@linux.site>
From: Dmitriy Monakhov <dmonakhov@sw.ru>
Date: Sun, 14 Jan 2007 17:25:44 +0300
In-Reply-To: <20070113011255.9449.33228.sendpatchset@linux.site> (Nick Piggin's message of "Sat, 13 Jan 2007 04:25:11 +0100 (CET)")
Message-ID: <87bql1lm6v.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> writes:

> If prepare_write fails with AOP_TRUNCATED_PAGE, or if commit_write fails, then
> we may have failed the write operation despite prepare_write having
> instantiated blocks past i_size. Fix this, and consolidate the trimming into
> one place.
>
> Signed-off-by: Nick Piggin <npiggin@suse.de>
>
> Index: linux-2.6/mm/filemap.c
> ===================================================================
> --- linux-2.6.orig/mm/filemap.c
> +++ linux-2.6/mm/filemap.c
> @@ -1911,22 +1911,9 @@ generic_file_buffered_write(struct kiocb
>  		}
>  
>  		status = a_ops->prepare_write(file, page, offset, offset+bytes);
> -		if (unlikely(status)) {
> -			loff_t isize = i_size_read(inode);
> +		if (unlikely(status))
> +			goto fs_write_aop_error;
May be it's stupid question but still..
Why we treat non zero prepare_write() return code as error, it may be positive.
Positive error code may be used as fine grained 'bytes' limiter in case of 
blksize < pgsize as follows:

                status = a_ops->prepare_write(file, page, offset, offset+bytes);
		if (unlikely(status)) {
                        if (status > 0) {
                                bytes = min(bytes, status);
                                status = 0;
                        } else {
                	        goto fs_write_aop_error;
                        }
                }
---
This is useful because fs may want to reduce 'bytes' by number of reasons,
for example make it blksize bound. 
Example : filesystem has 1k blksize and only two free blocks. And we try 
write 4k bytes.
Currently  write(fd, buff, 4096) will return -ENOSPC
But after this fix write(fd, buff, 4096) will return as mutch as it can (2048).
>  
> -			if (status != AOP_TRUNCATED_PAGE)
> -				unlock_page(page);
> -			page_cache_release(page);
> -			if (status == AOP_TRUNCATED_PAGE)
> -				continue;
> -			/*
> -			 * prepare_write() may have instantiated a few blocks
> -			 * outside i_size.  Trim these off again.
> -			 */
> -			if (pos + bytes > isize)
> -				vmtruncate(inode, isize);
> -			break;
> -		}
>  		if (likely(nr_segs == 1))
>  			copied = filemap_copy_from_user(page, offset,
>  							buf, bytes);
> @@ -1935,10 +1922,9 @@ generic_file_buffered_write(struct kiocb
>  						cur_iov, iov_offset, bytes);
>  		flush_dcache_page(page);
>  		status = a_ops->commit_write(file, page, offset, offset+bytes);
> -		if (status == AOP_TRUNCATED_PAGE) {
> -			page_cache_release(page);
> -			continue;
> -		}
> +		if (unlikely(status))
> +			goto fs_write_aop_error;
> +
>  		if (likely(copied > 0)) {
>  			if (!status)
>  				status = copied;
> @@ -1969,6 +1955,25 @@ generic_file_buffered_write(struct kiocb
>  			break;
>  		balance_dirty_pages_ratelimited(mapping);
>  		cond_resched();
> +		continue;
> +
> +fs_write_aop_error:
> +		if (status != AOP_TRUNCATED_PAGE)
> +			unlock_page(page);
> +		page_cache_release(page);
> +
> +		/*
> +		 * prepare_write() may have instantiated a few blocks
> +		 * outside i_size.  Trim these off again. Don't need
> +		 * i_size_read because we hold i_mutex.
> +		 */
> +		if (pos + bytes > inode->i_size)
> +			vmtruncate(inode, inode->i_size);
> +		if (status == AOP_TRUNCATED_PAGE)
> +			continue;
> +		else
> +			break;
> +
>  	} while (count);
>  	*ppos = pos;
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

