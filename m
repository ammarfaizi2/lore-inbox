Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUBVFhz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 00:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUBVFhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 00:37:55 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:33255 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261155AbUBVFhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 00:37:50 -0500
Message-ID: <4038402A.4030708@cyberone.com.au>
Date: Sun, 22 Feb 2004 16:37:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au> <40383300.5010203@matchmail.com>
In-Reply-To: <40383300.5010203@matchmail.com>
Content-Type: multipart/mixed;
 boundary="------------080307020301030500040309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080307020301030500040309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Mike Fedyk wrote:

> Nick Piggin wrote:
>
>>
>>
>> Nick Piggin wrote:
>>
>>>
>>> Actually I think the previous shrink_slab formula factors
>>> out to the right thing anyway, so nevermind this patch :P
>>>
>>>
>>
>> Although, nr_used_zone_pages probably shouldn't be counting
>> highmem zones, which might be our problem.
>
>
> What is the kernel parameter to disable highmem?  I saw nohighio, but 
> that's not it...
>

Not sure. That defeats the purpose of trying to get your setup
working nicely though ;)

Can you upgrade to 2.6.3-mm2? It would be ideal if you could
test this patch against that kernel due to the other VM changes.

Chris, could you test this too please? Thanks.


--------------080307020301030500040309
Content-Type: text/plain;
 name="vm-shrink-slab-lowmem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-shrink-slab-lowmem.patch"

 linux-2.6-npiggin/include/linux/mm.h |    2 +-
 linux-2.6-npiggin/mm/page_alloc.c    |   13 +++++++++----
 linux-2.6-npiggin/mm/vmscan.c        |   22 ++++++++++++----------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff -puN mm/vmscan.c~vm-shrink-slab-lowmem mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-shrink-slab-lowmem	2004-02-22 16:35:06.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-02-22 16:35:06.000000000 +1100
@@ -145,7 +145,7 @@ static int shrink_slab(unsigned long sca
 	if (down_trylock(&shrinker_sem))
 		return 0;
 
-	pages = nr_used_zone_pages();
+	pages = nr_lowmem_lru_pages();
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 
@@ -857,7 +857,8 @@ shrink_zone(struct zone *zone, unsigned 
  */
 static int
 shrink_caches(struct zone **zones, int priority, int *total_scanned,
-		int gfp_mask, int nr_pages, struct page_state *ps)
+		int *lowmem_scanned, int gfp_mask, int nr_pages,
+		struct page_state *ps)
 {
 	int ret = 0;
 	int i;
@@ -875,7 +876,10 @@ shrink_caches(struct zone **zones, int p
 
 		ret += shrink_zone(zone, gfp_mask,
 				to_reclaim, &nr_scanned, ps, priority);
+
 		*total_scanned += nr_scanned;
+		if (i < ZONE_HIGHMEM)
+			*lowmem_scanned += nr_scanned;
 		if (ret >= nr_pages)
 			break;
 	}
@@ -915,19 +919,17 @@ int try_to_free_pages(struct zone **zone
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
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-02-22 16:35:06.000000000 +1100
@@ -772,13 +772,18 @@ unsigned int nr_free_pages(void)
 
 EXPORT_SYMBOL(nr_free_pages);
 
-unsigned int nr_used_zone_pages(void)
+unsigned int nr_lowmem_lru_pages(void)
 {
+	pg_data_t *pgdat;
 	unsigned int pages = 0;
-	struct zone *zone;
 
-	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
+	for_each_pgdat(pgdat) {
+		int i;
+		for (i = 0; i < ZONE_HIGHMEM; i++) {
+			struct zone *zone = pgdat->node_zones + i;
+			pages += zone->nr_active + zone->nr_inactive;
+		}
+	}
 
 	return pages;
 }
diff -puN include/linux/mm.h~vm-shrink-slab-lowmem include/linux/mm.h
--- linux-2.6/include/linux/mm.h~vm-shrink-slab-lowmem	2004-02-22 16:35:06.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mm.h	2004-02-22 16:35:06.000000000 +1100
@@ -625,7 +625,7 @@ static inline struct vm_area_struct * fi
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
-extern unsigned int nr_used_zone_pages(void);
+extern unsigned int nr_lowmem_lru_pages(void);
 
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,

_

--------------080307020301030500040309--
