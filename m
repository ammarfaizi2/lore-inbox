Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUHQVFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUHQVFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266743AbUHQVEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:04:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:43747 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266741AbUHQVAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:00:46 -0400
Subject: [RFC] New timeofday code
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
In-Reply-To: <1092773633.2429.176.camel@cog.beaverton.ibm.com>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
	 <412151CA.4060902@mvista.com>
	 <Pine.LNX.4.53.0408170851020.15157@gockel.physik3.uni-rostock.de>
	 <1092773244.2429.170.camel@cog.beaverton.ibm.com>
	 <1092773633.2429.176.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1092774271.2429.189.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Aug 2004 13:58:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the first pass of the core code for the time of day overhaul. 
Since the changes affect so much of the kernel, I'm just sending out the
important files. Those files being:

kernel/timeofday.c: core time of day implementation and interfaces
include/linux/timeofday.h: interface definition and helper functions
include/linux/timesource.h: timesource interface definition
drivers/timesource/cyclone.c: example timesource

I'm still heavily working on this, so any comments or suggestions would
be greatly appreciated. 

thanks
-john



=[linux/kernel/timeofday.c]======================================

/*	linux/kernel/timeofday.c
 *
 *	Copyright (C) 2003 IBM
 *
 *  This file contains the functions which access and manage
 *	the system's time of day functionality.
 */


/* TODO:
 *		o NTP functions & testing
 */

#include <linux/timeofday.h>
#include <linux/timesource.h>
#include <linux/ntp.h>

/*XXX - remove later */
#define TIME_DBG 1
#define TIME_DBG_FREQ 120000

/*[Nanosecond based variables]----------------
 * system_time:
 *		Monotonically increasing counter of the number of nanoseconds
 *		since boot.
 * wall_time_offset:
 *		Offset added to system_time to provide accurate time-of-day
 */
static nsec_t system_time;
static nsec_t wall_time_offset;


/*[Cycle based variables]----------------
 * offset_base:
 *		Value of the timesource at the last clock_interrupt_hook()
 */
static cycle_t offset_base;

/*[Time source data]-------------------
 * timesource
 *		current timesource pointer (initialized to timesource_jiffies)
 * next_timesource:
 *		pointer to the timesource that will be installed at the next hook
 */
extern struct timesource_t timesource_jiffies;
static struct timesource_t *timesource = &timesource_jiffies;
static struct timesource_t *next_timesource;

/*[Locks]----------------------------
 * system_time_lock:
 *		generic lock for all locally scoped time values
 */
static seqlock_t system_time_lock = SEQLOCK_UNLOCKED;


/* [XXX - Hacks]--------------------
 *			Makes stuff compile
 */
extern unsigned long get_cmos_time(void);


/* get_lowres_timestamp():
 *		Returns a low res timestamp.
 *		(ie: the value of system_time as  calculated at
 *			the last invocation of clock_interrupt_hook() )
 */
nsec_t get_lowres_timestamp(void)
{
	nsec_t ret;
	unsigned long seq;
	do {
		seq = read_seqbegin(&system_time_lock);

		/* quickly grab system_time*/
		ret = system_time;

	} while (read_seqretry(&system_time_lock, seq));

	return ret;
}

/* get_lowres_timeofday():
 *		Returns a low res time of day, as calculated at the
 *		last invocation of clock_interrupt_hook()
 */
nsec_t get_lowres_timeofday(void)
{
	nsec_t ret;
	unsigned long seq;
	do {
		seq = read_seqbegin(&system_time_lock);

		/* quickly calculate low-res time of day */
		ret = system_time + wall_time_offset;

	} while (read_seqretry(&system_time_lock, seq));

	return ret;
}


/* __monotonic_clock():
 *		private function, must hold system_time_lock lock when being
 *		called. Returns the monotonically increasing number of
 *		nanoseconds	since the system booted (adjusted by NTP scaling)
 */
static nsec_t __monotonic_clock(void)
{
	nsec_t ret, ns_offset;
	cycle_t now, delta;

	/* read timesource */
	now = timesource->read();

	/* calculate the delta since the last clock_interrupt */
	delta = timesource->delta(now, offset_base);

	/* convert to nanoseconds */
	ns_offset = timesource->cyc2ns(delta, 0);

	/* apply the NTP scaling */
	ns_offset = ntp_scale(ns_offset);

	/* add result to system time */
	ret = system_time + ns_offset;

	return ret;
}


/* do_monotonic_clock():
 *		Returns the monotonically increasing number of nanoseconds
 *		since the system booted via __monotonic_clock()
 */
nsec_t do_monotonic_clock(void)
{
	nsec_t ret;
	unsigned long seq;

	/* atomically read __monotonic_clock() */
	do {
		seq = read_seqbegin(&system_time_lock);

		ret = __monotonic_clock();

	} while (read_seqretry(&system_time_lock, seq));

	return ret;
}


/* do_gettimeofday():
 *		Returns the time of day
 */
void do_gettimeofday(struct timeval *tv)
{
	nsec_t wall, sys;
	unsigned long seq;

	/* atomically read wall and sys time */
	do {
		seq = read_seqbegin(&system_time_lock);

		wall = wall_time_offset;
		sys = __monotonic_clock();

	} while (read_seqretry(&system_time_lock, seq));

	/* add them and convert to timeval */
	*tv = ns2timeval(wall+sys);
}


/* do_settimeofday():
 *		Sets the time of day
 */
int do_settimeofday(struct timespec *tv)
{
	/* convert timespec to ns */
	nsec_t newtime = timespec2ns(tv);

	/* atomically adjust wall_time_offset to the desired value */
	write_seqlock_irq(&system_time_lock);

	wall_time_offset = newtime - __monotonic_clock();

	/* clear NTP settings */
	ntp_clear();

	write_sequnlock_irq(&system_time_lock);

	return 0;
}

/* do_adjtimex:
 *		Userspace NTP daemon's interface to the kernel NTP variables
 */
int do_adjtimex(struct timex *tx)
{
	do_gettimeofday(&tx->time); /* set timex->time*/
								/* Note: We set tx->time first, */
								/* because ntp_adjtimex uses it */

	return ntp_adjtimex(tx);			/* call out to NTP code */
}


/* timeofday_interrupt_hook:
 *		calculates the delta since the last interrupt,
 *		updates system time and clears the offset.
 *		likely called by timer_interrupt()
 */
void timeofday_interrupt_hook(void)
{
	cycle_t now, delta, remainder;
	nsec_t ns, ntp_ns;

	write_seqlock(&system_time_lock);

	/* read time source */
	now = timesource->read();

	/* calculate cycle delta */
	delta = timesource->delta(now, offset_base);

	/* convert cycles to ns  and save remainder */
	ns = timesource->cyc2ns(delta, &remainder);

	/* apply NTP scaling factor for this tick */
	ntp_ns = ntp_scale(ns);

#if TIME_DBG /* XXX - remove later*/
{
	static int dbg=0;
	if(!(dbg++%TIME_DBG_FREQ)){
		printk("now: %lluc - then: %lluc = delta: %lluc -> %llu ns + %llu cyc (ntp: %lluc)\n",
			now, offset_base, delta, ns, remainder, ntp_ns);
	}
}
#endif
	/* update system_time */
	system_time += ntp_ns;

	/* reset the offset_base */
	offset_base = now;

	/* subtract remainder to account for rounded off cycles */
	offset_base = timesource->delta(offset_base,remainder);

	/* advance the ntp state machine by ns*/
	ntp_advance(ns);

	/* if necessary, switch timesources */
	if (next_timesource) {
		/* immediately set new offset_base */
		offset_base = next_timesource->read();
		/* swap timesources */
		timesource = next_timesource;
		next_timesource = 0;

		printk(KERN_INFO "Time: %s timesource has been installed\n",
					timesource->name);
	}

	write_sequnlock(&system_time_lock);
}

/* register_timesource():
 *		Used to install a new timesource
 */
void register_timesource(struct timesource_t* t)
{
	write_seqlock(&system_time_lock);

	/* XXX - check override */

	/* if next_timesource has been set, make sure we beat that one too */
	if (next_timesource && (t->priority > next_timesource->priority))
		next_timesource = t;
	else if(t->priority > timesource->priority)
		next_timesource = t;

	write_sequnlock(&system_time_lock);
}


/* timeofday_init():
 *		Initializes time variables
 */
void timeofday_init(void)
{
	write_seqlock(&system_time_lock);

	/* clear and initialize offsets*/
	offset_base = timesource->read();
	wall_time_offset = ((u64)get_cmos_time()) * NSEC_PER_SEC;

	/* clear NTP scaling factor*/
	ntp_clear();

	write_sequnlock(&system_time_lock);

	return;
}


=[include/linux/timeofday.h]======================================
/*	linux/include/linux/timeofday.h
 *
 *	Copyright (C) 2003 IBM
 *
 *	This file contains the interface to the time of day subsystem
 */
#ifndef _LINUX_TIMEOFDAY_H
#define _LINUX_TIMEOFDAY_H
#include <linux/types.h>
#include <linux/time.h>

nsec_t get_lowres_timestamp(void);
nsec_t get_lowres_timeofday(void);
nsec_t do_monotonic_clock(void);


void do_gettimeofday(struct timeval *tv);
int do_settimeofday(struct timespec *tv);
int do_adjtimex(struct timex *tx);

void timeofday_interrupt_hook(void);
void timeofday_init(void);


/* Helper functions */
#define USEC_PER_NSEC 1000;

static inline struct timeval ns2timeval(nsec_t ns)
{
	struct timeval tv;
	tv.tv_sec = div_long_long_rem(ns, NSEC_PER_SEC, &tv.tv_usec);
	tv.tv_usec /= USEC_PER_NSEC;
	return tv;
}

static inline struct timespec ns2timespec(nsec_t ns)
{
	struct timespec ts;
	ts.tv_sec = div_long_long_rem(ns, NSEC_PER_SEC, &ts.tv_nsec);
	return ts;
}

static inline u64 timespec2ns(struct timespec* ts)
{
	nsec_t ret;
	ret = ((nsec_t)ts->tv_sec) * NSEC_PER_SEC;
	ret += ts->tv_nsec;
	return ret;
}

static inline nsec_t timeval2ns(struct timeval* tv)
{
	nsec_t ret;
	ret = ((nsec_t)tv->tv_sec) * NSEC_PER_SEC;
	ret += tv->tv_usec*USEC_PER_NSEC;
	return ret;
}

#endif

=[include/linux/timesource.h]======================================
/*	linux/include/linux/timesource.h
 *
 *	Copyright (C) 2003 IBM
 *
 *	This file contains the structure definitions for timesources. 
 *
 *	If you are not a timesource, or the time of day code, you should
 *	not be including this file.
 */
#ifndef _LINUX_TIMESORUCE_H
#define _LINUX_TIMESORUCE_H

#include <linux/types.h>
#include <linux/time.h>

/* struct timesource_t:
 *		Provides mostly state-free accessors to the underlying
 *		hardware.
 * name:	ptr to timesource name
 * priority:priority value (higher is better)
 * @read:	returns a cycle value
 * @delta:	calculates the difference between two cycle values
 * @cyc2ns:	converts a cycle value to ns (expected to be expensive)
 */
struct timesource_t {
	char* name;
	int priority;
	cycle_t (*read)(void);
	cycle_t (*delta)(cycle_t now, cycle_t then);
	nsec_t (*cyc2ns)(cycle_t cycles, cycle_t* remainder);
};
void register_timesource(struct timesource_t*);

#endif

=[drivers/timesource/cyclone.c]==================================
#include <linux/timesource.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/timex.h>
#include <linux/init.h>

#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/fixmap.h>
#include "mach_timer.h"

#define CYCLONE_CBAR_ADDR 0xFEB00CD0
#define CYCLONE_PMCC_OFFSET 0x51A0
#define CYCLONE_MPMC_OFFSET 0x51D0
#define CYCLONE_MPCS_OFFSET 0x51A8
#define CYCLONE_TIMER_FREQ 100000000
#define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /* 40 bit mask */

unsigned long cyclone_freq_khz;

int use_cyclone = 0;
static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */

/* helper macro to atomically read both cyclone counter registers */
#define read_cyclone_counter(low,high) \
	do{ \
		high = cyclone_timer[1]; low = cyclone_timer[0]; \
	} while (high != cyclone_timer[1]);


static cycle_t cyclone_read(void)
{
	u32 low, high;
	u64 ret;

	read_cyclone_counter(low,high);
	ret = ((u64)high << 32)|low;

	return (cycle_t)ret;
}

static cycle_t cyclone_delta(cycle_t now, cycle_t then)
{
	return (now - then)&CYCLONE_TIMER_MASK;
}

static nsec_t cyclone_cyc2ns(cycle_t cyc, cycle_t* remainder)
{
	u64 rem;
	cyc *= 1000000;
	rem = do_div(cyc, cyclone_freq_khz);
	if (remainder)
		*remainder = rem;
	return (nsec_t)cyc;
}

struct timesource_t timesource_cyclone = {
	.name = "cyclone",
	.priority = 100,
	.read = cyclone_read,
	.delta = cyclone_delta,
	.cyc2ns = cyclone_cyc2ns,
};


static void calibrate_cyclone(void)
{
	u32 startlow, starthigh, endlow, endhigh, delta32;
	u64 start, end, delta64;
	unsigned long i, count;
	/* repeat 3 times to make sure the cache is warm */
	for(i=0; i < 3; i++) {
		mach_prepare_counter();
		read_cyclone_counter(startlow,starthigh);
		mach_countup(&count);
		read_cyclone_counter(endlow,endhigh);
	}
	start = (u64)starthigh<<32|startlow;
	end = (u64)endhigh<<32|endlow;

	delta64 = end - start;
	printk("cyclone delta: %llu\n", delta64);
	delta64 *= (ACTHZ/1000)>>8;
	printk("delta*hz = %llu\n", delta64);
	delta32 = (u32)delta64;
	cyclone_freq_khz = delta32/CALIBRATE_ITERATION;
	printk("calculated cyclone_freq: %lu khz\n", cyclone_freq_khz);
}

static int init_cyclone_timesource(void)
{
	u32* reg;
	u32 base;		/* saved cyclone base address */
	u32 pageaddr;	/* page that contains cyclone_timer register */
	u32 offset;		/* offset from pageaddr to cyclone_timer register */
	int i;

	/*make sure we're on a summit box*/
	if(!use_cyclone) return -ENODEV;

	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");

	/* find base address */
	pageaddr = (CYCLONE_CBAR_ADDR)&PAGE_MASK;
	offset = (CYCLONE_CBAR_ADDR)&(~PAGE_MASK);
	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
	if(!reg){
		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
		return -ENODEV;
	}
	base = *reg;
	if(!base){
		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
		return -ENODEV;
	}

	/* setup PMCC */
	pageaddr = (base + CYCLONE_PMCC_OFFSET)&PAGE_MASK;
	offset = (base + CYCLONE_PMCC_OFFSET)&(~PAGE_MASK);
	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
	if(!reg){
		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
		return -ENODEV;
	}
	reg[0] = 0x00000001;

	/* setup MPCS */
	pageaddr = (base + CYCLONE_MPCS_OFFSET)&PAGE_MASK;
	offset = (base + CYCLONE_MPCS_OFFSET)&(~PAGE_MASK);
	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
	if(!reg){
		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
		return -ENODEV;
	}
	reg[0] = 0x00000001;

	/* map in cyclone_timer */
	pageaddr = (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
	offset = (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
	if(!cyclone_timer){
		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
		return -ENODEV;
	}

	/*quick test to make sure its ticking*/
	for(i=0; i<3; i++){
		u32 old = cyclone_timer[0];
		int stall = 100;
		while(stall--) barrier();
		if(cyclone_timer[0] == old){
			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
			cyclone_timer = 0;
			return -ENODEV;
		}
	}
	calibrate_cyclone();
	register_timesource(&timesource_cyclone);

	return 0;
}

module_init(init_cyclone_timesource);



