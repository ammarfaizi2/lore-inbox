Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUBZCgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUBZCgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:36:07 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:38136 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262606AbUBZCfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:35:13 -0500
Message-ID: <403D5B4C.3020309@matchmail.com>
Date: Wed, 25 Feb 2004 18:34:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com> <403D5174.6050302@cyberone.com.au>
In-Reply-To: <403D5174.6050302@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------050105070108030203000003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050105070108030203000003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> 
> 
> Mike Fedyk wrote:
> 
>> Nick Piggin wrote:
>>
>>>
>>>
>>> That is a much better sounding ratio. Of course that doesn't mean much
>>> if performance is worse. Slab might be getting reclaimed a little bit
>>> too hard vs pagecache now.
>>>
>>
>> I'll let you know.  My graphs are looking better, except for one 
>> instance of Xvnc (for one user -- I'm still tracking that one down) 
>> hitting a memory grabbing loop that made me kill it.
>>
> 
> Try to get /proc/meminfo and a sysrq + T trace if something like
> this happens.

I'll do that next time.

When did /proc/sysrq-trigger get in the kernel?  forgot about that at 
the time :(

> 
>>>> See:
>>>> http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html 
>>>>
>>>>
>>>> Is there any way I can get the VM patches against 2.6.3?  I'm not 
>>>> comfortable with running -mm3 on this production server, especially 
>>>> seeing the "sync hang" bug.
>>>>
>>>
>>> Well your server wasn't going too badly with 2.6.3, wasn't it? Might
>>> as well just wait for them to get into the the tree.
>>
>>
>>
>> I might as well take out the third 512MB DIMM in that machine then...
>>
>> Any chance you could post a VM patch roll-up against 2.6.3 for little 
>> ole me?
>>
> 
> It is a bit easier said than done as you might have seen :P And
> I'm laz^W^W I happen to not agree with one of Andrew's patches,
> so it would go against all my principles ;)
> 
> IMO, shrink_slab-for-all-zones.patch and zone-balancing-fix.patch
> should be all you need although they won't shrink the slab as
> much as mm3. They should be pretty easy to port by hand.

OK, I'll give that a try.

Is the attached patch the latest version of your alternative patch 
instead of shrink_slab-for-all-zones.patch?

--------------050105070108030203000003
Content-Type: text/x-patch;
 name="vm-shrink-slab-lowmem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-shrink-slab-lowmem.patch"

 linux-2.6-npiggin/include/linux/mm.h |    2 -
 linux-2.6-npiggin/mm/page_alloc.c    |   11 ------
 linux-2.6-npiggin/mm/vmscan.c        |   64 ++++++++++++++++++++++++++++-------
 3 files changed, 52 insertions(+), 25 deletions(-)

diff -puN mm/vmscan.c~vm-shrink-slab-lowmem mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-shrink-slab-lowmem	2004-02-22 16:35:06.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-02-22 17:30:53.000000000 +1100
@@ -122,7 +122,25 @@ void remove_shrinker(struct shrinker *sh
 }
 
 EXPORT_SYMBOL(remove_shrinker);
- 
+
+/*
+ * Returns the number of lowmem pages which are on the lru lists
+ */
+static unsigned int nr_lowmem_lru_pages(void)
+{
+	unsigned int pages = 0;
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		if (unlikely(is_highmem(zone)))
+			continue;
+		pages += zone->nr_active + zone->nr_inactive;
+	}
+
+	return pages;
+}
+
+
 #define SHRINK_BATCH 128
 /*
  * Call the shrink functions to age shrinkable caches
@@ -136,6 +154,24 @@ EXPORT_SYMBOL(remove_shrinker);
  * slab to avoid swapping.
  *
  * We do weird things to avoid (scanned*seeks*entries) overflowing 32 bits.
+ *
+ * The formula to work out how much to scan each slab is as follows:
+ * Let S be the number of lowmem LRU pages were scanned (scanned)
+ * Let M be the total number of lowmem LRU pages (pages)
+ * T be the total number of all slab items.
+ * For each slab:
+ * I be number of slab items ((*shrinker->shrinker)(0, gfp_mask))
+ *
+ * "S * M / T" then gives the total number of slab items to scan, N
+ * Then for each slab, "N * T / I" is the number of items to scan for this slab.
+ *
+ * This simplifies to  "S * M / I", or
+ * lowmem lru scanned * items in this slab / total lowmem lru pages
+ *
+ * TODO:
+ * The value of M should be calculated *before* LRU scanning.
+ * Total number of items in each slab should be used, not just freeable ones.
+ * Unfreeable slab items should not count toward the scanning total.
  */
 static int shrink_slab(unsigned long scanned, unsigned int gfp_mask)
 {
@@ -145,14 +181,16 @@ static int shrink_slab(unsigned long sca
 	if (down_trylock(&shrinker_sem))
 		return 0;
 
-	pages = nr_used_zone_pages();
+	pages = nr_lowmem_lru_pages();
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 
 		delta = 4 * scanned / shrinker->seeks;
 		delta *= (*shrinker->shrinker)(0, gfp_mask);
 		do_div(delta, pages + 1);
-		shrinker->nr += delta;
+
+		/* +1 to ensure some scanning gets done */
+		shrinker->nr += delta + 1;
 		if (shrinker->nr > SHRINK_BATCH) {
 			long nr_to_scan = shrinker->nr;
 
@@ -857,7 +895,8 @@ shrink_zone(struct zone *zone, unsigned 
  */
 static int
 shrink_caches(struct zone **zones, int priority, int *total_scanned,
-		int gfp_mask, int nr_pages, struct page_state *ps)
+		int *lowmem_scanned, int gfp_mask, int nr_pages,
+		struct page_state *ps)
 {
 	int ret = 0;
 	int i;
@@ -875,7 +914,10 @@ shrink_caches(struct zone **zones, int p
 
 		ret += shrink_zone(zone, gfp_mask,
 				to_reclaim, &nr_scanned, ps, priority);
+
 		*total_scanned += nr_scanned;
+		if (i < ZONE_HIGHMEM)
+			*lowmem_scanned += nr_scanned;
 		if (ret >= nr_pages)
 			break;
 	}
@@ -915,19 +957,17 @@ int try_to_free_pages(struct zone **zone
 		zones[i]->temp_priority = DEF_PRIORITY;
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		int total_scanned = 0;
+		int total_scanned = 0, lowmem_scanned = 0;
 		struct page_state ps;
 
 		get_page_state(&ps);
 		nr_reclaimed += shrink_caches(zones, priority, &total_scanned,
-						gfp_mask, nr_pages, &ps);
+				&lowmem_scanned, gfp_mask, nr_pages, &ps);
 
-		if (zones[0] - zones[0]->zone_pgdat->node_zones < ZONE_HIGHMEM) {
-			shrink_slab(total_scanned, gfp_mask);
-			if (reclaim_state) {
-				nr_reclaimed += reclaim_state->reclaimed_slab;
-				reclaim_state->reclaimed_slab = 0;
-			}
+		shrink_slab(lowmem_scanned, gfp_mask);
+		if (reclaim_state) {
+			nr_reclaimed += reclaim_state->reclaimed_slab;
+			reclaim_state->reclaimed_slab = 0;
 		}
 
 		if (nr_reclaimed >= nr_pages) {
diff -puN mm/page_alloc.c~vm-shrink-slab-lowmem mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~vm-shrink-slab-lowmem	2004-02-22 16:35:06.000000000 +1100
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-02-22 17:04:43.000000000 +1100
@@ -772,17 +772,6 @@ unsigned int nr_free_pages(void)
 
 EXPORT_SYMBOL(nr_free_pages);
 
-unsigned int nr_used_zone_pages(void)
-{
-	unsigned int pages = 0;
-	struct zone *zone;
-
-	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
-
-	return pages;
-}
-
 #ifdef CONFIG_NUMA
 unsigned int nr_free_pages_pgdat(pg_data_t *pgdat)
 {
diff -puN include/linux/mm.h~vm-shrink-slab-lowmem include/linux/mm.h
--- linux-2.6/include/linux/mm.h~vm-shrink-slab-lowmem	2004-02-22 16:35:06.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mm.h	2004-02-22 17:04:26.000000000 +1100
@@ -625,8 +625,6 @@ static inline struct vm_area_struct * fi
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
-extern unsigned int nr_used_zone_pages(void);
-
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
 		int write);

_

--------------050105070108030203000003--
