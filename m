Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSFBVwF>; Sun, 2 Jun 2002 17:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSFBVwE>; Sun, 2 Jun 2002 17:52:04 -0400
Received: from holomorphy.com ([66.224.33.161]:23970 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314553AbSFBVwD>;
	Sun, 2 Jun 2002 17:52:03 -0400
Date: Sun, 2 Jun 2002 14:51:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: repetitive reinitialization of active_list and inactive_list in free_area_init_core()
Message-ID: <20020602215141.GI14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inactive_list and active_list are global, yet they are repeatedly
initialized using INIT_LIST_HEAD() in free_area_init_core(). This
patch is originally due to Christoph Hellwig, and by some reports
has been implementated before in 2.4-based trees by Andrea Arcangeli.

Against 2.5.19.


===== mm/page_alloc.c 1.63 vs edited =====
--- 1.63/mm/page_alloc.c	Tue May 28 16:57:49 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 14:46:14 2002
@@ -27,8 +27,8 @@
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 int nr_swap_pages;
-struct list_head inactive_list;
-struct list_head active_list;
+LIST_HEAD(active_list);
+LIST_HEAD(inactive_list);
 pg_data_t *pgdat_list;
 
 /* Used to look up the address of the struct zone encoded in page->zone */
@@ -826,9 +826,6 @@
 			realtotalpages -= zholes_size[i];
 			
 	printk("On node %d totalpages: %lu\n", nid, realtotalpages);
-
-	INIT_LIST_HEAD(&active_list);
-	INIT_LIST_HEAD(&inactive_list);
 
 	/*
 	 * Some architectures (with lots of mem and discontinous memory
