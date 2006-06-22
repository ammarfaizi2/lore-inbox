Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWFVUZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWFVUZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWFVUZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:25:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:57298 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030392AbWFVUZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:25:20 -0400
Date: Thu, 22 Jun 2006 13:25:53 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul McKenney <Paul.McKenney@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Userspace RCU+rtth hack (was Re: [patch 3/3] radix-tree: RCU lockless readside)
Message-ID: <20060622202552.GH1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060408134635.22479.79269.sendpatchset@linux.site> <20060408134707.22479.33814.sendpatchset@linux.site> <20060622014949.GA2202@us.ibm.com> <20060622154518.GA23109@wotan.suse.de> <20060622163032.GC1295@us.ibm.com> <20060622165551.GB23109@wotan.suse.de> <20060622174057.GF1295@us.ibm.com> <20060622182343.GA29003@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622182343.GA29003@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 08:23:43PM +0200, Nick Piggin wrote:
> 
> Just out of interest, attached is my userspace RCU implementation
> and RCU radix-tree concurrent tests for Andrew Morton's radix-tree
> test harness.
> 
> The RCU implementation is only 100 lines. Awful performance, of
> course, but I've stretched the rcu_read_lock/unlock over large
> periods so that we can get full concurrency at the cost of a
> bit of memory build up. And it still seems to catch use-after
> RCU-freed errors pretty easily.

Interesting approach!  One caution -- this approach can result in
RCU callbacks being invoked in the context of either call_rcu() or
rcu_read_unlock().  In some legitimate uses of RCU, this can result
in deadlock.  See Documentation/RCU/UP.txt for more info.

One solution is to have some other context (perhaps just a separate
pthread, given that performance is not critical) to invoke the callbacks.

Another user-level RCU implementation is available here:

	http://www.cs.toronto.edu/~tomhart/perflab/ipdps06.tgz

Tom and his major prof unfortunately felt the need to rename
everything.  Here is a decoder ring:

	Linux Name			perflab name

	rcupdate.c			qsbr.c
	rcupdate.h			qsbr.h
	call_rcu()			free_node_later()
	rcu_read_lock()			N/A
	rcu_read_unlock()		N/A

The perflab package invokes callbacks from the quiescent state
(called quiescent_state(), appropriately enough).

FWIW, "QSBR" stands for quiescent-state-based reclamation.

I have a few user-mode implementations myself, but the lawyers won't
let me release them.  :-(

> Question - our kernel's call_rcu implies a smp_wmb, right? Because
> that did catch me out initially, because I initially had no barrier
> to prevent the freeing of the object becoming visible before
> removal of its last reference becoming visible (fixed by adding
> smp_wmb() in my call_rcu).

No and yes...  The kernel's call_rcu() itself does not have an smp_wmb(),
but the Classic RCU grace-period mechanism forces a memory barrier on each
CPU as part of grace-period detection -- which is why rcu_read_lock()
and rcu_read_unlock() don't need memory barriers.  Looks like your need
for an smp_wmb() in call_rcu() itself is due to the fact that you can
execute callbacks in the context of the call_rcu() itself.

							Thanx, Paul
