Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269913AbRHWSRm>; Thu, 23 Aug 2001 14:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269944AbRHWSRh>; Thu, 23 Aug 2001 14:17:37 -0400
Received: from mailc.telia.com ([194.22.190.4]:51143 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S269868AbRHWSQ6>;
	Thu, 23 Aug 2001 14:16:58 -0400
Message-Id: <200108231817.f7NIHCj11077@mailc.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
X-KMail-Redirect-From: Roger Larsson <roger.larsson@norran.net>
Subject: [PATCH NG] alloc_pages_limit & pages_min
From: Roger Larsson <roger.larsson@norran.net> (by way of Roger Larsson
	<roger.larsson@norran.net>)
Date: Thu, 23 Aug 2001 20:12:49 +0200
To: <linux-kernel@vger.kernel.org>
Cc: alan@redhat.com, torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Same patch as earlier sent to linux-mm, now tested]

Patch is agains 2.4.8-pre3, but should apply cleanly.
The only performance difference I have noticed is for copying
a huge file, then it performs a lot better (but I do not have a
baseline run for an unpatched -pre3, but I have benchmarked
both earlier and later revisions)

* The original code in __alloc_pages_limit has a little bug in
the case when:
- kreclaimd were not allowed to run for a LONG time...
Lots of kernel activity, RT tasks, or code running
around for a long time allocating memory.
- there were lots of inactive clean pages
- pages were allocated without direct_reclaim (higher order)
(networking might be one candidate)
it could result in using up ALL free pages!

This patch tries to prevent this situation in several ways:
1) Do not allow to alloc a free page when they are critically low.
   [last line of patch, the really critical part of this patch]

2) If direct reclaims are allowed do some additional work.
 reclaim & free until pages_min,
 alloc one page,
 reclaim and free until pages_low

/RogerL

--
Roger Larsson
Skellefteå
Sweden


*******************************************
Patch prepared by: roger.larsson@norran.net with comments from Riel

--- linux/mm/page_alloc.c.orig	Wed Aug 22 13:36:57 2001
+++ linux/mm/page_alloc.c	Thu Aug 23 01:15:17 2001
@@ -253,11 +253,35 @@

 		if (z->free_pages + z->inactive_clean_pages >= water_mark) {
 			struct page *page = NULL;
-			/* If possible, reclaim a page directly. */
-			if (direct_reclaim)
+
+			/*
+			 * Reclaim a page from the inactive_clean list.
+			 * If needed, refill the free list up to the
+			 * low water mark.
+			 */
+			if (direct_reclaim) {
 				page = reclaim_page(z);
-			/* If that fails, fall back to rmqueue. */
-			if (!page)
+
+				while (page && z->free_pages < z->pages_min) {
+					__free_page(page);
+					page = reclaim_page(z);
+				}
+
+				if (page) {
+					while (z->free_pages < z->pages_low) {
+						struct page *extra = reclaim_page(z);
+						if (!extra)
+							break;
+						__free_page(extra);
+					}
+				}
+
+				/* let kreclaimd handle up to pages_high */
+			}
+			/* If that fails, fall back to rmqueue, but never let
+			*  free_pages go below pages_min...
+			*/
+			if (!page && z->free_pages >= z->pages_min)
 				page = rmqueue(z, order);
 			if (page)
 				return page;
