Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVAMTev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVAMTev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVAMTev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:34:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50932 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261329AbVAMTXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:23:48 -0500
Message-ID: <41E6CAAA.4040804@mvista.com>
Date: Thu, 13 Jan 2005 11:23:22 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: VST patches ported to 2.6.11-rc1
References: <20050113132641.GA4380@elf.ucw.cz>
In-Reply-To: <20050113132641.GA4380@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> I really hate sf download system... Here are those patches (only
> common+i386) ported to 2.6.11-rc1.
> 
> BTW why is linux-net@vger listed as maintainer of HRT?

Oops, should be linux-kernel...

If you could send these as seperate attachments (4 different patches, me 
thinks), I will put them in the CVS system and on the site.

Thanks
> 
> 								Pavel
> 
> --- clean-mm/MAINTAINERS	2005-01-12 11:11:56.000000000 +0100
> +++ linux-mm/MAINTAINERS	2005-01-13 14:10:49.000000000 +0100
> @@ -936,6 +936,12 @@
>  W:	http://drama.obuda.kando.hu/~fero/cgi-bin/hgafb.shtml
>  S:	Maintained
>  
> +High-Res-Timers (HRT) extension to Posix Clocks & Timers
> +P:	George Anzinger
> +M:	george@mvista.com
> +L:	linux-net@vger.kernel.org
> +S:	Supported
> +
>  HIGH-SPEED SCC DRIVER FOR AX.25
>  P:	Klaus Kudielka
>  M:	klaus.kudielka@ieee.org
> --- clean-mm/arch/i386/Kconfig	2005-01-12 11:12:01.000000000 +0100
> +++ linux-mm/arch/i386/Kconfig	2005-01-13 14:20:00.000000000 +0100
> @@ -437,6 +437,17 @@
>  	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
>  	default y
>  
> +choice
> +	prompt "Clock & Timer Selection"
> +	default LEGACY_TIMER
> +	help
> +	  You may have either HPET, High Resolution, or Legacy timer support.
> +
> +config LEGACY_TIMER
> +	bool "Legacy Timer Support"
> +	help
> +	  This chooses the legacy 8254 (PIT) for timer support.
> +
>  config HPET_TIMER
>  	bool "HPET Timer Support"
>  	help
> @@ -446,12 +457,165 @@
>  	  activated if the platform and the BIOS support this feature.
>  	  Otherwise the 8254 will be used for timing services.
>  
> -	  Choose N to continue using the legacy 8254 timer.
> +config HIGH_RES_TIMERS
> +	bool "High Resolution Timer Support"
> +	help
> +	  This option enables high resolution POSIX clocks and timers with 
> +	  resolution of at least 1 microsecond.  High resolution timers are not
> +	  free, a small overhead is incurred each time a timer that does not
> +	  expire on a 1/HZ tick boundary is used.  If no such timers are used
> +	  the overhead is nil.  
> +
> +	  The POSIX clocks CLOCK_REALTIME and CLOCK_MONOTONIC are available by 
> +	  default.  This option enables two additional clocks, CLOCK_REALTIME_HR
> +	  and CLOCK_MONOTONIC_HR.  Note that this option does not change the
> +	  resolution of CLOCK_REALTIME or CLOCK_MONOTONIC, which remain at 1/HZ
> +	  resolution.
> +
> +endchoice
> +
> +choice
> +	prompt "High Resolution Timer clock source"
> +	depends on HIGH_RES_TIMERS
> +	default HIGH_RES_TIMER_TSC
> +	help 
> +	  This option allows you to choose the wall clock timer for your
> +	  system.  With high resolution timers on the x86 platforms it
> +	  is best to keep the interrupt-generating timer separate from
> +	  the time-keeping timer.  On x86 platforms there are two
> +	  possible sources implemented for the wall clock.  These are:
> + 
> +	  <timer>				<resolution>
> +	  ACPI power management (pm) timer	~280 nanoseconds
> +	  TSC (Time Stamp Counter)		1/CPU clock
> +
> +	  The PIT is always used to generate clock interrupts, but in
> +	  SMP systems the APIC timers are used to drive the timer list
> +	  code.  This means that in SMP systems the PIT will not be
> +	  programmed to generate sub jiffie events and can give
> +	  reasonable service as the clock interrupt. In non-SMP (UP)
> +	  systems it will be programmed to interrupt when the next timer
> +	  is to expire or on the next 1/HZ tick.
> +
> +	  The TSC runs at the CPU clock rate (i.e. its resolution is
> +	  1/CPU clock) and it has a very low access time.  However, it
> +	  is subject, in some (incorrect) processors, to throttling to
> +	  cool the CPU, and to other slowdowns during power management.
> +	  If your system has power managment code active these changes
> +	  are tracked by the TSC timer code.  If your CPU is correct and
> +	  does not change the TSC frequency for throttling or power
> +	  management outside of the power managment kernel code, this is
> +	  the best clock timer.
> +
> +	  The ACPI pm timer is available on systems with Advanced
> +	  Configuration and Power Interface support.  The pm timer is
> +	  available on these systems even if you don't use or enable
> +	  ACPI in the software or the BIOS (but see Default ACPI pm
> +	  timer address).  The timer has a resolution of about 280
> +	  nanoseconds, however, the access time is a bit higher than
> +	  that of the TSC.  Since it is part of ACPI it is intended to
> +	  keep track of time while the system is under power management,
> +	  thus it is not subject to the power management problems of the
> +	  TSC.
> +
> +	  If you enable the ACPI pm timer and it cannot be found, it is
> +	  possible that your BIOS is not producing the ACPI table or
> +	  that your machine does not support ACPI.  In the former case,
> +	  see "Default ACPI pm timer address".  If the timer is not
> +	  found the boot will fail when trying to calibrate the 'delay'
> +	  loop.
> +
> +config HIGH_RES_TIMER_ACPI_PM
> +	bool "ACPI-pm-timer"
> +	
> +config HIGH_RES_TIMER_TSC
> +	bool "Time-stamp-counter/TSC"
> +	depends on X86_TSC
> +	  
> +endchoice
> +
> +config HIGH_RES_RESOLUTION
> +	int "High Resolution Timer resolution (nanoseconds)"
> +	depends on HIGH_RES_TIMERS
> +	default 1000
> +	help
> +	  This sets the resolution in nanoseconds of the CLOCK_REALTIME_HR and
> +	  CLOCK_MONOTONIC_HR timers.  Too fine a resolution (small a number)
> +	  will usually not be observable due to normal system latencies.  For an
> +          800 MHz processor about 10,000 (10 microseconds) is recommended as a
> +	  finest resolution.  If you don't need that sort of resolution,
> +	  larger values may generate less overhead.
> +
> +config HIGH_RES_TIMER_ACPI_PM_ADD
> +	int "Default ACPI pm timer address"
> +	depends on HIGH_RES_TIMER_ACPI_PM
> +	default 0
> +	help
> +	  This option is available for use on systems where the BIOS
> +	  does not generate the ACPI tables if ACPI is not enabled.  For
> +	  example some BIOSes will not generate the ACPI tables if APM
> +	  is enabled.  The ACPI pm timer is still available but cannot
> +	  be found by the software.  This option allows you to supply
> +	  the needed address.  When the high resolution timers code
> +	  finds a valid ACPI pm timer address it reports it in the boot
> +	  messages log (look for lines that begin with
> +	  "High-res-timers:").  You can turn on the ACPI support in the
> +	  BIOS, boot the system and find this value.  You can then enter
> +	  it at configure time.  Both the report and the entry are in
> +	  decimal.
>  
>  config HPET_EMULATE_RTC
>  	bool "Provide RTC interrupt"
>  	depends on HPET_TIMER && RTC=y
>  
> +config VST
> +	bool "Provide Variable idle Sleep Time"
> +        depends on X86_GOOD_APIC
> +	help
> +
> +	  CONFIG_VST: This option causes a scan of the timer list when
> +	  ever the system is about to go idle.  If no "immediate" timers
> +	  are pending, the tick interrupt is turned off and an interrupt
> +	  is scheduled for when the next timer expires.  Thus an idle
> +	  system is not interrupted by useless timer ticks.  The
> +	  definition of "immediate" and other useful information is
> +	  available at /proc/sys/kernel/vst.
> +
> +          The system boots with VST enabled and it can be disabled by:
> +	  "echo 0 > /proc/sys/kernel/vst/enable".
> +
> +config VST_STATS
> +	bool "Provide VST timer info via /proc"
> +	depends on VST && PROC_FS
> +	help
> +
> +	  CONFIG_VST_STATS: This option turns on code that collects
> +	  information in a circular buffer on timers which are incurred
> +	  while entering, or attempting to enter the VST state.  This
> +	  information is useful if you are trying to figure out why the
> +	  system is not entering the VST state.  See
> +	  Documentation/vst.txt for more information on what is
> +	  displayed and how to interpret the information.  Say NO here
> +	  unless you are trying to optimize VST entry.
> +
> +config IDLE
> +	bool "Provide IDLE call back functions"
> + 	help
> +
> +	  CONFIG_IDLE: This option provides the IDLE notify facility.
> +	  Registered functions will be called when ever the system is
> +	  about to go idle and when the system exits the idle task.  It
> +	  is expected that callers may change timers and other such
> +	  things so as to more fully use the VST capability (see above).
> +
> +	  The system boots with IDLE notify disabled.  It can be enabled
> +	  by "echo 1 > /proc/sys/kernel/idle/enable".  Other information
> +	  is also available at /proc/sys/kernel/idle/*.
> +
> +	  This capability does not affect the system unless it is
> +	  enabled AND one or more functions have registered to be
> +	  called.
> +
>  config SMP
>  	bool "Symmetric multi-processing support"
>  	---help---
> --- clean-mm/arch/i386/kernel/Makefile	2004-12-25 15:51:02.000000000 +0100
> +++ linux-mm/arch/i386/kernel/Makefile	2005-01-13 14:20:00.000000000 +0100
> @@ -30,6 +30,7 @@
>  obj-y				+= sysenter.o vsyscall.o
>  obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
>  obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
> +obj-$(CONFIG_VST)		+= vst.o
>  obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
>  
> --- clean-mm/arch/i386/kernel/apic.c	2005-01-12 11:12:01.000000000 +0100
> +++ linux-mm/arch/i386/kernel/apic.c	2005-01-13 14:20:00.000000000 +0100
> @@ -34,11 +34,19 @@
>  #include <asm/desc.h>
>  #include <asm/arch_hooks.h>
>  #include <asm/hpet.h>
> +#include <linux/hrtime.h>
> +#include <linux/vst.h>
>  
>  #include <mach_apic.h>
>  
>  #include "io_ports.h"
>  
> +#ifndef CONFIG_HIGH_RES_TIMERS
> +#define compute_latch(a)
> +#else
> +extern void apic_timer_ipi_interrupt(struct pt_regs regs);
> +#endif
> +
>  /*
>   * Debug level
>   */
> @@ -69,6 +77,9 @@
>  {
>  #ifdef CONFIG_SMP
>  	smp_intr_init();
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	set_intr_gate(LOCAL_TIMER_IPI_VECTOR, apic_timer_ipi_interrupt);
> +#endif
>  #endif
>  	/* self generated IPI for local APIC timer */
>  	set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
> @@ -88,7 +99,7 @@
>  
>  static DEFINE_PER_CPU(int, prof_multiplier) = 1;
>  static DEFINE_PER_CPU(int, prof_old_multiplier) = 1;
> -static DEFINE_PER_CPU(int, prof_counter) = 1;
> +DEFINE_PER_CPU(int, prof_counter) = 1; /* used by high-res-timers thus global*/
>  
>  static int enabled_via_apicbase;
>  
> @@ -909,13 +920,23 @@
>   */
>  
>  #define APIC_DIVISOR 16
> -
> +/*
> + * For high res timers we want a single shot timer.
> + * This means, for profiling, that we must load it each
> + * interrupt, but it works best for timers as a one shot and
> + * it is little overhead for the profiling which, we hope is
> + * not done that often, nor on production machines.
> + */
>  void __setup_APIC_LVTT(unsigned int clocks)
>  {
>  	unsigned int lvtt_value, tmp_value, ver;
>  
>  	ver = GET_APIC_VERSION(apic_read(APIC_LVR));
> -	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
> +	lvtt_value = 
> +#ifndef CONFIG_HIGH_RES_TIMERS
> +		APIC_LVT_TIMER_PERIODIC | 
> +#endif
> +		LOCAL_TIMER_VECTOR;
>  	if (!APIC_INTEGRATED(ver))
>  		lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
>  	apic_write_around(APIC_LVTT, lvtt_value);
> @@ -1041,6 +1062,8 @@
>  	 */
>  	setup_APIC_timer(calibration_result);
>  
> +	compute_latch(calibration_result / APIC_DIVISOR);
> +
>  	local_irq_enable();
>  }
>  
> @@ -1114,6 +1137,10 @@
>  inline void smp_local_timer_interrupt(struct pt_regs * regs)
>  {
>  	int cpu = smp_processor_id();
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	if (! per_cpu(prof_counter, cpu))
> +		do_hr_timer_int();
> +#endif
>  
>  	profile_tick(CPU_PROFILING, regs);
>  	if (--per_cpu(prof_counter, cpu) <= 0) {
> @@ -1133,11 +1160,18 @@
>  					per_cpu(prof_counter, cpu));
>  			per_cpu(prof_old_multiplier, cpu) =
>  						per_cpu(prof_counter, cpu);
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +			return;
> +#endif
>  		}
> -
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +		apic_write_around(APIC_TMICT, calibration_result /
> +				  per_cpu(prof_counter, cpu));
> +#else
>  #ifdef CONFIG_SMP
>  		update_process_times(user_mode(regs));
>  #endif
> +#endif
>  	}
>  
>  	/*
> @@ -1181,10 +1215,42 @@
>  	 * interrupt lock, which is the WrongThing (tm) to do.
>  	 */
>  	irq_enter();
> +	vst_wakeup(regs, 1);
>  	smp_local_timer_interrupt(regs);
>  	irq_exit();
>  }
>  
> +#if defined(CONFIG_SMP) && defined(CONFIG_HIGH_RES_TIMERS)
> +/*
> + * This code ONLY takes IPI interrupts from the PIT interrupt handler
> + */
> +fastcall void smp_apic_timer_ipi_interrupt(struct pt_regs *regs)
> +{
> +	int cpu = smp_processor_id();
> +
> +	/*
> +	 * the NMI deadlock-detector uses this.
> +	 */
> +	irq_stat[cpu].apic_timer_irqs++;
> +
> +	/*
> +	 * NOTE! We'd better ACK the irq immediately,
> +	 * because timer handling can be slow.
> +	 */
> +	ack_APIC_irq();
> +	/*
> +	 * update_process_times() expects us to have done irq_enter().
> +	 * Besides, if we don't timer interrupts ignore the global
> +	 * interrupt lock, which is the WrongThing (tm) to do.
> +	 */
> +	irq_enter();
> +	vst_wakeup(regs, 0);
> +	update_process_times(user_mode(regs));
> +	irq_exit();
> +	
> +}
> +#endif
> +
>  /*
>   * This interrupt should _never_ happen with our APIC/SMP architecture
>   */
> --- clean-mm/arch/i386/kernel/io_apic.c	2004-12-25 15:51:05.000000000 +0100
> +++ linux-mm/arch/i386/kernel/io_apic.c	2005-01-13 14:20:00.000000000 +0100
> @@ -1155,6 +1155,7 @@
>  
>  static struct hw_interrupt_type ioapic_level_type;
>  static struct hw_interrupt_type ioapic_edge_type;
> +static struct hw_interrupt_type ioapic_edge_type_irq0;
>  
>  #define IOAPIC_AUTO	-1
>  #define IOAPIC_EDGE	0
> @@ -1166,15 +1167,19 @@
>  		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
>  				trigger == IOAPIC_LEVEL)
>  			irq_desc[vector].handler = &ioapic_level_type;
> -		else
> +		else if (vector)
>  			irq_desc[vector].handler = &ioapic_edge_type;
> +		else
> +			irq_desc[vector].handler = &ioapic_edge_type_irq0;
>  		set_intr_gate(vector, interrupt[vector]);
>  	} else	{
>  		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
>  				trigger == IOAPIC_LEVEL)
>  			irq_desc[irq].handler = &ioapic_level_type;
> -		else
> +		else if (irq)
>  			irq_desc[irq].handler = &ioapic_edge_type;
> +		else
> +			irq_desc[irq].handler = &ioapic_edge_type_irq0;
>  		set_intr_gate(vector, interrupt[irq]);
>  	}
>  }
> @@ -1286,7 +1291,7 @@
>  	 * The timer IRQ doesn't have to know that behind the
>  	 * scene we have a 8259A-master in AEOI mode ...
>  	 */
> -	irq_desc[0].handler = &ioapic_edge_type;
> +	irq_desc[0].handler = &ioapic_edge_type_irq0;
>  
>  	/*
>  	 * Add it to the IO-APIC irq-routing table:
> @@ -1976,6 +1981,23 @@
>  	.set_affinity 	= set_ioapic_affinity,
>  };
>  
> +/*
> + * For hysterical reasons we don't want to change the ioapic_edge_type, but
> + * we DO want to be able to stop the PIT interrupts.  Here we define a type
> + * for use by irq 0, the PIT, only.
> + */
> +static struct hw_interrupt_type ioapic_edge_type_irq0 = {
> +	.typename 	= "IO-APIC-edge-irq0",
> +	.startup 	= startup_edge_ioapic,
> +	.shutdown 	= shutdown_edge_ioapic,
> +	.enable 	= unmask_IO_APIC_irq,
> +	.disable 	= mask_IO_APIC_irq,
> +	.ack 		= ack_edge_ioapic,
> +	.end 		= end_edge_ioapic,
> +	.set_affinity 	= set_ioapic_affinity,
> +};
> +
> +
>  static inline void init_IO_APIC_traps(void)
>  {
>  	int irq;
> --- clean-mm/arch/i386/kernel/irq.c	2004-12-25 15:51:05.000000000 +0100
> +++ linux-mm/arch/i386/kernel/irq.c	2005-01-13 14:20:00.000000000 +0100
> @@ -13,6 +13,7 @@
>  #include <asm/uaccess.h>
>  #include <linux/module.h>
>  #include <linux/seq_file.h>
> +#include <linux/vst.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel_stat.h>
>  
> @@ -55,6 +56,7 @@
>  #endif
>  
>  	irq_enter();
> +	vst_wakeup(regs, 0);
>  #ifdef CONFIG_DEBUG_STACKOVERFLOW
>  	/* Debugging check for stack overflow: is there less than 1KB free? */
>  	{
> --- clean-mm/arch/i386/kernel/nmi.c	2004-10-19 14:37:41.000000000 +0200
> +++ linux-mm/arch/i386/kernel/nmi.c	2005-01-13 14:20:00.000000000 +0100
> @@ -31,6 +31,7 @@
>  #include <asm/mtrr.h>
>  #include <asm/mpspec.h>
>  #include <asm/nmi.h>
> +#include <linux/cpumask.h>
>  
>  #include "mach_traps.h"
>  
> @@ -200,7 +201,7 @@
>  	}
>  	nmi_active = -1;
>  	/* tell do_nmi() and others that we're not active any more */
> -	nmi_watchdog = 0;
> +	nmi_watchdog = NMI_NONE;
>  }
>  
>  static void enable_lapic_nmi_watchdog(void)
> @@ -257,7 +258,7 @@
>  	}
>  }
>  
> -#ifdef CONFIG_PM
> +#if defined(CONFIG_PM) || defined(CONFIG_VST)
>  
>  static int nmi_pm_active; /* nmi_active before suspend */
>  
> @@ -274,6 +275,61 @@
>  		enable_lapic_nmi_watchdog();
>  	return 0;
>  }
> +static int nmi_restart;
> +static long nmi_apic_save;
> +cpumask_t nmi_disabled_cpus;
> +extern unsigned int
> +	alert_counter [NR_CPUS];
> +/*
> + * As I read the code, the NMI_LOCAL_APIC mode is only used in the UP
> + * systems and then only if the processer supports it.  This means that
> + * NMI_IO_APIC is ALWAYS used with SMP systems.  Here is the only
> + * disable/enable code for them.  In that case we need to have flags for
> + * each cpu to do the right thing.
> + */
> +
> +void disable_nmi_watchdog(void)
> +{
> +	struct sys_device * dum = NULL;
> +	u32 state = 0;
> +
> +	if (cpu_isset(smp_processor_id(), nmi_disabled_cpus)) {
> +		nmi_restart = nmi_watchdog;
> +		switch (nmi_watchdog) {
> +		case NMI_LOCAL_APIC:
> +			lapic_nmi_suspend(dum, state);
> +			break;
> +		case NMI_IO_APIC:
> +			nmi_apic_save = apic_read(APIC_LVT0);
> +			apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
> +			cpu_set(smp_processor_id(), nmi_disabled_cpus);
> + 		default:
> +			return;
> +		}
> +		cpu_set(smp_processor_id(), nmi_disabled_cpus);
> +	}
> +}
> +void enable_nmi_watchdog(void)
> +{
> +	struct sys_device * dum = NULL;
> +	int cpu = smp_processor_id();
> +
> +	if (!cpu_isset(cpu, nmi_disabled_cpus)) {
> +		switch (nmi_restart) {
> +		case NMI_LOCAL_APIC:
> +			lapic_nmi_resume(dum);
> +			break;
> +		case NMI_IO_APIC:
> +			apic_write_around(APIC_LVT0, nmi_apic_save);
> +		default:
> +			return;
> +		}
> +		cpu_clear(cpu, nmi_disabled_cpus);
> +		alert_counter[cpu] = 0;
> +		nmi_watchdog = nmi_restart;
> +		nmi_restart = 0;
> +	}
> +}
>  
>  
>  static struct sysdev_class nmi_sysclass = {
> --- clean-mm/arch/i386/kernel/process.c	2005-01-12 11:12:01.000000000 +0100
> +++ linux-mm/arch/i386/kernel/process.c	2005-01-13 14:20:00.000000000 +0100
> @@ -50,6 +50,7 @@
>  #include <asm/math_emu.h>
>  #endif
>  
> +#include <linux/vst.h>
>  #include <linux/irq.h>
>  #include <linux/err.h>
>  
> @@ -96,9 +97,11 @@
>  {
>  	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
>  		local_irq_disable();
> -		if (!need_resched())
> -			safe_halt();
> -		else
> +		if (!need_resched()) {
> +			if (vst_setup())
> +				return;
> + 			safe_halt();
> +		} else
>  			local_irq_enable();
>  	} else {
>  		cpu_relax();
> --- clean-mm/arch/i386/kernel/smp.c	2004-12-25 15:51:05.000000000 +0100
> +++ linux-mm/arch/i386/kernel/smp.c	2005-01-13 14:20:00.000000000 +0100
> @@ -23,6 +23,7 @@
>  #include <asm/mtrr.h>
>  #include <asm/tlbflush.h>
>  #include <mach_apic.h>
> +#include <linux/vst.h>
>  
>  /*
>   *	Some notes on x86 processor bugs affecting SMP operation:
> @@ -335,6 +336,7 @@
>  			leave_mm(cpu);
>  	}
>  	ack_APIC_irq();
> +	vst_wakeup(regs, 0);
>  	smp_mb__before_clear_bit();
>  	cpu_clear(cpu, flush_cpumask);
>  	smp_mb__after_clear_bit();
> @@ -591,6 +593,7 @@
>  	int wait = call_data->wait;
>  
>  	ack_APIC_irq();
> +	vst_wakeup(regs, 0);
>  	/*
>  	 * Notify initiating CPU that I've grabbed the data and am
>  	 * about to execute the function
> --- clean-mm/arch/i386/kernel/smpboot.c	2005-01-12 11:12:01.000000000 +0100
> +++ linux-mm/arch/i386/kernel/smpboot.c	2005-01-13 14:16:22.000000000 +0100
> @@ -54,6 +54,7 @@
>  #include <mach_apic.h>
>  #include <mach_wakecpu.h>
>  #include <smpboot_hooks.h>
> +#include <linux/hrtime.h>
>  
>  /* Set if we find a B stepping CPU */
>  static int __initdata smp_b_stepping;
> @@ -248,6 +249,9 @@
>  		wmb();
>  		atomic_inc(&tsc_count_stop);
>  	}
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	CLEAR_REF_TSC;
> +#endif
>  
>  	sum = 0;
>  	for (i = 0; i < NR_CPUS; i++) {
> --- clean-mm/arch/i386/kernel/time.c	2005-01-12 11:12:01.000000000 +0100
> +++ linux-mm/arch/i386/kernel/time.c	2005-01-13 14:17:07.000000000 +0100
> @@ -29,7 +29,10 @@
>   *	Fixed a xtime SMP race (we need the xtime_lock rw spinlock to
>   *	serialize accesses to xtime/lost_ticks).
>   */
> -
> +/* 2002-8-13 George Anzinger  Modified for High res timers: 
> + *                            Copyright (C) 2002 MontaVista Software
> +*/
> +#define _INCLUDED_FROM_TIME_C
>  #include <linux/errno.h>
>  #include <linux/sched.h>
>  #include <linux/kernel.h>
> @@ -65,6 +68,8 @@
>  #include <asm/hpet.h>
>  
>  #include <asm/arch_hooks.h>
> +#include <linux/hrtime.h>
> +#include <mach_ipi.h>
>  
>  #include "io_ports.h"
>  
> @@ -87,51 +92,64 @@
>  EXPORT_SYMBOL(i8253_lock);
>  
>  struct timer_opts *cur_timer = &timer_none;
> -
>  /*
>   * This version of gettimeofday has microsecond resolution
>   * and better than microsecond precision on fast x86 machines with TSC.
>   */
> +
> +/*
> + * High res timers changes: First we want to use full nsec for all
> + * the math to avoid the double round off (on the offset and xtime).
> + * Second, we want to allow a boot with HRT turned off at boot time.
> + * This will cause hrtimer_use to be false, and we then fall back to 
> + * the old code.  We also shorten the xtime lock region and eliminate
> + * the lost tick code as this kernel will never have lost ticks under
> + * the lock (i.e. wall_jiffies will never differ from jiffies except
> + * when the write xtime lock is held).
> + */
>  void do_gettimeofday(struct timeval *tv)
>  {
>  	unsigned long seq;
> -	unsigned long usec, sec;
> +	unsigned long sec, nsec, clk_nsec;
>  	unsigned long max_ntp_tick;
>  
>  	do {
> -		unsigned long lost;
> -
>  		seq = read_seqbegin(&xtime_lock);
> -
> -		usec = cur_timer->get_offset();
> -		lost = jiffies - wall_jiffies;
> -
> -		/*
> -		 * If time_adjust is negative then NTP is slowing the clock
> -		 * so make sure not to go into next possible interval.
> -		 * Better to lose some accuracy than have time go backwards..
> -		 */
> -		if (unlikely(time_adjust < 0)) {
> -			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
> -			usec = min(usec, max_ntp_tick);
> -
> -			if (lost)
> -				usec += lost * max_ntp_tick;
> -		}
> -		else if (unlikely(lost))
> -			usec += lost * (USEC_PER_SEC / HZ);
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +		if (hrtimer_use) 
> +			nsec = arch_cycle_to_nsec(get_arch_cycles(wall_jiffies));
> +		else 
> +#endif
> +			nsec = cur_timer->get_offset() * NSEC_PER_USEC;
> +		
>  
>  		sec = xtime.tv_sec;
> -		usec += (xtime.tv_nsec / 1000);
> +		clk_nsec = xtime.tv_nsec;
>  	} while (read_seqretry(&xtime_lock, seq));
>  
> -	while (usec >= 1000000) {
> -		usec -= 1000000;
> +	/*
> +	 * If time_adjust is negative then NTP is slowing the clock
> +	 * so make sure not to go into next possible interval.
> +	 * Better to lose some accuracy than have time go backwards..
> +
> +	 * Note, in this kernel wall_jiffies and jiffies will always
> +	 * be the same, at least under the lock.
> +	 */
> +	if (unlikely(time_adjust < 0)) {
> +		max_ntp_tick = tick_nsec - (tickadj * NSEC_PER_USEC);
> +		if (max_ntp_tick > nsec)
> +			nsec = max_ntp_tick - nsec;
> +	}
> +
> +	nsec += clk_nsec;
> +				
> +	while (nsec >= NSEC_PER_SEC) {
> +		nsec -=  NSEC_PER_SEC;
>  		sec++;
>  	}
>  
>  	tv->tv_sec = sec;
> -	tv->tv_usec = usec;
> +	tv->tv_usec = nsec / NSEC_PER_USEC;
>  }
>  
>  EXPORT_SYMBOL(do_gettimeofday);
> @@ -218,8 +236,7 @@
>   * timer_interrupt() needs to keep up the real-time clock,
>   * as well as call the "do_timer()" routine every clocktick
>   */
> -static inline void do_timer_interrupt(int irq, void *dev_id,
> -					struct pt_regs *regs)
> +static inline void do_timer_interrupt(struct pt_regs *regs)
>  {
>  #ifdef CONFIG_X86_IO_APIC
>  	if (timer_ack) {
> @@ -239,6 +256,13 @@
>  
>  	do_timer_interrupt_hook(regs);
>  
> +        /* 
> +         * This is dumb for two reasons.  
> +         * 1.) it is based on wall time which has not yet been updated.
> +         * 2.) it is checked each tick for something that happens each
> +         *     10 min.  Why not use a timer for it?  Much lower overhead,
> +         *     in fact, zero if STA_UNSYNC is set.
> +         */
>  	/*
>  	 * If we have an externally synchronized Linux clock, then update
>  	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
> @@ -259,22 +283,10 @@
>  		} else if (set_rtc_mmss(xtime.tv_sec) == 0)
>  			last_rtc_update = xtime.tv_sec;
>  		else
> -			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
> +			/* do it again in 60 s */
> +			last_rtc_update = xtime.tv_sec - 600; 
>  	}
>  
> -	if (MCA_bus) {
> -		/* The PS/2 uses level-triggered interrupts.  You can't
> -		turn them off, nor would you want to (any attempt to
> -		enable edge-triggered interrupts usually gets intercepted by a
> -		special hardware circuit).  Hence we have to acknowledge
> -		the timer interrupt.  Through some incredibly stupid
> -		design idea, the reset for IRQ 0 is done by setting the
> -		high bit of the PPI port B (0x61).  Note that some PS/2s,
> -		notably the 55SX, work fine if this is removed.  */
> -
> -		irq = inb_p( 0x61 );	/* read the current state */
> -		outb_p( irq|0x80, 0x61 );	/* reset the IRQ */
> -	}
>  }
>  
>  /*
> @@ -292,16 +304,123 @@
>  	 * locally disabled. -arca
>  	 */
>  	write_seqlock(&xtime_lock);
> +	reset_fillin_timer();
>  
>  	cur_timer->mark_offset();
>   
> -	do_timer_interrupt(irq, NULL, regs);
> +	do_timer_interrupt(regs);
> +#ifdef CONFIG_MCA
> +        /*
> +         * This code moved here from do_timer_interrupt() as part of the
> +         * high-res timers change because it should be done every interrupt
> +         * but do_timer_interrupt() wants to return early if it is not a 
> +         * "1/HZ" tick interrupt.  For non-high-res systems the code is in
> +         * exactly the same location (i.e. it is moved from the tail of the
> +         * above called function to the next thing after the function).
> +         */
> +	if( MCA_bus ) {
> +		int irq;
> +		/* The PS/2 uses level-triggered interrupts.  You can't
> +		turn them off, nor would you want to (any attempt to
> +		enable edge-triggered interrupts usually gets intercepted by a
> +		special hardware circuit).  Hence we have to acknowledge
> +		the timer interrupt.  Through some incredibly stupid
> +		design idea, the reset for IRQ 0 is done by setting the
> +		high bit of the PPI port B (0x61).  Note that some PS/2s,
> +		notably the 55SX, work fine if this is removed.  */
>  
> +		irq = inb_p( 0x61 );	/* read the current state */
> +		outb_p( irq|0x80, 0x61 );	/* reset the IRQ */
> +	}
> +#endif
>  	write_sequnlock(&xtime_lock);
> +#if defined(CONFIG_SMP) && defined(CONFIG_HIGH_RES_TIMERS)
> +	send_IPI_allbutself(LOCAL_TIMER_IPI_VECTOR);
> +	irq_stat[smp_processor_id()].apic_timer_irqs++;
> +	update_process_times(user_mode(regs));
> +#endif
>  	return IRQ_HANDLED;
>  }
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +/*
> + * We always continue to provide interrupts even if they are not
> + * serviced.  To do this, we leave the chip in periodic mode programmed
> + * to interrupt every jiffie.  This is done by, for short intervals,
> + * programming a short time, waiting till it is loaded and then
> + * programming the 1/HZ.  The chip will not load the 1/HZ count till the
> + * short count expires.  If the last interrupt was programmed to be
> + * short, we need to program another short to cover the remaining part
> + * of the jiffie and can then just leave the chip alone.  Note that it
> + * is also a low overhead way of doing things as we do not have to mess
> + * with the chip MOST of the time. 
> + */
> +#ifdef USE_APIC_TIMERS
> +int _schedule_jiffies_int(unsigned long jiffie_f)
> +{
> +	long past;
> +	unsigned long seq;
> +	if (unlikely(!hrtimer_use)) return 0;
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		past = get_arch_cycles(jiffie_f);
> +	} while (read_seqretry(&xtime_lock, seq));
> +
> +	return (past >= arch_cycles_per_jiffy); 
> +}
> +#else 
> +int _schedule_jiffies_int(unsigned long jiffie_f)
> +{
> +	int rtn;
> +	if (!hrtimer_use || __last_was_long) return 0;
> +
> +	rtn = _schedule_next_int(jiffie_f, arch_cycles_per_jiffy);
> +	if (unlikely(!__last_was_long))
> +		/*
> +		 * We need to force a timer interrupt here.  Timer chip code
> +		 * will boost the 1 to some min. value.
> +		 */
> +		reload_timer_chip(1);
> +	return rtn;
> +}
> +#endif
> +int _schedule_next_int(unsigned long jiffie_f,long sub_jiffie_in)
> +{
> +	long sub_jiff_offset; 
> +	unsigned long seq;
> +	/* 
> +	 * First figure where we are in time. 
> +	 * A note on locking.  We are under the timerlist_lock here.  This
> +	 * means that interrupts are off already, so don't use irq versions.
> +	 */
> +	if (unlikely(!hrtimer_use)){
> +		return 0;
> +	}
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		sub_jiff_offset = sub_jiffie_in - get_arch_cycles(jiffie_f);
> +	} while (read_seqretry(&xtime_lock, seq));
> +	/*
> +	 * If time is already passed, just return saying so.
> +	 */
> +	if (sub_jiff_offset <= 0)
> +		return 1;
> +
> +	__last_was_long = arch_cycles_per_jiffy == sub_jiffie_in;
> +	reload_timer_chip(sub_jiff_offset);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_APM
> +void restart_timer(void)
> +{
> +        start_PIT();
> +}
> +#endif /* CONFIG_APM */
> +#endif /* CONFIG_HIGH_RES_TIMERS */
> +
>  
>  /* not static: needed by APM */
> +
>  unsigned long get_cmos_time(void)
>  {
>  	unsigned long retval;
> --- clean-mm/arch/i386/kernel/timers/Makefile	2004-10-19 14:37:41.000000000 +0200
> +++ linux-mm/arch/i386/kernel/timers/Makefile	2005-01-13 14:16:22.000000000 +0100
> @@ -7,3 +7,6 @@
>  obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
>  obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
>  obj-$(CONFIG_X86_PM_TIMER)	+= timer_pm.o
> +obj-$(CONFIG_HIGH_RES_TIMER_ACPI_PM) += hrtimer_pm.o
> +obj-$(CONFIG_HIGH_RES_TIMER_ACPI_PM) += high-res-tbxfroot.o
> +obj-$(CONFIG_HIGH_RES_TIMER_TSC) += hrtimer_tsc.o
> --- clean-mm/arch/i386/kernel/timers/common.c	2004-12-25 15:51:05.000000000 +0100
> +++ linux-mm/arch/i386/kernel/timers/common.c	2005-01-13 14:16:22.000000000 +0100
> @@ -22,7 +22,7 @@
>   * device.
>   */
>  
> -#define CALIBRATE_TIME	(5 * 1000020/HZ)
> +__initdata unsigned long tsc_cycles_per_50_ms;
>  
>  unsigned long __init calibrate_tsc(void)
>  {
> @@ -57,6 +57,12 @@
>  		if (endlow <= CALIBRATE_TIME)
>  			goto bad_ctc;
>  
> +		/*
> +		 * endlow at this point is 50 ms of arch clocks
> +		 * Set up the value for other who want high res.
> +		 */
> +		tsc_cycles_per_50_ms = endlow;
> +
>  		__asm__("divl %2"
>  			:"=a" (endlow), "=d" (endhigh)
>  			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
> @@ -70,6 +76,7 @@
>  	 * 32 bits..
>  	 */
>  bad_ctc:
> +	printk("******************** TSC calibrate failed!\n");
>  	return 0;
>  }
>  
> --- clean-mm/arch/i386/kernel/timers/timer.c	2004-12-25 15:51:05.000000000 +0100
> +++ linux-mm/arch/i386/kernel/timers/timer.c	2005-01-13 14:16:22.000000000 +0100
> @@ -1,10 +1,12 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> +#include <linux/hrtime.h>
>  #include <asm/timer.h>
>  
>  #ifdef CONFIG_HPET_TIMER
>  /*
> + * If high res, we put that first...
>   * HPET memory read is slower than tsc reads, but is more dependable as it
>   * always runs at constant frequency and reduces complexity due to
>   * cpufreq. So, we prefer HPET timer to tsc based one. Also, we cannot use
> @@ -13,7 +15,17 @@
>  #endif
>  /* list of timers, ordered by preference, NULL terminated */
>  static struct init_timer_opts* __initdata timers[] = {
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +#ifdef CONFIG_HIGH_RES_TIMER_ACPI_PM
> +	&hrtimer_pm_init,
> +#elif  CONFIG_HIGH_RES_TIMER_TSC
> +	&hrtimer_tsc_init,
> +#endif  /* CONFIG_HIGH_RES_TIMER_ACPI_PM */
> +#endif
>  #ifdef CONFIG_X86_CYCLONE_TIMER
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +#error "The High Res Timers option is incompatable with the Cyclone timer"
> +#endif
>  	&timer_cyclone_init,
>  #endif
>  #ifdef CONFIG_HPET_TIMER
> @@ -28,6 +40,7 @@
>  };
>  
>  static char clock_override[10] __initdata;
> +#ifndef CONFIG_HIGH_RES_TIMERS_try
>  
>  static int __init clock_setup(char* str)
>  {
> @@ -45,7 +58,7 @@
>  {
>  	cur_timer = &timer_pit;
>  }
> -
> +#endif
>  /* iterates through the list of timers, returning the first 
>   * one that initializes successfully.
>   */
> --- clean-mm/arch/i386/kernel/timers/timer_pit.c	2004-12-25 15:51:05.000000000 +0100
> +++ linux-mm/arch/i386/kernel/timers/timer_pit.c	2005-01-13 14:16:22.000000000 +0100
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/irq.h>
> +#include <linux/hrtime.h>
>  #include <linux/sysdev.h>
>  #include <linux/timex.h>
>  #include <asm/delay.h>
> --- clean-mm/arch/i386/kernel/timers/timer_tsc.c	2004-12-25 15:51:05.000000000 +0100
> +++ linux-mm/arch/i386/kernel/timers/timer_tsc.c	2005-01-13 14:16:22.000000000 +0100
> @@ -48,14 +48,21 @@
>  
>  /* convert from cycles(64bits) => nanoseconds (64bits)
>   *  basic equation:
> - *		ns = cycles / (freq / ns_per_sec)
> - *		ns = cycles * (ns_per_sec / freq)
> - *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
> - *		ns = cycles * (10^3 / cpu_mhz)
> + *	ns = cycles / (freq / ns_per_sec)
> + *	ns = cycles / (cpu_cycles_in_time_X / time_X) / ns_per_sec
> + *	ns = cycles / cpu_cycles_in_time_X / (time_X * ns_per_sec)
> + *	ns = cycles * (time_X * ns_per_sec) / cpu_cycles_in_time_X
> + *
> + *     Here time_X = CALIBRATE_TIME (in USEC) * NSEC_PER_USEC
> + *       and cpu_cycles_in_time_X is tsc_cycles_per_50_ms so...
> + *
> + *      ns = cycles * (CALIBRATE_TIME * NSEC_PER_USEC) / tsc_cycles_per_50_ms
>   *
>   *	Then we use scaling math (suggested by george@mvista.com) to get:
> - *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
> - *		ns = cycles * cyc2ns_scale / SC
> + *
> + *	ns = cycles * CALIBRATE_TIME * NSEC_PER_USEC * SC / tsc_cycles_per_50_ms / SC
> + *      cyc2ns_scale = CALIBRATE_TIME * NSEC_PER_USEC * SC / tsc_cycles_per_50_ms
> + *	ns = cycles * cyc2ns_scale / SC
>   *
>   *	And since SC is a constant power of two, we can convert the div
>   *  into a shift.   
> @@ -64,9 +71,12 @@
>  static unsigned long cyc2ns_scale; 
>  #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
>  
> -static inline void set_cyc2ns_scale(unsigned long cpu_mhz)
> +static inline void set_cyc2ns_scale(void)
>  {
> -	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
> +	long long it = (CALIBRATE_TIME * NSEC_PER_USEC) << CYC2NS_SCALE_FACTOR;
> +	
> +	do_div(it, tsc_cycles_per_50_ms);
> +	cyc2ns_scale = (unsigned long)it;
>  }
>  
>  static inline unsigned long long cycles_2_ns(unsigned long long cyc)
> @@ -238,7 +248,7 @@
>   * to verify the CPU frequency the timing core thinks the CPU is running
>   * at is still correct.
>   */
> -static inline void cpufreq_delayed_get(void) 
> +static inline void cpufreq_delayed_get(void)
>  {
>  	if (cpufreq_init && !cpufreq_delayed_issched) {
>  		cpufreq_delayed_issched = 1;
> @@ -253,6 +263,7 @@
>  
>  static unsigned int  ref_freq = 0;
>  static unsigned long loops_per_jiffy_ref = 0;
> +static unsigned long cyc2ns_scale_ref;
>  
>  #ifndef CONFIG_SMP
>  static unsigned long fast_gettimeoffset_ref = 0;
> @@ -270,6 +281,7 @@
>  	if (!ref_freq) {
>  		ref_freq = freq->old;
>  		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
> +		cyc2ns_scale_ref = cyc2ns_scale;
>  #ifndef CONFIG_SMP
>  		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
>  		cpu_khz_ref = cpu_khz;
> @@ -287,7 +299,8 @@
>  		if (use_tsc) {
>  			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
>  				fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
> -				set_cyc2ns_scale(cpu_khz/1000);
> +				cyc2ns_scale = cpufreq_scale(cyc2ns_scale_ref,
> +							     freq->new, ref_freq);
>  			}
>  		}
>  #endif
> @@ -516,7 +529,7 @@
>  	                	"0" (eax), "1" (edx));
>  				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
>  			}
> -			set_cyc2ns_scale(cpu_khz/1000);
> +			set_cyc2ns_scale();
>  			return 0;
>  		}
>  	}
> --- clean-mm/fs/proc/array.c	2005-01-12 11:12:08.000000000 +0100
> +++ linux-mm/fs/proc/array.c	2005-01-13 14:17:23.000000000 +0100
> @@ -399,7 +399,7 @@
>  
>  	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
>  %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
> -%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
> +%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %lx\n",
>  		task->pid,
>  		tcomm,
>  		state,
> @@ -444,7 +444,8 @@
>  		task->exit_signal,
>  		task_cpu(task),
>  		task->rt_priority,
> -		task->policy);
> +		task->policy,
> +		(unsigned long)task);
>  	if(mm)
>  		mmput(mm);
>  	return res;
> --- clean-mm/include/asm-i386/mach-default/do_timer.h	2004-12-25 15:51:28.000000000 +0100
> +++ linux-mm/include/asm-i386/mach-default/do_timer.h	2005-01-13 14:16:22.000000000 +0100
> @@ -15,7 +15,33 @@
>  
>  static inline void do_timer_interrupt_hook(struct pt_regs *regs)
>  {
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	{ 
> +		long arch_cycles = get_arch_cycles(jiffies);
> +
> +		/*
> +		 * We use unsigned here to correct a little problem when
> +		 * the TSC is reset during the SMP sync TSC stuff at
> +		 * boot time.  The unsigned on the compare will force
> +		 * the code into a loop updating the "stake"
> +		 * (last_update) until we get a positive result.  By
> +		 * using unsigned we don't incure any additional over
> +		 * head while still traping the problem of a negative
> +		 * return.
> +		 */
> +		if ((unsigned)arch_cycles < arch_cycles_per_jiffy) { 
> +			do_hr_timer_int();
> +			return;
> +		}
> +		discipline_PIT_timer();
> +		do{
> +			do_timer(regs);
> +			stake_cpuctr();
> +		}while ((unsigned)get_arch_cycles(jiffies) > arch_cycles_per_jiffy);
> +	}
> +#else
>  	do_timer(regs);
> +#endif
>  #ifndef CONFIG_SMP
>  	update_process_times(user_mode(regs));
>  #endif
> --- clean-mm/include/asm-i386/mach-default/entry_arch.h	2004-10-19 14:38:59.000000000 +0200
> +++ linux-mm/include/asm-i386/mach-default/entry_arch.h	2005-01-13 14:16:22.000000000 +0100
> @@ -13,6 +13,9 @@
>  BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
>  BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
>  BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +BUILD_INTERRUPT(apic_timer_ipi_interrupt,LOCAL_TIMER_IPI_VECTOR)
> +#endif
>  #endif
>  
>  /*
> --- clean-mm/include/asm-i386/mach-default/irq_vectors.h	2004-10-19 14:38:59.000000000 +0200
> +++ linux-mm/include/asm-i386/mach-default/irq_vectors.h	2005-01-13 14:16:22.000000000 +0100
> @@ -55,6 +55,7 @@
>   * to work around the 'lost local interrupt if more than 2 IRQ
>   * sources per level' errata.
>   */
> +#define LOCAL_TIMER_IPI_VECTOR  0xee
>  #define LOCAL_TIMER_VECTOR	0xef
>  
>  /*
> --- clean-mm/include/asm-i386/mach-default/mach_timer.h	2004-10-19 14:38:59.000000000 +0200
> +++ linux-mm/include/asm-i386/mach-default/mach_timer.h	2005-01-13 14:16:22.000000000 +0100
> @@ -15,10 +15,33 @@
>  #ifndef _MACH_TIMER_H
>  #define _MACH_TIMER_H
>  
> -#define CALIBRATE_LATCH	(5 * LATCH)
> +/*
> + * Always use a 50ms calibrate time (PIT is only good for ~54ms)
> + */
> +# define CAL_HZ             100
> +# define CALIBRATE_LATCH    (((CLOCK_TICK_RATE * 5) + 50) / CAL_HZ)
> +# define CALIBRATE_TIME	  (u32)(((u64)CALIBRATE_LATCH * USEC_PER_SEC)/ CLOCK_TICK_RATE)
> +
> +#define PIT2_CHAN 0x42
> +#define PIT_COMMAND_CHAN 0x43
> +
> +#define PIT_BINARY 0
> +#define PIT_SELECT2 0x80
> +#define PIT_RW_2BYTES 0x30
> +#define PIT2_BINARY PIT_SELECT2 + PIT_RW_2BYTES + PIT_BINARY
> +
> +#define PIT_RB2     0x04
> +#define PIT_READBACK 0xc0
> +#define PIT_LATCH_STATUS 0x20 /* actually means don't latch count */
> +#define PIT2_CMD_LATCH_STATUS PIT_READBACK + PIT_LATCH_STATUS + PIT_RB2
> +
> +#define PIT_NULL_COUNT 0x40
> +
> +extern unsigned long tsc_cycles_per_50_ms;
>  
>  static inline void mach_prepare_counter(void)
>  {
> +	unsigned char pit_status;
>         /* Set the Gate high, disable speaker */
>  	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
>  
> @@ -31,9 +54,18 @@
>  	 *
>  	 * Some devices need a delay here.
>  	 */
> -	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
> -	outb_p(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
> -	outb_p(CALIBRATE_LATCH >> 8, 0x42);       /* MSB of count */
> +	outb(PIT2_BINARY, PIT_COMMAND_CHAN);/* binary, mode 0, LSB/MSB, Ch 2 */
> +	outb_p(CALIBRATE_LATCH & 0xff, PIT2_CHAN);	/* LSB of count */
> +	outb_p(CALIBRATE_LATCH >> 8, PIT2_CHAN);       /* MSB of count */
> +	do {
> +		/*
> +		 * Here we wait for the PIT to actually load the count
> +		 * Yes, it does take a while.  Remember his clock is only
> +		 * about 1 MHZ.
> +		 */
> +		outb(PIT2_CMD_LATCH_STATUS, PIT_COMMAND_CHAN);
> +		pit_status = inb(PIT2_CHAN);
> +	} while (pit_status & PIT_NULL_COUNT);
>  }
>  
>  static inline void mach_countup(unsigned long *count_p)
> @@ -41,7 +73,7 @@
>  	unsigned long count = 0;
>  	do {
>  		count++;
> -	} while ((inb_p(0x61) & 0x20) == 0);
> +	} while ((inb(0x61) & 0x20) == 0);
>  	*count_p = count;
>  }
>  
> --- clean-mm/include/asm-i386/mach-visws/do_timer.h	2004-12-25 15:51:28.000000000 +0100
> +++ linux-mm/include/asm-i386/mach-visws/do_timer.h	2005-01-13 14:16:22.000000000 +0100
> @@ -8,7 +8,33 @@
>  	/* Clear the interrupt */
>  	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
>  
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +        { 
> +		long arch_cycles = get_arch_cycles(jiffies);
> +
> +		/*
> +		 * We use unsigned here to correct a little problem when
> +		 * the TSC is reset during the SMP sync TSC stuff at
> +		 * boot time.  The unsigned on the compare will force
> +		 * the code into a loop updating the "stake"
> +		 * (last_update) until we get a positive result.  By
> +		 * using unsigned we don't incure any additional over
> +		 * head while still traping the problem of a negative
> +		 * return.
> +		 */
> +		if ((unsigned)arch_cycles < arch_cycles_per_jiffy) { 
> +			do_hr_timer_int();
> +			return;
> +		}
> +		discipline_PIT_timer();
> +		do{
> +			do_timer(regs);
> +			stake_cpuctr();
> +		}while ((unsigned)get_arch_cycles(jiffies) > arch_cycles_per_jiffy);
> +	}
> +#else
>  	do_timer(regs);
> +#endif
>  #ifndef CONFIG_SMP
>  	update_process_times(user_mode(regs));
>  #endif
> --- clean-mm/include/asm-i386/mach-visws/entry_arch.h	2004-10-19 14:38:59.000000000 +0200
> +++ linux-mm/include/asm-i386/mach-visws/entry_arch.h	2005-01-13 14:16:22.000000000 +0100
> @@ -7,6 +7,9 @@
>  BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
>  BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
>  BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +BUILD_INTERRUPT(apic_timer_ipi_interrupt,LOCAL_TIMER_IPI_VECTOR)
> +#endif
>  #endif
>  
>  /*
> --- clean-mm/include/asm-i386/mach-visws/irq_vectors.h	2004-10-19 14:38:59.000000000 +0200
> +++ linux-mm/include/asm-i386/mach-visws/irq_vectors.h	2005-01-13 14:16:22.000000000 +0100
> @@ -35,6 +35,7 @@
>   * sources per level' errata.
>   */
>  #define LOCAL_TIMER_VECTOR	0xef
> +#define LOCAL_TIMER_IPI_VECTOR  0xee
>  
>  /*
>   * First APIC vector available to drivers: (vectors 0x30-0xee)
> --- clean-mm/include/asm-i386/mach-voyager/do_timer.h	2004-12-25 15:51:28.000000000 +0100
> +++ linux-mm/include/asm-i386/mach-voyager/do_timer.h	2005-01-13 14:16:22.000000000 +0100
> @@ -3,7 +3,31 @@
>  
>  static inline void do_timer_interrupt_hook(struct pt_regs *regs)
>  {
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	long arch_cycles = get_arch_cycles(jiffies);
> +
> +	/*
> +	 * We use unsigned here to correct a little problem when
> +	 * the TSC is reset during the SMP sync TSC stuff at
> +	 * boot time.  The unsigned on the compare will force
> +	 * the code into a loop updating the "stake"
> +	 * (last_update) until we get a positive result.  By
> +	 * using unsigned we don't incure any additional over
> +	 * head while still traping the problem of a negative
> +	 * return.
> +	 */
> +	if ((unsigned)arch_cycles < arch_cycles_per_jiffy) { 
> +		do_hr_timer_int();
> +		return;
> +	}
> +	discipline_PIT_timer();
> +	do {
> +		do_timer(regs);
> +		stake_cpuctr();
> +	} while ((unsigned)get_arch_cycles(jiffies) > arch_cycles_per_jiffy);
> +#else
>  	do_timer(regs);
> +#endif
>  #ifndef CONFIG_SMP
>  	update_process_times(user_mode(regs));
>  #endif
> --- clean-mm/include/linux/posix-timers.h	2004-12-25 15:51:46.000000000 +0100
> +++ linux-mm/include/linux/posix-timers.h	2005-01-13 14:10:49.000000000 +0100
> @@ -1,6 +1,33 @@
>  #ifndef _linux_POSIX_TIMERS_H
>  #define _linux_POSIX_TIMERS_H
>  
> +/*
> + * include/linux/posix-timers.h
> + *
> + *
> + * 2003-7-7  Posix Clocks & timers 
> + *                           by George Anzinger george@mvista.com
> + *
> + *			     Copyright (C) 2003 by MontaVista Software.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or (at
> + * your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * MontaVista Software | 1237 East Arques Avenue | Sunnyvale | CA 94085 | USA 
> + */
> +#include <linux/config.h>
> +#include <linux/hrtime.h>
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
>  
> @@ -17,6 +44,9 @@
>  	int it_sigev_signo;		/* signo word of sigevent struct */
>  	sigval_t it_sigev_value;	/* value word of sigevent struct */
>  	unsigned long it_incr;		/* interval specified in jiffies */
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	int it_sub_incr;		/* sub jiffie part of interval */
> +#endif
>  	struct task_struct *it_process;	/* process to send signal to */
>  	struct timer_list it_timer;
>  	struct sigqueue *sigq;		/* signal queue entry. */
> @@ -54,9 +84,142 @@
>  /* function to call to trigger timer event */
>  int posix_timer_event(struct k_itimer *timr, int si_private);
>  
> +#if defined(CONFIG_HIGH_RES_TIMERS)
> +
> +struct now_struct {
> +	unsigned long jiffies;
> +	long sub_jiffie;
> +};
> +#define get_expire(now, timr) do {\
> +                  (now)->jiffies = (timr)->it_timer.expires; \
> +                  (now)->sub_jiffie = (timr)->it_timer.sub_expires;}while (0)
> +#define put_expire(now, timr) do { \
> +                  (timr)->it_timer.expires = (now)->jiffies; \
> +                  (timr)->it_timer.sub_expires = (now)->sub_jiffie;}while (0)
> +#define sub_now(now, then) do{ \
> +	          (now)->jiffies -= (then)->jiffies; \
> +                  (now)->sub_jiffie -= (then)->sub_jiffie; \
> +                  full_normalize_jiffies_now(now);} while (0)
> +static inline void
> +normalize_jiffies(unsigned long *jiff, long *sub_jif)
> +{
> +	while ((*(sub_jif) - arch_cycles_per_jiffy) >= 0) {
> +		*(sub_jif) -= arch_cycles_per_jiffy;
> +		(*(jiff))++;
> +	}
> +}
> +static inline void
> +full_normalize_jiffies(unsigned long *jiff, long *sub_jif)
> +{
> +	normalize_jiffies(jiff, sub_jif);
> +	while (*(sub_jif) < 0) {
> +		*(sub_jif) += arch_cycles_per_jiffy;
> +		(*(jiff))--;
> +	}
> +}
> +#define normalize_jiffies_now(now) \
> +	normalize_jiffies(&(now)->jiffies, &(now)->sub_jiffie);
> +#define full_normalize_jiffies_now(now) \
> +	full_normalize_jiffies(&(now)->jiffies, &(now)->sub_jiffie);
> +
> +/*
> + * The following locking assumes that irq off.
> + */
> +static inline void
> +posix_get_now(struct now_struct *now)
> +{
> +	unsigned long seq;
> +	
> +	(now)->jiffies = jiffies;
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		(now)->sub_jiffie = get_arch_cycles((now)->jiffies);
> +	} while (read_seqretry(&xtime_lock, seq));
> +	
> +	normalize_jiffies_now(now); 
> +}
> +
> +static inline int
> +posix_time_before (const struct timer_list* t, const struct now_struct* now)
> +{
> +	const long diff = (long)t->expires - (long)now->jiffies;
> +
> +	return (diff < 0) 
> +		|| ((diff == 0) && (t->sub_expires < now->sub_jiffie)); 
> +}
> +
> +#define posix_bump_timer(timr, now) _posix_bump_timer(timr, now)
> +#if 0
> +static void _posix_bump_timer(struct k_itimer * timr, struct now_struct *now)
> +{ 
> +	struct now_struct tmp;
> +	u64 div = (u64)(timr)->it_incr * arch_cycles_per_jiffy +
> +		(timr)->it_sub_incr;
> +	u64 delta;
> +	unsigned long orun = 1;
> +	long sub_jf;
> +		
> +	tmp.jiffies = now->jiffies - (timr)->it_timer.expires;
> +	tmp.sub_jiffie = now->sub_jiffie - (timr)->it_timer.sub_expires;
> +	full_normalize_jiffies_now(&tmp);
> +	if ((long)tmp.jiffies < 0) 
> +		return;
> +	delta = (u64)tmp.jiffies * arch_cycles_per_jiffy + tmp.sub_jiffie;
> +	/*
> +	 * We need to div a long long by a long long to get a long
> +	 * result.  Such a mess.  First test if it is needed at all.
> +	 */
> +	if (delta > div) {   
> +		/*
> +		 * If we are dividing by less than 2^32 use do_div
> +		 * else reduce the num and denom to make it so.
> +		 */
> +		u64 sdiv = div, delta_i = delta;
> +		int shift = 0;
> +
> +		while (sdiv >> 32) {
> +			sdiv >>= 1;
> +			shift += 1;
> +		};
> +		delta >>= shift;
> +		do_div(delta, (u32)sdiv);
> +		orun = (u32)delta;
> +		delta = orun * div;
> +		if (delta <= delta_i) {
> +			delta += div;
> +			orun++;
> +		}
> +	} else {
> +		delta = div;
> +	}
> +	(timr)->it_timer.expires += 
> +		div_long_long_rem(delta, 
> +				  arch_cycles_per_jiffy, 
> +				  &sub_jf);
> +	(timr)->it_timer.sub_expires += sub_jf;
> +	normalize_jiffies(&(timr)->it_timer.expires,
> +			  &(timr)->it_timer.sub_expires);
> +	(timr)->it_overrun += orun;
> +}
> +#else
> +#define __posix_bump_timer(timr) do {				\
> +          (timr)->it_timer.expires += (timr)->it_incr;		\
> +          (timr)->it_timer.sub_expires += (timr)->it_sub_incr;	\
> +          normalize_jiffies(&((timr)->it_timer.expires),		\
> +			  &((timr)->it_timer.sub_expires));	\
> +          (timr)->it_overrun++;					\
> +        }while (0)
> +#define _posix_bump_timer(timr, now) do {  __posix_bump_timer(timr); \
> +                  } while  (posix_time_before(&((timr)->it_timer), now))
> +#endif
> +#else /* defined(CONFIG_HIGH_RES_TIMERS) */
> +
>  struct now_struct {
>  	unsigned long jiffies;
>  };
> +#define get_expire(now, timr) (now)->jiffies = (timr)->it_timer.expires
> +#define put_expire(now, timr) (timr)->it_timer.expires = (now)->jiffies
> +#define sub_now(now, then)    (now)->jiffies -= (then)->jiffies
>  
>  #define posix_get_now(now) (now)->jiffies = jiffies;
>  #define posix_time_before(timer, now) \
> @@ -65,12 +228,12 @@
>  #define posix_bump_timer(timr, now)					\
>           do {								\
>                long delta, orun;						\
> -	      delta = now.jiffies - (timr)->it_timer.expires;		\
> +	      delta = (now)->jiffies - (timr)->it_timer.expires;	\
>                if (delta >= 0) {						\
>  	           orun = 1 + (delta / (timr)->it_incr);		\
>  	          (timr)->it_timer.expires += orun * (timr)->it_incr;	\
>                    (timr)->it_overrun += orun;				\
>                }								\
>              }while (0)
> +#endif /* defined(CONFIG_HIGH_RES_TIMERS) */
>  #endif
> -
> --- clean-mm/include/linux/sysctl.h	2005-01-12 11:12:09.000000000 +0100
> +++ linux-mm/include/linux/sysctl.h	2005-01-13 14:17:46.000000000 +0100
> @@ -135,6 +135,8 @@
>  	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
>  	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
>  	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
> +	KERN_VST=68,            /* VST table */
> +	KERN_IDLE=69,           /* IDLE table */
>  };
>  
>  
> --- clean-mm/include/linux/thread_info.h	2004-10-19 14:39:13.000000000 +0200
> +++ linux-mm/include/linux/thread_info.h	2005-01-13 14:10:49.000000000 +0100
> @@ -12,7 +12,7 @@
>   */
>  struct restart_block {
>  	long (*fn)(struct restart_block *);
> -	unsigned long arg0, arg1, arg2, arg3;
> +	unsigned long arg0, arg1, arg2, arg3, arg4;
>  };
>  
>  extern long do_no_restart_syscall(struct restart_block *parm);
> --- clean-mm/include/linux/time.h	2005-01-12 11:12:09.000000000 +0100
> +++ linux-mm/include/linux/time.h	2005-01-13 14:10:49.000000000 +0100
> @@ -113,13 +113,14 @@
>  		nsec -= NSEC_PER_SEC;
>  		++sec;
>  	}
> -	while (nsec < 0) {
> +	while (unlikely(nsec < 0)) {
>  		nsec += NSEC_PER_SEC;
>  		--sec;
>  	}
>  	ts->tv_sec = sec;
>  	ts->tv_nsec = nsec;
>  }
> +#define timespec_norm(a) set_normalized_timespec((a), (a)->tv_sec, (a)->tv_nsec)
>  
>  #endif /* __KERNEL__ */
>  
> @@ -167,9 +168,6 @@
>  
>  #define CLOCK_SGI_CYCLE 10
>  #define MAX_CLOCKS 16
> -#define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC | \
> -                     CLOCK_REALTIME_HR | CLOCK_MONOTONIC_HR)
> -#define CLOCKS_MONO (CLOCK_MONOTONIC & CLOCK_MONOTONIC_HR)
>  
>  /*
>   * The various flags for setting POSIX.1b interval timers.
> --- clean-mm/include/linux/timer.h	2004-10-19 14:39:13.000000000 +0200
> +++ linux-mm/include/linux/timer.h	2005-01-13 14:10:49.000000000 +0100
> @@ -19,6 +19,7 @@
>  	unsigned long data;
>  
>  	struct tvec_t_base_s *base;
> +	long sub_expires;
>  };
>  
>  #define TIMER_MAGIC	0x4b87ad6e
> @@ -30,6 +31,7 @@
>  		.base = NULL,					\
>  		.magic = TIMER_MAGIC,				\
>  		.lock = SPIN_LOCK_UNLOCKED,			\
> +		.sub_expires = 0,			        \
>  	}
>  
>  /***
> @@ -42,6 +44,7 @@
>  static inline void init_timer(struct timer_list * timer)
>  {
>  	timer->base = NULL;
> +	timer->sub_expires = 0;
>  	timer->magic = TIMER_MAGIC;
>  	spin_lock_init(&timer->lock);
>  }
> --- clean-mm/kernel/Makefile	2004-12-25 15:51:46.000000000 +0100
> +++ linux-mm/kernel/Makefile	2005-01-13 14:17:23.000000000 +0100
> @@ -16,6 +16,13 @@
>  obj-$(CONFIG_MODULES) += module.o
>  obj-$(CONFIG_KALLSYMS) += kallsyms.o
>  obj-$(CONFIG_PM) += power/
> +ifeq ($(CONFIG_VST),y)
> +	DOVST=vst.o
> +endif
> +ifeq ($(CONFIG_IDLE),y)
> +	DOVST=vst.o
> +endif
> +obj-y += $(DOVST)
>  obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
>  obj-$(CONFIG_COMPAT) += compat.o
>  obj-$(CONFIG_IKCONFIG) += configs.o
> --- clean-mm/kernel/posix-timers.c	2005-01-12 11:12:10.000000000 +0100
> +++ linux-mm/kernel/posix-timers.c	2005-01-13 14:10:49.000000000 +0100
> @@ -42,13 +42,15 @@
>  #include <linux/init.h>
>  #include <linux/compiler.h>
>  #include <linux/idr.h>
> +#include <linux/hrtime.h>
>  #include <linux/posix-timers.h>
>  #include <linux/syscalls.h>
>  #include <linux/wait.h>
> +#include <linux/sc_math.h>
> +#include <asm/div64.h>
>  #include <linux/workqueue.h>
>  
>  #ifndef div_long_long_rem
> -#include <asm/div64.h>
>  
>  #define div_long_long_rem(dividend,divisor,remainder) ({ \
>  		       u64 result = dividend;		\
> @@ -58,10 +60,6 @@
>  #endif
>  #define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */
>  
> -static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
> -{
> -	return (u64)mpy1 * mpy2;
> -}
>  /*
>   * Management arrays for POSIX timers.	 Timers are kept in slab memory
>   * Timer ids are allocated by an external routine that keeps track of the
> @@ -137,7 +135,7 @@
>   * RESOLUTION: Clock resolution is used to round up timer and interval
>   *	    times, NOT to report clock times, which are reported with as
>   *	    much resolution as the system can muster.  In some cases this
> - *	    resolution may depend on the underlying clock hardware and
> + *	    resolution may depend on the underlaying clock hardware and
>   *	    may not be quantifiable until run time, and only then is the
>   *	    necessary code is written.	The standard says we should say
>   *	    something about this issue in the documentation...
> @@ -155,7 +153,7 @@
>   *
>   *          At this time all functions EXCEPT clock_nanosleep can be
>   *          redirected by the CLOCKS structure.  Clock_nanosleep is in
> - *          there, but the code ignores it.
> + *          there, but the code ignors it.
>   *
>   * Permissions: It is assumed that the clock_settime() function defined
>   *	    for each clock will take care of permission checks.	 Some
> @@ -166,6 +164,7 @@
>   */
>  
>  static struct k_clock posix_clocks[MAX_CLOCKS];
> +IF_HIGH_RES(static long arch_res_by_2;)
>  /*
>   * We only have one real clock that can be set so we need only one abs list,
>   * even if we should want to have several clocks with differing resolutions.
> @@ -187,7 +186,7 @@
>  
>  static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
>  static u64 do_posix_clock_monotonic_gettime_parts(
> -	struct timespec *tp, struct timespec *mo);
> +	struct timespec *tp, struct timespec *mo, long *sub_jiff);
>  int do_posix_clock_monotonic_gettime(struct timespec *tp);
>  static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
>  
> @@ -216,20 +215,34 @@
>  	posix_timers_cache = kmem_cache_create("posix_timers_cache",
>  					sizeof (struct k_itimer), 0, 0, NULL, NULL);
>  	idr_init(&posix_timers_id);
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	/*
> +	 * Possibly switched out at boot time
> +	 */
> +	if (hrtimer_use) {
> +		clock_realtime.res = hr_time_resolution;
> +		register_posix_clock(CLOCK_REALTIME_HR, &clock_realtime);
> +		clock_monotonic.res = hr_time_resolution;
> +		register_posix_clock(CLOCK_MONOTONIC_HR, &clock_monotonic);
> +	}
> +	arch_res_by_2 = nsec_to_arch_cycle(hr_time_resolution >> 1);
> +#endif
> +
> +#ifdef	final_clock_init
> +	final_clock_init();	/* defined as needed by arch header file */
> +#endif
> +
>  	return 0;
>  }
>  
>  __initcall(init_posix_timers);
> -
> +#ifndef CONFIG_HIGH_RES_TIMERS
>  static void tstojiffie(struct timespec *tp, int res, u64 *jiff)
>  {
> -	long sec = tp->tv_sec;
> -	long nsec = tp->tv_nsec + res - 1;
> +	struct timespec tv = *tp;
> +	tv.tv_nsec += res - 1;
>  
> -	if (nsec > NSEC_PER_SEC) {
> -		sec++;
> -		nsec -= NSEC_PER_SEC;
> -	}
> +	timespec_norm(&tv);
>  
>  	/*
>  	 * The scaling constants are defined in <linux/time.h>
> @@ -237,10 +250,47 @@
>  	 * res rounding and compute a 64-bit result (well so does that
>  	 * but it then throws away the high bits).
>    	 */
> -	*jiff =  (mpy_l_X_l_ll(sec, SEC_CONVERSION) +
> -		  (mpy_l_X_l_ll(nsec, NSEC_CONVERSION) >> 
> +	*jiff =  (((u64)tv.tv_sec * SEC_CONVERSION) +
> +		  (((u64)tv.tv_nsec * NSEC_CONVERSION) >>
>  		   (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
>  }
> +#else
> +static long tstojiffie(struct timespec *tp, int res, u64 *jiff)
> +{
> +	struct timespec tv = *tp;
> +	u64 raw_jiff;
> +	unsigned long mask_jiff;
> +	long rtn;
> +
> +	tv.tv_nsec += res - 1;
> +
> +	timespec_norm(&tv);
> +
> +	/*
> +	 * This much like the above, except, well you know that bit
> +	 * we shift off the right end to get jiffies.  Well that is
> +	 * the sub_jiffie part and here we pick that up and convert
> +	 * it to arch_cycles.
> +	 *
> +	 * Also, we need to be a bit more rigorous about resolution,
> +	 * See the next line...
> +	 */
> +	tv.tv_nsec -= tv.tv_nsec % res;
> +
> +	raw_jiff =  (((u64)tv.tv_sec * SEC_CONVERSION) +
> +		     (((u64)tv.tv_nsec * NSEC_CONVERSION) >>
> +		(NSEC_JIFFIE_SC - SEC_JIFFIE_SC)));
> +	*jiff = raw_jiff >> SEC_JIFFIE_SC;
> +
> +	mask_jiff = raw_jiff & ((1 << SEC_JIFFIE_SC) -1);
> +
> +	rtn = ((u64)mask_jiff * arch_cycles_per_jiffy +
> +		(1 << SEC_JIFFIE_SC) -1) >> SEC_JIFFIE_SC;
> +
> +	return rtn;
> +}
> +#endif
> +
>  
>  /*
>   * This function adjusts the timer as needed as a result of the clock
> @@ -250,7 +300,7 @@
>   * reference wall_to_monotonic value.  It is complicated by the fact
>   * that tstojiffies() only handles positive times and it needs to work
>   * with both positive and negative times.  Also, for negative offsets,
> - * we need to defeat the res round up.
> + * we need to make the res round up actually round up (not down).
>   *
>   * Return is true if there is a new time, else false.
>   */
> @@ -258,7 +308,7 @@
>  			       struct timespec *new_wall_to)
>  {
>  	struct timespec delta;
> -	int sign = 0;
> +	IF_HIGH_RES(long sub_jif);
>  	u64 exp;
>  
>  	set_normalized_timespec(&delta,
> @@ -269,15 +319,28 @@
>  	if (likely(!(delta.tv_sec | delta.tv_nsec)))
>  		return 0;
>  	if (delta.tv_sec < 0) {
> -		set_normalized_timespec(&delta,
> +		/* clock advanced */
> +		set_normalized_timespec(&delta, 
>  					-delta.tv_sec,
> -					1 - delta.tv_nsec -
> -					posix_clocks[timr->it_clock].res);
> -		sign++;
> +					-posix_clocks[timr->it_clock].res - 
> +					delta.tv_nsec);
> +		IF_HIGH_RES(sub_jif = -)
> +			tstojiffie(&delta, posix_clocks[timr->it_clock].res,
> +				   &exp);
> +		exp = -exp;
> +	} else {
> +		/* clock retarded */
> +		IF_HIGH_RES(sub_jif = )
> +			tstojiffie(&delta, posix_clocks[timr->it_clock].res, 
> +				   &exp);
>  	}
> -	tstojiffie(&delta, posix_clocks[timr->it_clock].res, &exp);
>  	timr->wall_to_prev = *new_wall_to;
> -	timr->it_timer.expires += (sign ? -exp : exp);
> +	timr->it_timer.expires += exp;
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	timr->it_timer.sub_expires += sub_jif;
> +	full_normalize_jiffies(&timr->it_timer.expires,
> +			       &timr->it_timer.sub_expires);
> +#endif
>  	return 1;
>  }
>  
> @@ -309,9 +372,15 @@
>  	 * "other" CLOCKs "next timer" code (which, I suppose should
>  	 * also be added to the k_clock structure).
>  	 */
> -	if (!timr->it_incr) 
> -		return;
>  
> +	/* Set up the timer for the next interval (if there is one) */
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	if (!(timr->it_incr | timr->it_sub_incr))
> +		return;
> +#else
> +	if (!(timr->it_incr))
> +		return;
> +#endif
>  	do {
>  		seq = read_seqbegin(&xtime_lock);
>  		new_wall_to =	wall_to_monotonic;
> @@ -322,11 +391,11 @@
>  		spin_lock(&abs_list.lock);
>  		add_clockset_delta(timr, &new_wall_to);
>  
> -		posix_bump_timer(timr, now);
> +		posix_bump_timer(timr, &now);
>  
>  		spin_unlock(&abs_list.lock);
>  	} else {
> -		posix_bump_timer(timr, now);
> +		posix_bump_timer(timr, &now);
>  	}
>  	timr->it_overrun_last = timr->it_overrun;
>  	timr->it_overrun = -1;
> @@ -409,12 +478,13 @@
>  	struct k_itimer *timr = (struct k_itimer *) __data;
>  	unsigned long flags;
>  	unsigned long seq;
> +	IF_HIGH_RES(long sub_jif);
>  	struct timespec delta, new_wall_to;
>  	u64 exp = 0;
>  	int do_notify = 1;
>  
>  	spin_lock_irqsave(&timr->it_lock, flags);
> - 	set_timer_inactive(timr);
> +	set_timer_inactive(timr);
>  	if (!list_empty(&timr->abs_timer_entry)) {
>  		spin_lock(&abs_list.lock);
>  		do {
> @@ -432,11 +502,17 @@
>  			/* do nothing, timer is already late */
>  		} else {
>  			/* timer is early due to a clock set */
> +			IF_HIGH_RES(sub_jif = )
>  			tstojiffie(&delta,
>  				   posix_clocks[timr->it_clock].res,
>  				   &exp);
>  			timr->wall_to_prev = new_wall_to;
> -			timr->it_timer.expires += exp;
> +			timr->it_timer.expires += exp; 
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +			timr->it_timer.sub_expires += sub_jif;
> +			normalize_jiffies(&timr->it_timer.expires,
> +					  &timr->it_timer.sub_expires);
> +#endif
>  			add_timer(&timr->it_timer);
>  			do_notify = 0;
>  		}
> @@ -446,7 +522,7 @@
>  	if (do_notify)  {
>  		int si_private=0;
>  
> -		if (timr->it_incr)
> +		if (timr->it_incr IF_HIGH_RES( | timr->it_sub_incr))
>  			si_private = ++timr->it_requeue_pending;
>  		else {
>  			remove_from_abslist(timr);
> @@ -625,11 +701,14 @@
>  				new_timer->it_process = process;
>  				list_add(&new_timer->list,
>  					 &process->signal->posix_timers);
> -				spin_unlock_irqrestore(&process->sighand->siglock, flags);
> -				if (new_timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
> +				spin_unlock_irqrestore(
> +					&process->sighand->siglock, flags);
> +				if (new_timer->it_sigev_notify == 
> +				    (SIGEV_SIGNAL|SIGEV_THREAD_ID))
>  					get_task_struct(process);
>  			} else {
> -				spin_unlock_irqrestore(&process->sighand->siglock, flags);
> +				spin_unlock_irqrestore(
> +					&process->sighand->siglock, flags);
>  				process = NULL;
>  			}
>  		}
> @@ -733,38 +812,60 @@
>   * it is the same as a requeue pending timer WRT to what we should
>   * report.
>   */
> +
> +#ifdef CONFIG_HIGH_RES_TIMERS 
> +struct now_struct zero_now = {0, 0};
> +#define timeleft (expire.jiffies | expire.sub_jiffie)
> +#else
> +struct now_struct zero_now = {0};
> +#define timeleft (expire.jiffies)
> +#endif
> +
>  static void
>  do_timer_gettime(struct k_itimer *timr, struct itimerspec *cur_setting)
>  {
> -	unsigned long expires;
> -	struct now_struct now;
> +	struct now_struct now, expire;
>  
> -	do
> -		expires = timr->it_timer.expires;
> -	while ((volatile long) (timr->it_timer.expires) != expires);
> +	do {
> +		get_expire(&expire, timr);
> +	} while ((volatile long) (timr->it_timer.expires) != expire.jiffies);
>  
>  	posix_get_now(&now);
>  
> -	if (expires &&
> -	    ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) &&
> -	    !timr->it_incr &&
> -	    posix_time_before(&timr->it_timer, &now))
> -		timr->it_timer.expires = expires = 0;
> -	if (expires) {
> +	if (timeleft && 
> +	    ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) && 
> +	    !(timr->it_incr IF_HIGH_RES(| timr->it_sub_incr)) &&
> +	    posix_time_before(&timr->it_timer, &now)) {
> +		put_expire(&zero_now, timr);
> +		expire = zero_now;
> +	}
> +	if (timeleft) {
>  		if (timr->it_requeue_pending & REQUEUE_PENDING ||
>  		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
> -			posix_bump_timer(timr, now);
> -			expires = timr->it_timer.expires;
> +			posix_bump_timer(timr, &now);
> +			get_expire(&expire, timr);
>  		}
>  		else
>  			if (!timer_pending(&timr->it_timer))
> -				expires = 0;
> -		if (expires)
> -			expires -= now.jiffies;
> +				expire = zero_now;
> +		if (timeleft) {
> +			sub_now(&expire, &now);
> +		}
>  	}
> -	jiffies_to_timespec(expires, &cur_setting->it_value);
> +	jiffies_to_timespec(expire.jiffies, &cur_setting->it_value);
>  	jiffies_to_timespec(timr->it_incr, &cur_setting->it_interval);
>  
> +#ifdef CONFIG_HIGH_RES_TIMERS 
> +	set_normalized_timespec(&cur_setting->it_value, 
> +				cur_setting->it_value.tv_sec, 
> +				cur_setting->it_value.tv_nsec +
> +				arch_cycle_to_nsec(expire.sub_jiffie));
> +
> +	set_normalized_timespec(&cur_setting->it_interval, 
> +				cur_setting->it_interval.tv_sec,
> +				cur_setting->it_interval.tv_nsec +
> +				arch_cycle_to_nsec(timr->it_sub_incr));
> +#endif
>  	if (cur_setting->it_value.tv_sec < 0) {
>  		cur_setting->it_value.tv_nsec = 1;
>  		cur_setting->it_value.tv_sec = 0;
> @@ -827,26 +928,36 @@
>   *
>   * If it is relative time, we need to add the current (CLOCK_MONOTONIC)
>   * time to it to get the proper time for the timer.
> - */
> -static int adjust_abs_time(struct k_clock *clock, struct timespec *tp, 
> -			   int abs, u64 *exp, struct timespec *wall_to)
> + *
> + * err will be set to -EINVAL if offset is larger than MAX_JIFFY_OFFSET.
> + * Caller should set err otherwise prior to call if he desires to test
> + * this value.
> + */
> +static int adjust_abs_time(struct k_clock *clock, 
> +			   struct timespec *tp, 
> +			   int abs, 
> +			   u64 *exp, 
> +			   struct timespec *wall_to,
> +			   int *err)
>  {
>  	struct timespec now;
>  	struct timespec oc = *tp;
>  	u64 jiffies_64_f;
> +	long sub_jiff;
>  	int rtn =0;
>  
>  	if (abs) {
>  		/*
> -		 * The mask pick up the 4 basic clocks 
> +		 * The mask picks up the 4 basic clocks
>  		 */
> -		if (!((clock - &posix_clocks[0]) & ~CLOCKS_MASK)) {
> +		if ((clock - &posix_clocks[0]) <= CLOCK_MONOTONIC_HR) {
>  			jiffies_64_f = do_posix_clock_monotonic_gettime_parts(
> -				&now,  wall_to);
> +				&now,  wall_to, &sub_jiff);
>  			/*
>  			 * If we are doing a MONOTONIC clock
>  			 */
> -			if((clock - &posix_clocks[0]) & CLOCKS_MONO){
> +			if(clock->clock_get ==
> +			    posix_clocks[CLOCK_MONOTONIC].clock_get){
>  				now.tv_sec += wall_to->tv_sec;
>  				now.tv_nsec += wall_to->tv_nsec;
>  			}
> @@ -854,7 +965,7 @@
>  			/*
>  			 * Not one of the basic clocks
>  			 */
> -			do_posix_gettime(clock, &now);	
> +			do_posix_gettime(clock, &now);
>  			jiffies_64_f = get_jiffies_64();
>  		}
>  		/*
> @@ -865,41 +976,47 @@
>  		/*
>  		 * Normalize...
>  		 */
> -		while ((oc.tv_nsec - NSEC_PER_SEC) >= 0) {
> -			oc.tv_nsec -= NSEC_PER_SEC;
> -			oc.tv_sec++;
> -		}
> +		timespec_norm(&oc);
>  		while ((oc.tv_nsec) < 0) {
>  			oc.tv_nsec += NSEC_PER_SEC;
>  			oc.tv_sec--;
>  		}
>  	}else{
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +		do_atomic_on_xtime_seq(
> +			jiffies_64_f = jiffies_64;
> +			sub_jiff = get_arch_cycles((u32) jiffies_64_f);
> +			);
> +#else
>  		jiffies_64_f = get_jiffies_64();
> +#endif
>  	}
>  	/*
>  	 * Check if the requested time is prior to now (if so set now)
>  	 */
>  	if (oc.tv_sec < 0)
>  		oc.tv_sec = oc.tv_nsec = 0;
> -	tstojiffie(&oc, clock->res, exp);
>  
> -	/*
> -	 * Check if the requested time is more than the timer code
> -	 * can handle (if so we error out but return the value too).
> -	 */
> -	if (*exp > ((u64)MAX_JIFFY_OFFSET))
> -			/*
> -			 * This is a considered response, not exactly in
> -			 * line with the standard (in fact it is silent on
> -			 * possible overflows).  We assume such a large 
> -			 * value is ALMOST always a programming error and
> -			 * try not to compound it by setting a really dumb
> -			 * value.
> -			 */
> -			rtn = -EINVAL;
> +	if (oc.tv_sec | oc.tv_nsec) {
> +		oc.tv_nsec += clock->res;
> +		timespec_norm(&oc);
> +	}
> +
> +	IF_HIGH_RES(rtn = sub_jiff + )
> +		tstojiffie(&oc, clock->res, exp);
> +
>  	/*
>  	 * return the actual jiffies expire time, full 64 bits
>  	 */
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	while (rtn >= arch_cycles_per_jiffy) {
> +		rtn -= arch_cycles_per_jiffy;
> +		jiffies_64_f++;
> +	}
> +#endif
> +	if (*exp > ((u64)MAX_JIFFY_OFFSET))
> +		*err = -EINVAL;
> +
>  	*exp += jiffies_64_f;
>  	return rtn;
>  }
> @@ -912,12 +1029,15 @@
>  {
>  	struct k_clock *clock = &posix_clocks[timr->it_clock];
>  	u64 expire_64;
> +	int rtn = 0;
> +	IF_HIGH_RES(long sub_expire;)
>  
>  	if (old_setting)
>  		do_timer_gettime(timr, old_setting);
>  
>  	/* disable the timer */
>  	timr->it_incr = 0;
> +	IF_HIGH_RES(timr->it_sub_incr = 0;)
>  	/*
>  	 * careful here.  If smp we could be in the "fire" routine which will
>  	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
> @@ -949,16 +1069,34 @@
>  	 */
>  	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec) {
>  		timr->it_timer.expires = 0;
> +		IF_HIGH_RES(timr->it_timer.sub_expires = 0;)
>  		return 0;
>  	}
>  
> -	if (adjust_abs_time(clock,
> -			    &new_setting->it_value, flags & TIMER_ABSTIME, 
> -			    &expire_64, &(timr->wall_to_prev))) {
> -		return -EINVAL;
> -	}
> -	timr->it_timer.expires = (unsigned long)expire_64;	
> -	tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
> +	IF_HIGH_RES(sub_expire = )
> +		adjust_abs_time(clock, &new_setting->it_value, 
> +				flags & TIMER_ABSTIME, &expire_64, 
> +				&(timr->wall_to_prev), &rtn);
> +	/*
> +	 * Check if the requested time is more than the timer code
> +	 * can handle (if so we error out).
> +	 */
> +	if (rtn)
> +			/*
> +			 * This is a considered response, not exactly in
> +			 * line with the standard (in fact it is silent on
> +			 * possible overflows).  We assume such a large
> +			 * value is ALMOST always a programming error and
> +			 * try not to compound it by setting a really dumb
> +			 * value.
> +			 */
> +		return rtn;
> +
> +	timr->it_timer.expires = (unsigned long)expire_64;
> +	IF_HIGH_RES(timr->it_timer.sub_expires = sub_expire;)
> +	IF_HIGH_RES(timr->it_sub_incr =)
> +		tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
> +
>  	timr->it_incr = (unsigned long)expire_64;
>  
>  	/*
> @@ -1011,7 +1149,7 @@
>  							       &new_spec, rtn);
>  	unlock_timer(timr, flag);
>  	if (error == TIMER_RETRY) {
> -		rtn = NULL;	// We already got the old time...
> +		rtn = NULL;	/* We already got the old time... */
>  		goto retry;
>  	}
>  
> @@ -1025,6 +1163,7 @@
>  static inline int do_timer_delete(struct k_itimer *timer)
>  {
>  	timer->it_incr = 0;
> +	IF_HIGH_RES(timer->it_sub_incr = 0;)
>  #ifdef CONFIG_SMP
>  	if (timer_active(timer) && !del_timer(&timer->it_timer))
>  		/*
> @@ -1143,12 +1282,36 @@
>   * spin_lock_irq() held and from clock calls with no locking.	They must
>   * use the save flags versions of locks.
>   */
> +extern volatile unsigned long wall_jiffies;
> +
> +static void get_wall_time(struct timespec *tp)
> +{
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	*tp = xtime;
> +	tp->tv_nsec += arch_cycle_to_nsec(get_arch_cycles(wall_jiffies));
> +#else
> +	getnstimeofday(tp);
> +#endif
> +}
> +/*
> + * The sequence lock below does not need the irq part with real
> + * sequence locks (i.e. in 2.6).  We do need them in 2.4 where
> + * we emulate the sequence lock... shame really.
> + */
>  static int do_posix_gettime(struct k_clock *clock, struct timespec *tp)
>  {
> +	unsigned int seq;
> +
>  	if (clock->clock_get)
>  		return clock->clock_get(tp);
>  
> -	getnstimeofday(tp);
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		get_wall_time(tp);
> +	} while(read_seqretry(&xtime_lock, seq));
> +
> +	timespec_norm(tp);
> +
>  	return 0;
>  }
>  
> @@ -1161,35 +1324,41 @@
>   */
>  
>  static u64 do_posix_clock_monotonic_gettime_parts(
> -	struct timespec *tp, struct timespec *mo)
> +		struct timespec *tp, struct timespec *mo, long *sub_jiff)
>  {
>  	u64 jiff;
>  	unsigned int seq;
>  
>  	do {
>  		seq = read_seqbegin(&xtime_lock);
> -		getnstimeofday(tp);
> +		get_wall_time(tp);
>  		*mo = wall_to_monotonic;
>  		jiff = jiffies_64;
> +		IF_HIGH_RES(*sub_jiff = get_arch_cycles((u32)jiff);)
>  
>  	} while(read_seqretry(&xtime_lock, seq));
>  
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	while(*sub_jiff >= arch_cycles_per_jiffy) {
> +		*sub_jiff -= arch_cycles_per_jiffy;
> +		jiff++;
> +	}
> +#endif
> +
>  	return jiff;
>  }
>  
>  int do_posix_clock_monotonic_gettime(struct timespec *tp)
>  {
>  	struct timespec wall_to_mono;
> +	long sub_jiff;
>  
> -	do_posix_clock_monotonic_gettime_parts(tp, &wall_to_mono);
> +	do_posix_clock_monotonic_gettime_parts(tp, &wall_to_mono, &sub_jiff);
>  
>  	tp->tv_sec += wall_to_mono.tv_sec;
>  	tp->tv_nsec += wall_to_mono.tv_nsec;
>  
> -	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
> -		tp->tv_nsec -= NSEC_PER_SEC;
> -		tp->tv_sec++;
> -	}
> +	timespec_norm(tp);
>  	return 0;
>  }
>  
> @@ -1272,7 +1441,6 @@
>  static void nanosleep_wake_up(unsigned long __data)
>  {
>  	struct task_struct *p = (struct task_struct *) __data;
> -
>  	wake_up_process(p);
>  }
>  
> @@ -1416,6 +1584,27 @@
>  		return -EFAULT;
>  	return ret;
>  }
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +#define get_jiffies_time(result)				\
> +({								\
> +	unsigned int seq;					\
> +	u64 jiff;						\
> +	do {							\
> +		seq = read_seqbegin(&xtime_lock);		\
> +		jiff = jiffies_64;				\
> +		*result = get_arch_cycles((unsigned long)jiff);	\
> +	} while(read_seqretry(&xtime_lock, seq));		\
> +        while(*result >= arch_cycles_per_jiffy) {		\
> +                *result -= arch_cycles_per_jiffy;		\
> +                jiff++;						\
> +        }							\
> +	jiff;							\
> +})
> +
> +#else
> +#define get_jiffies_time(result) get_jiffies_64()
> +
> +#endif
>  
>  long
>  do_clock_nanosleep(clockid_t which_clock, int flags, struct timespec *tsave)
> @@ -1424,10 +1613,11 @@
>  	struct timer_list new_timer;
>  	DECLARE_WAITQUEUE(abs_wqueue, current);
>  	u64 rq_time = (u64)0;
> -	s64 left;
> +	s64 left, jiff_u64_f;
> +	IF_HIGH_RES(long sub_left;)
>  	int abs;
>  	struct restart_block *restart_block =
> -	    &current_thread_info()->restart_block;
> +	    &(current_thread_info()->restart_block);
>  
>  	abs_wqueue.flags = 0;
>  	init_timer(&new_timer);
> @@ -1447,9 +1637,18 @@
>  		rq_time = (rq_time << 32) + restart_block->arg2;
>  		if (!rq_time)
>  			return -EINTR;
> -		left = rq_time - get_jiffies_64();
> +		IF_HIGH_RES(new_timer.sub_expires = restart_block->arg4;)
> +		left = rq_time - get_jiffies_time(&sub_left);
> +
> +
> +#ifndef CONFIG_HIGH_RES_TIMERS
>  		if (left <= (s64)0)
>  			return 0;	/* Already passed */
> +#else
> +		if ((left < (s64)0) || 
> +		    ((left == (s64)0) && (new_timer.sub_expires <= sub_left)))
> +			return 0;
> +#endif
>  	}
>  
>  	if (abs && (posix_clocks[which_clock].clock_get !=
> @@ -1458,33 +1657,51 @@
>  
>  	do {
>  		t = *tsave;
> -		if (abs || !rq_time) {
> +		if (abs || !(rq_time IF_HIGH_RES(| new_timer.sub_expires))) {
> +			int dum2;
> +			IF_HIGH_RES(new_timer.sub_expires =)
>  			adjust_abs_time(&posix_clocks[which_clock], &t, abs,
> -					&rq_time, &dum);
> -			rq_time += (t.tv_sec || t.tv_nsec);
> +					&rq_time, &dum, &dum2);
>  		}
>  
> -		left = rq_time - get_jiffies_64();
> +		jiff_u64_f = get_jiffies_time(&sub_left);
> +		left = rq_time - jiff_u64_f;
>  		if (left >= (s64)MAX_JIFFY_OFFSET)
>  			left = (s64)MAX_JIFFY_OFFSET;
> +#ifndef CONFIG_HIGH_RES_TIMERS
>  		if (left < (s64)0)
>  			break;
> +#else
> +		if ((left < (s64)0) || 
> +		    ((left == (s64)0) && (new_timer.sub_expires <= sub_left)))
> +			break;
> +#endif
>  
> -		new_timer.expires = jiffies + left;
> +		new_timer.expires = (unsigned long)jiff_u64_f + left;
>  		__set_current_state(TASK_INTERRUPTIBLE);
>  		add_timer(&new_timer);
>  
>  		schedule();
>  
>  		del_timer_sync(&new_timer);
> -		left = rq_time - get_jiffies_64();
> -	} while (left > (s64)0 && !test_thread_flag(TIF_SIGPENDING));
> +		left = rq_time - get_jiffies_time(&sub_left);
> +	} while ((left > (s64)0  
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +		  || (left == (s64)0 && (new_timer.sub_expires > sub_left))
> +#endif
> +			 ) &&  !test_thread_flag(TIF_SIGPENDING));
>  
>  	if (abs_wqueue.task_list.next)
>  		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
>  
> -	if (left > (s64)0) {
>  
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	if (left > (s64)0 || 
> +	    (left == (s64)0 && (new_timer.sub_expires > sub_left)))
> +#else
> +	if (left > (s64)0 )
> +#endif
> +	{
>  		/*
>  		 * Always restart abs calls from scratch to pick up any
>  		 * clock shifting that happened while we are away.
> @@ -1493,6 +1710,9 @@
>  			return -ERESTARTNOHAND;
>  
>  		left *= TICK_NSEC;
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +		left += arch_cycle_to_nsec(new_timer.sub_expires - sub_left);
> +#endif
>  		tsave->tv_sec = div_long_long_rem(left, 
>  						  NSEC_PER_SEC, 
>  						  &tsave->tv_nsec);
> @@ -1512,10 +1732,10 @@
>  		 */
>  		restart_block->arg2 = rq_time & 0xffffffffLL;
>  		restart_block->arg3 = rq_time >> 32;
> +		IF_HIGH_RES(restart_block->arg4 = new_timer.sub_expires;)
>  
>  		return -ERESTART_RESTARTBLOCK;
>  	}
> -
>  	return 0;
>  }
>  /*
> --- clean-mm/kernel/sysctl.c	2005-01-12 11:12:10.000000000 +0100
> +++ linux-mm/kernel/sysctl.c	2005-01-13 14:17:23.000000000 +0100
> @@ -141,6 +141,12 @@
>  static ctl_table debug_table[];
>  static ctl_table dev_table[];
>  extern ctl_table random_table[];
> +#ifdef CONFIG_VST
> +extern ctl_table vst_table[];
> +#endif
> +#ifdef CONFIG_IDLE
> +extern ctl_table idle_table[];
> +#endif
>  #ifdef CONFIG_UNIX98_PTYS
>  extern ctl_table pty_table[];
>  #endif
> @@ -633,6 +639,26 @@
>  		.proc_handler	= &proc_dointvec,
>  	},
>  #endif
> +#ifdef CONFIG_VST
> +	{
> +		.ctl_name	= KERN_VST,
> +		.procname	= "vst",
> +		.data		= NULL, 
> +		.maxlen		= 0, 
> +		.mode		= 0555,
> +		.child		= vst_table,
> +	},
> +#endif
> +#ifdef CONFIG_IDLE
> +	{
> +		.ctl_name	= KERN_IDLE,
> +		.procname	= "idle", 
> +		.data		= NULL, 
> +		.maxlen		= 0,  
> +		.mode		= 0555,
> +		.child		= idle_table,
> +	},
> +#endif
>  	{ .ctl_name = 0 }
>  };
>  
> --- clean-mm/kernel/timer.c	2005-01-12 11:12:10.000000000 +0100
> +++ linux-mm/kernel/timer.c	2005-01-13 14:19:41.000000000 +0100
> @@ -17,6 +17,8 @@
>   *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
>   *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
>   *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
> + *  2002-10-01  High res timers code by George Anzinger 
> + *                  2002-2004 (c) MontaVista Software, Inc.
>   */
>  
>  #include <linux/kernel_stat.h>
> @@ -33,11 +35,13 @@
>  #include <linux/cpu.h>
>  #include <linux/syscalls.h>
>  
> +#include <linux/hrtime.h>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
>  #include <asm/div64.h>
>  #include <asm/timex.h>
>  #include <asm/io.h>
> +#include <linux/timer-list.h>
>  
>  #ifdef CONFIG_TIME_INTERPOLATION
>  static void time_interpolator_update(long delta_nsec);
> @@ -45,37 +49,6 @@
>  #define time_interpolator_update(x)
>  #endif
>  
> -/*
> - * per-CPU timer vector definitions:
> - */
> -#define TVN_BITS 6
> -#define TVR_BITS 8
> -#define TVN_SIZE (1 << TVN_BITS)
> -#define TVR_SIZE (1 << TVR_BITS)
> -#define TVN_MASK (TVN_SIZE - 1)
> -#define TVR_MASK (TVR_SIZE - 1)
> -
> -typedef struct tvec_s {
> -	struct list_head vec[TVN_SIZE];
> -} tvec_t;
> -
> -typedef struct tvec_root_s {
> -	struct list_head vec[TVR_SIZE];
> -} tvec_root_t;
> -
> -struct tvec_t_base_s {
> -	spinlock_t lock;
> -	unsigned long timer_jiffies;
> -	struct timer_list *running_timer;
> -	tvec_root_t tv1;
> -	tvec_t tv2;
> -	tvec_t tv3;
> -	tvec_t tv4;
> -	tvec_t tv5;
> -} ____cacheline_aligned_in_smp;
> -
> -typedef struct tvec_t_base_s tvec_base_t;
> -
>  static inline void set_running_timer(tvec_base_t *base,
>  					struct timer_list *timer)
>  {
> @@ -83,9 +56,9 @@
>  	base->running_timer = timer;
>  #endif
>  }
> -
>  /* Fake initialization */
> -static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
> +DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
> +
>  
>  static void check_timer_failed(struct timer_list *timer)
>  {
> @@ -111,47 +84,99 @@
>  		check_timer_failed(timer);
>  }
>  
> -
> -static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
> +/*
> + * must be cli-ed when calling this
> + */
> +static inline void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
>  {
> -	unsigned long expires = timer->expires;
> -	unsigned long idx = expires - base->timer_jiffies;
> -	struct list_head *vec;
> -
> -	if (idx < TVR_SIZE) {
> -		int i = expires & TVR_MASK;
> -		vec = base->tv1.vec + i;
> -	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
> -		int i = (expires >> TVR_BITS) & TVN_MASK;
> -		vec = base->tv2.vec + i;
> -	} else if (idx < 1 << (TVR_BITS + 2 * TVN_BITS)) {
> -		int i = (expires >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
> -		vec = base->tv3.vec + i;
> -	} else if (idx < 1 << (TVR_BITS + 3 * TVN_BITS)) {
> -		int i = (expires >> (TVR_BITS + 2 * TVN_BITS)) & TVN_MASK;
> -		vec = base->tv4.vec + i;
> -	} else if ((signed long) idx < 0) {
> -		/*
> -		 * Can happen if you add a timer with expires == jiffies,
> -		 * or you set a timer to go off in the past
> -		 */
> -		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
> +  	unsigned long expires = timer->expires;
> + 	IF_HIGH_RES(long sub_expires = timer->sub_expires;)
> + 	struct list_head *pos, *list_start;
> + 	int indx;
> +  
> + 	if (time_before(expires, base->timer_jiffies)) {
> + 		/*
> + 		 * already expired, schedule for next tick 
> + 		 * would like to do better here
> + 		 * Actually this now works just fine with the
> + 		 * back up of timer_jiffies in "run_timer_list".
> + 		 * Note that this puts the timer on a list other
> + 		 * than the one it idexes to.  We don't want to
> + 		 * change the expires value in the timer as it is
> + 		 * used by the repeat code in setitimer and the
> + 		 * POSIX timers code.
> + 		 */
> + 		expires = base->timer_jiffies;
> + 		IF_HIGH_RES(sub_expires = 0);
> + 	}
> + 	BUMP_VST_VISIT_COUNT;		
> + 	indx = expires & NEW_TVEC_MASK;
> + 	if ((expires - base->timer_jiffies) < NEW_TVEC_SIZE) {
> +#ifdef CONFIG_HIGH_RES_TIMERS
> + 		unsigned long jiffies_f;
> +  		/*
> + 		 * The high diff bits are the same, goes to the head of 
> + 		 * the list, sort on sub_expire.
> +  		 */
> + 		for (pos = (list_start = &base->tv[indx])->next; 
> + 		     pos != list_start; 
> + 		     pos = pos->next){
> + 			struct timer_list *tmr = 
> + 				list_entry(pos,
> + 					   struct timer_list,
> + 					   entry);
> + 			if ((tmr->sub_expires >= sub_expires) ||
> + 			    (tmr->expires != expires)){
> + 				break;
> + 			}
> + 		}
> + 		list_add_tail(&timer->entry, pos);
> + 		/*
> + 		 * Notes to me.	 Use jiffies here instead of 
> + 		 * timer_jiffies to prevent adding unneeded interrupts.
> + 		 * Running_timer is NULL if we are NOT currently 
> + 		 * activly dispatching timers.	Since we are under
> + 		 * the same spin lock, it being false means that 
> + 		 * it has dropped the spinlock to call the timer
> + 		 * function, which could well be who called us.
> + 		 * In any case, we don't need a new interrupt as
> + 		 * the timer dispach code (run_timer_list) will
> + 		 * pick this up when the function it is calling 
> + 		 * returns.
> + 		 */
> + 		if ( expires == (jiffies_f = base->timer_jiffies) && 
> + 		     list_start->next == &timer->entry &&
> + 		     (base->running_timer == NULL)) {
> + 			if (schedule_hr_timer_int(jiffies_f, sub_expires))
> +				run_local_timers();
> + 		}
> +#else
> + 		pos = (&base->tv[indx])->next;
> + 		list_add_tail(&timer->entry, pos);
> +#endif
>  	} else {
> -		int i;
> -		/* If the timeout is larger than 0xffffffff on 64-bit
> -		 * architectures then we use the maximum timeout:
> +		/*
> +		 * The high diff bits differ, search from the tail
> +		 * The for will pick up an empty list.
>  		 */
> -		if (idx > 0xffffffffUL) {
> -			idx = 0xffffffffUL;
> -			expires = idx + base->timer_jiffies;
> +		for (pos = (list_start = &base->tv[indx])->prev; 
> +		     pos != list_start; 
> +		     pos = pos->prev) {
> +			struct timer_list *tmr = 
> +				list_entry(pos,
> +					   struct timer_list,
> +					   entry);
> +			if (time_after(tmr->expires, expires))
> +				continue;
> +
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +			if ((tmr->expires != expires) ||
> +			    (tmr->sub_expires < sub_expires))
> +#endif
> +				break;
>  		}
> -		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
> -		vec = base->tv5.vec + i;
> -	}
> -	/*
> -	 * Timers are FIFO:
> -	 */
> -	list_add_tail(&timer->entry, vec);
> +		list_add(&timer->entry, pos);
> +	}			
>  }
>  
>  int __mod_timer(struct timer_list *timer, unsigned long expires)
> @@ -398,86 +423,140 @@
>  EXPORT_SYMBOL(del_singleshot_timer_sync);
>  #endif
>  
> -static int cascade(tvec_base_t *base, tvec_t *tv, int index)
> -{
> -	/* cascade all the timers from tv up one level */
> -	struct list_head *head, *curr;
> -
> -	head = tv->vec + index;
> -	curr = head->next;
> -	/*
> -	 * We are removing _all_ timers from the list, so we don't  have to
> -	 * detach them individually, just clear the list afterwards.
> -	 */
> -	while (curr != head) {
> -		struct timer_list *tmp;
> -
> -		tmp = list_entry(curr, struct timer_list, entry);
> -		BUG_ON(tmp->base != base);
> -		curr = curr->next;
> -		internal_add_timer(base, tmp);
> -	}
> -	INIT_LIST_HEAD(head);
> +/*
> + * This read-write spinlock protects us from races in SMP while
> + * playing with xtime and avenrun.
> + */
> +#ifndef ARCH_HAVE_XTIME_LOCK
> +seqlock_t xtime_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
>  
> -	return index;
> -}
> +EXPORT_SYMBOL(xtime_lock);
> +#endif
>  
> -/***
> - * __run_timers - run all expired timers (if any) on this CPU.
> - * @base: the timer vector to be processed.
> - *
> - * This function cascades all vectors and executes all expired timer
> - * vectors.
> +/*
> + * run_timer_list is ALWAYS called from softirq which calls with irq enabled.
> + * We may assume this and not save the flags.
>   */
> -#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
> -
> -static inline void __run_timers(tvec_base_t *base)
> +static void __run_timers(tvec_base_t *base)
>  {
> -	struct timer_list *timer;
> -
> +	IF_HIGH_RES( unsigned long jiffies_f;
> +		     long sub_jiff;
> +		     long sub_jiffie_f;
> +		     unsigned long seq);
>  	spin_lock_irq(&base->lock);
> -	while (time_after_eq(jiffies, base->timer_jiffies)) {
> -		struct list_head work_list = LIST_HEAD_INIT(work_list);
> -		struct list_head *head = &work_list;
> - 		int index = base->timer_jiffies & TVR_MASK;
> - 
> +	BUMP_VST_VISIT_COUNT; 
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +run_timer_list_again:
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		jiffies_f = jiffies;
> +		sub_jiffie_f = get_arch_cycles(jiffies_f);
> +	} while (read_seqretry(&xtime_lock, seq));
> +	sub_jiff = 0;
> +/*
> + * Lets not go beyond the current jiffies.  It tends to confuse some 
> + * folks using short timers causing then to loop forever...
> + * If sub_jiffie_f > cycles_per_jiffies we will just clean out all
> + * timers at jiffies_f and quit.  We get the rest on the next go round.
> +	while ( unlikely(sub_jiffie_f >= arch_cycles_per_jiffy)){
> +		sub_jiffie_f -= arch_cycles_per_jiffy;
> +		jiffies_f++;
> +	}
> + */
> +	while ((long)(jiffies_f - base->timer_jiffies) >= 0) {
> +#else
> +	while ((long)(jiffies - base->timer_jiffies) >= 0) {
> +#endif
> +		struct list_head *head;
> +		head = base->tv + (base->timer_jiffies & NEW_TVEC_MASK);
>  		/*
> -		 * Cascade timers:
> +		 * Note that we never move "head" but continue to
> +		 * pick the first entry from it.  This allows new
> +		 * entries to be inserted while we unlock for the
> +		 * function call below.
>  		 */
> -		if (!index &&
> -			(!cascade(base, &base->tv2, INDEX(0))) &&
> -				(!cascade(base, &base->tv3, INDEX(1))) &&
> -					!cascade(base, &base->tv4, INDEX(2)))
> -			cascade(base, &base->tv5, INDEX(3));
> -		++base->timer_jiffies; 
> -		list_splice_init(base->tv1.vec + index, &work_list);
>  repeat:
>  		if (!list_empty(head)) {
>  			void (*fn)(unsigned long);
>  			unsigned long data;
> +			struct timer_list *timer;
>  
> -			timer = list_entry(head->next,struct timer_list,entry);
> - 			fn = timer->function;
> - 			data = timer->data;
> -
> -			list_del(&timer->entry);
> -			set_running_timer(base, timer);
> -			smp_wmb();
> -			timer->base = NULL;
> -			spin_unlock_irq(&base->lock);
> -			{
> -				u32 preempt_count = preempt_count();
> +			timer = list_entry(head->next, struct timer_list, entry);
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +			/*
> +			 * This would be simpler if we never got behind
> +			 * i.e. if timer_jiffies == jiffies, we could
> +			 * drop one of the tests.  Since we may get 
> +			 * behind, (in fact we don't up date until
> +			 * we are behind to allow sub_jiffie entries)
> +			 * we need a way to negate the sub_jiffie
> +			 * test in that case...
> +			 */
> +			if (time_before(timer->expires, jiffies_f)||
> +			    ((timer->expires == jiffies_f) &&
> +			     timer->sub_expires <= sub_jiffie_f)) {
> +#else
> +			if (time_before_eq(timer->expires, jiffies)) {
> +#endif
> +				fn = timer->function;
> +				data = timer->data;
> +				list_del(&timer->entry);
> +				timer->entry.next = timer->entry.prev = NULL;
> +				set_running_timer(base, timer);
> +				smp_wmb();
> +				timer->base = NULL;
> +				spin_unlock_irq(&base->lock);
>  				fn(data);
> -				if (preempt_count != preempt_count()) {
> -					printk("huh, entered %p with %08x, exited with %08x?\n", fn, preempt_count, preempt_count());
> -					BUG();
> +				spin_lock_irq(&base->lock);
> +				goto repeat;
> +			}
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +			else {
> +				/*
> + 				 * The new timer list is not always emptied
> +				 * here as it contains:
> +				 * a.) entries (list size)*N jiffies out and
> +				 * b.) entries that match in jiffies, but have
> +				 *     sub_expire times further out than now.
> +				 */
> +				if (timer->expires == jiffies_f ) { 
> +					sub_jiff = timer->sub_expires;
> + 					/*
> +					 * If schedule_hr_timer_int says the 
> +					 * time has passed we go round again
> +					 */
> +					if (schedule_hr_timer_int(jiffies_f, 
> +								  sub_jiff))
> +						goto run_timer_list_again;
>  				}
> +				 /* Otherwise, we need a jiffies interrupt next... */
>  			}
> -			spin_lock_irq(&base->lock);
> -			goto repeat;
> +#endif
>  		}
> +		++base->timer_jiffies; 
>  	}
> +	/*
> +	 * It is faster to back out the last bump, than to prevent it.
> +	 * This allows zero time inserts as well as sub_jiffie values in
> +	 * the current jiffie.
> +	 */
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	--base->timer_jiffies;
> +	if (!sub_jiff && schedule_jiffies_int(jiffies_f)) {
> +		spin_unlock_irq(&base->lock);
> +		/*
> +		 * If we are here, jiffies time has passed.  We should be
> +		 * safe waiting for jiffies to change.
> +		 */
> +		while ((volatile unsigned long)jiffies == jiffies_f) {
> +			cpu_relax();
> +		}
> +		spin_lock_irq(&base->lock);
> +		goto run_timer_list_again;
> +	}
> +#endif
>  	set_running_timer(base, NULL);
> +
>  	spin_unlock_irq(&base->lock);
>  }
>  
> @@ -809,12 +888,25 @@
>  /*
>   * Called from the timer interrupt handler to charge one tick to the current 
>   * process.  user_tick is 1 if the tick is user time, 0 for system.
> + * For VST we change to account for multiple ticks.
>   */
> +static unsigned process_jiffies[NR_CPUS];
> +
> +
>  void update_process_times(int user_tick)
>  {
>  	struct task_struct *p = current;
> -	int cpu = smp_processor_id();
> +	int cpu = smp_processor_id(), system = 0;
> +	unsigned long delta_jiffies = jiffies - process_jiffies[cpu];
>  
> +	process_jiffies[cpu] += delta_jiffies;
> +
> +	if (user_tick) {
> +		user_tick = delta_jiffies;
> +	} else {
> +		system = delta_jiffies;
> +	}
> +	
>  	/* Note: this timer irq context must be accounted for as well. */
>  	if (user_tick)
>  		account_user_time(p, jiffies_to_cputime(1));
> @@ -867,16 +959,6 @@
>  unsigned long wall_jiffies = INITIAL_JIFFIES;
>  
>  /*
> - * This read-write spinlock protects us from races in SMP while
> - * playing with xtime and avenrun.
> - */
> -#ifndef ARCH_HAVE_XTIME_LOCK
> -seqlock_t xtime_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
> -
> -EXPORT_SYMBOL(xtime_lock);
> -#endif
> -
> -/*
>   * This function runs timers and the timer-tq in bottom half context.
>   */
>  static void run_timer_softirq(struct softirq_action *h)
> @@ -1284,15 +1366,8 @@
>         
>  	base = &per_cpu(tvec_bases, cpu);
>  	spin_lock_init(&base->lock);
> -	for (j = 0; j < TVN_SIZE; j++) {
> -		INIT_LIST_HEAD(base->tv5.vec + j);
> -		INIT_LIST_HEAD(base->tv4.vec + j);
> -		INIT_LIST_HEAD(base->tv3.vec + j);
> -		INIT_LIST_HEAD(base->tv2.vec + j);
> -	}
> -	for (j = 0; j < TVR_SIZE; j++)
> -		INIT_LIST_HEAD(base->tv1.vec + j);
> -
> +	for (j = 0; j < NEW_TVEC_SIZE; j++)
> +		INIT_LIST_HEAD(base->tv + j);
>  	base->timer_jiffies = jiffies;
>  }
>  
> Only in linux-mm/kernel: vst.c
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

