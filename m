Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317381AbSFCMFA>; Mon, 3 Jun 2002 08:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317382AbSFCME7>; Mon, 3 Jun 2002 08:04:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34536 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317381AbSFCME6>;
	Mon, 3 Jun 2002 08:04:58 -0400
Date: Mon, 3 Jun 2002 17:38:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
Message-ID: <20020603173810.A8437@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020528171104.D19734@in.ibm.com> <20020528.042514.92633856.davem@redhat.com> <20020528182806.A21303@in.ibm.com> <1022600998.20317.44.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 08:49:58AM -0700, Robert Love wrote:
> I agree the numbers posted are nice, but I remain skeptical like Linus. 
> Sure, the locking overhead is nearly gone in the profiled function where
> RCU is used.  But the overhead has just been _moved_ to wherever the RCU
> work is now done.  Any benchmark needs to include the damage done there,
> too.

Hi Robert,

I did a crude analysis of RCU overhead for rt_rcu-2.5.3-1.patch
and the corresponding RCU infrastructure patch rcu_ltimer-2.5.3-1.patch.
(http://prdownloads.sourceforge.net/lse/rcu_ltimer-2.5.3-1.patch).
The rcu_ltimer patch uses the local timer interrupt handler to check
if there is any RCU pending for that that CPU. The 
smp_local_timer_interrupt() routine is never counted for profiling,
but it happens every 10ms and the RCU overhead is limited
to checking a few CPU-local things and scheduling the per-CPU
RCU tasklet. The rest of the RCU code is entirely in rcupdate.c
and were measured in kernel profiling.

Here is an analysis of what we can measure -

1. rt_rcu with neighbor table garbage collection threshold increased
   prevent frequent overflow (due to random dest addresses).
   (8-1-32-gc31048576gcint60 configuration in earlier published results).


Function                              2.5.3              rt_rcu-2.5.3
--------                              ------             ------------
ip_route_output_key [c0214470]:        4486                2026

call_rcu [c0125f40]:                   N/A                 11
rcu_process_callbacks [c01261d0]:      N/A                 4
rcu_invoke_callbacks [c0125fc0]:       N/A                 4

So with infrequent updates, clearly RCU overheads are practically
negligible.


2. rt_rcu with frequent neighbor table overflow (due to random dest addresses)
   (8-1-32 configuration in earlier published results).


Function                              2.5.3              rt_rcu-2.5.3
--------                              ------             ------------
ip_route_output_key [c0214470]:       2358                 1646

call_rcu [c0125f40]:                  N/A                  262
rcu_invoke_callbacks [c0125fc0]:      N/A                  57
rcu_process_callbacks [c01261d0]:     N/A                  49
rcu_check_quiescent_state [c0126030]: N/A                  27
rcu_check_callbacks [c01260d0]:       N/A                  24
rcu_reg_batch [c0125ff0]:             N/A                  3

This shows that with very frequent RCU updates, the real gains
made in ip_route_output_key() is less but still outweighs RCU overhead. 
I suspect that such frequent update is not a common occurrence, but Davem
can confirm that.

The bottom line is that RCU overhead is tolerable where we know that
updates are not going to be frequent. Also different RCU
algorithms are likely to have different overheads. We will
present analysis for these algorithms as we go along.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
