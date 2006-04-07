Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWDGWiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWDGWiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 18:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWDGWiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 18:38:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:30087 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965039AbWDGWiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 18:38:06 -0400
From: Darren Hart <dvhltc@us.ibm.com>
To: Bill Huey (hui) <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Date: Fri, 7 Apr 2006 15:37:37 -0700
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200604052025.05679.darren@dvhart.com> <200604070756.21625.darren@dvhart.com> <20060407210633.GA15971@gnuppy.monkey.org>
In-Reply-To: <20060407210633.GA15971@gnuppy.monkey.org>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604071537.38044.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 14:06, Bill Huey wrote:
> On Fri, Apr 07, 2006 at 07:56:20AM -0700, Darren Hart wrote:
> > The rt-overload mechanism is distinct from load balancing.  RT overload
> > attempts to make sure the NR_CPUS highest priority runnable tasks are
> > running on each of the available CPUs.  This isn't load balancing, this
> > is "system wide strict realtime priority scheduling" (SWSRPS).  This
> > scheduling should take place even if there are 1000 non RT tasks on CPU 0
> > and none on all the others.  The load balancer would be responsible for
> > distributing those 1000 non rt tasks to all the CPUs.
>
> I'm quite aware of what you're saying as well as a much of the contents of
> the -rt patch. Please don't assume that I'm not aware of this. The -rt
> patch doesn't do SWSRPS, but it could with more expensive checking. I'm not
> saying anything against it. In fact, I'm clearly for it if you read the
> other posts. Please read my other posts.


OK First off - let's assume we both read eachothers posts before 
commenting :-)  I'll try to address some of the areas where we seem to be 
talking passed eachother, please let me know if we agree on the following:

First, when I refer to "System Wide Strict Realtime Priority 
Scheduling" (SWSRPS) I mean it in the absolute sense.  There is no "nearly" 
or "almost", it is either SWSRPS or it is not.  Everything else is just load 
balancing (relaxed, aggressive, whatever).  Since it's my term, I get to 
define it ;-) (and if anyone can come up with a better term, please do - 
SWSRPS is admittedly really lame)

My first question to the community was where do we want to end up?  RT 
scheduling on SMP is relatively new and some RT specs don't even address it 
(http://www.rtsj.org for example, see 
http://www.rtsj.org/specjavadoc/sched_overview-summary.html section 
"Semantics and Requirements Governing the Base Scheduler").  It is my belief 
(and I think you agree?) that because Realtime tasks expect deterministic 
behavior, there should be support for SWSRPS in the kernel.

There will be some overhead involved with the SWSRPS implementation, we want 
to minimize that.  The current attempts use IPI which is higher overhead than 
would be ideal.  You mentioned 20 us, less than 10us would be better (subject 
to hardware limitations of course).

CPU binding can be used by the application developer to fine tune a complex 
realtime application and avoid some of the overhead involved with SWSRPS.  
When I read your comments it sounds like you are mentioning this as a new 
feature, which as you know it isn't - so can you rephrase what you mean by 
this?


>
> > > RT applications tend to want explicit control over the scheduling of
> > > the system with as little interference from the kernel as possible. The
> > > general purpose policies (RT rebalancing) of the Linux kernel can
> > > impede RT apps from getting at CPU time more directly.
> >
> > I don't feel that SWSRPS in anyway interferes with realtime applications.
> >  If an application does not explicitly set a cpu affinity, then the
> > kernel should assume the task can run on any CPU and should make SWSRPS
> > decisions accordingly.  In fact, in my experience, applications expect
> > this type of scheduling - and don't consider it an interference.
>
> It will with the IPI forcing the rescheduling. I've seen up to 20 usec hits
> for the IPI on p3 hardware. Some RT might like tighter guarantees. That
> extends the maxium deterministic latency by the time that it does IPI an
> along with the response.

I'm not arguing that SWSRPS won't impose some overhead, it definitely will.  
I'd like to see better than 20us as well.  My points was without it, we don't 
have determinism, and that's a "bad thing".  (We don't have SWSRPS now, I 
understand that, but there is work towards it.).

>
> > Actually the SWSRPS is what makes the scheduling deterministic.  That
> > determinism comes at a cost, but without it it doesn't exist at all on an
> > SMP machine.  So saying it "adds to the maximum deterministic response
> > time" doesn't really make any sense.
>
> Above comments...
>
> > It's my impression (RT folks please pipe up if it's wrong) that if you
> > don't care about priority scheduling (i.e. it's OK for a lower priority
> > task to run while one with a higher priority sits waiting on another
> > queue), then you don't use SCHED_FIFO.  So I don't think case 2 is really
> > valid.
>
> Yeah, this is not good. There's a serious communication disconnect here and
> it's not going to be easily bridged. Please read what I said and think
> about the usage scenarios that I've mentioned more carefully. The -rt patch
> already has this kind of mechanism whether you're aware of this or not
> (unless somethings changed since I last looked). It's not as aggressively
> doing SWSRPS as what you're saying but it serves things nicely for now.

Which mechanism are you referring to?  Do you mean rt_overload?  or the 
load_balancer maybe?  Either way, they do not achieve SWSRPS, but I think the 
rt_overload code is close.

>
> Do you understand this ? The -rt patch has yet to be target for a doing
> strict RT work and your suggestion/patches might be one step closer to that
> goal. 

I think I've addressed that above...

> The counter effect to that is that you're going to effect the general 
> case latency case with SCHED_FIFO via that rescheduling hit "all of the
> time" with IPIs and stuff. I'm 'ok' with that. In fact, that's what I want.

Well, the rt_overload code doesn't kick in unless one or more run_queues has 2 
or more runnable RT tasks.  So it won't be "all the time" - but certainly 
most of the time on any SMP machine running a serious RT application.  And we 
agree, it will impose some overhead - but we want to minimize that.  Perhaps 
some kind of a runtime switch to enable the rt_overload code would be 
appropriate?

> I'm not ok with Ingo creating a new scheduling class to get around that
> aggressive rebalancing policy preserving the current SCHED_FIFO behavior in
> the main line. It's a hack IMO and I'll bet you that nobody cared about
> that behavior in the first place.

I'd prefer not to add another scheduling policy.  Although some might argue 
that a runtime switch for rt_overload is effectively the same thing... I 
might even argue that :-)

>
> I'd much rather see that some kind of SWSRPS go into the main line kernel
> (RT scheduling is pretty goofy already so folks probaby won't mind SWSRPS
> replacing it) 

I agree, and I think Ingo does to, he mentioned wanting to push rt_overload to 
mainline.  Ingo?

> and let thread binding to a CPU restore any loss of latency 
> by bypassing the SWSRPS logic. Are you tracking me ? My concerns here are
> the latency and overhead of SWSRPS and they are definitely significant.

So if an application binds an RT task to a CPU it needs to be excluded from 
some of the SWSRPS logic in order to reduce overhead?  It sounds nice, but 
I'm not sure it's possible unless all the tasks are bound to CPUs.  Take a 4 
CPU system.  Task A is bound to CPU0.  3 other RT tasks are about to become 
runnable, the SWSRPS logic will still have to account for an RT task on CPU0 
so it doesn't get bumped.  What did you have in mind?

>
> > You've made a lot of references to binding tasks to CPUs (or forbidding
> > them, which is essentially a bind to non-forbidden CPUs).  While
> > application developers can certainly take this approach, the linux kernel
> > should schedule realtime tasks globally according to priority in the
> > generic case.
>
> For a default RT oriented kernel, yes, I agree, but that's not what's in
> -rt and it serves the purpose for now. Looser scheduling constraints aren't
> really effecting the current crop of RT applications and that's ok since
> it's a bit fast than a pure SWSRPS solution. For those apps having a more
> general, looser, case semantic doesn't effect things dramatically and might
> even be useful.

OK so you said earlier that:

	> The counter effect to that is that you're going to effect the general 
	> case latency case with SCHED_FIFO via that rescheduling hit "all of 
	> the time" with IPIs and stuff. I'm 'ok' with that. In fact, that's 
	> what I want. 

These two paragraphs appear contradictory to me, it's unclear to me what you 
are trying to accomplish.  Would you like to see SWSRPS in the mainline 
kernel or not?

Has this cleared some things up?  If not, let me know what else needs 
clarification.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
