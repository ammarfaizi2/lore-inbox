Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270101AbRHYSve>; Sat, 25 Aug 2001 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270309AbRHYSvZ>; Sat, 25 Aug 2001 14:51:25 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:59047 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S270101AbRHYSvJ>; Sat, 25 Aug 2001 14:51:09 -0400
Date: Sat, 25 Aug 2001 19:51:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: What version of the kernel fixes these VM issues?
Message-ID: <20010825195123.D2694@flint.arm.linux.org.uk>
In-Reply-To: <20010825163138Z16125-32384+506@humbolt.nl.linux.org> <Pine.LNX.4.33.0108251420510.20456-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108251420510.20456-100000@xanadu.home>; from nico@cam.org on Sat, Aug 25, 2001 at 02:29:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm saying this for the record, Nico already knows the following ;)

On Sat, Aug 25, 2001 at 02:29:00PM -0400, Nicolas Pitre wrote:
> SysRq: Show Memory
> Mem-info:
> Free pages:        1016kB (     0kB HighMem)
> ( Active: 2554, inactive_dirty: 0, inactive_clean: 0, free: 254 (255 510 765) )
> 4*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 1016kB)
> = 0kB)
> = 0kB)
> Swap cache: add 0, delete 0, find 0/0
> Free swap:            0kB
> 8192 pages of RAM
> 395 free pages
> 626 reserved pages
> 581 pages shared
> 0 pages swap cached
> 3 page tables cached
> Buffer memory:     8000kB

The above buffer memory usage is caused by an 8MB ramdisk.  Unfortunately,
we are looking by default for 8192 * (2 + 2) / 100 = 327 pages between the
buffermem and the page cache before triggering the OOM handler.

With an 8MB ramdisk (== 2000 pages) obviously we'll never reach that, so
we might as well not have the oom handler in this case... or...

With the attached patch, we take the number of ramdisk pages into account
when checking for OOM.  (side note: we don't seem to account for ramdisk
pages, therefore I have to count the individual pages on the active list).

The patch below factors out the fixed ramdisk allocation, and allows the
OOM killer to be functional on machines with ramdisks.  We only count the
number of ramdisk pages when we're getting close to the limit (ie,
freepages stuff indicates oom, and there's no swap).

As an added bonus, this patch also dumps out the number of Page Cache
pages, buffermem pages, and ramdisk pages on sysrq-m.

Note that this doesn't solve Nico's original problem.

diff -x .* -x *.[oas] -urN ref/mm/oom_kill.c linux/mm/oom_kill.c
--- ref/mm/oom_kill.c	Tue Aug 14 21:39:03 2001
+++ linux/mm/oom_kill.c	Sat Aug 25 18:01:41 2001
@@ -193,6 +193,8 @@
 	return;
 }
 
+extern long count_ramdisk_pages(void);
+
 /**
  * out_of_memory - is the system out of memory?
  *
@@ -210,6 +212,10 @@
 	if (nr_free_pages() + nr_inactive_clean_pages() > freepages.low)
 		return 0;
 
+	/* Enough swap space left?  Not OOM. */
+	if (nr_swap_pages > 0)
+		return 0;
+
 	/*
 	 * If the buffer and page cache (excluding swap cache) are over
 	 * their (/proc tunable) minimum, we're still not OOM.  We test
@@ -219,14 +225,11 @@
 	cache_mem = atomic_read(&page_cache_size);
 	cache_mem += atomic_read(&buffermem_pages);
 	cache_mem -= swapper_space.nrpages;
+	cache_mem -= count_ramdisk_pages();
 	limit = (page_cache.min_percent + buffer_mem.min_percent);
 	limit *= num_physpages / 100;
 
 	if (cache_mem > limit)
-		return 0;
-
-	/* Enough swap space left?  Not OOM. */
-	if (nr_swap_pages > 0)
 		return 0;
 
 	/* Else... */
diff -x .* -x *.[oas] -urN ref/mm/page_alloc.c linux/mm/page_alloc.c
--- ref/mm/page_alloc.c	Tue Aug 21 22:30:51 2001
+++ linux/mm/page_alloc.c	Sat Aug 25 18:01:12 2001
@@ -690,6 +690,8 @@
      return (sum > 0 ? sum : 0);
 }
 
+extern long count_ramdisk_pages(void);
+
 /*
  * Show free area list (used inside shift_scroll-lock stuff)
  * We also calculate the percentage fragmentation. We do this by counting the
@@ -743,6 +745,10 @@
 #ifdef SWAP_CACHE_INFO
 	show_swap_cache_info();
 #endif	
+
+	printk("Page cache size: %d\n", atomic_read(&page_cache_size));
+	printk("Buffer mem: %d\n", atomic_read(&buffermem_pages));
+	printk("Ramdisk pages: %ld\n", count_ramdisk_pages());
 }
 
 void show_free_areas(void)
diff -x .* -x *.[oas] -urN ref/mm/vmscan.c linux/mm/vmscan.c
--- ref/mm/vmscan.c	Thu Aug 23 20:07:43 2001
+++ linux/mm/vmscan.c	Sat Aug 25 19:11:46 2001
@@ -816,6 +816,24 @@
 	return nr_deactivated;
 }
 
+long count_ramdisk_pages(void)
+{
+	struct list_head *page_lru;
+	struct page *page;
+	long nr_ramdisk = 0;
+
+	spin_lock(&pagemap_lru_lock);
+	for (page_lru = active_list.next; page_lru != &active_list;
+	     page_lru = page_lru->next) {
+		page = list_entry(page_lru, struct page, lru);
+		if (page_ramdisk(page))
+			nr_ramdisk ++;
+	}
+	spin_unlock(&pagemap_lru_lock);
+
+	return nr_ramdisk;
+}
+
 /*
  * Check if there are zones with a severe shortage of free pages,
  * or if all zones have a minor shortage.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

