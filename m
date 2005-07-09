Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVGIAFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVGIAFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbVGIADc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:03:32 -0400
Received: from gold.veritas.com ([143.127.12.110]:46781 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262989AbVGIAAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:00:39 -0400
Date: Sat, 9 Jul 2005 01:01:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] correct swapfile nr_good_pages
In-Reply-To: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507090101240.13391@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 00:00:36.0726 (UTC) FILETIME=[3C193160:01C58419]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a regular swapfile lies on a filesystem whose blocksize is less than
PAGE_SIZE, then setup_swap_extents may have to cut the number of usable
swap pages; but sys_swapon's nr_good_pages was not expecting that.  Also,
setup_swap_extents takes no account of badpages listed in the swap header:
not worth doing so, but ensure nr_badpages is 0 for a regular swapfile.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/swapfile.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

--- swap1/mm/swapfile.c	2005-07-08 19:13:21.000000000 +0100
+++ swap2/mm/swapfile.c	2005-07-08 19:13:33.000000000 +0100
@@ -1006,8 +1006,9 @@ reprobe:
 	}
 	ret = 0;
 	if (page_no == 0)
-		ret = -EINVAL;
+		page_no = 1;	/* force Empty message */
 	sis->max = page_no;
+	sis->pages = page_no - 1;
 	sis->highest_bit = page_no - 1;
 done:
 	sis->curr_swap_extent = list_entry(sis->extent_list.prev,
@@ -1444,6 +1445,10 @@ asmlinkage long sys_swapon(const char __
 		p->highest_bit = maxpages - 1;
 
 		error = -EINVAL;
+		if (!maxpages)
+			goto bad_swap;
+		if (swap_header->info.nr_badpages && S_ISREG(inode->i_mode))
+			goto bad_swap;
 		if (swap_header->info.nr_badpages > MAX_SWAP_BADPAGES)
 			goto bad_swap;
 		
@@ -1468,25 +1473,27 @@ asmlinkage long sys_swapon(const char __
 		if (error) 
 			goto bad_swap;
 	}
-	
+
 	if (swapfilesize && maxpages > swapfilesize) {
 		printk(KERN_WARNING
 		       "Swap area shorter than signature indicates\n");
 		error = -EINVAL;
 		goto bad_swap;
 	}
+	if (nr_good_pages) {
+		p->swap_map[0] = SWAP_MAP_BAD;
+		p->max = maxpages;
+		p->pages = nr_good_pages;
+		error = setup_swap_extents(p);
+		if (error)
+			goto bad_swap;
+		nr_good_pages = p->pages;
+	}
 	if (!nr_good_pages) {
 		printk(KERN_WARNING "Empty swap-file\n");
 		error = -EINVAL;
 		goto bad_swap;
 	}
-	p->swap_map[0] = SWAP_MAP_BAD;
-	p->max = maxpages;
-	p->pages = nr_good_pages;
-
-	error = setup_swap_extents(p);
-	if (error)
-		goto bad_swap;
 
 	down(&swapon_sem);
 	swap_list_lock();
