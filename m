Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271859AbRICXdG>; Mon, 3 Sep 2001 19:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271860AbRICXc6>; Mon, 3 Sep 2001 19:32:58 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:425 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271859AbRICXck>;
	Mon, 3 Sep 2001 19:32:40 -0400
Date: Tue, 04 Sep 2001 00:32:51 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: [PATCH] Instrumenting, and (??) fixing, fragmentation in buddy system for high order allocs
Message-ID: <1134626955.999563571@[169.254.198.40]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further to yesterday's thread, I thought I'd have
a further look at high order memory allocations
and the buddy allocator.

One patch here (the first) can go into the tree I think
(tested against vanilla 2.4.9). The second is tested,
but needs to have its efficacy proven.

Task 1:
=======

Instrument the buddy allocator, and see if we can determine
a test which causes the instrumentation to show that there is
a problem.

This is easy enough: see patch #1 below, against stock 2.4.9,
tested, which adds /proc/memareas. "watch cat /proc/memareas"
is extremely instructive.

/proc/memareas gives you the same sort of display SysRq-M
gives, but more readably - i.e. the number of free areas
in each zone of each order. It also adds a fragmentation
percentage. This is defined as the % of free memory in that
zone which is only available in units than the pertinent
order. So for 64kb order in the normal zone, this would
be the % of free memory in the normal zone held in 4kb,
8kb, 16kb and 32kb orders. When fragmentation reaches
100% for a given order, we are unable to allocate from
that order, as all free memory is held in smaller orders.

First set of results below (marked Vanilla 2.4.9 MM) show
the result of a single iteration of bonnie++ from a cold
boot. Initially there isn't much fragmentation. However,
bonnie++ quickly fragments memory (second snapshot during
bonnie++). The third snapshot was after bonnie++ had run,
allowing 30 seconds or so of quiescent system. Not much
of the fragmentation disappears. Much of the fragmentation
comes from the 'creating unique files' stage, as opposed
to the earlier I/O stage. I wonder if this tells us
something.

Task 2
======

See if my earlier patch (attached) helped things, or broke
things (well, actually see if it boots and survives was new).
This patch does 2 things:

1. Attempt to place newly freed memory areas on an
   optimized 'end' of the free area queue. If we think
   the buddy is likely to be free soon, we put it on the
   tail end, where our area will be used later than the
   default, which is we put it on the head end. 'Buddy
   likely to be free soon' is defined as (at order 0)
   the buddy is on the InactiveClean or InactiveDirty
   list, and (at order>0) the buddy has one unallocated
   half.

2. Make memory pressure increase/decrease by 1<<order, rather
   than 1.

So the good news is that the patch runs perfectly.

Results included below for the same test.

Looking at the percentage fragmentation, there is a
marginal (i.e. hardly detectable) improvement in
% fragmentation. However, very strangely, the system
ran with about 10% of the previous number of free
pages. They all came back, so this is not a leak.
I am guessing this means it was buffering more
efficiently or something. To be honest, this was
NOT what I was expecting, so I'm at a bit of a loss.

To be fair, the patch was designed to improve matters
in low memory situations, for GFP_ATOMIC allocations,
and I was testing neither of these. So performing
equally is not a bad start.


Testers Please
==============

I'd be interested in people testing this stuff. I believe
both patches are stable. Apply in order.

I think Patch #1 could go into the tree as it's
non-intrusive.

Patch #2 needs more testing. Though it's light weight,
no point changing code if it doesn't do any good. We need
to find people who have high order memory alloc failures
to test this stuff.

--
Alex Bligh



RESULTS
=======

Vanilla 2.4.9 MM
================

Before bonnie++
---------------

   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB  1024kB  2048kB Tot Pages/kb
    DMA       2       2       4       3       3       3       1       1       0       6 =     3454
  @frag      0%      0%      0%      1%      1%      3%      6%      7%     11%     11%      13816kB
 Normal      33      70      15      13       3       2       1       0       1      22 =    12033
  @frag      0%      0%      1%      2%      3%      3%      4%      4%      4%      6%      48132kB
HighMem = 0kB - zero size zone


During bonnie++
---------------

   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB  1024kB  2048kB Tot Pages/kb
    DMA     495     349     197      71      10       1       1       0       0       0 =     2805
  @frag      0%     18%     43%     71%     91%     97%     98%    100%    100%    100%      11220kB
 Normal     984    2576    1670     666     140      12       3       1       0       0 =    21088
  @frag      0%      5%     29%     61%     86%     97%     98%     99%    100%    100%      84352kB
HighMem = 0kB - zero size zone


After bonnie++
--------------

   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB  1024kB  2048kB Tot Pages/kb
    DMA     495     348     196      72      10       1       1       0       0       0 =     2807)
  @frag      0%     18%     42%     70%     91%     97%     98%    100%    100%    100% =    11228kB
 Normal       0    1579    1670     667     140      12       3       1       0       0 =    18118)
  @frag      0%      0%     17%     54%     84%     96%     98%     99%    100%    100% =    72472kB
HighMem = 0kB - zero size zone


2.4.9 + Buddy patches
=====================

Before bonnie++
---------------

   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB  1024kB  2048kB Tot Pages/kb
    DMA       2       2       4       3       3       3       1       1       0       6 =     3454
  @frag      0%      0%      0%      1%      1%      3%      6%      7%     11%     11%      13816kB
 Normal      84      84      56      30      21       7       5       0       2      22 =    13372
  @frag      0%      1%      2%      4%      5%      8%     10%     12%     12%     16%      53488kB
HighMem = 0kB - zero size zone


During bonnie++
---------------

   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB  1024kB  2048kB Tot Pages/kb
    DMA       1       1      21       7       1       1       1       0       0       0 =      255
  @frag      0%      0%      1%     34%     56%     62%     75%    100%    100%    100%       1020kB
 Normal       5       2       1      30       0       0       1       1       0       0 =      445
  @frag      0%      1%      2%      3%     57%     57%     57%     71%    100%    100%       1780kB
HighMem = 0kB - zero size zone


After bonnie++
--------------

   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB  1024kB  2048kB Tot Pages/kb
    DMA     482     375     204      67       9       1       1       0       0       0 =     2824
  @frag      0%     17%     44%     73%     92%     97%     98%    100%    100%    100%      11296kB
 Normal       0     905    1649     707     154      20       1       1       0       0 =    17358
  @frag      0%      0%     10%     48%     81%     95%     99%     99%    100%    100%      69432kB
HighMem = 0kB - zero size zone


PATCH #1 - INSTRUMENT BUDDY SYSTEM ONLY
=======================================


--- include/linux/mm.h-vanilla	Mon Sep  3 21:10:34 2001
+++ include/linux/mm.h	Mon Sep  3 22:12:14 2001
@@ -419,6 +419,8 @@
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr),0)

+extern int proc_memareas(char * buffer);
+
 extern void show_free_areas(void);
 extern void show_free_areas_node(pg_data_t *pgdat);

--- mm/page_alloc.c.vanilla	Thu Aug 16 17:43:02 2001
+++ mm/page_alloc.c	Mon Sep  3 22:52:01 2001
@@ -622,8 +622,6 @@

 /*
  * Show free area list (used inside shift_scroll-lock stuff)
- * We also calculate the percentage fragmentation. We do this by counting the
- * memory on each free list with the exception of the first item on the list.
  */
 void show_free_areas_core(pg_data_t *pgdat)
 {
@@ -679,6 +677,101 @@
 {
 	show_free_areas_core(pgdat_list);
 }
+
+
+
+
+int proc_memareas_core(char * buffer, pg_data_t *pgdat)
+{
+ 	unsigned long order;
+	unsigned type;
+
+	int len=0;
+
+	len += sprintf(buffer+len,
+		       "%7s ","Zone");
+
+	for (order = 0; order < MAX_ORDER; order++) {
+	  len += sprintf(buffer+len,
+			 "%5lukB ",
+			 (PAGE_SIZE>>10) << order);
+	}
+
+	len += sprintf(buffer+len,
+		       "Tot Pages/kb\n");
+
+	for (type = 0; type < MAX_NR_ZONES; type++) {
+		struct list_head *head, *curr;
+		zone_t *zone = pgdat->node_zones + type;
+ 		unsigned long nr, total, flags, smaller, pages[MAX_ORDER];
+
+		len += sprintf(buffer+len,
+			       "%7s ",
+			       zone_names[type]);
+
+		total = 0;
+		if (zone->size) {
+			spin_lock_irqsave(&zone->lock, flags);
+		 	for (order = 0; order < MAX_ORDER; order++) {
+				head = &(zone->free_area + order)->free_list;
+				curr = head;
+				nr = 0;
+				for (;;) {
+					curr = memlist_next(curr);
+					if (curr == head)
+						break;
+					nr++;
+				}
+
+				pages[order] = nr * (1 << order);
+				total += pages[order];
+
+				len += sprintf(buffer+len,
+					       "%7lu ",
+					       nr);
+			}
+			spin_unlock_irqrestore(&zone->lock, flags);
+			
+			len+=sprintf(buffer+len,
+				     "= %8lu\n%7s ",
+				     total,
+				     " @frag");
+
+			smaller = 0;
+		 	for (order = 0; order < MAX_ORDER; order++) {
+			  /* smaller contains the number of pages
+			   * allocated in smaller orders
+			   * Note thus that order 0 is always perfectly
+			   * defragmented
+			   */
+			  len+=sprintf(buffer+len,
+				       "%6lu%% ",
+				       ((smaller*100)+(total>>1))
+				       /(total?total:1));
+
+			  /* Fix up smaller */
+			  smaller += pages[order];
+			}
+			len+=sprintf(buffer+len, "  %8lukB\n",
+				     total * (PAGE_SIZE>>10)
+				     );
+		}
+		else {
+			len+=sprintf(buffer+len,
+				     "= 0kB - zero size zone\n"
+				     );
+		}
+
+	}
+
+	return len;
+}
+
+int proc_memareas(char * buffer)
+{
+	return ( proc_memareas_core(buffer, pgdat_list) );
+}
+

 /*
  * Builds allocation fallback zone lists.
--- fs/proc/proc_misc.c.vanilla	Sat Jul  7 19:43:24 2001
+++ fs/proc/proc_misc.c	Mon Sep  3 22:10:56 2001
@@ -135,6 +135,14 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }

+static int memareas_read_proc(char *page, char **start, off_t off,
+		       int count, int *eof, void *data)
+{
+	int len = proc_memareas(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+
 static int meminfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -518,6 +526,7 @@
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
+		{"memareas",	memareas_read_proc},
 		{"version",	version_read_proc},
 		{"cpuinfo",	cpuinfo_read_proc},
 #ifdef CONFIG_PROC_HARDWARE



PATCH #2 - TWEAK BUDDY SYSTEM & MEMORY PRESSURE
===============================================


--- mm/page_alloc.c.keep	Mon Sep  3 22:52:01 2001
+++ mm/page_alloc.c	Mon Sep  3 23:22:51 2001
@@ -69,6 +69,8 @@
 	struct page *base;
 	zone_t *zone;

+	int addfront=1;
+
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
@@ -112,10 +114,29 @@
 		if (area >= zone->free_area + MAX_ORDER)
 			BUG();
 		if (!__test_and_change_bit(index, area->map))
-			/*
-			 * the buddy page is still allocated.
-			 */
-			break;
+		 {
+		   /*
+		    * The buddy page is still allocated.
+		    *
+		    * Test:
+		    * - If order=0, see if buddy is on Inactive list
+		    * - If order>0, see if buddy has only one 'half'
+		    *		    used, rather than both
+		    * If the appropriate condition is true, then we
+		    * conclude the buddy may be free soon, so add
+		    * it to the tail of the queue. Else we
+		    * add it to the head.
+		    */
+		   if (mask & 1) /* not order 0 merge */
+		     addfront = ( !test_bit((index^1)<<1,
+					    (area-1)->map) &&
+				  !test_bit(((index^1)<<1) | 1,
+					    (area-1)->map) );
+		   else
+		     addfront = !( PageInactiveDirty(base+(page_idx^-mask)) ||
+				   PageInactiveClean(base+(page_idx^-mask)) );
+		   break;
+		 }
 		/*
 		 * Move the buddy up one level.
 		 */
@@ -132,7 +153,11 @@
 		index >>= 1;
 		page_idx &= mask;
 	}
-	memlist_add_head(&(base + page_idx)->list, &area->free_list);
+
+       if (addfront)
+	 memlist_add_head(&(base + page_idx)->list, &area->free_list);
+       else
+	 memlist_add_tail(&(base + page_idx)->list, &area->free_list);

 	spin_unlock_irqrestore(&zone->lock, flags);

@@ -141,8 +166,8 @@
 	 * since it's nothing important, but we do want to make sure
 	 * it never gets negative.
 	 */
-	if (memory_pressure > NR_CPUS)
-		memory_pressure--;
+	if (memory_pressure > (NR_CPUS << order))
+		memory_pressure-= 1<<order;
 }

 #define MARK_USED(index, order, area) \
@@ -288,7 +313,7 @@
 	/*
 	 * Allocations put pressure on the VM subsystem.
 	 */
-	memory_pressure++;
+	memory_pressure+= 1<<order;

 	/*
 	 * (If anyone calls gfp from interrupts nonatomically then it


--
Alex Bligh
