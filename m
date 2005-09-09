Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbVIIWaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbVIIWaz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVIIWaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:30:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:42693 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932602AbVIIWay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:30:54 -0400
Date: Fri, 9 Sep 2005 15:30:47 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050909223047.GF4496@us.ibm.com>
References: <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905072704.GB5734@atomide.com> <20050905170202.GJ25856@us.ibm.com> <20050907073743.GB5804@atomide.com> <20050907150517.GC4590@us.ibm.com> <20050908100035.GD25847@atomide.com> <20050908212213.GB2997@us.ibm.com> <20050908220854.GE2997@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908220854.GE2997@us.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.2005 [15:08:54 -0700], Nishanth Aravamudan wrote:
> On 08.09.2005 [14:22:13 -0700], Nishanth Aravamudan wrote:
> > On 08.09.2005 [13:00:36 +0300], Tony Lindgren wrote:
> > > * Nishanth Aravamudan <nacc@us.ibm.com> [050907 18:07]:
> > > > On 07.09.2005 [10:37:43 +0300], Tony Lindgren wrote:
> > > > > * Nishanth Aravamudan <nacc@us.ibm.com> [050905 20:02]:
> > > > > > On 05.09.2005 [10:27:05 +0300], Tony Lindgren wrote:
> > > > > > > * Srivatsa Vaddagiri <vatsa@in.ibm.com> [050905 10:03]:
> > > > > > > > On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > > > > > > > > 
> > > > > > > > > Also, I am a bit confused by the use of "dynamic-tick" to describe these
> > > > > > > > > changes. To me, these are all NO_IDLE_HZ implementations, as they are
> > > > > > > > > only invoked from cpu_idle() (or their equivalent) routines. I know this
> > > > > > > > > is true of s390 and the x86 code, and I believe it is true of the ARM
> > > > > > > > > code? If it were dynamic-tick, I would think we would be adjusting the
> > > > > > > > > timer interrupt frequency continuously (e.g., at the end of
> > > > > > > > > __run_timers() and at every call to {add,mod,del}_timer()). I was
> > > > > > > > > working on a patch which did some renaming to no_idle_hz_timer, etc.,
> > > > > > > > > but it's mostly code churn :)
> > > > > > > > 
> > > > > > > > Yes, the name 'dynamic-tick' is misleading!
> 
> <snipping much useful feedback and many constructive conversations>
> 
> So, after *all* that, I'm going back to dyntick (notice no hyphen though
> :-P). Everyone ok with this doc?
> 
> Thanks,
> Nish
> 
> 
> - include/linux/dyntick.h
> 	with definitions in kernel/dyntick.c
> 
> #define DYN_TICK_ENABLED	(1 << 1)
> #define DYN_TICK_SUITABLE	(1 << 0)
> 
> #define DYN_TICK_MIN_SKIP	2
> 
> /* Abstraction of a dynamic tick source
>  * @state: current state
>  * @max_skip: current maximum number of jiffies to program h/w to skip
>  * @min_skip: current minimum number of jiffies to program h/w to skip
>  * @init: initialization routine
>  * @enable_dyn_tick: called via sysfs to enable interrupt skipping
>  * @disable_dyn_tick: called via sysfs to disable interrupt
>  * 			skipping
>  * @reprogram: actually interact with h/w, return number of ticks the
>  *			h/w will skip
>  * @recover_time: handler for returning from skipped ticks and keeping
>  * 			time consistent
>  * @enter_all_cpus_idle: last cpu to go idle calls this, which should
>  * 			disable any timer source (e.g. PIT on x86)
>  * @exit_all_cpus_idle: first cpu to wake after @enter_all_cpus_idle has
>  *			been called should use this to revert the
>  *			effects of that function
>  */
> struct dyntick_timer {

Ah ha! I think I figured out what my problem was with the naming (I
*just* can't get my head around it). As we added the cpus_idle() hooks,
recover_time() and other non-per-interrupt-source related functionality,
I think it might be best to name this structure:

struct dyntick_control;

indicating it's dynamic tick basis, but that it's used to control the
subsystem.

I think that makes it clear, and keeps it clear why we have
non-"timer" stuff in there. It's also much clearer to me now why we
*don't* need it per-CPU, as we're relying on one set of callbacks for a
subsystem, and not for each CPU's hardware (works out to be the same,
but makes more sense to me that way).

Does that make more sense?

Thanks,
Nish
