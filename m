Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVITO66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVITO66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVITO66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:58:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:25579 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965018AbVITO65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:58:57 -0400
Date: Tue, 20 Sep 2005 07:58:56 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Tony Lindgren <tony@atomide.com>, Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050920145856.GE6589@us.ibm.com>
References: <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905072704.GB5734@atomide.com> <20050905170202.GJ25856@us.ibm.com> <20050907073743.GB5804@atomide.com> <20050907150517.GC4590@us.ibm.com> <20050908100035.GD25847@atomide.com> <20050908212213.GB2997@us.ibm.com> <20050908220854.GE2997@us.ibm.com> <20050920110654.GA373@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920110654.GA373@in.ibm.com>
X-Operating-System: Linux 2.6.13.2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.2005 [16:36:54 +0530], Srivatsa Vaddagiri wrote:
> Nish,
> 	I did some study of how s390 and ARM are architected and have
> some comments as a result of that.
> 
> On Thu, Sep 08, 2005 at 03:08:54PM -0700, Nishanth Aravamudan wrote:
> > struct dyntick_timer {
> > 	unsigned int state;
> > 	unsigned long max_skip;
> > 	unsigned long min_skip;
> > 	int (*init) (void);
> > 	void (*enable_dyn_tick) (void);
> > 	void (*disable_dyn_tick) (void);
> > 	unsigned long (*reprogram) (unsigned long); /* return number of ticks skipped */
> > 	unsigned long (*recover_time) (int, void *, struct pt_regs *); /* handler in arm */
> > 	/* following empty in UP */
> > 	void (*enter_all_cpus_idle) (int);
> > 	void (*exit_all_cpus_idle) (int);
> > 	spinlock_t lock;
> > };
> 
> The usage of 'lock' probably needs to be made clear. I intended it to
> be used for mainly serializing enter/exit_all_cpus_idle routines.

Yes, now that we are somewhat settled on the structure, I will add
comments to the structure in dyn-tick.h and send out patches. Sorry,
I've been swamped with other tasks lately...

> Considering that not all architectures have such routines, then the
> use of spinlock can be entirely within the arch code. Maybe the
> 'enter' routine is invoked as part of 'reprogram' routine (when the
> last CPU goes down) and 'exit' routine is invoked as part of
> dyn_tick_interrupt() (when coming out of all_idle_state), both being
> serialized using the spinlock?

I think I suggested this at one point or another :)

The usage I envisioned is

dyntick_timer_reprogram():

current_dyntick_timer->reprogram();
if (cpus_full(noidlehz_mask))
	current_dyntick_timer->enter_all_cpus_idle(); // which will lock
					// with
					// current_dyntick_timer->lock,
					// if necessary

dyn_tick_interrupt():

if (cpus_full(noidlehz_mask)) {
	cpu_unset(cpu, noidlehz_mask);
	current_dyntick_timer->exit_all_cpus_idle(); // which will lock
					// with
					// current_dyntick_timer->lock,
					// if necessary

> Another interesting point is that I expected recover_time to be
> invoked only as part of 'exit_all_cpus_idle', but s390 seems to 
> have unconditional call to account_ticks (for recovering time) on
> any CPU that wakes up. I guess it will be a no-op if other CPUs
> were active.

Maybe that is just paranoia? In theory, if nothing has happened, then
accounting should not need to do anything; but I'm not sure, I'll add
this to my "code to look at" list ;)

> We probably also need to document how 'reprogram' will be invoked 
> - with xtime_lock held or not. Again s390 does not seem to require it
> while ARM is using one. I think we should let the arch code take
> xtime_lock if they deem it necessary.

That seems buggy. I'm guessing they need the xtime_lock there just as
much as ARM and x86 will. In fact, I'm pretty sure all archs will need
it. But I'm fine with leaving it to the arch for now, and then unifying
the locking later, if we find that all archs call seq_lock(xtime_lock).

> > extern void dyntick_timer_register(struct dyntick_timer *new_dyntick_timer);
> >  /* so do we need this?
> >  	Maybe it can just be static to dyntick.c and all the callable
> > 	functions will call-down to the structure members? */
> > extern struct dyntick_timer *current_dyntick_timer;
> 
> I don't think this can be static - since the low-level arch-code
> will need access to, for example, 'recover_time'/'handler' 
> and 'enter/exit_all_cpus_idle' routines?

Ah yes, you are probably right...

> > extern struct tick_source * __init arch_select_tick_source(void);
> > /* calls select_tick_source(), then calls tick_source_register() */
> > extern void __init dyn_tick_init(void);
> 
> Hmm ..I think just tick_source_register is sufficient ..we can do let
> the arch-code select what tick source it wants and call register with
> the selected source ..

Ok, that is fine by me.

> From a point of getting this reviewed by arch-maintainers, I think it
> will help if a new version of this interface is posted and point out
> how the existing s390/ARM interfaces will be affected. I could help
> out if you are busy.

That would be great. I will try to get your changes merged into what I
already have pending for dyn-tick.h to make sure everyone is still in
agreement.

I think for x86, it's mostly assigning the members of the structure and
perhaps renaming some functions for the PIT/APIC, etc. Same for s390 as
there is only the one timer source. Ideally, the same will hold for ARM,
but it may require some validation.

Thanks again,
Nish
