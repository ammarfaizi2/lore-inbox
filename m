Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUGaRYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUGaRYA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUGaRYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:24:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:31150 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266137AbUGaRXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:23:31 -0400
Date: Sat, 31 Jul 2004 10:23:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, kladit@t-online.de,
       linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
In-Reply-To: <20040730124744.0eb11f63.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407311003210.16847@ppc970.osdl.org>
References: <20040726150615.GA1119@xeon2.local.here> <20040729140743.170acb3e.akpm@osdl.org>
 <20040730163007.GA2931@logos.cnet> <20040730124744.0eb11f63.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Jul 2004, Andrew Morton wrote:
> 
> Seems that we reach a state where lowmem pagecache get reclaimed faster
> than dcache/icache.  This causes the number of pages scanned for lowmem
> allocations to fall.  This causes less scanning of the slab and the whole
> thing repeats.  I expect changing nr_used_zone_pages() to ignore highmem
> will fix it, and might be the long-term fix, too.

Ouch. Indeed, looking at the usage of nr_used_zone_pages(), it looks 
totally broken. However, I don't think the right thing to do is to ignore 
the HIGHMEM zone altogether, I think it should take the list of zones 
being shrunk into account.

Look at usage: one caller of shrink_slab() is try_to_free_pages(), and if 
try_to_free_pages() is called for a HIGHMEM zone, then it is _fine_ to 
count the HIGHMEM zone as pages, and shrink the slab memory much less 
aggressively. The _problem_ is when slab competes against itself (lowmem) 
or some other thing (inodes) that want lowmem-only memory, and then the 
slab shrinking really should ignore the fact that there are tons of 
highmem pages left.

Something like this (totally untested, may not compile, you get the idea) 
might work. Or not. Since the _rest_ of "shrink_slab()" doesn't know about 
zonelists, just making the "how many pages does this zone have free" take 
the zonelist into account might cause other problems.

		Linus
-----
===== include/linux/mm.h 1.179 vs edited =====
--- 1.179/include/linux/mm.h	2004-06-27 00:19:35 -07:00
+++ edited/include/linux/mm.h	2004-07-31 10:19:25 -07:00
@@ -706,7 +706,7 @@
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
-extern unsigned int nr_used_zone_pages(void);
+extern unsigned int nr_used_zone_pages(struct zone **);
 
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
===== mm/page_alloc.c 1.221 vs edited =====
--- 1.221/mm/page_alloc.c	2004-07-19 08:44:36 -07:00
+++ edited/mm/page_alloc.c	2004-07-31 10:18:37 -07:00
@@ -825,13 +825,15 @@
 
 EXPORT_SYMBOL(nr_free_pages);
 
-unsigned int nr_used_zone_pages(void)
+unsigned int nr_used_zone_pages(struct zone **zones)
 {
 	unsigned int pages = 0;
-	struct zone *zone;
 
-	for_each_zone(zone)
+	while (*zones) {
+		struct zone * zone = *zones;
+		zones++;
 		pages += zone->nr_active + zone->nr_inactive;
+	}
 
 	return pages;
 }
===== mm/vmscan.c 1.224 vs edited =====
--- 1.224/mm/vmscan.c	2004-06-24 01:56:14 -07:00
+++ edited/mm/vmscan.c	2004-07-31 10:20:17 -07:00
@@ -170,7 +170,7 @@
  *
  * We do weird things to avoid (scanned*seeks*entries) overflowing 32 bits.
  */
-static int shrink_slab(unsigned long scanned, unsigned int gfp_mask)
+static int shrink_slab(unsigned long scanned, unsigned int gfp_mask, struct zone **zones)
 {
 	struct shrinker *shrinker;
 	long pages;
@@ -178,7 +178,7 @@
 	if (down_trylock(&shrinker_sem))
 		return 0;
 
-	pages = nr_used_zone_pages();
+	pages = nr_used_zone_pages(zones);
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 
@@ -912,7 +912,7 @@
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
 		shrink_caches(zones, &sc);
-		shrink_slab(sc.nr_scanned, gfp_mask);
+		shrink_slab(sc.nr_scanned, gfp_mask, zones);
 		if (reclaim_state) {
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
@@ -1032,6 +1032,7 @@
 		 */
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
+			struct zone * zones[2] = { zone, NULL };
 
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
@@ -1048,7 +1049,7 @@
 			sc.priority = priority;
 			shrink_zone(zone, &sc);
 			reclaim_state->reclaimed_slab = 0;
-			shrink_slab(sc.nr_scanned, GFP_KERNEL);
+			shrink_slab(sc.nr_scanned, GFP_KERNEL, zones);
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			total_reclaimed += sc.nr_reclaimed;
 			if (zone->all_unreclaimable)
