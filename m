Return-Path: <linux-kernel-owner+w=401wt.eu-S1752056AbXARPsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbXARPsF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbXARPsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:48:05 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:35085 "EHLO
	mail.clusterfs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbXARPsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:48:03 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17839.38576.779132.455963@gargle.gargle.HOWL>
Date: Thu, 18 Jan 2007 18:48:00 +0300
To: Christoph Lameter <clameter@sgi.com>
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [RFC 7/8] Exclude unreclaimable pages from dirty ration calculation
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.mm
In-Reply-To: <20070116054819.15358.37282.sendpatchset@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116054819.15358.37282.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000176 4b050371acdbcf09b2c2e925837024e4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:
 > Consider unreclaimable pages during dirty limit calculation
 > 
 > Tracking unreclaimable pages helps us to calculate the dirty ratio
 > the right way. If a large number of unreclaimable pages are allocated
 > (through the slab or through huge pages) then write throttling will
 > no longer work since the limit cannot be reached anymore.
 > 
 > So we simply subtract the number of unreclaimable pages from the pages
 > considered for writeout threshold calculation.
 > 
 > Other code that allocates significant amounts of memory for device
 > drivers etc could also be modified to take advantage of this functionality.

I think that simpler solution of this problem is to use only potentially
reclaimable pages (that is, active, inactive, and free pages) to
calculate writeout threshold. This way there is no need to maintain
counters for unreclaimable pages. Below is a patch implementing this
idea, it got some testing.

Nikita.

Fix write throttling to calculate its thresholds from amount of memory that
can be consumed by file system and swap caches, rather than from the total
amount of physical memory. This avoids situations (among other things) when
memory consumed by kernel slab allocator prevents write throttling from ever
happening.

Signed-off-by: Nikita Danilov <danilov@gmail.com>

 mm/page-writeback.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

Index: git-linux/mm/page-writeback.c
===================================================================
--- git-linux.orig/mm/page-writeback.c
+++ git-linux/mm/page-writeback.c
@@ -101,6 +101,18 @@ EXPORT_SYMBOL(laptop_mode);
 
 static void background_writeout(unsigned long _min_pages);
 
+/* Maximal number of pages that can be consumed by pageable caches. */
+static unsigned long total_pageable_pages(void)
+{
+	unsigned long active;
+	unsigned long inactive;
+	unsigned long free;
+
+	get_zone_counts(&active, &inactive, &free);
+	/* +1 to never return 0. */
+	return active + inactive + free + 1;
+}
+
 /*
  * Work out the current dirty-memory clamping and background writeout
  * thresholds.
@@ -127,22 +139,31 @@ get_dirty_limits(long *pbackground, long
 	int unmapped_ratio;
 	long background;
 	long dirty;
-	unsigned long available_memory = vm_total_pages;
+	unsigned long total_pages;
+	unsigned long available_memory;
 	struct task_struct *tsk;
 
+	available_memory = total_pages = total_pageable_pages();
+
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * If this mapping can only allocate from low memory,
 	 * we exclude high memory from our count.
 	 */
-	if (mapping && !(mapping_gfp_mask(mapping) & __GFP_HIGHMEM))
+	if (mapping && !(mapping_gfp_mask(mapping) & __GFP_HIGHMEM)) {
+		if (available_memory > totalhigh_pages)
 		available_memory -= totalhigh_pages;
+		else
+			available_memory = 1;
+	}
 #endif
 
 
 	unmapped_ratio = 100 - ((global_page_state(NR_FILE_MAPPED) +
 				global_page_state(NR_ANON_PAGES)) * 100) /
-					vm_total_pages;
+					total_pages;
+	if (unmapped_ratio < 0)
+		unmapped_ratio = 0;
 
 	dirty_ratio = vm_dirty_ratio;
 	if (dirty_ratio > unmapped_ratio / 2)
@@ -513,7 +534,7 @@ void laptop_sync_completion(void)
 
 void writeback_set_ratelimit(void)
 {
-	ratelimit_pages = vm_total_pages / (num_online_cpus() * 32);
+	ratelimit_pages = total_pageable_pages() / (num_online_cpus() * 32);
 	if (ratelimit_pages < 16)
 		ratelimit_pages = 16;
 	if (ratelimit_pages * PAGE_CACHE_SIZE > 4096 * 1024)
@@ -542,7 +563,7 @@ void __init page_writeback_init(void)
 	long buffer_pages = nr_free_buffer_pages();
 	long correction;
 
-	correction = (100 * 4 * buffer_pages) / vm_total_pages;
+	correction = (100 * 4 * buffer_pages) / total_pageable_pages();
 
 	if (correction < 100) {
 		dirty_background_ratio *= correction;

