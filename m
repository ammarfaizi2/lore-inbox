Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWESTSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWESTSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWESTSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 15:18:06 -0400
Received: from citi.umich.edu ([141.211.133.111]:53406 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964794AbWESTSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 15:18:04 -0400
Message-ID: <446E19EC.1070902@citi.umich.edu>
Date: Fri, 19 May 2006 15:18:04 -0400
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Center for Information Technology Integration
User-Agent: Thunderbird 1.5.0.2 (Macintosh/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 3/6] nfs: Eliminate nfs_get_user_pages()
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>	<20060519180028.3244.7809.stgit@brahms.dsl.sfldmi.ameritech.net> <20060519111734.523232b4.akpm@osdl.org>
In-Reply-To: <20060519111734.523232b4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Chuck Lever <cel@netapp.com> wrote:
>> Neil Brown observed that the kmalloc() in nfs_get_user_pages() is more
>> likely to fail if the I/O is large enough to require the allocation of more
>> than a single page to keep track of all the pinned pages in the user's
>> buffer.
>>
>> Instead of tracking one large page array per dreq/iocb, track pages per
>> nfs_read/write_data, just like the cached I/O path does.  An array for
>> pages is already allocated for us by nfs_readdata_alloc() (and the write
>> and commit equivalents).
>>
>> This is also required for adding support for vectored I/O to the NFS direct
>> I/O path.
>>
>> The original reason to pin the user buffer and allocate all the NFS data
>> structures before trying to schedule I/O was to ensure all needed resources
>> are allocated on the client before starting to send requests.  This reduces
>> the chance that resource exhaustion on the client will cause a short read
>> or write.
>>
>> On the other hand, for an application making very large application I/O
>> requests, this means that it will be nearly impossible for the application
>> to make forward progress on a resource-limited client.
>>
>> Thus, moving the buffer pinning functionality into the I/O scheduling
>> loops should be good for scalability.  The next patch will do the same for
>> NFS data structure allocation.
>>
>> +static void nfs_release_user_pages(struct page **pages, int npages)
>>  {
>> -	int result = -ENOMEM;
>> -	unsigned long page_count;
>> -	size_t array_size;
>> -
>> -	page_count = (user_addr + size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>> -	page_count -= user_addr >> PAGE_SHIFT;
>> -
>> -	array_size = (page_count * sizeof(struct page *));
>> -	*pages = kmalloc(array_size, GFP_KERNEL);
>> -	if (*pages) {
>> -		down_read(&current->mm->mmap_sem);
>> -		result = get_user_pages(current, current->mm, user_addr,
>> -					page_count, (rw == READ), 0,
>> -					*pages, NULL);
>> -		up_read(&current->mm->mmap_sem);
>> -		if (result != page_count) {
>> -			/*
>> -			 * If we got fewer pages than expected from
>> -			 * get_user_pages(), the user buffer runs off the
>> -			 * end of a mapping; return EFAULT.
>> -			 */
>> -			if (result >= 0) {
>> -				nfs_free_user_pages(*pages, result, 0);
>> -				result = -EFAULT;
>> -			} else
>> -				kfree(*pages);
>> -			*pages = NULL;
>> -		}
>> -	}
>> -	return result;
>> +	int i;
>> +	for (i = 0; i < npages; i++)
>> +		page_cache_release(pages[i]);
>>  }
> 
> If `npages' is negative, this does the right thing.
> 
>> +		result = get_user_pages(current, current->mm, user_addr,
>> +					data->npages, 1, 0, data->pagevec, NULL);
>> +		up_read(&current->mm->mmap_sem);
>> +		if (unlikely(result < data->npages))
>> +			goto out_err;
>> ...
>> +out_err:
>> +	nfs_release_user_pages(data->pagevec, result);
> 
> And `npages' can indeed be negative.

I fixed this by making all of these an "unsigned long". 
get_user_pages() returns an unsigned long result, so all these 
comparisons should always work correctly.

nfs_count_pages() now also returns an unsigned long, but I don't see how 
it is possible for it to compute a negative value.

> So.  No bug there, but the code is a little unobvious and fragile - if
> someone were to alter a type then subtle bugs would happen.
> 
> Perhaps
> 
> 	if (result > 0)
> 		nfs_release_user_pages(...);
> 
> would be cleaner.  Or at least a loud comment in nfs_release_user_pages().

-- 
corporate:	cel at netapp dot com
personal:	chucklever at bigfoot dot com
