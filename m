Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270333AbRIBXbi>; Sun, 2 Sep 2001 19:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRIBXbX>; Sun, 2 Sep 2001 19:31:23 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:38565 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270438AbRIBXbC>;
	Sun, 2 Sep 2001 19:31:02 -0400
Date: Mon, 03 Sep 2001 00:31:16 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: High order page allocs - final thought for tonight
Message-ID: <1048432722.999477076@[169.254.198.40]>
In-Reply-To: <1047062967.999475697@[169.254.198.40]>
In-Reply-To: <1047062967.999475697@[169.254.198.40]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Final thought for tonight & off to bed.

For order=0 returns to list, it may help if we add the
page to the back (rather than the front) of the
list, if its buddy is on the InactiveClean or
InactiveDirty list, as page_launder will find
these first. Also a nice quick chek.
We keep the previous heuristic for order>0 returns
to list.

Patch below has both has previous heuristic,
memory_pressure change, and Inactive[Clean|Dirty]
buddying. Again, uncompiled, untested, against
2.4.9

Daniel: Whitespace fixed - sorry about that.

--
Alex Bligh

--- mm/page_alloc.c.keep	Sun Sep  2 23:32:56 2001
+++ mm/page_alloc.c	Mon Sep  3 00:23:27 2001
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


