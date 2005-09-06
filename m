Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVIFUvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVIFUvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVIFUvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:51:21 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59870 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750923AbVIFUvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:51:20 -0400
Date: Tue, 6 Sep 2005 13:51:12 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050906205112.GA3038@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com> <20050905064416.GD25856@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905064416.GD25856@us.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.2005 [23:44:16 -0700], Nishanth Aravamudan wrote:
> On 05.09.2005 [12:02:29 +0530], Srivatsa Vaddagiri wrote:
> > On Sun, Sep 04, 2005 at 10:48:13PM -0700, Nishanth Aravamudan wrote:
> > > Admittedly, I don't think SMP ARM has been around all that long?
> > > Maybe the existing code just has not been extended.
> > 
> > Yeah, maybe ARM never cared for SMP. But we do care :)
> 
> I just took a look at arm/Kconfig and SMP is marked as EXPERIMENTAL &&
> BROKEN. So I'm guessing that is the only reason for some of the
> differences you mentioned (the differences are of course, valid and the
> x86 SMP implementation makes sense to me to extend arch-independently).
> 
> > > I'm not sure on this. It's going to be NULL for other architectures,
> > > or end up being called by the reprogram() call for the last CPU to
> > > go idle, right (presuming there isn't a separate TOD source, like in
> > > x86). I think it is better to be in the reprogram() interface.
> > 
> > Non-x86 could have it set to NULL, in which case it doesn't get
> > called.  (I know the current code does not take care of this
> > situation).  But having an explicit 'all_cpus_idle' interface may be
> > good, since Tony talked of idling some devices when all CPUs are idle.
> > So it probably has non-x86/PIT uses too.
> 
> OK, not a problem. I'll try and write up a general intsource.h file
> (interrupt source header) tonight and tomorrow and send it to this list
> to see if everybody agrees on what's in the structure and where the
> arch-independent/dependent line lies.

Sigh, later than I had hoped, but here is what I have hashed out so far.
Does it seem like a step in the right direction? Rather hand-wavy, but I
think it's mostly correct ;)

Thanks,
Nish


- include/linux/intsource.h
	with definitions in kernel/intsource.c

#define DYN_TICK_ENABLED	(1 << 1)
#define DYN_TICK_SUITABLE	(1 << 0)

#define DYN_TICK_MIN_SKIP	2

/* Abstraction of an interrupt source
 * @state: current state
 * @max_skip: current maximum number of ticks to skip
 * @arch_init: initialization routine
 * @arch_enable_dyn_tick: called via sysfs to enable interrupt skipping
 * @arch_disable_dyn_tick: called via sysfs to disable interrupt
 * 				skipping
 * @arch_set_all_cpus_idle: last cpu to go idle calls this, which should
 * 				disable any timesource (e.g. PIT on x86)
 * @arch_recover_time: handler for returning from skipped ticks and keeping
 * 				time consistent
 */
struct interrupt_source {
	unsigned int state;
	unsigned long max_skip;
	int (*arch_init) (void);
	void (*arch_enable_dyn_tick) (void);
	void (*arch_disable_dyn_tick) (void);
	unsigned long (*arch_reprogram) (unsigned long); /* return number of ticks skipped */
	unsigned long (*arch_recover_time) (int, void *, struct pt_regs *); /* handler in arm */
	/* following empty in UP */
	void (*arch_set_all_cpus_idle) (int);
	spinlock_t lock;
};

extern void interrupt_source_register(struct interrupt_source *new_interrupt_source);
extern struct interrupt_source *current_intsource;

#ifdef CONFIG_NO_IDLE_HZ
extern void set_interrupt_max_skip(unsigned long max_skip);
/* idle_reprogram_interrupt calls reprogram_interrupt calls current_intsource->arch_reprogram()
 * do we really need the first step? */
extern void idle_reprogram_interrupt(void);
/* return number of ticks skipped, potentially for accounting purposes? */
extern unsigned long reprogram_interrupt(void);

extern struct interrupt_source * __init arch_select_interrupt_source(void);
extern void __init dyn_tick_init(void); /* calls select_interrupt_source(), verifies source is usable, then calls interrupt_source_register() */

static inline int dyn_tick_enabled(void)
{
	return (current_intsource->state & DYN_TICK_ENABLED);
}

#else	/* CONFIG_NO_IDLE_HZ */
static inline void set_interrupt_max_skip(unsigned long max_skip)
{
}

static inline void idle_reprogram_interrupt(void)
{
}

static inline unsigned long reprogram_interrupt(void)
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
#include <asm/intsource.h>

#endif	/* _DYN_TICK_TIMER_H */

- sched.c / sched.h
	/* do we want these elsewhere? */
	cpumask_t no_idle_hz_cpumask;

* each arch-specific file pair needs to provide:
	arch_select_interrupt_source();
	appropriate struct interrupt_source definitions, functions, etc.

- include/asm-i386/intsource.h
	with defines in arch/i386/intsource.c

- include/asm-arm/arch-omap/intsource.h
	with definitions in arch/arm/mach-omap/intsource.c

- include/asm-s390/intsource.h
	with definitions in arch/s390/intsource.c

- include/asm-generic/intsource.h
	do I need something here?
