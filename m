Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSFQHK6>; Mon, 17 Jun 2002 03:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSFQGv5>; Mon, 17 Jun 2002 02:51:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316775AbSFQGuC>;
	Mon, 17 Jun 2002 02:50:02 -0400
Message-ID: <3D0D8784.F8DE33E4@zip.com.au>
Date: Sun, 16 Jun 2002 23:53:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 19/19] Reduce the radix tree nodes to 64 slots
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Reduce the radix tree nodes from 128 slots to 64.

- The main reason for this is that on 64-bit/4k page machines, the
  slab allocator has decided that radix tree nodes will require an
  order-1 allocation.  Shrinking the nodes to 64 slots pulls that back
  to an order-0 allocation.

- On x86 we get fifteen 64-slot nodes per page rather than seven
  129-slot nodes, for a modest memory saving.

- Halving the node size will approximately halve the memory use in
  the worrisome really-large, really-sparse file case.

Of course, the downside is longer tree walks.  Each level of the tree
covers six bits of pagecache index rather than seven.  As ever, I am
guided by Anton's profiling on the 12- and 32-way PPC boxes. 
radix_tree_lookup() is currently down in the noise floor.

Now, there is one special case: one file which is really big and which
is accessed in a random manner and which is accessed very heavily: the
blockdev mapping.  We _are_ showing some locking cost in
__find_get_block (used to be __get_hash_table) and in its call to
find_get_page().  I have a bunch of patches which introduce a generic
per-cpu buffer LRU, and which remove ext2's private bitmap buffer LRUs.
I expect these patches to wipe the blockdev mapping lookup lock contention
off the map,  but I'm awaiting test results from Anton before deciding
whether those patches are worth submitting.



--- 2.5.22/lib/radix-tree.c~ratshrink	Sun Jun 16 23:12:54 2002
+++ 2.5.22-akpm/lib/radix-tree.c	Sun Jun 16 23:12:54 2002
@@ -29,7 +29,7 @@
 /*
  * Radix tree node definition.
  */
-#define RADIX_TREE_MAP_SHIFT  7
+#define RADIX_TREE_MAP_SHIFT  6
 #define RADIX_TREE_MAP_SIZE  (1UL << RADIX_TREE_MAP_SHIFT)
 #define RADIX_TREE_MAP_MASK  (RADIX_TREE_MAP_SIZE-1)
 

-
