Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVGCNyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVGCNyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 09:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVGCNyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 09:54:17 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27316 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261441AbVGCNud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 09:50:33 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] all-arch delay functions take 2
Date: Sun, 3 Jul 2005 16:50:13 +0300
User-Agent: KMail/1.5.4
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507031650.13770.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This patch makes mdelay/udelay/ndelay calls as small
as possible (just a function call), uses macros which
do compile-time checks on delay duration if parameter
is a constant, otherwise check is done at run time
to prevent udelay(-1) disasters.

arch-specific __[un]delay has guaranteed upper limit
on their argument (helps a lot if you write hand optimized
assembly divide-by-multiply and are worried of overflows).

Arches other than i386 were minimally modified and
were not tested.

i386 ndelay was 15% off scale:
	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
That's rounded up from 4.295!
We are doing much better now.

ndelay calibration is added. ndelay internally subtracts it's own latency
from its argument. On my 2GHz Athlon it is 34 ns. You
need to measure it first somehow, tho (default ndelay_offset=0).
I have a TSC-based measurement function included,
experimentally called after "Freeing unused kernel memory:"

+       if (cpu_has_tsc)
+               calibrate_ndelay_offset();

Run tested on i386 arch.
--
vda

diff -urpN linux-2.6.12.src/arch/alpha/lib/udelay.c linux-2.6.12.delay/arch/alpha/lib/udelay.c
--- linux-2.6.12.src/arch/alpha/lib/udelay.c	Tue Oct 19 00:54:39 2004
+++ linux-2.6.12.delay/arch/alpha/lib/udelay.c	Sun Jul  3 16:27:31 2005
@@ -39,17 +39,17 @@ __delay(int loops)
 #endif
 
 void
-udelay(unsigned long usecs)
+__udelay(unsigned long usecs)
 {
 	usecs *= (((unsigned long)HZ << 32) / 1000000) * LPJ;
 	__delay((long)usecs >> 32);
 }
-EXPORT_SYMBOL(udelay);
+EXPORT_SYMBOL(__udelay);
 
 void
-ndelay(unsigned long nsecs)
+__ndelay(unsigned long nsecs)
 {
 	nsecs *= (((unsigned long)HZ << 32) / 1000000000) * LPJ;
 	__delay((long)nsecs >> 32);
 }
-EXPORT_SYMBOL(ndelay);
+EXPORT_SYMBOL(__ndelay);
diff -urpN linux-2.6.12.src/arch/arm/kernel/armksyms.c linux-2.6.12.delay/arch/arm/kernel/armksyms.c
--- linux-2.6.12.src/arch/arm/kernel/armksyms.c	Thu Feb  3 11:38:47 2005
+++ linux-2.6.12.delay/arch/arm/kernel/armksyms.c	Sun Jul  3 16:27:31 2005
@@ -61,7 +61,6 @@ EXPORT_SYMBOL(__backtrace);
 
 	/* platform dependent support */
 EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__const_udelay);
 
 	/* networking */
 EXPORT_SYMBOL(csum_partial);
diff -urpN linux-2.6.12.src/arch/arm/lib/delay.S linux-2.6.12.delay/arch/arm/lib/delay.S
--- linux-2.6.12.src/arch/arm/lib/delay.S	Thu Feb  3 11:38:48 2005
+++ linux-2.6.12.delay/arch/arm/lib/delay.S	Sun Jul  3 16:27:31 2005
@@ -20,7 +20,7 @@ ENTRY(__udelay)
 		mov	r2,     #0x6800
 		orr	r2, r2, #0x00db
 		mul	r0, r2, r0
-ENTRY(__const_udelay)				@ 0 <= r0 <= 0x01ffffff
+						@ 0 <= r0 <= 0x01ffffff
 		ldr	r2, LC0
 		ldr	r2, [r2]		@ max = 0x0fffffff
 		mov	r0, r0, lsr #11		@ max = 0x00003fff
diff -urpN linux-2.6.12.src/arch/arm26/kernel/armksyms.c linux-2.6.12.delay/arch/arm26/kernel/armksyms.c
--- linux-2.6.12.src/arch/arm26/kernel/armksyms.c	Thu Mar  3 09:30:08 2005
+++ linux-2.6.12.delay/arch/arm26/kernel/armksyms.c	Sun Jul  3 16:27:31 2005
@@ -100,7 +100,7 @@ EXPORT_SYMBOL(kd_mksound);
 	/* platform dependent support */
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
-EXPORT_SYMBOL(udelay);
+EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(system_rev);
 EXPORT_SYMBOL(system_serial_low);
diff -urpN linux-2.6.12.src/arch/i386/kernel/i386_ksyms.c linux-2.6.12.delay/arch/i386/kernel/i386_ksyms.c
--- linux-2.6.12.src/arch/i386/kernel/i386_ksyms.c	Sun Jun 19 16:09:49 2005
+++ linux-2.6.12.delay/arch/i386/kernel/i386_ksyms.c	Sun Jul  3 16:27:31 2005
@@ -90,8 +90,6 @@ EXPORT_SYMBOL(csum_partial_copy_generic)
 /* Delay loops */
 EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
diff -urpN linux-2.6.12.src/arch/i386/kernel/i8259.c linux-2.6.12.delay/arch/i386/kernel/i8259.c
--- linux-2.6.12.src/arch/i386/kernel/i8259.c	Sun Jun 19 16:09:49 2005
+++ linux-2.6.12.delay/arch/i386/kernel/i8259.c	Sun Jul  3 16:27:31 2005
@@ -11,6 +11,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/8253pit.h>
 #include <asm/atomic.h>
diff -urpN linux-2.6.12.src/arch/i386/kernel/timers/timer_pit.c linux-2.6.12.delay/arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.12.src/arch/i386/kernel/timers/timer_pit.c	Thu Feb  3 11:38:53 2005
+++ linux-2.6.12.delay/arch/i386/kernel/timers/timer_pit.c	Sun Jul  3 16:27:31 2005
@@ -9,7 +9,7 @@
 #include <linux/irq.h>
 #include <linux/sysdev.h>
 #include <linux/timex.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/mpspec.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
diff -urpN linux-2.6.12.src/arch/i386/lib/delay.c linux-2.6.12.delay/arch/i386/lib/delay.c
--- linux-2.6.12.src/arch/i386/lib/delay.c	Thu Mar  3 09:30:10 2005
+++ linux-2.6.12.delay/arch/i386/lib/delay.c	Sun Jul  3 16:27:31 2005
@@ -21,29 +21,31 @@
 #include <asm/smp.h>
 #endif
 
-extern struct timer_opts* timer;
-
-void __delay(unsigned long loops)
-{
-	cur_timer->delay(loops);
-}
-
-inline void __const_udelay(unsigned long xloops)
+static inline void __const_udelay(unsigned long xloops)
 {
 	int d0;
-	xloops *= 4;
+	/* on entry: xloops = 2**32 * secs * HZ/4.
+	 * loops_needed = secs * loops_per_sec =
+	 * 2**32 * secs * loops_per_jiffy*HZ / 2**32 =
+	 * 2**32 * secs*HZ/4 * loops_per_jiffy*4 / 2**32 
+	 */
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (cpu_data[_smp_processor_id()].loops_per_jiffy * (HZ/4)));
+		:"1" (xloops),"0" (cpu_data[_smp_processor_id()].loops_per_jiffy * 4));
         __delay(++xloops);
 }
 
+/* usecs is guaranteed <= 1024 */
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up) */
+	/* 2**32 * usecs = ? secs: */
+	/* 4295 = 2**32 / 1000000 (4294.967 , rounded up) */
+	__const_udelay(usecs * (4295 * HZ/4));
 }
 
+/* nsecs is guaranteed <= 64*1024 */
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
+	/* 2**32 * nsecs == ? secs */
+	__const_udelay(nsecs * (4295 * HZ/4 / 1000));
 }
diff -urpN linux-2.6.12.src/arch/i386/mm/init.c linux-2.6.12.delay/arch/i386/mm/init.c
--- linux-2.6.12.src/arch/i386/mm/init.c	Sun Jun 19 16:09:49 2005
+++ linux-2.6.12.delay/arch/i386/mm/init.c	Sun Jul  3 16:28:14 2005
@@ -679,6 +679,8 @@ void free_initmem(void)
 		totalram_pages++;
 	}
 	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);
+	if (cpu_has_tsc)
+		calibrate_ndelay_offset();
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff -urpN linux-2.6.12.src/arch/m32r/kernel/m32r_ksyms.c linux-2.6.12.delay/arch/m32r/kernel/m32r_ksyms.c
--- linux-2.6.12.src/arch/m32r/kernel/m32r_ksyms.c	Sun Jun 19 16:09:52 2005
+++ linux-2.6.12.delay/arch/m32r/kernel/m32r_ksyms.c	Sun Jul  3 16:27:31 2005
@@ -44,7 +44,6 @@ EXPORT_SYMBOL(__down_trylock);
 /* Delay loops */
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
diff -urpN linux-2.6.12.src/arch/m32r/lib/delay.c linux-2.6.12.delay/arch/m32r/lib/delay.c
--- linux-2.6.12.src/arch/m32r/lib/delay.c	Thu Feb  3 11:38:55 2005
+++ linux-2.6.12.delay/arch/m32r/lib/delay.c	Sun Jul  3 16:27:31 2005
@@ -58,7 +58,7 @@ void __delay(unsigned long loops)
 #endif
 }
 
-void __const_udelay(unsigned long xloops)
+static void __const_udelay(unsigned long xloops)
 {
 #if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 	/*
diff -urpN linux-2.6.12.src/arch/m68knommu/lib/delay.c linux-2.6.12.delay/arch/m68knommu/lib/delay.c
--- linux-2.6.12.src/arch/m68knommu/lib/delay.c	Thu Mar  3 09:30:14 2005
+++ linux-2.6.12.delay/arch/m68knommu/lib/delay.c	Sun Jul  3 16:27:31 2005
@@ -12,10 +12,62 @@
 #include <asm/param.h>
 #include <asm/delay.h>
 
-EXPORT_SYMBOL(udelay);
+extern unsigned long loops_per_jiffy;
 
-void udelay(unsigned long usecs)
+extern __inline__ void __delay(unsigned long loops)
 {
-	_udelay(usecs);
+#if defined(CONFIG_COLDFIRE)
+	/* The coldfire runs this loop at significantly different speeds
+	 * depending upon long word alignment or not.  We'll pad it to
+	 * long word alignment which is the faster version.
+	 * The 0x4a8e is of course a 'tstl %fp' instruction.  This is better
+	 * than using a NOP (0x4e71) instruction because it executes in one
+	 * cycle not three and doesn't allow for an arbitary delay waiting
+	 * for bus cycles to finish.  Also fp/a6 isn't likely to cause a
+	 * stall waiting for the register to become valid if such is added
+	 * to the coldfire at some stage.
+	 */
+	__asm__ __volatile__ (	".balignw 4, 0x4a8e\n\t"
+				"1: subql #1, %0\n\t"
+				"jcc 1b"
+		: "=d" (loops) : "0" (loops));
+#else
+	__asm__ __volatile__ (	"1: subql #1, %0\n\t"
+				"jcc 1b"
+		: "=d" (loops) : "0" (loops));
+#endif
+}
+
+/*
+ *	Ideally we use a 32*32->64 multiply to calculate the number of
+ *	loop iterations, but the older standard 68k and ColdFire do not
+ *	have this instruction. So for them we have a close approximation
+ *	loop using 32*32->32 multiplies only. This calculation based on
+ *	the ARM version of delay.
+ *
+ *	We want to implement:
+ *
+ *	loops = (usecs * 0x10c6 * HZ * loops_per_jiffy) / 2^32
+ */
+
+#define	HZSCALE		(268435456 / (1000000/HZ))
+
+EXPORT_SYMBOL(__udelay);
+
+void __udelay(unsigned long usecs)
+{
+#if defined(CONFIG_M68328) || defined(CONFIG_M68EZ328) || \
+    defined(CONFIG_M68VZ328) || defined(CONFIG_M68360) || \
+    defined(CONFIG_COLDFIRE)
+	__delay((((usecs * HZSCALE) >> 11) * (loops_per_jiffy >> 11)) >> 6);
+#else
+	unsigned long tmp;
+
+	usecs *= 4295;		/* 2**32 / 1000000 */
+	__asm__ ("mulul %2,%0:%1"
+		: "=d" (usecs), "=d" (tmp)
+		: "d" (usecs), "1" (loops_per_jiffy*HZ));
+	__delay(usecs);
+#endif
 }
 
diff -urpN linux-2.6.12.src/arch/sh/kernel/sh_ksyms.c linux-2.6.12.delay/arch/sh/kernel/sh_ksyms.c
--- linux-2.6.12.src/arch/sh/kernel/sh_ksyms.c	Sun Jun 19 16:09:58 2005
+++ linux-2.6.12.delay/arch/sh/kernel/sh_ksyms.c	Sun Jul  3 16:27:31 2005
@@ -77,7 +77,6 @@ EXPORT_SYMBOL(__down_interruptible);
 
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__div64_32);
 
diff -urpN linux-2.6.12.src/arch/sh/lib/delay.c linux-2.6.12.delay/arch/sh/lib/delay.c
--- linux-2.6.12.src/arch/sh/lib/delay.c	Thu Mar  3 09:30:22 2005
+++ linux-2.6.12.delay/arch/sh/lib/delay.c	Sun Jul  3 16:27:31 2005
@@ -19,7 +19,7 @@ void __delay(unsigned long loops)
 		: "t");
 }
 
-inline void __const_udelay(unsigned long xloops)
+static inline void __const_udelay(unsigned long xloops)
 {
 	__asm__("dmulu.l	%0, %2\n\t"
 		"sts	mach, %0"
diff -urpN linux-2.6.12.src/arch/sh64/lib/udelay.c linux-2.6.12.delay/arch/sh64/lib/udelay.c
--- linux-2.6.12.src/arch/sh64/lib/udelay.c	Tue Oct 19 00:53:46 2004
+++ linux-2.6.12.delay/arch/sh64/lib/udelay.c	Sun Jul  3 16:27:31 2005
@@ -36,25 +36,14 @@ void __delay(int loops)
 			     :"0"(loops));
 }
 
-void __udelay(unsigned long long usecs, unsigned long lpj)
+void __udelay(unsigned long long usecs)
 {
-	usecs *= (((unsigned long long) HZ << 32) / 1000000) * lpj;
+	usecs *= (((unsigned long long) HZ << 32) / 1000000) * loops_per_jiffy;
 	__delay((long long) usecs >> 32);
 }
 
-void __ndelay(unsigned long long nsecs, unsigned long lpj)
+void __ndelay(unsigned long long nsecs)
 {
-	nsecs *= (((unsigned long long) HZ << 32) / 1000000000) * lpj;
+	nsecs *= (((unsigned long long) HZ << 32) / 1000000000) * loops_per_jiffy;
 	__delay((long long) nsecs >> 32);
 }
-
-void udelay(unsigned long usecs)
-{
-	__udelay(usecs, loops_per_jiffy);
-}
-
-void ndelay(unsigned long nsecs)
-{
-	__ndelay(nsecs, loops_per_jiffy);
-}
-
diff -urpN linux-2.6.12.src/arch/sparc/kernel/entry.S linux-2.6.12.delay/arch/sparc/kernel/entry.S
--- linux-2.6.12.src/arch/sparc/kernel/entry.S	Thu Feb  3 11:39:08 2005
+++ linux-2.6.12.delay/arch/sparc/kernel/entry.S	Sun Jul  3 16:27:31 2005
@@ -1796,15 +1796,15 @@ fpload:
 	retl
 	 nop
 
-	/* __ndelay and __udelay take two arguments:
+	/* ___ndelay and ___udelay take two arguments:
 	 * 0 - nsecs or usecs to delay
 	 * 1 - per_cpu udelay_val (loops per jiffy)
 	 *
 	 * Note that ndelay gives HZ times higher resolution but has a 10ms
 	 * limit.  udelay can handle up to 1s.
 	 */
-	.globl	__ndelay
-__ndelay:
+	.globl	___ndelay
+___ndelay:
 	save	%sp, -STACKFRAME_SZ, %sp
 	mov	%i0, %o0
 	call	.umul
@@ -1814,8 +1814,8 @@ __ndelay:
 	ba	delay_continue
 	 mov	%o1, %o0		! >>32 later for better resolution
 
-	.globl	__udelay
-__udelay:
+	.globl	___udelay
+___udelay:
 	save	%sp, -STACKFRAME_SZ, %sp
 	mov	%i0, %o0
 	sethi	%hi(0x10c6), %o1
diff -urpN linux-2.6.12.src/arch/sparc/kernel/sparc_ksyms.c linux-2.6.12.delay/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.12.src/arch/sparc/kernel/sparc_ksyms.c	Sun Jun 19 16:09:59 2005
+++ linux-2.6.12.delay/arch/sparc/kernel/sparc_ksyms.c	Sun Jul  3 16:27:31 2005
@@ -164,8 +164,8 @@ EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(phys_cpu_present_map);
 #endif
 
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__ndelay);
+EXPORT_SYMBOL(___udelay);
+EXPORT_SYMBOL(___ndelay);
 EXPORT_SYMBOL(rtc_lock);
 EXPORT_SYMBOL(mostek_lock);
 EXPORT_SYMBOL(mstk48t02_regs);
diff -urpN linux-2.6.12.src/arch/sparc64/kernel/sparc64_ksyms.c linux-2.6.12.delay/arch/sparc64/kernel/sparc64_ksyms.c
--- linux-2.6.12.src/arch/sparc64/kernel/sparc64_ksyms.c	Sun Jun 19 16:10:00 2005
+++ linux-2.6.12.delay/arch/sparc64/kernel/sparc64_ksyms.c	Sun Jul  3 16:27:31 2005
@@ -400,7 +400,6 @@ EXPORT_SYMBOL(strncmp);
 /* Delay routines. */
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__const_udelay);
 EXPORT_SYMBOL(__delay);
 
 void VISenter(void);
diff -urpN linux-2.6.12.src/arch/sparc64/lib/delay.c linux-2.6.12.delay/arch/sparc64/lib/delay.c
--- linux-2.6.12.src/arch/sparc64/lib/delay.c	Thu Mar  3 09:30:22 2005
+++ linux-2.6.12.delay/arch/sparc64/lib/delay.c	Sun Jul  3 16:27:31 2005
@@ -27,7 +27,7 @@ void __delay(unsigned long loops)
  * but that runs into problems for higher values of HZ and
  * slow cpus.
  */
-void __const_udelay(unsigned long n)
+static void __const_udelay(unsigned long n)
 {
 	n *= 4;
 
diff -urpN linux-2.6.12.src/arch/um/sys-i386/delay.c linux-2.6.12.delay/arch/um/sys-i386/delay.c
--- linux-2.6.12.src/arch/um/sys-i386/delay.c	Sun Jun 19 16:10:01 2005
+++ linux-2.6.12.delay/arch/um/sys-i386/delay.c	Sun Jul  3 16:27:31 2005
@@ -27,14 +27,3 @@ void __udelay(unsigned long usecs)
 }
 
 EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
-{
-	int i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
-}
-
-EXPORT_SYMBOL(__const_udelay);
diff -urpN linux-2.6.12.src/arch/um/sys-i386/ksyms.c linux-2.6.12.delay/arch/um/sys-i386/ksyms.c
--- linux-2.6.12.src/arch/um/sys-i386/ksyms.c	Sun Jun 19 16:10:01 2005
+++ linux-2.6.12.delay/arch/um/sys-i386/ksyms.c	Sun Jul  3 16:27:31 2005
@@ -17,5 +17,4 @@ EXPORT_SYMBOL(__up_wakeup);
 EXPORT_SYMBOL(csum_partial);
 
 /* delay core functions */
-EXPORT_SYMBOL(__const_udelay);
 EXPORT_SYMBOL(__udelay);
diff -urpN linux-2.6.12.src/arch/um/sys-x86_64/delay.c linux-2.6.12.delay/arch/um/sys-x86_64/delay.c
--- linux-2.6.12.src/arch/um/sys-x86_64/delay.c	Sun Jun 19 16:10:01 2005
+++ linux-2.6.12.delay/arch/um/sys-x86_64/delay.c	Sun Jul  3 16:27:31 2005
@@ -28,14 +28,3 @@ void __udelay(unsigned long usecs)
 }
 
 EXPORT_SYMBOL(__udelay);
-
-void __const_udelay(unsigned long usecs)
-{
-	unsigned long i, n;
-
-	n = (loops_per_jiffy * HZ * usecs) / MILLION;
-        for(i=0;i<n;i++)
-                cpu_relax();
-}
-
-EXPORT_SYMBOL(__const_udelay);
diff -urpN linux-2.6.12.src/arch/x86_64/kernel/x8664_ksyms.c linux-2.6.12.delay/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.12.src/arch/x86_64/kernel/x8664_ksyms.c	Sun Jun 19 16:10:03 2005
+++ linux-2.6.12.delay/arch/x86_64/kernel/x8664_ksyms.c	Sun Jul  3 16:27:31 2005
@@ -73,7 +73,6 @@ EXPORT_SYMBOL(ip_compute_csum);
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
diff -urpN linux-2.6.12.src/arch/x86_64/lib/delay.c linux-2.6.12.delay/arch/x86_64/lib/delay.c
--- linux-2.6.12.src/arch/x86_64/lib/delay.c	Sun Jun 19 16:10:03 2005
+++ linux-2.6.12.delay/arch/x86_64/lib/delay.c	Sun Jul  3 16:27:31 2005
@@ -32,7 +32,7 @@ void __delay(unsigned long loops)
 	while((now-bclock) < loops);
 }
 
-inline void __const_udelay(unsigned long xloops)
+static inline void __const_udelay(unsigned long xloops)
 {
 	__delay(((xloops * cpu_data[_smp_processor_id()].loops_per_jiffy) >> 32) * HZ);
 }
diff -urpN linux-2.6.12.src/include/asm-alpha/delay.h linux-2.6.12.delay/include/asm-alpha/delay.h
--- linux-2.6.12.src/include/asm-alpha/delay.h	Tue Oct 19 00:53:51 2004
+++ linux-2.6.12.delay/include/asm-alpha/delay.h	Sun Jul  3 16:27:31 2005
@@ -2,9 +2,8 @@
 #define __ALPHA_DELAY_H
 
 extern void __delay(int loops);
-extern void udelay(unsigned long usecs);
-
-extern void ndelay(unsigned long nsecs);
-#define ndelay ndelay
+extern void __udelay(unsigned long usecs);
+extern void __ndelay(unsigned long nsecs);
+#define __ndelay(n) __ndelay(n)
 
 #endif /* defined(__ALPHA_DELAY_H) */
diff -urpN linux-2.6.12.src/include/asm-arm/delay.h linux-2.6.12.delay/include/asm-arm/delay.h
--- linux-2.6.12.src/include/asm-arm/delay.h	Thu Feb  3 11:40:05 2005
+++ linux-2.6.12.delay/include/asm-arm/delay.h	Sun Jul  3 16:27:31 2005
@@ -8,35 +8,9 @@
 
 extern void __delay(int loops);
 
-/*
- * This function intentionally does not exist; if you see references to
- * it, it means that you're calling udelay() with an out of range value.
- *
- * With currently imposed limits, this means that we support a max delay
- * of 2000us and 671 bogomips
- */
-extern void __bad_udelay(void);
-
-/*
- * division by multiplication: you don't have to worry about
- * loss of precision.
- *
- * Use only for very small delays ( < 1 msec).  Should probably use a
- * lookup table, really, as the multiplications take much too long with
- * short delays.  This is a "reasonable" implementation, though (and the
- * first constant multiplications gets optimized away if the delay is
- * a constant)
- */
 extern void __udelay(unsigned long usecs);
-extern void __const_udelay(unsigned long);
 
 #define MAX_UDELAY_MS 2
-
-#define udelay(n)						\
-	(__builtin_constant_p(n) ?				\
-	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :	\
-			__const_udelay((n) * 0x68dbul)) :	\
-	  __udelay(n))
 
 #endif /* defined(_ARM_DELAY_H) */
 
diff -urpN linux-2.6.12.src/include/asm-arm26/delay.h linux-2.6.12.delay/include/asm-arm26/delay.h
--- linux-2.6.12.src/include/asm-arm26/delay.h	Tue Oct 19 00:53:06 2004
+++ linux-2.6.12.delay/include/asm-arm26/delay.h	Sun Jul  3 16:27:31 2005
@@ -21,7 +21,7 @@ extern void __delay(int loops);
  *
  * FIXME - lets improve it then...
  */
-extern void udelay(unsigned long usecs);
+extern void __udelay(unsigned long usecs);
 
 static inline unsigned long muldiv(unsigned long a, unsigned long b, unsigned long c)
 {
diff -urpN linux-2.6.12.src/include/asm-cris/delay.h linux-2.6.12.delay/include/asm-cris/delay.h
--- linux-2.6.12.src/include/asm-cris/delay.h	Tue Oct 19 00:55:23 2004
+++ linux-2.6.12.delay/include/asm-cris/delay.h	Sun Jul  3 16:27:31 2005
@@ -13,7 +13,7 @@
 
 extern unsigned long loops_per_usec; /* arch/cris/mm/init.c */
 
-extern __inline__ void udelay(unsigned long usecs)
+extern __inline__ void __udelay(unsigned long usecs)
 {
 	__delay(usecs * loops_per_usec);
 }
diff -urpN linux-2.6.12.src/include/asm-frv/delay.h linux-2.6.12.delay/include/asm-frv/delay.h
--- linux-2.6.12.src/include/asm-frv/delay.h	Thu Mar  3 09:31:07 2005
+++ linux-2.6.12.delay/include/asm-frv/delay.h	Sun Jul  3 16:27:31 2005
@@ -40,11 +40,11 @@ static inline void __delay(unsigned long
 
 extern unsigned long loops_per_jiffy;
 
-static inline void udelay(unsigned long usecs)
+static inline void __udelay(unsigned long usecs)
 {
 	__delay(usecs * __delay_loops_MHz);
 }
 
-#define ndelay(n)	udelay((n) * 5)
+//BOGUS! #define ndelay(n)	udelay((n) * 5)
 
 #endif /* _ASM_DELAY_H */
diff -urpN linux-2.6.12.src/include/asm-h8300/delay.h linux-2.6.12.delay/include/asm-h8300/delay.h
--- linux-2.6.12.src/include/asm-h8300/delay.h	Thu Feb  3 11:40:05 2005
+++ linux-2.6.12.delay/include/asm-h8300/delay.h	Sun Jul  3 16:27:31 2005
@@ -27,7 +27,7 @@ extern __inline__ void __delay(unsigned 
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void udelay(unsigned long usecs)
+extern __inline__ void __udelay(unsigned long usecs)
 {
 	usecs *= 4295;		/* 2**32 / 1000000 */
 	usecs /= (loops_per_jiffy*HZ);
diff -urpN linux-2.6.12.src/include/asm-i386/delay.h linux-2.6.12.delay/include/asm-i386/delay.h
--- linux-2.6.12.src/include/asm-i386/delay.h	Tue Oct 19 00:53:05 2004
+++ linux-2.6.12.delay/include/asm-i386/delay.h	Sun Jul  3 16:27:31 2005
@@ -6,21 +6,18 @@
  *
  * Delay routines calling functions in arch/i386/lib/delay.c
  */
- 
-extern void __bad_udelay(void);
-extern void __bad_ndelay(void);
 
+#include "timer.h" /* cur_timer */
+ 
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long usecs);
-extern void __delay(unsigned long loops);
+#define __ndelay(n) __ndelay(n)
+
+//extern struct timer_opts* timer;
 
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
-	__udelay(n))
-	
-#define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
-	__ndelay(n))
+static inline void __delay(unsigned long loops)
+{
+	cur_timer->delay(loops);
+}
 
 #endif /* defined(_I386_DELAY_H) */
diff -urpN linux-2.6.12.src/include/asm-m32r/delay.h linux-2.6.12.delay/include/asm-m32r/delay.h
--- linux-2.6.12.src/include/asm-m32r/delay.h	Tue Oct 19 00:53:45 2004
+++ linux-2.6.12.delay/include/asm-m32r/delay.h	Sun Jul  3 16:27:31 2005
@@ -9,20 +9,9 @@
  * Delay routines calling functions in arch/m32r/lib/delay.c
  */
 
-extern void __bad_udelay(void);
-extern void __bad_ndelay(void);
-
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long usecs);
+#define __ndelay(n) __ndelay(n)
 extern void __delay(unsigned long loops);
-
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
-	__udelay(n))
-
-#define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
-	__ndelay(n))
 
 #endif /* _ASM_M32R_DELAY_H */
diff -urpN linux-2.6.12.src/include/asm-m68k/delay.h linux-2.6.12.delay/include/asm-m68k/delay.h
--- linux-2.6.12.src/include/asm-m68k/delay.h	Tue Oct 19 00:55:28 2004
+++ linux-2.6.12.delay/include/asm-m68k/delay.h	Sun Jul  3 16:27:31 2005
@@ -15,8 +15,6 @@ static inline void __delay(unsigned long
 		: "=d" (loops) : "0" (loops));
 }
 
-extern void __bad_udelay(void);
-
 /*
  * Use only for very small delays ( < 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
@@ -38,10 +36,6 @@ static inline void __udelay(unsigned lon
 {
 	__const_udelay(usecs * 4295);	/* 2**32 / 1000000 */
 }
-
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 4295)) : \
-	__udelay(n))
 
 static inline unsigned long muldiv(unsigned long a, unsigned long b,
 				   unsigned long c)
diff -urpN linux-2.6.12.src/include/asm-m68knommu/delay.h linux-2.6.12.delay/include/asm-m68knommu/delay.h
--- linux-2.6.12.src/include/asm-m68knommu/delay.h	Thu Feb  3 11:40:08 2005
+++ linux-2.6.12.delay/include/asm-m68knommu/delay.h	Sun Jul  3 16:27:31 2005
@@ -8,69 +8,6 @@
 
 #include <asm/param.h>
 
-extern __inline__ void __delay(unsigned long loops)
-{
-#if defined(CONFIG_COLDFIRE)
-	/* The coldfire runs this loop at significantly different speeds
-	 * depending upon long word alignment or not.  We'll pad it to
-	 * long word alignment which is the faster version.
-	 * The 0x4a8e is of course a 'tstl %fp' instruction.  This is better
-	 * than using a NOP (0x4e71) instruction because it executes in one
-	 * cycle not three and doesn't allow for an arbitary delay waiting
-	 * for bus cycles to finish.  Also fp/a6 isn't likely to cause a
-	 * stall waiting for the register to become valid if such is added
-	 * to the coldfire at some stage.
-	 */
-	__asm__ __volatile__ (	".balignw 4, 0x4a8e\n\t"
-				"1: subql #1, %0\n\t"
-				"jcc 1b"
-		: "=d" (loops) : "0" (loops));
-#else
-	__asm__ __volatile__ (	"1: subql #1, %0\n\t"
-				"jcc 1b"
-		: "=d" (loops) : "0" (loops));
-#endif
-}
-
-/*
- *	Ideally we use a 32*32->64 multiply to calculate the number of
- *	loop iterations, but the older standard 68k and ColdFire do not
- *	have this instruction. So for them we have a clsoe approximation
- *	loop using 32*32->32 multiplies only. This calculation based on
- *	the ARM version of delay.
- *
- *	We want to implement:
- *
- *	loops = (usecs * 0x10c6 * HZ * loops_per_jiffy) / 2^32
- */
-
-#define	HZSCALE		(268435456 / (1000000/HZ))
-
-extern unsigned long loops_per_jiffy;
-
-extern __inline__ void _udelay(unsigned long usecs)
-{
-#if defined(CONFIG_M68328) || defined(CONFIG_M68EZ328) || \
-    defined(CONFIG_M68VZ328) || defined(CONFIG_M68360) || \
-    defined(CONFIG_COLDFIRE)
-	__delay((((usecs * HZSCALE) >> 11) * (loops_per_jiffy >> 11)) >> 6);
-#else
-	unsigned long tmp;
-
-	usecs *= 4295;		/* 2**32 / 1000000 */
-	__asm__ ("mulul %2,%0:%1"
-		: "=d" (usecs), "=d" (tmp)
-		: "d" (usecs), "1" (loops_per_jiffy*HZ));
-	__delay(usecs);
-#endif
-}
-
-/*
- *	Moved the udelay() function into library code, no longer inlined.
- *	I had to change the algorithm because we are overflowing now on
- *	the faster ColdFire parts. The code is a little biger, so it makes
- *	sense to library it.
- */
-extern void udelay(unsigned long usecs);
+extern void __udelay(unsigned long usecs);
 
 #endif /* defined(_M68KNOMMU_DELAY_H) */
diff -urpN linux-2.6.12.src/include/asm-mips/delay.h linux-2.6.12.delay/include/asm-mips/delay.h
--- linux-2.6.12.src/include/asm-mips/delay.h	Thu Feb  3 11:40:09 2005
+++ linux-2.6.12.delay/include/asm-mips/delay.h	Sun Jul  3 16:27:31 2005
@@ -49,10 +49,16 @@ static inline void __delay(unsigned long
  * a constant)
  */
 
-static inline void __udelay(unsigned long usecs, unsigned long lpj)
+static inline void __udelay(unsigned long usecs)
 {
 	unsigned long lo;
 
+#ifdef CONFIG_SMP
+	unsigned long loops_per_jiffy = cpu_data[smp_processor_id()].udelay_val;
+#else
+	/* using global one */
+#endif
+
 	/*
 	 * The common rates of 1000 and 128 are rounded wrongly by the
 	 * catchall case for 64-bit.  Excessive precission?  Probably ...
@@ -71,23 +77,15 @@ static inline void __udelay(unsigned lon
 	if (sizeof(long) == 4)
 		__asm__("multu\t%2, %3"
 		: "=h" (usecs), "=l" (lo)
-		: "r" (usecs), "r" (lpj)
+		: "r" (usecs), "r" (loops_per_jiffy)
 		: GCC_REG_ACCUM);
 	else if (sizeof(long) == 8)
 		__asm__("dmultu\t%2, %3"
 		: "=h" (usecs), "=l" (lo)
-		: "r" (usecs), "r" (lpj)
+		: "r" (usecs), "r" (loops_per_jiffy)
 		: GCC_REG_ACCUM);
 
 	__delay(usecs);
 }
-
-#ifdef CONFIG_SMP
-#define __udelay_val cpu_data[smp_processor_id()].udelay_val
-#else
-#define __udelay_val loops_per_jiffy
-#endif
-
-#define udelay(usecs) __udelay((usecs),__udelay_val)
 
 #endif /* _ASM_DELAY_H */
diff -urpN linux-2.6.12.src/include/asm-parisc/delay.h linux-2.6.12.delay/include/asm-parisc/delay.h
--- linux-2.6.12.src/include/asm-parisc/delay.h	Tue Oct 19 00:54:08 2004
+++ linux-2.6.12.delay/include/asm-parisc/delay.h	Sun Jul  3 16:27:31 2005
@@ -38,6 +38,4 @@ static __inline__ void __udelay(unsigned
 	__cr16_delay(usecs * ((unsigned long)boot_cpu_data.cpu_hz / 1000000UL));
 }
 
-#define udelay(n) __udelay(n)
-
 #endif /* defined(_PARISC_DELAY_H) */
diff -urpN linux-2.6.12.src/include/asm-ppc/delay.h linux-2.6.12.delay/include/asm-ppc/delay.h
--- linux-2.6.12.src/include/asm-ppc/delay.h	Tue Oct 19 00:54:39 2004
+++ linux-2.6.12.delay/include/asm-ppc/delay.h	Sun Jul  3 16:27:31 2005
@@ -50,17 +50,7 @@ extern __inline__ void __ndelay(unsigned
 		"r" (x), "r" (loops_per_jiffy * 5));
 	__delay(loops);
 }
-
-extern void __bad_udelay(void);		/* deliberately undefined */
-extern void __bad_ndelay(void);		/* deliberately undefined */
-
-#define udelay(n) (__builtin_constant_p(n)? \
-	((n) > __MAX_UDELAY? __bad_udelay(): __udelay((n) * (19 * HZ))) : \
-	__udelay((n) * (19 * HZ)))
-
-#define ndelay(n) (__builtin_constant_p(n)? \
-	((n) > __MAX_NDELAY? __bad_ndelay(): __ndelay((n) * HZ)) : \
-	__ndelay((n) * HZ))
+#define __ndelay(n) __ndelay(n)
 
 #endif /* defined(_PPC_DELAY_H) */
 #endif /* __KERNEL__ */
diff -urpN linux-2.6.12.src/include/asm-ppc64/delay.h linux-2.6.12.delay/include/asm-ppc64/delay.h
--- linux-2.6.12.src/include/asm-ppc64/delay.h	Tue Oct 19 00:53:06 2004
+++ linux-2.6.12.delay/include/asm-ppc64/delay.h	Sun Jul  3 16:27:31 2005
@@ -38,7 +38,7 @@ static inline void __delay(unsigned long
 	__barrier();
 }
 
-static inline void udelay(unsigned long usecs)
+static inline void __udelay(unsigned long usecs)
 {
 	unsigned long loops = tb_ticks_per_usec * usecs;
 
diff -urpN linux-2.6.12.src/include/asm-s390/delay.h linux-2.6.12.delay/include/asm-s390/delay.h
--- linux-2.6.12.src/include/asm-s390/delay.h	Tue Oct 19 00:54:39 2004
+++ linux-2.6.12.delay/include/asm-s390/delay.h	Sun Jul  3 16:27:31 2005
@@ -17,6 +17,4 @@
 extern void __udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) __udelay(n)
-
 #endif /* defined(_S390_DELAY_H) */
diff -urpN linux-2.6.12.src/include/asm-sh/delay.h linux-2.6.12.delay/include/asm-sh/delay.h
--- linux-2.6.12.src/include/asm-sh/delay.h	Tue Oct 19 00:55:24 2004
+++ linux-2.6.12.delay/include/asm-sh/delay.h	Sun Jul  3 16:27:31 2005
@@ -7,21 +7,9 @@
  * Delay routines calling functions in arch/sh/lib/delay.c
  */
  
-extern void __bad_udelay(void);
-extern void __bad_ndelay(void);
-
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long usecs);
+#define __ndelay(n) __ndelay(n)
 extern void __delay(unsigned long loops);
-
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
-	__udelay(n))
-
-
-#define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
-	__ndelay(n))
 
 #endif /* __ASM_SH_DELAY_H */
diff -urpN linux-2.6.12.src/include/asm-sh64/delay.h linux-2.6.12.delay/include/asm-sh64/delay.h
--- linux-2.6.12.src/include/asm-sh64/delay.h	Tue Oct 19 00:54:37 2004
+++ linux-2.6.12.delay/include/asm-sh64/delay.h	Sun Jul  3 16:27:31 2005
@@ -2,10 +2,9 @@
 #define __ASM_SH64_DELAY_H
 
 extern void __delay(int loops);
-extern void __udelay(unsigned long long usecs, unsigned long lpj);
-extern void __ndelay(unsigned long long nsecs, unsigned long lpj);
-extern void udelay(unsigned long usecs);
-extern void ndelay(unsigned long nsecs);
+extern void __udelay(unsigned long long usecs);
+extern void __ndelay(unsigned long long nsecs);
+#define __ndelay(n) __ndelay(n)
 
 #endif /* __ASM_SH64_DELAY_H */
 
diff -urpN linux-2.6.12.src/include/asm-sparc/delay.h linux-2.6.12.delay/include/asm-sparc/delay.h
--- linux-2.6.12.src/include/asm-sparc/delay.h	Tue Oct 19 00:53:45 2004
+++ linux-2.6.12.delay/include/asm-sparc/delay.h	Sun Jul  3 16:27:31 2005
@@ -21,15 +21,15 @@ extern __inline__ void __delay(unsigned 
 }
 
 /* This is too messy with inline asm on the Sparc. */
-extern void __udelay(unsigned long usecs, unsigned long lpj);
-extern void __ndelay(unsigned long nsecs, unsigned long lpj);
+extern void ___udelay(unsigned long usecs, unsigned long lpj);
+extern void ___ndelay(unsigned long nsecs, unsigned long lpj);
 
 #ifdef CONFIG_SMP
 #define __udelay_val	cpu_data(smp_processor_id()).udelay_val
 #else /* SMP */
 #define __udelay_val	loops_per_jiffy
 #endif /* SMP */
-#define udelay(__usecs)	__udelay(__usecs, __udelay_val)
-#define ndelay(__nsecs)	__ndelay(__nsecs, __udelay_val)
+#define __udelay(__usecs)	___udelay(__usecs, __udelay_val)
+#define __ndelay(__nsecs)	___ndelay(__nsecs, __udelay_val)
 
 #endif /* defined(__SPARC_DELAY_H) */
diff -urpN linux-2.6.12.src/include/asm-sparc64/delay.h linux-2.6.12.delay/include/asm-sparc64/delay.h
--- linux-2.6.12.src/include/asm-sparc64/delay.h	Tue Oct 19 00:54:38 2004
+++ linux-2.6.12.delay/include/asm-sparc64/delay.h	Sun Jul  3 16:27:31 2005
@@ -17,21 +17,9 @@
 
 #ifndef __ASSEMBLY__
 
-extern void __bad_udelay(void);
-extern void __bad_ndelay(void);
-
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long nsecs);
-extern void __const_udelay(unsigned long usecs);
-extern void __delay(unsigned long loops);
-
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
-	__udelay(n))
-	
-#define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
-	__ndelay(n))
+#define __ndelay(n) __ndelay(n)
 
 #endif /* !__ASSEMBLY__ */
 
diff -urpN linux-2.6.12.src/include/asm-v850/delay.h linux-2.6.12.delay/include/asm-v850/delay.h
--- linux-2.6.12.src/include/asm-v850/delay.h	Tue Oct 19 00:55:24 2004
+++ linux-2.6.12.delay/include/asm-v850/delay.h	Sun Jul  3 16:27:31 2005
@@ -33,7 +33,7 @@ extern __inline__ void __delay(unsigned 
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void udelay(unsigned long usecs)
+extern __inline__ void __udelay(unsigned long usecs)
 {
 	register unsigned long full_loops, part_loops;
 
diff -urpN linux-2.6.12.src/include/asm-x86_64/delay.h linux-2.6.12.delay/include/asm-x86_64/delay.h
--- linux-2.6.12.src/include/asm-x86_64/delay.h	Tue Oct 19 00:54:32 2004
+++ linux-2.6.12.delay/include/asm-x86_64/delay.h	Sun Jul  3 16:27:31 2005
@@ -7,21 +7,10 @@
  * Delay routines calling functions in arch/x86_64/lib/delay.c
  */
  
-extern void __bad_udelay(void);
-extern void __bad_ndelay(void);
 
 extern void __udelay(unsigned long usecs);
 extern void __ndelay(unsigned long usecs);
-extern void __const_udelay(unsigned long usecs);
+#define __ndelay(n) __ndelay(n)
 extern void __delay(unsigned long loops);
-
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
-	__udelay(n))
-
-#define ndelay(n) (__builtin_constant_p(n) ? \
-       ((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
-       __ndelay(n))
-
 
 #endif /* defined(_X8664_DELAY_H) */
diff -urpN linux-2.6.12.src/include/linux/delay.h linux-2.6.12.delay/include/linux/delay.h
--- linux-2.6.12.src/include/linux/delay.h	Thu Mar  3 09:31:14 2005
+++ linux-2.6.12.delay/include/linux/delay.h	Sun Jul  3 16:27:31 2005
@@ -8,43 +8,66 @@
  */
 
 extern unsigned long loops_per_jiffy;
+extern unsigned int ndelay_offset;
 
 #include <asm/delay.h>
 
 /*
- * Using udelay() for intervals greater than a few milliseconds can
- * risk overflow for high loops_per_jiffy (high bogomips) machines. The
- * mdelay() provides a wrapper to prevent this.  For delays greater
- * than MAX_UDELAY_MS milliseconds, the wrapper is used.  Architecture
- * specific values can be defined in asm-???/delay.h as an override.
- * The 2nd mdelay() definition ensures GCC will optimize away the 
- * while loop for the common cases where n <= MAX_UDELAY_MS  --  Paul G.
+ * Milli, micro and nanosecond delay loops.
+ *
+ * Duration is artificially capped by MAX_MDELAY_MS,
+ * MAX_UDELAY_MS*1000 and MAX_UDELAY_MS*1000*1000 respectively
+ * in order to catch math underflows etc.
+ * At compile time you get link failure, if you slip through
+ * __builtin_constant_p check, ar run time you get a message and
+ * dump_stack in the log and delay is capped.
+ *
+ * Arch has to provide __udelay(n).
+ * It is guaranteed that __udelay(n) is never called with n > 1024.
+ *
+ * Arch may provide a macro __ndelay(n), else ndelay is 'emulated'
+ * by udelay(n/1000). It is guaranteed that __ndelay() is never
+ * called with n > 64*1024.
+ *
+ * Arch may also override default MAX_MDELAY_MS and MAX_UDELAY_MS.
  */
+#ifndef MAX_MDELAY_MS
+#define MAX_MDELAY_MS	5000
+#endif
 
 #ifndef MAX_UDELAY_MS
-#define MAX_UDELAY_MS	5
+#define MAX_UDELAY_MS	20
 #endif
 
-#ifdef notdef
-#define mdelay(n) (\
-	{unsigned long __ms=(n); while (__ms--) udelay(1000);})
-#else
-#define mdelay(n) (\
-	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
-	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
-#endif
+/* defined nowhere */
+void BUG_overlong_mdelay(void);
+void BUG_overlong_udelay(void);
+void BUG_overlong_ndelay(void);
+
+void _mdelay(unsigned int msecs);
+void _udelay(unsigned int usecs);
+void _ndelay(unsigned int nsecs);
+
+#define mdelay(n) ( \
+	(__builtin_constant_p(n) && (unsigned int)(n)>MAX_MDELAY_MS) ? \
+	BUG_overlong_mdelay() : _mdelay(n))
+
+#define udelay(n) ( \
+	(__builtin_constant_p(n) && (unsigned int)(n)>MAX_UDELAY_MS*1000) ? \
+	BUG_overlong_udelay() : _udelay(n))
 
-#ifndef ndelay
-#define ndelay(x)	udelay(((x)+999)/1000)
+#ifndef __ndelay
+#define __ndelay(x)	__udelay(((x)+999)/1000)
 #endif
 
+#define ndelay(n) ( \
+	(__builtin_constant_p(n) && (unsigned int)(n)>MAX_UDELAY_MS*1000*1000) ? \
+	BUG_overlong_ndelay() : _ndelay(n))
+
 void calibrate_delay(void);
+void calibrate_ndelay_offset(void);
+void ssleep(unsigned int secs);
 void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
-
-static inline void ssleep(unsigned int seconds)
-{
-	msleep(seconds * 1000);
-}
 
 #endif /* defined(_LINUX_DELAY_H) */
diff -urpN linux-2.6.12.src/kernel/timer.c linux-2.6.12.delay/kernel/timer.c
--- linux-2.6.12.src/kernel/timer.c	Sat Jun 25 14:50:22 2005
+++ linux-2.6.12.delay/kernel/timer.c	Sun Jul  3 16:27:31 2005
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -89,6 +90,117 @@ static inline void set_running_timer(tve
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
+/***
+ * Arch __udelay() for intervals greater than a few milliseconds can
+ * risk overflow for high loops_per_jiffy (high bogomips) machines. The
+ * _Xdelay() provide wrappers to prevent this.
+ *
+ * It's not inlined because we do not optimize delays for speed,
+ * but for code size at delay callsite
+ */
+void _mdelay(unsigned int msecs)
+{
+	if (msecs > MAX_MDELAY_MS) {
+		printk("BUG: delay too large: %cdelay(%u)\n", 'm', msecs);
+		dump_stack();
+		msecs = MAX_MDELAY_MS;
+	}
+	while (msecs) {
+		__udelay(1000);
+		msecs--;
+	}
+}
+EXPORT_SYMBOL(_mdelay);
+
+void _udelay(unsigned int usecs)
+{
+	unsigned int k;
+	if (usecs > MAX_UDELAY_MS*1000) {
+		printk("BUG: delay too large: %cdelay(%u)\n", 'u', usecs);
+		dump_stack();
+		usecs = MAX_UDELAY_MS*1000;
+	}
+	k = usecs / 1024;
+	while (k) {
+		__udelay(1024);
+		k--;
+	}
+	__udelay(usecs % 1024);
+}
+EXPORT_SYMBOL(_udelay);
+
+unsigned int ndelay_offset;
+
+void _ndelay(unsigned int nsecs)
+{
+	unsigned int k;
+	if (nsecs > MAX_UDELAY_MS*1000*1000) {
+		printk("BUG: delay too large: %cdelay(%u)\n", 'n', nsecs);
+		dump_stack();
+		nsecs = MAX_UDELAY_MS*1000*1000;
+	}
+	nsecs -= ndelay_offset;
+	if ((int)nsecs < 0)
+		nsecs = 0;
+	k = nsecs / (64*1024);
+	while (k) {
+		__ndelay(64*1024);
+		k--;
+	}
+	__ndelay(nsecs % (64*1024));
+}
+EXPORT_SYMBOL(_ndelay);
+
+#if defined(rdtscl)
+static int time_ndelay(int n)
+{
+	int a, b, null;
+	rdtscl(a);
+	rdtscl(b);
+	null = b - a;
+	rdtscl(a);
+	ndelay(n);
+	rdtscl(b);
+	return b - a - null;
+}
+
+static int cpu_ticks(int n)
+{
+	int t, i;
+	int minimum, maximum, avg;
+
+	avg = 0;
+	minimum = INT_MAX;
+	maximum = 0;
+	time_ndelay(n); /* warm up icache */
+	for(i = 0; i < 3; i++) {
+		t = time_ndelay(n);
+		if (t < minimum) minimum = t;
+		if (t > maximum) maximum = t;
+		avg += t;
+	}
+	avg = (avg - minimum - maximum);
+	return avg;
+}
+
+void calibrate_ndelay_offset(void)
+{
+	int a, b;
+	ndelay_offset = 0;
+	a = cpu_ticks(1000);
+	b = cpu_ticks(17000);
+	/*
+	 * (a*17-b)/16: 'extra' ticks happened per ndelay.
+	 * need to convert it into ns, and we have all data handy:
+	 * extra_ns = extra_ticks * ns_per_ticks = extra_ticks * (17000/b)
+	 */
+	ndelay_offset = ( ((a*17-b+8)/16) * 17000 + b/2) / b;
+	printk("Calibrated ndelay_offset: %d\n", ndelay_offset);
+}
+#else
+void calibrate_ndelay_offset(void) {}
+#endif
+
 static void check_timer_failed(struct timer_list *timer)
 {
 	static int whine_count;
@@ -1594,8 +1706,13 @@ void msleep(unsigned int msecs)
 		timeout = schedule_timeout(timeout);
 	}
 }
-
 EXPORT_SYMBOL(msleep);
+
+void ssleep(unsigned int secs)
+{
+	msleep(secs * 1000);
+}
+EXPORT_SYMBOL(ssleep);
 
 /**
  * msleep_interruptible - sleep waiting for waitqueue interruptions

