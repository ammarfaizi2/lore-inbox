Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQL1SiR>; Thu, 28 Dec 2000 13:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQL1SiH>; Thu, 28 Dec 2000 13:38:07 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60423 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129391AbQL1Shv>; Thu, 28 Dec 2000 13:37:51 -0500
Date: Thu, 28 Dec 2000 10:07:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmem_unuse race fix
In-Reply-To: <m31yuswyig.fsf@linux.local>
Message-ID: <Pine.LNX.4.10.10012281003360.12064-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 28 Dec 2000, Christoph Rohland wrote:
> 
> First we need the following patch since otherwise we use a swap entry
> without having the count increased:

No, that shouldn't be needed.

Look at the code-path: the kernel has the page locked, so nothing will
de-allocate the swap entry - so it's perfectly ok to increase it later. I
dislike the "magic" __get_swap_page(2) thing - we might make
get_swap_page() itself _always_ return a swap entry with count two (one
fot eh swap cache, one for the user), or we should keep it the way it was
(where we explicitly increment it for the user).

> Second there look at this in handle_pte_fault:
> 
> 		/*
> 		 * If it truly wasn't present, we know that kswapd
> 		 * and the PTE updates will not touch it later. So
> 		 * drop the lock.
> 		 */
> 		spin_unlock(&mm->page_table_lock);
> 		if (pte_none(entry))
> 			return do_no_page(mm, vma, address, write_access, pte);
> 		return do_swap_page(mm, vma, address, pte, pte_to_swp_entry(entry), write_access);
> 
> The comment is wrong. try_to_unuse will touch it. This stumbles over a
> bad swap entry after try_to_unuse complaining about an undead swap
> entry.
> 
> If I retry in try_to_unuse it goes into an infinite loop since it
> deadlocks with this.

Ok. How about making try_to_unuse() just get the VM semaphore instead of
the page table lock?

Then try_to_unuse() would follow all the right rules, and the above
problem wouldn't exist..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
