Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUESTaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUESTaa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 15:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUESTaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 15:30:30 -0400
Received: from wanderer.mr.itd.umich.edu ([141.211.93.146]:20703 "EHLO
	wanderer.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S264211AbUESTaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 15:30:18 -0400
Date: Wed, 19 May 2004 15:30:16 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@rust.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 36 mprotect use vma_merge
In-Reply-To: <1Xl6y-4AC-45@gated-at.bofh.it>
Message-ID: <Pine.LNX.4.58.0405191515050.16860@rust.engin.umich.edu>
References: <1Xl6k-4AC-3@gated-at.bofh.it> <1Xl6y-4AC-45@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hugh,

A couple of small clarifications.

>  void vma_adjust(struct vm_area_struct *vma, unsigned long start,
> -	unsigned long end, pgoff_t pgoff, struct vm_area_struct *next)
> +	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
[snip]
> +	long adjust_next = 0;
> +	int remove_next = 0;
> +
> +	if (next && !insert) {
[snip]
> +			BUG_ON(vma->vm_end != next->vm_start);
> +			adjust_next = end - next->vm_start;
> +		}
> +	}

Can adjust_next overflow?  No? I think making adjust_next in
PAGE_SIZE units will avoid overflow concerns.

[snip]
>  	if (root) {
> +		if (adjust_next) {
> +			vma_prio_tree_init(next);
> +			vma_prio_tree_insert(next, root);
> +		}
>  		vma_prio_tree_init(vma);
>  		vma_prio_tree_insert(vma, root);
>  		flush_dcache_mmap_unlock(mapping);
>  	}

I think this flush_dcache_mmap_unlock should go down - after
__insert_vm_struct call - just before page_table_lock unlock.


> +		__insert_vm_struct(mm, insert);
>  	}
>
>  	spin_unlock(&mm->page_table_lock);
>  	if (mapping)
>  		spin_unlock(&mapping->i_mmap_lock);

Thanks,
Rajesh
