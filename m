Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUBVGfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUBVGfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:35:40 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:38870 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261178AbUBVGfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:35:13 -0500
Message-ID: <40384D9D.6040604@cyberone.com.au>
Date: Sun, 22 Feb 2004 17:35:09 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mfedyk@matchmail.com, cw@f00f.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com>	<20040222023638.GA13840@dingdong.cryptoapps.com>	<Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>	<20040222031113.GB13840@dingdong.cryptoapps.com>	<Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>	<20040222033111.GA14197@dingdong.cryptoapps.com>	<4038299E.9030907@cyberone.com.au>	<40382BAA.1000802@cyberone.com.au>	<4038307B.2090405@cyberone.com.au>	<40383300.5010203@matchmail.com>	<4038402A.4030708@cyberone.com.au>	<40384325.1010802@matchmail.com>	<403845CB.8040805@cyberone.com.au> <20040221221721.42e734d6.akpm@osdl.org>
In-Reply-To: <20040221221721.42e734d6.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020007000305060202010404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020007000305060202010404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>  
>
>>Fair enough. Maybe if we can get enough testing, some of the mm
>> changes can get into 2.6.4? I'm sure Linus is turning pale, maybe
>> we'd better wait until 2.6.10 ;)
>>    
>>
>
>I need to alight from my lazy tail and test them a bit^Wlot first.  More
>like 2.6.5.
>
>  
>

Can you maybe use this patch then, please?

Thanks


--------------020007000305060202010404
Content-Type: text/plain;
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

--------------020007000305060202010404--
