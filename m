Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbSJJL4n>; Thu, 10 Oct 2002 07:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262024AbSJJL4n>; Thu, 10 Oct 2002 07:56:43 -0400
Received: from h-64-105-35-49.SNVACAID.covad.net ([64.105.35.49]:39040 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262019AbSJJL4i>; Thu, 10 Oct 2002 07:56:38 -0400
Date: Thu, 10 Oct 2002 05:02:12 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.41 multiprocessor vs. CONFIG_X86_TSC
Message-ID: <20021010050212.A383@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	When I attempted to boot 2.5.40 and 2.5.41 on an x86
multiprocessor that booted 2.5.34 , I got an infinite loop
"APIC error on CPU1: 08(08)".

	The cause of this loop was that syncrhonize_tsc_bp in
arch/i386/kernel/smpboot.c would attempt a calculation that involved
dividing by fast_gettimeoffset_quotient, a value that was only set if
CONFIG_X86_TSC was defined.  This resulted in a divide by zero trap,
which left some interrupt handling in a funky a state, which resulted
in the repeating error message.

	There are two bugs that this problem exposed:

	1. Running on an x86 multiprocessor now requires a CPU with the
	   Time Stamp Counter feature, apparently a feature of Pentium I
	   and later.  Sequent made 386 and 486(?) multiprocessor systems,
	   but I don't know if they or any other 386 or 486 multiprocessors
	   can run Linux.  If they can, then this problem really should be
	   nailed, which I have not yet done.

	2. CONFIG_X86_TSC is used inconsistently.  In some cases it means
	   "Assume TSC" and its absense means "check cpu_has_tsc at run
	   time", but parts of arch/i386/time.c were treating its absense
	   as meaning "assume TSC is not present."  The result was that when
	   I tried to boot a kernel that could run on a 386, time.c assumed
	   TSC was not present and did left fast_gettimeoffset_quotient as
	   zero, resulting in the divide by zero in the APIC initialization.

	The following preliminary fixes arch/i386/time.c so that the
absense of CONFIG_X86_TSC just means "check cpu_has_tsc."  I have also
attached matching changes for a couple of other places where
CONFIG_X86_TSC was checked, but those changes are not necessary to
allow of a kernel that can boot on both 386's and multiprocessors.

	I would appreciate feedback on the following questions:

	1. Do we still want a CONFIG_X86_TSC compile-time option?
	   We already have a boot time argument to tell the kernel to
	   assume the TSC is bad.  The only quasi-critical paths that
	   an "if (cpu_has_tsc)" would be in would be in the
	   include/net/profile.h macros and some DRM drivers that call
	   get_cycles().

	2. Are there x86 multiprocessors that Linux runs on that lack the
	   Time Stamp Counter feature?  If so, I would welcome any
	   suggestions or requests on how best to fix arch/i386/smpboot.c.

	3. Is there anything else I should change in these patches?  I was
	   thinking of doing "#define cpu_has_tsc 1" if CONFIG_X86_TSC
	   is set.

	4. I would like to first submit my changes to arch/i386/time.c,
	   as they are sufficient to allow for a Linux kernel that can
	   both on 386 and on virtually all real world multiprocessors,
	   and would be included in every way that I can imaging addressing
	   this problem.  Any objections this step?

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tsc.diff"

--- linux-2.5.41/arch/i386/kernel/time.c	2002-10-07 11:24:15.000000000 -0700
+++ linux/arch/i386/kernel/time.c	2002-10-10 04:14:01.000000000 -0700
@@ -522,7 +522,6 @@
 #define CALIBRATE_LATCH	(5 * LATCH)
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
-#ifdef CONFIG_X86_TSC
 static unsigned long __init calibrate_tsc(void)
 {
        /* Set the Gate high, disable speaker */
@@ -587,7 +586,6 @@
 bad_ctc:
 	return 0;
 }
-#endif /* CONFIG_X86_TSC */
 
 static struct sys_device device_i8253 = {
 	.name		= "rtc",
@@ -652,9 +650,7 @@
 
 void __init time_init(void)
 {
-#ifdef CONFIG_X86_TSC
 	extern int x86_udelay_tsc;
-#endif
 	
 	xtime.tv_sec = get_cmos_time();
 	xtime.tv_nsec = 0;
@@ -673,7 +669,6 @@
  * to disk; this won't break the kernel, though, 'cuz we're
  * smart.  See arch/i386/kernel/apm.c.
  */
-#ifdef CONFIG_X86_TSC
  	/*
  	 *	Firstly we have to do a CPU check for chips with
  	 * 	a potentially buggy TSC. At this point we haven't run
@@ -717,8 +712,7 @@
 #endif
 		}
 	}
-#endif /* CONFIG_X86_TSC */
 
 	time_init_hook();
 }
--- linux-2.5.41/include/net/profile.h	2002-10-07 11:23:23.000000000 -0700
+++ linux/include/net/profile.h	2002-10-10 04:14:01.000000000 -0700
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <asm/system.h>
 
-#ifdef CONFIG_X86_TSC
+#ifdef CONFIG_X86
 #include <asm/msr.h>
 #endif
 
@@ -29,51 +29,7 @@
 extern struct timeval net_profile_adjust;
 extern void net_profile_irq_adjust(struct timeval *entered, struct timeval* leaved);
 
-#ifdef CONFIG_X86_TSC
-
-static inline void  net_profile_stamp(struct timeval *pstamp)
-{
-	rdtsc(pstamp->tv_usec, pstamp->tv_sec);
-}
-
-static inline void  net_profile_accumulate(struct timeval *entered,
-					       struct timeval *leaved,
-					       struct timeval *acc)
-{
-	__asm__ __volatile__ ("subl %2,%0\n\t" 
-			      "sbbl %3,%1\n\t" 
-			      "addl %4,%0\n\t" 
-			      "adcl %5,%1\n\t" 
-			      "subl net_profile_adjust+4,%0\n\t" 
-			      "sbbl $0,%1\n\t" 
-			      : "=r" (acc->tv_usec), "=r" (acc->tv_sec)
-			      : "g" (entered->tv_usec), "g" (entered->tv_sec),
-			      "g" (leaved->tv_usec), "g" (leaved->tv_sec),
-			      "0" (acc->tv_usec), "1" (acc->tv_sec));
-}
-
-static inline void  net_profile_sub(struct timeval *sub,
-					struct timeval *acc)
-{
-	__asm__ __volatile__ ("subl %2,%0\n\t" 
-			      "sbbl %3,%1\n\t" 
-			      : "=r" (acc->tv_usec), "=r" (acc->tv_sec)
-			      : "g" (sub->tv_usec), "g" (sub->tv_sec),
-			      "0" (acc->tv_usec), "1" (acc->tv_sec));
-}
-
-static inline void  net_profile_add(struct timeval *add,
-					struct timeval *acc)
-{
-	__asm__ __volatile__ ("addl %2,%0\n\t" 
-			      "adcl %3,%1\n\t" 
-			      : "=r" (acc->tv_usec), "=r" (acc->tv_sec)
-			      : "g" (add->tv_usec), "g" (add->tv_sec),
-			      "0" (acc->tv_usec), "1" (acc->tv_sec));
-}
-
-
-#elif defined (__alpha__)
+#ifdef __alpha__
 
 extern __u32 alpha_lo;
 extern long alpha_hi;
@@ -143,8 +99,23 @@
 
 #else
 
+# ifdef CONFIG_X86_TSC
+#  define IF_TSC(code)	{ code; }
+# elif CONFIG_X86
+#  define IF_TSC(code)	{ if(cpu_has_tsc) { code; } }
+# else
+#  define IF_TSC(code)	{ }
+# endif
+
+
+
 static inline void  net_profile_stamp(struct timeval *pstamp)
 {
+	IF_TSC({
+		rdtsc(pstamp->tv_usec, pstamp->tv_sec);
+		return;
+	});
+
 	/* Not "fast" counterpart! On architectures without
 	   cpu clock "fast" routine is absolutely useless in this
 	   situation. do_gettimeofday still says something on slow-slow-slow
@@ -158,6 +129,22 @@
 					       struct timeval *leaved,
 					       struct timeval *acc)
 {
+	IF_TSC({
+		__asm__ __volatile__ ("subl %2,%0\n\t" 
+				      "sbbl %3,%1\n\t" 
+				      "addl %4,%0\n\t" 
+				      "adcl %5,%1\n\t" 
+				      "subl net_profile_adjust+4,%0\n\t" 
+				      "sbbl $0,%1\n\t" 
+				      : "=r" (acc->tv_usec), "=r" (acc->tv_sec)
+				      : "g" (entered->tv_usec),
+				      "g" (entered->tv_sec),
+				      "g" (leaved->tv_usec),
+				      "g" (leaved->tv_sec),
+				      "0" (acc->tv_usec), "1" (acc->tv_sec));
+		return;
+	});
+
 	time_t usecs = acc->tv_usec + leaved->tv_usec - entered->tv_usec
 		- net_profile_adjust.tv_usec;
 	time_t secs = acc->tv_sec + leaved->tv_sec - entered->tv_sec;
@@ -179,8 +166,22 @@
 static inline void  net_profile_sub(struct timeval *entered,
 					struct timeval *leaved)
 {
-	time_t usecs = leaved->tv_usec - entered->tv_usec;
-	time_t secs = leaved->tv_sec - entered->tv_sec;
+	time_t usecs, secs;
+
+	IF_TSC({
+		__asm__ __volatile__ ("subl %2,%0\n\t" 
+				      "sbbl %3,%1\n\t" 
+				      : "=r" (leaved->tv_usec),
+				      "=r" (leaved->tv_sec)
+				      : "g" (entered->tv_usec),
+				      "g" (entered->tv_sec),
+				      "0" (leaved->tv_usec),
+				      "1" (leaved->tv_sec));
+		return;
+	});
+
+	usecs = leaved->tv_usec - entered->tv_usec;
+	secs = leaved->tv_sec - entered->tv_sec;
 
 	if (usecs < 0) {
 		usecs += 1000000;
@@ -192,8 +193,22 @@
 
 static inline void  net_profile_add(struct timeval *entered, struct timeval *leaved)
 {
-	time_t usecs = leaved->tv_usec + entered->tv_usec;
-	time_t secs = leaved->tv_sec + entered->tv_sec;
+	time_t usecs, secs;
+
+	IF_TSC({
+		__asm__ __volatile__ ("addl %2,%0\n\t" 
+				      "adcl %3,%1\n\t" 
+				      : "=r" (leaved->tv_usec),
+				      "=r" (leaved->tv_sec)
+				      : "g" (entered->tv_usec),
+				      "g" (entered->tv_sec),
+				      "0" (leaved->tv_usec),
+				      "1" (leaved->tv_sec));
+		return;
+	});
+
+	usecs = leaved->tv_usec + entered->tv_usec;
+	secs = leaved->tv_sec + entered->tv_sec;
 
 	if (usecs >= 1000000) {
 		usecs -= 1000000;
--- linux-2.5.41/include/net/pkt_sched.h	2002-10-07 11:23:34.000000000 -0700
+++ linux/include/net/pkt_sched.h	2002-10-10 04:14:01.000000000 -0700
@@ -12,7 +12,7 @@
 #include <linux/pkt_sched.h>
 #include <net/pkt_cls.h>
 
-#ifdef CONFIG_X86_TSC
+#ifdef CONFIG_X86
 #include <asm/msr.h>
 #endif
 
@@ -253,10 +253,11 @@
 
 #define PSCHED_US2JIFFIE(delay) (((delay)+psched_clock_per_hz-1)/psched_clock_per_hz)
 
-#ifdef CONFIG_X86_TSC
+#ifdef CONFIG_X86
 
 #define PSCHED_GET_TIME(stamp) \
 ({ u64 __cur; \
+   BUG_ON(!cpu_has_tsc);
    rdtscll(__cur); \
    (stamp) = __cur>>psched_clock_scale; \
 })
--- linux-2.5.41/include/asm-x86_64/timex.h	2002-10-07 11:24:39.000000000 -0700
+++ linux/include/asm-x86_64/timex.h	2002-10-10 04:14:01.000000000 -0700
@@ -17,14 +17,9 @@
 		<< (SHIFT_SCALE-SHIFT_HZ)) / HZ)
 
 /*
- * Standard way to access the cycle counter on i586+ CPUs.
+ * Standard way to access the cycle counter on i586+ CPUs, including x86_64.
  * Currently only used on SMP.
  *
- * If you really have a SMP machine with i486 chips or older,
- * compile for that, and this will just always return zero.
- * That's ok, it just means that the nicer scheduling heuristics
- * won't work for you.
- *
  * We only use the low 32 bits, and we'd simply better make sure
  * that we reschedule before that wraps. Scheduling at least every
  * four billion cycles just basically sounds like a good idea,
@@ -36,15 +31,11 @@
 
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
-	return 0;
-#else
 	unsigned long long ret;
 
 	rdtscll(ret);
 	return ret;
-#endif
 }
 
 extern unsigned int cpu_khz;
--- linux-2.5.41/include/asm-i386/timex.h	2002-10-07 11:24:01.000000000 -0700
+++ linux/include/asm-i386/timex.h	2002-10-10 04:14:01.000000000 -0700
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <asm/msr.h>
+#include <asm/processor.h>
 
 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
@@ -40,14 +41,14 @@
 
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
-	return 0;
-#else
-	unsigned long long ret;
+	if (cpu_has_tsc) {
+		unsigned long long ret;
 
-	rdtscll(ret);
-	return ret;
-#endif
+		rdtscll(ret);
+		return ret;
+	}
+	else
+		return 0;
 }
 
 extern unsigned long cpu_khz;
--- linux-2.5.41/include/asm-i386/cpufeature.h	2002-10-07 11:23:33.000000000 -0700
+++ linux/include/asm-i386/cpufeature.h	2002-10-10 04:14:01.000000000 -0700
@@ -7,6 +7,8 @@
 #ifndef __ASM_I386_CPUFEATURE_H
 #define __ASM_I386_CPUFEATURE_H
 
+#include <asm/bitops.h>			  /* test_bit */
+
 #define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
 
 /* Intel-defined CPU features, CPUID level 0x00000001, word 0 */

--sm4nu43k4a2Rpi4c--
