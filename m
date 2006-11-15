Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966559AbWKOHz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966559AbWKOHz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966262AbWKOHuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:50:32 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:6605 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966059AbWKOHu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:27 -0500
Message-ID: <363577020.39493@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:07 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/28] Adaptive readahead V16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This readahead update focuses on complexity/overhead problems.
It introduces major changes to initial/context/nfsd readahead,
along with many other cleanups.

Patches
=======

One-to-one patching to the existing patches would be impossible,
so I updated the -mm patchset in place. Please replace the -mm patches
from
	readahead-kconfig-options.patch
to
	readahead-remove-the-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch
with this patchset, thanks.

[PATCH 01/28] readahead: kconfig options
[PATCH 02/28] radixtree: introduce scan hole/data functions
[PATCH 03/28] mm: introduce probe_page()
[PATCH 04/28] mm: introduce PG_readahead
[PATCH 05/28] readahead: add look-ahead support to __do_page_cache_readahead()
[PATCH 06/28] readahead: insert cond_resched() calls
[PATCH 07/28] readahead: {MIN,MAX}_RA_PAGES
[PATCH 08/28] readahead: events accounting
[PATCH 09/28] readahead: rescue_pages()
[PATCH 10/28] readahead: sysctl parameters
[PATCH 11/28] readahead: min/max sizes
[PATCH 12/28] readahead: state based method - aging accounting
[PATCH 13/28] readahead: state based method - routines
[PATCH 14/28] readahead: state based method
[PATCH 15/28] readahead: context based method
[PATCH 16/28] readahead: initial method - guiding sizes
[PATCH 17/28] readahead: initial method - thrashing guard size
[PATCH 18/28] readahead: initial method - user recommended size
[PATCH 19/28] readahead: initial method
[PATCH 20/28] readahead: backward prefetching method
[PATCH 21/28] readahead: thrashing recovery method
[PATCH 22/28] readahead: call scheme
[PATCH 23/28] readahead: laptop mode
[PATCH 24/28] readahead: loop case
[PATCH 25/28] readahead: nfsd case
[PATCH 26/28] readahead: turn on by default
[PATCH 27/28] readahead: remove size limit on read_ahead_kb
[PATCH 28/28] readahead: remove size limit of max_sectors_kb on read_ahead_kb

Diffstat
========

 Documentation/sysctl/vm.txt |   46 +
 block/ll_rw_blk.c           |   43 -
 drivers/block/loop.c        |    6
 fs/mpage.c                  |    4
 fs/nfs/client.c             |    3
 fs/nfsd/vfs.c               |    6
 include/linux/backing-dev.h |    2
 include/linux/fs.h          |   60 +
 include/linux/mm.h          |   31
 include/linux/mmzone.h      |    3
 include/linux/page-flags.h  |    6
 include/linux/pagemap.h     |    2
 include/linux/radix-tree.h  |    6
 include/linux/sysctl.h      |    2
 include/linux/writeback.h   |    6
 kernel/sysctl.c             |   27
 lib/radix-tree.c            |   93 ++
 mm/Kconfig                  |   57 +
 mm/filemap.c                |   65 +-
 mm/page-writeback.c         |    2
 mm/page_alloc.c             |   33 +
 mm/readahead.c              | 1404 +++++++++++++++++++++++++++++++++++++++++++-
 mm/vmscan.c                 |    1
 23 files changed, 1862 insertions(+), 46 deletions(-)

Changelog
=========

V16  2006-11-15

OVERHEADS ELIMINATION
- nfsd readahead: now works in peace with the chaotic nfsd requests
- context readahead on random reads: disabled by default
- replace TestClearPageReadahead() with ClearPageReadahead()

CODE REDUCTION
- take 2 function parameters from page_cache_readahead_adaptive()
- drop delayed page_cache_release() patch on filemap.c
- drop smooth aging accounting
- drop cache hit feedback
- drop fixed size random read prefetching
- drop initial readahead size auto detection

READABILITY IMPROVEMENT
- context readahead: document and clearly define cases/subroutines
- rename ra_dispatch() to ra_submit()
- rename zone.aging_total to zone.total_scanned
- move readahead.c/node_readahead_aging() to page_alloc.c/nr_scanned_pages_node()
- some minor cleanups

SEMANTIC CHANGES
- vm.readahead_ratio == 1 (single value) selects stock readahead
- vm.readahead_hit_rate == 0 prevents possible context readahead overheads
- /sys/block/sda/queue/initial_ra_kb = 64 as recommended initial readahead size
- limit ra_min to ra_max/8 (8 = 128k/16k)
- ignore readahead_ratio in aggressive context readahead
- be conservative on backward prefetching

V15  2006-05-28
- apply stream_shift size limits to contexta method
- *remain in query_page_cache_segment() is over counted by 1, fix it
- comment update for adjust_rala_aggressive()
- add use case comment for backward prefetching

V14  2006-05-27
- remove __radix_tree_lookup_parent()
- implement radix_tree_scan_hole*() as dumb and safe
- break file_ra_state.cache_hits into u16s
- rationalize ra_dispatch and move look-ahead/age stuffs here
- move node_free_and_cold_pages() to page_alloc.c/nr_free_inactive_pages_node()
- fix a bug in query_page_cache_segment()
- adjust RA_FLAG_XXX to avoid confliction with ra_class_{new,old}
- random comments

V13  2006-05-26
- remove radix tree look-aside cache
- fix radix tree NULL dereference bug
- fix radix tree bugs on direct embedded data
- add comment on cold_page_refcnt()
- rename find_page() to probe_page()
- replace the non-atomic __SetPageReadahead()
- fix the risky rescue_pages()
- some cleanups recommended by Nick Piggin

V12  2006-05-24
- improve small files case
- allow pausing of events accounting
- disable sparse read-ahead by default
- a bug fix in radix_tree_cache_lookup_parent()
- more cleanups

V11  2006-03-19
- patchset rework
- add kconfig option to make the feature compile-time selectable
- improve radix tree scan functions
- fix bug of using smp_processor_id() in preemptible code
- avoid overflow in compute_thrashing_threshold()
- disable sparse read prefetching if (readahead_hit_rate == 1)
- make thrashing recovery a standalone function
- random cleanups

V10  2005-12-16
- remove delayed page activation
- remove live page protection
- revert mmap readaround to old behavior
- default to original readahead logic
- default to original readahead size
- merge comment fixes from Andreas Mohr
- merge radixtree cleanups from Christoph Lameter
- reduce sizeof(struct file_ra_state) by unnamed union
- stateful method cleanups
- account other read-ahead paths

V9  2005-12-3
- standalone mmap read-around code, a little more smart and tunable
- make stateful method sensible of request size
- decouple readahead_ratio from live pages protection
- let readahead_ratio contribute to ra_size grow speed in stateful method
- account variance of ra_size

V8  2005-11-25

- balance zone aging only in page relaim paths and do it right
- do the aging of slabs in the same way as zones
- add debug code to dump the detailed page reclaim steps
- undo exposing of struct radix_tree_node and uninline related functions
- work better with nfsd
- generalize accelerated context based read-ahead
- account smooth read-ahead aging based on page referenced/activate bits
- avoid divide error in compute_thrashing_threshold()
- more low lantency efforts
- update some comments
- rebase debug actions on debugfs entries instead of magic readahead_ratio values

V7  2005-11-09

- new tunable parameters: readahead_hit_rate/readahead_live_chunk
- support sparse sequential accesses
- delay look-ahead if drive is spinned down in laptop mode
- disable look-ahead for loopback file
- make mandatory thrashing protection more simple and robust
- attempt to improve responsiveness on large read-ahead size

V6  2005-11-01

- cancel look-ahead in laptop mode
- increase read-ahead limit to 0xFFFF pages

V5  2005-10-28

- rewrite context based method to make it clean and robust
- improved accuracy of stateful thrashing threshold estimation
- make page aging equal to the number of code pages scanned
- sort out the thrashing protection logic
- enhanced debug/accounting facilities

V4  2005-10-15

- detect and save live chunks on page reclaim
- support database workload
- support reading backward
- radix tree lookup look-aside cache

V3  2005-10-06

- major code reorganization and documention
- stateful estimation of thrashing-threshold
- context method with accelerated grow up phase
- adaptive look-ahead
- early detection and rescue of pages in danger
- statitics data collection
- synchronized page aging between zones

V2  2005-09-15

- delayed page activation
- look-ahead: towards pipelined read-ahead

V1  2005-09-13

Initial release which features:
        o stateless (for now)
        o adapts to available memory / read speed
        o free of thrashing (in theory)

And handles:
        o large number of slow streams (FTP server)
	o open/read/close access patterns (NFS server)
        o multiple interleaved, sequential streams in one file
	  (multithread / multimedia / database)

Cheers,
Fengguang Wu
--
Dept. Automation                University of Science and Technology of China
