Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271384AbTG2KHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbTG2KFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:05:46 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:57082 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S271373AbTG2KFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:05:11 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: habanero@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] scheduler fix for 1cpu/node case
Date: Tue, 29 Jul 2003 12:08:30 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
References: <200307280548.53976.efocht@gmx.net> <3904530000.1059424676@[10.10.2.4]> <200307282124.28378.habanero@us.ibm.com>
In-Reply-To: <200307282124.28378.habanero@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307291208.30332.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 July 2003 04:24, Andrew Theurer wrote:
> On Monday 28 July 2003 15:37, Martin J. Bligh wrote:
> > > But the Hammer is a NUMA architecture and a working NUMA scheduler
> > > should be flexible enough to deal with it. And: the corner case of 1
> > > CPU per node is possible also on any other NUMA platform, when in some
> > > of the nodes (or even just one) only one CPU is configured in. Solving
> > > that problem automatically gives the Hammer what it needs.
>
> I am going to ask a silly question, do we have any data showing this really
> is a problem on AMD?  I would think, even if we have an idle cpu, sometimes
> a little delay on task migration (on NUMA) may not be a bad thing.   If it
> is too long, can we just make the rebalance ticks arch specific?

The fact that global rebalances are done only in the timer interrupt
is simply bad! It complicates rebalance_tick() and wastes the
opportunity to get feedback from the failed local balance attempts.

If you want data supporting my assumptions: Ted Ts'o's talk at OLS
shows the necessity to rebalance ASAP (even in try_to_wake_up). There
are plenty of arguments towards this, starting with the steal delay
parameter scans from the early days of multi-queue schedulers (Davide
Libenzi), over my experiments with NUMA schedulers and the observation
of Andi Kleen that on Opteron you better run from the wrong CPU than
wait (if the tasks returns to the right cpu, all's fine anyway).

> I'd much rather have info related to the properties of the NUMA arch than
> something that makes decisions based on nr_cpus_node().  For example, we
> may want to inter-node balance as much or more often on ppc64 than even
> AMD, but it has 8 cpus per node.  On this patch it would has the lowest
> inter-node balance frequency, even though it probably has one of the lowest
> latencies between nodes and highest throughput interconnects.

We can still discuss on the formula. Currently there's a bug in the
scheduler and the corner case of 1 cpu/node is just broken. The
function local_balance_retries(attempts, cpus_in_this_node) must
return 0 for cpus_in_this_node=1 and should return larger values for
larger cpus_in_this_node. To have an upper limit is fine, but maybe
not necessary.

Regarding the ppc64 interconnect, I'm glad that you said "probably"
and "one of the ...". No need to point you to better ones ;-)

> > Right, I realise that the 1 cpu per node case is broken. However, doesn't
> > this also affect the multi-cpu per node case in the manner I suggested
> > above? So even if we turn off NUMA scheduler for Hammer, this still
> > needs fixing, right?
>
> Maybe so, but if we start making idle rebalance more aggressive, I think we
> would need to make CAN_MIGRATE more restrictive, taking memory placement of
> the tasks in to account.  On AMD with interleaved memory allocation, tasks
> would move very easily, since their memory is spread out anyway.  On "home
> node" or node-local policy, we may not move a task (or maybe not on the
> first attempt), even if there is an idle cpu in another node.

Aehm, that's another story and I'm sure we will fix that too. There
are a few ideas around. But you shouldn't expect to solve all problems
at once, after all optimal NUMA scheduling can still be considered a
research area.

> Personally, I'd like to see all systems use NUMA sched, non NUMA systems
> being a single node (no policy difference from non-numa sched), allowing us
> to remove all NUMA ifdefs.  I think the code would be much more readable.

:-) Then you expect that everybody who reads the scheduler code knows
what NUMA stands for and what it means? Pretty optimistic, but yes,
I'd like that, too.

Erich


