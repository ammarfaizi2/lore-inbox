Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWESSPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWESSPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWESSPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:15:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751373AbWESSPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:15:04 -0400
Date: Fri, 19 May 2006 11:17:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Lever <cel@citi.umich.edu>
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 3/6] nfs: Eliminate nfs_get_user_pages()
Message-Id: <20060519111734.523232b4.akpm@osdl.org>
In-Reply-To: <20060519180028.3244.7809.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
	<20060519180028.3244.7809.stgit@brahms.dsl.sfldmi.ameritech.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever <cel@netapp.com> wrote:
>
> Neil Brown observed that the kmalloc() in nfs_get_user_pages() is more
> likely to fail if the I/O is large enough to require the allocation of more
> than a single page to keep track of all the pinned pages in the user's
> buffer.
> 
> Instead of tracking one large page array per dreq/iocb, track pages per
> nfs_read/write_data, just like the cached I/O path does.  An array for
> pages is already allocated for us by nfs_readdata_alloc() (and the write
> and commit equivalents).
> 
> This is also required for adding support for vectored I/O to the NFS direct
> I/O path.
> 
> The original reason to pin the user buffer and allocate all the NFS data
> structures before trying to schedule I/O was to ensure all needed resources
> are allocated on the client before starting to send requests.  This reduces
> the chance that resource exhaustion on the client will cause a short read
> or write.
> 
> On the other hand, for an application making very large application I/O
> requests, this means that it will be nearly impossible for the application
> to make forward progress on a resource-limited client.
> 
> Thus, moving the buffer pinning functionality into the I/O scheduling
> loops should be good for scalability.  The next patch will do the same for
> NFS data structure allocation.
> 
> +static void nfs_release_user_pages(struct page **pages, int npages)
>  {
> -	int result = -ENOMEM;
> -	unsigned long page_count;
> -	size_t array_size;
> -
> -	page_count = (user_addr + size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -	page_count -= user_addr >> PAGE_SHIFT;
> -
> -	array_size = (page_count * sizeof(struct page *));
> -	*pages = kmalloc(array_size, GFP_KERNEL);
> -	if (*pages) {
> -		down_read(&current->mm->mmap_sem);
> -		result = get_user_pages(current, current->mm, user_addr,
> -					page_count, (rw == READ), 0,
> -					*pages, NULL);
> -		up_read(&current->mm->mmap_sem);
> -		if (result != page_count) {
> -			/*
> -			 * If we got fewer pages than expected from
> -			 * get_user_pages(), the user buffer runs off the
> -			 * end of a mapping; return EFAULT.
> -			 */
> -			if (result >= 0) {
> -				nfs_free_user_pages(*pages, result, 0);
> -				result = -EFAULT;
> -			} else
> -				kfree(*pages);
> -			*pages = NULL;
> -		}
> -	}
> -	return result;
> +	int i;
> +	for (i = 0; i < npages; i++)
> +		page_cache_release(pages[i]);
>  }

If `npages' is negative, this does the right thing.

> +		result = get_user_pages(current, current->mm, user_addr,
> +					data->npages, 1, 0, data->pagevec, NULL);
> +		up_read(&current->mm->mmap_sem);
> +		if (unlikely(result < data->npages))
> +			goto out_err;
> ...
> +out_err:
> +	nfs_release_user_pages(data->pagevec, result);

And `npages' can indeed be negative.

So.  No bug there, but the code is a little unobvious and fragile - if
someone were to alter a type then subtle bugs would happen.

Perhaps

	if (result > 0)
		nfs_release_user_pages(...);

would be cleaner.  Or at least a loud comment in nfs_release_user_pages().
