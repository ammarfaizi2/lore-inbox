Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314755AbSEHRCj>; Wed, 8 May 2002 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSEHRCi>; Wed, 8 May 2002 13:02:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:22460 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314755AbSEHRCh>; Wed, 8 May 2002 13:02:37 -0400
Date: Wed, 8 May 2002 10:02:24 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Jussi Laako <jussi.laako@kolumbus.fi>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020508100224.C1531@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020507151356.A18701@w-mikek.des.beaverton.ibm.com> <E175DhD-0000HF-00@the-village.bc.nu> <20020507154322.F1537@w-mikek2.des.beaverton.ibm.com> <1020814775.2084.43.camel@bigsur> <20020507164857.G1537@w-mikek2.des.beaverton.ibm.com> <3CD94582.DE18AB99@kolumbus.fi> <1020875500.2078.117.camel@bigsur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 09:31:39AM -0700, Robert Love wrote:
> On Wed, 2002-05-08 at 08:34, Jussi Laako wrote:
> > 
> > Maybe this is the reason why O(1) scheduler has big latencies with
> > pthread_cond_*() functions which original scheduler doesn't have?
> > I think I tracked the problem down to try_to_wake_up(), but I was unable to
> > fix it.
> 
> Ah this could be the same case.  I just looked into the definition of
> the conditional variable pthread stuff and it looks like it _could_ be
> implemented using pipes but I do not see why it would per se.  If it
> does not use pipes, then this sync issue is not at hand (only the pipe
> code passed 1 for the sync flag).
> 
> If it does not use pipes, we could have another problem - but I doubt
> it.  Maybe the benchmark is just another case where it shows worse
> performance due to some attribute of the scheduler or load balancer?
> 

In some cases, the O(1) scheduler will produce higher latencies than
the old scheduler.  On 'some' workloads/benchmarks the old scheduler
was better because it had a greater tendency to schedule tasks on the
same CPU.  This is certainly the case with the lat_ctx and lat_pipe
components of LMbench.  Note that this has nothing to do with the
wake_up sync behavior.  Rather, it is the difference between scheduling
a new task on the current CPU as opposed to a 'remote' CPU.  You can
schedule the task on the current CPU quicker, but this is not good for
optimal cache usage.  I believe the O(1) scheduler makes the correct
trade off in this area.

Is there anything simple I can do to check the latencies of the
pthread_cond_*() functions?  I'd like to do some analysis of 
scheduler behavior, but am unfamiliar with the user level code.

-- 
Mike
