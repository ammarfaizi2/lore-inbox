Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUA2Cre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 21:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUA2Cre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 21:47:34 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:22754 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265805AbUA2CrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 21:47:03 -0500
Subject: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, andrea <andrea@suse.de>,
       Joel Becker <Joel.Becker@oracle.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Chris McDermott <lcm@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-FVjz4JvI5Kv9YfiVu8rl"
Message-Id: <1075344395.1592.87.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Jan 2004 18:46:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FVjz4JvI5Kv9YfiVu8rl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

All,
        This is my port of the x86-64 vsyscall gettimeofday code to
i386. This patch moves gettimeofday into userspace, so it can be called
without the syscall overhead, greatly improving performance. This is
important for any application, like a database, which heavily uses
gettimeofday for timestamping. It supports both the TSC and IBM x44X
cyclone time source.

Example performance gain: (vs. int80)
Normal gettimeofday 
gettimeofday ( 1665576us / 1000000runs ) = 1.665574us
vsyscall LD_PRELOAD gettimeofday
gettimeofday ( 868378us / 1000000runs ) = 0.868377us

This patch becomes especially important with the introduction of the
4G/4G split, as there the syscall overhead is greatly increased. 

Example gain w/ 4/4g split: (vs. int80)
Normal gettimeofday 
gettimeofday ( 7210630us / 1000000runs ) = 7.210623us
vsyscall LD_PRELOAD gettimeofday
gettimeofday ( 844855us / 1000000runs ) = 0.844854us

Also attached is an example test program which generated the numbers
above, and shows how to use vsyscall-gtod via LD_PRELOAD. Ideally glibc
would support this, as it does vsyscall-sysenter.

Please let me know if you have any comments or suggestions. 

New in this patch (B0 -> B1):
o Cleaned up 4/4 split code, so no additional patch is needed.
o Fixed permissions on fixmapped cyclone page
o Improved alternate_instruction workaround 
o Use NTP variables to avoid related time inconsistencies
o minor code cleanups

thanks
-john


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Jan 27 19:26:21 2004
+++ b/arch/i386/Kconfig	Tue Jan 27 19:26:21 2004
@@ -416,6 +416,10 @@
 config HPET_EMULATE_RTC
 	def_bool HPET_TIMER && RTC=y
 
+config VSYSCALL_GTOD
+	depends on EXPERIMENTAL
+	bool "VSYSCALL gettimeofday() interface"
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Tue Jan 27 19:26:21 2004
+++ b/arch/i386/kernel/Makefile	Tue Jan 27 19:26:21 2004
@@ -31,6 +31,7 @@
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
+obj-$(CONFIG_VSYSCALL_GTOD)	+= vsyscall-gtod.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Tue Jan 27 19:26:21 2004
+++ b/arch/i386/kernel/setup.c	Tue Jan 27 19:26:21 2004
@@ -47,6 +47,7 @@
 #include <asm/sections.h>
 #include <asm/io_apic.h>
 #include <asm/ist.h>
+#include <asm/vsyscall-gtod.h>
 #include "setup_arch_pre.h"
 #include "mach_resources.h"
 
@@ -1142,6 +1143,7 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+	vsyscall_init();
 }
 
 #include "setup_arch_post.h"
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Jan 27 19:26:21 2004
+++ b/arch/i386/kernel/time.c	Tue Jan 27 19:26:21 2004
@@ -393,5 +393,8 @@
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	/* set vsyscall to use selected time source */
+	vsyscall_set_timesource(cur_timer->name);
+	
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Tue Jan 27 19:26:21 2004
+++ b/arch/i386/kernel/timers/timer.c	Tue Jan 27 19:26:21 2004
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <asm/timer.h>
+#include <asm/vsyscall-gtod.h>
 
 #ifdef CONFIG_HPET_TIMER
 /*
@@ -41,6 +42,9 @@
 void clock_fallback(void)
 {
 	cur_timer = &timer_pit;
+
+	/* set vsyscall to use selected time source */
+	vsyscall_set_timesource(cur_timer->name);
 }
 
 /* iterates through the list of timers, returning the first 
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Tue Jan 27 19:26:21 2004
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Tue Jan 27 19:26:21 2004
@@ -21,18 +21,24 @@
 extern spinlock_t i8253_lock;
 
 /* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
+int cyclone_delay_at_last_interrupt;
+
+/* FIXMAP flag  */
+#ifdef CONFIG_VSYSCALL_GTOD
+#define PAGE_CYCLONE PAGE_KERNEL_VSYSCALL_NOCACHE
+#else
+#define PAGE_CYCLONE PAGE_KERNEL_NOCACHE
+#endif
 
 #define CYCLONE_CBAR_ADDR 0xFEB00CD0
 #define CYCLONE_PMCC_OFFSET 0x51A0
 #define CYCLONE_MPMC_OFFSET 0x51D0
 #define CYCLONE_MPCS_OFFSET 0x51A8
-#define CYCLONE_TIMER_FREQ 100000000
 #define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /* 40 bit mask */
 int use_cyclone = 0;
 
-static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
-static u32 last_cyclone_low;
+u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
+u32 last_cyclone_low;
 static u32 last_cyclone_high;
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
@@ -57,7 +63,7 @@
 	spin_lock(&i8253_lock);
 	read_cyclone_counter(last_cyclone_low,last_cyclone_high);
 
-	/* read values for delay_at_last_interrupt */
+	/* read values for cyclone_delay_at_last_interrupt */
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
 
 	count = inb_p(0x40);    /* read the latched count */
@@ -67,7 +73,7 @@
 	/* lost tick compensation */
 	delta = last_cyclone_low - delta;	
 	delta /= (CYCLONE_TIMER_FREQ/1000000);
-	delta += delay_at_last_interrupt;
+	delta += cyclone_delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
 	if (lost >= 2)
@@ -78,16 +84,16 @@
 	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
 	write_sequnlock(&monotonic_lock);
 
-	/* calculate delay_at_last_interrupt */
+	/* calculate cyclone_delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
-	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+	cyclone_delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 
 
 	/* catch corner case where tick rollover occured 
 	 * between cyclone and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - cyclone_delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
 }
 
@@ -96,7 +102,7 @@
 	u32 offset;
 
 	if(!cyclone_timer)
-		return delay_at_last_interrupt;
+		return cyclone_delay_at_last_interrupt;
 
 	/* Read the cyclone timer */
 	offset = cyclone_timer[0];
@@ -109,7 +115,7 @@
 	offset = offset/(CYCLONE_TIMER_FREQ/1000000);
 
 	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + offset;
+	return cyclone_delay_at_last_interrupt + offset;
 }
 
 static unsigned long long monotonic_clock_cyclone(void)
@@ -193,7 +199,7 @@
 	/* map in cyclone_timer */
 	pageaddr = (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
 	offset = (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
-	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	__set_fixmap(FIX_CYCLONE_TIMER, pageaddr, PAGE_CYCLONE);
 	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!cyclone_timer){
 		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Tue Jan 27 19:26:21 2004
+++ b/arch/i386/kernel/timers/timer_tsc.c	Tue Jan 27 19:26:21 2004
@@ -33,7 +33,7 @@
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
+int tsc_delay_at_last_interrupt;
 
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
@@ -104,7 +104,7 @@
 		 "0" (eax));
 
 	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + edx;
+	return tsc_delay_at_last_interrupt + edx;
 }
 
 static unsigned long long monotonic_clock_tsc(void)
@@ -223,7 +223,7 @@
 		 "0" (eax));
 		delta = edx;
 	}
-	delta += delay_at_last_interrupt;
+	delta += tsc_delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
 	if (lost >= 2) {
@@ -244,15 +244,15 @@
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
 
-	/* calculate delay_at_last_interrupt */
+	/* calculate tsc_delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
-	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+	tsc_delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 
 	/* catch corner case where tick rollover occured 
 	 * between tsc and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - tsc_delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
 }
 
@@ -304,7 +304,7 @@
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
 
-	/* calculate delay_at_last_interrupt */
+	/* calculate tsc_delay_at_last_interrupt */
 	/*
 	 * Time offset = (hpet delta) * ( usecs per HPET clock )
 	 *             = (hpet delta) * ( usecs per tick / HPET clocks per tick)
@@ -312,9 +312,9 @@
 	 * Where,
 	 * hpet_usec_quotient = (2^32 * usecs per tick)/HPET clocks per tick
 	 */
-	delay_at_last_interrupt = hpet_current - offset;
-	ASM_MUL64_REG(temp, delay_at_last_interrupt,
-			hpet_usec_quotient, delay_at_last_interrupt);
+	tsc_delay_at_last_interrupt = hpet_current - offset;
+	ASM_MUL64_REG(temp, tsc_delay_at_last_interrupt,
+			hpet_usec_quotient, tsc_delay_at_last_interrupt);
 }
 #endif
 
diff -Nru a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S	Tue Jan 27 19:26:21 2004
+++ b/arch/i386/kernel/vmlinux.lds.S	Tue Jan 27 19:26:21 2004
@@ -3,11 +3,11 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <linux/config.h>
 	
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(startup_32)
-jiffies = jiffies_64;
 SECTIONS
 {
   . = 0xC0000000 + 0x100000;
@@ -48,6 +48,79 @@
 
   _edata = .;			/* End of data section */
 
+/* VSYSCALL_GTOD data */
+#ifdef CONFIG_VSYSCALL_GTOD
+
+	/* vsyscall entry */
+   . = ALIGN(64);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+	/* Must be the same as VSYSCALL_GTOD_START */
+  .vsyscall_0 0xffffc000: AT ((LOADADDR(.data.cacheline_aligned) + SIZEOF(.data.cacheline_aligned) + 4095) & ~(4095)) { *(.vsyscall_0) }
+  __vsyscall_0 = LOADADDR(.vsyscall_0);
+
+
+	/* generic gtod variables */
+  . = ALIGN(64);
+  .vsyscall_timesource : AT ((LOADADDR(.vsyscall_0) + SIZEOF(.vsyscall_0) + 63) & ~(63)) { *(.vsyscall_timesource) }
+  vsyscall_timesource = LOADADDR(.vsyscall_timesource);
+
+    . = ALIGN(16);
+  .xtime_lock : AT ((LOADADDR(.vsyscall_timesource) + SIZEOF(.vsyscall_timesource) + 15) & ~(15)) { *(.xtime_lock) }
+  xtime_lock = LOADADDR(.xtime_lock);
+
+  . = ALIGN(16);
+  .xtime : AT ((LOADADDR(.xtime_lock) + SIZEOF(.xtime_lock) + 15) & ~(15)) { *(.xtime) }
+  xtime = LOADADDR(.xtime);
+
+  . = ALIGN(16);
+  .jiffies : AT ((LOADADDR(.xtime) + SIZEOF(.xtime) + 15) & ~(15)) { *(.jiffies) }
+  jiffies = LOADADDR(.jiffies);
+
+  . = ALIGN(16);
+  .wall_jiffies : AT ((LOADADDR(.jiffies) + SIZEOF(.jiffies) + 15) & ~(15)) { *(.wall_jiffies) }
+  wall_jiffies = LOADADDR(.wall_jiffies);
+  
+  .sys_tz : AT (LOADADDR(.wall_jiffies) + SIZEOF(.wall_jiffies)) { *(.sys_tz) }
+  sys_tz = LOADADDR(.sys_tz);
+  
+	/* NTP variables */
+  .tickadj : AT (LOADADDR(.sys_tz) + SIZEOF(.sys_tz)) { *(.tickadj) }
+  tickadj = LOADADDR(.tickadj);
+
+  .time_adjust : AT (LOADADDR(.tickadj) + SIZEOF(.tickadj)) { *(.time_adjust) }
+  time_adjust = LOADADDR(.time_adjust);
+
+	/* TSC variables*/
+  .last_tsc_low : AT (LOADADDR(.time_adjust) + SIZEOF(.time_adjust)) { *(.last_tsc_low) }
+  last_tsc_low = LOADADDR(.last_tsc_low);
+  
+  .tsc_delay_at_last_interrupt : AT (LOADADDR(.last_tsc_low) + SIZEOF(.last_tsc_low)) { *(.tsc_delay_at_last_interrupt) }
+  tsc_delay_at_last_interrupt = LOADADDR(.tsc_delay_at_last_interrupt);
+  
+  .fast_gettimeoffset_quotient : AT (LOADADDR(.tsc_delay_at_last_interrupt) + SIZEOF(.tsc_delay_at_last_interrupt)) { *(.fast_gettimeoffset_quotient) }
+  fast_gettimeoffset_quotient = LOADADDR(.fast_gettimeoffset_quotient);
+
+
+	/*cyclone values*/
+  .cyclone_timer : AT (LOADADDR(.fast_gettimeoffset_quotient) + SIZEOF(.fast_gettimeoffset_quotient))  { *(.cyclone_timer) }
+  cyclone_timer = LOADADDR(.cyclone_timer);
+
+  .last_cyclone_low : AT (LOADADDR(.cyclone_timer) + SIZEOF(.cyclone_timer)) { *(.last_cyclone_low) }
+  last_cyclone_low = LOADADDR(.last_cyclone_low);
+  
+  .cyclone_delay_at_last_interrupt : AT (LOADADDR(.last_cyclone_low) + SIZEOF(.last_cyclone_low)) { *(.cyclone_delay_at_last_interrupt) }
+  cyclone_delay_at_last_interrupt = LOADADDR(.cyclone_delay_at_last_interrupt);
+
+
+  .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT (LOADADDR(.vsyscall_0) + 1024) { *(.vsyscall_1) }
+  . = LOADADDR(.vsyscall_0) + 4096;
+  
+  jiffies_64 = jiffies;
+#else
+  jiffies = jiffies_64;
+#endif 
+/* END of VSYSCALL_GTOD data*/
+	
   . = ALIGN(8192);		/* init_task */
   .data.init_task : { *(.data.init_task) }
 
diff -Nru a/arch/i386/kernel/vsyscall-gtod.c b/arch/i386/kernel/vsyscall-gtod.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/vsyscall-gtod.c	Tue Jan 27 19:26:21 2004
@@ -0,0 +1,275 @@
+/*
+ *  linux/arch/i386/kernel/vsyscall-gtod.c
+ *
+ *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
+ *  Copyright (C) 2003,2004 John Stultz <johnstul@us.ibm.com> IBM 
+ *
+ *  Thanks to hpa@transmeta.com for some useful hint.
+ *  Special thanks to Ingo Molnar for his early experience with
+ *  a different vsyscall implementation for Linux/IA32 and for the name.
+ *
+ *  vsyscall 0 is located at VSYSCALL_START, vsyscall 1 is located
+ *  at virtual address VSYSCALL_START+1024bytes etc... 
+ *
+ *  Originally written for x86-64 by Andrea Arcangeli <andrea@suse.de>
+ *  Ported to i386 by John Stultz <johnstul@us.ibm.com>
+ */
+
+
+#include <linux/time.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/sched.h>
+
+#include <asm/vsyscall-gtod.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/msr.h>
+#include <asm/timer.h>
+#include <asm/system.h>
+#include <asm/unistd.h>
+#include <asm/errno.h>
+
+int errno;
+static inline _syscall2(int,gettimeofday,struct timeval *,tv,struct timezone *,tz);
+static int vsyscall_mapped = 0; /* flag variable for remap_vsyscall() */
+
+enum vsyscall_timesource_e vsyscall_timesource;
+enum vsyscall_timesource_e __vsyscall_timesource __section_vsyscall_timesource;
+
+/* readonly clones of generic time values */
+seqlock_t  __xtime_lock __section_xtime_lock  = SEQLOCK_UNLOCKED;
+struct timespec __xtime __section_xtime;
+volatile unsigned long __jiffies __section_jiffies;
+unsigned long __wall_jiffies __section_wall_jiffies;
+struct timezone __sys_tz __section_sys_tz;
+/* readonly clones of ntp time variables */
+int __tickadj __section_tickadj;
+long __time_adjust __section_time_adjust;
+
+/* readonly clones of TSC timesource values*/
+unsigned long __last_tsc_low __section_last_tsc_low;
+int __tsc_delay_at_last_interrupt __section_tsc_delay_at_last_interrupt;
+unsigned long __fast_gettimeoffset_quotient __section_fast_gettimeoffset_quotient;
+
+/* readonly clones of cyclone timesource values*/
+u32* __cyclone_timer __section_cyclone_timer;	/* Cyclone MPMC0 register */
+u32 __last_cyclone_low __section_last_cyclone_low;
+int __cyclone_delay_at_last_interrupt __section_cyclone_delay_at_last_interrupt;
+
+
+static inline unsigned long vgettimeoffset_tsc(void)
+{
+	unsigned long eax, edx;
+
+	/* Read the Time Stamp Counter */
+	rdtsc(eax,edx);
+
+	/* .. relative to previous jiffy (32 bits is enough) */
+	eax -= __last_tsc_low;	/* tsc_low delta */
+
+	/*
+	 * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
+	 *             = (tsc_low delta) * (usecs_per_clock)
+	 *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
+	 *
+	 * Using a mull instead of a divl saves up to 31 clock cycles
+	 * in the critical path.
+	 */
+
+
+	__asm__("mull %2"
+		:"=a" (eax), "=d" (edx)
+		:"rm" (__fast_gettimeoffset_quotient),
+		 "0" (eax));
+
+	/* our adjusted time offset in microseconds */
+	return __tsc_delay_at_last_interrupt + edx;
+
+}
+
+static inline unsigned long vgettimeoffset_cyclone(void)
+{
+	u32 offset;
+	
+	if (!__cyclone_timer)
+		return 0;
+
+	/* Read the cyclone timer */
+	offset = __cyclone_timer[0];
+
+	/* .. relative to previous jiffy */
+	offset = offset - __last_cyclone_low;
+
+	/* convert cyclone ticks to microseconds */	
+	offset = offset/(CYCLONE_TIMER_FREQ/1000000);
+
+	/* our adjusted time offset in microseconds */
+	return __cyclone_delay_at_last_interrupt + offset;
+}
+
+static inline void do_vgettimeofday(struct timeval * tv)
+{
+	long sequence;
+	unsigned long usec, sec;
+	unsigned long lost;
+	unsigned long max_ntp_tick;
+
+	/* If we don't have a valid vsyscall time source, 
+	 * just call gettimeofday()
+	 */
+	if (__vsyscall_timesource == VSYSCALL_GTOD_NONE) {
+		gettimeofday(tv, NULL);
+		return;
+	}
+	
+	
+	do {
+		sequence = read_seqbegin(&__xtime_lock);
+
+		/* Get the high-res offset */
+		if (__vsyscall_timesource == VSYSCALL_GTOD_CYCLONE)
+			usec = vgettimeoffset_cyclone();
+		else
+			usec = vgettimeoffset_tsc();
+
+		lost = __jiffies - __wall_jiffies;
+
+		/*
+		 * If time_adjust is negative then NTP is slowing the clock
+		 * so make sure not to go into next possible interval.
+		 * Better to lose some accuracy than have time go backwards..
+		 */
+		if (unlikely(__time_adjust < 0)) {
+			max_ntp_tick = (USEC_PER_SEC / HZ) - __tickadj;
+			usec = min(usec, max_ntp_tick);
+
+			if (lost)
+				usec += lost * max_ntp_tick;
+		}
+		else if (unlikely(lost))
+			usec += lost * (USEC_PER_SEC / HZ);
+
+		sec = __xtime.tv_sec;
+		usec += (__xtime.tv_nsec / 1000);
+
+	} while (read_seqretry(&__xtime_lock, sequence));
+
+	tv->tv_sec = sec + usec / 1000000;
+	tv->tv_usec = usec % 1000000;
+}
+
+static inline void do_get_tz(struct timezone * tz)
+{
+	long sequence;
+
+	do {
+		sequence = read_seqbegin(&__xtime_lock);
+
+		*tz = __sys_tz;
+
+	} while (read_seqretry(&__xtime_lock, sequence));
+}
+
+static int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
+{
+	if (tv)
+		do_vgettimeofday(tv);
+	if (tz)
+		do_get_tz(tz);
+	return 0;
+}
+
+static time_t __vsyscall(1) vtime(time_t * t)
+{
+	struct timeval tv; 
+	vgettimeofday(&tv,NULL); 
+	if (t)
+		*t = tv.tv_sec; 
+	return tv.tv_sec;
+}
+
+static long __vsyscall(2) venosys_0(void)
+{
+	return -ENOSYS;
+}
+
+static long __vsyscall(3) venosys_1(void)
+{
+	return -ENOSYS;
+}
+
+
+void vsyscall_set_timesource(char* name)
+{
+	if (!strncmp(name, "tsc", 3))
+		vsyscall_timesource = VSYSCALL_GTOD_TSC;
+	else if (!strncmp(name, "cyclone", 7))
+		vsyscall_timesource = VSYSCALL_GTOD_CYCLONE;
+	else
+		vsyscall_timesource = VSYSCALL_GTOD_NONE;
+}
+
+
+static void __init map_vsyscall(void)
+{
+	unsigned long physaddr_page0 = (unsigned long) &__vsyscall_0 - PAGE_OFFSET;
+
+	/* Initially we map the VSYSCALL page w/ PAGE_KERNEL permissions to
+	 * keep the alternate_instruction code from bombing out when it 
+	 * changes the seq_lock memory barriers in vgettimeofday()
+	 */
+	__set_fixmap(FIX_VSYSCALL_GTOD_FIRST_PAGE, physaddr_page0, PAGE_KERNEL);
+}
+
+static int __init remap_vsyscall(void)
+{
+	unsigned long physaddr_page0 = (unsigned long) &__vsyscall_0 - PAGE_OFFSET;
+
+	if (!vsyscall_mapped)
+		return 0;
+
+	/* Remap the VSYSCALL page w/ PAGE_KERNEL_VSYSCALL permissions 
+	 * after the alternate_instruction code has run
+	 */
+	clear_fixmap(FIX_VSYSCALL_GTOD_FIRST_PAGE);
+	__set_fixmap(FIX_VSYSCALL_GTOD_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
+
+	return 0;
+}
+
+int __init vsyscall_init(void)
+{
+	printk("VSYSCALL: consistency checks...");
+	if ((unsigned long) &vgettimeofday != VSYSCALL_ADDR(__NR_vgettimeofday)) {
+		printk("vgettimeofday link addr broken\n");
+		printk("VSYSCALL: vsyscall_init failed!\n");
+		return -EFAULT;
+	}
+	if ((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime)) {
+		printk("vtime link addr broken\n");
+		printk("VSYSCALL: vsyscall_init failed!\n");
+		return -EFAULT;
+	}
+	if (VSYSCALL_ADDR(0) != __fix_to_virt(FIX_VSYSCALL_GTOD_FIRST_PAGE)) {
+		printk("fixmap first vsyscall 0x%lx should be 0x%x\n", 
+			__fix_to_virt(FIX_VSYSCALL_GTOD_FIRST_PAGE),
+			VSYSCALL_ADDR(0));
+		printk("VSYSCALL: vsyscall_init failed!\n");
+		return -EFAULT;
+	}
+
+
+	printk("passed...mapping...");
+	map_vsyscall();
+	printk("done.\n");
+	vsyscall_mapped = 1;
+	printk("VSYSCALL: fixmap virt addr: 0x%lx\n",
+		__fix_to_virt(FIX_VSYSCALL_GTOD_FIRST_PAGE));
+
+	return 0;
+}
+
+__initcall(remap_vsyscall);
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Tue Jan 27 19:26:21 2004
+++ b/include/asm-i386/fixmap.h	Tue Jan 27 19:26:21 2004
@@ -18,6 +18,7 @@
 #include <asm/acpi.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
+#include <asm/vsyscall-gtod.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -44,6 +45,17 @@
 enum fixed_addresses {
 	FIX_HOLE,
 	FIX_VSYSCALL,
+#ifdef CONFIG_VSYSCALL_GTOD
+#ifndef CONFIG_X86_4G
+	FIX_VSYSCALL_GTOD_PAD,
+#endif /* !CONFIG_X86_4G */
+	FIX_VSYSCALL_GTOD_LAST_PAGE,
+	FIX_VSYSCALL_GTOD_FIRST_PAGE = FIX_VSYSCALL_GTOD_LAST_PAGE
+					+ VSYSCALL_GTOD_NUMPAGES - 1,
+#ifdef CONFIG_X86_4G
+	FIX_VSYSCALL_GTOD_4GALIGN,
+#endif /* CONFIG_X86_4G */
+#endif /* CONFIG_VSYSCALL_GTOD */
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
diff -Nru a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	Tue Jan 27 19:26:21 2004
+++ b/include/asm-i386/pgtable.h	Tue Jan 27 19:26:21 2004
@@ -137,11 +137,15 @@
 #define __PAGE_KERNEL_RO	(__PAGE_KERNEL & ~_PAGE_RW)
 #define __PAGE_KERNEL_NOCACHE	(__PAGE_KERNEL | _PAGE_PCD)
 #define __PAGE_KERNEL_LARGE	(__PAGE_KERNEL | _PAGE_PSE)
-
+#define __PAGE_KERNEL_VSYSCALL \
+	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
+	
 #define PAGE_KERNEL		__pgprot(__PAGE_KERNEL)
 #define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO)
 #define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE)
 #define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE)
+#define PAGE_KERNEL_VSYSCALL __pgprot(__PAGE_KERNEL_VSYSCALL)
+#define PAGE_KERNEL_VSYSCALL_NOCACHE __pgprot(__PAGE_KERNEL_VSYSCALL|(__PAGE_KERNEL_RO | _PAGE_PCD))
 
 /*
  * The i386 can't do page protection for execute, and considers that
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Tue Jan 27 19:26:21 2004
+++ b/include/asm-i386/timer.h	Tue Jan 27 19:26:21 2004
@@ -20,6 +20,7 @@
 };
 
 #define TICK_SIZE (tick_nsec / 1000)
+#define CYCLONE_TIMER_FREQ 100000000
 
 extern struct timer_opts* select_timer(void);
 extern void clock_fallback(void);
diff -Nru a/include/asm-i386/vsyscall-gtod.h b/include/asm-i386/vsyscall-gtod.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/vsyscall-gtod.h	Tue Jan 27 19:26:21 2004
@@ -0,0 +1,68 @@
+#ifndef _ASM_i386_VSYSCALL_GTOD_H_
+#define _ASM_i386_VSYSCALL_GTOD_H_
+#include <linux/seqlock.h>
+
+#ifdef CONFIG_VSYSCALL_GTOD
+
+/* VSYSCALL_GTOD_START must be the same as 
+ * __fix_to_virt(FIX_VSYSCALL_GTOD FIRST_PAGE) 
+ * and must also be same as addr in vmlinux.lds.S */
+#define VSYSCALL_GTOD_START 0xffffc000  
+#define VSYSCALL_GTOD_SIZE 1024
+#define VSYSCALL_GTOD_END (VSYSCALL_GTOD_START + PAGE_SIZE)
+#define VSYSCALL_GTOD_NUMPAGES \
+	((VSYSCALL_GTOD_END-VSYSCALL_GTOD_START) >> PAGE_SHIFT)
+#define VSYSCALL_ADDR(vsyscall_nr) \
+	(VSYSCALL_GTOD_START+VSYSCALL_GTOD_SIZE*(vsyscall_nr))
+
+#ifdef __KERNEL__
+
+#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
+
+/* ReadOnly generic time value attributes*/
+#define __section_vsyscall_timesource __attribute__ ((unused, __section__ (".vsyscall_timesource")))
+#define __section_xtime_lock __attribute__ ((unused, __section__ (".xtime_lock")))
+#define __section_xtime __attribute__ ((unused, __section__ (".xtime")))
+#define __section_jiffies __attribute__ ((unused, __section__ (".jiffies")))
+#define __section_wall_jiffies __attribute__ ((unused, __section__ (".wall_jiffies")))
+#define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz")))
+
+/* ReadOnly NTP variables */
+#define __section_tickadj __attribute__ ((unused, __section__ (".tickadj")))
+#define __section_time_adjust __attribute__ ((unused, __section__ (".time_adjust")))
+
+
+/* ReadOnly TSC time value attributes*/
+#define __section_last_tsc_low	__attribute__ ((unused, __section__ (".last_tsc_low")))
+#define __section_tsc_delay_at_last_interrupt	__attribute__ ((unused, __section__ (".tsc_delay_at_last_interrupt")))
+#define __section_fast_gettimeoffset_quotient	__attribute__ ((unused, __section__ (".fast_gettimeoffset_quotient")))
+
+/* ReadOnly Cyclone time value attributes*/
+#define __section_cyclone_timer __attribute__ ((unused, __section__ (".cyclone_timer")))
+#define __section_last_cyclone_low __attribute__ ((unused, __section__ (".last_cyclone_low")))
+#define __section_cyclone_delay_at_last_interrupt	__attribute__ ((unused, __section__ (".cyclone_delay_at_last_interrupt")))
+
+enum vsyscall_num {
+	__NR_vgettimeofday,
+	__NR_vtime,
+};
+
+enum vsyscall_timesource_e {
+	VSYSCALL_GTOD_NONE,
+	VSYSCALL_GTOD_TSC,
+	VSYSCALL_GTOD_CYCLONE,
+};
+
+int vsyscall_init(void);
+void vsyscall_set_timesource(char* name);
+
+extern char __vsyscall_0;
+
+
+#endif /* __KERNEL__ */
+#else /* CONFIG_VSYSCALL_GTOD */
+#define vsyscall_init() 
+#define vsyscall_set_timesource(x)
+#endif /* CONFIG_VSYSCALL_GTOD */
+#endif /* _ASM_i386_VSYSCALL_GTOD_H_ */
+


--=-FVjz4JvI5Kv9YfiVu8rl
Content-Disposition: attachment; filename=vsyscall-gtod_test_B1.tar.gz
Content-Type: application/x-compressed-tar; name=vsyscall-gtod_test_B1.tar.gz
Content-Transfer-Encoding: base64

H4sICFQsF0AAA3ZzeXNjYWxsLWd0b2RfdGVzdF9CMS50YXIA7Zdfb9owEMB5JZ/iRNUpARISCEQa
ZdLW7qESpVUntJdJKEsMZDMxip1odNp335nwH1qkibXq5t9DIt+d72xfbF8yPuOBT6k5EiwcCMLF
4INTK5wU23Ztr9nEt217LXfrvaDg4MN16l7LsQu206yjOTRPO4zDpFz4CUDhGxcpFQ+P2h3Tv1Ky
g/lfSq3gFDFsTG7LdR/Nf93zdvLv1VEN9imCH+M/z/9ZFAc0DQlccBFGzBq/07ZENPoqZVrGohD0
svwwDJ2LJA0EiGhCMp+Wq7AjMKADuuxRNuwfQyTA7Pa77YWbERHSkg1Df7brC0QGe/5APBjaT624
jC+yKkra2i/tpZfv1XN4/9/438kwouQ0MY7t/4bTKMgLouHVXddGudPyGnW1/58DTP1brTgKAjCH
d9eXYCbhLPYnEbZHYOLzM1rA+j5Y2PKxn5AQUE1NzrADqa5sOLMcMBlsCSwbhSsJA5OiFxrS3J/8
+Ez58VmB7LlqalpAiR/jCJMJlK0Nzb53dRb8CYf3/0Y+ThDjyP53nIaH+7/lNFpNx3Pk/vcasv5T
+//v8/T9P+M1eQfPK4CzEK+EmECvfzO47/c+gZOnb6W4ub68v11JtSgWMPGjWJ9f3ds3OshFF/Ke
Z9MqoKCtFaV9hO805tEoxsOFsniUP0JChY+qIWW+gClJAhILbK8txGSK7a3C4s0iRq/f7RqyM0v0
qGO3IYKL1SSwVakYWnGnK45o3XHXqxzyUicnxqaWyAac4NHVySe2aLfX2nRXneb6+cxktbQ/a2PD
czlfWxxnsfKkbe5WKy7WSHqeL5oxD1TTl/OuOHL00wQXfaiXNmcIOpxTmqYcanAeJRgLZDl3Pkz5
l7hUlWOY+6qu1rC6zAi6BCQhIk1isFV99go4fP5j2i0+PlUMef4/9f+Pv3vL+q9pNz1Z/7muOv+f
BRKMGZR6LJngqbx5DpQ0a10GaLnZ8mOB7tXg7v5j9/b91U6ftaJj1fYLwE2XLz1zhUKhUCgUCoVC
oVAoFAqFQqH4t/kN/oOgqQAoAAA=

--=-FVjz4JvI5Kv9YfiVu8rl--

