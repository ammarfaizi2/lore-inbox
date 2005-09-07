Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVIGPyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVIGPyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVIGPyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:54:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15302 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932166AbVIGPyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:54:06 -0400
Date: Wed, 7 Sep 2005 08:53:52 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050907155352.GD4590@us.ibm.com>
References: <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com> <20050905064416.GD25856@us.ibm.com> <20050906205112.GA3038@us.ibm.com> <20050907081303.GC5804@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907081303.GC5804@atomide.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.2005 [11:13:04 +0300], Tony Lindgren wrote:
> * Nishanth Aravamudan <nacc@us.ibm.com> [050906 23:55]:
> 
> ...
> 
> > Sigh, later than I had hoped, but here is what I have hashed out so far.
> > Does it seem like a step in the right direction? Rather hand-wavy, but I
> > think it's mostly correct ;)
> 
> Some comments below.

Updated document below.

Thanks,
Nish


- include/linux/timer.h
	with definitions in kernel/timer.c

OR better in
- include/linux/ticksource.h
	with definitions in kernel/ticksource.c?

#define DYN_TICK_ENABLED	(1 << 1)
#define DYN_TICK_SUITABLE	(1 << 0)

#define DYN_TICK_MIN_SKIP	2

/* Abstraction of a tick source
 * @state: current state
 * @max_skip: current maximum number of ticks to skip
 * @init: initialization routine
 * @enable_dyn_tick: called via sysfs to enable interrupt skipping
 * @disable_dyn_tick: called via sysfs to disable interrupt
 * 				skipping
 * @set_all_cpus_idle: last cpu to go idle calls this, which should
 * 				disable any timesource (e.g. PIT on x86)
 * @recover_time: handler for returning from skipped ticks and keeping
 * 				time consistent
 */
struct tick_source {
	unsigned int state;
	unsigned long max_skip;
	int (*init) (void);
	void (*enable_dyn_tick) (void);
	void (*disable_dyn_tick) (void);
	unsigned long (*reprogram) (unsigned long); /* return number of ticks skipped */
	unsigned long (*recover_time) (int, void *, struct pt_regs *); /* handler in arm */
	/* following empty in UP */
	void (*set_all_cpus_idle) (int);
	spinlock_t lock;
};

extern void tick_source_register(struct tick_source *new_tick_source);
extern struct tick_source *current_ticksource;

#ifdef CONFIG_NO_IDLE_HZ /* which means CONFIG_DYNTICK is also on */
extern void set_tick_max_skip(unsigned long max_skip);
/* idle_reprogram_tick calls reprogram_tick calls current_ticksource->reprogram()
 * do we really need the first step? */
extern void idle_reprogram_tick(void);
/* return number of ticks skipped, potentially for accounting purposes? */
extern unsigned long reprogram_tick(void);

extern struct tick_source * __init arch_select_tick_source(void);
extern void __init dyn_tick_init(void); /* calls select_tick_source(), verifies source is usable, then calls tick_source_register() */

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
#include <asm/timer.h> /* or <asm/ticksource.h>, depending */

- sched.c / sched.h
	/* do we want these elsewhere? */
	cpumask_t no_idle_hz_cpumask;

- each arch-specific file pair needs to provide:
	arch_select_tick_source();
	appropriate struct tick_source definitions, functions, etc.

- include/asm-i386/timer.h /* or ticksource.h */
	with defines in arch/i386/timer.c /* or ticksource.c */

- include/asm-arm/arch-omap/timer.h /* or ticksource.h */
	with definitions in arch/arm/mach-omap/timer.c /* or ticksource.c */

- include/asm-s390/timer.h /* or ticksource.h */
	with definitions in arch/s390/timer.c /* or ticksource.c */
