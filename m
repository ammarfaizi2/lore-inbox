Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVLLCqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVLLCqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 21:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVLLCqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 21:46:49 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:13750 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751051AbVLLCqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 21:46:48 -0500
Date: Mon, 12 Dec 2005 10:53:39 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 03/16] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051212025339.GA4145@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>,
	Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
	Andrea Arcangeli <andrea@suse.de>
References: <20051207104755.177435000@localhost.localdomain> <20051207104932.630888000@localhost.localdomain> <20051211223646.GB6978@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211223646.GB6978@dmt.cnet>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 08:36:46PM -0200, Marcelo Tosatti wrote:
> Hi Wu,

Hi Marcelo,

> It is not very clear to me what is the meaning of these numbers and what
> you're trying to deduce from them. Please correct me if I'm wrong.
> 
> z->aging_total is the sum of all scanned inactive pages for the zone
> (sum of scanned pages by shrink_cache).
> 
> z->aging_milestone is the number of pages scanned with "nr_inactive"
> precision (it is updated in response to a full inactive list scan).
> 
> z->page_age is the difference between aging_milestone and aging_total.
> 
> The name sounds a bit misleading since "page age" intuitively means
> "what is the age of a page".
> 
> Anyway, z->page_age is the number of scanned pages since the last full  
> scan, shifted left by PAGE_AGE_SHIFT and divided by the number of       
> inactive pages.                                                         
> 
> IOW, it still means "number of scanned pages since last full scan".
 
Thanks for the review and comments. Your interpretations are pretty accurate.

> How can that be meaningful? No other code uses this in the patchset
> AFAICS.

1) It is updated _solely_ by update_age() and used _only_ through age_ge/age_gt
   macros.
2) Yes, there are some duplications. The normalized one can be removed, at cost
   of possibly more runtime computations.

Let me answer more of your recommends by the following new patch :)

The new patch also fixed a bug where the fluctuations of nr_inactive can lead to
big jumps of zone age. Now the balancing logics can work as expected.

Regards,
Wu
---

Subject: mm: supporting variables and functions for balanced zone aging

The imbalance of zone aging rates can severely damage read-ahead requests,
shorten their effective life time, increase unexpected I/O lantency and waste
memory.

This patch introduces struct aging with members
	- life_span
	- raw_age
	- std_age
to keep track of page aging rate. It is updated _solely_ by update_age() and
used _only_ through age_ge/age_gt macros.

The aging.std_age is a normalized value of (aging.raw_age/aging.life_span)
that can be compared between zones/slabs with the helper macro age_ge/age_gt.
The goal of balancing logics are to keep this normalized value in sync.

One can check the balanced aging progress by running:
                        tar c / | cat > /dev/null &
                        watch -n1 'grep "age " /proc/zoneinfo'

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
 include/linux/mmzone.h |   14 ++++++++++++++
 mm/page_alloc.c        |   11 +++++++++++
 mm/vmscan.c            |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

--- linux.orig/include/linux/mmzone.h
+++ linux/include/linux/mmzone.h
@@ -106,6 +106,12 @@ struct per_cpu_pageset {
  * ZONE_HIGHMEM	 > 896 MB	only page cache and user processes
  */
 
+struct aging {
+	unsigned long	life_span;
+	unsigned long	raw_age;
+	unsigned long	std_age;
+};
+
 struct zone {
 	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
@@ -149,6 +155,8 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	struct aging		aging;
+
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?
--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -123,6 +123,53 @@ static long total_memory;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#ifdef CONFIG_HIGHMEM64G
+#define		AGING_SHIFT  8
+#elif BITS_PER_LONG == 32
+#define		AGING_SHIFT  12
+#elif BITS_PER_LONG == 64
+#define		AGING_SHIFT  20
+#else
+#error unknown BITS_PER_LONG
+#endif
+#define		AGING_SIZE   (1 << AGING_SHIFT)
+#define		AGING_MASK   (AGING_SIZE - 1)
+
+/*
+ * The simplified code is:
+ * 	age_ge: (@a->aging.std_age >= @b->aging.std_age)
+ * 	age_gt: (@a->aging.std_age > @b->aging.std_age)
+ * The complexity deals with the wrap-around problem.
+ * Two page ages not close enough(gap >= 1/8) should also be ignored:
+ * they are out of sync and the comparison may be nonsense.
+ *
+ * Return value depends on the position of @a relative to @b:
+ * -1/8       b      +1/8
+ *   |--------|--------|-----------------------------------------------|
+ *       0        1                           0
+ */
+#define age_ge(a, b) \
+	(((a->aging.std_age - b->aging.std_age) & AGING_MASK) < AGING_SIZE / 8)
+#define age_gt(a, b) \
+	(((b->aging.std_age - a->aging.std_age) & AGING_MASK) > AGING_SIZE * 7 / 8)
+
+/*
+ * Keep track of the percent of cold pages that have been scanned / aged.
+ * It's not really ##%, but a high resolution normalized value.
+ */
+static inline void update_age(struct aging *a, unsigned long age,
+						unsigned long current_life_span)
+{
+	a->raw_age += age;
+
+	if (a->raw_age > a->life_span ) {
+		a->raw_age -= a->life_span;
+		a->life_span = (current_life_span | 1);
+	}
+
+	a->std_age = (a->raw_age << AGING_SHIFT) / a->life_span;
+}
+
 /*
  * Add a shrinker callback to be called from the vm
  */
@@ -887,6 +934,7 @@ static void shrink_cache(struct zone *zo
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
+		update_age(&zone->aging, nr_scan, zone->nr_inactive);
 		spin_unlock_irq(&zone->lru_lock);
 
 		if (nr_taken == 0)
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -1522,6 +1522,7 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",
@@ -1533,6 +1534,7 @@ void show_free_areas(void)
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
+			zone->aging.std_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
@@ -2144,6 +2146,7 @@ static void __init free_area_init_core(s
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		memset(&zone->aging, 0, sizeof(struct aging));
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2292,6 +2295,7 @@ static int zoneinfo_show(struct seq_file
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        age      %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2301,6 +2305,7 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->aging.std_age,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
