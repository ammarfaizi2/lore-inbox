Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266808AbRGXDnd>; Mon, 23 Jul 2001 23:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266853AbRGXDnZ>; Mon, 23 Jul 2001 23:43:25 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:18698 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266808AbRGXDnO>; Mon, 23 Jul 2001 23:43:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Optimization for use-once pages
Date: Tue, 24 Jul 2001 05:47:30 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Message-Id: <01072405473005.00301@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Today's patch tackles the use-once problem, that is, the problem of
how to identify and discard pages containing data likely to be used 
only once in a long time, while retaining pages that are used more 
often.

I'll try to explain not only what I did, but the process I went
through to arrive at this particular approach.  This requires some 
background.

Recent History of Linux Memory Management
-----------------------------------------

Rik van Riel developed our current memory management regime early last 
fall, more or less on a dare by Linus.[1]  At that time the big 
question was, could the poorly-performing 2.3 memory manager be fixed 
up in some way or should it be rewritten from scratch?  Rik favored a 
complete rewrite in the 2.5 timeframe whereas Linus wanted to see 
incremental improvements to the existing code base.  After a little 
flam^H^H^H^H encouragement from Linus, Rik did manage to produce a 
patch that improved the performance of 2.3 considerably.

Rik's patch was loosely inspired by Matt Dillon's FreeBSD work.[2]   At 
that time, FreeBSD enjoyed a clear lead in memory management 
performance over Linux, so it made sense to use his work as a model.  
What Rik came up with though is really his own creation[3] and differs 
in a number of fundamental respects from Matt's work.  After a few 
months of working out minor problems this is essentially what we have 
now.  It works well under typical loads but has tended to suffer from 
variable or even horrible performance under certain rarer loads and 
machine configurations.  Over time some of the problems have been 
tracked down and fixed, the most recent being Marcelo's identification 
and eradication of the zone-imbalance performance bug.[4]

During this whole period, I've been studying Rik's memory manager with 
a view to understanding how it does what it does, and thus, how to go 
about improving it.  I'll to describe the essential details now, as I 
see them.

What Rik's Memory Manager Does
------------------------------

Every physical page of memory in the system can be on at most one of 
three "page_lru" lists.  They are:

   1) active
   2) inactive_dirty (misnomer - has both clean and dirty pages)
   3) inactive_clean (misnomer - really is 'inactive_bufferless')

List (1) is an unordered ring while lists (3) is a fifo queue.  List 
(2) is somewhere in between, a fifo for clean pages and a ring for 
dirty pages.  The transitions are:

   active -> inactive_dirty, if a page is an eviction candidate
   inactive_dirty -> inactive_clean, if a page is not dirty
   inactive_clean -> active, if a page is referenced
   inactive_dirty -> active, if a page is referenced

The memory manager's job is to scan each of these lists from time to 
time and effect the appropriate transitions.  To decide which pages 
should be considered for eviction, the memory manager walks around the 
active ring "aging" pages, "up" if they have been referenced since the 
last scan and "down" otherwise.  A page whose age has reached zero is 
considered to be a good candidate for eviction (a "victim") and is 
moved to the inactive_dirty queue (note: regardless of whether it is 
actually dirty).  The memory manager also scans the "old" end of the 
inactive_dirty queue.  Any page that has been used since being put on 
the queue is moved to the active ring.  Unreferenced clean pages that 
have their buffers (if any) removed and are moved to the inactive_clean 
queue.  Unreferenced dirty pages are scheduled for writeout and moved 
back to the "young" end of the queue, to be rescanned later.  

All of this scanning is driven by demand for pages.  To anticpate 
future demand, the memory manager tries to keep the inactive_clean list 
longer than a certain minimum, and this in turn determines the rate at 
which the other two lists are scanned.

In this short tour of Linux's memory manager I've glossed over many 
subtle details and complexities.  Sorry.  This is just to provide some 
context for discussing the problem at hand, and my approach to solving 
it.  Now on to the theoretical part.

Why it works
------------

The two fifo queues can be thought of as a single, two-stage queue.  So 
what we have is an unordered ring and a queue.  As described above, the 
ring is used to find eviction candidates via the aging process, which 
gives us information about both how frequently and how recently a given 
page was used, mixed together inseparably.  Ultimately, being recently 
used is more important than being frequently used, so to find out 
whether a page really isn't being used we put it on the inactive queue. 
If it goes all the way from one end of the inactive queue to the other 
without being referenced we then know quite a lot more about it, and 
can evict it with a reasonable expectation that it will not need to be 
re-read immediately.  (Notice how this is all kind of approximate - 
memory management is like that.)

Why it doesn't always work
--------------------------

This is the tough question.  If we knew the whole answer, it would 
already be working perfectly under all conditions, or we would have 
moved on to a different design.  Recently though, some of the more 
obscure problems have begun to yield to analysis.  In particular, 
Marcelo demonstrated how important it is to know what the memory manager 
is actually doing, and developed a statistical reporting interface 
(soon to be included in the standard kernel) which allowed him to 
isolate and fix the obscure zone-balancing problem.  There are also 
more of us coming up to speed on understanding the memory manager, both 
the part inherited from 2.2 and the new part designed by Rik.

Use-once Pages
--------------

One of the things we want the memory manager to do is to assign very 
low priority to data that tends to be used once and then not again for 
a long time.  Pages containing such data should be identified and 
evicted as soon as possible.  Typically, these "use-once" pages are 
generated by file IO, either reads or writes, and reside in the page 
cache.  The question is, how do we distinguish between "use-once" file 
data and file data that we should keep in memory, expecting it to be 
used more than once in a short period?  Up till now we've used a simple 
strategy: always expect that file data is "use-once" and queue it for 
eviction immediately after being used.  If it really is going to be 
used more than once, then hopefully it will be used again before it 
reaches the other end of the inactive queue and thus be "rescued" from 
eviction.

Rik added code to the memory manager to implement this idea, which he 
called "drop-behind", and system performance did improve.  (I verified 
this by disabling the code, and sure enough, it got worse again.)  But 
there are several problems with the drop-behind strategy:

  - Deactivates even popular file pages - every time a popular
    file page is touched by generic_file_read or generic_file_write
    it gets deactivated, losing historical information and putting
    the page at risk of being evicted, should its next access come
    a little too late.

  - Busy work - readahead pages circulate on the active list before
    being used and deactivated, which does nothing other than
    consume CPU cycles.

  - Not general - drop-behind specific heuristic for file I/O and
    shows a bias towards one particular access pattern, perhaps at
    the expense of, say, a database-like access pattern.  If for
    some reason, less than an entire file is read, the readahead
    pages will not be deactivated.

  - Doesn't do anything for memory-mapped files.

LRU/2 and 2Q
------------

Enter the LRU/2 Algorithm[5] which provides a specific prescription 
aimed at optimizing for database loads with a mix of use-once pages and 
use-often pages.  The idea is to choose for eviction the page whose 
second-most-recent access was furthest in the past, and not pay any 
attention at all to the time of the most recent access.  This algorithm 
has been shown to be more efficient than classic LRU for real-world 
loads but is difficult to implement efficiently.  The 2Q algorithm, 
discussed on lkml recently, approximates the behavior of LRU/2, 
essentially by ignoring the first use of a page then managing all pages 
referenced at least twice using a normal LRU.  Both LRU/2 and 2Q show 
significant improvements over LRU, on the order of 5-15%, in testing 
against captured real-world database access patterns.

My Approach
-----------

The 2Q algorithm has a major disadvantage from my point of view: it 
uses a LRU list.[6]  We don't, we use the aging strategy described
above.  There are several reasons to keep doing it this way:

  - It's more efficient to update an age than to relink a LRU item
  - Aging captures both frequency and temporal information
  - Aging offers more scope for fine tuning
  - It's what we're doing now - changing would be a lot of work

So I decided to look for a new way of approaching the use-once problem 
that would easily integrated with our current approach.   What I came 
up with is pretty simple: instead of starting a newly allocated page on 
the active ring, I start it on the inactive queue with an age of zero. 
Then, any time generic_file_read or write references a page, if its 
age is zero, set its age to START_AGE and mark it as unreferenced.

This has the effect of scheduling all file pages read or written the
first time for early eviction, but introduces a delay before the 
eviction actually occurs.  If the file page is referenced relatively 
soon thereafter it will be "rescued" from eviction as described above, 
and thereafter aged normally on the active ring.  Subsequent reads and 
writes of the same cached page age it normally and do not cause it to 
be "unreferenced" again, because its age is not zero.  (Just noticed 
while composing this: the attached patch does not provide properly for 
the case where a page deactivated by aging is subsequently 
read/written, and it should.)

Implementing this idea was not as easy as it sounds.  At first, I hoped 
for a one-line implementation:

-	add_page_to_active_list(page);
+	add_page_to_inactive_dirty_list(page);

but alas this was not to be.  The actual implementation required  three 
days of chasing after odd effects caused by redundant tests in the page 
scanning code, and learning a lot more about the life cycles of page 
cache pages.  During this process I managed to disable aging of 
read/write pages completely, resulting in a "fifo" eviction policy.  
This degraded performance by about 60%.  (Truly remarkable not only 
because page io is far from my test case's only activity, but because
it shows just how well we are already doing versus a truly naive 
eviction policy.)  This was especially discouraging because I had 
imagined I was quite close to actually achieving some optimization.  
However, changing just one line took me from that disaster to a version 
that magically turned in a performance 12% better than I'd seen with
the existing code.

In retrospect, if I'd been smarter about this I would have applied 
Marcelo's statistical patch at the beginning of the process.  That 
would have saved me a lot of time spent hunting around in the dark, 
using only the test case running time for feedback.[7]

Test Load
---------

For a test load, I used the following:

    time -o /tmp/time1 make clean bzImage &
    time -o /tmp/time2 grep -r foo /usr/src >/dev/null 2>/dev/null

In other words, a clean make of the kernel concurrent with a grep of my 
(rather large) source directory.  By themselves, the make requires a 
little more than 12 minutes and the grep about 15 minutes.  The stock 
2.4.5 kernel turned in a performance of slightly better than 20 minutes 
for the two simultaneously: very respectable.  All of my "improved" 
kernels did worse than this, up until the last one, which did 
considerably better.  (I think the following principle applies: you 
always find what you are looking for in the last place you look.)

I chose to combine the make and grep in order to create an I/O-bound 
situation, but not without some complexity and with real work being 
done.  With optimal performance, I imagined the disk light would be on 
all, or nearly all the time.  This turned out to be the case.  
Unfortunately, it also turned out to be the case with my disastrous 
"fifo" kernel.  In the latter case, the light was always on because 
pages frequently needed to be read back in immediately after being 
evicted.

This is probably true though: any time the disk light goes out during 
this test it's trying to tell us we're not finished optimizing yet.

Timings
-------

The grep always takes longer than the make, so the numbers for the grep 
are the total elapsed time for both processes to complete and are thus 
more important.  It's nice to see that the make always runs faster with 
the patch though - this shows that the system is treating the two 
processes fairly and the grep is not starving the make too badly for 
disk bandwidth.  (However, I did note with interest that the 
disk-intensive make step involving 'tmppiggy' takes 8 times longer when 
running in parallel with the grep than by itself - there is some poor 
IO scheduling behavior to investigate there.)

Here is the executive summary:

	  2.4.5, vanilla	2.4.5+use.once.patch

make	    16:29.87		     15:46.67
grep	    20:09.15		     17:37.33

So, with the patch, the two processes run to completion 2 1/2 minutes 
faster, a savings of about 13%.  These results are quite repeatable and 
considerably better than what I had hoped for when I began this work.

Detailed timings are given below.  Interestingly, the timings for the
two processes running separately do not vary nearly as much: the make 
runs at virtually the same speed with or without the patch, and the 
grep runs 54 seconds faster, much less than the 2 1/2 minute difference 
seen when the processes run in parallel.

vanilla 2.2.14

make
475.38user 59.71system 16:27.28elapsed 54%CPU
0inputs+0outputs (461932major+513611minor)pagefaults 268swaps

grep
22.14user 71.81system 20:09.15elapsed 7%CPU
0inputs+0outputs (366064major+7236minor)pagefaults 110swaps

vanilla 2.4.5

make
305.70user 229.08system 16:29.87elapsed 54%CPU
0inputs+0outputs (460034major+533055minor)pagefaults 0swaps

grep
13.48user 85.18system 19:49.90elapsed 8%CPU
0inputs+0outputs (1839major+20261minor)pagefaults 0swaps

vanilla 2.4.5 (again)

make
306.05user 229.74system 16:34.83elapsed 53%CPU
0inputs+0outputs (457841major+531251minor)pagefaults 0swaps

grep
13.64user 84.12system 19:52.66elapsed 8%CPU
0inputs+0outputs (2104major+16537minor)pagefaults 0swaps

use.once.patch

make
306.34user 253.36system 15:46.67elapsed 59%CPU
0inputs+0outputs (451569major+522397minor)pagefaults 0swaps

grep
13.20user 81.60system 17:37.33elapsed 8%CPU
0inputs+0outputs (369major+11632minor)pagefaults 0swaps

use.once.patch (again)

make
306.30user 244.88system 15:31.69elapsed 59%CPU
0inputs+0outputs (451352major+522484minor)pagefaults 0swaps

grep
13.50user 82.88system 17:36.84elapsed 9%CPU
0inputs+0outputs (379major+14643minor)pagefaults 0swaps

vanilla 2.4.5, just the make
638.42user 27.96system 12:03.33elapsed 92%CPU
0inputs+0outputs (450134major+520691minor)pagefaults 0swaps

use.once.patch, just the make
632.39user 28.37system 11:58.59elapsed 91%CPU
0inputs+0outputs (450135major+520725minor)pagefaults 0swaps

vanilla 2.4.5, just the grep
13.08user 62.54system 13:43.16elapsed 9%CPU
0inputs+0outputs (1316major+21906minor)pagefaults 0swaps

use.once.patch, just the grep
13.00user 61.05system 12:49.37elapsed 9%CPU
0inputs+0outputs (259major+7586minor)pagefaults 0swaps

[1] http://mail.nl.linux.org/linux-mm/2000-08/msg00023.html
   (Linus goads Rik on to great things)

[2] http://mail.nl.linux.org/linux-mm/2000-05/msg00419.html
   (Rik's discussion with Matt Dillon)

[3] http://mail.nl.linux.org/linux-mm/2000-05/msg00418.html
   (Rik's RFC for his 2.3/4 memory manager design)

[4] http://marc.theaimsgroup.com/?l=linux-kernel&m=99542192302579&w=2
   (Marcelo's fix to the zone balancing problem)

[5] http://www.informatik.uni-trier.de/~ley/db/conf/vldb/vldb94-439.html
   (Original paper on the 2Q algorithm)

[6] A further disadvantage of the 2Q Algorithm is that it is oriented
towards database files with a relatively limited number of blocks in
them, as opposed to files of effectively unlimited size as are common
in a general-purpose operating system.

[7] While doing this work I like to imagine how it must feel to work 
on a tokomak prototype fusion reactor or z-pinch machine.  In these 
projects, scientists and engineers try to put theory into practice by 
squeezing ever more power out of the same, weird and wonderful piece of 
hardware.  Sometimes new ideas work as expected, and sometimes the 
plasma just goes unstable.

The Patch
---------

This is an experimental patch, for comment.  There is a small amount
of raciness in the check_used_once function, on some architectures,
but this would at worst lead to suboptimal performance.  The patch has
been completely stable for me, and it may just be my imagination, but
interactive performance seems to be somewhat improved.

To apply:

    cd /usr/src/your-2.4.5-tree
    patch <this.patch -p0

--- ../2.4.5.clean/mm/filemap.c	Thu May 31 17:30:45 2001
+++ ./mm/filemap.c	Mon Jul 23 17:42:40 2001
@@ -770,51 +770,6 @@
 #endif
 
 /*
- * We combine this with read-ahead to deactivate pages when we
- * think there's sequential IO going on. Note that this is
- * harmless since we don't actually evict the pages from memory
- * but just move them to the inactive list.
- *
- * TODO:
- * - make the readahead code smarter
- * - move readahead to the VMA level so we can do the same
- *   trick with mmap()
- *
- * Rik van Riel, 2000
- */
-static void drop_behind(struct file * file, unsigned long index)
-{
-	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
-	unsigned long start;
-
-	/* Nothing to drop-behind if we're on the first page. */
-	if (!index)
-		return;
-
-	if (index > file->f_rawin)
-		start = index - file->f_rawin;
-	else
-		start = 0;
-
-	/*
-	 * Go backwards from index-1 and drop all pages in the
-	 * readahead window. Since the readahead window may have
-	 * been increased since the last time we were called, we
-	 * stop when the page isn't there.
-	 */
-	spin_lock(&pagecache_lock);
-	while (--index >= start) {
-		page = __find_page_simple(mapping, index);
-		if (!page)
-			break;
-		deactivate_page(page);
-	}
-	spin_unlock(&pagecache_lock);
-}
-
-/*
  * Read-ahead profiling information
  * --------------------------------
  * Every PROFILE_MAXREADCOUNT, the following information is written 
@@ -1033,12 +988,6 @@
 		if (filp->f_ramax > max_readahead)
 			filp->f_ramax = max_readahead;
 
-		/*
-		 * Move the pages that have already been passed
-		 * to the inactive list.
-		 */
-		drop_behind(filp, index);
-
 #ifdef PROFILE_READAHEAD
 		profile_readahead((reada_ok == 2), filp);
 #endif
@@ -1048,6 +997,15 @@
 }
 
 
+inline void check_used_once (struct page *page)
+{
+	if (!page->age)
+	{
+		page->age = PAGE_AGE_START;
+		ClearPageReferenced(page);
+	}
+}
+
 /*
  * This is a generic file read routine, and uses the
  * inode->i_op->readpage() function for the actual low-level
@@ -1163,7 +1121,8 @@
 		offset += ret;
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
-	
+
+		check_used_once (page);
 		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
@@ -2597,7 +2556,6 @@
 	while (count) {
 		unsigned long index, offset;
 		char *kaddr;
-		int deactivate = 1;
 
 		/*
 		 * Try to find the page in the cache. If it isn't there,
@@ -2606,10 +2564,8 @@
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count) {
+		if (bytes > count)
 			bytes = count;
-			deactivate = 0;
-		}
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2653,8 +2609,7 @@
 unlock:
 		/* Mark it unlocked again and drop the page.. */
 		UnlockPage(page);
-		if (deactivate)
-			deactivate_page(page);
+		check_used_once(page);
 		page_cache_release(page);
 
 		if (status < 0)
--- ../2.4.5.clean/mm/swap.c	Mon Jan 22 22:30:21 2001
+++ ./mm/swap.c	Mon Jul 23 17:38:25 2001
@@ -231,11 +231,8 @@
 	spin_lock(&pagemap_lru_lock);
 	if (!PageLocked(page))
 		BUG();
-	DEBUG_ADD_PAGE
-	add_page_to_active_list(page);
-	/* This should be relatively rare */
-	if (!page->age)
-		deactivate_page_nolock(page);
+	add_page_to_inactive_dirty_list(page);
+	page->age = 0;
 	spin_unlock(&pagemap_lru_lock);
 }
 
--- ../2.4.5.clean/mm/vmscan.c	Sat May 26 02:00:18 2001
+++ ./mm/vmscan.c	Mon Jul 23 17:25:27 2001
@@ -359,10 +359,10 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageReferenced(page) || page->age > 0 ||
-				(!page->buffers && page_count(page) > 1)) {
+		if (PageReferenced(page) || (!page->buffers && page_count(page) > 1)) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_active_list(page);
+			page->age = PAGE_AGE_START;
 			continue;
 		}
 
@@ -462,11 +462,11 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageReferenced(page) || page->age > 0 ||
-				(!page->buffers && page_count(page) > 1) ||
+		if (PageReferenced(page) || (!page->buffers && page_count(page) > 1) ||
 				page_ramdisk(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
+			page->age = PAGE_AGE_START;
 			continue;
 		}
 
