Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318480AbSGSJVg>; Fri, 19 Jul 2002 05:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318483AbSGSJVg>; Fri, 19 Jul 2002 05:21:36 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:35460 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S318480AbSGSJVe>; Fri, 19 Jul 2002 05:21:34 -0400
Date: Fri, 19 Jul 2002 02:22:26 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: [PATCH 4/6] "not nearly so minimal" rmap for 2.5.26
Message-ID: <Pine.LNX.4.44.0207182239350.4647-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the usual place is a series of rmap patches, collected and ported from 
various contributions...

	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.26/

The first three are essentially the same as Andrew & Rik's posted patches 
for 2.5.26, minus the arm changes:

	2.5.26-rmap-1-core
	2.5.26-rmap-2-lrufix
	2.5.26-rmap-3-optimize 

This, the fourth in the series, brings the rmap VM approximately to the 
level of Rik van Riel's rmap-13b patches -- ex. the 2.4-ac kernel tree, 
in terms of basic page replacement, page aging, and lru list logic.  

The basic components of the patch, which might make a sensible splitting 
arrangement someday (?), not in order:

	- make dquot, inode and dentry cache shrinking functions return 
	  the number of pages shrunk

	- add rss limit enforcement and throttling; edit Dave McCracken's 
	  optimizations to add this to rmap.

	- alterations for numa

	- page aging of active list, low-level background aging. 
	  Heuristic akin to Linux 2.0/FreeBSD.

	- preparatory changes to header files: mm_inline.h macros for LRU 
	  list management, for_each_zone(), and other handy bits. 

	- major LRU list shakeup.  shrink_cache functionally becomes 
	  page_launder, which cleans the inactive (dirty) list and creates 
	  a list of freeable pages in inactive (clean), like the 'cache' 
	  list in FreeBSD.  page_launder makes inactive pages "clean", 
	  "clean" pages can be freed immediately or directly reclaimed 
	  without going through the usual page allocation.  Pages on 
	  the active list are aged and sent to inactive (dirty) when they 
	  are cold. Etc, etc...  Lists are per-zone.  Min, low, high, 
	  plenty watermarks dictate when action should be taken to refill 
	  the various lists.

	- Drop_behind takes "already passed" pages in the readahead buffer 
	  and deactivates them to the clean list.  If we need them again, 
	  they're easily reclaimed.  If not, they make easy pickings for 
	  reclaim.

Or something like that.   I have *not* done any kind of patch splitting, 
as significant changes undoubtedly lie ahead.  One seems pretty near:

	- Andrew Morton proposed a series of patches to reduce 
	  pagemap_lru_lock contention -- in essence, they move a lot of 
	  the page management VM functions away from processing one page 
	  at a time, to batch processing.  

		http://mail.nl.linux.org/linux-mm/2002-07/msg00009.html

	  Implementation of this notion for the full rmap patch also looks 
	  very interesting.  In particular:

		a) reclaim_page can reclaim in batch mode from the clean 
		   list.  Rik made the point that it might be good to 
		   drop direct reclaim and simply free the pages.  This 
		   simplifies page_alloc.c logic a bit, and ensures that 
		   page flags need only be updated in rmqueue(), just 
		   like vanilla-2.5-latest.  Right now, we need it in 
		   both rmqueue and reclaim_page for direct-reclaim --
		   took me two days to figure that one out! 

		b) page_launder_zone is a great candidate for 
		   batching, much in the same sense as akpm is batching 
		   shrink_cache().  This is similar to its current 
		   behavior, but we just won't hold the pagemap_lru_lock
		   except to load up on pages to scan.

		c) Same deal for refill_inactive_zone(). 

Once Andrew has stabilized his lock contention patches, it'll be 
interesting to see what they can do for the full rmap vm.  

One significant question is large pages.  Batching is great for 4K pages,
and indeed the motivation is to get some of the good behavior of larger
page sizes, without having to actually do that.  But if large pages are
necessary to some folks, how do we (or should we) nicely degrade to
unbatched processing?  Batch processing 4M pages sounds a bit on the
coarse side! :)

Give the patches a try, try to break them, send me feedback and fixes. ;)

Craig Kulesa
Steward Observatory
Univ. of Arizona

