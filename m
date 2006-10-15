Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWJOLho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWJOLho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 07:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWJOLhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 07:37:43 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:26740 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932096AbWJOLhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 07:37:42 -0400
Subject: Re: [patch 6/6] mm: fix pagecache write deadlocks
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>, Neil Brown <neilb@suse.de>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061013143616.15438.77140.sendpatchset@linux.site>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
	 <20061013143616.15438.77140.sendpatchset@linux.site>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 13:37:10 +0200
Message-Id: <1160912230.5230.23.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 18:44 +0200, Andrew Morton wrote:
> The idea is to modify the core write() code so that it won't take a pagefault
> while holding a lock on the pagecache page. There are a number of different
> deadlocks possible if we try to do such a thing:
> 
> 1.  generic_buffered_write
> 2.   lock_page
> 3.    prepare_write
> 4.     unlock_page+vmtruncate
> 5.     copy_from_user
> 6.      mmap_sem(r)
> 7.       handle_mm_fault
> 8.        lock_page (filemap_nopage)
> 9.    commit_write
> 1.   unlock_page
> 
> b. sys_munmap / sys_mlock / others
> c.  mmap_sem(w)
> d.   make_pages_present
> e.    get_user_pages
> f.     handle_mm_fault
> g.      lock_page (filemap_nopage)
> 
> 2,8	- recursive deadlock if page is same
> 2,8;2,7	- ABBA deadlock is page is different

2,8;2,8 I think you mean

> 2,6;c,g	- ABBA deadlock if page is same

> +
> +		/*
> +		 * Must not enter the pagefault handler here, because we hold
> +		 * the page lock, so we might recursively deadlock on the same
> +		 * lock, or get an ABBA deadlock against a different lock, or
> +		 * against the mmap_sem (which nests outside the page lock).
> +		 * So increment preempt count, and use _atomic usercopies.
> +		 */
> +		inc_preempt_count();
>  		if (likely(nr_segs == 1))
> -			copied = filemap_copy_from_user(page, offset,
> +			copied = filemap_copy_from_user_atomic(page, offset,
>  							buf, bytes);
>  		else
> -			copied = filemap_copy_from_user_iovec(page, offset,
> -						cur_iov, iov_offset, bytes);
> +			copied = filemap_copy_from_user_iovec_atomic(page,
> +						offset, cur_iov, iov_offset,
> +						bytes);
> +		dec_preempt_count();
> +

Why use raw {inc,dec}_preempt_count() and not
preempt_{disable,enable}()? Is the compiler barrier not needed here? And
do we really want to avoid the preempt_check_resched()?

> Index: linux-2.6/mm/filemap.h
> ===================================================================
> --- linux-2.6.orig/mm/filemap.h
> +++ linux-2.6/mm/filemap.h
> @@ -22,19 +22,19 @@ __filemap_copy_from_user_iovec_inatomic(
>  
>  /*
>   * Copy as much as we can into the page and return the number of bytes which
> - * were sucessfully copied.  If a fault is encountered then clear the page
> - * out to (offset+bytes) and return the number of bytes which were copied.
> + * were sucessfully copied.  If a fault is encountered then return the number of
> + * bytes which were copied.
>   *
> - * NOTE: For this to work reliably we really want copy_from_user_inatomic_nocache
> - * to *NOT* zero any tail of the buffer that it failed to copy.  If it does,
> - * and if the following non-atomic copy succeeds, then there is a small window
> - * where the target page contains neither the data before the write, nor the
> - * data after the write (it contains zero).  A read at this time will see
> - * data that is inconsistent with any ordering of the read and the write.
> - * (This has been detected in practice).
> + * NOTE: For this to work reliably we really want
> + * copy_from_user_inatomic_nocache to *NOT* zero any tail of the buffer that it
> + * failed to copy.  If it does, and if the following non-atomic copy succeeds,
> + * then there is a small window where the target page contains neither the data
> + * before the write, nor the data after the write (it contains zero).  A read at
> + * this time will see data that is inconsistent with any ordering of the read
> + * and the write.  (This has been detected in practice).
>   */
>  static inline size_t
> -filemap_copy_from_user(struct page *page, unsigned long offset,
> +filemap_copy_from_user_atomic(struct page *page, unsigned long offset,
>  			const char __user *buf, unsigned bytes)
>  {
>  	char *kaddr;
> @@ -44,23 +44,32 @@ filemap_copy_from_user(struct page *page
>  	left = __copy_from_user_inatomic_nocache(kaddr + offset, buf, bytes);
>  	kunmap_atomic(kaddr, KM_USER0);
>  
> -	if (left != 0) {
> -		/* Do it the slow way */
> -		kaddr = kmap(page);
> -		left = __copy_from_user_nocache(kaddr + offset, buf, bytes);
> -		kunmap(page);
> -	}
> +	return bytes - left;
> +}
> +
> +static inline size_t
> +filemap_copy_from_user_nonatomic(struct page *page, unsigned long offset,
> +			const char __user *buf, unsigned bytes)
> +{
> +	char *kaddr;
> +	int left;
> +
> +	kaddr = kmap(page);
> +	left = __copy_from_user_nocache(kaddr + offset, buf, bytes);
> +	kunmap(page);
> +
>  	return bytes - left;
>  }
>  
>  /*
> - * This has the same sideeffects and return value as filemap_copy_from_user().
> + * This has the same sideeffects and return value as
> + * filemap_copy_from_user_atomic().
>   * The difference is that on a fault we need to memset the remainder of the
>   * page (out to offset+bytes), to emulate filemap_copy_from_user()'s
>   * single-segment behaviour.
>   */
>  static inline size_t
> -filemap_copy_from_user_iovec(struct page *page, unsigned long offset,
> +filemap_copy_from_user_iovec_atomic(struct page *page, unsigned long offset,
>  			const struct iovec *iov, size_t base, size_t bytes)
>  {
>  	char *kaddr;
> @@ -70,14 +79,27 @@ filemap_copy_from_user_iovec(struct page
>  	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
>  							 base, bytes);
>  	kunmap_atomic(kaddr, KM_USER0);
> -	if (copied != bytes) {
> -		kaddr = kmap(page);
> -		copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
> -								 base, bytes);
> -		if (bytes - copied)
> -			memset(kaddr + offset + copied, 0, bytes - copied);
> -		kunmap(page);
> -	}
> +	return copied;
> +}
> +
> +/*
> + * This has the same sideeffects and return value as
> + * filemap_copy_from_user_nonatomic().
> + * The difference is that on a fault we need to memset the remainder of the
> + * page (out to offset+bytes), to emulate filemap_copy_from_user_nonatomic()'s
> + * single-segment behaviour.
> + */
> +static inline size_t
> +filemap_copy_from_user_iovec_nonatomic(struct page *page, unsigned long offset,
> +			const struct iovec *iov, size_t base, size_t bytes)
> +{
> +	char *kaddr;
> +	size_t copied;
> +
> +	kaddr = kmap(page);
> +	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
> +							 base, bytes);
> +	kunmap(page);
>  	return copied;
>  }
>  

Why create the _nonatomic versions? There are no users.


