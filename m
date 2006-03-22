Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932863AbWCVWbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863AbWCVWbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932868AbWCVWbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:31:44 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:26504 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S932863AbWCVWbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:31:42 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 00/34] mm: Page Replacement Policy Framework
Date: Wed, 22 Mar 2006 23:31:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch-set introduces a page replacement policy framework and 4 new 
experimental policies.

The page replacement algorithm determines which pages to swap out.
The current algorithm has some problems that are increasingly noticable, even
on desktop workloads. As said, this patch-set introduces 4 new algorithms.

Patches 01 - 25:

  Introduction of the general framework. Piece by piece the current 
use-once LRU-2Q policy is isolated. With each patch a piece of the framework
API is introduced.

Patches 26 - 29: 

  Adds a policy based on CLOCKPro. (http://linux-mm.org/PeterZClockPro2)

Patches 30 - 32: 

  Adds a policy based on CART. (http://linux-mm.org/PeterZCart)

Patch 33: 

  Adds a variation of the CART policy that tries to incorporate 
cyclic access patterns.

Patch 34: 

  Adds a random page replacement policy, simple policy that uses a simple
PRNG to take the decision. More of a toy example than a real alternative.


Individual patches and a rollup can be found here:
  http://programming.kicks-ass.net/kernel-patches/page-replace/


Measurements:

(Walltime, so lower is better)

cyclic-anon ; Cyclic access pattern with anonymous memory.
              (http://programming.kicks-ass.net/benchmarks/cyclic-anon.c)

2.6.16-rc6              14:28
2.6.16-rc6-useonce      15:11
2.6.16-rc6-clockpro     10:51
2.6.16-rc6-cart          8:55
2.6.16-rc6-random     1:09:50

cyclic-file ; Cyclic access pattern with file backed memory.
              (http://programming.kicks-ass.net/benchmarks/cyclic-file.c)

2.6.16-rc6              11:24
2.6.16-rc6-clockpro      8:14
2.6.16-rc6-cart          8:09

webtrace ; Replay of an IO trace from the Umass trace repository
           (http://programming.kicks-ass.net/benchmarks/spc/)

2.6.16-rc6               8:27
2.6.16-rc6-useonce       8:24
2.6.16-rc6-clockpro     10:23
2.6.16-rc6-cart         15:30
2.6.16-rc6-random       15:52

mdb-bench ; Low frequency benchmark.
            (http://linux-mm.org/PageReplacementTesting)

2.6.16-rc6            4:20:44
2.6.16-rc6 (mlock)    3:52:15
2.6.16-rc6-useonce    4:20:59
2.6.16-rc6-clockpro   3:56:17
2.6.16-rc6-cart       4:11:54
2.6.16-rc6-random     5:21:30

(I should do more runs to get error bounds on these values, 
 this is the avg of 3)

Aside from tweaking the policies, the big thing left is NUMA-ify the 
nonresident page trackers.

The results merit further attention, please consider for 2.6.18.

Peter

---

 Documentation/vm/page_replacement_api.txt |  216 +++++++
 fs/cifs/file.c                            |    4 
 fs/exec.c                                 |    4 
 fs/mpage.c                                |    5 
 fs/ntfs/file.c                            |    4 
 fs/ramfs/file-nommu.c                     |    2 
 include/linux/mm_cart_data.h              |   39 +
 include/linux/mm_cart_policy.h            |  141 ++++
 include/linux/mm_clockpro_data.h          |   21 
 include/linux/mm_clockpro_policy.h        |  143 +++++
 include/linux/mm_inline.h                 |   39 -
 include/linux/mm_page_replace.h           |  146 +++++
 include/linux/mm_page_replace_data.h      |   19 
 include/linux/mm_random_data.h            |    9 
 include/linux/mm_random_policy.h          |   47 +
 include/linux/mm_use_once_data.h          |   16 
 include/linux/mm_use_once_policy.h        |  175 ++++++
 include/linux/mmzone.h                    |    8 
 include/linux/nonresident-cart.h          |   34 +
 include/linux/nonresident.h               |   12 
 include/linux/page-flags.h                |   11 
 include/linux/pagevec.h                   |    8 
 include/linux/percpu.h                    |    5 
 include/linux/rmap.h                      |    4 
 include/linux/swap.h                      |   10 
 init/main.c                               |    2 
 mm/Kconfig                                |   32 +
 mm/Makefile                               |    6 
 mm/cart.c                                 |  723 +++++++++++++++++++++++++
 mm/clockpro.c                             |  855 ++++++++++++++++++++++++++++++
 mm/filemap.c                              |   20 
 mm/hugetlb.c                              |    5 
 mm/memory.c                               |   42 +
 mm/mempolicy.c                            |   13 
 mm/mmap.c                                 |    5 
 mm/nonresident-cart.c                     |  362 ++++++++++++
 mm/nonresident.c                          |  167 +++++
 mm/page_alloc.c                           |   76 --
 mm/random_policy.c                        |  292 ++++++++++
 mm/readahead.c                            |    9 
 mm/rmap.c                                 |   26 
 mm/shmem.c                                |    2 
 mm/swap.c                                 |  206 +------
 mm/swap_state.c                           |    6 
 mm/swapfile.c                             |   17 
 mm/useonce.c                              |  489 +++++++++++++++++
 mm/vmscan.c                               |  552 +++----------------
 47 files changed, 4226 insertions(+), 803 deletions(-)

