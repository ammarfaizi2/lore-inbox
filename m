Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUCDAPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUCDAPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:15:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57229 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261310AbUCDANd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:13:33 -0500
Subject: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part2 (2/3)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1078359137.10076.193.camel@cog.beaverton.ibm.com>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
	 <1078359137.10076.193.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1078359191.10076.195.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 16:13:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This is the core vsyscall-gtod implementation. It depends on the
vsyscall-gtod_B3-part1 patch.

thanks
-john

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Wed Mar  3 15:37:34 2004
+++ b/arch/i386/Kconfig	Wed Mar  3 15:37:34 2004
@@ -435,6 +435,10 @@
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
--- a/arch/i386/kernel/Makefile	Wed Mar  3 15:37:34 2004
+++ b/arch/i386/kernel/Makefile	Wed Mar  3 15:37:34 2004
@@ -32,6 +32,7 @@
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_VSYSCALL_GTOD)	+= vsyscall-gtod.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Wed Mar  3 15:37:34 2004
+++ b/arch/i386/kernel/setup.c	Wed Mar  3 15:37:34 2004
@@ -47,6 +47,7 @@
 #include <asm/sections.h>
 #include <asm/io_apic.h>
 #include <asm/ist.h>
+#include <asm/vsyscall-gtod.h>
 #include "setup_arch_pre.h"
 #include "mach_resources.h"
 
@@ -1159,6 +1160,7 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+	vsyscall_init();
 }
 
 #include "setup_arch_post.h"
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Wed Mar  3 15:37:34 2004
+++ b/arch/i386/kernel/time.c	Wed Mar  3 15:37:34 2004
@@ -393,5 +393,8 @@
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	/* set vsyscall to use selected time source */
+	vsyscall_set_timesource(cur_timer->name);
+
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Wed Mar  3 15:37:34 2004
+++ b/arch/i386/kernel/timers/timer.c	Wed Mar  3 15:37:34 2004
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <asm/timer.h>
+#include <asm/vsyscall-gtod.h>
 
 #ifdef CONFIG_HPET_TIMER
 /*
@@ -44,6 +45,9 @@
 void clock_fallback(void)
 {
 	cur_timer = &timer_pit;
+
+	/* set vsyscall to use selected time source */
+	vsyscall_set_timesource(cur_timer->name);
 }
 
 /* iterates through the list of timers, returning the first 
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Wed Mar  3 15:37:34 2004
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Wed Mar  3 15:37:34 2004
@@ -23,6 +23,13 @@
 /* Number of usecs that the last interrupt was delayed */
 int cyclone_delay_at_last_interrupt;
 
+/* FIXMAP flag  */
+#ifdef CONFIG_VSYSCALL_GTOD
+#define PAGE_CYCLONE PAGE_KERNEL_VSYSCALL_NOCACHE
+#else
+#define PAGE_CYCLONE PAGE_KERNEL_NOCACHE
+#endif
+
 #define CYCLONE_CBAR_ADDR 0xFEB00CD0
 #define CYCLONE_PMCC_OFFSET 0x51A0
 #define CYCLONE_MPMC_OFFSET 0x51D0
@@ -192,7 +199,7 @@
 	/* map in cyclone_timer */
 	pageaddr = (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
 	offset = (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
-	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
+	__set_fixmap(FIX_CYCLONE_TIMER, pageaddr, PAGE_CYCLONE);
 	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
 	if(!cyclone_timer){
 		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
diff -Nru a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S	Wed Mar  3 15:37:34 2004
+++ b/arch/i386/kernel/vmlinux.lds.S	Wed Mar  3 15:37:34 2004
@@ -3,11 +3,12 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
-	
+#include <linux/config.h>
+#include <asm/vsyscall-gtod.h>
+
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(startup_32)
-jiffies = jiffies_64;
 SECTIONS
 {
   . = 0xC0000000 + 0x100000;
@@ -47,6 +48,79 @@
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
   _edata = .;			/* End of data section */
+
+/* VSYSCALL_GTOD data */
+#ifdef CONFIG_VSYSCALL_GTOD
+
+	/* vsyscall entry */
+   . = ALIGN(64);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  .vsyscall_0 VSYSCALL_GTOD_START: AT ((LOADADDR(.data.cacheline_aligned) + SIZEOF(.data.cacheline_aligned) + 4095) & ~(4095)) { *(.vsyscall_0) }
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
 
   . = ALIGN(8192);		/* init_task */
   .data.init_task : { *(.data.init_task) }
diff -Nru a/arch/i386/kernel/vsyscall-gtod.c b/arch/i386/kernel/vsyscall-gtod.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/vsyscall-gtod.c	Wed Mar  3 15:37:34 2004
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
--- a/include/asm-i386/fixmap.h	Wed Mar  3 15:37:34 2004
+++ b/include/asm-i386/fixmap.h	Wed Mar  3 15:37:34 2004
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
--- a/include/asm-i386/pgtable.h	Wed Mar  3 15:37:34 2004
+++ b/include/asm-i386/pgtable.h	Wed Mar  3 15:37:34 2004
@@ -137,11 +137,15 @@
 #define __PAGE_KERNEL_RO	(__PAGE_KERNEL & ~_PAGE_RW)
 #define __PAGE_KERNEL_NOCACHE	(__PAGE_KERNEL | _PAGE_PCD)
 #define __PAGE_KERNEL_LARGE	(__PAGE_KERNEL | _PAGE_PSE)
+#define __PAGE_KERNEL_VSYSCALL \
+	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 
 #define PAGE_KERNEL		__pgprot(__PAGE_KERNEL)
 #define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO)
 #define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE)
 #define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE)
+#define PAGE_KERNEL_VSYSCALL __pgprot(__PAGE_KERNEL_VSYSCALL)
+#define PAGE_KERNEL_VSYSCALL_NOCACHE __pgprot(__PAGE_KERNEL_VSYSCALL|(__PAGE_KERNEL_RO | _PAGE_PCD))
 
 /*
  * The i386 can't do page protection for execute, and considers that
diff -Nru a/include/asm-i386/vsyscall-gtod.h b/include/asm-i386/vsyscall-gtod.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/vsyscall-gtod.h	Wed Mar  3 15:37:34 2004
@@ -0,0 +1,68 @@
+#ifndef _ASM_i386_VSYSCALL_GTOD_H_
+#define _ASM_i386_VSYSCALL_GTOD_H_
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
+#ifndef __ASSEMBLY__
+#include <linux/seqlock.h>
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
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#else /* CONFIG_VSYSCALL_GTOD */
+#define vsyscall_init()
+#define vsyscall_set_timesource(x)
+#endif /* CONFIG_VSYSCALL_GTOD */
+#endif /* _ASM_i386_VSYSCALL_GTOD_H_ */
+


