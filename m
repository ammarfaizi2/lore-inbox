Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUDOWkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDOWkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:40:06 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3789
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262134AbUDOWkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:40:01 -0400
Date: Fri, 16 Apr 2004 00:40:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <20040415224005.GM2150@dualathlon.random>
References: <Pine.LNX.4.44.0404151752210.9569-100000@localhost.localdomain> <178970000.1082049291@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178970000.1082049291@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 10:14:51AM -0700, Martin J. Bligh wrote:
> I still think my list-of-lists patch fixes the original problem, and is
> simpler ... I'll try to get it updated, and sent out.

it's a lot worse than the prio-tree IMHO, when a new range is generated
you've to loop all over the vmas etc... it's O(N) stuff for certain ops,
prio-tree is O(log(N)) for all.

If your object is to be able to use RCU (and implementing a RCU
prio-tree is going to be extremely complicated) you can attempt a
prio-skip-list, that would be a skip-list (that still provides O(log(N))
but that uses lists everywhere so that you can more easily create a
RCU-prio-skip-list, though I didn't even think if the range-lookup can
be implemented reasonably easily on top of a skip-list to create the
prio-skip-list).

but even if we could create the rcu-prio-skip-list (that would solve all
complexity issues like the prio-tree and it would allow lockless lookups
too [unlike prio-tree]) you'd still have to deal with the mess of
freeing vmas with rcu, that would cause everything else over the
vma to be freed with rcu too, mm, pgds etc... that would require quite
some changes, at the very least to be able to garbage collect the mm,pgd
from the vma free operations. I doubt it worth it, for the fast path you
cannot go lockless anyways, the lockless is only for the readonly
operations, and the readonly are the only unlikely ones (namely only
truncate and paging). So it's overdesign.
