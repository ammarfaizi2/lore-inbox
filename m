Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbWJKVdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWJKVdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161386AbWJKV3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:29:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:40606 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161394AbWJKVFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:05:16 -0400
Date: Wed, 11 Oct 2006 14:04:53 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Christoph Lameter <clameter@sgi.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/67] zone_reclaim: dynamic slab reclaim
Message-ID: <20061011210453.GS16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="zone_reclaim-dynamic-slab-reclaim.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Christoph Lameter <clameter@sgi.com>

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=0ff38490c836dc379ff7ec45b10a15a662f4e5f6


Currently one can enable slab reclaim by setting an explicit option in
/proc/sys/vm/zone_reclaim_mode.  Slab reclaim is then used as a final
option if the freeing of unmapped file backed pages is not enough to free
enough pages to allow a local allocation.

However, that means that the slab can grow excessively and that most memory
of a node may be used by slabs.  We have had a case where a machine with
46GB of memory was using 40-42GB for slab.  Zone reclaim was effective in
dealing with pagecache pages.  However, slab reclaim was only done during
global reclaim (which is a bit rare on NUMA systems).

This patch implements slab reclaim during zone reclaim.  Zone reclaim
occurs if there is a danger of an off node allocation.  At that point we

1. Shrink the per node page cache if the number of pagecache
   pages is more than min_unmapped_ratio percent of pages in a zone.

2. Shrink the slab cache if the number of the nodes reclaimable slab pages
   (patch depends on earlier one that implements that counter)
   are more than min_slab_ratio (a new /proc/sys/vm tunable).

The shrinking of the slab cache is a bit problematic since it is not node
specific.  So we simply calculate what point in the slab we want to reach
(current per node slab use minus the number of pages that neeed to be
allocated) and then repeately run the global reclaim until that is
unsuccessful or we have reached the limit.  I hope we will have zone based
slab reclaim at some point which will make that easier.

The default for the min_slab_ratio is 5%

Also remove the slab option from /proc/sys/vm/zone_reclaim_mode.

[akpm@osdl.org: cleanups]
Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/sysctl/vm.txt |   27 +++++++++++++++-----
 include/linux/mmzone.h      |    3 ++
 include/linux/swap.h        |    1 
 include/linux/sysctl.h      |    1 
 kernel/sysctl.c             |   11 ++++++++
 mm/page_alloc.c             |   17 ++++++++++++
 mm/vmscan.c                 |   58 ++++++++++++++++++++++++++++----------------
 7 files changed, 90 insertions(+), 28 deletions(-)

--- linux-2.6.18.orig/Documentation/sysctl/vm.txt
+++ linux-2.6.18/Documentation/sysctl/vm.txt
@@ -29,6 +29,7 @@ Currently, these files are in /proc/sys/
 - drop-caches
 - zone_reclaim_mode
 - min_unmapped_ratio
+- min_slab_ratio
 - panic_on_oom
 
 ==============================================================
@@ -138,7 +139,6 @@ This is value ORed together of
 1	= Zone reclaim on
 2	= Zone reclaim writes dirty pages out
 4	= Zone reclaim swaps pages
-8	= Also do a global slab reclaim pass
 
 zone_reclaim_mode is set during bootup to 1 if it is determined that pages
 from remote zones will cause a measurable performance reduction. The
@@ -162,18 +162,13 @@ Allowing regular swap effectively restri
 node unless explicitly overridden by memory policies or cpuset
 configurations.
 
-It may be advisable to allow slab reclaim if the system makes heavy
-use of files and builds up large slab caches. However, the slab
-shrink operation is global, may take a long time and free slabs
-in all nodes of the system.
-
 =============================================================
 
 min_unmapped_ratio:
 
 This is available only on NUMA kernels.
 
-A percentage of the file backed pages in each zone.  Zone reclaim will only
+A percentage of the total pages in each zone.  Zone reclaim will only
 occur if more than this percentage of pages are file backed and unmapped.
 This is to insure that a minimal amount of local pages is still available for
 file I/O even if the node is overallocated.
@@ -182,6 +177,24 @@ The default is 1 percent.
 
 =============================================================
 
+min_slab_ratio:
+
+This is available only on NUMA kernels.
+
+A percentage of the total pages in each zone.  On Zone reclaim
+(fallback from the local zone occurs) slabs will be reclaimed if more
+than this percentage of pages in a zone are reclaimable slab pages.
+This insures that the slab growth stays under control even in NUMA
+systems that rarely perform global reclaim.
+
+The default is 5 percent.
+
+Note that slab reclaim is triggered in a per zone / node fashion.
+The process of reclaiming slab memory is currently not node specific
+and may not be fast.
+
+=============================================================
+
 panic_on_oom
 
 This enables or disables panic on out-of-memory feature.  If this is set to 1,
--- linux-2.6.18.orig/include/linux/mmzone.h
+++ linux-2.6.18/include/linux/mmzone.h
@@ -155,6 +155,7 @@ struct zone {
 	 * zone reclaim becomes active if more unmapped pages exist.
 	 */
 	unsigned long		min_unmapped_ratio;
+	unsigned long		min_slab_pages;
 	struct per_cpu_pageset	*pageset[NR_CPUS];
 #else
 	struct per_cpu_pageset	pageset[NR_CPUS];
@@ -421,6 +422,8 @@ int percpu_pagelist_fraction_sysctl_hand
 					void __user *, size_t *, loff_t *);
 int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
 			struct file *, void __user *, size_t *, loff_t *);
+int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
+			struct file *, void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
--- linux-2.6.18.orig/include/linux/swap.h
+++ linux-2.6.18/include/linux/swap.h
@@ -190,6 +190,7 @@ extern long vm_total_pages;
 #ifdef CONFIG_NUMA
 extern int zone_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
+extern int sysctl_min_slab_ratio;
 extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
 #else
 #define zone_reclaim_mode 0
--- linux-2.6.18.orig/include/linux/sysctl.h
+++ linux-2.6.18/include/linux/sysctl.h
@@ -191,6 +191,7 @@ enum
 	VM_MIN_UNMAPPED=32,	/* Set min percent of unmapped pages */
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
+	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
 };
 
 
--- linux-2.6.18.orig/kernel/sysctl.c
+++ linux-2.6.18/kernel/sysctl.c
@@ -943,6 +943,17 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one_hundred,
 	},
+	{
+		.ctl_name	= VM_MIN_SLAB,
+		.procname	= "min_slab_ratio",
+		.data		= &sysctl_min_slab_ratio,
+		.maxlen		= sizeof(sysctl_min_slab_ratio),
+		.mode		= 0644,
+		.proc_handler	= &sysctl_min_slab_ratio_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
 #endif
 #ifdef CONFIG_X86_32
 	{
--- linux-2.6.18.orig/mm/page_alloc.c
+++ linux-2.6.18/mm/page_alloc.c
@@ -2008,6 +2008,7 @@ static void __meminit free_area_init_cor
 #ifdef CONFIG_NUMA
 		zone->min_unmapped_ratio = (realsize*sysctl_min_unmapped_ratio)
 						/ 100;
+		zone->min_slab_pages = (realsize * sysctl_min_slab_ratio) / 100;
 #endif
 		zone->name = zone_names[j];
 		spin_lock_init(&zone->lock);
@@ -2318,6 +2319,22 @@ int sysctl_min_unmapped_ratio_sysctl_han
 				sysctl_min_unmapped_ratio) / 100;
 	return 0;
 }
+
+int sysctl_min_slab_ratio_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	struct zone *zone;
+	int rc;
+
+	rc = proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	if (rc)
+		return rc;
+
+	for_each_zone(zone)
+		zone->min_slab_pages = (zone->present_pages *
+				sysctl_min_slab_ratio) / 100;
+	return 0;
+}
 #endif
 
 /*
--- linux-2.6.18.orig/mm/vmscan.c
+++ linux-2.6.18/mm/vmscan.c
@@ -1510,7 +1510,6 @@ int zone_reclaim_mode __read_mostly;
 #define RECLAIM_ZONE (1<<0)	/* Run shrink_cache on the zone */
 #define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_SWAP (1<<2)	/* Swap pages out during reclaim */
-#define RECLAIM_SLAB (1<<3)	/* Do a global slab shrink if the zone is out of memory */
 
 /*
  * Priority for ZONE_RECLAIM. This determines the fraction of pages
@@ -1526,6 +1525,12 @@ int zone_reclaim_mode __read_mostly;
 int sysctl_min_unmapped_ratio = 1;
 
 /*
+ * If the number of slab pages in a zone grows beyond this percentage then
+ * slab reclaim needs to occur.
+ */
+int sysctl_min_slab_ratio = 5;
+
+/*
  * Try to free up some pages from this zone through reclaim.
  */
 static int __zone_reclaim(struct zone *zone, gfp_t gfp_mask, unsigned int order)
@@ -1556,29 +1561,37 @@ static int __zone_reclaim(struct zone *z
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	/*
-	 * Free memory by calling shrink zone with increasing priorities
-	 * until we have enough memory freed.
-	 */
-	priority = ZONE_RECLAIM_PRIORITY;
-	do {
-		nr_reclaimed += shrink_zone(priority, zone, &sc);
-		priority--;
-	} while (priority >= 0 && nr_reclaimed < nr_pages);
+	if (zone_page_state(zone, NR_FILE_PAGES) -
+		zone_page_state(zone, NR_FILE_MAPPED) >
+		zone->min_unmapped_ratio) {
+		/*
+		 * Free memory by calling shrink zone with increasing
+		 * priorities until we have enough memory freed.
+		 */
+		priority = ZONE_RECLAIM_PRIORITY;
+		do {
+			nr_reclaimed += shrink_zone(priority, zone, &sc);
+			priority--;
+		} while (priority >= 0 && nr_reclaimed < nr_pages);
+	}
 
-	if (nr_reclaimed < nr_pages && (zone_reclaim_mode & RECLAIM_SLAB)) {
+	if (zone_page_state(zone, NR_SLAB) > zone->min_slab_pages) {
 		/*
 		 * shrink_slab() does not currently allow us to determine how
-		 * many pages were freed in this zone. So we just shake the slab
-		 * a bit and then go off node for this particular allocation
-		 * despite possibly having freed enough memory to allocate in
-		 * this zone.  If we freed local memory then the next
-		 * allocations will be local again.
+		 * many pages were freed in this zone. So we take the current
+		 * number of slab pages and shake the slab until it is reduced
+		 * by the same nr_pages that we used for reclaiming unmapped
+		 * pages.
 		 *
-		 * shrink_slab will free memory on all zones and may take
-		 * a long time.
+		 * Note that shrink_slab will free memory on all zones and may
+		 * take a long time.
 		 */
-		shrink_slab(sc.nr_scanned, gfp_mask, order);
+		unsigned long limit = zone_page_state(zone,
+				NR_SLAB) - nr_pages;
+
+		while (shrink_slab(sc.nr_scanned, gfp_mask, order) &&
+			zone_page_state(zone, NR_SLAB) > limit)
+			;
 	}
 
 	p->reclaim_state = NULL;
@@ -1592,7 +1605,8 @@ int zone_reclaim(struct zone *zone, gfp_
 	int node_id;
 
 	/*
-	 * Zone reclaim reclaims unmapped file backed pages.
+	 * Zone reclaim reclaims unmapped file backed pages and
+	 * slab pages if we are over the defined limits.
 	 *
 	 * A small portion of unmapped file backed pages is needed for
 	 * file I/O otherwise pages read by file I/O will be immediately
@@ -1601,7 +1615,9 @@ int zone_reclaim(struct zone *zone, gfp_
 	 * unmapped file backed pages.
 	 */
 	if (zone_page_state(zone, NR_FILE_PAGES) -
-	    zone_page_state(zone, NR_FILE_MAPPED) <= zone->min_unmapped_ratio)
+	    zone_page_state(zone, NR_FILE_MAPPED) <= zone->min_unmapped_ratio
+	    && zone_page_state(zone, NR_SLAB)
+			<= zone->min_slab_pages)
 		return 0;
 
 	/*

--
