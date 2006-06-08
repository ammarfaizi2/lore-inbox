Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWFHXDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWFHXDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWFHXDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49595 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965056AbWFHXDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:11 -0400
Date: Thu, 8 Jun 2006 16:02:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 00/14] Zoned VM counters V2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zone based VM statistics are necessary to be able to determine what the state
of memory in one zone is. In a NUMA system this can be helpful for local
reclaim and other memory optimizations that may be able to shift VM load
in order to get more balanced memory use.

It is also helpful to know how the computing load affects the memory
allocations on various zones.

The patchset introduces a framework for counters that is a cross between the
existing page_stats --which are simply global counters split per cpu-- and
the approach of deferred incremental updates implemented for nr_pagecache.

Small per cpu 8 bit counters are added to struct zone. If the counter
exceeds certain thresholds then the counters are accumulated in an array of
atomic_long in the zone and in a global array that sums up all
zone values.

Access to VM counter information for a zone and for the whole machine
is then possible by simply indexing an array (Thanks to Nick Piggin for
pointing out that approach). The access to the total number of pages of
various types does no longer require the summing up of all per cpu counters.

Benefits of this patchset right now:

- zone_reclaim_interval vanishes since VM stats can now determine
  when it is worth to scan for reclaimable pages.

- loops over all processors are avoided in writeback and
  reclaim paths.

- Get rid of the nr_pagecache atomic for the single processor case
  (Marcelo's idea).

- Accurate counters in /sys/devices/system/node/node*/meminfo. Current
  counters are based on where the pages were allocated so the counters
  were not useful to show the actual use of pages on a node.

- Detailed VM counters available in more /proc and /sys status files.

References to earlier discussions:
V1 http://marc.theaimsgroup.com/?l=linux-kernel&m=113511649910826&w=2
Earlier approaches:  http://marc.theaimsgroup.com/?l=linux-kernel&m=113460596414687&w=2

Performance test with AIM7 did not show any regressions. Seems to be a tad
faster even. Tested on ia64/ NUMA. Builds fine on i386, SMP / UP.

Changelog

V1->V2:

- Cleanup code, resequence and base patches on 2.6.17-rc6-mm1
- Reduce interrupt holdoffs
- Add zone reclaim interval removal patch
- Rename EVENT_COUNTER to VM_EVENT_COUNTERS (also all variables and functions)

The patchset consists of 14 patches. These are:

01/14 Per zone counter infrastructure

Sets up the functionality to handle per zone counters but does not
define any.

02/14 Add zoned counters to /proc/vmstat

Adds the display of zoned counters

03/14 Conversion of nr_mapped to a per zone counter

Converts nr_mapped and sets up the first per zone counters. This allows
optimizations in various places that avoid looping over counters from all
processors.

04/14 Conversion of nr_pagecache to a per zone counter

Replace the single atomic variable with a per cpu counter. For UP this means
that no atomic operations have to be used for nr_pagecache anymore. Remove
special nr_pagecache code.

05/14 Use zoned counters instead of zone_reclaim_interval

Replace the zone_reclaim_interval logic with a check for
unmapped pages.

06/14 Extend proc per node, per zone stats by adding per zone counters

Adds new counters to various places where we display counters.

07/14 Conversion of nr_slab to a per zone counter

This avoids looping over processors in the reclaim code and allows accurate
accounting of slab use per zone.

08/14 Conversion of nr_pagetable to a per zone counter

Allows accurate accounting of pagetable pages per zone.

09/14 Conversion of nr_dirty to a per zone counter

Avoids loop over processors in writeback state determination

10/14 Conversion of nr_writeback to a per zone counter

Avoids loop over processors in writeback state determination.

11/14 Conversio of nr_unstable to a per zone counter

Avoids loop over proessors in writeback state determination.

12/14 Remove get_page_state functions

There is no need anymoore for the get_page_state function. So remove it.

13/14 Convert nr_bounce to a per zone counter

nr_bounce also counts a type of page.

14/14 Remove writeback structures

There is really no need anymore to cache writeback information since
the counters are readily available. Remove the writeback information
structure.

