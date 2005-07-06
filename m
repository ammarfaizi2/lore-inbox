Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVGFBnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVGFBnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 21:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVGFBnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 21:43:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:57027 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262033AbVGFBmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 21:42:49 -0400
Subject: RE: [patch 1/] timers: tsc using for cpu scheduling
From: john stultz <johnstul@us.ibm.com>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       "Semenikhin, Sergey V" <sergey.v.semenikhin@intel.com>
In-Reply-To: <6EDC9204B3704C4C8522539D5C1185E501A349FA@mssmsx403.ccr.corp.intel.com>
References: <6EDC9204B3704C4C8522539D5C1185E501A349FA@mssmsx403.ccr.corp.intel.com>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 18:42:39 -0700
Message-Id: <1120614159.7673.30.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 21:08 +0400, Ananiev, Leonid I wrote:
> 	Not only page faults may increase process priority. Someone can
> write two threads with mutexes so that each thread will spent much less
> than 1 msec for calculations on cpu than lock-unlock mutexes and yield
> cpu to brother which wait mutex unlock and will do the same. Both
> threads will have high priority according to other threads during
> infinite time. The scheduler will not see the time spent by both
> considered threads on cpu.

Oh, I don't doubt there is a problem. I'm just asking if using the TSC
is really the only way to properly ding the process? 

I'm not a scheduler guy, so forgive my ignorance, but since the TSC may
not be available everywhere, might there be an alternative way to ding
the process? Surely something is keeping track of how many pagefaults a
process causes. Maybe a counter of how many times it has switched off
the cpu within the current tick? Couldn't these values be used as
scheduler weights?

I realize that ideally having super a fine grained notion of how much
cputime every process has had executing would be great. But it isn't
possible everywhere, so what can we do instead?

> 	The cpu scheduler does not need in real time value. It is need
> the number of cpu clocks spent for considered task/thread for priority
> calculation. It is not need to modify TSC tick rate for cpu scheduling.

The problem is that some CPUs give you time, others give you work, and
sometimes those values are related. If you really want to re-define
sched_clock so that it gives you some vague work-unit instead of
nanoseconds, then that's fine, but it will need some additional
documentation and its likely you don't want to use the cycles_2_ns()
functions.

I don't really care too much about changes to sched_clock() as its
always been a special case interface just for the scheduler. I just want
it documented well enough so others don't think its a valid timekeeping
interface.


> 	The TSC can be used for priority calculation in NUMA because we
> do not compare TSCs of different cpu's. 

If you can guarantee that, then great! I know that was the original
intention, but some folks had problems with it which resulting in the
conditional #if NUMA code.


> > there are other cases where the TSC cannot be used for
> > sched_clock, such as on systems that do not have TSCs...
> 
> > You're patch removes any fallback for the case where the TSC cannot be
> used.
> No. Now there is two global kernel values: cyc2ns_scale and use_tsc.
> We may say that
>  	use_tsc = (cyc2ns_scale != 0);
> Now instead of 
>  'if (use_tsc) than ...'
> 					I propose to write
>  'if ((cyc2ns_scale != 0) than...'


That's fine if its what you propose, I just didn't see it in your patch.
As it was written it would have broken NUMAQ and other systems that do
not have usable TSCs (ie: i386/i486).

> > This I don't agree with because there are situations where we cannot
> use
> the TSC.
> 
> The patch says that if there are PMT and TSC timers concurrently than
> Linux will use TSC for CPU scheduler priority calculatin.
> 1 millisecond jiffies on the base of PMT were used patch in Linux before
> this. So user can see that if CPU has TSC it is worst than CPU which has
> not TSC because Linux choose slightly more precise but exactly 1000000
> times more gross variant in this case.

Try re-spinning the patch to address the above issues and I'll happily
review it again. I just want to make sure the issue is addressed
properly and doesn't break other systems.

thanks
-john



