Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273222AbRIMXxu>; Thu, 13 Sep 2001 19:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273223AbRIMXxm>; Thu, 13 Sep 2001 19:53:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24838 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273222AbRIMXxZ>; Thu, 13 Sep 2001 19:53:25 -0400
Date: Thu, 13 Sep 2001 19:29:06 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109131901240.4163-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109131925200.4183-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Sep 2001, Marcelo Tosatti wrote:

> 
> 
> On Thu, 13 Sep 2001, Marcelo Tosatti wrote:
> 
> > 
> > 
> > On Thu, 13 Sep 2001, Marcelo Tosatti wrote:
> > 
> > > 
> > > 
> > > On Thu, 13 Sep 2001, Marcelo Tosatti wrote:
> > > 
> > > > 
> > > > 
> > > > On Thu, 13 Sep 2001, Hugh Dickins wrote:
> > > > 
> > > > > On Wed, 12 Sep 2001, Marcelo Tosatti wrote:
> > > > > > On Tue, 11 Sep 2001, Hugh Dickins wrote:
> > > > > > > It may be made more likely by my swapoff changes (not bumping swap
> > > > > > > count in valid_swaphandles), but it's not been introduced by those
> > > > > > > changes.  Though usually swapin_readahead/valid_swaphandles covers
> > > > > > > (includes) the particular swap entry which do_swap_page actually
> > > > > > > wants to bring in, under pressure that's not always so, and then
> > > > > > > the race you outline can occur with the "bare" read_swap_cache_async
> > > > > > > for which there was no bumping.  Furthermore, you can play your
> > > > > > > scenario with valid_swaphandles through to add_to_swap_cache on CPU0
> > > > > > > interposed between the get_swap_page and add_to_swap_cache on CPU1
> > > > > > > (if interrupt on CPU1 diverts it).
> > > > > > 
> > > > > > I don't think so. A "bare" read_swap_cache_async() call only happens on
> > > > > > swap entries which already have additional references. That is, its
> > > > > > guaranteed that a "bare" read_swap_cache_async() call only happens for
> > > > > > swap map entries which already have a reference, so we're guaranteed that
> > > > > > it cannot be reused.
> > > > > 
> > > > > Almost agreed, but there may be a long interval between when that reference
> > > > > was observed in the page table, and when read_swap_cache_async upon it is
> > > > > actually performed (waiting for BKL, waiting to allocate pages for prior
> > > > > swapin_readahead).  In that interval the reference can be removed:
> > > > > certainly by swapoff, certainly by vm_swap_full removal, anything else?
> > > > 
> > > > Not sure about swapoff(). 
> > > > 
> > > > vm_swap_full() is only going to remove the reference _after_ we did the
> > > > swapin, so I don't see how the race can happen with it.

<snip>

Linus, 

Here it goes a (untested) patch to reintroduce swap map bumping when doing
readahead.

Note: It does fix the race I described, however I'm not sure how it
affects the interaction between swapin readahead and swapoff.

Hugh, is there any problem you remember with swapoff and the swap map
bumping ?

I'm going home now, and if Hugh is not sure about this I'm going to review
the swapoff/readahead interaction tomorrow morning.



diff -Nur linux.orig/mm/memory.c linux/mm/memory.c 
--- linux.orig/mm/memory.c Thu Sep 13 18:35:11 2001 
+++ linux/mm/memory.c Thu Sep 13 20:46:47 2001 
@@ -1069,7 +1069,8 @@
 	unsigned long offset;
 
 	/*
-	 * Get the number of handles we should do readahead io to.
+	 * Get the number of handles we should do readahead io to.  Also,
+	 * grab temporary references on them, releasing them as io completes.
 	 */
 	num = valid_swaphandles(entry, &offset);
 	for (i = 0; i < num; offset++, i++) {
@@ -1079,9 +1080,13 @@
 			break;
 		/* Ok, do the async read-ahead now */
 		new_page = read_swap_cache_async(SWP_ENTRY(SWP_TYPE(entry), offset));
-		if (!new_page)
-			break;
-		page_cache_release(new_page);
+		if (new_page != NULL)
+			page_cache_release(new_page);
+		/*
+		 * Free the additional swap map entry reference
+		 * which has been got by valid_swaphandles().
+		 */
+		swap_free(SWP_ENTRY(SWP_TYPE(entry), offset));
 	}
 	return;
 }
diff -Nur linux.orig/mm/swap_state.c linux/mm/swap_state.c
--- linux.orig/mm/swap_state.c	Thu Sep 13 18:35:11 2001
+++ linux/mm/swap_state.c	Thu Sep 13 20:42:36 2001
@@ -224,11 +224,6 @@
 	if (found_page)
 		goto out_free_page;
 
-	/*
-	 * Make sure the swap entry is still in use.  It could have gone
-	 * while caller waited for BKL, or while allocating page above,
-	 * or while allocating page in prior call via swapin_readahead.
-	 */
 	if (!swap_duplicate(entry))	/* Account for the swap cache */
 		goto out_free_page;
 
diff -Nur linux.orig/mm/swapfile.c linux/mm/swapfile.c
--- linux.orig/mm/swapfile.c	Thu Sep 13 18:35:11 2001
+++ linux/mm/swapfile.c	Thu Sep 13 20:41:34 2001
@@ -1111,8 +1111,19 @@
 }
 
 /*
- * Kernel_lock protects against swap device deletion. Don't grab an extra
- * reference on the swaphandle, it doesn't matter if it becomes unused.
+ * Kernel_lock protects against swap device deletion. Grab an extra
+ * reference on the swaphandles we are going to do readahead so 
+ * that it does not become unused.
+ * 
+ * If there is a possibility for any swap entry which we decided 
+ * to do readahead to become used to map _another_ data page, we
+ * may race adding two pagecache hash entries for the same 
+ * data page.
+ *
+ * Do not change that behaviour without analyzing locking all
+ * around the swap code, please: The races are subtle.
+ *
+ * 				- Marcelo
  */
 int valid_swaphandles(swp_entry_t entry, unsigned long *offset)
 {
@@ -1120,9 +1131,11 @@
 	unsigned long toff;
 	struct swap_info_struct *swapdev = SWP_TYPE(entry) + swap_info;
 
+
 	*offset = SWP_OFFSET(entry);
 	toff = *offset = (*offset >> page_cluster) << page_cluster;
 
+	swap_device_lock(swapdev);
 	do {
 		/* Don't read-ahead past the end of the swap area */
 		if (toff >= swapdev->max)
@@ -1132,8 +1145,10 @@
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

