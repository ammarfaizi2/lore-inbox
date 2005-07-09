Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVGIAIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVGIAIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVGIAFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:05:49 -0400
Received: from gold.veritas.com ([143.127.12.110]:190 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262989AbVGIAEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:04:14 -0400
Date: Sat, 9 Jul 2005 01:05:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] swap unsigned int consistency
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090104470.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:04:13.0351 (UTC) FILETIME=[BD378B70:01C58419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The swap header's unsigned int last_page determines the range of swap
pages, but swap_info has been using int or unsigned long in some cases:
use unsigned int throughout (except, in several places a local unsigned
long is useful to avoid overflows when adding).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/swap.h |    6 +++---
 mm/swapfile.c        |   17 +++++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

--- swap5/include/linux/swap.h	2005-07-08 19:14:12.000000000 +0100
+++ swap6/include/linux/swap.h	2005-07-08 19:14:26.000000000 +0100
@@ -129,10 +129,10 @@ struct swap_info_struct {
 	unsigned int highest_bit;
 	unsigned int cluster_next;
 	unsigned int cluster_nr;
+	unsigned int pages;
+	unsigned int max;
+	unsigned int inuse_pages;
 	int prio;			/* swap priority */
-	int pages;
-	unsigned long max;
-	unsigned long inuse_pages;
 	int next;			/* next entry on swap list */
 };
 
--- swap5/mm/swapfile.c	2005-07-08 19:14:12.000000000 +0100
+++ swap6/mm/swapfile.c	2005-07-08 19:14:26.000000000 +0100
@@ -82,7 +82,7 @@ void swap_unplug_io_fn(struct backing_de
 	up_read(&swap_unplug_sem);
 }
 
-static inline int scan_swap_map(struct swap_info_struct *si)
+static inline unsigned long scan_swap_map(struct swap_info_struct *si)
 {
 	unsigned long offset;
 	/* 
@@ -529,10 +529,11 @@ static int unuse_mm(struct mm_struct *mm
  * Scan swap_map from current position to next entry still in use.
  * Recycle to start on reaching the end, returning 0 when empty.
  */
-static int find_next_to_unuse(struct swap_info_struct *si, int prev)
+static unsigned int find_next_to_unuse(struct swap_info_struct *si,
+					unsigned int prev)
 {
-	int max = si->max;
-	int i = prev;
+	unsigned int max = si->max;
+	unsigned int i = prev;
 	int count;
 
 	/*
@@ -575,7 +576,7 @@ static int try_to_unuse(unsigned int typ
 	unsigned short swcount;
 	struct page *page;
 	swp_entry_t entry;
-	int i = 0;
+	unsigned int i = 0;
 	int retval = 0;
 	int reset_overflow = 0;
 	int shmem;
@@ -1214,7 +1215,7 @@ static int swap_show(struct seq_file *sw
 
 	file = ptr->swap_file;
 	len = seq_path(swap, file->f_vfsmnt, file->f_dentry, " \t\n\\");
-	seq_printf(swap, "%*s%s\t%d\t%ld\t%d\n",
+	seq_printf(swap, "%*s%s\t%u\t%u\t%d\n",
 		       len < 40 ? 40 - len : 1, " ",
 		       S_ISBLK(file->f_dentry->d_inode->i_mode) ?
 				"partition" : "file\t",
@@ -1273,7 +1274,7 @@ asmlinkage long sys_swapon(const char __
 	static int least_priority;
 	union swap_header *swap_header = NULL;
 	int swap_header_version;
-	int nr_good_pages = 0;
+	unsigned int nr_good_pages = 0;
 	int nr_extents;
 	sector_t span;
 	unsigned long maxpages = 1;
@@ -1507,7 +1508,7 @@ asmlinkage long sys_swapon(const char __
 	nr_swap_pages += nr_good_pages;
 	total_swap_pages += nr_good_pages;
 
-	printk(KERN_INFO "Adding %dk swap on %s.  "
+	printk(KERN_INFO "Adding %uk swap on %s.  "
 			"Priority:%d extents:%d across:%lluk\n",
 		nr_good_pages<<(PAGE_SHIFT-10), name, p->prio,
 		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10));
