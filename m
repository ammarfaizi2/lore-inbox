Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVI2SQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVI2SQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVI2SQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:16:19 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:60689 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932312AbVI2SQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:16:18 -0400
Message-Id: <20050929180845.910895444@twins>
Date: Thu, 29 Sep 2005 20:08:45 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: [PATCH 0/7] CART - an advanced page replacement policy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple memory zone CART implementation for Linux.
An advanced page replacement policy.

http://www.almaden.ibm.com/cs/people/dmodha/clockfast.pdf
(IBM does hold patent rights to the base algorithm ARC)

My ideas are based on the initial cart patch by Rahul Iyer and the
non-resident code of Rik van Riel.

For a zoned page replacement algorithm we have per zone resident list(s)
and global non-resident list(s). CART specific we would have a T1_i and
T2_i, where 0 <= i <= nr_zones, and global B1 and B2 lists.

Because B1 and B2 are variable size and the B1_i target size q_i is zone
specific we need some tricks. However since |B1| + |B2| = c we could get
away with a single hash_table of c entries if we can manage to balance
the entries within.

Let us denote the buckets with the subscript j: |B1_j| + |B2_j| = c_j.

We need to balance the per zone values:
 T1_i, T2_i, |T1_i|, |T2_i|
 p_i, Ns_i, Nl_i

 |B1_i|, |B2_i|, q_i

against the per bucket values:
 B1_j, B2_j.

and global values:
 |B1|, |B2|

This can be done with two simple modifications to the algorithm:

 - explicitly keep |B1_i| and |B2_i| - needed for the p,q targets;
   rebalance with the global |B1|, |B2| before a batch replace.

 - merge the history replacement (lines 6-10) in the replace (lines
   36-40) code so that: adding the new MRU page and removing the old LRU
   page becomes one action.

This will keep:

 |B1_j|     |B1|     |B1_i|
-------- ~ ------ ~ --------
 |B2_j|     |B2|     |B2_i|


I implemented my ideas in the following 4 patches:

[1/7] cart-nonresident.patch
[3/7] cart-cart.patch
[6/7] cart-use-once.patch
[7/7] cart-use-cart.patch

1. contains the hashed nonresident page management
3. contains the CART implementation proper
6. removes the current use-once logic
7. replace the current page replacement logic with cart

I also improved upon CART in the following patch:

[5/7] cart-cart-r.patch

And some debugging /proc stats for both the nonresident and cart code:

[2/7] cart-nonresident-stats.patch
[4/7] cart-cart-stats.patch


The code seems stable on my SMP box (thanks to the wonderfull lock debugging
found in the -rt tree) hence this first post outside of linux-mm.

All feedback, comments and test results are welcome. I hope for inclusion in
-mm and if blessed in -linus one day.


Kind regards,

  Peter Zijlstra
