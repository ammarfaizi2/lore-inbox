Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWJCTU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWJCTU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030512AbWJCTU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:20:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:7876 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030503AbWJCTUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:20:54 -0400
Subject: Re: [patch 02/23] GTOD: persistent clock support, core
From: john stultz <johnstul@us.ibm.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <200610030653.12411.david-b@pacbell.net>
References: <200610030653.12411.david-b@pacbell.net>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 12:19:36 -0700
Message-Id: <1159903176.1642.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 06:53 -0700, David Brownell wrote:
> > Implement generic timekeeping suspend/resume accounting by introducing 
> > the read_persistent_clock() interface. This is an arch specific 
> > function that returns the seconds since the epoch using the arch 
> > defined battery backed clock.
> 
> I remain unclear what's expected to happen when there IS no such
> architcture-defined clock ... but where the system itself still
> has one, e.g. a board may access one through I2C or SPI once IRQs
> are working normally.

Yea. First, let me apologize for falling off the last thread. I got busy
with other things and the discussion withered. This patch has been
re-raised because Thomas finally tripped over the "theoretical" resume
time ordering bug that I was concerned about.

So, while my first announcement with the patch was something of the
effect of "Trying to unify the cmos/RTC/whatever interface", due to our
discussion I'm scaling back that goal.

Instead the purpose of this is just a continuation of the generic
timekeeping work. Moving the *existing* arch specific resume timekeeping
code into generic code, so we don't get crazy resume ordering issues
splitting the issue of who sets what when between the generic and arch
specific time resume functions.

On arches that have the constraints you list above, a dummy
read_persistent_clock() that returns zero can be implemented, with a
comment about why and the RTC_HCTOSYS bits can be used, with no change
in behavior from what we have now.


> You'll recall that I had pointed out that the drivers/rtc framework
> provides CONFIG_RTC_HCTOSYS, which already unifies quite a lot of
> the "persistent" clocks in the way you described above, but without
> that nasty requirement of working without IRQs enabled.
> 
> 
> > +/**
> > + * read_persistent_clock -  Return time in seconds from the persistent clock.
> > + *
> > + * Weak dummy function for arches that do not yet support it.
> > + * Returns seconds from epoch using the battery backed persistent clock.
> > + * Returns zero if unsupported.
> > + *
> > + *  XXX - Do be sure to remove it once all arches implement it.
> 
> But not all architectures **CAN** support this notion ...

That's ok and is the reason why we have a unsupported return option.

This patch just gives us a path to consolidate what the majority of
arches do currently.


> >  /* 
> >   * timekeeping_init - Initializes the clocksource and common timekeeping values
> >   */
> >  void __init timekeeping_init(void)
> >  {
> >         unsigned long flags;
> > +       unsigned long sec = read_persistent_clock();
> 
> ... and timekeeping_init() is called before I2C or SPI could be used,
> since IRQs aren't enabled yet and accessing those busses can't be
> done in general without IRQs enabled.

Again, that's fine. If the read_persistent_clock is not supported, xtime
will still be zero and can be set later via other methods.


> > @@ -774,13 +801,23 @@ static int timekeeping_suspended;
> >  static int timekeeping_resume(struct sys_device *dev)
> >  {
> >         unsigned long flags;
> > +       unsigned long now = read_persistent_clock();
> 
> Again: sys_device resume() is called with IRQs disabled, which
> prevents access to many systems' persistent clocks.  In fact,
> after posting this example patch
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=115600629813751&w=2


Ok, correct me if I'm wrong, though: The only catch, if I understand
correctly, is that it requires the system in question to have a proper
RTC driver, which doesn't cover 100% of the arch/platforms supported.
No?

I don't really have an issue w/ the RTC code above, however it does not
address the current suspend/resume code in the majority of arches. I
don't know if we're actually in that much conflict here, since I'm
trying to remove the arch specific suspend/resume timekeeping changes,
and (to my understanding) so are you.

We just have a difference in where we're trying to re-add the code. I'm
moving the current code into the generic tod path, and you're moving it
into the RTC driver. Both efforts are consolidating code, so even with
the minor duplication we have less code then before. So I'm sure as we
whittle away at this we can find a way to meet in the middle. I think
this patch moves us forward in that direction.


> I never heard anything more from you on this issue.  Given this
> particular patch (in $SUBJECT) should I assume you're going to
> just ignore the issues whereby RTCs ("persistent clocks") can't
> always meet the no-IRQs-needed assumptions being made here?  Or
> address isssues like using pointer-to-function instead of using
> linker tricks?

In my head I see it like this:

Currently here is how the timekeeping resume code breaks down:
1) timeofday_resume: reset clocksource, NTP
2) arch time resume: [set xtime]
3) RTC resume: [set xtime]

Where the [set xtime]s depend on platform config

I'm trying to just move us to:
1) timeofday_resume: reset clocksource, NTP, [set xtime]
2) RTC resume: [set xtime]

Again, where the [set xtime]s depend on platform config

Then as the RTC drivers gain  coverage, maybe we can start cutting
timeofday resume down and have something like:
1) timeofday_resume: reset clocksource, NTP
2) RTC resume: set xtime

Does this sound like a way forward?

thanks
-john

