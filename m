Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRITSOQ>; Thu, 20 Sep 2001 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274586AbRITSOH>; Thu, 20 Sep 2001 14:14:07 -0400
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:1702 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S268835AbRITSN4>; Thu, 20 Sep 2001 14:13:56 -0400
Date: Thu, 20 Sep 2001 11:14:19 -0700
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Subject: RFC: Cache-optimized concurrent skip lists in kernel?
Message-ID: <20010920111419.A2635@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a solution just waiting for the right problem to come along
and find it useful.  Some of you on l-k may have an application
in mind so I will share it with you.

I developed this data structure originally as part of a class
project, the topic of which was to measure the cache-efficiency
of in-memory tree data structures.  One of the data structures
we tested was the "Deterministic Top-down Skip List".  The basic
algorithms for maintaining balanced top-down skip lists were the
simplest I had ever seen, but the examples in the literature
use a "linked" structure--essentially making it a binary tree
with two pointers per node.  Binary search trees utilize the
cache poorly, so an improvement was needed.  The "paged skip
list" organizes larger nodes, similar to a B+tree, to make better
use of the cache.

We ran experiments with linked skip list, paged skip list, 
B+tree, and AVL tree to determine their cache performance using
both a real (x86) and simulated (simplescalar) processors.
The B+tree and paged skip list support variable node sizes, 
which is a cache-tuning parameter.  The best node size on x86
for the processors I've tested is either 128 or 256 bytes.
The skip list and B-tree perform similarly, but the top-down
algorithms require no recursion, just a single downward pass,
resulting in a shorter code path.  The paged skip list won in
all of our comparisons.  

The cost of a cache-miss (DRAM latency) in clock cycles is rising
with time, so cache-efficiency is a rising concern.

Since the original experiments over two years ago I have written 
two polished versions of the paged skip list data structure--
the algorithms are stable and quite well understood.

The latest version of the paged skip list adds (optional) 
node-level concurrency control.  I have used the Linux 2.4 
read/write spinlock to accomplish this with the intention 
that it may find a use in the kernel.  Top-down balancing 
routines have a very natural kind of concurrency using lock-
coupling to descend the tree.  Readers and writers aquire 
read locks on internal nodes.  Writers upgrade to a write 
lock when necessary.  Insertion never locks more than two 
nodes, deletion never locks more than three nodes, when 
rebalancing is required.  The algorithms are deadlock-free.

I have run concurrency tests on this code, unfortunatly 
I have only been able to test on 1- and 2-processors so far, 
but the results for a 2-way SMP were promising.  The speedup
is not linear, due to the cost of cache consistency 
protocols, but at the very least I have measured speedup
of 10-25% with two processors for a update-intensive
workload (25% insert, 25% delete, 50% search) on trees 
ranging in size of 400 to 4000000 keys.

Enough description, here's the code:

	http://prdownloads.sourceforge.net/skiplist/slpc-20010917.tar.gz

There is a file named RESULTS with some experimental data.

Here's the term paper giving our original results:

	http://prdownloads.sourceforge.net/skiplist/skiplist.pdf

(On sourceforge you'll also find an older, templatized C++ 
class implementing the same algorithm w/o concurrency.)

I am seeking your comments.  I know of only one tree structure
in the kernel (mm/mmap_avl.c), but I wonder if there are any
other applications people would have if the right data structure
came along.  What in the kernel needs dynamic, sorted mappings?

If you have any comments or suggestions I would appreciate 
feedback.  Thanks,

-josh
