Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbTHTIPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTHTIOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:14:47 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:44209 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261826AbTHTIK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:10:26 -0400
Date: Wed, 20 Aug 2003 10:05:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
Message-ID: <20030820080513.GB17793@ucw.cz>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C9@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C9@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 05:18:50PM -0700, Pallipadi, Venkatesh wrote:

> Fixmap is for HPET memory map address access. As the timer
> initialization happen 
> early in the boot sequence (before vm initialization), we need to have
> fixmap() 
> and fix_to_virt() to access HPET memory map address.

Ahh, yes, you're right. You can't use ioremap at that time. Actually I
did the same on x86_64 not only because of vsyscalls.

> Yes. Most of the code is generic, and can run on other platforms. The
> only reason 
> I have that check is because, I haven't got chance to test this patch on
> other 
> platforms.
> 
> Thanks,
> -Venkatesh 
> 
> > -----Original Message-----
> > From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
> > Sent: Tuesday, August 19, 2003 3:39 PM
> > To: Pallipadi, Venkatesh
> > Cc: linux-kernel@vger.kernel.org; torvalds@osdl.org; 
> > Nakajima, Jun; Mallick, Asit K
> > Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
> > 
> > 
> > On Tue, Aug 19, 2003 at 12:20:02PM -0700, Pallipadi, Venkatesh wrote:
> > 
> > > 2/5 - hpet2.patch - All the changes required to use HPET in place
> > >                     of PIT as the kernel base-timer at IRQ 0.
> > 
> > What are you using the fixmap() for? i386 doesn't have vsyscalls ...
> > 
> > Why are you limiting the HPET vendor ID to Intel? This code will
> > happily run on other vendor hardware as well ...
> > 
> >  
> > > diff -purN linux-2.6.0-test1/arch/i386/kernel/apic.c 
> > linux-2.6.0-test1-hpet/arch/i386/kernel/apic.c
> > > --- linux-2.6.0-test1/arch/i386/kernel/apic.c	
> > 2003-07-13 20:39:27.000000000 -0700
> > > +++ linux-2.6.0-test1-hpet/arch/i386/kernel/apic.c	
> > 2003-08-13 11:36:24.000000000 -0700
> > > @@ -34,6 +34,7 @@
> > >  #include <asm/pgalloc.h>
> > >  #include <asm/desc.h>
> > >  #include <asm/arch_hooks.h>
> > > +#include <asm/hpet.h>
> > >  
> > >  #include <mach_apic.h>
> > >  
> > > @@ -749,7 +750,8 @@ static unsigned int __init get_8254_time
> > >  	return count;
> > >  }
> > >  
> > > -void __init wait_8254_wraparound(void)
> > > +/* next tick in 8254 can be caught by catching timer wraparound */
> > > +static void __init wait_8254_wraparound(void)
> > >  {
> > >  	unsigned int curr_count, prev_count=~0;
> > >  	int delta;
> > > @@ -771,6 +773,12 @@ void __init wait_8254_wraparound(void)
> > >  }
> > >  
> > >  /*
> > > + * Default initialization for 8254 timers. If we use other 
> > timers like HPET,
> > > + * we override this later 
> > > + */
> > > +void (*wait_timer_tick)(void) = wait_8254_wraparound;
> > > +
> > > +/*
> > >   * This function sets up the local APIC timer, with a timeout of
> > >   * 'clocks' APIC bus clock. During calibration we actually call
> > >   * this function twice on the boot CPU, once with a bogus timeout
> > > @@ -811,7 +819,7 @@ static void setup_APIC_timer(unsigned in
> > >  	/*
> > >  	 * Wait for IRQ0's slice:
> > >  	 */
> > > -	wait_8254_wraparound();
> > > +	wait_timer_tick();
> > >  
> > >  	__setup_APIC_LVTT(clocks);
> > >  
> > > @@ -854,7 +862,7 @@ int __init calibrate_APIC_clock(void)
> > >  	 * (the current tick might have been already half done)
> > >  	 */
> > >  
> > > -	wait_8254_wraparound();
> > > +	wait_timer_tick();
> > >  
> > >  	/*
> > >  	 * We wrapped around just now. Let's start:
> > > @@ -867,7 +875,7 @@ int __init calibrate_APIC_clock(void)
> > >  	 * Let's wait LOOPS wraprounds:
> > >  	 */
> > >  	for (i = 0; i < LOOPS; i++)
> > > -		wait_8254_wraparound();
> > > +		wait_timer_tick();
> > >  
> > >  	tt2 = apic_read(APIC_TMCCT);
> > >  	if (cpu_has_tsc)
> > > diff -purN linux-2.6.0-test1/arch/i386/kernel/time.c 
> > linux-2.6.0-test1-hpet/arch/i386/kernel/time.c
> > > --- linux-2.6.0-test1/arch/i386/kernel/time.c	
> > 2003-07-13 20:34:29.000000000 -0700
> > > +++ linux-2.6.0-test1-hpet/arch/i386/kernel/time.c	
> > 2003-08-18 12:36:25.000000000 -0700
> > > @@ -60,6 +60,8 @@
> > >  #include <linux/timex.h>
> > >  #include <linux/config.h>
> > >  
> > > +#include <asm/hpet.h>
> > > +
> > >  #include <asm/arch_hooks.h>
> > >  
> > >  #include "io_ports.h"
> > > @@ -298,6 +300,12 @@ void __init time_init(void)
> > >  	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> > >  	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
> > >  
> > > +#ifdef CONFIG_HPET_TIMER
> > > +	if (hpet_enable() >= 0) {
> > > +		printk("Using HPET for base-timer\n");
> > > +	}
> > > +#endif
> > > +
> > >  	cur_timer = select_timer();
> > >  	time_init_hook();
> > >  }
> > > diff -purN linux-2.6.0-test1/arch/i386/kernel/time_hpet.c 
> > linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c
> > > --- linux-2.6.0-test1/arch/i386/kernel/time_hpet.c	
> > 1969-12-31 16:00:00.000000000 -0800
> > > +++ linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c	
> > 2003-08-18 20:22:06.000000000 -0700
> > > @@ -0,0 +1,153 @@
> > > +/*
> > > + *  linux/arch/i386/kernel/time_hpet.c
> > > + *  This code largely copied from arch/x86_64/kernel/time.c
> > > + *  See that file for credits.
> > > + *
> > > + *  2003-06-30    Venkatesh Pallipadi - Additional changes 
> > for HPET support
> > > + */
> > > +
> > > +#include <linux/errno.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/param.h>
> > > +#include <linux/string.h>
> > > +#include <linux/init.h>
> > > +#include <linux/smp.h>
> > > +
> > > +#include <asm/timer.h>
> > > +#include <asm/fixmap.h>
> > > +#include <asm/apic.h>
> > > +
> > > +#include <linux/timex.h>
> > > +#include <linux/config.h>
> > > +
> > > +#include <asm/hpet.h>
> > > +
> > > +unsigned long hpet_period;	/* fsecs / HPET clock */
> > > +unsigned long hpet_tick;	/* hpet clks count per tick */
> > > +unsigned long hpet_address;	/* hpet memory map address */
> > > +
> > > +static int use_hpet; 		/* can be used for 
> > runtime check of hpet */
> > > +static int boot_hpet_disable; 	/* boottime override 
> > for HPET timer */
> > > +
> > > +#define FSEC_TO_USEC (1000000000UL)
> > > +
> > > +#ifdef CONFIG_X86_LOCAL_APIC
> > > +/*
> > > + * HPET counters dont wrap around on every tick. They just 
> > change the 
> > > + * comparator value and continue. Next tick can be caught 
> > by checking 
> > > + * for a change in the comparator value. Used in apic.c.
> > > + */
> > > +void __init wait_hpet_tick(void)
> > > +{
> > > +	unsigned int start_cmp_val, end_cmp_val;
> > > +
> > > +	start_cmp_val = hpet_readl(HPET_T0_CMP);
> > > +	do {
> > > +		end_cmp_val = hpet_readl(HPET_T0_CMP);
> > > +	} while (start_cmp_val == end_cmp_val);
> > > +}
> > > +#endif
> > > +
> > > +/*
> > > + * Check whether HPET was found by ACPI boot parse. If yes 
> > setup HPET 
> > > + * counter 0 for kernel base timer. 
> > > + */
> > > +int __init hpet_enable(void)
> > > +{
> > > +	unsigned int cfg, id;
> > > +	unsigned long tick_fsec_low, tick_fsec_high; /* tick in 
> > femto sec */
> > > +	unsigned long hpet_tick_rem;
> > > +
> > > +	if (boot_hpet_disable)
> > > +		return -1;
> > > +
> > > +	if (!hpet_address) {
> > > +		return -1;
> > > +	}
> > > +	set_fixmap_nocache(FIX_HPET_BASE, hpet_address);
> > > +	printk(KERN_INFO "HPET enabled at %#lx\n", hpet_address);
> > > +
> > > +	/*
> > > +	 * Read the period, compute tick and quotient.
> > > +	 */
> > > +	id = hpet_readl(HPET_ID);
> > > +
> > > +	/*
> > > +	 * We are checking for value '1' or more in number field. 
> > > +	 * So, we are OK with HPET_EMULATE_RTC part too, where we need
> > > +	 * to have atleast 2 timers.
> > > +	 */
> > > +	if (!(id & HPET_ID_NUMBER) ||
> > > +	    !(id & HPET_ID_LEGSUP))
> > > +		return -1;
> > > +
> > > +	if (((id & HPET_ID_VENDOR) >> HPET_ID_VENDOR_SHIFT) != 
> > > +				HPET_ID_VENDOR_8086)
> > > +		return -1;
> > > +
> > > +	hpet_period = hpet_readl(HPET_PERIOD);
> > > +	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > 
> > HPET_MAX_PERIOD))
> > > +		return -1;
> > > +
> > > +	/*
> > > +	 * 64 bit math
> > > +	 * First changing tick into fsec
> > > +	 * Then 64 bit div to find number of hpet clk per tick
> > > +	 */
> > > +	ASM_MUL64_REG(tick_fsec_low, tick_fsec_high, 
> > > +			KERNEL_TICK_USEC, FSEC_TO_USEC);
> > > +	ASM_DIV64_REG(hpet_tick, hpet_tick_rem, 
> > > +			hpet_period, tick_fsec_low, tick_fsec_high);
> > > +
> > > +	if (hpet_tick_rem > (hpet_period >> 1))
> > > +		hpet_tick++; /* rounding the result */
> > > +
> > > +	/*
> > > +	 * Stop the timers and reset the main counter.
> > > +	 */
> > > +	cfg = hpet_readl(HPET_CFG);
> > > +	cfg &= ~HPET_CFG_ENABLE;
> > > +	hpet_writel(cfg, HPET_CFG);
> > > +	hpet_writel(0, HPET_COUNTER);
> > > +	hpet_writel(0, HPET_COUNTER + 4);
> > > +
> > > +	/*
> > > +	 * Set up timer 0, as periodic with first interrupt to 
> > happen at 
> > > +	 * hpet_tick, and period also hpet_tick.
> > > +	 */
> > > +	cfg = hpet_readl(HPET_T0_CFG);
> > > +	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | 
> > > +	       HPET_TN_SETVAL | HPET_TN_32BIT;
> > > +	hpet_writel(cfg, HPET_T0_CFG);
> > > +	hpet_writel(hpet_tick, HPET_T0_CMP);
> > > +
> > > +	/*
> > > + 	 * Go!
> > > + 	 */
> > > +	cfg = hpet_readl(HPET_CFG);
> > > +	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
> > > +	hpet_writel(cfg, HPET_CFG);
> > > +
> > > +	use_hpet = 1;
> > > +#ifdef CONFIG_X86_LOCAL_APIC
> > > +	wait_timer_tick = wait_hpet_tick;
> > > +#endif
> > > +	return 0;
> > > +}
> > > +
> > > +int is_hpet_enabled(void)
> > > +{
> > > +	return use_hpet;
> > > +}
> > > +
> > > +static int __init hpet_setup(char* str)
> > > +{
> > > +	if (str) {
> > > +		if (!strncmp("disable", str, 7))
> > > +			boot_hpet_disable = 1;
> > > +	}
> > > +	return 1;
> > > +}
> > > +
> > > +__setup("hpet=", hpet_setup);
> > > +
> > > diff -purN linux-2.6.0-test1/include/asm-i386/apic.h 
> > linux-2.6.0-test1-hpet/include/asm-i386/apic.h
> > > --- linux-2.6.0-test1/include/asm-i386/apic.h	
> > 2003-07-13 20:38:53.000000000 -0700
> > > +++ linux-2.6.0-test1-hpet/include/asm-i386/apic.h	
> > 2003-08-13 11:34:37.000000000 -0700
> > > @@ -64,6 +64,8 @@ static inline void ack_APIC_irq(void)
> > >  	apic_write_around(APIC_EOI, 0);
> > >  }
> > >  
> > > +extern void (*wait_timer_tick)(void);
> > > +
> > >  extern int get_maxlvt(void);
> > >  extern void clear_local_APIC(void);
> > >  extern void connect_bsp_APIC (void);
> > > diff -purN linux-2.6.0-test1/include/asm-i386/fixmap.h 
> > linux-2.6.0-test1-hpet/include/asm-i386/fixmap.h
> > > --- linux-2.6.0-test1/include/asm-i386/fixmap.h	
> > 2003-07-13 20:29:30.000000000 -0700
> > > +++ linux-2.6.0-test1-hpet/include/asm-i386/fixmap.h	
> > 2003-08-14 13:10:31.000000000 -0700
> > > @@ -44,6 +44,9 @@
> > >  enum fixed_addresses {
> > >  	FIX_HOLE,
> > >  	FIX_VSYSCALL,
> > > +#ifdef CONFIG_HPET_TIMER
> > > +	FIX_HPET_BASE,
> > > +#endif
> > >  #ifdef CONFIG_X86_LOCAL_APIC
> > >  	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for 
> > SMP or not */
> > >  #endif
> > > diff -purN linux-2.6.0-test1/include/asm-i386/hpet.h 
> > linux-2.6.0-test1-hpet/include/asm-i386/hpet.h
> > > --- linux-2.6.0-test1/include/asm-i386/hpet.h	
> > 1969-12-31 16:00:00.000000000 -0800
> > > +++ linux-2.6.0-test1-hpet/include/asm-i386/hpet.h	
> > 2003-08-18 20:22:40.000000000 -0700
> > > @@ -0,0 +1,104 @@
> > > +
> > > +#ifndef _I386_HPET_H
> > > +#define _I386_HPET_H
> > > +
> > > +#ifdef CONFIG_HPET_TIMER
> > > +
> > > +#include <linux/errno.h>
> > > +#include <linux/module.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/param.h>
> > > +#include <linux/string.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/time.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/init.h>
> > > +#include <linux/smp.h>
> > > +
> > > +#include <asm/io.h>
> > > +#include <asm/smp.h>
> > > +#include <asm/irq.h>
> > > +#include <asm/msr.h>
> > > +#include <asm/delay.h>
> > > +#include <asm/mpspec.h>
> > > +#include <asm/uaccess.h>
> > > +#include <asm/processor.h>
> > > +
> > > +#include <linux/timex.h>
> > > +#include <linux/config.h>
> > > +
> > > +#include <asm/fixmap.h>
> > > +
> > > +/*
> > > + * Documentation on HPET can be found at:
> > > + *      http://www.intel.com/ial/home/sp/pcmmspec.htm
> > > + *      ftp://download.intel.com/ial/home/sp/mmts098.pdf
> > > + */
> > > +
> > > +#define HPET_ID		0x000
> > > +#define HPET_PERIOD	0x004
> > > +#define HPET_CFG	0x010
> > > +#define HPET_STATUS	0x020
> > > +#define HPET_COUNTER	0x0f0
> > > +#define HPET_T0_CFG	0x100
> > > +#define HPET_T0_CMP	0x108
> > > +#define HPET_T0_ROUTE	0x110
> > > +#define HPET_T1_CFG	0x120
> > > +#define HPET_T1_CMP	0x128
> > > +#define HPET_T1_ROUTE	0x130
> > > +#define HPET_T2_CFG	0x140
> > > +#define HPET_T2_CMP	0x148
> > > +#define HPET_T2_ROUTE	0x150
> > > +
> > > +#define HPET_ID_VENDOR	0xffff0000
> > > +#define HPET_ID_LEGSUP	0x00008000
> > > +#define HPET_ID_NUMBER	0x00001f00
> > > +#define HPET_ID_REV	0x000000ff
> > > +
> > > +#define HPET_ID_VENDOR_SHIFT	16
> > > +#define HPET_ID_VENDOR_8086	0x8086
> > > +
> > > +#define HPET_CFG_ENABLE	0x001
> > > +#define HPET_CFG_LEGACY	0x002
> > > +
> > > +#define HPET_TN_ENABLE		0x004
> > > +#define HPET_TN_PERIODIC	0x008
> > > +#define HPET_TN_PERIODIC_CAP	0x010
> > > +#define HPET_TN_SETVAL		0x040
> > > +#define HPET_TN_32BIT		0x100
> > > +
> > > +/* Use our own asm for 64 bit multiply/divide */
> > > +#define ASM_MUL64_REG(eax_out,edx_out,reg_in,eax_in) 	
> > 		\
> > > +		__asm__ __volatile__("mull %2" 			
> > 	\
> > > +				:"=a" (eax_out), "=d" (edx_out) 
> > 	\
> > > +				:"r" (reg_in), "0" (eax_in))
> > > +
> > > +#define 
> > ASM_DIV64_REG(eax_out,edx_out,reg_in,eax_in,edx_in) 		\
> > > +		__asm__ __volatile__("divl %2" 			
> > 	\
> > > +				:"=a" (eax_out), "=d" (edx_out) 
> > 	\
> > > +				:"r" (reg_in), "0" (eax_in), 
> > "1" (edx_in))
> > > +
> > > +#define hpet_readl(a)		
> > readl(fix_to_virt(FIX_HPET_BASE) + a)
> > > +#define hpet_writel(d,a)	writel(d, 
> > fix_to_virt(FIX_HPET_BASE) + a)
> > > +
> > > +#define KERNEL_TICK_USEC 	(1000000UL/HZ)	/* tick value 
> > in microsec */
> > > +/* Max HPET Period is 10^8 femto sec as in HPET spec */
> > > +#define HPET_MAX_PERIOD (100000000UL)
> > > +/*
> > > + * Min HPET period is 10^5 femto sec just for safety. If 
> > it is less than this, 
> > > + * then 32 bit HPET counter wrapsaround in less than 0.5 sec. 
> > > + */
> > > +#define HPET_MIN_PERIOD (100000UL)
> > > +
> > > +extern unsigned long hpet_period;	/* fsecs / HPET clock */
> > > +extern unsigned long hpet_tick;  	/* hpet clks count per tick */
> > > +extern unsigned long hpet_address;	/* hpet memory map address */
> > > +extern unsigned long hpet_virt_address;	/* hpet kernel 
> > virtual address */
> > > +
> > > +extern int hpet_enable(void);
> > > +extern int is_hpet_enabled(void);
> > > +
> > > +#endif /* CONFIG_HPET_TIMER */
> > > +#endif /* _I386_HPET_H */
> > > diff -purN linux-2.6.0-test1/include/asm-i386/mc146818rtc.h 
> > linux-2.6.0-test1-hpet/include/asm-i386/mc146818rtc.h
> > > --- linux-2.6.0-test1/include/asm-i386/mc146818rtc.h	
> > 2003-07-13 20:36:37.000000000 -0700
> > > +++ linux-2.6.0-test1-hpet/include/asm-i386/mc146818rtc.h	
> > 2003-08-18 20:23:43.000000000 -0700
> > > @@ -24,6 +24,10 @@ outb_p((addr),RTC_PORT(0)); \
> > >  outb_p((val),RTC_PORT(1)); \
> > >  })
> > >  
> > > +#ifdef CONFIG_HPET_TIMER
> > > +#define RTC_IRQ 0
> > > +#else
> > >  #define RTC_IRQ 8
> > > +#endif
> > >  
> > >  #endif /* _ASM_MC146818RTC_H */
> > > diff -purN 
> > linux-2.6.0-test1/Documentation/kernel-parameters.txt 
> > linux-2.6.0-test1-hpet/Documentation/kernel-parameters.txt
> > > --- linux-2.6.0-test1/Documentation/kernel-parameters.txt   
> >     2003-07-13 20:39:36.000000000 -0700
> > > +++ 
> > linux-2.6.0-test1-hpet/Documentation/kernel-parameters.txt  
> > 2003-08-18 20:37:41.000000000 -0700
> > > @@ -212,7 +212,10 @@ running once the system is up.
> > > 			when calculating gettimeofday(). If 
> > specicified timesource
> > > 			is not avalible, it defaults to PIT. 
> > > 			Format: { pit | tsc | cyclone | ... }
> > > -
> > > +
> > > +	hpet=		[IA-32,HPET] option to disable HPET and use PIT.
> > > +			Format: disable
> > > +
> > > 	cm206=		[HW,CD]
> > > 			Format: { auto | [<io>,][<irq>] }
> > >  
> > > 
> > > 
> > 
> > 
> > 
> > -- 
> > Vojtech Pavlik
> > SuSE Labs, SuSE CR
> > 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
