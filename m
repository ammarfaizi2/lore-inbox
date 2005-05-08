Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVEHPZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVEHPZw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 11:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVEHPZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 11:25:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33941 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262886AbVEHPZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 11:25:33 -0400
Date: Sun, 8 May 2005 20:56:11 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       rusty@rustcorp.com.au, schwidefsky@de.ibm.com, jdike@addtoit.com,
       akpm@osdl.org, mingo@elte.hu, rmk+lkml@arm.linux.org.uk,
       nickpiggin@yahoo.com.au, Dipankar <dipankar@in.ibm.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050508152611.GA28956@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <m1vf5tvo8b.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vf5tvo8b.fsf@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 03:31:00PM +0200, Andi Kleen wrote:
> I think the best way is to let other CPUs handle the load balancing
> for idle CPUs. Basically when a CPU goes fully idle then you mark
> this in some global data structure, 

nohz_cpu_mask already exists for this purpose.

> and CPUs doing load balancing after doing their own thing look for others 
> that need to be balanced too and handle them too. 

This is precisely what I had proposed in my watchdog implementation.

> When no CPU is left non idle then nothing needs to be load balanced anyways. 
> When a idle CPU gets a task it just gets an reschedule IPI as usual, that 
> wakes it up. 

True.

> 
> I call this the "scoreboard".
> 
> The trick is to evenly load balance the work over the remaining CPUs.
> Something simple like never doing work for more than 1/idlecpus is
> probably enough. 

Well, there is this imbalance_pct which acts as a trigger threshold before
which load balance won't happen.  I do take this into account before
waking up the sleeping idle cpu (the same imbalance_pct logic would 
have been followed by the idle CPU if it were to continue taking timer
ticks).

So I guess your 1/idlecpus and the imbalance_pct may act on parallel lines.

> In theory one could even use machine NUMA topology
> information for this, but that would be probably overkill for the
> first implementation.
> 
> With the scoreboard implementation CPus could be virtually idle
> forever, which I think is best for virtualization.
> 
> BTW we need a very similar thing for RCU too.

RCU is taken care of already, except it is broken. There is a small
race which is not fixed. Following patch (which I wrote aainst 2.6.10 kernel
maybe) should fix that race. I intend to post this patch after test
agaist more recent kernel.


--- kernel/rcupdate.c.org	2005-02-11 11:38:47.000000000 +0530
+++ kernel/rcupdate.c	2005-02-11 11:44:08.000000000 +0530
@@ -199,8 +199,11 @@ static void rcu_start_batch(struct rcu_c
  */
 static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
 {
+	cpumask_t tmpmask;
+
 	cpu_clear(cpu, rsp->cpumask);
-	if (cpus_empty(rsp->cpumask)) {
+	cpus_andnot(tmpmask, rsp->cpumask, nohz_cpu_mask);
+	if (cpus_empty(tmpmask)) {
 		/* batch completed ! */
 		rcp->completed = rcp->cur;
 		rcu_start_batch(rcp, rsp, 0);



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
