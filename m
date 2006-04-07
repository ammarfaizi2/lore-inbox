Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWDGXgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWDGXgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 19:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWDGXgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 19:36:43 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:26512
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S964985AbWDGXgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 19:36:42 -0400
Date: Fri, 7 Apr 2006 16:36:31 -0700
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060407233631.GA17574@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <200604070756.21625.darren@dvhart.com> <20060407210633.GA15971@gnuppy.monkey.org> <200604071537.38044.dvhltc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604071537.38044.dvhltc@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 03:37:37PM -0700, Darren Hart wrote:
> OK First off - let's assume we both read eachothers posts before 
> commenting :-)  I'll try to address some of the areas where we seem to be 
> talking passed eachother, please let me know if we agree on the following:

Right, let's try that, please.

> First, when I refer to "System Wide Strict Realtime Priority 
> Scheduling" (SWSRPS) I mean it in the absolute sense.  There is no "nearly" 
> or "almost", it is either SWSRPS or it is not.  Everything else is just load 
> balancing (relaxed, aggressive, whatever).  Since it's my term, I get to 
> define it ;-) (and if anyone can come up with a better term, please do - 
> SWSRPS is admittedly really lame)

I agree with that terminology. I would have just said "strict priority
across all processors". RTOS systems don't typically have interactive
scheduling policies so that stuff is never even in consideration. In fact,
I'm completely ignoring that in my posts. It doesn't exist in my mental
landscape. I don't care about the load balancer at all, really. RT
scheduling policies are quite difference and serve apps in very different
ways like bandwidth schedulers, etc...

That's why sched-plugin is potentally so important for -rt since the
current crop of -rt scheduling policies are very basic. It's also
important because I don't want somebody's research scheduler included
into the main line either or have to deal churns that force time
consuming prohibitive forward porting of scheduler patches. Different
topic though.

> My first question to the community was where do we want to end up?  RT 
> scheduling on SMP is relatively new and some RT specs don't even address it 
> (http://www.rtsj.org for example, see 
> http://www.rtsj.org/specjavadoc/sched_overview-summary.html section 
> "Semantics and Requirements Governing the Base Scheduler").  It is my belief 
> (and I think you agree?) that because Realtime tasks expect deterministic 
> behavior, there should be support for SWSRPS in the kernel.

Not in the main line kernel, but definitely in -rt. The main line kernel
is very far off from an RTOS and really is a place that doesn't respect
this strict priority policy. It's needed in -rt, arguably badly.

> There will be some overhead involved with the SWSRPS implementation, we want 
> to minimize that.  The current attempts use IPI which is higher overhead than 
> would be ideal.  You mentioned 20 us, less than 10us would be better (subject 
> to hardware limitations of course).

Better to bypass it completely for 0 nanoseconds for some special app cases.

> CPU binding can be used by the application developer to fine tune a complex 
> realtime application and avoid some of the overhead involved with SWSRPS.  
> When I read your comments it sounds like you are mentioning this as a new 
> feature, which as you know it isn't - so can you rephrase what you mean by 
> this?

I'm saying stop using a general purpose mechanism for a situation that
isn't general purpose. The high end of RT apps will do all sorts of tricks
to get that extra performance. What I'm saying to you "KERNEL FOLKS" is to
understand the programming issues behind these RT apps. It's not hard.

I'm having trouble getting folks to understand this problem in a
comprehensive manner. It's not one magic technique, it's a series of
them working together for a particular end goal. Let me find some
papers...linuxdevices.com. The mentality for this discussion is
completely off which is why I'm getting frustrated with it.

> I'm not arguing that SWSRPS won't impose some overhead, it definitely will.  
> I'd like to see better than 20us as well.  My points was without it, we don't 
> have determinism, and that's a "bad thing".  (We don't have SWSRPS now, I 
> understand that, but there is work towards it.).

Yes, I agree, but the only ready for it is the -rt patch set.

> > Yeah, this is not good. There's a serious communication disconnect here and
> > it's not going to be easily bridged. Please read what I said and think
> > about the usage scenarios that I've mentioned more carefully. The -rt patch
> > already has this kind of mechanism whether you're aware of this or not
> > (unless somethings changed since I last looked). It's not as aggressively
> > doing SWSRPS as what you're saying but it serves things nicely for now.
> 
> Which mechanism are you referring to?  Do you mean rt_overload?  or the 
> load_balancer maybe?  Either way, they do not achieve SWSRPS, but I think the 
> rt_overload code is close.

Yeah, rt overload or what ever Ingo calls it. It's "ok" for now. That
means it makes some decisions about distributing the RT load across
which at least allows it to run, but isn't a strictly obeying priority
across processors.

> Well, the rt_overload code doesn't kick in unless one or more run_queues has 2 
> or more runnable RT tasks.  So it won't be "all the time" - but certainly 
> most of the time on any SMP machine running a serious RT application.  And we 
> agree, it will impose some overhead - but we want to minimize that.  Perhaps 
> some kind of a runtime switch to enable the rt_overload code would be 
> appropriate?

Listen to me, "maximum deterministic latency". Do you understand what that
is ? This is what I'm talking about. RTOS folks care about "maximum deterministic
latency" times, are you ? :)

> I'd prefer not to add another scheduling policy.  Although some might argue 
> that a runtime switch for rt_overload is effectively the same thing... I 
> might even argue that :-)
> 
> > I'd much rather see that some kind of SWSRPS go into the main line kernel
> > (RT scheduling is pretty goofy already so folks probaby won't mind SWSRPS
> > replacing it) 
> 
> I agree, and I think Ingo does to, he mentioned wanting to push rt_overload to 
> mainline.  Ingo?

It really should go into -rt. It's needed there and that variant of the
kernel can deliver a time granularity that can respect a strict priority.
Please think in terms of -rt. -rt rules.
 
> > and let thread binding to a CPU restore any loss of latency 
> > by bypassing the SWSRPS logic. Are you tracking me ? My concerns here are
> > the latency and overhead of SWSRPS and they are definitely significant.
> 
> So if an application binds an RT task to a CPU it needs to be excluded from 
> some of the SWSRPS logic in order to reduce overhead?  It sounds nice, but 
> I'm not sure it's possible unless all the tasks are bound to CPUs.  Take a 4 
> CPU system.  Task A is bound to CPU0.  3 other RT tasks are about to become 
> runnable, the SWSRPS logic will still have to account for an RT task on CPU0 
> so it doesn't get bumped.  What did you have in mind?

Let the RT app dudes determine that. Seperate the general case from the
specific RT app case usage. They are completely different things, don't
mix them up in your head. They have to be address differently. I'm
repeating myself, again and again and again... but I'm ok, what ever works. :)

> > For a default RT oriented kernel, yes, I agree, but that's not what's in
> > -rt and it serves the purpose for now. Looser scheduling constraints aren't
> > really effecting the current crop of RT applications and that's ok since
> > it's a bit fast than a pure SWSRPS solution. For those apps having a more
> > general, looser, case semantic doesn't effect things dramatically and might
> > even be useful.
> 
> OK so you said earlier that:
> 
> 	> The counter effect to that is that you're going to effect the general 
> 	> case latency case with SCHED_FIFO via that rescheduling hit "all of 
> 	> the time" with IPIs and stuff. I'm 'ok' with that. In fact, that's 
> 	> what I want. 
> 
> These two paragraphs appear contradictory to me, it's unclear to me what you 
> are trying to accomplish.  Would you like to see SWSRPS in the mainline 
> kernel or not?

No, but I like to see this in -rt definitely. Main line is just too wacked
out to really utilize this properly. Plus, anybody seriously using SCHED_FIFO
on a 2.6 kernel is going to be using -rt anyways.

> Has this cleared some things up?  If not, let me know what else needs 
> clarification.

Yes, but you should really work to clarify terminology. Is this better ?

bill

