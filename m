Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUDOSwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUDOSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:49:48 -0400
Received: from reformers.mr.itd.umich.edu ([141.211.93.147]:22739 "EHLO
	reformers.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263089AbUDOSrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:47:18 -0400
Date: Thu, 15 Apr 2004 14:47:07 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@blue.engin.umich.edu
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <192710000.1082052992@flay>
Message-ID: <Pine.GSO.4.58.0404151421260.28662@blue.engin.umich.edu>
References: <Pine.LNX.4.44.0404151842530.9612-100000@localhost.localdomain>
 <192710000.1082052992@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It has similar problems, IIRC with increasing i_shared_sem contention.

Agreed.

> But I think it solves the same issues as prio_tree,

Agreed.

> is simpler,

Agreed.

> is easier to fix up to do clever locking with.

I haven't thought about it fully, so I am not sure. But, it is likely
that locking is easier with list-of-lists.

[snip]

> diff -urpN -X /home/fletch/.diff.exclude 820-numa_large_pages/mm/mmap.c 830-list-of-lists/mm/mmap.c
> --- 820-numa_large_pages/mm/mmap.c	Wed Jun 18 21:49:20 2003
> +++ 830-list-of-lists/mm/mmap.c	Wed Jun 18 23:29:38 2003
> @@ -306,6 +306,56 @@ static void __vma_link_rb(struct mm_stru
>  	rb_insert_color(&vma->vm_rb, &mm->mm_rb);
>  }
>
> +static void vma_add (struct vm_area_struct *vma,
> +						struct list_head *range_list)
> +{
> +	struct address_range *range;
> +	struct list_head *prev, *next;
> +	unsigned long start = vma->vm_pgoff;
> +	unsigned long end = vma->vm_pgoff +
> +		(((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) - 1);
> +
> +	/* First, look for an existing range that matches ours */
> +	prev = range_list;
> +	list_for_each(next, range_list) {
> +		range = list_entry(next, struct address_range, ranges);
> +		if (range->start > start)
> +			break;    /* this list is sorted by start */
> +		if ((range->start == start) && (range->end == end)) {
> +			goto found;
> +		}
> +		prev = next;
> +	}

Hmm.. We do a linear O(N) search for each vma added. If the range_list
has 1000 vmas, then it is really bad. Running Ingo's test-mmap3.c or
Andrew's rmap-test.c (check 3rd test Andrew did - single process,
10,000 different vmas - with different range->start and range->end)
will be slow.

The prio_tree patch optimizes these cases with O(log N) insert algorithm.

[snip]

> +static void vma_del (struct vm_area_struct *vma)
> +{
[snip]
> +	next = vma->shared.next;	/* stash the range list we're on */
> +	list_del(&vma->shared);		/* remove us from the list of vmas */
> +	if (list_empty(next)) {		/* we were the last vma for range */
> +		range = list_entry(next, struct address_range, vmas);
> +		list_del(&range->ranges);
> +		kfree(range);
> +	}
> +}

Agree that vma_del is much simpler.

>  page_referenced_obj(struct page *page)
>  {
[snip]
> +	list_for_each_entry(range, &mapping->i_mmap, ranges) {
> +		if (range->start > index)
> +			break;     /* Sorted by start address => we are done */
> +		if (range->end < index)
> +			continue;

Again O(N) search...

> +		list_for_each_entry(vma, &range->vmas, shared)
> +			referenced += page_referenced_obj_one(vma, page);
> +	}


> @@ -512,7 +532,9 @@ static int
>  try_to_unmap_obj(struct page *page)
>  {
[snip]
> +	list_for_each_entry(range, &mapping->i_mmap, ranges) {
> +		if (range->start > index)
> +			break;     /* Sorted by start address => we are done */
> +		if (range->end < index)
> +			continue;

Here also O(N) search when each vma map a unique set of file pages...

Thanks for posting the code. Your old postings (almost a year ago)
regarding list-of-lists inspired me to develop prio_tree. Thanks.

Rajesh
