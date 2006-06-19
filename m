Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWFSOFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWFSOFD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWFSOFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:05:03 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:47852 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932382AbWFSOFB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:05:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic  HZ
Date: Tue, 20 Jun 2006 00:03:25 +1000
User-Agent: KMail/1.9.3
Cc: tglx@timesys.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>
References: <1150643426.27073.17.camel@localhost.localdomain> <200606191521.05508.kernel@kolivas.org> <20060619122606.GA19451@elte.hu>
In-Reply-To: <20060619122606.GA19451@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200606200003.26008.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 22:26, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > One of the problems we enountered with dynticks was that using the
> > higher resolution timers such as TSC and HPET to adjust for timer
> > ticks over longer periods when skipping ticks made the overall clock
> > drift when run for many days and only the PM Timer was not prone to
> > this happening. ie the timers were very accurate for short periods but
> > over days it would drift. It could well have been a design flaw in the
> > dynticks I was maintaining rather than the timers themselves but have
> > you checked that this isn't a problem?
>
> not yet. If it's a real problem we could introduce a 'make clock events
> more reliable' framework by doing something like always programming
> clock event sources into periodic mode and reading their current time
> offset [if possible] when the event is processesed (thus compensating
> for most of the drift caused by irq processing latency). But if it's not
> needed it would be nice to avoid that complexity. I'm also wondering why
> the PM timer was the most accurate in that regard - it's almost as slow
> to program as the PIT, so i'd have expected it to to show the biggest
> drift.
>
> (another technique to reduce drift: we could increase the APIC-priority
> of the lapic timer, making it less suspect to drift when there are lots
> of other IRQs going on.)

Better to wait and see if it was an artefact of my dodgy code for recover 
walltime and if this code doesn't have that issue.

> can you think of any other similar 'weird cases' that you saw happen
> with dynticks? For example there's the 'APIC stops timer irqs when
> entering C3 mode' bug - any similar weirdness we should be careful
> about? [right now the patch doesnt handle the C3 mode bug, but it should
> be relatively straightforward to blacklist lapic events in that case]

The hardware that also did C4 was more troublesome but for the same reasons 
since it's a subset of C3. See Dominik's patches mentioned below which 
address these high state transitions. There isn't anything else offhand I can 
think of that I actually managed to track down :|

> i'm looking at dynticks-060227.patch right now, and there seem to be a
> fair amount of dyntick specific changes to ACPI's processor_idle.c code.
> Do you remember what those changes were about and should we pick them up
> in one way or another?

Dominik donated a lot of code to use the dynticks infrastructure to actually 
implement the power savings. Just skipping ticks seemed to make very little 
power difference unless we also used the knowledge from next timer interrupt 
to know how long we are going to be idle and choose C state transitions 
accordingly. Each patch is documented at length in the split out

C-States-1_bm_activity_improvements.patch
C-States-2_bm_activity_handling_improvement.patch
C-States-3_accounting_of_sleep_times.patch
C-States-4_dyn-ticks_tweaks.patch

http://ck.kolivas.org/patches/dyn-ticks/split-out/

> > The other thing I note is that there is a reasonable amount of
> > indirection in fairly hot paths. It looks like there is scope for more
> > local variable storage of these indirect calls. [...]
>
> which function(s) were you looking at when coming to this conclusion?
> clockevents_init_next_event() perhaps? [we could certainly put
> 'sources->nextevent' into a local variable there]

>From what I could see

hrtimer_restart_sched_tick() could use
struct hrtimer *sched_timer = &cpu_base->sched_timer;

clockevents_init_next_event() and clockevents_set_next_event() could use
struct clock_event *nextevt = sources->nextevt;

> > [...] Also if set_next_event is separated from struct clock_event, the
> > whole struct looks like a suitable candidate for __read_mostly.
>
> You mean ->event_handler()? We can make all clockevent instantiations
> __read_mostly right now - all of the fields of clock_event are static,
> even ->event_handler() will change at most once per bootup [when we
> switch from low-res into high-res mode].

Great, thanks!

-- 
-ck
