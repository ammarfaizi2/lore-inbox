Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVGIAIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVGIAIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVGIAF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:05:57 -0400
Received: from gold.veritas.com ([143.127.12.110]:60349 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262998AbVGIADX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:03:23 -0400
Date: Sat, 9 Jul 2005 01:04:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] show span of swap extents
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090103530.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:03:20.0601 (UTC) FILETIME=[9DC68890:01C58419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "Adding %dk swap" message shows the number of swap extents, as a guide
to how fragmented the swapfile may be.  But a useful further guide is what
total extent they span across (sometimes scarily large).

And there's no need to keep nr_extents in swap_info: it's unused after
the initial message, so save a little space by keeping it on stack.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/swap.h |    1 -
 mm/swapfile.c        |   44 ++++++++++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 15 deletions(-)

--- swap4/include/linux/swap.h	2005-07-08 19:14:00.000000000 +0100
+++ swap5/include/linux/swap.h	2005-07-08 19:14:12.000000000 +0100
@@ -122,7 +122,6 @@ struct swap_info_struct {
 	struct file *swap_file;
 	struct block_device *bdev;
 	struct list_head extent_list;
-	int nr_extents;
 	struct swap_extent *curr_swap_extent;
 	unsigned old_block_size;
 	unsigned short * swap_map;
--- swap4/mm/swapfile.c	2005-07-08 19:14:00.000000000 +0100
+++ swap5/mm/swapfile.c	2005-07-08 19:14:12.000000000 +0100
@@ -852,7 +852,6 @@ static void destroy_swap_extents(struct 
 		list_del(&se->list);
 		kfree(se);
 	}
-	sis->nr_extents = 0;
 }
 
 /*
@@ -891,8 +890,7 @@ add_swap_extent(struct swap_info_struct 
 	new_se->start_block = start_block;
 
 	list_add_tail(&new_se->list, &sis->extent_list);
-	sis->nr_extents++;
-	return 0;
+	return 1;
 }
 
 /*
@@ -926,7 +924,7 @@ add_swap_extent(struct swap_info_struct 
  * This is extremely effective.  The average number of iterations in
  * map_swap_page() has been measured at about 0.3 per page.  - akpm.
  */
-static int setup_swap_extents(struct swap_info_struct *sis)
+static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 {
 	struct inode *inode;
 	unsigned blocks_per_page;
@@ -934,11 +932,15 @@ static int setup_swap_extents(struct swa
 	unsigned blkbits;
 	sector_t probe_block;
 	sector_t last_block;
+	sector_t lowest_block = -1;
+	sector_t highest_block = 0;
+	int nr_extents = 0;
 	int ret;
 
 	inode = sis->swap_file->f_mapping->host;
 	if (S_ISBLK(inode->i_mode)) {
 		ret = add_swap_extent(sis, 0, sis->max, 0);
+		*span = sis->pages;
 		goto done;
 	}
 
@@ -983,19 +985,28 @@ static int setup_swap_extents(struct swa
 			}
 		}
 
+		first_block >>= (PAGE_SHIFT - blkbits);
+		if (page_no) {	/* exclude the header page */
+			if (first_block < lowest_block)
+				lowest_block = first_block;
+			if (first_block > highest_block)
+				highest_block = first_block;
+		}
+
 		/*
 		 * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
 		 */
-		ret = add_swap_extent(sis, page_no, 1,
-				first_block >> (PAGE_SHIFT - blkbits));
-		if (ret)
+		ret = add_swap_extent(sis, page_no, 1, first_block);
+		if (ret < 0)
 			goto out;
+		nr_extents += ret;
 		page_no++;
 		probe_block += blocks_per_page;
 reprobe:
 		continue;
 	}
-	ret = 0;
+	ret = nr_extents;
+	*span = 1 + highest_block - lowest_block;
 	if (page_no == 0)
 		page_no = 1;	/* force Empty message */
 	sis->max = page_no;
@@ -1263,6 +1274,8 @@ asmlinkage long sys_swapon(const char __
 	union swap_header *swap_header = NULL;
 	int swap_header_version;
 	int nr_good_pages = 0;
+	int nr_extents;
+	sector_t span;
 	unsigned long maxpages = 1;
 	int swapfilesize;
 	unsigned short *swap_map;
@@ -1298,7 +1311,6 @@ asmlinkage long sys_swapon(const char __
 		nr_swapfiles = type+1;
 	INIT_LIST_HEAD(&p->extent_list);
 	p->flags = SWP_USED;
-	p->nr_extents = 0;
 	p->swap_file = NULL;
 	p->old_block_size = 0;
 	p->swap_map = NULL;
@@ -1475,9 +1487,11 @@ asmlinkage long sys_swapon(const char __
 		p->swap_map[0] = SWAP_MAP_BAD;
 		p->max = maxpages;
 		p->pages = nr_good_pages;
-		error = setup_swap_extents(p);
-		if (error)
+		nr_extents = setup_swap_extents(p, &span);
+		if (nr_extents < 0) {
+			error = nr_extents;
 			goto bad_swap;
+		}
 		nr_good_pages = p->pages;
 	}
 	if (!nr_good_pages) {
@@ -1492,9 +1506,11 @@ asmlinkage long sys_swapon(const char __
 	p->flags = SWP_ACTIVE;
 	nr_swap_pages += nr_good_pages;
 	total_swap_pages += nr_good_pages;
-	printk(KERN_INFO "Adding %dk swap on %s.  Priority:%d extents:%d\n",
-		nr_good_pages<<(PAGE_SHIFT-10), name,
-		p->prio, p->nr_extents);
+
+	printk(KERN_INFO "Adding %dk swap on %s.  "
+			"Priority:%d extents:%d across:%lluk\n",
+		nr_good_pages<<(PAGE_SHIFT-10), name, p->prio,
+		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10));
 
 	/* insert swap space into swap_list: */
 	prev = -1;
