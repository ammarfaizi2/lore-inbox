Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWIWKNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWIWKNX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 06:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWIWKM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 06:12:56 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:18368 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751470AbWIWKMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 06:12:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Date: Sat, 23 Sep 2006 12:10:54 +0200
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609231158.00147.rjw@sisk.pl>
In-Reply-To: <200609231158.00147.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609231210.54692.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use a swap file with swsusp we need to know the offset at which
its swap header is located.  However, the swap header is always located in the
first page block of the swap file and it's quite easy to make sys_swapon() print
the offset of the swap file's (or swap partition's) first page block.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
---
 mm/swapfile.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc7-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.18-rc7-mm1.orig/mm/swapfile.c
+++ linux-2.6.18-rc7-mm1/mm/swapfile.c
@@ -1047,7 +1047,8 @@ add_swap_extent(struct swap_info_struct 
  * This is extremely effective.  The average number of iterations in
  * map_swap_page() has been measured at about 0.3 per page.  - akpm.
  */
-static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
+static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span,
+                              sector_t *start)
 {
 	struct inode *inode;
 	unsigned blocks_per_page;
@@ -1060,6 +1061,7 @@ static int setup_swap_extents(struct swa
 	int nr_extents = 0;
 	int ret;
 
+	*start = 0;
 	inode = sis->swap_file->f_mapping->host;
 	if (S_ISBLK(inode->i_mode)) {
 		ret = add_swap_extent(sis, 0, sis->max, 0);
@@ -1114,6 +1116,8 @@ static int setup_swap_extents(struct swa
 				lowest_block = first_block;
 			if (first_block > highest_block)
 				highest_block = first_block;
+		} else {
+			*start = first_block;
 		}
 
 		/*
@@ -1407,7 +1411,7 @@ asmlinkage long sys_swapon(const char __
 	int swap_header_version;
 	unsigned int nr_good_pages = 0;
 	int nr_extents = 0;
-	sector_t span;
+	sector_t span, start;
 	unsigned long maxpages = 1;
 	int swapfilesize;
 	unsigned short *swap_map;
@@ -1608,7 +1612,7 @@ asmlinkage long sys_swapon(const char __
 		p->swap_map[0] = SWAP_MAP_BAD;
 		p->max = maxpages;
 		p->pages = nr_good_pages;
-		nr_extents = setup_swap_extents(p, &span);
+		nr_extents = setup_swap_extents(p, &span, &start);
 		if (nr_extents < 0) {
 			error = nr_extents;
 			goto bad_swap;
@@ -1628,9 +1632,10 @@ asmlinkage long sys_swapon(const char __
 	total_swap_pages += nr_good_pages;
 
 	printk(KERN_INFO "Adding %uk swap on %s.  "
-			"Priority:%d extents:%d across:%lluk\n",
+			"Priority:%d extents:%d across:%lluk offset:%llu\n",
 		nr_good_pages<<(PAGE_SHIFT-10), name, p->prio,
-		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10));
+		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
+		(unsigned long long)start);
 
 	/* insert swap space into swap_list: */
 	prev = -1;

