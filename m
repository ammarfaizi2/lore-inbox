Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVLCHJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVLCHJx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 02:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVLCHJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 02:09:53 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:28093 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751123AbVLCHJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 02:09:52 -0500
Message-Id: <20051203071444.260068000@localhost.localdomain>
Date: Sat, 03 Dec 2005 15:14:44 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 00/16] Adaptive read-ahead V9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current read-ahead logic uses an inflexible algorithm with 128KB
VM_MAX_READAHEAD. Less memory leads to thrashing, more memory helps no
throughput. The new logic is simply safer and faster. It makes sure
every single read-ahead request is safe for the current load. Memory
tight systems are expected to benefit a lot: no thrashing any more.
It can also help boost I/O throughput for large memory systems, for
VM_MAX_READAHEAD now defaults to 1MB. The value is no longer tightly
coupled with the thrashing problem, and therefore constrainted by it.

Changelog
=========

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


Thanks,
Wu Fengguang
--
Dept. Automation                University of Science and Technology of China
