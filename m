Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTFTNrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTFTNrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:47:13 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:58290 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP id S261825AbTFTNrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:47:07 -0400
Date: Fri, 20 Jun 2003 10:00:51 -0400 (EDT)
From: Jiantao Kong <jiantao@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
cc: jkong@us.ibm.com
Subject: Improper parameter for refill_inactive_zone in 2.5 kernel
Message-ID: <Pine.GSO.4.50.0306200959160.28060-100000@gaia.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following description is based on the 2.5.69 kernel. But it seems that
the 2.5.72 kernel is the same.

PROBLEM 1: refill_counter becomes extreme large.

In 2.5 kernel, the number of pages that are moved from the active list to
the inactive list is determined in two steps. First, it is calculated
using the same formula as 2.4 kernel.
  ratio = nr_pages * nr_active /((nr_inactive|1*2);
Then, this ratio value is added to a refill_counter. If the refill_counter
is larger than SWAP_CLUSTER_MAX, min{refill_counter, 4*SWAP_CLUSTER_MAX}
pages are examined in the active list to refill the inactive list. The
number of pages examined is reduced from the refill_counter.

However, the refill_counter may become extreme large in some cases. I ran
test under UML with 160M memory and 512M swap space. A process allocates
190M memory using malloc and accesses the memory continuously. The
refill_counter becomes very large after a while.
(My printk output: refill counter = 1263227753)

Basically, the formula tells us the number of pages to examine based on
the distance from current state to the ideal state. So there is no need to
consider anything from any old state. The only purpose to maintain the
refill_counter is to avoid doing refill_inactive_zone when the number of
pages which need to be examined is too small. So, instead of subtracting
the number of pages examined from the refill_counter, it should be better
to reset it to zero every time refill_inactive_zone is called.

PROBLEM 2: try_to_free_pages/balance_pgdat is more likely to fail to
reclaim enough pages.

When the inactive list is almost empty, pages must be moved from the
active list to the inactive list first to reclaim. The upper bound for
refill_inactive_zone limits the number of pages to examine to
4*(DEF_PRIORITY+1)*SWAP_CLUSTER_MAX for try_to_free_pages and
balance_pgdat. It is possible that there is not enough pages moved to the
inactive list because that 'page_referenced' returns true for many of
those examined pages.

The effect of this behavior is not clear for me. Will it affect the
responsiveness of the system?

Is it better to determine the upper bound for refill_inactive_zone based
on the 'priority' parameter for shrink_zone just like the way that
controls the number of pages to scan for shrink_cache?

			-Jiantao Kong (jiantao@cc.gatech.edu)

P.S.:

One simple example can show why the counter becomes so large. Considering
the worse case scenario that the inactive list is empty, then the ratio is
(nr_pages*nr_active)/2. Here the nr_pages is the number of pages to
reclaim, which is usually SWAP_CLUSTER_MAX=32 in 2.5 kernel if calling
from try_to_free_pages or even larger if calling from balance_pgdat. Now
the ratio may be 16N where N is the number of active pages. In 2.4 kernel,
this number causes the refill_inactive to scan more pages then necessary.
In 2.5 kernel, this number is still accumulated into the refill_counter.
Moreover, the speed of feeding the refill_counter may be quicker than the
speed of consuming. For example, the refill_inactive_zone may move fewer
pages then expected so that the inactive list is still empty after the
shrink_cache. Then the next time when shrink_zone is called, another 16N
is added to the refill counter.

