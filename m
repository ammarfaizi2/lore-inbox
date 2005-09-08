Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVIHWI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVIHWI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVIHWI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:08:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:5527 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965026AbVIHWI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:08:57 -0400
Date: Thu, 8 Sep 2005 15:08:54 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050908220854.GE2997@us.ibm.com>
References: <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905072704.GB5734@atomide.com> <20050905170202.GJ25856@us.ibm.com> <20050907073743.GB5804@atomide.com> <20050907150517.GC4590@us.ibm.com> <20050908100035.GD25847@atomide.com> <20050908212213.GB2997@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908212213.GB2997@us.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.2005 [14:22:13 -0700], Nishanth Aravamudan wrote:
> On 08.09.2005 [13:00:36 +0300], Tony Lindgren wrote:
> > * Nishanth Aravamudan <nacc@us.ibm.com> [050907 18:07]:
> > > On 07.09.2005 [10:37:43 +0300], Tony Lindgren wrote:
> > > > * Nishanth Aravamudan <nacc@us.ibm.com> [050905 20:02]:
> > > > > On 05.09.2005 [10:27:05 +0300], Tony Lindgren wrote:
> > > > > > * Srivatsa Vaddagiri <vatsa@in.ibm.com> [050905 10:03]:
> > > > > > > On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > > > > > > > 
> > > > > > > > Also, I am a bit confused by the use of "dynamic-tick" to describe these
> > > > > > > > changes. To me, these are all NO_IDLE_HZ implementations, as they are
> > > > > > > > only invoked from cpu_idle() (or their equivalent) routines. I know this
> > > > > > > > is true of s390 and the x86 code, and I believe it is true of the ARM
> > > > > > > > code? If it were dynamic-tick, I would think we would be adjusting the
> > > > > > > > timer interrupt frequency continuously (e.g., at the end of
> > > > > > > > __run_timers() and at every call to {add,mod,del}_timer()). I was
> > > > > > > > working on a patch which did some renaming to no_idle_hz_timer, etc.,
> > > > > > > > but it's mostly code churn :)
> > > > > > > 
> > > > > > > Yes, the name 'dynamic-tick' is misleading!

<snipping much useful feedback and many constructive conversations>

So, after *all* that, I'm going back to dyntick (notice no hyphen though
:-P). Everyone ok with this doc?

Thanks,
Nish


- include/linux/dyntick.h
	with definitions in kernel/dyntick.c

#define DYN_TICK_ENABLED	(1 << 1)
#define DYN_TICK_SUITABLE	(1 << 0)

#define DYN_TICK_MIN_SKIP	2

/* Abstraction of a dynamic tick source
 * @state: current state
 * @max_skip: current maximum number of jiffies to program h/w to skip
 * @min_skip: current minimum number of jiffies to program h/w to skip
 * @init: initialization routine
 * @enable_dyn_tick: called via sysfs to enable interrupt skipping
 * @disable_dyn_tick: called via sysfs to disable interrupt
 * 			skipping
 * @reprogram: actually interact with h/w, return number of ticks the
 *			h/w will skip
 * @recover_time: handler for returning from skipped ticks and keeping
 * 			time consistent
 * @enter_all_cpus_idle: last cpu to go idle calls this, which should
 * 			disable any timer source (e.g. PIT on x86)
 * @exit_all_cpus_idle: first cpu to wake after @enter_all_cpus_idle has
 *			been called should use this to revert the
 *			effects of that function
 */
struct dyntick_timer {
	unsigned int state;
	unsigned long max_skip;
	unsigned long min_skip;
	int (*init) (void);
	void (*enable_dyn_tick) (void);
	void (*disable_dyn_tick) (void);
	unsigned long (*reprogram) (unsigned long); /* return number of ticks skipped */
	unsigned long (*recover_time) (int, void *, struct pt_regs *); /* handler in arm */
	/* following empty in UP */
	void (*enter_all_cpus_idle) (int);
	void (*exit_all_cpus_idle) (int);
	spinlock_t lock;
};

extern void dyntick_timer_register(struct dyntick_timer *new_dyntick_timer);
 /* so do we need this?
 	Maybe it can just be static to dyntick.c and all the callable
	functions will call-down to the structure members? */
extern struct dyntick_timer *current_dyntick_timer;

#ifdef CONFIG_NO_IDLE_HZ /* which means CONFIG_DYNTICK is also on */
extern void set_dyntick_max_skip(unsigned long max_skip);
extern void set_dyntick_min_skip(unsigned long min_skip);
/* return number of ticks skipped, as we can request any number
	called from cpu_idle() in dyntick-enabled arch's */
extern unsigned long reprogram_dyntick(void);

extern struct tick_source * __init arch_select_tick_source(void);
/* calls select_tick_source(), then calls tick_source_register() */
extern void __init dyn_tick_init(void);

static inline int dyn_tick_enabled(void)
{
	return (current_ticksource->state & DYN_TICK_ENABLED);
}

#else	/* CONFIG_NO_IDLE_HZ */
static inline void set_tick_max_skip(unsigned long max_skip)
{
}

static inline void idle_reprogram_tick(void)
{
}

static inline unsigned long reprogram_tick(void)
{
	return 0;
}

static inline void dyn_tick_init(void)
{
}

static inline int dyn_tick_enabled(void)
{
	return 0;
}
#endif	/* CONFIG_NO_IDLE_HZ */

/* Pick up arch specific header */
#include <asm/dyntick.h>

- timer.c / timer.h
	/* moved from sched.c/.h */
	cpumask_t no_idle_hz_cpumask;

- each arch-specific file pair needs to provide:
	arch_select_tick_source();
	an appropriate struct tick_source definitions, functions, etc. per
		usable h/w

- include/asm-i386/dyntick.h
	with defines in arch/i386/dyntick.c
	/* basically already done */

- include/asm-arm/arch-omap/dyntick.h
	with definitions in arch/arm/mach-omap/dyntick.c

- include/asm-s390/dyntick.h
	with definitions in arch/s390/dyntick.c


