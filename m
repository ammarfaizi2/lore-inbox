Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273382AbRINNMl>; Fri, 14 Sep 2001 09:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273380AbRINNMb>; Fri, 14 Sep 2001 09:12:31 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:11255 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S273382AbRINNMW>; Fri, 14 Sep 2001 09:12:22 -0400
Date: Fri, 14 Sep 2001 14:14:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109131925200.4183-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109141343570.1542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, Marcelo Tosatti wrote:
> 
> Here it goes a (untested) patch to reintroduce swap map bumping when doing
> readahead.

Your patch was not quite correct: when swapin_readahead breaks because
nr_async_pages too high, it must remember to swap_free remaining bumps.
And no need to touch swap_state.c: comment on swap_duplicate still valid.

Patch below reverts 2.4.10-pre9 swapin_readahead and valid_swaphandles
to precisely what they were in 2.4.9.  But lacks your comment above the
latter: add it back if you wish, though I'd prefer something more like
"quick hack to fix most obvious cases until we fix them all properly"!
I'm agnostic as to whether this should go in for now or not: up to Linus.

> Note: It does fix the race I described, however I'm not sure how it
> affects the interaction between swapin readahead and swapoff.

It fixes the particular race you described (which we guess
would be the most common kind); but not all the races between
read_swap_cache_async's and try_to_swap_out's add_to_swap_cache.

> Hugh, is there any problem you remember with swapoff and the swap map
> bumping ?

Bumping the counts can add to swapoff's inefficiency: try_to_unuse
has to go on looping until the hidden references have disappeared;
but it does not affect its correctness.

Hugh

--- 2.4.10-pre9/mm/memory.c	Fri Sep 14 10:36:03 2001
+++ linux/mm/memory.c	Fri Sep 14 13:35:05 2001
@@ -1069,19 +1069,23 @@
 	unsigned long offset;
 
 	/*
-	 * Get the number of handles we should do readahead io to.
+	 * Get the number of handles we should do readahead io to. Also,
+	 * grab temporary references on them, releasing them as io completes.
 	 */
 	num = valid_swaphandles(entry, &offset);
 	for (i = 0; i < num; offset++, i++) {
 		/* Don't block on I/O for read-ahead */
-		if (atomic_read(&nr_async_pages) >=
-		    pager_daemon.swap_cluster << page_cluster)
+		if (atomic_read(&nr_async_pages) >= pager_daemon.swap_cluster
+				* (1 << page_cluster)) {
+			while (i++ < num)
+				swap_free(SWP_ENTRY(SWP_TYPE(entry), offset++));
 			break;
+		}
 		/* Ok, do the async read-ahead now */
 		new_page = read_swap_cache_async(SWP_ENTRY(SWP_TYPE(entry), offset));
-		if (!new_page)
-			break;
-		page_cache_release(new_page);
+		if (new_page != NULL)
+			page_cache_release(new_page);
+		swap_free(SWP_ENTRY(SWP_TYPE(entry), offset));
 	}
 	return;
 }
--- 2.4.10-pre9/mm/swapfile.c	Fri Sep 14 10:36:03 2001
+++ linux/mm/swapfile.c	Fri Sep 14 13:35:05 2001
@@ -1111,8 +1111,8 @@
 }
 
 /*
- * Kernel_lock protects against swap device deletion. Don't grab an extra
- * reference on the swaphandle, it doesn't matter if it becomes unused.
+ * Kernel_lock protects against swap device deletion. Grab an extra
+ * reference on the swaphandle so that it dos not become unused.
  */
 int valid_swaphandles(swp_entry_t entry, unsigned long *offset)
 {
@@ -1123,6 +1123,7 @@
 	*offset = SWP_OFFSET(entry);
 	toff = *offset = (*offset >> page_cluster) << page_cluster;
 
+	swap_device_lock(swapdev);
 	do {
 		/* Don't read-ahead past the end of the swap area */
 		if (toff >= swapdev->max)
@@ -1132,8 +1133,10 @@
 			break;
 		if (swapdev->swap_map[toff] == SWAP_MAP_BAD)
 			break;
+		swapdev->swap_map[toff]++;
 		toff++;
 		ret++;
 	} while (--i);
+	swap_device_unlock(swapdev);
 	return ret;
 }

