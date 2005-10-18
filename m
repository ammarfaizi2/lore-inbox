Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVJRVe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVJRVe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVJRVe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:34:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932146AbVJRVe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:34:27 -0400
Date: Tue, 18 Oct 2005 14:34:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
Message-Id: <20051018143438.66d360c4.akpm@osdl.org>
In-Reply-To: <20051018141512.A26194@unix-os.sc.intel.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Seth, Rohit" <rohit.seth@intel.com> wrote:
>
> Linus,
> 
> [PATCH]: Handle spurious page fault for hugetlb region
> 
> The hugetlb pages are currently pre-faulted.  At the time of mmap of
> hugepages, we populate the new PTEs.  It is possible that HW has already cached
> some of the unused PTEs internally.

What's an "unused pte"?  One which maps a regular-sized page at the same
virtual address?  How can such a thing come about, and why isn't it already
a problem for regular-sized pages?  From where does the hardware prefetch
the pte contents?

IOW: please tell us more about this hardware pte-fetcher.

>  These stale entries never get a chance to
> be purged in existing control flow.

I'd have thought that invalidating those ptes at mmap()-time would be a
more consistent approach.

> This patch extends the check in page fault code for hugepages.  Check if
> a faulted address falls with in size for the hugetlb file backing it.  We
> return VM_FAULT_MINOR for these cases (assuming that the arch specific
> page-faulting code purges the stale entry for the archs that need it).

Do you have an example of the code which does this purging?

> --- linux-2.6.14-rc4-git5-x86/include/linux/hugetlb.h	2005-10-18 13:14:24.879947360 -0700
> +++ b/include/linux/hugetlb.h	2005-10-18 13:13:55.711381656 -0700
> @@ -155,11 +155,24 @@
>  {
>  	file->f_op = &hugetlbfs_file_operations;
>  }
> +
> +static inline int valid_hugetlb_file_off(struct vm_area_struct *vma, 
> +					  unsigned long address) 
> +{
> +	struct inode *inode = vma->vm_file->f_dentry->d_inode;
> +	loff_t file_off = address - vma->vm_start;
> +	
> +	file_off += (vma->vm_pgoff << PAGE_SHIFT);
> +	
> +	return (file_off < inode->i_size);
> +}

I suppose we should use i_size_read() here.

> +		if (valid_hugetlb_file_off(vma, address))
> +			/* We get here only if there was a stale(zero) TLB entry 
> +			 * (because of  HW prefetching). 
> +			 * Low-level arch code (if needed) should have already
> +			 * purged the stale entry as part of this fault handling.  
> +			 * Here we just return.
> +			 */

If the low-level code has purged the stale pte then it knows what's
happening.  Perhaps it shouldn't call into handle_mm_fault() at all?
