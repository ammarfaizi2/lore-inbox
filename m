Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSGQFW4>; Wed, 17 Jul 2002 01:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSGQFUr>; Wed, 17 Jul 2002 01:20:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16652 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318219AbSGQFTN>;
	Wed, 17 Jul 2002 01:19:13 -0400
Message-ID: <3D3500D8.B7FD8F73@zip.com.au>
Date: Tue, 16 Jul 2002 22:30:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 8/13] alloc_pages cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cleanup patch from Martin Bligh: convert some loops which want to be
`for' loops into that, and add some commentary.




 page_alloc.c |   44 ++++++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 24 deletions(-)

--- 2.5.26/mm/page_alloc.c~cleanup-alloc_pages	Tue Jul 16 21:46:36 2002
+++ 2.5.26-akpm/mm/page_alloc.c	Tue Jul 16 21:46:36 2002
@@ -323,22 +323,23 @@ balance_classzone(zone_t * classzone, un
 struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
 {
 	unsigned long min;
-	zone_t **zone, * classzone;
+	zone_t **zones, *classzone;
 	struct page * page;
-	int freed;
+	int freed, i;
 
 	KERNEL_STAT_ADD(pgalloc, 1<<order);
 
-	zone = zonelist->zones;
-	classzone = *zone;
-	if (classzone == NULL)
+	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
+	classzone = zones[0]; 
+	if (classzone == NULL)    /* no zones in the zonelist */
 		return NULL;
+
+	/* Go through the zonelist once, looking for a zone with enough free */
 	min = 1UL << order;
-	for (;;) {
-		zone_t *z = *(zone++);
-		if (!z)
-			break;
+	for (i = 0; zones[i] != NULL; i++) {
+		zone_t *z = zones[i];
 
+		/* the incremental min is allegedly to discourage fallback */
 		min += z->pages_low;
 		if (z->free_pages > min) {
 			page = rmqueue(z, order);
@@ -349,16 +350,15 @@ struct page * __alloc_pages(unsigned int
 
 	classzone->need_balance = 1;
 	mb();
+	/* we're somewhat low on memory, failed to find what we needed */
 	if (waitqueue_active(&kswapd_wait))
 		wake_up_interruptible(&kswapd_wait);
 
-	zone = zonelist->zones;
+	/* Go through the zonelist again, taking __GFP_HIGH into account */
 	min = 1UL << order;
-	for (;;) {
+	for (i = 0; zones[i] != NULL; i++) {
 		unsigned long local_min;
-		zone_t *z = *(zone++);
-		if (!z)
-			break;
+		zone_t *z = zones[i];
 
 		local_min = z->pages_min;
 		if (gfp_mask & __GFP_HIGH)
@@ -375,11 +375,9 @@ struct page * __alloc_pages(unsigned int
 
 rebalance:
 	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
-		zone = zonelist->zones;
-		for (;;) {
-			zone_t *z = *(zone++);
-			if (!z)
-				break;
+		/* go through the zonelist yet again, ignoring mins */
+		for (i = 0; zones[i] != NULL; i++) {
+			zone_t *z = zones[i];
 
 			page = rmqueue(z, order);
 			if (page)
@@ -403,12 +401,10 @@ nopage:
 	if (page)
 		return page;
 
-	zone = zonelist->zones;
+	/* go through the zonelist yet one more time */
 	min = 1UL << order;
-	for (;;) {
-		zone_t *z = *(zone++);
-		if (!z)
-			break;
+	for (i = 0; zones[i] != NULL; i++) {
+		zone_t *z = zones[i];
 
 		min += z->pages_min;
 		if (z->free_pages > min) {

.
