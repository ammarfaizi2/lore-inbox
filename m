Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVIWI1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVIWI1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVIWI1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:27:04 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21131
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750806AbVIWI1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:27:01 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.61.0509221816030.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509201247190.3743@scrub.home>
	 <1127342485.24044.600.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509221816030.3728@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 23 Sep 2005 10:27:21 +0200
Message-Id: <1127464041.24044.809.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 01:09 +0200, Roman Zippel wrote:
> > Quick answer: Networking and disk I/O. Insane load on a 4 way SMP
> > machine. Check yourself. :)
> 
> This no answer at all, you only repeat what you already said above. :(
> Care to share your knowledge?

Each network connection, each disk I/O operation arms a timeout timer to
cover error conditions. Increasing the load on those increases the
number of armed timers. At the same time this increased load keeps the
timers longer active as it takes more time to detect that the "good"
condition arrived on time.

> You don't make it obvious at all. You jump from problems with _kernel_ 
> timers, to the introduction of a new subsytem to manage _process_ timers.
> Why don't you fix the problems with kernel timers separately?
> Only because kernel timer require less precision, doesn't mean you can 
> make them imprecise. 

I did not make them imprecise. ktimers changes excactly nothing there.

> The timer accuracy is defined by the timer source and 
> I expect it to be the same for both kernel and process timers.

As John pointed out correctly, this is a seperation of time domains. Is
Johns explanation enough ?

> > > Basically how does the new big picture look like and how do high 
> > > resolution timer fit into it? (You are more busy defending the 64bit math, 
> > > than actually explaining why and where it's needed in the first place.)
> > 
> > I also explained why I wanted to seperate "timeout" and "timers" APIs. I
> > explained why I choose rbtree and I explained why I used 64bit math and
> > at least why 64 bit math is not that evil as commonly seen. 
> 
> I don't say that 64bit math is evil, I just question that it's required - 
> small, but important difference.
> The main problem with your ktimer patch is that it's another all-in-one 
> patch, it simply changes too many aspects at once. If you want to 
> introduce a new API, you can do so by first introducing a small layer 
> which maps to the old layer. This makes it easier to see and prove any 
> potential improvement.

I dont see ktimers as an all in one change everything patch. 

It addresses exactly _one_ problem and nothing else. It seperates time
domains and their representation and handling.

I dont see how you want to map this new API to the old layer.

Lets look at the patch:

ktimers.c/h introduce the new API (no change to existing code)

The other files changed are the conversions of the users to this new
API. Mostly small changes except for posix-timers.c, where the abs_list
handling was removed as it was not longer necessary. 

Providing a new API wihtout making use of it and showing the benefits is
rather pointless. I consider the simplification of posix-timers as a
valuable benefit.

> > >  I'm not against high resolution timers per se, but this 
> > > doesn't explain why it has to be high resolution all the way. 
> > 
> > Where is high resolution all the way. Care to read the patch ? It's high
> > resolution aware and it does take out odd areas of code by design.
> 
> It's not just high resolution aware, it makes all calculation in high 
> resolution _unconditionally_, which makes it high resolution all the way.

Please see the other mail explaining 32/64bit issues.

> > > It also doesn't explain how it will interact with Johns work,
> > 
> > "The following add on patches are not provided for ad hoc inclusion as
> > they contain third party patches. The reason for providing this series
> > is to demonstrate the future use of ktimers and the simple extensibility
> > for the impelemtation of high resolution timers. Especially John Stultz
> > timeofday patch is a complete seperate issue
> > and just used due to the ability to provide high resolution timers in a
> > simple and non intrusive way."
> > 
> > Isn't this clear enough ?
> 
> No and I explained why I think that these are not separate issues at all.

These issues are seperate even if ktimers uses values provided by the
time of day subsystem. 

ktimers need the current time in the representation of CLOCK_REALTIME
and CLOCK_MONOTIC. 

ktimers doe not rely on Johns work.  Ktimers can make use of Johns work
as it uses the values provided by the existing timeofday code now. 

The usage is simpler if Johns work is in place. Nothing else.

> > > The main difference between them is that the latter is user 
> > > programmable. 
> > 
> > wallclock is reprogrammable too and it introduces a bunch of horrible
> > functions in posix-timers.c. grep for abs_list. I explained why its
> > horrible already.
> 
> I said _user_ programmable, wallclock time is usually NTP controlled.

I consider sys_adjtimex() and sys_settimeofday() as user interfaces.
Both affect wallclock and therefor affect timers related to wallclock.

> > 2.I dont see any hidden arch code in the ktimers patch. Do you ?
> 
> That's not what I meant (and if you had taken the time to think about it, 
> instead of just being angry at me, I'm sure you would have noticed 
> yourself), this is e.g. about code in arch/i386/kernel/timers/ or 
> arch/ppc/kernel/time.c.

I dont see what you want. The submitted ktimers patch does not contain a
single change to arch/xxx files.

If you refer to the proof of concept high resolution timer
implementation, then I really do not understand why you are insisting on
that. It is proof of concept to verify the usability of the ktimer base
implementation for high resolution timing - nothing more. I used Johns
patches for that proof of concept implementation as they made life
simpler. 

So there is no point in discussing this.

I clearly said that from the beginning. I provided this addon patch
series to give interested developers a possibility to look at it and
compare and contrast it to the existing high resolution timer
implementations. 

> > > The existence of the timer source abstraction is a major requirement for 
> > > further improvements (in this regard it's already suspicious, that you put 
> > > major changes before Johns patch). 
> > 
> > Whats suspicious on that ? Seperating the "timeout" API and the "timer"
> > API has nothing to do with Johns patches.
> 
> Related changes should be done in a logical order, which I'm obviously 
> disagree about with you.

Again. The patches are orthogonal. So where is the logical order ?

> > I clearly stated that the reprogramming of timer events, which are not
> > addressed by ktimers and I never claimed ktimers does, is a completely
> > different problem.
> 
> No, it's part of the same problem, how are scheduler and your ktimers 
> supposed to share the same time source?

<SNIP...>

Admittedly everything which is dealing with aspects of time is related,
but it can and must be seperated into different subsystems, which make
use of the provided interfaces.

1. Time tick

	- constant frequency tick
	
	Provides interface for:
	reading the current tick count

2. Time of day

	- handles frequency adjustments of the timesource
	- keeps track of monotonic time
	- provides the representation of wall clock time
	- handles the adjustment of wall clock time

	Provides interfaces for:
	reading monotonic time
	reading wallclock time
	adjusting the frequency of the time source
	setting wallclock time


	Makes possibly use of the interface:
	(Depends on the availability of time sources)
	time tick:read tick count

3. Timeout API

	- Time tick based timer handling
	- Solely used for in kernel purposes

	Provides interfaces for:
	adding timers
	modifying timers
	deleting timers

	Makes use of the interface:
	time tick:read tick count

4. Timer API

	- monotonic clock based timers
	- realtime (wallclock) clock based timers
	- Mainly intended for application timers

	Provides interfaces for:
	adding timers
	modifying timers
	deleting timers
	
	Makes use of the interfaces:
	timeofday: read monotonic time	
	timeofday: read wallclock time	

So we have four seperate building blocks related to time, but clearly
seperated.

The current implementation in the kernel is providing only 1,2,3. The
timeofday API is somewhat intermingled with the tick code. The Timer API
is implemented with a bunch of workarounds by using the Timeout API.

ktimers provide the seperation of Timeout API and Timer API and therefor
the seperation of the time domains. ktimers do not need any changes to
1,2,3 but can benefit from what ever improvement is made in the
timeofday domain.

Johns patches address the clear seperation of time ticks and time of day
timekeeping and do not affect the timeout API nor ktimers. Once Johns
work is in place the ktimer code simply makes use of the new interfaces.

High resolution timers and dynsmic ticks need this seperations to make
them less intrusive. Of course we need an additional abstraction layer,
which handles the timer event sources.

tglx



