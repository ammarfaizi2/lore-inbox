Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTFTAD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTFTAD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:03:58 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30926
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262029AbTFTADs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:03:48 -0400
Date: Fri, 20 Jun 2003 02:17:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <20030620001743.GI18317@dualathlon.random>
References: <133430000.1055448961@baldur.austin.ibm.com> <20030612134946.450e0f77.akpm@digeo.com> <20030612140014.32b7244d.akpm@digeo.com> <150040000.1055452098@baldur.austin.ibm.com> <20030612144418.49f75066.akpm@digeo.com> <184910000.1055458610@baldur.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184910000.1055458610@baldur.austin.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 12, 2003 at 05:56:50PM -0500, Dave McCracken wrote:
> --- 2.5.70-mm8/./mm/memory.c	2003-06-12 13:37:31.000000000 -0500
> +++ 2.5.70-mm8-trunc/./mm/memory.c	2003-06-12 17:51:55.000000000 -0500
> @@ -1138,6 +1138,8 @@ invalidate_mmap_range(struct address_spa
>  			hlen = ULONG_MAX - hba + 1;
>  	}
>  	down(&mapping->i_shared_sem);
> +	/* Protect against page fault */
> +	atomic_inc(&mapping->truncate_count);
>  	if (unlikely(!list_empty(&mapping->i_mmap)))
>  		invalidate_mmap_range_list(&mapping->i_mmap, hba, hlen);
>  	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
> @@ -1390,8 +1392,10 @@ do_no_page(struct mm_struct *mm, struct 
>  	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
>  {
>  	struct page * new_page;
> +	struct address_space *mapping;
>  	pte_t entry;
>  	struct pte_chain *pte_chain;
> +	unsigned sequence;
>  	int ret;
>  
>  	if (!vma->vm_ops || !vma->vm_ops->nopage)
> @@ -1400,6 +1404,9 @@ do_no_page(struct mm_struct *mm, struct 
>  	pte_unmap(page_table);
>  	spin_unlock(&mm->page_table_lock);
>  
> +	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
> +retry:
> +	sequence = atomic_read(&mapping->truncate_count);
>  	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
>  
>  	/* no page was available -- either SIGBUS or OOM */
> @@ -1428,6 +1435,16 @@ do_no_page(struct mm_struct *mm, struct 
>  	}
>  
>  	spin_lock(&mm->page_table_lock);
> +	/*
> +	 * For a file-backed vma, someone could have truncated or otherwise
> +	 * invalidated this page.  If invalidate_mmap_range got called,
> +	 * retry getting the page.
> +	 */
> +	if (unlikely(sequence != atomic_read(&mapping->truncate_count))) {
> +		spin_unlock(&mm->page_table_lock);
> +		page_cache_release(new_page);
> +		goto retry;
> +	}
>  	page_table = pte_offset_map(pmd, address);

maybe I'm missing something silly but this fixes nothing IMHO. It's not
a coincidence I used the seq_lock (aka frlock in 2.4-aa) in my fix, a
single counter increment isn't nearly enough, you definitely need _both_
an entry and exit point in do_truncate or you'll never know if
vmtruncate has been running under you. The first increment is like the
down_read, the second increment is the up_read. Both are necessary to
trap any vmtruncate during the do_no_page.

Your patch traps this timing case:

	CPU 0			CPU 1
	----------		-----------
				do_no_page
	truncate
				read counter

	increment counter
	vmtruncate
				->nopage
				read counter again -> different so retry


but you can't trap this with a single counter increment in do_truncate:

	CPU 0			CPU 1
	----------		-----------
				do_no_page
	truncate
	increment counter
				read counter
				->nopage
	vmtruncate
				read counter again -> different so retry

thanks to the second counter increment after vmtruncate in my fix, the
above race couldn't happen.

About the down(&inode->i_sem); up(), that you dropped under Andrew's
suggestion, while that maybe ugly, it will have a chance to save cpu,
and since it's a slow path such goto, it's definitely worthwhile to keep
it IMHO. Otherwise one cpu will keep scheduling in a loop until truncate
returns, and it can take time since it may have to do I/O or wait on
some I/O semaphore. It wouldn't be DoSable, because the
ret-from-exception will check need_resched, but still it's bad for cpu
utilization and such a waste can be avoided trivially as in my fix.

I was chatting with Daniel about those hooks a few minutes ago, and he
suggested to make do_no_page a callback itself (instead of having
do_no_page call into a ->nopage further callback). And to provide by
default a generic implementation that would be equivalent to the current
do_no_page. As far as I can tell that will save both the new pointer to
function for the DSM hook (that IMHO has to be taken twice, both before
->nopage and after ->nopage, not only before the ->nopage, for the
reason explained above) and the ->nopage hook itself. So maybe that
could be a cleaner solution to avoid the DSM hooks enterely, so we don't
have more hooks but less, and a library call. This sounds the best for
performance and flexibility. (talking only about 2.5 of course, 2.4 I
think is just fine with my ""production"" 8) fix here:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/2.4.21rc8aa1/9999_truncate-nopage-race-1

)

Andrea
