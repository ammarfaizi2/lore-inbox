Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289260AbSA1ROD>; Mon, 28 Jan 2002 12:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289270AbSA1RNx>; Mon, 28 Jan 2002 12:13:53 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:36233 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S289260AbSA1RNk>; Mon, 28 Jan 2002 12:13:40 -0500
Date: Mon, 28 Jan 2002 09:13:38 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020128091338.D6578@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When memory pressure becomes high, the Linux kswapd begins calling
shrink_caches() from try_to_free_pages() with an integer priority from
6 (the default, lowest priority) to 1 (high priority).  Looking
specifically at the dcache, this results in a calls to
shrink_dcache_memory() that attempt to free a fraction (1/priority) of
the inactive dcache entries.  This ultimately leads to prune_dcache()
scanning the dcache in least-recently-used order attempting to call
kmem_cache_free() on some number of dcache entries.

Dcache entries are allocated from the kmem_slab_cache, which manages
objects in page-size "slabs", but the kmem_slab_cache cannot free a
page until every object in a slab becomes unused.  The problem is that
freeing dcache entries in LRU-order is effectively freeing entries
from randomly-selected slabs, and therefore applying shrink_caches()
pressure to the dcache has an undesired result.  In the attempt to
reduce its size, the dcache must free objects from random slabs in 
order to actually release full pages.  The result is that under high
memory pressure the dcache utilization drops dramatically.  The
prune_dcache() mechanism doesn't just reduce the page utilization as
desired, it reduces the intra-page utilization, which is bad.

In order to measure this effect (via /proc/slabinfo) I first populated
a large dcache and then ran a memory-hog to force swapping to occur.
The dcache utilization drops to between 20-35%.  For example, before
running the memory-hog my dcache reports:

dentry_cache       10170  10170    128  339  339    1 :  252  126

(i.e., 10170 active dentry objects, 10170 available dentry objects @
128 bytes each, 339 pages with at least one object, and 339 allocated
pages, an approximately 1.4MB dcache)

While running the memory-hog program to initiate swapping, the dcache
stands at:

dentry_cache         693   3150    128  105  105    1 :  252  126

Meaning, the randomly-applied cache pressure was successful at freeing
234 (= 339-105) pages, leaving a 430KB dcache, but at the same time it
reduced the cache utilization to 22%, meaning that although it was
able to free nearly 1MB of space, 335KB are now wasted as a result of
the high memory-pressure condition.

So, it would seem that the dcache and kmem_slab_cache memory allocator
could benefit from a way to shrink the dcache in a less random way.
Any thoughts?

-josh

--
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
