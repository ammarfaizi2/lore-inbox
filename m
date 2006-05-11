Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWEKQQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWEKQQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWEKQQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:16:53 -0400
Received: from gold.veritas.com ([143.127.12.110]:2674 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030313AbWEKQQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:16:50 -0400
X-IronPort-AV: i="4.05,116,1146466800"; 
   d="scan'208"; a="59426089:sNHT31297620"
Date: Thu, 11 May 2006 16:01:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, pavel@suse.cz
Subject: Re: [PATCH -mm] swsusp: support creating bigger images
In-Reply-To: <200605110026.48445.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0605111533390.23342@blonde.wat.veritas.com>
References: <200605021200.37424.rjw@sisk.pl> <200605091219.17386.rjw@sisk.pl>
 <Pine.LNX.4.64.0605091301140.21281@blonde.wat.veritas.com>
 <200605110026.48445.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 May 2006 16:16:50.0547 (UTC) FILETIME=[4F387C30:01C67516]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006, Rafael J. Wysocki wrote:
> On Tuesday 09 May 2006 14:30, Hugh Dickins wrote:
> 
> --- linux-2.6.17-rc3-mm1.orig/mm/rmap.c	2006-05-01 14:11:50.000000000 +0200
> +++ linux-2.6.17-rc3-mm1/mm/rmap.c	2006-05-10 23:10:58.000000000 +0200
> @@ -857,3 +857,38 @@ int try_to_unmap(struct page *page, int 
>  	return ret;
>  }
>  
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +/**
> + *	suspend_safe_page - determine if a page can be included in the

suspend_safe_page sounds like it's suspending a safe page,
and safe is unclear: suspend_knows_page_is_frozen?

> + *	suspend image without copying (returns true if so).
> + *
> + *	It is safe to include the page in the suspend image without
> + *	copying if (a) it's on the LRU and (b) it's mapped by a frozen task

That's not quite what the code checks:
(b) it's mapped but not by the the current task

(Actually, page_address_in_vma doesn't really say whether the page
is mapped by the task, but -EFAULT does tell you that it can't be.)

I still find its checks very obscure: am I right to think that most
pages are "frozen" at this point, that it's very hard to determine
which are and which are not, but there happens to be this "little"
category of pages which you can be damn sure are frozen - and on
most active systems, this "little" category actually covers a
large number of pages which it's well worth avoiding copying?

A very loose heuristic which works well enough to make a big difference.

> + *	(all tasks except for the current task should be frozen when it's
> + *	called).  Otherwise the page should be copied for this purpose
> + *	(compound pages are avoided for simplicity).
> + */
> +
> +int suspend_safe_page(struct page *page)
> +{
> +	struct vm_area_struct *vma;
> +	int ret = 0;
> +
> +	if (!PageLRU(page) || PageCompound(page))
> +		return 0;
> +
> +	if (page_mapped(page)) {
> +		ret = 1;
> +		down_read(&current->mm->mmap_sem);
> +		/* Return 0 if the page is mapped by the current task */
> +		for (vma = current->mm->mmap; vma; vma = vma->vm_next)
> +			if (page_address_in_vma(page, vma) != -EFAULT) {
> +				ret = 0;
> +				break;
> +			}
> +		up_read(&current->mm->mmap_sem);
> +	}
> +
> +	return ret;
> +}
> +#endif /* CONFIG_SOFTWARE_SUSPEND */
> 
> I've left the locking, because the functions is called when we're freeing
> memory and I'm not 100% sure it's safe to drop it.

If the locking is necessary, then that down_read is liable to schedule
and wait for mmap_sem to be released.  But you have interrupts disabled?
And everything which might release mmap_sem already frozen?  My guess is
that it's a lot safer _not_ to lock here than to lock; but just how safe
that is I'm not at all sure.

> > But if it is sufficiently frozen, I'm puzzled as to why pages mapped
> > into the current process are (potentially) unsafe, while those mapped
> > into others are safe.  If the current process can get back to messing
> > with its mapped pages, what if it maps a page you earlier judged safe?
> 
> The current task is forbidden to map anything at this point.

Too bald a statement for me to judge (and by forbidden to map,
do you mean forbidden to mmap, or forbidden to fault?).

Perhaps I'd understand better if you explain why pages mapped into the
current task have to be excluded?  It just seems to me that if it can
interfere with those pages, then it is liable to interfere with other
pages too, including some mapped into other processes which you've
already judged to be safe/frozen.

Sorry if I'm wasting your time, forcing you to spell things out to
someone who hasn't a clue what you're up to; but it all smells a
little fishy to me.

Hugh
