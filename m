Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268959AbUJPXo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268959AbUJPXo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 19:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUJPXo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 19:44:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55485 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268959AbUJPXoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 19:44:15 -0400
Message-ID: <4171B23F.6060305@pobox.com>
Date: Sat, 16 Oct 2004 19:43:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com> <20041016154818.271a394b.akpm@osdl.org>
In-Reply-To: <20041016154818.271a394b.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060807010208020209070201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060807010208020209070201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>The only really notable changes in -bk3 -> -bk4 are the signal changes, 
>>something in mm/vmscan.c.
>>
> 
> 
> I'd be suspecting the vmscan.c change, but we allegedly fixed that later on.
> Can you try reverting it?  (Can't reproduce the problem here)


Verified -- reverting the vmscan.c changeset (attached) fixed my hang.

This hang is definitely present from -rc3-bk4 through -final, so a fix 
is not presented in mainline.

	Jeff



--------------060807010208020209070201
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# ChangeSet
#   2004/10/03 09:16:48-07:00 nickpiggin@yahoo.com.au 
#   [PATCH] vm: prevent kswapd pageout priority windup
#   
#   Now that we are correctly kicking off kswapd early (before the synch
#   reclaim watermark), it is really doing asynchronous pageout.  This has
#   exposed a latent problem where allocators running at the same time will
#   make kswapd think it is getting into trouble, and cause too much swapping
#   and suboptimal behaviour.
#   
#   This patch changes the kswapd scanning algorithm to use the same metrics
#   for measuring pageout success as the synchronous reclaim path - namely, how
#   much work is required to free SWAP_CLUSTER_MAX pages.
#   
#   This should make things less fragile all round, and has the added benefit
#   that kswapd will continue running so long as memory is low and it is
#   managing to free pages, rather than going through the full priority loop,
#   then giving up.  Should result in much better behaviour all round,
#   especially when there are concurrent allocators.
#   
#   akpm: the patch was confirmed to fix up the excessive swapout which Ray Bryant
#   <raybry@sgi.com> has been reporting.
#   
#   Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	2004-10-16 19:42:30 -04:00
+++ b/mm/vmscan.c	2004-10-16 19:42:30 -04:00
@@ -968,12 +968,16 @@
 static int balance_pgdat(pg_data_t *pgdat, int nr_pages)
 {
 	int to_free = nr_pages;
+	int all_zones_ok;
 	int priority;
 	int i;
-	int total_scanned = 0, total_reclaimed = 0;
+	int total_scanned, total_reclaimed;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 
+loop_again:
+	total_scanned = 0;
+	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
@@ -987,10 +991,11 @@
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		int all_zones_ok = 1;
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
 
+		all_zones_ok = 1;
+
 		if (nr_pages == 0) {
 			/*
 			 * Scan in the highmem->dma direction for the highest
@@ -1072,6 +1077,15 @@
 		 */
 		if (total_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
+
+		/*
+		 * We do this so kswapd doesn't build up large priorities for
+		 * example when it is freeing in parallel with allocators. It
+		 * matches the direct reclaim path behaviour in terms of impact
+		 * on zone->*_priority.
+		 */
+		if (total_reclaimed >= SWAP_CLUSTER_MAX)
+			break;
 	}
 out:
 	for (i = 0; i < pgdat->nr_zones; i++) {
@@ -1079,6 +1093,9 @@
 
 		zone->prev_priority = zone->temp_priority;
 	}
+	if (!all_zones_ok)
+		goto loop_again;
+
 	return total_reclaimed;
 }
 

--------------060807010208020209070201--
