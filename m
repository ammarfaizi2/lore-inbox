Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVIVNiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVIVNiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbVIVNiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:38:08 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:15501 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030337AbVIVNiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:38:06 -0400
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Tony Lindgren <tony@atomide.com>,
       Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
In-Reply-To: <20050920145856.GE6589@us.ibm.com>
References: <20050904201054.GA4495@us.ibm.com>
	 <20050905070053.GA7329@in.ibm.com> <20050905072704.GB5734@atomide.com>
	 <20050905170202.GJ25856@us.ibm.com> <20050907073743.GB5804@atomide.com>
	 <20050907150517.GC4590@us.ibm.com> <20050908100035.GD25847@atomide.com>
	 <20050908212213.GB2997@us.ibm.com> <20050908220854.GE2997@us.ibm.com>
	 <20050920110654.GA373@in.ibm.com>  <20050920145856.GE6589@us.ibm.com>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 15:38:10 +0200
Message-Id: <1127396290.4903.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 07:58 -0700, Nishanth Aravamudan wrote:

Hi folks,
finally found some time to catch up on the dynticks discussion. Quite
lengthy already..

> > On Thu, Sep 08, 2005 at 03:08:54PM -0700, Nishanth Aravamudan wrote:
> > > struct dyntick_timer {
> > > 	unsigned int state;
> > > 	unsigned long max_skip;
> > > 	unsigned long min_skip;
> > > 	int (*init) (void);
> > > 	void (*enable_dyn_tick) (void);
> > > 	void (*disable_dyn_tick) (void);
> > > 	unsigned long (*reprogram) (unsigned long); /* return number of ticks skipped */
> > > 	unsigned long (*recover_time) (int, void *, struct pt_regs *); /* handler in arm */
> > > 	/* following empty in UP */
> > > 	void (*enter_all_cpus_idle) (int);
> > > 	void (*exit_all_cpus_idle) (int);
> > > 	spinlock_t lock;
> > > };
> > 
> > The usage of 'lock' probably needs to be made clear. I intended it to
> > be used for mainly serializing enter/exit_all_cpus_idle routines.
> 
> Yes, now that we are somewhat settled on the structure, I will add
> comments to the structure in dyn-tick.h and send out patches. Sorry,
> I've been swamped with other tasks lately...

As I first saw the dyntick_timer structure I thought: "why does it have
to be that complicated?". Must be because of the requirements for
high-res-timers, since it's overkill for no-idle-hz.

> > Considering that not all architectures have such routines, then the
> > use of spinlock can be entirely within the arch code. Maybe the
> > 'enter' routine is invoked as part of 'reprogram' routine (when the
> > last CPU goes down) and 'exit' routine is invoked as part of
> > dyn_tick_interrupt() (when coming out of all_idle_state), both being
> > serialized using the spinlock?
> 
> I think I suggested this at one point or another :)
> 
> The usage I envisioned is
> 
> dyntick_timer_reprogram():
> 
> current_dyntick_timer->reprogram();
> if (cpus_full(noidlehz_mask))
> 	current_dyntick_timer->enter_all_cpus_idle(); // which will lock
> 					// with
> 					// current_dyntick_timer->lock,
> 					// if necessary
> 
> dyn_tick_interrupt():
> 
> if (cpus_full(noidlehz_mask)) {
> 	cpu_unset(cpu, noidlehz_mask);
> 	current_dyntick_timer->exit_all_cpus_idle(); // which will lock
> 					// with
> 					// current_dyntick_timer->lock,
> 					// if necessary

I would really like to see how all the fields from the dyntick_timer
structure are supposed to be used. Especially the who-calls-what graph,
if I got it right then the low-level arch code calls common code
functions which in turn call functions from the dyntick_timer structure.
The question is what should be the connecting points between the arch
code and the common timer code? With the current code its
* do_timer()
* update_process_times()
* next_timer_event()
and the non-trivial interactions with rcu via
* test/set/clear bit on nohz_cpu_mask
* rcu_pending() and friends.

> > Another interesting point is that I expected recover_time to be
> > invoked only as part of 'exit_all_cpus_idle', but s390 seems to 
> > have unconditional call to account_ticks (for recovering time) on
> > any CPU that wakes up. I guess it will be a no-op if other CPUs
> > were active.
> 
> Maybe that is just paranoia? In theory, if nothing has happened, then
> accounting should not need to do anything; but I'm not sure, I'll add
> this to my "code to look at" list ;)

After a cpu woke up some code need to check if a tick has passed or not.
For s390 this is done in the start_hz_timer function called from the
idle notifier. Even if "nothing" has happened it's not just paranoia,
account_ticks sets up the clock comparator for the next tick, updates
xtime if it is necessary and account_user_vtime()/update_process_times()
for cpu time accounting. It is the exact same function that is used for
the regular tick interrupts, its just called from a different context.

The reason that xtime and process ticks are done in a single function is
that s390 doesn't have the distinction between wall-clock timer and
local APIC timer. Each s390 cpu has something called the clock
comparator that each cpu can set up individually. Whenever the value of
the time-of-day (TOD) clock is bigger then the clock comparator the cpu
gets an external interrupt if the cpu is enabled for the interrupt. This
timer interrupt source is used for both the xtime updates and the
process ticks. So there won't be any exit_all_cpus_idle special handling
for s390.

> > We probably also need to document how 'reprogram' will be invoked 
> > - with xtime_lock held or not. Again s390 does not seem to require it
> > while ARM is using one. I think we should let the arch code take
> > xtime_lock if they deem it necessary.
> 
> That seems buggy. I'm guessing they need the xtime_lock there just as
> much as ARM and x86 will. In fact, I'm pretty sure all archs will need
> it. But I'm fine with leaving it to the arch for now, and then unifying
> the locking later, if we find that all archs call seq_lock(xtime_lock).

Why do you need the xtime_lock to reprogram the clock comparator (=local
APIC timer) for the next timer interrupt? Neither xtime nor jiffies are
needed to reprogram the timer.

> > > extern void dyntick_timer_register(struct dyntick_timer *new_dyntick_timer);
> > >  /* so do we need this?
> > >  	Maybe it can just be static to dyntick.c and all the callable
> > > 	functions will call-down to the structure members? */
> > > extern struct dyntick_timer *current_dyntick_timer;
> > 
> > I don't think this can be static - since the low-level arch-code
> > will need access to, for example, 'recover_time'/'handler' 
> > and 'enter/exit_all_cpus_idle' routines?
> 
> Ah yes, you are probably right...

Again the question who-calls-what. 

> > > extern struct tick_source * __init arch_select_tick_source(void);
> > > /* calls select_tick_source(), then calls tick_source_register() */
> > > extern void __init dyn_tick_init(void);
> > 
> > Hmm ..I think just tick_source_register is sufficient ..we can do let
> > the arch-code select what tick source it wants and call register with
> > the selected source ..
> 
> Ok, that is fine by me.
> 
> > From a point of getting this reviewed by arch-maintainers, I think it
> > will help if a new version of this interface is posted and point out
> > how the existing s390/ARM interfaces will be affected. I could help
> > out if you are busy.
> 
> That would be great. I will try to get your changes merged into what I
> already have pending for dyn-tick.h to make sure everyone is still in
> agreement.

Yes, that would be good. And I will happily review and test the changes
for s390.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


