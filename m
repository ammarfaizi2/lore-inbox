Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131863AbQLMRyH>; Wed, 13 Dec 2000 12:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131876AbQLMRx5>; Wed, 13 Dec 2000 12:53:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47880 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131863AbQLMRxr>; Wed, 13 Dec 2000 12:53:47 -0500
Date: Wed, 13 Dec 2000 09:23:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
In-Reply-To: <Pine.LNX.4.10.10012130805190.19301-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012130914470.19475-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Linus Torvalds wrote:
> 
> Lookin gat "swapoff()", it could easily be something like
> 
>  - swapoff walks theough the processes, marking the pages dirty
>    (correctly)
>  - swapoff goes on to the next swap entry, and because it needs memory for
>    this, the VM layer will swap out old entries by marking them dirty in
>    the "struct page".
>  - final stages of swapoff() removes the swap cache entry, never minding
>    the fact that it is marked dirty again in "struct page", and clean in
>    various VM page tables.
> 
> Ho humm.. I don't think that is it exactly, but something along those
> lines.

Actually, having thought about it for five more minutes, I actually think
that that _is_ it.

If so, the fix looks like it could be really simple. The whole problem
arises from the fact that we remove the page from the swap cache only
_after_ we've walked the page-tables to look at it. It looks like the
fairly trivial fix is simply to remove it from the swap cache before,
getting rid of all such races in swapoff().

Mind trying out this patch?

NOTE! It's untested. It might not work. It might trigger some sanity-test
somewhere else. But it looks like it should do the right thing (the page
might be moved to _another_ swap device early, if there are multiple swap
areas, but even that should be fine - the unuse_process() stuff doesn't
care about what swapcache this actually is any more.

Does this patch make a difference (I moved the delete seven lines upwards,
and removed the test - the test looks extraneous).

		Linus

----
--- v2.4.0-test12/linux/mm/swapfile.c	Tue Oct 31 12:42:27 2000
+++ linux/mm/swapfile.c	Wed Dec 13 09:17:51 2000
@@ -370,6 +370,7 @@
 			swap_free(entry);
   			return -ENOMEM;
 		}
+		delete_from_swap_cache(page);
 		read_lock(&tasklist_lock);
 		for_each_task(p)
 			unuse_process(p->mm, entry, page);
@@ -377,8 +378,6 @@
 		shm_unuse(entry, page);
 		/* Now get rid of the extra reference to the temporary
                    page we've been using. */
-		if (PageSwapCache(page))
-			delete_from_swap_cache(page);
 		page_cache_release(page);
 		/*
 		 * Check for and clear any overflowed swap map counts.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
