Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318742AbSIKMKR>; Wed, 11 Sep 2002 08:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSIKMKQ>; Wed, 11 Sep 2002 08:10:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63112 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318742AbSIKMKQ>;
	Wed, 11 Sep 2002 08:10:16 -0400
Date: Wed, 11 Sep 2002 17:50:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read-Copy Update 2.5.34
Message-ID: <20020911175011.D28198@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020911164940.C28198@in.ibm.com> <Pine.LNX.4.44.0209111323360.12332-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209111323360.12332-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 11, 2002 at 01:24:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 01:24:21PM +0200, Ingo Molnar wrote:
> 
> i dont really understand why it has to change the scheduler. You want a
> facility to force a reschedule on any given CPU, correct?
> 

Hi Ingo,

Yes, like force_cpu_reschedule().

Apart from that RCU adds some minor things in the scheduler code -

1. Per-CPU context switch counter increment in the fast path
2. For preemptive kernels, a conditional branch in the voluntary
   context switch code path checking whether the current task may 
   have had an involuntary context switch earlier [rcu_preempt_put()].
3. Adding a field to the task structure - cpu_preempt_cntr.
4. RCU checking hook into the scheduler_tick(), but this is not
   in the fast path.

#2 and #3 are necessary to support call_rcu_preempt() which
allows preemption-safe reads of data protected by RCU. A preempted
task may still contain references to RCU protected data and
the RCU grace period needs to be prolonged until all such tasks
before the update do voluntary context switches.

I did some reflex benchmarking to make sure that I didn't introduce 
any false sharing by mistake in scheduler fast path and the results 
look comparable -

(4CPU P3 Xeon with 1MB L2 + 1GB RAM)

			vanilla-2.5.34	rcu_poll-2.5.34
			--------------  ---------------
80 , 40 , 		1.593		1.569
112 , 40 , 		1.544		1.554
144 , 40 , 		1.595		1.552
176 , 40 , 		1.568		1.605
198 , 40 , 		1.562		1.577
230 , 40 , 		1.563		1.583
244 , 40 , 		1.671		1.638

Not sure how reliable these numbers are.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
