Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVIVXKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVIVXKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 19:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVIVXKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 19:10:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52152 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751054AbVIVXKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 19:10:04 -0400
Date: Fri, 23 Sep 2005 01:09:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <1127342485.24044.600.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0509221816030.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Sep 2005, Thomas Gleixner wrote:

> > > This revealed a reasonable explanation for this behaviour. Both 
> > > networking and disk I/O arm a lot of timeout timers (the maximum number 
> > > of armed timers during the tests observed was ~400000).
> > 
> > This triggers the obvious question: where are these timers coming from? 
> > You don't think that having that much timers in first place is little 
> > insane (especially if these are kernel timers)?
> 
> Quick answer: Networking and disk I/O. Insane load on a 4 way SMP
> machine. Check yourself. :)

This no answer at all, you only repeat what you already said above. :(
Care to share your knowledge?

First off, I can understand that you're rather upset with what I wrote, 
unfortunately you got overly defensive, so could you please next time 
not reply immediately and first sleep over it, an overly emotional reply 
is funny to read but not exactly useful.
The main problem with your text is that you jump from one topic to the 
next, making it impossible to create a coherent picture from it. Maybe 
it's obvious for you, but I'd like you to fill in these holes to better 
understand the design desicions.

> Actually there are several problems in the timer system:
> 
> 1. HZ/jiffie boundness in the current implementation is problematic vs.
> the conversion of human time units, which is the way programmers think
> and the way time values are defined in data sheets, to HZ/jiffies.

This is an API problem. How is this related to core timer system (and more 
specially to ktimers).

> 2. The all in one solution for "timeouts" and "timers".
> 
> I think I made this point rather clear, but nevertheless:
> 
> Timeouts are coarse grained functions to catch error conditions. The
> vast majority of those never expire. The implementation emphasis is fast
> insertion/removal.
> 
> Timers are (possibly/desirably) fine grained functions to control
> program flow in a time ordered way. The vast majority of those  expire.
> The implementation emphasis is time accuracy. Don't confuse accuracy
> with high resolution! 
> 
> Intermingling those types (1.) /(2.) leads to an obvious conflict in
> interests and to restrictions of extensibility / flexibility especially
> when (3.) applies.

You don't make it obvious at all. You jump from problems with _kernel_ 
timers, to the introduction of a new subsytem to manage _process_ timers.
Why don't you fix the problems with kernel timers separately?
Only because kernel timer require less precision, doesn't mean you can 
make them imprecise. The timer accuracy is defined by the timer source and 
I expect it to be the same for both kernel and process timers.

> 3. There _are_ provable abuses of the current timer ("timeout") system.
> Functions which run longer than the next timer tick have to be
> considered insane.

Fine. Again, how exactly does this problem with _kernel_ timer relate to 
the introduction of ktimers?

> The only places where "ugl*" is used in the whole writeup are:
> "ticks introduce a bunch of ugliness especially when it comes to time
> synchronizing with high resolution time 
> sources."
> 
> "The combination of both patches provides the grounds and leads the way
> to the cleanup of the timeout API and the implementation of
> dyntick/tickless support without introducing additional ugliness."
> 
> I'm sure that both assertions are true, especially in the context they
> were made.

It's nice that you're sure of it, but as long don't provide the means to 
verify them, they are just assertions.
You never really expand on what this "bunch of ugliness" is, you talk 
about timer abusers and API problems, but what is the problem with timer 
ticks related to high resolution timers?
How are dyntick/tickless support and ktimers supposed to share the same 
timer source? This never becomes clear from you document and neither from 
your example code.

> > Basically how does the new big picture look like and how do high 
> > resolution timer fit into it? (You are more busy defending the 64bit math, 
> > than actually explaining why and where it's needed in the first place.)
> 
> I also explained why I wanted to seperate "timeout" and "timers" APIs. I
> explained why I choose rbtree and I explained why I used 64bit math and
> at least why 64 bit math is not that evil as commonly seen. 

I don't say that 64bit math is evil, I just question that it's required - 
small, but important difference.
The main problem with your ktimer patch is that it's another all-in-one 
patch, it simply changes too many aspects at once. If you want to 
introduce a new API, you can do so by first introducing a small layer 
which maps to the old layer. This makes it easier to see and prove any 
potential improvement.

> > Sorry, if this sounds harsh, but your announcement is more a random 
> > collection of information about timers than an explanation of why ktimers 
> > are desirable.
> 
> First of all, this is volunteer work and I _did_ take the time to write
> up a detailed explanation at all rather than throwing a random patch
> with a 10 line bla into the arena. Do you expect that I write a PhD
> thesis on that ?

No, but I hope you didn't just expect hoorray calls. I appreciate that you 
try to explain this, but you should also expect criticism. You make it 
sound I'm doing this just for fun and to annoy you, but I'm trying to keep 
the quality level of Linux up and half finished ideas out of it. There is 
a reason that the answer took a few days, I really thought very carefully 
about this based on your document and patches. It's still possible I 
missed something, but feel free to point this out (preferably in a 
civilized manner).

> Second this writeup was not targeted for John User. ....

Well, I'm not sure whom you targeted, but it wasn't coherent enough for 
the avarage LKML reader (at least for those wanting more than just cursory 
information).

> >  I'm not against high resolution timers per se, but this 
> > doesn't explain why it has to be high resolution all the way. 
> 
> Where is high resolution all the way. Care to read the patch ? It's high
> resolution aware and it does take out odd areas of code by design.

It's not just high resolution aware, it makes all calculation in high 
resolution _unconditionally_, which makes it high resolution all the way.

> > It also doesn't explain how it will interact with Johns work,
> 
> "The following add on patches are not provided for ad hoc inclusion as
> they contain third party patches. The reason for providing this series
> is to demonstrate the future use of ktimers and the simple extensibility
> for the impelemtation of high resolution timers. Especially John Stultz
> timeofday patch is a complete seperate issue
> and just used due to the ability to provide high resolution timers in a
> simple and non intrusive way."
> 
> Isn't this clear enough ?

No and I explained why I think that these are not separate issues at all.

> > Ok, so what's missing? From a basic design overview I would expect some 
> > information about types of time within the kernel and their relationship. 
> > We basically have three types:
> > - scheduler time
> > - wallclock time
> > - process time
> 
> What about monotonic time ?

It's derived from wallclock time.

> > The main difference between them is that the latter is user 
> > programmable. 
> 
> wallclock is reprogrammable too and it introduces a bunch of horrible
> functions in posix-timers.c. grep for abs_list. I explained why its
> horrible already.

I said _user_ programmable, wallclock time is usually NTP controlled.

> > Johns patches now introduce two major new concepts as a generic mechanism 
> > (and not just hidden somewhere in arch code): 1) a timer source 
> > abstraction, 2) making wallclock updates independent of the timer tick. 
> 
> 1. I'm well aware of the addressed problems in Johns patches.
> 
> 2.I dont see any hidden arch code in the ktimers patch. Do you ?

That's not what I meant (and if you had taken the time to think about it, 
instead of just being angry at me, I'm sure you would have noticed 
yourself), this is e.g. about code in arch/i386/kernel/timers/ or 
arch/ppc/kernel/time.c.

> > BTW here you completely miss the "main point of criticizm", the 64bit math 
> > is a problem, but the main problem is that he completely changed the NTP 
> > kernel model. I don't deny that the NTP code could use some updates 
> > itself, but that's a completely separate problem. Regarding the timer 
> > system it's only important how to synchronize NTP time with the kernel 
> > wallclock time, as soon as you get that right, the whole 64bit math 
> > problematic becomes irrelevant.
> 
> Roman, what are you trying to achieve ? Finding a playground for
> rabulistic discussions ?

Ok, I'm at a loss here, what are you trying to tell me? Is the above in 
any way incorrect?

> > The existence of the timer source abstraction is a major requirement for 
> > further improvements (in this regard it's already suspicious, that you put 
> > major changes before Johns patch). 
> 
> Whats suspicious on that ? Seperating the "timeout" API and the "timer"
> API has nothing to do with Johns patches.

Related changes should be done in a logical order, which I'm obviously 
disagree about with you.

> > The next major change would be to add the possibility to reprogram a 
> > timer source, the scheduler can use this to 
> > skip timer ticks and e.g. itimer can offer higher resolution timers. The 
> > main point here is before we get to any API decisions, we need to develop 
> > a model how a single time source can drive multiple users. Your split 
> > between user timers and kernel timeouts leaves this question completely 
> > open.
> 
> Did I claim, that ktimers solve this problem?
> 
> No. 
> 
> The patches are related but address different aspects of the overall
> problem without conflicting with each other. Quite the contrary: they
> complement each other.
> 
> I clearly stated that the reprogramming of timer events, which are not
> addressed by ktimers and I never claimed ktimers does, is a completely
> different problem.

No, it's part of the same problem, how are scheduler and your ktimers 
supposed to share the same time source?

> > The next step (_after_ reprogrammable timer sources) would be increasing 
> > the timer resolution.
> 
> Please let me correct you here. Adding reprogrammable timer events
> before you have the core timer system ready is wrong by design.
> Providing reprogrammable timer events is simple, but when the timer core
> system which depends on timer events is not ready for that you implement
> useless things and implement likely stuff which is not matching the
> requirements of the generic system.

So what are these requirements? Please be more specific.

> >  Here I'm not at all convinced, that we need to 
> > change everything to nanosecond resolution, we can easily make this a 
> > config option which either ties process time resolution to scheduler time 
> > or makes it independent. The first would make process time a 32bit ms 
> > value (basically current behaviour), the latter can make it to a 64bit ns 
> > value. Anyone trying to introduce nsec_t in common code really needs to 
> > come up with some better arguments why calculations in ns are necessary 
> > unconditionally, instead of making the resolution configurable.
> 
> Please provide a whatever time unit based and configurable / flexible
> solution for that instead of making unprovable claims !

What unprovable claims? What would change in the basic principles, if you 
would do them with 32bit ms values instead of 64bit ns values? The basic 
math should be the same and should demonstrate the basic principles 
equally well and since the current timer code has only ms (at HZ=1000) 
precision the behaviour should be the same as well.

> > In summary please provide a larger picture for your changes, it's 
> > especially important to desribe the relationship between the various 
> > systems. The API definition is only the last step and is derived from 
> > these relationships.
> 
> Sorry. When you are not able to get the larger picture in your mind, I
> doubt that you are the right person to discuss this topic. This kind of
> argument is not working with me, especially not when repeated all over
> the place. 
> 
> Please provide an alternative solution (i.e. code to review) yourself.

You seriously trying to tell me, that anyone doing reviews must provide 
alternative solution first?
Please refrain from personal attacks, it should be obvious that we have
different ideas how to implement this, what I'm trying to do is to get you 
to explain your picture better and I'm trying to explain my picture, so we
can understand each other better. We won't get very far as long as you are 
just pissed at me for disagreeing with you.

bye, Roman
