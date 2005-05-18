Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVERVZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVERVZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVERVY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:24:29 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:6382 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262394AbVERVX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:23:56 -0400
Message-ID: <428BB267.30809@us.ibm.com>
Date: Wed, 18 May 2005 14:23:51 -0700
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "lkml, " <linux-kernel@vger.kernel.org>
Subject: [PATCH] vm: try_to_free_pages unused argument
Content-Type: multipart/mixed;
 boundary="------------080907020209060709070105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080907020209060709070105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

try_to_free_pages accepts a third argument, order, but hasn't used it 
since before 2.6.0.  The following patch removes the argument and 
updates all the calls to try_to_free_pages.

Tested on a 4 way x86 box running kernbench.  No problems detected.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>

--------------080907020209060709070105
Content-Type: text/plain;
 name="try_to_free_pages-order"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="try_to_free_pages-order"

diff -purN -X /home/dvhart/.diff.exclude /home/linux/views/linux-2.6.12-rc4/fs/buffer.c 2.6.12-rc4-order/fs/buffer.c
--- /home/linux/views/linux-2.6.12-rc4/fs/buffer.c	2005-05-06 23:22:28.000000000 -0700
+++ 2.6.12-rc4-order/fs/buffer.c	2005-05-18 11:52:05.000000000 -0700
@@ -528,7 +528,7 @@ static void free_more_memory(void)
 	for_each_pgdat(pgdat) {
 		zones = pgdat->node_zonelists[GFP_NOFS&GFP_ZONEMASK].zones;
 		if (*zones)
-			try_to_free_pages(zones, GFP_NOFS, 0);
+			try_to_free_pages(zones, GFP_NOFS);
 	}
 }
 
diff -purN -X /home/dvhart/.diff.exclude /home/linux/views/linux-2.6.12-rc4/include/linux/swap.h 2.6.12-rc4-order/include/linux/swap.h
--- /home/linux/views/linux-2.6.12-rc4/include/linux/swap.h	2005-05-06 23:22:33.000000000 -0700
+++ 2.6.12-rc4-order/include/linux/swap.h	2005-05-18 11:52:05.000000000 -0700
@@ -172,7 +172,7 @@ extern int rotate_reclaimable_page(struc
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
+extern int try_to_free_pages(struct zone **, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
diff -purN -X /home/dvhart/.diff.exclude /home/linux/views/linux-2.6.12-rc4/mm/page_alloc.c 2.6.12-rc4-order/mm/page_alloc.c
--- /home/linux/views/linux-2.6.12-rc4/mm/page_alloc.c	2005-05-06 23:22:34.000000000 -0700
+++ 2.6.12-rc4-order/mm/page_alloc.c	2005-05-18 11:52:05.000000000 -0700
@@ -829,7 +829,7 @@ rebalance:
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	did_some_progress = try_to_free_pages(zones, gfp_mask, order);
+	did_some_progress = try_to_free_pages(zones, gfp_mask);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
diff -purN -X /home/dvhart/.diff.exclude /home/linux/views/linux-2.6.12-rc4/mm/vmscan.c 2.6.12-rc4-order/mm/vmscan.c
--- /home/linux/views/linux-2.6.12-rc4/mm/vmscan.c	2005-05-06 23:22:34.000000000 -0700
+++ 2.6.12-rc4-order/mm/vmscan.c	2005-05-18 11:52:05.000000000 -0700
@@ -907,8 +907,7 @@ shrink_caches(struct zone **zones, struc
  * holds filesystem locks which prevent writeout this might not work, and the
  * allocation attempt will fail.
  */
-int try_to_free_pages(struct zone **zones,
-		unsigned int gfp_mask, unsigned int order)
+int try_to_free_pages(struct zone **zones, unsigned int gfp_mask)
 {
 	int priority;
 	int ret = 0;

--------------080907020209060709070105--
