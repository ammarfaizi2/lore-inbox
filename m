Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275621AbRJAV7O>; Mon, 1 Oct 2001 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275616AbRJAV6y>; Mon, 1 Oct 2001 17:58:54 -0400
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:5321 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S275615AbRJAV6r>; Mon, 1 Oct 2001 17:58:47 -0400
Date: Mon, 1 Oct 2001 14:59:06 -0700
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Cc: riel@conectiva.com.br, andrea@suse.de
Subject: Cache-Opt Skip List & Red-Black Tree
Message-ID: <20011001145906.A3616@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have done experiments comparing Andrea's new red-black tree found in
kernel 2.4.10 with the cache-optimized skip list that I advertised
here a week ago.  There are many ways you could measure the relative
performance of these data structures, but I chose my experiment based
on the usage of vm_area_struct in mm/mmap.c.  vm_area_struct is
currently a 68-byte structure, with 20 bytes devoted to the red-black
tree and the singly-linked list of VMA entries: three pointers per
red-block node, one integer to store the color, and one right-link
pointer in the sorted list of VMAs.

I ran an experiment parametrized by the maximum number of keys in the
key-space to determine the average insertion, search, and deletion
times associated with accessing the data structures.  This test does
not measure concurrency, since the red-black tree does not support
concurrent access.  For each run of the experiment, space was
pre-allocated for max-keys vm_area_structs and then half of the
key-space was populated in each tree.  A mixture of insert, search,
and delete operations followed that probabilistically maintains a 50%
occupancy.

I measure space overhead, which is fixed for the vm_area_struct usage
at 41.7% overhead.  The skip list separates its pointers into nodes
and except for very small trees, its worst-case overhead is slightly
smaller at 38.1%.  That is if every node is exactly half-full, whereas
the expected occupancy is 66%.

The results for average-key-counts ranging from 8 to 512000 (max-keys
from 16 to 1024000) are plotted in the following (log-scale) graphs.
The first three plot the average number of cycles per operation:

    http://prdownloads.sourceforge.net/skiplist/slrb_insert.gif
    http://prdownloads.sourceforge.net/skiplist/slrb_search.gif
    http://prdownloads.sourceforge.net/skiplist/slrb_delete.gif

And the final plots space overhead (%):

    http://prdownloads.sourceforge.net/skiplist/slrb_space.gif

The results show the effect of the cache-optimization but it takes a
reasonably large tree before it kicks in.  The RB-tree performs better
at insert and delete up to an average of around 10000 keys, at which
point the slopes change and the red-black tree performs exponentially
worse.  The same effect happens for search but the crossing-point is
much sooner at around 1000 keys.  (The reason why insert and delete
perform relatively worse is that they have to re-organize up to
256-bytes of data each time a rebalancing occurs).

The insert/delete results are somewhat generous in favor of the
red-black tree since I did not measure the cost of maintaining the
additional linked list of vm_area_structs.  That is maintained
already as part of the skip list.

I present these results in the hopes that someone out there may have a
task that requires dynamic mapping of sufficiently many keys that the
cache-optimization pays off.

I do not suggest this could be a drop-in replacement for the
vm_area_struct red-black tree.  For one thing, the red-black tree code
is not well encapsulated.  This is done for performance reasons, but
still you must write your own search routines based on the provided
helper functions to rebalance the tree.  Anreas's comment on this
subject:

    To use rbtrees you'll have to implement your own insert and search cores.
    This will avoid us to use callbacks and to drop drammatically performances.
    I know it's not the cleaner way,  but in C (not in C++) to get
    performances and genericity...

I personally believe that the skip list, taken on fundamentals, offers
a much simpler data structure, and it shows that you need not entirely
sacrifice performance for a clean abstraction.  The de-embedding of
tree nodes from the vm_area_struct is part of the cache-optimization.

Further, one of the major aspects of this data structure is that it
gives you concurrency as well, and the vm_area_struct is protected by
a call to lock_vma_mappings() as well as a spin_lock on
mm->page_table_lock.  I realize it takes significant design work
to make use of a concurrent data structure such as this.

Are there applications out there that use 1000s or 10000s of
vm_area_struct mappings?  I would be curious to know.

I have included the code necessary to repeat these experiments in the
20011001 release of SLPC, also available on sourceforge.

-josh
