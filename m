Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbSJRE16>; Fri, 18 Oct 2002 00:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbSJRE16>; Fri, 18 Oct 2002 00:27:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:64213 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262886AbSJRE1w>; Fri, 18 Oct 2002 00:27:52 -0400
Subject: [RFC][PATCH] linux-2.5.34_vsyscall_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, andrea <andrea@suse.de>
Cc: Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Oct 2002 21:25:31 -0700
Message-Id: <1034915132.1681.144.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Andrea, all,

	This is a port of Andrea's x86-64 vsyscall(userspace) gettimeofday to
i386. Its fairly untested, but it works here! I'm sure it probably has a
few bugs, but since a number of folks are wanting this, I figured I'd go
ahead and post and just take the abuse. 

I realize that this is probably in the "too late" category, but please
give any feedback you can and I'll try my best to get this ready to go
before sunday night. 

A small test application will follow shortly.

All comments/flames/etc emphatically requested. 

thanks
-john

diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Thu Oct 17 21:25:02 2002
+++ b/arch/i386/kernel/Makefile	Thu Oct 17 21:25:02 2002
@@ -9,7 +9,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
-		bootflag.o
+		bootflag.o vsyscall.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Thu Oct 17 21:25:02 2002
+++ b/arch/i386/kernel/time.c	Thu Oct 17 21:25:02 2002
@@ -69,7 +69,10 @@
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
 
 extern rwlock_t xtime_lock;
-extern unsigned long wall_jiffies;
+struct timespec __xtime __section_xtime;
+unsigned long __wall_jiffies __section_wall_jiffies;
+struct timezone __sys_tz __section_sys_tz;
+volatile unsigned long __jiffies __section_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
@@ -110,6 +113,7 @@
 void do_settimeofday(struct timeval *tv)
 {
 	write_lock_irq(&xtime_lock);
+	vxtime_lock();
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -126,6 +130,8 @@
 
 	xtime.tv_sec = tv->tv_sec;
 	xtime.tv_nsec = (tv->tv_usec * 1000);
+	vxtime_unlock();
+
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -277,11 +283,11 @@
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
--- a/arch/i386/kernel/timers/timer_tsc.c	Thu Oct 17 21:25:02 2002
+++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Oct 17 21:25:02 2002
@@ -10,6 +10,7 @@
 #include <linux/cpufreq.h>
 
 #include <asm/timer.h>
+#include <asm/vsyscall.h>
 #include <asm/io.h>
 
 extern int x86_udelay_tsc;
@@ -17,16 +18,16 @@
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
+int __delay_at_last_interrupt __section_delay_at_last_interrupt;
 
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+unsigned long __last_tsc_low __section_last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
  * Initialized in time_init.
  */
-unsigned long fast_gettimeoffset_quotient;
+unsigned long __fast_gettimeoffset_quotient __section_fast_gettimeoffset_quotient;
 
 static unsigned long get_offset_tsc(void)
 {
diff -Nru a/arch/i386/kernel/vsyscall.c b/arch/i386/kernel/vsyscall.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/vsyscall.c	Thu Oct 17 21:25:02 2002
@@ -0,0 +1,203 @@
+/*
+ *  linux/arch/x86_64/kernel/vsyscall.c
+ *
+ *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
+ *
+ *  Thanks to hpa@transmeta.com for some useful hint.
+ *  Special thanks to Ingo Molnar for his early experience with
+ *  a different vsyscall implementation for Linux/IA32 and for the name.
+ *
+ *  vsyscall 1 is located at -10Mbyte, vsyscall 2 is located
+ *  at virtual address -10Mbyte+1024bytes etc... There are at max 8192
+ *  vsyscalls. One vsyscall can reserve more than 1 slot to avoid
+ *  jumping out of line if necessary.
+ *
+ *  $Id: vsyscall.c,v 1.9 2002/03/21 13:42:58 ak Exp $
+ *
+ *  Ported to i386 by John Stultz <johnstul@us.ibm.com>
+ */
+
+/*
+ * TODO 2001-03-20:
+ *
+ * 1) make page fault handler detect faults on page1-page-last of the vsyscall
+ *    virtual space, and make it increase %rip and write -ENOSYS in %rax (so
+ *    we'll be able to upgrade to a new glibc without upgrading kernel after
+ *    we add more vsyscalls.
+ * 2) Possibly we need a fixmap table for the vsyscalls too if we want
+ *    to avoid SIGSEGV and we want to return -EFAULT from the vsyscalls as well.
+ *    Can we segfault inside a "syscall"? We can fix this anytime and those fixes
+ *    won't be visible for userspace. Not fixing this is a noop for correct programs,
+ *    broken programs will segfault and there's no security risk until we choose to
+ *    fix it.
+ *
+ * These are not urgent things that we need to address only before shipping the first
+ * production binary kernels.
+ */
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
--- a/arch/i386/vmlinux.lds.S	Thu Oct 17 21:25:02 2002
+++ b/arch/i386/vmlinux.lds.S	Thu Oct 17 21:25:02 2002
@@ -4,7 +4,7 @@
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
-jiffies = jiffies_64;
+jiffies_64 = jiffies;
 SECTIONS
 {
   . = 0xC0000000 + 0x100000;
@@ -90,6 +90,33 @@
   __bss_stop = .; 
 
   _end = . ;
+  
+   . = ALIGN(64);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
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
 
   /* Sections to be discarded */
   /DISCARD/ : {
diff -Nru a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
--- a/include/asm-i386/fixmap.h	Thu Oct 17 21:25:02 2002
+++ b/include/asm-i386/fixmap.h	Thu Oct 17 21:25:02 2002
@@ -18,6 +18,7 @@
 #include <asm/acpi.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
+#include <asm/vsyscall.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -49,6 +50,8 @@
  * fix-mapped?
  */
 enum fixed_addresses {
+	VSYSCALL_LAST_PAGE,
+	VSYSCALL_FIRST_PAGE = VSYSCALL_LAST_PAGE + ((VSYSCALL_END-VSYSCALL_START) >> PAGE_SHIFT) - 1,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif
diff -Nru a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	Thu Oct 17 21:25:02 2002
+++ b/include/asm-i386/pgtable.h	Thu Oct 17 21:25:02 2002
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
+++ b/include/asm-i386/vsyscall.h	Thu Oct 17 21:25:02 2002
@@ -0,0 +1,49 @@
+#ifndef _ASM_i386_VSYSCALL_H_
+#define _ASM_i386_VSYSCALL_H_
+
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
+
+#endif /* _ASM_i386_VSYSCALL_H_ */

