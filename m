Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVBGV1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVBGV1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVBGV1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:27:11 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21813 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261329AbVBGVZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:25:53 -0500
Date: Mon, 7 Feb 2005 21:24:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
In-Reply-To: <20050203035605.C981A7046E@sv1.valinux.co.jp>
Message-ID: <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, IWAMOTO Toshihiro wrote:
> The current implementation of memory hotremoval relies on that pages
> can be unmapped from process spaces.  After successful unmapping,
> subsequent accesses to the pages are blocked and don't interfere
> the hotremoval operation.
> 
> However, this code
> 
>         if (PageSwapCache(page) &&
>             page_count(page) != page_mapcount(page) + 2) {
>                 ret = SWAP_FAIL;
>                 goto out_unmap;
>         }

Yes, that is odd code.  It would be nice to have a solution without it.

> in try_to_unmap_one() prevents unmapping pages that are referenced via
> get_user_pages(), and such references can be held for a long time if
> they are due to such as direct IO.
> I've made a test program that issues multiple direct IO read requests
> against a single read buffer, and pages that belong to the buffer
> cannot be hotremoved because they aren't unmapped.

I haven't looked at the rest of your hotremoval, so it's not obvious
to me how a change here would help you - obviously you wouldn't want
to be migrating pages while direct IO to them was in progress.

I presume your patch works for you by letting the page count fall
to a point where migration moves it automatically as soon as the
got_user_pages are put, where without your patch the count is held
too high, and you keep doing scans which tend to miss the window
in which those pages are put?

> The following patch, which is against linux-2.6.11-rc1-mm1 and also
> tested witch linux-2.6.11-rc2-mm2, fixes this issue.  The purpose of
> this patch is to be able to unmap pages that have incremented
> page_count.  To do that consistently, the COW detection logic needs to
> be modified to not to rely on page_count.  I'm aware that such
> extensive use of page_mapcount is discouraged and there is a plan to
> kill page_mapcount (*), but I cannot think of a better alternative
> solution.
> 
> (*) c.f. http://www.ussg.iu.edu/hypermail/linux/kernel/0406.0/0483.html

I apologize for scaring you off page mapcount.  I have no current
plans to scrap it, and feel a lot more satisfied with it than at the
time of that comment.  Partly because it's now manipulated atomically
rather than under bitspin lock.  Partly because I realize that although
64-bit systems are overdue for an atomic64 page count and page mapcount,
we can actually just use one atomic64 for them both, keeping, say, lower
24 bits for count and upper 40 for mapcount (and not repeating mapcount
in count on these arches), so mapcount won't increase struct page size.

Go right ahead and use page mapcount if it's appropriate.

> Some notes about my code:
> 
>   - I think it's safe to rely on page_mapcount in do_swap_page(),
>     because its use is protected by lock_page().

I think so too.

>   - The can_share_swap_page() call in do_swap_page() always returns
>     false.  It is inefficient but should be harmless.  Incrementing
>     page_mapcount before calling that function should fix the problem,
>     but it may cause bad side effects.

Odd that your patch moves it if it now doesn't even work!
But I think some more movement should be able to solve that.

>   - Another obvious solution to this issue is to find the "offending"
>     process from a un-unmappable page and suspend it until the page is
>     unmapped.  I'm afraid the implementation would be much more complicated.

Agreed, let's not get into that.

>   - I could not test the following situation.  It should be possible
>     to write some kernel code to do that, but please let me know if
>     you know any such test cases.
>     - A page_count is incremented by get_user_pages().
>     - The page gets unmapped.
>     - The process causes a write fault for the page, before the
>       incremented page_count is dropped.

I confess I don't have such a test case ready myself.

> Also, while I've tried carefully not to make mistakes and done some
> testing, I'm not very sure this is bug free.  Please comment.
> 
> --- mm/memory.c.orig	2005-01-17 14:47:11.000000000 +0900
> +++ mm/memory.c	2005-01-17 14:55:51.000000000 +0900
> @@ -1786,10 +1786,6 @@ static int do_swap_page(struct mm_struct
>  	}
>  
>  	/* The page isn't present yet, go ahead with the fault. */
> -		
> -	swap_free(entry);
> -	if (vm_swap_full())
> -		remove_exclusive_swap_page(page);
>  
>  	mm->rss++;
>  	acct_update_integrals();
> @@ -1800,6 +1796,10 @@ static int do_swap_page(struct mm_struct
>  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>  		write_access = 0;
>  	}
> +		
> +	swap_free(entry);
> +	if (vm_swap_full())
> +		remove_exclusive_swap_page(page);
>  	unlock_page(page);
>  
>  	flush_icache_page(vma, page);
> --- mm/rmap.c.orig	2005-01-17 14:40:08.000000000 +0900
> +++ mm/rmap.c	2005-01-21 12:34:06.000000000 +0900
> @@ -569,8 +569,11 @@ static int try_to_unmap_one(struct page 
>  	 */
>  	if (PageSwapCache(page) &&
>  	    page_count(page) != page_mapcount(page) + 2) {
> -		ret = SWAP_FAIL;
> -		goto out_unmap;
> +		if (page_mapcount(page) > 1) {	/* happens when COW is in progress */
> +			ret = SWAP_FAIL;
> +			goto out_unmap;
> +		}
> +	printk("unmapping GUPed page\n");
>  	}
>  
>  	/* Nuke the page table entry. */

I'm disappointed to see you making this more complicated, it's
even harder to understand than before.  I believe that if we're
going to make good use of page_mapcount in can_share_swap_page,
it should be possible to delete this block from try_to_unmap_one
altogether.  Or did you try that, and find it goes wrong?

(The swapoff progress case can be dealt with differently,
by shifting unuse_pmd's activate_page to the start of unuse_process,
before it might drop page lock.)

> --- mm/swapfile.c.orig	2005-01-17 14:47:11.000000000 +0900
> +++ mm/swapfile.c	2005-01-31 16:59:11.000000000 +0900
> @@ -293,7 +293,7 @@ static int exclusive_swap_page(struct pa
>  		if (p->swap_map[swp_offset(entry)] == 1) {
>  			/* Recheck the page count with the swapcache lock held.. */
>  			write_lock_irq(&swapper_space.tree_lock);
> -			if (page_count(page) == 2)
> +			if (page_mapcount(page) == 1)
>  				retval = 1;
>  			write_unlock_irq(&swapper_space.tree_lock);
>  		}

I think that the write_lock_irq stuff here is unnecessary,
given that we already have the page lock - do you agree?
But you're quite right not to change that in the same patch.

> @@ -316,22 +316,17 @@ int can_share_swap_page(struct page *pag
>  
>  	if (!PageLocked(page))
>  		BUG();
> -	switch (page_count(page)) {
> -	case 3:
> -		if (!PagePrivate(page))
> -			break;
> -		/* Fallthrough */
> -	case 2:
> -		if (!PageSwapCache(page))
> -			break;
> -		retval = exclusive_swap_page(page);
> -		break;
> -	case 1:
> -		if (PageReserved(page))
> -			break;
> -		retval = 1;
> +
> +	if (!PageSwapCache(page)) {
> +		if (PageAnon(page) && page_mapcount(page) == 1 &&
> +		    !PageReserved(page))
> +			return 1;
> +		return 0;
>  	}
> -	return retval;
> +	if (page_mapcount(page) <= 1 && exclusive_swap_page(page))
> +		return 1;
> +
> +	return 0;
>  }
>  
>  /*

This can_share_swap_page looks messier than I'd want.

I was hoping to append my own patch to this response, but I haven't
got it working right yet (swap seems too full).  I hope tomorrow,
but thought I'd better not delay these comments any longer.

Hugh
