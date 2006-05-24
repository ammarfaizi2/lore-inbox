Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWEXLTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWEXLTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWEXLTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:03 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:30080 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932585AbWEXLTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:01 -0400
Message-ID: <348469535.17438@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:46 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 00/33] Adaptive read-ahead V12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This is the 12th release of the adaptive readahead patchset.

It has received tests in a wide range of applications in the past
six months, and polished up considerably.

Please consider it for inclusion in -mm tree.


Performance benefits
====================

Besides file servers and desktops, it is recently found to benefit
postgresql databases a lot.

I explained to pgsql users how the patch may help their db performance:
http://archives.postgresql.org/pgsql-performance/2006-04/msg00491.php
[QUOTE]
	HOW IT WORKS

	In adaptive readahead, the context based method may be of particular
	interest to postgresql users. It works by peeking into the file cache
	and check if there are any history pages present or accessed. In this
	way it can detect almost all forms of sequential / semi-sequential read
	patterns, e.g.
		- parallel / interleaved sequential scans on one file
		- sequential reads across file open/close
		- mixed sequential / random accesses
		- sparse / skimming sequential read

	It also have methods to detect some less common cases:
		- reading backward
		- seeking all over reading N pages

	WAYS TO BENEFIT FROM IT

	As we know, postgresql relies on the kernel to do proper readahead.
	The adaptive readahead might help performance in the following cases:
		- concurrent sequential scans
		- sequential scan on a fragmented table
		  (some DBs suffer from this problem, not sure for pgsql)
		- index scan with clustered matches
		- index scan on majority rows (in case the planner goes wrong)

And received positive responses:
[QUOTE from Michael Stone]
	I've got one DB where the VACUUM ANALYZE generally takes 11M-12M ms;
	with the patch the job took 1.7M ms. Another VACUUM that normally takes
	between 300k-500k ms took 150k. Definately a promising addition.

[QUOTE from Michael Stone]
	>I'm thinking about it, we're already using a fixed read-ahead of 16MB
	>using blockdev on the stock Redhat 2.6.9 kernel, it would be nice to
	>not have to set this so we may try it.

	FWIW, I never saw much performance difference from doing that. Wu's
	patch, OTOH, gave a big boost.

[QUOTE: odbc-bench with Postgresql 7.4.11 on dual Opteron]
	Base kernel:
	 Transactions per second:                92.384758
	 Transactions per second:                99.800896

	After read-ahvm.readahead_ratio = 100:
	 Transactions per second:                105.461952
	 Transactions per second:                105.458664

	vm.readahead_ratio = 100 ; vm.readahead_hit_rate = 1:
	 Transactions per second:                113.055367
	 Transactions per second:                124.815910


Patches
=======
All 33 patches are bisect friendly:
special cares have been taken to make them compile cleanly on each step.

The following 29 patches are only logically seperated -
one should not remove one of them and expect others to compile cleanly:

[patch 01/33] readahead: kconfig options
[patch 02/33] radixtree: look-aside cache
[patch 03/33] radixtree: hole scanning functions
[patch 04/33] readahead: page flag PG_readahead
[patch 05/33] readahead: refactor do_generic_mapping_read()
[patch 06/33] readahead: refactor __do_page_cache_readahead()
[patch 07/33] readahead: insert cond_resched() calls
[patch 08/33] readahead: common macros
[patch 09/33] readahead: events accounting
[patch 10/33] readahead: support functions
[patch 11/33] readahead: sysctl parameters
[patch 12/33] readahead: min/max sizes
[patch 13/33] readahead: state based method - aging accounting
[patch 14/33] readahead: state based method - data structure
[patch 15/33] readahead: state based method - routines
[patch 16/33] readahead: state based method
[patch 17/33] readahead: context based method
[patch 18/33] readahead: initial method - guiding sizes
[patch 19/33] readahead: initial method - thrashing guard size
[patch 20/33] readahead: initial method - expected read size
[patch 21/33] readahead: initial method - user recommended size
[patch 22/33] readahead: initial method
[patch 23/33] readahead: backward prefetching method
[patch 24/33] readahead: seeking reads method
[patch 25/33] readahead: thrashing recovery method
[patch 26/33] readahead: call scheme
[patch 27/33] readahead: laptop mode
[patch 28/33] readahead: loop case
[patch 29/33] readahead: nfsd case

The following 4 patches are for debugging purpose, and for -mm only:

[patch 30/33] readahead: turn on by default
[patch 31/33] readahead: debug radix tree new functions
[patch 32/33] readahead: debug traces showing accessed file names
[patch 33/33] readahead: debug traces showing read patterns


Diffstat
========
 Documentation/sysctl/vm.txt |   37 
 block/ll_rw_blk.c           |   34 
 drivers/block/loop.c        |    6 
 fs/file_table.c             |    7 
 fs/mpage.c                  |    4 
 fs/nfsd/vfs.c               |    5 
 include/linux/backing-dev.h |    3 
 include/linux/fs.h          |   57 +
 include/linux/mm.h          |   31 
 include/linux/mmzone.h      |    5 
 include/linux/page-flags.h  |    5 
 include/linux/radix-tree.h  |   87 ++
 include/linux/sysctl.h      |    2 
 include/linux/writeback.h   |    6 
 kernel/sysctl.c             |   28 
 lib/radix-tree.c            |  202 ++++-
 mm/Kconfig                  |   62 +
 mm/filemap.c                |   90 ++
 mm/page-writeback.c         |    2 
 mm/page_alloc.c             |    2 
 mm/readahead.c              | 1641 +++++++++++++++++++++++++++++++++++++++++++-
 mm/swap.c                   |    2 
 mm/vmscan.c                 |    4 
 23 files changed, 2262 insertions(+), 60 deletions(-)


Changelog
=========

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
Wu Fengguang
--
Dept. Automation                University of Science and Technology of China
