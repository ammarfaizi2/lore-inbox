Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWJDTJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWJDTJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWJDTJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:09:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:13002 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750845AbWJDTJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:09:28 -0400
Subject: Re: [patch 02/23] GTOD: persistent clock support, core
From: john stultz <johnstul@us.ibm.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <200610041050.55982.david-b@pacbell.net>
References: <200610030653.12411.david-b@pacbell.net>
	 <1159903176.1642.45.camel@localhost>
	 <200610041050.55982.david-b@pacbell.net>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 12:09:23 -0700
Message-Id: <1159988964.5934.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 10:50 -0700, David Brownell wrote:
> On Tuesday 03 October 2006 12:19 pm, john stultz wrote:
> > 
> > Yea. First, let me apologize for falling off the last thread. I got busy
> > with other things and the discussion withered. This patch has been
> > re-raised because Thomas finally tripped over the "theoretical" resume
> > time ordering bug that I was concerned about.
> 
> I recall losing track of what that issue was, and thinking a new explanation
> was needed ... no such issues were described in this patch or its summary.

Right. So briefly, the resume ordering issue is this: Currently resuming
the timekeeping code is split across both the generic code and the arch
specific code. It wasn't always this way, my earlier GTOD patches had a
similar change, but in my reworking and cutting down of the code to get
it acceptable for mainline I dropped it. 

The assumption I made, was that the generic timekeeping_resume would be
called before the arch specific time resume code runs. And by luck it
does, however I realized shortly afterward that there isn't a strict
ordering to the resume functions and it could happen the other way. With
the dynticks patch, Thomas finally tripped over the issue, and so I got
this patch going again.


> > So, while my first announcement with the patch was something of the
> > effect of "Trying to unify the cmos/RTC/whatever interface", due to our
> > discussion I'm scaling back that goal.
> > 
> > Instead the purpose of this is just a continuation of the generic
> > timekeeping work. Moving the *existing* arch specific resume timekeeping
> > code into generic code,
> 
> ... which wasn't what that one source code comment implied; quite
> the opposite, it assumed all architectures _could_ work that way.

Well to me the comment meant that all arches could implement the
function which would return the persistent time or zero(unsupported).
And I guess I was thinking the arch implementation it would include
comment at to why it returns zero.

But sure, I can understand its confusing and will re-work the wording to
be more clear.

> > On arches that have the constraints you list above, a dummy
> > read_persistent_clock() that returns zero can be implemented, with a
> > comment about why and the RTC_HCTOSYS bits can be used, with no change
> > in behavior from what we have now.
> 
> Better IMO to use a more traditional run-time function call style
> hook, not the link time magic you're now using.  Point is, this
> is most accurately a _board_ option not an architectural one.
> 
> Even systems that _could_ provide some access to a persistent
> clock without relying on IRQs might be designed not to do so.
> For example, RTCs integrated into system-on-chip processors
> can be less power-efficient than discrete ones, so that when
> power-efficient design is essential, that integrated RTC may
> not be a viable design option.
> 
> And since we expect Linux kernels to be able to run on more
> than one board, that includes configurations where one of the
> boards uses the integrated register-based RTC, and another
> uses a discrete one with serial interface.  But your choice
> of link-time binding precludes one kernel handling both boards
> correctly...

Sure, using a function pointer is easy enough to change.

> > > Again: sys_device resume() is called with IRQs disabled, which
> > > prevents access to many systems' persistent clocks.  In fact,
> > > after posting this example patch
> > > 
> > >   http://marc.theaimsgroup.com/?l=linux-kernel&m=115600629813751&w=2
> > 
> > 
> > Ok, correct me if I'm wrong, though: The only catch, if I understand
> > correctly, is that it requires the system in question to have a proper
> > RTC driver, which doesn't cover 100% of the arch/platforms supported.
> > No?
> 
> It's not a "catch" for the systems which have an RTC class driver,
> and your approach doesn't cover 100% either.

True, it doesn't provide a solution for 100% of the systems. But that's
not what I'm shooting for. I'm trying to fix a real bug (the resume
ordering issue), and reduce the arch specific logic.


> The key difference between the two approaches is that yours **CANNOT**
> handle cases like an I2C based RTC (call them "message based RTCs"), where
> the RTC class drivers **CAN** handle "register based RTCs".

Sure. As a long term solution, the RTC method has promise. The patch in
question does not prohibit the RTC work from getting there.

It simply resolves a possible resume ordering bug and allows logic that
already exists in alpha, cris, frv, h8300, i386, ia64, m68k, m68knommu,
mips, parisc, powerpc, ppc, s390...
[deep inhale]
sh, sh64, sparc64, um, v850, x86_64, and xtensa [whew!] to be
consolidated in the generic path.

And the above doesn't challenge your point about there being more
embedded systems then desktops. This patch isn't about one arch or
platform being more important or more common then another, its just a
code duplication and maintenance issue.

> > I don't really have an issue w/ the RTC code above, however it does not
> > address the current suspend/resume code in the majority of arches. I
> > don't know if we're actually in that much conflict here, since I'm
> > trying to remove the arch specific suspend/resume timekeeping changes,
> > and (to my understanding) so are you.
> 
> It's a question of scope, I guess.  You're limiting your solution to
> boards that don't require message based RTCs.  I'm thinking that's not
> really sufficient ... and it bothers me to see something be pitched
> as a basic architectural feature of the clock/time framework when
> it's so clearly not sufficient.

Has an unsupported return code. Does not change existing behavior
(except for fixing the ordering issue). Not a basic architectural
feature. Just a common one we want to handle correctly.

> > We just have a difference in where we're trying to re-add the code. I'm
> > moving the current code into the generic tod path, and you're moving it
> > into the RTC driver. Both efforts are consolidating code, so even with
> > the minor duplication we have less code then before. So I'm sure as we
> > whittle away at this we can find a way to meet in the middle. I think
> > this patch moves us forward in that direction.
> 
> So long as this GTOD patch is updated to reflect the reality that
> not all _boards_ can (or will) support that style of RTC ... cleanup
> is good, but those code comments suggest deeper assumptions.

Sure. I apologize for the confusion.

> > I'm trying to just move us to:
> > 1) timeofday_resume: reset clocksource, NTP, [set xtime]
> > 2) RTC resume: [set xtime]
> > 
> > Again, where the [set xtime]s depend on platform config
> 
> Getting rid of one is useful, yes.  But why not get rid of two?

Sure, but that requires RTC drivers to be written for every arch and
platform first.

> > Then as the RTC drivers gain  coverage, maybe we can start cutting
> > timeofday resume down and have something like:
> > 1) timeofday_resume: reset clocksource, NTP
> > 2) RTC resume: set xtime
> > 
> > Does this sound like a way forward?
> 
> I'm not sure I see how the last two groups are very different;
> are you saying it would get rid of these message-unfriendly
> read_persistent_clock() calls?

I'm open to that. Once the RTC drivers get there. :)

I apologize if this reply seems a bit terse (and more worrying,
combative). That's not the intent. I really do appreciate your review
and feedback. Your point about message based RTCs is solid and I will
keep it in mind as the development continues.

thanks again,
-john

