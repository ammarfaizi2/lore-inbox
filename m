Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbUJaXko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUJaXko (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUJaXk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:40:26 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:708 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261703AbUJaXjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:39:54 -0500
Date: Sun, 31 Oct 2004 18:39:30 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@lazuli.engin.umich.edu
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
cc: Stefan Hornburg <kernel@linuxia.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] prio_tree: fix prio_tree_expand corner c
In-Reply-To: <Pine.LNX.4.44.0409201343170.16315-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0410311837180.13785@lazuli.engin.umich.edu>
References: <Pine.LNX.4.44.0409201343170.16315-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently we use prio_tree_root->index_bits to optimize the height
of both the initial heap-and-radix indexed levels of a prio_tree
as well as the heap-and-size indexed overflow-sub-trees. Please see
the accompanying prio_tree documentation patch for further details.

When index_bits is increased in prio_tree_expand we shuffle the
initial heap-and-radix indexed levels to make sure that vmas are
placed in the tree at appropriate places. Similarly, since the
overflow-sub-trees' heights also depend on prio_tree_root->index_bits
we should shuffle all the overflow-sub-trees when index_bits changes.
However, I missed to take care of this in my implementation.

Recently Stefan Hornburg (Racke) reported the problem and patiently
tested the trace patches. Hugh Dickins produced the trace patches
that helped to detect the bug. Moreover, Hugh reduced the crash
test case to few lines of code. Thanks to both of them.

The easy fix is to disable prio_tree_expand code completely. That
may lead to skewed trees in some common cases. Hence, this patch
takes a different approach.

This patch fixes the problem by not optimizing the height of the
overflow-sub-trees using prio_tree_root->index_bits. Now all
overflow-sub-trees use full BITS_PER_LONG bits of size_index to place
the vmas (that have the same start_vm_pgoff) in an overflow-sub-tree.

This may result in skewed overflow-sub-trees because all bits in
vm_pgoff above prio_tree_root->index_bits will be 0 (zero). However,
processes rarely map many vmas with the same start_vm_pgoff and different
end_vm_pgoff. Therefore, such skewed sub-trees should be very rare.

Signed-off-by: Rajesh Venkatasubramanian <vrajesh@umich.edu>


 mm/prio_tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN mm/prio_tree.c~prio_expand_fix mm/prio_tree.c
--- linux-2.6.9/mm/prio_tree.c~prio_expand_fix	2004-10-31 18:27:09.000000000 -0500
+++ linux-2.6.9-jaya/mm/prio_tree.c	2004-10-31 18:27:09.000000000 -0500
@@ -245,7 +245,7 @@ static struct prio_tree_node *prio_tree_
 		mask >>= 1;

 		if (!mask) {
-			mask = 1UL << (root->index_bits - 1);
+			mask = 1UL << (BITS_PER_LONG - 1);
 			size_flag = 1;
 		}
 	}
@@ -334,7 +334,7 @@ static struct prio_tree_node *prio_tree_
 				iter->mask = ULONG_MAX;
 			} else {
 				iter->size_level = 1;
-				iter->mask = 1UL << (iter->root->index_bits - 1);
+				iter->mask = 1UL << (BITS_PER_LONG - 1);
 			}
 		}
 		return iter->cur;
@@ -376,7 +376,7 @@ static struct prio_tree_node *prio_tree_
 				iter->mask = ULONG_MAX;
 			} else {
 				iter->size_level = 1;
-				iter->mask = 1UL << (iter->root->index_bits - 1);
+				iter->mask = 1UL << (BITS_PER_LONG - 1);
 			}
 		}
 		return iter->cur;

_


