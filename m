Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbRGMWnl>; Fri, 13 Jul 2001 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbRGMWnd>; Fri, 13 Jul 2001 18:43:33 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:1006 "EHLO e23.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266967AbRGMWnV>;
	Fri, 13 Jul 2001 18:43:21 -0400
Date: Fri, 13 Jul 2001 15:43:05 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Larry McVoy <lm@bitmover.com>, Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: CPU affinity & IPI latency
Message-ID: <20010713154305.G1137@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20010713100521.D1137@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.33.0107131249200.4540-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107131249200.4540-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Fri, Jul 13, 2001 at 12:51:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 12:51:53PM -0700, David Lang wrote:
> A real-world example of this issue.
> 
> I was gzipping a large (~800MB) file on a dual athlon box. the gzip prcess
> was bouncing back and forth between the two CPUs. I actually was able to
> gzip faster by starting up setiathome to keep one CPU busy and force the
> scheduler to keep the gzip on a single CPU (I ran things several times to
> verify it was actually faster)
> 
> David Lang

That does sound like the same behavior I was seeing with lat_ctx.  Like
I said in my previous note, the scheduler does try to take CPU affinity
into account.  reschedule_idle() does a pretty good job of determining
what CPU a task should run on.  In the case of lat_ctx (and I believe
your use of gzip), the 'fast path' in reschedule_idle() is taken because
the CPU associated with the awakened task is idle.  However, before
schedule() is run on the 'target' CPU, schedule() is run on another
CPU and the task is scheduled there.

The root cause of this situation is the delay between the time
reschedule_idle() determines what is the best CPU a task should run
on, and the time schedule() is actually ran on that CPU.

I have toyed with the idea of 'temporarily binding' a task to a CPU
for the duration of the delay between reschedule_idle() and schedule().
It would go something like this,

- Define a new field in the task structure 'saved_cpus_allowed'.
  With a little collapsing of existing fields, there is room to put
  this on the same cache line as 'cpus_allowed'.
- In reschedule_idle() if we determine that the best CPU for a task
  is the CPU it is associated with (p->processor), then temporarily
  bind the task to that CPU.  The task is temporarily bound to the
  CPU by overwriting the 'cpus_allowed' field such that the task can
  only be scheduled on the target CPU.  Of course, the original
  value of 'cpus_allowed' is saved in 'saved_cpus_allowed'.
- In schedule(), the loop which examines all tasks on the runqueue
  will restore the value of 'cpus_allowed'.

This would preserve the 'best CPU' decision made by reschedule_idle().
On the down side, 'temporarily bound' tasks could not be scheduled
until schedule() is run on their associated CPUs.  This could potentially
waste CPU cycles, and delay context switches.  In addition, it is
quite possible that while a task is 'temporarily bound' the state of
the system could change in such a way that the best CPU is no longer
best.

There appears to be a classic tradeoff between CPU affinity and
context switch time.

Comments?

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
