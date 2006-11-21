Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031257AbWKUWu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031257AbWKUWu1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031258AbWKUWu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:50:26 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:57510 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1031255AbWKUWuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:50:25 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 0/11] Avoiding fragmentation with page clustering v27
Date: Tue, 21 Nov 2006 22:50:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is another post of the patches aimed at reducing external
fragmentation. Based on feedback from Christoph Lameter, it has been
reworked in two important respects. One, allocations should be grouped by
ability to migrate, not just reclaim. This lays the foundation for using
page migration as a defragmentation solution later.  Second, the per-cpu
structures were larger in earlier versions which is a problem on machines
with large CPUs. They remain the same in this version.

Tests show that the kernel is far better at servicing high-order allocations
with these patches applied. kernbench figures show performance differences
of between -0.1% and +0.5% on three test machines (two ppc64 and one x86_64).

Changelog Since V27

o Renamed anti-fragmentation to Page Clustering. Anti-fragmentation was giving
  the mistaken impression that it was the 100% solution for high order
  allocations. Instead, it greatly increases the chances high-order
  allocations will succeed and lays the foundation for defragmentation and
  memory hot-remove to work properly
o Redefine page groupings based on ability to migrate or reclaim instead of
  basing on reclaimability alone
o Get rid of spurious inits
o Per-cpu lists are no longer split up per-type. Instead the per-cpu list is
  searched for a page of the appropriate type
o Added more explanation commentary
o Fix up bug in pageblock code where bitmap was used before being initalised

Changelog Since V26
o Fix double init of lists in setup_pageset

Changelog Since V25
o Fix loop order of for_each_rclmtype_order so that order of loop matches args
o gfpflags_to_rclmtype uses gfp_t instead of unsigned long
o Rename get_pageblock_type() to get_page_rclmtype()
o Fix alignment problem in move_freepages()
o Add mechanism for assigning flags to blocks of pages instead of page->flags
o On fallback, do not examine the preferred list of free pages a second time

The purpose of these patches is to reduce external fragmentation by grouping
pages of related types together. When pages are migrated (or reclaimed under
memory pressure), large contiguous pages will be freed. 

This patch works by categorising allocations by their ability to migrate;

Movable - The pages may be moved with the page migration mechanism. These are
	generally userspace pages. 

Reclaimable - These are allocations for some kernel caches that are
	reclaimable or allocations that are known to be very short-lived.

Unmovable - These are pages that are allocated by the kernel that
	are not trivially reclaimed. For example, the memory allocated for a
	loaded module would be in this category. By default, allocations are
	considered to be of this type

Instead of having one MAX_ORDER-sized array of free lists in struct free_area,
there is one for each type of reclaimability. Once a 2^MAX_ORDER block of
pages is split for a type of allocation, it is added to the free-lists for
that type, in effect reserving it. Hence, over time, pages of the different
types can be clustered together.

When the preferred freelists are expired, the largest possible block is taken
from an alternative list. Buddies that are split from that large block are
placed on the preferred allocation-type freelists to mitigate fragmentation.

This implementation gives best-effort for low fragmentation in all zones. To
be effective, min_free_kbytes needs to be set to a value about 10% of physical
memory (10% was found by experimentation, it may be workload dependant). To
get that value lower, more invasive is required.

Our tests show that about 60-70% of physical memory can be allocated on
a desktop after a few days uptime. In benchmarks and stress tests, we are
finding that 80% of memory is available as contiguous blocks at the end of
the test. To compare, a standard kernel was getting < 1% of memory as large
pages on a desktop and about 8-12% of memory as large pages at the end of
stress tests.

Following this email are 8 patches that implement page clustering with an
additional 3 patches that provide an alternative to using page->flags. The
early patches introduce the split between movable and all other allocations.
Later we introduce a further split for reclaimable allocations.  Note that
although in early patches an additional page flag is consumed, later patches
reuse the suspend bits, releasing this bit again. The last three patches
remove the restriction on suspend by introducing an alternative solution
for tracking page blocks which remove the need for any page bits.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
