Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289091AbSAGCrG>; Sun, 6 Jan 2002 21:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289092AbSAGCq5>; Sun, 6 Jan 2002 21:46:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30295 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289091AbSAGCqo>; Sun, 6 Jan 2002 21:46:44 -0500
Date: Mon, 7 Jan 2002 03:46:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
Message-ID: <20020107034654.G1561@athlon.random>
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>; from akpm@zip.com.au on Sat, Jan 05, 2002 at 03:08:25AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 03:08:25AM -0800, Andrew Morton wrote:
> @@ -1639,6 +1666,17 @@ static int __block_prepare_write(struct 
>  	}
>  	return 0;
>  out:
> +	bh = head;
> +	block_start = 0;
> +	do {
> +		if (buffer_new(bh) && !buffer_uptodate(bh)) {
> +			memset(kaddr+block_start, 0, bh->b_size);
> +			set_bit(BH_Uptodate, &bh->b_state);
> +			mark_buffer_dirty(bh);
> +		}
> +		block_start += bh->b_size;
> +		bh = bh->b_this_page;
> +	} while (bh != head);
>  	return err;
>  }
>  
> --- linux-2.4.18-pre1/mm/filemap.c	Wed Dec 26 11:47:41 2001
> +++ linux-akpm/mm/filemap.c	Sat Jan  5 01:26:50 2002
> @@ -3004,7 +3004,7 @@ generic_file_write(struct file *file,con
>  		kaddr = kmap(page);
>  		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
>  		if (status)
> -			goto unlock;
> +			goto sync_failure;
>  		page_fault = __copy_from_user(kaddr+offset, buf, bytes);
>  		flush_dcache_page(page);
>  		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
> @@ -3029,6 +3029,7 @@ unlock:
>  		if (status < 0)
>  			break;
>  	} while (count);
> +done:
>  	*ppos = pos;
>  
>  	if (cached_page)
> @@ -3050,6 +3051,18 @@ out:
>  fail_write:
>  	status = -EFAULT;
>  	goto unlock;
> +
> +sync_failure:
> +	/*
> +	 * If blocksize < pagesize, prepare_write() may have instantiated a
> +	 * few blocks outside i_size.  Trim these off again.
> +	 */
> +	kunmap(page);
> +	UnlockPage(page);
> +	page_cache_release(page);
> +	if (pos + bytes > inode->i_size)
> +		vmtruncate(inode, inode->i_size);
> +	goto done;
>  
>  o_direct:
>  	written = generic_file_direct_IO(WRITE, file, (char *) buf, count, pos);


I prefer my fix that simply recalls the ->truncate callback if -ENOSPC
is returned by prepare_write. vmtruncate seems way overkill, and after
calling ->truncate the __block_prepare_changes above won't be necessary
because the leftover will be correctly deallocated (no need to clear
them out and to mark them dirty, they will just go away before any
readpage can see them).

for the writepage part of the patch (not quoted in this reply) it seems
fine to me. writepage won't corrupt i_size because it doesn't have the
ability to screwup i_size, and writing at least the successfully mapped
buffers is definitely right thing to do, even if we still can get silent
corruption with holes (but that's not a filesystem kernel side
corruption so I'm satisfied for 2.4 at least :). many thanks for sorting
it out.

Andrea
