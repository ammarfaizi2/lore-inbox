Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286428AbRLVBFr>; Fri, 21 Dec 2001 20:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286621AbRLVBFY>; Fri, 21 Dec 2001 20:05:24 -0500
Received: from air-1.osdl.org ([65.201.151.5]:35345 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S286428AbRLVBFO>;
	Fri, 21 Dec 2001 20:05:14 -0500
Date: Fri, 21 Dec 2001 17:02:00 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: bounce buffer usage
Message-ID: <Pine.LNX.4.33L2.0112211652430.2896-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

I added bounce in/out counters (for all bounce I/O) and
bounce swap i/o counters to /proc/stat (sample output below,
before and after running fillmem).
I also removed ipackets, opackets, ierrors, oerrors, and
collisions from kernel_stat, but this isn't critical.

I also added a warning message (every 1000th occurrence) if/when
highmem is used for swap io (in 2.4.x, highmem => bounce).
(small sample also below; my log file is full of them,
and this part of the patch is overkill on messages. :)


Are there any drivers in 2.4.x that support highmem directly,
or is all of that being done in 2.5.x (BIO patches)?
so that I can run the same tests without using highmem bounce
for swapping...

Would it be useful to try this with a 2.5.1 kernel?

Here's a comparison on 2.4.16, using 6 instances of 'fillmem 700'
(from Quintela's memtest files) on a 4 GiB (!) 4-proc ix86 system.

a.  2.4.16 with bounce stats:
Elapsed run time: 2 min:58 sec.

=============== /proc/stat BEFORE fillmem ====================
=========== with 2 new lines [4 new counters] (at end) ==============
cpu  292 0 3248 630512
cpu0 23 0 422 158068
cpu1 116 0 873 157524
cpu2 132 0 877 157504
cpu3 21 0 1076 157416
page 12847 816
swap 3 0
intr 168971 158513 2 0 0 6 0 3 1 0 0 0 0 0 0 4 0 0 0 0 310 6305 0 0 0 2063 942 0 807 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (8,0):(1924,1556,25550,368,1632) (8,1):(3,3,24,0,0) (8,2):(1,1,8,0,0) (8,3):(2,2,16,0,0) (8,4):(2,2,16,0,0) (8,5):(2,2,16,0,0) (8,6):(2,2,16,0,0) (8,7):(2,2,16,0,0) (8,8):(2,2,16,0,0) (8,9):(2,2,16,0,0)
ctxt 11542
btime 1008974326
processes 387
bounce io 23966 476
bounce swap io 0 0

=============== /proc/stat AFTER fillmem ====================
=========== with 2 new lines [4 new counters] (at end) ==============
cpu  3320 0 20454 681522
cpu0 876 0 4860 170588
cpu1 850 0 5257 170217
cpu2 982 0 4975 170367
cpu3 612 0 5362 170350
page 686457 725766
swap 168354 181146
intr 216713 176324 2 0 0 6 0 3 1 0 0 0 0 0 0 4 0 0 0 0 310 7313 0 0 0 30804 1033 0 898 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (8,0):(35376,22879,1372770,12497,1452132) (8,1):(3,3,24,0,0) (8,2):(1,1,8,0,0) (8,3):(2,2,16,0,0) (8,4):(2,2,16,0,0) (8,5):(2,2,16,0,0) (8,6):(2,2,16,0,0) (8,7):(2,2,16,0,0) (8,8):(2,2,16,0,0) (8,9):(2,2,16,0,0)
ctxt 4110183
btime 1008974326
processes 644
bounce io 1311468 195826
bounce swap io 160892 24385

----------------------------------------------------------------------
b.  2.4.16 with bounce stats and linux/mm/swap_state.c::read_swap_cache_async()
only allocating swap pages in ZONE_NORMAL (i.e., not in HIGHMEM):
Elapsed run time: 3 min:11 sec.
(This part of the patch was done just to reduce Highmem bouncing,
although it doesn't help in elapsed run time.)

=============== /proc/stat BEFORE fillmem ====================
=========== with 2 new lines [4 new counters] (at end) ==============
cpu  253 0 3344 845231
cpu0 27 0 376 211804
cpu1 17 0 797 211393
cpu2 20 0 844 211343
cpu3 189 0 1327 210691
page 12899 815
swap 3 0
intr 225242 212207 2 0 0 6 0 3 1 0 0 0 0 0 0 4 0 0 0 0 310 8300 0 0 0 2095 1218 0 1081 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (8,0):(1945,1563,25654,382,1630) (8,1):(3,3,24,0,0) (8,2):(1,1,8,0,0) (8,3):(2,2,16,0,0) (8,4):(2,2,16,0,0) (8,5):(2,2,16,0,0) (8,6):(2,2,16,0,0) (8,7):(2,2,16,0,0) (8,8):(2,2,16,0,0) (8,9):(2,2,16,0,0)
ctxt 12951
btime 1008978227
processes 396
bounce io 24046 476
bounce swap io 0 0

=============== /proc/stat AFTER fillmem ====================
=========== with 2 new lines [4 new counters] (at end) ==============
cpu  3047 0 17262 904935
cpu0 715 0 3838 226758
cpu1 826 0 4374 226111
cpu2 458 0 4425 226428
cpu3 1048 0 4625 225638
page 685718 854715
swap 168157 213360
intr 275576 231311 2 0 0 6 0 3 1 0 0 0 0 0 0 4 0 0 0 0 310 9454 0 0 0 31975 1316 0 1179 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
disk_io: (8,0):(37156,22904,1371300,14252,1709926) (8,1):(3,3,24,0,0) (8,2):(1,1,8,0,0) (8,3):(2,2,16,0,0) (8,4):(2,2,16,0,0) (8,5):(2,2,16,0,0) (8,6):(2,2,16,0,0) (8,7):(2,2,16,0,0) (8,8):(2,2,16,0,0) (8,9):(2,2,16,0,0)
ctxt 675273
btime 1008978227
processes 665
bounce io 24410 164072
bounce swap io 0 20415


Thanks,
~Randy  [see ya next year]
	"What's that bright yellow object out the window?"


============================= sample dmesg ==============================
bounce io (R) for 8:17
bounce io (R) for 8:17
bounce io (R) for 8:8
bounce io (R) for 8:6
bounce io (R) for 8:18
bounce io (R) for 8:17
bounce io (R) for 8:18
bounce io (R) for 8:8
bounce io (R) for 8:18
bounce io (W) for 8:18
bounce io (W) for 8:6
bounce io (R) for 8:18
bounce io (R) for 8:17
bounce io (R) for 8:6
bounce io (R) for 8:17
bounce io (R) for 8:18
bounce io (W) for 8:8
bounce io (W) for 8:8
bounce io (W) for 8:8
bounce io (R) for 8:18
bounce io (R) for 8:17
bounce io (R) for 8:18
bounce io (R) for 8:18
bounce io (R) for 8:17
bounce io (W) for 8:8
bounce io (W) for 8:8
bounce io (R) for 8:18
bounce io (R) for 8:17
bounce io (W) for 8:8
bounce io (R) for 8:8
bounce io (R) for 8:18
bounce io (R) for 8:8

Bounce-stats patch:
======================
--- linux/include/linux/kernel_stat.h.org	Mon Nov 26 10:19:29 2001
+++ linux/include/linux/kernel_stat.h	Thu Dec 20 13:26:50 2001
@@ -26,12 +26,14 @@
 	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int pgpgin, pgpgout;
 	unsigned int pswpin, pswpout;
+	unsigned int bouncein, bounceout;
+	unsigned int bounceswapin, bounceswapout;
 #if !defined(CONFIG_ARCH_S390)
 	unsigned int irqs[NR_CPUS][NR_IRQS];
 #endif
-	unsigned int ipackets, opackets;
-	unsigned int ierrors, oerrors;
-	unsigned int collisions;
+///	unsigned int ipackets, opackets;
+///	unsigned int ierrors, oerrors;
+///	unsigned int collisions;
 	unsigned int context_swtch;
 };

--- linux/fs/proc/proc_misc.c.org	Tue Nov 20 21:29:09 2001
+++ linux/fs/proc/proc_misc.c	Thu Dec 20 13:34:44 2001
@@ -310,6 +310,12 @@
 		xtime.tv_sec - jif / HZ,
 		total_forks);

+	len += sprintf(page + len,
+		"bounce io %u %u\n"
+		"bounce swap io %u %u\n",
+		kstat.bouncein, kstat.bounceout,
+		kstat.bounceswapin, kstat.bounceswapout);
+
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }

--- linux/mm/page_io.c.org	Mon Nov 19 15:19:42 2001
+++ linux/mm/page_io.c	Thu Dec 20 15:59:41 2001
@@ -10,6 +10,7 @@
  *  Always use brw_page, life becomes simpler. 12 May 1998 Eric Biederman
  */

+#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
@@ -68,6 +69,13 @@
 		dev = swapf->i_dev;
 	} else {
 		return 0;
+	}
+
+	if (PageHighMem(page)) {
+		if (rw == WRITE)
+			kstat.bounceswapout++;
+		else
+			kstat.bounceswapin++;
 	}

  	/* block_size == PAGE_SIZE/zones_used */
--- linux/drivers/block/ll_rw_blk.c.org	Mon Oct 29 12:11:17 2001
+++ linux/drivers/block/ll_rw_blk.c	Thu Dec 20 17:45:19 2001
@@ -873,6 +873,7 @@
 	} while (q->make_request_fn(q, rw, bh));
 }

+static int bmsg_count = 0;

 /**
  * submit_bh: submit a buffer_head to the block device later for I/O
@@ -890,6 +891,7 @@
 void submit_bh(int rw, struct buffer_head * bh)
 {
 	int count = bh->b_size >> 9;
+	int bounce = PageHighMem(bh->b_page);

 	if (!test_bit(BH_Lock, &bh->b_state))
 		BUG();
@@ -908,10 +910,19 @@
 	switch (rw) {
 		case WRITE:
 			kstat.pgpgout += count;
+			if (bounce) kstat.bounceout += count;
 			break;
 		default:
 			kstat.pgpgin += count;
+			if (bounce) kstat.bouncein += count;
 			break;
+	}
+	if (bounce) {
+		bmsg_count++;
+		if ((bmsg_count % 1000) == 1)
+			printk ("bounce io (%c) for %d:%d\n",
+				(rw == WRITE) ? 'W' : 'R',
+				MAJOR(bh->b_rdev), MINOR(bh->b_rdev));
 	}
 }


Debug patch to partially disable highmem swapping:
====================================================

--- linux/mm/swap_state.c.org	Wed Oct 31 15:31:03 2001
+++ linux/mm/swap_state.c	Fri Dec 21 10:32:02 2001
@@ -180,6 +180,7 @@
  * A failure return means that either the page allocation failed or that
  * the swap entry is no longer in use.
  */
+#define GFP_SWAP_LOW    (             __GFP_WAIT | __GFP_IO |                __GFP_FS )
 struct page * read_swap_cache_async(swp_entry_t entry)
 {
 	struct page *found_page, *new_page = NULL;
@@ -200,7 +201,7 @@
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page(GFP_HIGHUSER);
+			new_page = alloc_page(GFP_SWAP_LOW);
 			if (!new_page)
 				break;		/* Out of memory */
 		}

