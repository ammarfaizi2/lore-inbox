Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWJDRvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWJDRvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422631AbWJDRvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:51:01 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:63165 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422639AbWJDRvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:51:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=deEKMzWgdv8x2Nq9Y8lK+CmopR6CwHR3BE6zgQTOBCluxqyjr+Su8thLNdAWVF7DixDn7Sm//KRgoVl07P+8xdeMKTisvsBGNqZtJpkCmufta/qOYNb6tKXDcxNR0o1fcbIkijTHcbWoTAN6fkJwVCkqDFqQmu3IEE44xU1Ef70=  ;
From: David Brownell <david-b@pacbell.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [patch 02/23] GTOD: persistent clock support, core
Date: Wed, 4 Oct 2006 10:50:54 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
References: <200610030653.12411.david-b@pacbell.net> <1159903176.1642.45.camel@localhost>
In-Reply-To: <1159903176.1642.45.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041050.55982.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 12:19 pm, john stultz wrote:
> 
> Yea. First, let me apologize for falling off the last thread. I got busy
> with other things and the discussion withered. This patch has been
> re-raised because Thomas finally tripped over the "theoretical" resume
> time ordering bug that I was concerned about.

I recall losing track of what that issue was, and thinking a new explanation
was needed ... no such issues were described in this patch or its summary.


> So, while my first announcement with the patch was something of the
> effect of "Trying to unify the cmos/RTC/whatever interface", due to our
> discussion I'm scaling back that goal.
> 
> Instead the purpose of this is just a continuation of the generic
> timekeeping work. Moving the *existing* arch specific resume timekeeping
> code into generic code,

... which wasn't what that one source code comment implied; quite
the opposite, it assumed all architectures _could_ work that way.


> On arches that have the constraints you list above, a dummy
> read_persistent_clock() that returns zero can be implemented, with a
> comment about why and the RTC_HCTOSYS bits can be used, with no change
> in behavior from what we have now.

Better IMO to use a more traditional run-time function call style
hook, not the link time magic you're now using.  Point is, this
is most accurately a _board_ option not an architectural one.

Even systems that _could_ provide some access to a persistent
clock without relying on IRQs might be designed not to do so.
For example, RTCs integrated into system-on-chip processors
can be less power-efficient than discrete ones, so that when
power-efficient design is essential, that integrated RTC may
not be a viable design option.

And since we expect Linux kernels to be able to run on more
than one board, that includes configurations where one of the
boards uses the integrated register-based RTC, and another
uses a discrete one with serial interface.  But your choice
of link-time binding precludes one kernel handling both boards
correctly...



> > > +/**
> > > + * read_persistent_clock -  Return time in seconds from the persistent clock.
> > > + *
> > > + * Weak dummy function for arches that do not yet support it.
> > > + * Returns seconds from epoch using the battery backed persistent clock.
> > > + * Returns zero if unsupported.
> > > + *
> > > + *  XXX - Do be sure to remove it once all arches implement it.
> > 
> > But not all architectures **CAN** support this notion ...
> 
> That's ok and is the reason why we have a unsupported return option.
> 
> This patch just gives us a path to consolidate what the majority of
> arches do currently.

That XXX comment disagrees ... it assumes all architectures can work
that way ...

And I'm not sure about "majority"; depends how you count.  Certainly
the number of embedded boards that could work differently is large and
growing ... and there are a lot more embedded computers in the world
than desktops, laptops, or servers.


> > > @@ -774,13 +801,23 @@ static int timekeeping_suspended;
> > >  static int timekeeping_resume(struct sys_device *dev)
> > >  {
> > >         unsigned long flags;
> > > +       unsigned long now = read_persistent_clock();
> > 
> > Again: sys_device resume() is called with IRQs disabled, which
> > prevents access to many systems' persistent clocks.  In fact,
> > after posting this example patch
> > 
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=115600629813751&w=2
> 
> 
> Ok, correct me if I'm wrong, though: The only catch, if I understand
> correctly, is that it requires the system in question to have a proper
> RTC driver, which doesn't cover 100% of the arch/platforms supported.
> No?

It's not a "catch" for the systems which have an RTC class driver,
and your approach doesn't cover 100% either.

The key difference between the two approaches is that yours **CANNOT**
handle cases like an I2C based RTC (call them "message based RTCs"), where
the RTC class drivers **CAN** handle "register based RTCs".


> I don't really have an issue w/ the RTC code above, however it does not
> address the current suspend/resume code in the majority of arches. I
> don't know if we're actually in that much conflict here, since I'm
> trying to remove the arch specific suspend/resume timekeeping changes,
> and (to my understanding) so are you.

It's a question of scope, I guess.  You're limiting your solution to
boards that don't require message based RTCs.  I'm thinking that's not
really sufficient ... and it bothers me to see something be pitched
as a basic architectural feature of the clock/time framework when
it's so clearly not sufficient.


> We just have a difference in where we're trying to re-add the code. I'm
> moving the current code into the generic tod path, and you're moving it
> into the RTC driver. Both efforts are consolidating code, so even with
> the minor duplication we have less code then before. So I'm sure as we
> whittle away at this we can find a way to meet in the middle. I think
> this patch moves us forward in that direction.

So long as this GTOD patch is updated to reflect the reality that
not all _boards_ can (or will) support that style of RTC ... cleanup
is good, but those code comments suggest deeper assumptions.


> > I never heard anything more from you on this issue.  Given this
> > particular patch (in $SUBJECT) should I assume you're going to
> > just ignore the issues whereby RTCs ("persistent clocks") can't
> > always meet the no-IRQs-needed assumptions being made here?  Or
> > address isssues like using pointer-to-function instead of using
> > linker tricks?
> 
> In my head I see it like this:
> 
> Currently here is how the timekeeping resume code breaks down:
> 1) timeofday_resume: reset clocksource, NTP
> 2) arch time resume: [set xtime]
> 3) RTC resume: [set xtime]
> 
> Where the [set xtime]s depend on platform config

That is, three different ways to do it.


> I'm trying to just move us to:
> 1) timeofday_resume: reset clocksource, NTP, [set xtime]
> 2) RTC resume: [set xtime]
> 
> Again, where the [set xtime]s depend on platform config

Getting rid of one is useful, yes.  But why not get rid of two?

 
> Then as the RTC drivers gain  coverage, maybe we can start cutting
> timeofday resume down and have something like:
> 1) timeofday_resume: reset clocksource, NTP
> 2) RTC resume: set xtime
> 
> Does this sound like a way forward?

I'm not sure I see how the last two groups are very different;
are you saying it would get rid of these message-unfriendly
read_persistent_clock() calls?

- Dave

