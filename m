Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946058AbWKALQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946058AbWKALQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946781AbWKALQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:16:22 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:64138 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1946058AbWKALQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:16:21 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 0/11] Avoiding fragmentation with subzone groupings v26
Date: Wed,  1 Nov 2006 11:16:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the latest version of anti-fragmentation based on sub-zones (previously
called list-based anti-fragmentation) based on top of 2.6.19-rc4-mm1. In
it's last release, it was decided that the scheme should be implemented with
zones to avoid affecting the page allocator hot paths. However, at VM Summit,
it was made clear that zones may not be the right answer either because zones
have their own issues. Hence, this is a reintroduction of the first approach.

Changelog Since V25
o Fix loop order of for_each_rclmtype_order so that order of loop matches args
o gfpflags_to_rclmtype uses gfp_t instead of unsigned long
o Rename get_pageblock_type() to get_page_rclmtype()
o Fix alignment problem in move_freepages()
o Add mechanism for assigning flags to blocks of pages instead of page->flags
o On fallback, do not examine the preferred list of free pages a second time

The purpose of these patches is to reduce external fragmentation by grouping
pages of related types together. The objective is that when page reclaim
occurs, there is a greater chance that large contiguous pages will be
free. Note that this is not a defragmentation which would get contiguous
pages by moving pages around.

This patch works by categorising allocations by their reclaimability;

EasyReclaimable - These are userspace pages that are easily reclaimable. This
	flag is set when it is known that the pages will be trivially reclaimed
	by writing the page out to swap or syncing with backing storage

KernelReclaimable - These are allocations for some kernel caches that are
	reclaimable or allocations that are known to be very short-lived.

KernelNonReclaimable - These are pages that are allocated by the kernel that
	are not trivially reclaimed. For example, the memory allocated for a
	loaded module would be in this category. By default, allocations are
	considered to be of this type

Instead of having one MAX_ORDER-sized array of free lists in struct free_area,
there is one for each type of reclaimability. Once a 2^MAX_ORDER block of
pages is split for a type of allocation, it is added to the free-lists for
that type, in effect reserving it. Hence, over time, pages of the different
types can be clustered together. When a page is allocated, the page-flags
are updated with a value indicating it's type of reclaimability so that it
is placed on the correct list on free.

When the preferred freelists are expired, the largest possible block is taken
from an alternative list. Buddies that are split from that large block are
placed on the preferred allocation-type freelists to mitigate fragmentation.

This implementation gives best-effort for low fragmentation in all zones. To
be effective, min_free_kbytes needs to be set to a value about 10% of physical
memory (10% was found by experimentation, it may be workload dependant). To
get that value lower, anti-fragmentation needs to be more invasive so it's
best to find out what sorts of workloads still cause fragmentation before
taking further steps.

Our tests show that about 60-70% of physical memory can be allocated on
a desktop after a few days uptime. In benchmarks and stress tests, we are
finding that 80% of memory is available as contiguous blocks at the end of
the test. To compare, a standard kernel was getting < 1% of memory as large
pages on a desktop and about 8-12% of memory as large pages at the end of
stress tests.

Performance tests are within 0.1% for kbuild on a number of test machines. aim9
is usually within 1% except on x86_64 where aim9 results are unreliable.
I have never been able to show it but it is possible the main allocator
path is adversely affected by anti-fragmentation (cache footprint might be a
problem) and it may be exposed by using differnet compilers or benchmarks. If
any regressions are detected due to anti-fragmentation, it may be simply
disabled via the kernel configuration and I'd appreciate a report detailing
the regression and how to trigger it.

Following this email are 8 patches that implement antifragmentation with an
additional 3 patches that provide an alternative to using page->flags. The
early patches introduce the split between user and kernel allocations.
Later we introduce a further split for kernel allocations, into KernRclm
and KernNoRclm.  Note that although in early patches an additional page
flag is consumed, later patches reuse the suspend bits, releasing this bit
again. The last three patches remove the restriction on suspend by introducing
an alternative solution for tracking page blocks which remove the need for
any page bits.

Comments?
-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
