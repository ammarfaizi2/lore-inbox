Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWFLVNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWFLVNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWFLVNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:13:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:24233 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751443AbWFLVND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:13:03 -0400
Date: Mon, 12 Jun 2006 14:12:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 00/21] Zoned VM counters V3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: This is *not* the lightweight event counter patchset where we
toyed around with local_t and racy updates for event counters.

Zone based VM statistics are necessary to be able to determine what the state
of memory in one zone is. In a NUMA system this can be helpful for local
reclaim and other memory optimizations that may be able to shift VM load
in order to get more balanced memory use.

It is also useful to know how the computing load affects the memory
allocations on various zones. This patchset allows the retrieval of that
data from userspace.

The patchset introduces a framework for counters that is a cross between the
existing page_stats --which are simply global counters split per cpu-- and
the approach of deferred incremental updates implemented for nr_pagecache.

Small per cpu 8 bit counters are added to struct zone. If the counter
exceeds certain thresholds then the counters are accumulated in an array of
atomic_long in the zone and in a global array that sums up all
zone values. The small 8 bit counters are next to the per cpu page pointers
and so they will be in high in the cpu cache when pages are allocated and
freed.

Access to VM counter information for a zone and for the whole machine
is then possible by simply indexing an array (Thanks to Nick Piggin for
pointing out that approach). The access to the total number of pages of
various types does no longer require the summing up of all per cpu counters.

Benefits of this patchset right now:

- Ability for UP and SMP configuration to determine how memory
  is balanced between the DMA, NORMAL and HIGHMEM zones.

- loops over all processors are avoided in writeback and
  reclaim paths. We can avoid caching the writeback information
  because the needed information is directly accessible.

- Special handling for nr_pagecache removed.

- zone_reclaim_interval vanishes since VM stats can now determine
  when it is worth to do local reclaim.

- Fast inline per node page state determination.

- Accurate counters in /sys/devices/system/node/node*/meminfo. Current
  counters are counting simply which processor allocated a page somewhere
  and guestimate based on that. So the counters were not useful to show
  the actual distribution of page use on a specific zone.

- The swap_prefetch patch requires per node statistics in order to
  figure out when processors of a node can prefetch. This patch provides
  some of the needed numbers.

- Detailed VM counters available in more /proc and /sys status files.

References to earlier discussions:
V1 http://marc.theaimsgroup.com/?l=linux-kernel&m=113511649910826&w=2
V2 http://marc.theaimsgroup.com/?l=linux-kernel&m=114980851924230&w=2
Earlier approaches:
   http://marc.theaimsgroup.com/?l=linux-kernel&m=113460596414687&w=2

Performance tests with AIM7 did not show any regressions. Seems to be a tad
faster even. Tested on ia64/NUMA. Builds fine on i386, SMP / UP. Includes
fixes for s390/arm/uml arch code.

Changelog

V1->V2:

- Cleanup code, resequence and base patches on 2.6.17-rc6-mm1
- Reduce interrupt holdoffs
- Add zone reclaim interval removal patch

V2->V3:
- Against temp tree by Andrew. (2.6.17-rc6-mm2 - old patches)
  Temp patch at http://www.zip.com.au/~akpm/linux/patches/stuff/cl.bz2
- Incorporate additional fixes for arch code.
- Create vmstat.c/h from pieces of page_alloc.c.
- Do the swap prefetch support patches the right way.
- Reorganize patchset so that the tree compiles after each
  patch (However, swap prefetch/reiser4 patches are separate.
  So if a swap prefetch patch follows then two patches must
  be applied for the kernel to compile again).
- Do various prescribed tests. Make sure that there is no remaining
  reference to page state in some arch code.
- Optimize the node_page_state function so that it can be used inline.

The patchset consists of 21 patches that are following this one.

