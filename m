Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSJ1Wd6>; Mon, 28 Oct 2002 17:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSJ1Wd6>; Mon, 28 Oct 2002 17:33:58 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:15563 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261688AbSJ1Wdl>;
	Mon, 28 Oct 2002 17:33:41 -0500
Subject: [PATCH] linux_2.5.44_vsyscall_A1
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, andrea <andrea@suse.de>, ak@muc.de,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>, Jeff Dike <jdike@karaya.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Oct 2002 14:29:15 -0800
Message-Id: <1035844155.984.77.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, 

	Here is the current rev of the i386 vsyscall gettimeofday port synced
up w/ today's BK. Same as last time, this patch contains a fix for the
linker trouble in _A0, as well as wraps the whole thing in
CONFIG_VSYSCALL.

This patch implements gettimeofday in a user readable page, allowing for
calls to gettimeofday to execute completely in userspace, giving a
significant performance boost.
        
Changes to glibc are unnecessary, because users that want to use the
vsyscall can do so by LD_PRELOADING a library which alias gettimeofday
before executing their application. This will not affect any other
application and allows the backward compatibility issue to be ignored.
I've created an example library (to be attached in a following email)
and ran a quick performance test w/ and w/o the preloaded library,
giving the following results:

[jstultz@elm3b52 vsyscall_test]$ ./run.sh 
Normal gettimeofday
gettimeofday ( 1388049us / 1000000runs ) = 1.388048us
vsyscall LD_PRELOAD gettimeofday
gettimeofday ( 286024us / 1000000runs ) = 0.286024us

Since this code uses the TSC for calculating time of day, this patch
will not help systems that suffer from TSC skew (ie: many NUMA systems,
etc). However, for UP and SMP boxes this is a pretty major win.
Alternative methods to use the cyclone/HPET registers for NUMA boxes are
also feasible in the future. 

Please consider for 2.5 integration. 

thanks
-john

diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Mon Oct 28 14:25:09 2002
+++ b/arch/i386/kernel/Makefile	Mon Oct 28 14:25:09 2002
@@ -29,6 +29,7 @@
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
+obj-$(CONFIG_VSYSCALL)		+= vsyscall.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Oct 28 14:25:09 2002
+++ b/arch/i386/kernel/time.c	Mon Oct 28 14:25:09 2002
@@ -69,8 +69,15 @@
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
 
 extern rwlock_t xtime_lock;
+#ifdef CONFIG_VSYSCALL
+unsigned long __wall_jiffies __section_wall_jiffies;
+struct timespec __xtime __section_xtime;
+struct timezone __sys_tz __section_sys_tz;
+volatile unsigned long __jiffies __section_jiffies;
+#else /* CONFIG_VSYSCALL */
 extern unsigned long wall_jiffies;
-
+#endif /* CONFIG_VSYSCALL */
+ 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
@@ -110,6 +117,7 @@
 void do_settimeofday(struct timeval *tv)
 {
 	write_lock_irq(&xtime_lock);
+	vxtime_lock();
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -126,6 +134,8 @@
 
 	xtime.tv_sec = tv->tv_sec;
 	xtime.tv_nsec = (tv->tv_usec * 1000);
+	vxtime_unlock();
+
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -277,11 +287,11 @@
 	 * locally disabled. -arca
 	 */
 	write_lock(&xtime_lock);
-
+	vxtime_lock();
 	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
-
+	vxtime_unlock();
 	write_unlock(&xtime_lock);
 
 }
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Oct 28 14:25:09 2002
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Oct 28 14:25:09 2002
@@ -10,23 +10,28 @@
 #include <linux/cpufreq.h>
 
 #include <asm/timer.h>
+#include <asm/vsyscall.h>
 #include <asm/io.h>
 
 extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
 
 static int use_tsc;
+#ifndef CONFIG_VSYSCALL
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
-
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
 unsigned long fast_gettimeoffset_quotient;
+#else /* CONFIG_VSYSCALL */
+int __delay_at_last_interrupt __section_delay_at_last_interrupt;
+unsigned long __last_tsc_low __section_last_tsc_low;
+unsigned long __fast_gettimeoffset_quotient __section_fast_gettimeoffset_quotient;
+#endif /* CONFIG_VSYSCALL */
 
 static unsigned long get_offset_tsc(void)
 {
diff -Nru a/arch/i386/kernel/vsyscall.c b/arch/i386/kernel/vsyscall.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/vsyscall.c	Mon Oct 28 14:25:09 2002
@@ -0,0 +1,199 @@
+/*
+ *  linux/arch/x86_64/kernel/vsyscall.c
+ *
+ *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
+ *
+ *  Thanks to hpa@transmeta.com for some useful hint.
+ *  Special thanks to Ingo Molnar for his early experience with
+ *  a different vsyscall implementation for Linux/IA32 and for the name.
+ *
+ *  vsyscall 1 is located at 0xffffe000, vsyscall 2 is located
+ *  at virtual address 0xffffe000+1024bytes etc... There are at max 8192
+ *  vsyscalls. One vsyscall can reserve more than 1 slot to avoid
+ *  jumping out of line if necessary.
+ *
+ *  $Id: vsyscall.c,v 1.9 2002/03/21 13:42:58 ak Exp $
+ *
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
+#include <asm/vsyscall.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/errno.h>
+#include <asm/msr.h>
+#include <asm/system.h>
+
+#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
+
+//#define NO_VSYSCALL 1
+
+#ifdef NO_VSYSCALL
+#include <asm/unistd.h>
+
+static int errno __section_vxtime_sequence; 
+
+static inline _syscall2(int,gettimeofday,struct timeval *,tv,struct timezone *,tz)
+
+#else
+long __vxtime_sequence[2] __section_vxtime_sequence;
+
+static inline void do_vgettimeofday(struct timeval * tv)
+{
+	long sequence;
+	unsigned long usec, sec;
+
+	do {
+		unsigned long eax, edx;
+
+		sequence = __vxtime_sequence[1];
+		rmb();
+		
+		/* Read the Time Stamp Counter */
+		rdtsc(eax,edx);
+
+		/* .. relative to previous jiffy (32 bits is enough) */
+		eax -= __last_tsc_low;	/* tsc_low delta */
+
+		/*
+		 * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
+		 *             = (tsc_low delta) * (usecs_per_clock)
+		 *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
+		 *
+		 * Using a mull instead of a divl saves up to 31 clock cycles
+		 * in the critical path.
+		 */
+
+
+		__asm__("mull %2"
+			:"=a" (eax), "=d" (edx)
+			:"rm" (__fast_gettimeoffset_quotient),
+			 "0" (eax));
+
+		/* our adjusted time offset in microseconds */
+		usec = __delay_at_last_interrupt + edx;
+
+		{
+			unsigned long lost = __jiffies - __wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		sec = __xtime.tv_sec;
+		usec += (__xtime.tv_nsec / 1000);;
+
+		rmb();
+	} while (sequence != __vxtime_sequence[0]);
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
+		sequence = __vxtime_sequence[1];
+		rmb();
+
+		*tz = __sys_tz;
+
+		rmb();
+	} while (sequence != __vxtime_sequence[0]);
+}
+#endif
+
+static int __vsyscall(0) vgettimeofday(struct timeval * tv, struct timezone * tz)
+{
+#ifdef NO_VSYSCALL
+	return gettimeofday(tv,tz); 
+#else
+	if (tv)
+		do_vgettimeofday(tv);
+	if (tz)
+		do_get_tz(tz);
+	return 0;
+#endif
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
+static void __init map_vsyscall(void)
+{
+	extern char __vsyscall_0;
+	unsigned long physaddr_page0 = (unsigned long) &__vsyscall_0 - __START_KERNEL_map;
+	pgd_t* pd;
+	pmd_t* pm;
+
+	__set_fixmap(VSYSCALL_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
+
+	/*
+	 * Set vsyscall's fixmap pmd to be user readable:
+	 * XXX HACK ALERT: this assumes non-vsyscall kernel space 
+	 * pte's will not have their userbit set. Otherwise this could
+	 * be a security problem.  Is this ok? Please advise -johnstul@us.ibm.com
+	 */
+	pd = pgd_offset_k((unsigned long)&__last_tsc_low);
+	pm = pmd_offset(pd,(unsigned long)&__last_tsc_low);
+	pm->pmd |= _PAGE_USER;
+
+}
+
+static int __init vsyscall_init(void)
+{
+	printk("VSYSCALL: consistency checks...");
+	if ((unsigned long) &vgettimeofday != VSYSCALL_ADDR(__NR_vgettimeofday))
+		panic("vgettimeofday link addr broken");
+	if ((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime))
+		panic("vtime link addr broken");
+	if (VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE))
+		panic("fixmap first vsyscall %lx should be %lx", __fix_to_virt(VSYSCALL_FIRST_PAGE),
+		      VSYSCALL_ADDR(0));
+
+	/* XXX: we'll also need to make sure the TSC is 
+	 * the in use timesource once there are others.
+	 *     -johnstul@us.ibm.com
+	 */
+
+	if(!cpu_has_tsc){
+		printk("FAILED!\nVSYSCALL: CPU has no TSC, cannot use vsyscall.\n");
+		return 0;
+	}
+	
+	printk("passed...mapping...");
+	map_vsyscall();
+	printk("done.\n");
+	
+	printk("VSYSCALL: fixmap virt addr: 0x%lx\n",
+		__fix_to_virt(VSYSCALL_FIRST_PAGE));
+
+	return 0;
+}
+
+__initcall(vsyscall_init);
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Mon Oct 28 14:25:09 2002
+++ b/arch/i386/vmlinux.lds.S	Mon Oct 28 14:25:09 2002
@@ -4,7 +4,7 @@
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
-jiffies = jiffies_64;
+jiffies_64 = jiffies;
 SECTIONS
 {
   . = 0xC0000000 + 0x100000;
@@ -54,6 +54,34 @@
 
   _edata = .;			/* End of data section */
 
+	/* VSYSCALL data */
+   . = ALIGN(64);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .vsyscall_0 0xffffe000: AT ((LOADADDR(.data.cacheline_aligned) + SIZEOF(.data.cacheline_aligned) + 4095) & ~(4095)) { *(.vsyscall_0) }
+  __vsyscall_0 = LOADADDR(.vsyscall_0);
+  . = ALIGN(64);
+  .vxtime_sequence : AT ((LOADADDR(.vsyscall_0) + SIZEOF(.vsyscall_0) + 63) & ~(63)) { *(.vxtime_sequence) }
+  vxtime_sequence = LOADADDR(.vxtime_sequence);
+  .last_tsc_low : AT (LOADADDR(.vxtime_sequence) + SIZEOF(.vxtime_sequence)) { *(.last_tsc_low) }
+  last_tsc_low = LOADADDR(.last_tsc_low);
+  .delay_at_last_interrupt : AT (LOADADDR(.last_tsc_low) + SIZEOF(.last_tsc_low)) { *(.delay_at_last_interrupt) }
+  delay_at_last_interrupt = LOADADDR(.delay_at_last_interrupt);
+  .fast_gettimeoffset_quotient : AT (LOADADDR(.delay_at_last_interrupt) + SIZEOF(.delay_at_last_interrupt)) { *(.fast_gettimeoffset_quotient) }
+  fast_gettimeoffset_quotient = LOADADDR(.fast_gettimeoffset_quotient);
+  .wall_jiffies : AT (LOADADDR(.fast_gettimeoffset_quotient) + SIZEOF(.fast_gettimeoffset_quotient)) { *(.wall_jiffies) }
+  wall_jiffies = LOADADDR(.wall_jiffies);
+  .sys_tz : AT (LOADADDR(.wall_jiffies) + SIZEOF(.wall_jiffies)) { *(.sys_tz) }
+  sys_tz = LOADADDR(.sys_tz);
+  . = ALIGN(16);
+  .jiffies : AT ((LOADADDR(.sys_tz) + SIZEOF(.sys_tz) + 15) & ~(15)) { *(.jiffies) }
+  jiffies = LOADADDR(.jiffies);
+  . = ALIGN(16);
+  .xtime : AT ((LOADADDR(.jiffies) + SIZEOF(.jiffies) + 15) & ~(15)) { *(.xtime) }
+  xtime = LOADADDR(.xtime);
+  .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT (LOADADDR(.vsyscall_0) + 1024) { *(.vsyscall_1) }
+  . = LOADADDR(.vsyscall_0) + 4096;
+	/* END of VSYSCALL data*/
+	
   . = ALIGN(8192);		/* init_task */
   .data.init_task : { *(.data.init_task) }
 
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Mon Oct 28 14:25:09 2002
+++ b/include/asm-i386/fixmap.h	Mon Oct 28 14:25:09 2002
@@ -18,6 +18,7 @@
 #include <asm/acpi.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
+#include <asm/vsyscall.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -49,6 +50,10 @@
  * fix-mapped?
  */
 enum fixed_addresses {
+#ifdef CONFIG_VSYSCALL
+	VSYSCALL_LAST_PAGE,
+	VSYSCALL_FIRST_PAGE = VSYSCALL_LAST_PAGE + ((VSYSCALL_END-VSYSCALL_START) >> PAGE_SHIFT) - 1,
+#endif /* CONFIG_VSYSCALL */
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
diff -Nru a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	Mon Oct 28 14:25:09 2002
+++ b/include/asm-i386/pgtable.h	Mon Oct 28 14:25:09 2002
@@ -139,11 +139,14 @@
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
 
 /*
  * The i386 can't do page protection for execute, and considers that
diff -Nru a/include/asm-i386/vsyscall.h b/include/asm-i386/vsyscall.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/vsyscall.h	Mon Oct 28 14:25:09 2002
@@ -0,0 +1,53 @@
+#ifndef _ASM_i386_VSYSCALL_H_
+#define _ASM_i386_VSYSCALL_H_
+
+#ifdef CONFIG_VSYSCALL
+enum vsyscall_num {
+	__NR_vgettimeofday,
+	__NR_vtime,
+};
+
+#define VSYSCALL_START 0xffffe000
+#define VSYSCALL_SIZE 1024
+#define VSYSCALL_END (0xffffe000 + PAGE_SIZE)
+#define VSYSCALL_ADDR(vsyscall_nr) (VSYSCALL_START+VSYSCALL_SIZE*(vsyscall_nr))
+
+#ifdef __KERNEL__
+#define __START_KERNEL_map 0xC0000000
+
+#define __section_last_tsc_low	__attribute__ ((unused, __section__ (".last_tsc_low")))
+#define __section_delay_at_last_interrupt	__attribute__ ((unused, __section__ (".delay_at_last_interrupt")))
+#define __section_fast_gettimeoffset_quotient	__attribute__ ((unused, __section__ (".fast_gettimeoffset_quotient")))
+#define __section_wall_jiffies __attribute__ ((unused, __section__ (".wall_jiffies")))
+#define __section_jiffies __attribute__ ((unused, __section__ (".jiffies")))
+#define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz")))
+#define __section_xtime __attribute__ ((unused, __section__ (".xtime")))
+#define __section_vxtime_sequence __attribute__ ((unused, __section__ (".vxtime_sequence")))
+
+/* vsyscall space (readonly) */
+extern long __vxtime_sequence[2];
+extern int __delay_at_last_interrupt;
+extern unsigned long __last_tsc_low;
+extern unsigned long __fast_gettimeoffset_quotient;
+extern struct timespec __xtime;
+extern volatile unsigned long __jiffies;
+extern unsigned long __wall_jiffies;
+extern struct timezone __sys_tz;
+
+/* kernel space (writeable) */
+extern unsigned long last_tsc_low;
+extern int delay_at_last_interrupt;
+extern unsigned long fast_gettimeoffset_quotient;
+extern unsigned long wall_jiffies;
+extern struct timezone sys_tz;
+extern long vxtime_sequence[2];
+
+#define vxtime_lock() do { vxtime_sequence[0]++; wmb(); } while(0)
+#define vxtime_unlock() do { wmb(); vxtime_sequence[1]++; } while (0)
+
+#endif /* __KERNEL__ */
+#else /* CONFIG_VSYSCALL */
+#define vxtime_lock() 
+#define vxtime_unlock()
+#endif /* CONFIG_VSYSCALL */
+#endif /* _ASM_i386_VSYSCALL_H_ */
diff -Nru a/init/Config.in b/init/Config.in
--- a/init/Config.in	Mon Oct 28 14:25:09 2002
+++ b/init/Config.in	Mon Oct 28 14:25:09 2002
@@ -9,6 +9,9 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+bool 'VSYSCALL interface' CONFIG_VSYSCALL
+fi
 endmenu
 
 mainmenu_option next_comment

