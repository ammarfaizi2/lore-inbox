Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVIVOwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVIVOwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVIVOwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:52:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:4560 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030387AbVIVOwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:52:24 -0400
Date: Thu, 22 Sep 2005 07:52:22 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Tony Lindgren <tony@atomide.com>,
       Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050922145222.GD5910@us.ibm.com>
References: <20050905072704.GB5734@atomide.com> <20050905170202.GJ25856@us.ibm.com> <20050907073743.GB5804@atomide.com> <20050907150517.GC4590@us.ibm.com> <20050908100035.GD25847@atomide.com> <20050908212213.GB2997@us.ibm.com> <20050908220854.GE2997@us.ibm.com> <20050920110654.GA373@in.ibm.com> <20050920145856.GE6589@us.ibm.com> <1127396290.4903.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127396290.4903.43.camel@localhost.localdomain>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.2005 [15:38:10 +0200], Martin Schwidefsky wrote:
> On Tue, 2005-09-20 at 07:58 -0700, Nishanth Aravamudan wrote:
> 
> Hi folks,
> finally found some time to catch up on the dynticks discussion. Quite
> lengthy already..
> 
> > > On Thu, Sep 08, 2005 at 03:08:54PM -0700, Nishanth Aravamudan wrote:
> > > > struct dyntick_timer {
> > > > 	unsigned int state;
> > > > 	unsigned long max_skip;
> > > > 	unsigned long min_skip;
> > > > 	int (*init) (void);
> > > > 	void (*enable_dyn_tick) (void);
> > > > 	void (*disable_dyn_tick) (void);
> > > > 	unsigned long (*reprogram) (unsigned long); /* return number of ticks skipped */
> > > > 	unsigned long (*recover_time) (int, void *, struct pt_regs *); /* handler in arm */
> > > > 	/* following empty in UP */
> > > > 	void (*enter_all_cpus_idle) (int);
> > > > 	void (*exit_all_cpus_idle) (int);
> > > > 	spinlock_t lock;
> > > > };
> > > 
> > > The usage of 'lock' probably needs to be made clear. I intended it to
> > > be used for mainly serializing enter/exit_all_cpus_idle routines.
> > 
> > Yes, now that we are somewhat settled on the structure, I will add
> > comments to the structure in dyn-tick.h and send out patches. Sorry,
> > I've been swamped with other tasks lately...
> 
> As I first saw the dyntick_timer structure I thought: "why does it have
> to be that complicated?". Must be because of the requirements for
>  high-res-timers, since it's overkill for no-idle-hz.

It has become complicated :) HRT does not (yet) use any of this
functionality for their work; Thomas is interested in perhaps doing so
with ktimers, but that is an eventuality, not a guarantee.

Let me try and give an overview of what is in here. Keep in mind that,
for now, we are only aiming for NO_IDLE_HZ in an arch-generic, clean
fashion (not VST, therefore). And, it is certainly reasonable for
certain members to be NULL depending on the arch (like the idle entry
and exit points).

- state: contains the current state of the dynamic-tick subsystem
  (enabled, etc.)
- max_skip, min_skip: the h/w may only be able to skip so far into the
  future (32-bit issues, or other random bit-values), so we need to
  constrain the dynamic-tick subsystem. Initialization code should set
  this value appropriately (on x86 it would depend on what interrupt
  source is eventually selected, e.g.). min_skip exists because it might
  make sense not to go through the hassle of reprogramming when the time
  necessary to reprogram the interrupt is about the same as how long we
  would be disabling the interrupt for.
- init(): arch-dependent initialization routine
- {enable,disable}_dyn_tick(): sysfs hooks so that userspace can disable
  the dynamic-tick subsystem (useful for debugging, mostly?)
- reprogram(): actually interact with whatever arch-dependent underlying
  h/w controls the timer interrupt frequency.
- recover_time(): since we skip ticks, we *must* recover time. Now, one
  option is simply to hook into the normal interrupt path, and I am
  talking with John about the best approach for that (e.g., just have an
  interrupt happen, and *in theory* the time/timer subsystem should be
  capable of recovering from "missed" or "lost" ticks), but for now we
  have a manual callback to catch up.
- {enter,exit}_all_cpus_idle(): some architectures (ahem, x86) may need
  to do additional work, if *all* CPUs go idle (disable the PIT, e.g.).
  This may also be a place for eventual PM code to catch the all going
  idle event and put the processor(s) into a sleep/low-power state.
- lock: guarantee atomicity of the enter/exit idle routines. we only
  want one CPU to be the "last" CPU going idle :)

> > > Considering that not all architectures have such routines, then the
> > > use of spinlock can be entirely within the arch code. Maybe the
> > > 'enter' routine is invoked as part of 'reprogram' routine (when the
> > > last CPU goes down) and 'exit' routine is invoked as part of
> > > dyn_tick_interrupt() (when coming out of all_idle_state), both being
> > > serialized using the spinlock?
> > 
> > I think I suggested this at one point or another :)
> > 
> > The usage I envisioned is
> > 
> > dyntick_timer_reprogram():
> > 
> > current_dyntick_timer->reprogram();
> > if (cpus_full(noidlehz_mask))
> > 	current_dyntick_timer->enter_all_cpus_idle(); // which will lock
> > 					// with
> > 					// current_dyntick_timer->lock,
> > 					// if necessary
> > 
> > dyn_tick_interrupt():
> > 
> > if (cpus_full(noidlehz_mask)) {
> > 	cpu_unset(cpu, noidlehz_mask);
> > 	current_dyntick_timer->exit_all_cpus_idle(); // which will lock
> > 					// with
> > 					// current_dyntick_timer->lock,
> > 					// if necessary
> 
> I would really like to see how all the fields from the dyntick_timer
> structure are supposed to be used. Especially the who-calls-what graph,
> if I got it right then the low-level arch code calls common code
> functions which in turn call functions from the dyntick_timer structure.

Yes, I will try and write this up for you and everyone else. In theory,
since we are only dealing with NO_IDLE_HZ right now, what should happen
is the following (very roughly):

during boot, we of course will initialize the subsystem, which will call
current_dyntick_timer->init().

in cpu_idle() [only?], the arch-dependent idle routine, we call
reprogram_dyntick(), which checks if tick skipping is enabled, finds out
when next_timer_interrupt() thinks the next timer is going to expire is,
and then calls into current_dyntick_timer->reprogram() with the delta
value. We also would check here to see if we are the last CPU to go idle
(see above) and hook into current_dyntick_timer->enter_all_cpus_idle()
if so.

Then, on the interrupt, we would see if we are the first CPU coming back
from idle, and hook into current_dyntick_timer->exit_all_cpus_idle() if
so. We then call current_dyntick_timer->recover_time() to make sure our
time subsystem catches up after missing X ticks. Then we execute the
common code-path for the timer interrupt.

> The question is what should be the connecting points between the arch
> code and the common timer code? With the current code its
> * do_timer()
> * update_process_times()
> * next_timer_event()

So I guess our interaction points would include those three and
cpu_idle(). By next_timer_event() did you mean next_timer_interrupt()?

> and the non-trivial interactions with rcu via
> * test/set/clear bit on nohz_cpu_mask
> * rcu_pending() and friends.

Yes, these are definitely the more complicated interactions.

> > > Another interesting point is that I expected recover_time to be
> > > invoked only as part of 'exit_all_cpus_idle', but s390 seems to 
> > > have unconditional call to account_ticks (for recovering time) on
> > > any CPU that wakes up. I guess it will be a no-op if other CPUs
> > > were active.
> > 
> > Maybe that is just paranoia? In theory, if nothing has happened, then
> > accounting should not need to do anything; but I'm not sure, I'll add
> > this to my "code to look at" list ;)
> 
> After a cpu woke up some code need to check if a tick has passed or not.
> For s390 this is done in the start_hz_timer function called from the
> idle notifier. Even if "nothing" has happened it's not just paranoia,
> account_ticks sets up the clock comparator for the next tick, updates
> xtime if it is necessary and account_user_vtime()/update_process_times()
> for cpu time accounting. It is the exact same function that is used for
> the regular tick interrupts, its just called from a different context.

You are right, and in fact, I mis-wrote when I replied to Vatsa. I think
this is how all archs should treat recover_time(). But doesn't the timer
interrupt already do much of this? I mean, if we were to allow the next
interrupt to occur as usual (maybe forced to be called from our common
dyntick_interrupt()), should time not get caught up that way?

> The reason that xtime and process ticks are done in a single function is
> that s390 doesn't have the distinction between wall-clock timer and
> local APIC timer. Each s390 cpu has something called the clock
> comparator that each cpu can set up individually. Whenever the value of
> the time-of-day (TOD) clock is bigger then the clock comparator the cpu
> gets an external interrupt if the cpu is enabled for the interrupt. This
> timer interrupt source is used for both the xtime updates and the
> process ticks. So there won't be any exit_all_cpus_idle special handling
> for s390.

Ah yes, that's why we are trying to figure out what needs to go into
arch code and what doesn't ;)


> > > We probably also need to document how 'reprogram' will be invoked 
> > > - with xtime_lock held or not. Again s390 does not seem to require it
> > > while ARM is using one. I think we should let the arch code take
> > > xtime_lock if they deem it necessary.
> > 
> > That seems buggy. I'm guessing they need the xtime_lock there just as
> > much as ARM and x86 will. In fact, I'm pretty sure all archs will need
> > it. But I'm fine with leaving it to the arch for now, and then unifying
> > the locking later, if we find that all archs call seq_lock(xtime_lock).
> 
> Why do you need the xtime_lock to reprogram the clock comparator (=local
> APIC timer) for the next timer interrupt? Neither xtime nor jiffies are
> needed to reprogram the timer.

Hrm, you might be right. I might have mis-typed again. At the point
where we are ready to hook into the underlying arch-dependent
current_dyntick_timer->reprogram() routine, we should know the delta
according to next_timer_interrupt(), so we should not need to query
jiffies or xtime anymore...

> > > > extern void dyntick_timer_register(struct dyntick_timer *new_dyntick_timer);
> > > >  /* so do we need this?
> > > >  	Maybe it can just be static to dyntick.c and all the callable
> > > > 	functions will call-down to the structure members? */
> > > > extern struct dyntick_timer *current_dyntick_timer;
> > > 
> > > I don't think this can be static - since the low-level arch-code
> > > will need access to, for example, 'recover_time'/'handler' 
> > > and 'enter/exit_all_cpus_idle' routines?
> > 
> > Ah yes, you are probably right...
> 
> Again the question who-calls-what. 

This is what I get for replying on little sleep. Vatsa, what arch-code
should need access to current_dyntick_timer->recover_time() or the
current_dyntick_timer->{enter,exit}_all_cpus_idle() routines? Ah...maybe
the problem is I removed the generic dyntick_interrupt()? If we have
that function again, we cann call current_dyntick_timer->recover_time()
from there as well as current_dyntick_timer->exit_all_cpus_idle().
current_dyntick_timer->enter_all_cpus_idle() should only need to be
called from reprogram_dyntick().

> > > > extern struct tick_source * __init arch_select_tick_source(void);
> > > > /* calls select_tick_source(), then calls tick_source_register() */
> > > > extern void __init dyn_tick_init(void);
> > > 
> > > Hmm ..I think just tick_source_register is sufficient ..we can do let
> > > the arch-code select what tick source it wants and call register with
> > > the selected source ..
> > 
> > Ok, that is fine by me.
> > 
> > > From a point of getting this reviewed by arch-maintainers, I think it
> > > will help if a new version of this interface is posted and point out
> > > how the existing s390/ARM interfaces will be affected. I could help
> > > out if you are busy.
> > 
> > That would be great. I will try to get your changes merged into what I
> > already have pending for dyn-tick.h to make sure everyone is still in
> > agreement.
> 
> Yes, that would be good. And I will happily review and test the changes
> for s390.

Great! That's good news. Thank you for reviewing what we've gotten
cobbled together so far.

Thanks,
Nish
