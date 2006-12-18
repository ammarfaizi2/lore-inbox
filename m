Return-Path: <linux-kernel-owner+w=401wt.eu-S1754750AbWLRXR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbWLRXR0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbWLRXR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:17:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56928 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbWLRXRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:17:25 -0500
Date: Mon, 18 Dec 2006 15:17:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-pm@lists.osdl.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org
Subject: Re: [linux-pm] OOPS: divide error while s2dsk (2.6.20-rc1-mm1)
Message-Id: <20061218151710.32ceba0d.akpm@osdl.org>
In-Reply-To: <200612182338.24843.rjw@sisk.pl>
References: <4586797B.3080007@gmail.com>
	<200612181646.23292.rjw@sisk.pl>
	<4586C99C.9020606@gmail.com>
	<200612182338.24843.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 23:38:23 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > Looks like we have a problem with slab shrinking here.
> > > 
> > > Could you please use gdb to check what exactly is at shrink_slab+0x9e?
> > 
> > Sure, but not till Friday, sorry (I am away).
> 
> I reproduced this on one box, but then it turned out that EIP was at line 195
> of mm/vmscan.c where there was
> 
> do_div(delta, lru_pages + 1);

That implies that we passed it lru_pages=-1.

Presumably the logic in
vmscanc-account-for-memory-already-freed-in-seeking-to.patch caused that.

> Well, I have no idea how this can lead to a divide error (lru_pages is
> unsigned).
> 
> I'm unable to reproduce this on another i386 box, so it seems to be somewhat
> configuration specific.
> 

There is one wart in shrink_all_memory() and I think we should fix that in
2.6.20.

Please check the below.  I'll drop
vmscanc-account-for-memory-already-freed-in-seeking-to.patch.  It has other
stuff in it which we might still need.  But altering sc->swap_cluster_max
in that manner looks odd.



From: Andrew Morton <akpm@osdl.org>

At the end of shrink_all_memory() we forget to recalculate lru_pages: it can
be zero.

Fix that up, and add a helper function for this operation too.

Also, recalculate lru_pages each time around the inner loop to get the
balancing correct.

Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/vmscan.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff -puN mm/vmscan.c~shrink_all_memory-fix-lru_pages-handling mm/vmscan.c
--- a/mm/vmscan.c~shrink_all_memory-fix-lru_pages-handling
+++ a/mm/vmscan.c
@@ -1484,6 +1484,16 @@ static unsigned long shrink_all_zones(un
 	return ret;
 }
 
+static unsigned long count_lru_pages(void)
+{
+	struct zone *zone;
+	unsigned long ret = 0;
+
+	for_each_zone(zone);
+		ret += zone->nr_active + zone->nr_inactive;
+	return ret;
+}
+
 /*
  * Try to free `nr_pages' of memory, system-wide, and return the number of
  * freed pages.
@@ -1498,7 +1508,6 @@ unsigned long shrink_all_memory(unsigned
 	unsigned long ret = 0;
 	int pass;
 	struct reclaim_state reclaim_state;
-	struct zone *zone;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_swap = 0,
@@ -1509,10 +1518,7 @@ unsigned long shrink_all_memory(unsigned
 
 	current->reclaim_state = &reclaim_state;
 
-	lru_pages = 0;
-	for_each_zone(zone)
-		lru_pages += zone->nr_active + zone->nr_inactive;
-
+	lru_pages = count_lru_pages();
 	nr_slab = global_page_state(NR_SLAB_RECLAIMABLE);
 	/* If slab caches are huge, it's better to hit them first */
 	while (nr_slab >= lru_pages) {
@@ -1539,13 +1545,6 @@ unsigned long shrink_all_memory(unsigned
 	for (pass = 0; pass < 5; pass++) {
 		int prio;
 
-		/* Needed for shrinking slab caches later on */
-		if (!lru_pages)
-			for_each_zone(zone) {
-				lru_pages += zone->nr_active;
-				lru_pages += zone->nr_inactive;
-			}
-
 		/* Force reclaiming mapped pages in the passes #3 and #4 */
 		if (pass > 2) {
 			sc.may_swap = 1;
@@ -1561,7 +1560,8 @@ unsigned long shrink_all_memory(unsigned
 				goto out;
 
 			reclaim_state.reclaimed_slab = 0;
-			shrink_slab(sc.nr_scanned, sc.gfp_mask, lru_pages);
+			shrink_slab(sc.nr_scanned, sc.gfp_mask,
+					count_lru_pages());
 			ret += reclaim_state.reclaimed_slab;
 			if (ret >= nr_pages)
 				goto out;
@@ -1569,20 +1569,19 @@ unsigned long shrink_all_memory(unsigned
 			if (sc.nr_scanned && prio < DEF_PRIORITY - 2)
 				congestion_wait(WRITE, HZ / 10);
 		}
-
-		lru_pages = 0;
 	}
 
 	/*
 	 * If ret = 0, we could not shrink LRUs, but there may be something
 	 * in slab caches
 	 */
-	if (!ret)
+	if (!ret) {
 		do {
 			reclaim_state.reclaimed_slab = 0;
-			shrink_slab(nr_pages, sc.gfp_mask, lru_pages);
+			shrink_slab(nr_pages, sc.gfp_mask, count_lru_pages());
 			ret += reclaim_state.reclaimed_slab;
 		} while (ret < nr_pages && reclaim_state.reclaimed_slab > 0);
+	}
 
 out:
 	current->reclaim_state = NULL;
_

