Return-Path: <linux-kernel-owner+w=401wt.eu-S964885AbWLMMNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWLMMNR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWLMMNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:13:17 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:37579 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964896AbWLMMNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:13:16 -0500
X-Greylist: delayed 1734 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 07:13:16 EST
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <45483020.9010607@yahoo.com.au>
References: <1161935995.5019.46.camel@localhost.localdomain>
	 <4541C1B2.7070003@yahoo.com.au>
	 <1161938694.5019.83.camel@localhost.localdomain>
	 <4542E2A4.2080400@yahoo.com.au>
	 <1162032227.5555.65.camel@localhost.localdomain>
	 <454348B4.60007@yahoo.com.au>
	 <1162209347.6962.2.camel@localhost.localdomain>
	 <45483020.9010607@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 11:43:55 +0000
Message-Id: <1166010236.5626.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 16:26 +1100, Nick Piggin wrote:
> The attached (very untested, in need of splitting up) patch attempts to
> solve these problems. Note that it is probably not going to prevent your
> SIGBUS, so that will have to be found and fixed individually.
> 
> In the meantime, I'll run this through some testing when I get half a
> chance.
> 
> plain text document attachment (mm-swap-fail.patch)
> Notice swap write errors during page reclaim, and deallocate the swap entry
> which is backing the swapcache. This allows the page error to be cleared and
> the page be allocated to a new entry, rather than the page to becoming pinned
> forever.

I finally got around to doing some debugging on this patch
(http://lkml.org/lkml/2006/11/1/7). Firstly, I can't seem to reproduce
the SIGBUS issues I was seeing so I'm assuming that was some bug I
introduced somewhere along the line and/or something fixed in mainline.
The patch below is a diff on top of the patch linked to above so you can
see what I needed to change to make it work.

The patch you proposed locked upon entry to try_to_unuse_entry() as
shrink_page_list() already had the page locked. I therefore moved the
locking to try_to_unuse() but this is complicated by the retry loop. The
solution below handles this but is slightly ugly as it has the "magic"
locking sequence in two places and I'm not sure where the associated
comment should go. An alternative might be to return -EAGAIN and have
the caller perform the loop for us but I'm not keen on having to
replicate this to all call sites. We could also just check if the page
was locked by the caller? Whats the best way to handle this?

The refcounting was also broken which I solved by moving
page_cache_release() to try_to_unuse() with the locking. Alternatively,
should try_to_unuse_page_entry() increase some refcount?

I added a sanity check to make sure that if we unused a page and it was
no longer in swapcache, its dirty bit was cleared. I suspect this isn't
actually needed but should be harmless.

I also moved the pages with error check outside PageAnon(page) as
otherwise you can see IO loops where it continually tries to swap out a
page with errors.

With these changes, the patch has coped fine with the testing I've
exposed it to where entire swap devices sudden stopped accepting writes.
It happily marked every page in the swap partition bad with no
instabilities.

If we can agree a way to handle the page locking, I think this patch
might be ready for -mm? I'm happy to split it into a small series and
submit it...

Richard


Index: linux-2.6.19/mm/swapfile.c
===================================================================
--- linux-2.6.19.orig/mm/swapfile.c	2006-12-13 11:23:34.000000000 +0000
+++ linux-2.6.19/mm/swapfile.c	2006-12-13 11:21:11.000000000 +0000
@@ -669,9 +669,6 @@ static int try_to_unuse_entry(swp_entry_
 	 * tests, do_swap_page and try_to_unuse repeatedly compete.
 	 */
 retry:
-	wait_on_page_locked(page);
-	wait_on_page_writeback(page);
-	lock_page(page);
 	wait_on_page_writeback(page);
 
 	/*
@@ -729,11 +726,8 @@ retry:
 		mmput(start_mm);
 		start_mm = new_start_mm;
 	}
-	if (retval) {
-		unlock_page(page);
-		page_cache_release(page);
-		goto out;
-	}
+	if (retval)
+		return retval;
 
 	/*
 	 * How could swap count reach 0x7fff when the maximum pid is 0x7fff,
@@ -778,6 +772,9 @@ retry:
 			};
 
 			swap_writepage(page, &wbc);
+			wait_on_page_locked(page);
+			wait_on_page_writeback(page);
+			lock_page(page);
 			goto retry;
 		}
 		if (!shmem) {
@@ -801,15 +798,11 @@ retry:
 	 * will preserve it.
 	 */
 	SetPageDirty(page);
-	unlock_page(page);
-	page_cache_release(page);
-
 	if (start_mm_p)
 		*start_mm_p = start_mm;
 	else
 		mmput(start_mm);
 
-out:
 	return retval;
 }
 
@@ -836,6 +829,8 @@ void try_to_unuse_page_entry(struct page
 	BUG_ON(*swap_map == SWAP_MAP_BAD);
 
 	try_to_unuse_entry(entry, swap_map, page, NULL);
+	if (!PageSwapCache(page)) 
+		ClearPageDirty(page);
 }
 
 /*
@@ -941,8 +936,16 @@ static int try_to_unuse(unsigned int typ
 			break;
 		}
 
+		wait_on_page_locked(page);
+		wait_on_page_writeback(page);
+		lock_page(page);
+
 		retval = try_to_unuse_entry(entry, swap_map, page,
 							&start_mm);
+
+		page_cache_release(page);
+		unlock_page(page);
+
 		if (retval)
 			break;
 
Index: linux-2.6.19/mm/vmscan.c
===================================================================
--- linux-2.6.19.orig/mm/vmscan.c	2006-12-13 11:23:34.000000000 +0000
+++ linux-2.6.19/mm/vmscan.c	2006-12-13 11:18:28.000000000 +0000
@@ -489,24 +489,22 @@ static unsigned long shrink_page_list(st
 
 #ifdef CONFIG_SWAP
 		/*
+		 * Encountered an error last time? Try to remove the
+		 * page from its current position, which will notice
+		 * the error and mark that swap entry bad. Then we can
+		 * try allocating another swap entry.
+		 */
+		if (PageSwapCache(page) && unlikely(PageError(page)))
+			try_to_unuse_page_entry(page);
+
+		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
 		 */
-		if (PageAnon(page)) {
-			/*
-			 * Encountered an error last time? Try to remove the
-			 * page from its current position, which will notice
-			 * the error and mark that swap entry bad. Then we can
-			 * try allocating another swap entry.
-			 */
-			if (PageSwapCache(page) && unlikely(PageError(page)))
-				try_to_unuse_page_entry(page);
+		if (PageAnon(page) && !PageSwapCache(page) 
+				&& !add_to_swap(page, GFP_ATOMIC))
+			goto activate_locked;
 
-			if (!PageSwapCache(page)) {
-				if (!add_to_swap(page, GFP_ATOMIC))
-					goto activate_locked;
-			}
-		}
 #endif /* CONFIG_SWAP */
 
 		mapping = page_mapping(page);



