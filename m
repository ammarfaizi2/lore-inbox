Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263290AbVGAJil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbVGAJil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 05:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbVGAJil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 05:38:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59853 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263290AbVGAJfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 05:35:41 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] all-arch delay patch
Date: Fri, 1 Jul 2005 12:35:07 +0300
User-Agent: KMail/1.5.4
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L5QxCe/i+o/SeiV"
Message-Id: <200507011235.07952.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_L5QxCe/i+o/SeiV
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This one is for review only by arch maintainers.

Run tested on i386.

# size vmlinux.org vmlinux.delay
   text    data     bss     dec     hex filename
4345737 1607102  259296 6212135  5eca27 vmlinux.org
4345296 1604470  259296 6209062  5ebe26 vmlinux.delay

If someone from non-i386 land with a bit of time to spare
wants to test it, that will be appreciated.
Add #include <linux/delay.h> if you will get undefined refs to
[mun]delay(). (I already did in two files IIRC).

Vojtech, I did not read your mail when I worked on the patch,
thus your ndelay() concerns are not addressed.

find.out.bz2 has some less boring cases of delays grepped
from kernel source. Selected gems are:

aic79xx_osm.h:
ahd_delay(long usec)
{
        /*
         * udelay on Linux can have problems for
         * multi-millisecond waits.  Wait at most
         * 1024us per call.
         */
        while (usec > 0) {
                udelay(usec % 1024);
                usec -= 1024;
        }
}

arch/i386/kernel/traps.c:
        outb(reason, 0x61);
        i = 2000;
        while (--i) udelay(1000);
        reason &= ~8;
        outb(reason, 0x61);

sound/oss/ad1889.c:
//now 100ms
/* #define WAIT_10MS()  schedule_timeout(HZ/10) */
#define WAIT_10MS()     do { int __i; for (__i = 0; __i < 100; __i++) udelay(1000); } while(0)

drivers/isdn/hisax/hisax.h:
#define HZDELAY(jiffs) {int tout = jiffs; while (tout--) udelay(1000000/HZ);}

drivers/scsi/u14-34f.c:
while ((jiffies - time) < HZ && limit++ < 20000) udelay(100L);
...
while ((jiffies - time) < (10 * HZ) && limit++ < 200000) udelay(100L);

sound/isa/es18xx.c:
        udelay(100000);

drivers/scsi/aha152x.c:
        mdelay(10000);
--
vda

--Boundary-00=_L5QxCe/i+o/SeiV
Content-Type: text/x-diff;
  charset="koi8-r";
  name="delay.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="delay.patch"

diff -U10 -urpN linux-2.6.12.org/arch/alpha/lib/udelay.c linux-2.6.12.delay/arch/alpha/lib/udelay.c
--- linux-2.6.12.org/arch/alpha/lib/udelay.c	Tue Oct 19 00:54:39 2004
+++ linux-2.6.12.delay/arch/alpha/lib/udelay.c	Thu Jun 30 22:48:06 2005
@@ -32,24 +32,24 @@ __delay(int loops)
 		: "=&r" (tmp), "=r" (loops) : "1"(loops));
 }
 
 #ifdef CONFIG_SMP
 #define LPJ	 cpu_data[smp_processor_id()].loops_per_jiffy
 #else
 #define LPJ	 loops_per_jiffy
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
diff -U10 -urpN linux-2.6.12.org/arch/arm/kernel/armksyms.c linux-2.6.12.delay/arch/arm/kernel/armksyms.c
--- linux-2.6.12.org/arch/arm/kernel/armksyms.c	Thu Feb  3 11:38:47 2005
+++ linux-2.6.12.delay/arch/arm/kernel/armksyms.c	Thu Jun 30 22:42:50 2005
@@ -54,21 +54,20 @@ extern void fp_enter(void);
  * These symbols will never change their calling convention...
  */
 EXPORT_SYMBOL_ALIAS(kern_fp_enter,fp_enter);
 EXPORT_SYMBOL_ALIAS(fp_printk,printk);
 EXPORT_SYMBOL_ALIAS(fp_send_sig,send_sig);
 
 EXPORT_SYMBOL(__backtrace);
 
 	/* platform dependent support */
 EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__const_udelay);
 
 	/* networking */
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(__csum_ipv6_magic);
 
 	/* io */
 #ifndef __raw_readsb
 EXPORT_SYMBOL(__raw_readsb);
 #endif
diff -U10 -urpN linux-2.6.12.org/arch/arm/lib/delay.S linux-2.6.12.delay/arch/arm/lib/delay.S
--- linux-2.6.12.org/arch/arm/lib/delay.S	Thu Feb  3 11:38:48 2005
+++ linux-2.6.12.delay/arch/arm/lib/delay.S	Thu Jun 30 22:44:30 2005
@@ -13,21 +13,21 @@
 
 LC0:		.word	loops_per_jiffy
 
 /*
  * 0 <= r0 <= 2000
  */
 ENTRY(__udelay)
 		mov	r2,     #0x6800
 		orr	r2, r2, #0x00db
 		mul	r0, r2, r0
-ENTRY(__const_udelay)				@ 0 <= r0 <= 0x01ffffff
+						@ 0 <= r0 <= 0x01ffffff
 		ldr	r2, LC0
 		ldr	r2, [r2]		@ max = 0x0fffffff
 		mov	r0, r0, lsr #11		@ max = 0x00003fff
 		mov	r2, r2, lsr #11		@ max = 0x0003ffff
 		mul	r0, r2, r0		@ max = 2^32-1
 		movs	r0, r0, lsr #6
 		RETINSTR(moveq,pc,lr)
 
 /*
  * loops = (r0 * 0x10c6 * 100 * loops_per_jiffy) / 2^32
diff -U10 -urpN linux-2.6.12.org/arch/i386/kernel/i386_ksyms.c linux-2.6.12.delay/arch/i386/kernel/i386_ksyms.c
--- linux-2.6.12.org/arch/i386/kernel/i386_ksyms.c	Sun Jun 19 16:09:49 2005
+++ linux-2.6.12.delay/arch/i386/kernel/i386_ksyms.c	Thu Jun 30 20:33:42 2005
@@ -84,21 +84,20 @@ EXPORT_SYMBOL(apm_info);
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
 EXPORT_SYMBOL(__down_failed_trylock);
 EXPORT_SYMBOL(__up_wakeup);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
 EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
 EXPORT_SYMBOL(__get_user_4);
 
 EXPORT_SYMBOL(__put_user_1);
 EXPORT_SYMBOL(__put_user_2);
 EXPORT_SYMBOL(__put_user_4);
 EXPORT_SYMBOL(__put_user_8);
 
diff -U10 -urpN linux-2.6.12.org/arch/i386/kernel/i8259.c linux-2.6.12.delay/arch/i386/kernel/i8259.c
--- linux-2.6.12.org/arch/i386/kernel/i8259.c	Sun Jun 19 16:09:49 2005
+++ linux-2.6.12.delay/arch/i386/kernel/i8259.c	Fri Jul  1 00:18:40 2005
@@ -4,20 +4,21 @@
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/8253pit.h>
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/timer.h>
 #include <asm/pgtable.h>
 #include <asm/delay.h>
 #include <asm/desc.h>
diff -U10 -urpN linux-2.6.12.org/arch/i386/kernel/timers/timer_pit.c linux-2.6.12.delay/arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.12.org/arch/i386/kernel/timers/timer_pit.c	Thu Feb  3 11:38:53 2005
+++ linux-2.6.12.delay/arch/i386/kernel/timers/timer_pit.c	Fri Jul  1 00:20:04 2005
@@ -2,21 +2,21 @@
  * This code largely moved from arch/i386/kernel/time.c.
  * See comments there for proper credits.
  */
 
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/sysdev.h>
 #include <linux/timex.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/mpspec.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
 #include <asm/io.h>
 #include <asm/arch_hooks.h>
 
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;
 #include "do_timer.h"
 #include "io_ports.h"
diff -U10 -urpN linux-2.6.12.org/arch/i386/lib/delay.c linux-2.6.12.delay/arch/i386/lib/delay.c
--- linux-2.6.12.org/arch/i386/lib/delay.c	Thu Mar  3 09:30:10 2005
+++ linux-2.6.12.delay/arch/i386/lib/delay.c	Thu Jun 30 20:33:54 2005
@@ -21,21 +21,21 @@
 #include <asm/smp.h>
 #endif
 
 extern struct timer_opts* timer;
 
 void __delay(unsigned long loops)
 {
 	cur_timer->delay(loops);
 }
 
-inline void __const_udelay(unsigned long xloops)
+static inline void __const_udelay(unsigned long xloops)
 {
 	int d0;
 	xloops *= 4;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
 		:"1" (xloops),"0" (cpu_data[_smp_processor_id()].loops_per_jiffy * (HZ/4)));
         __delay(++xloops);
 }
 
 void __udelay(unsigned long usecs)
diff -U10 -urpN linux-2.6.12.org/arch/m32r/kernel/m32r_ksyms.c linux-2.6.12.delay/arch/m32r/kernel/m32r_ksyms.c
--- linux-2.6.12.org/arch/m32r/kernel/m32r_ksyms.c	Sun Jun 19 16:09:52 2005
+++ linux-2.6.12.delay/arch/m32r/kernel/m32r_ksyms.c	Thu Jun 30 20:31:44 2005
@@ -37,21 +37,20 @@ EXPORT_SYMBOL(disable_irq_nosync);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(__down);
 EXPORT_SYMBOL(__down_interruptible);
 EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(__down_trylock);
 
 /* Networking helper routines. */
 /* Delay loops */
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
 EXPORT_SYMBOL(__get_user_4);
 
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 
 EXPORT_SYMBOL(strncpy_from_user);
 EXPORT_SYMBOL(__strncpy_from_user);
diff -U10 -urpN linux-2.6.12.org/arch/m32r/lib/delay.c linux-2.6.12.delay/arch/m32r/lib/delay.c
--- linux-2.6.12.org/arch/m32r/lib/delay.c	Thu Feb  3 11:38:55 2005
+++ linux-2.6.12.delay/arch/m32r/lib/delay.c	Thu Jun 30 20:31:36 2005
@@ -51,21 +51,21 @@ void __delay(unsigned long loops)
 		"addi	%0, #-1			\n\t"
 		"bgtz	%0, 1b			\n\t"
 		" .fillinsn			\n\t"
 		"2:				\n\t"
 		: "+r" (loops)
 		: "r" (0)
 	);
 #endif
 }
 
-void __const_udelay(unsigned long xloops)
+static void __const_udelay(unsigned long xloops)
 {
 #if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 	/*
 	 * loops [1] = (xloops >> 32) [sec] * loops_per_jiffy [1/jiffy]
 	 *            * HZ [jiffy/sec]
 	 *          = (xloops >> 32) [sec] * (loops_per_jiffy * HZ) [1/sec]
 	 *          = (((xloops * loops_per_jiffy) >> 32) * HZ) [1]
 	 *
 	 * NOTE:
 	 *   - '[]' depicts variable's dimension in the above equation.
diff -U10 -urpN linux-2.6.12.org/arch/m68knommu/lib/delay.c linux-2.6.12.delay/arch/m68knommu/lib/delay.c
--- linux-2.6.12.org/arch/m68knommu/lib/delay.c	Thu Mar  3 09:30:14 2005
+++ linux-2.6.12.delay/arch/m68knommu/lib/delay.c	Thu Jun 30 20:29:49 2005
@@ -5,17 +5,69 @@
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
 #include <linux/module.h>
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
+ *	have this instruction. So for them we have a clsoe approximation
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
 
diff -U10 -urpN linux-2.6.12.org/arch/sh/kernel/sh_ksyms.c linux-2.6.12.delay/arch/sh/kernel/sh_ksyms.c
--- linux-2.6.12.org/arch/sh/kernel/sh_ksyms.c	Sun Jun 19 16:09:58 2005
+++ linux-2.6.12.delay/arch/sh/kernel/sh_ksyms.c	Thu Jun 30 20:32:27 2005
@@ -70,21 +70,20 @@ EXPORT_SYMBOL(boot_cpu_data);
 EXPORT_SYMBOL(get_vm_area);
 #endif
 
 /* semaphore exports */
 EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(__down);
 EXPORT_SYMBOL(__down_interruptible);
 
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__div64_32);
 
 #define DECLARE_EXPORT(name) extern void name(void);EXPORT_SYMBOL(name)
 
 /* These symbols are generated by the compiler itself */
 DECLARE_EXPORT(__udivsi3);
 DECLARE_EXPORT(__udivdi3);
 DECLARE_EXPORT(__sdivsi3);
 DECLARE_EXPORT(__ashrdi3);
diff -U10 -urpN linux-2.6.12.org/arch/sh/lib/delay.c linux-2.6.12.delay/arch/sh/lib/delay.c
--- linux-2.6.12.org/arch/sh/lib/delay.c	Thu Mar  3 09:30:22 2005
+++ linux-2.6.12.delay/arch/sh/lib/delay.c	Thu Jun 30 20:32:33 2005
@@ -12,21 +12,21 @@ void __delay(unsigned long loops)
 	__asm__ __volatile__(
 		"tst	%0, %0\n\t"
 		"1:\t"
 		"bf/s	1b\n\t"
 		" dt	%0"
 		: "=r" (loops)
 		: "0" (loops)
 		: "t");
 }
 
-inline void __const_udelay(unsigned long xloops)
+static inline void __const_udelay(unsigned long xloops)
 {
 	__asm__("dmulu.l	%0, %2\n\t"
 		"sts	mach, %0"
 		: "=r" (xloops)
 		: "0" (xloops), "r" (cpu_data[_smp_processor_id()].loops_per_jiffy)
 		: "macl", "mach");
 	__delay(xloops * HZ);
 }
 
 void __udelay(unsigned long usecs)
diff -U10 -urpN linux-2.6.12.org/arch/sh64/lib/udelay.c linux-2.6.12.delay/arch/sh64/lib/udelay.c
--- linux-2.6.12.org/arch/sh64/lib/udelay.c	Tue Oct 19 00:53:46 2004
+++ linux-2.6.12.delay/arch/sh64/lib/udelay.c	Thu Jun 30 22:46:11 2005
@@ -29,32 +29,21 @@ void __delay(int loops)
 	long long dummy;
 	__asm__ __volatile__("gettr	tr0, %1\n\t"
 			     "pta	$+4, tr0\n\t"
 			     "addi	%0, -1, %0\n\t"
 			     "bne	%0, r63, tr0\n\t"
 			     "ptabs	%1, tr0\n\t":"=r"(loops),
 			     "=r"(dummy)
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
diff -U10 -urpN linux-2.6.12.org/arch/sparc/kernel/entry.S linux-2.6.12.delay/arch/sparc/kernel/entry.S
--- linux-2.6.12.org/arch/sparc/kernel/entry.S	Thu Feb  3 11:39:08 2005
+++ linux-2.6.12.delay/arch/sparc/kernel/entry.S	Thu Jun 30 19:56:48 2005
@@ -1789,40 +1789,40 @@ fpload:
 	ldd	[%o0 + 0x50], %f20
 	ldd	[%o0 + 0x58], %f22
 	ldd	[%o0 + 0x60], %f24
 	ldd	[%o0 + 0x68], %f26
 	ldd	[%o0 + 0x70], %f28
 	ldd	[%o0 + 0x78], %f30
 	ld	[%o1], %fsr
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
 	 mov	0x1ad, %o1		! 2**32 / (1 000 000 000 / HZ)
 	call	.umul
 	 mov	%i1, %o1		! udelay_val
 	ba	delay_continue
 	 mov	%o1, %o0		! >>32 later for better resolution
 
-	.globl	__udelay
-__udelay:
+	.globl	___udelay
+___udelay:
 	save	%sp, -STACKFRAME_SZ, %sp
 	mov	%i0, %o0
 	sethi	%hi(0x10c6), %o1
 	call	.umul
 	 or	%o1, %lo(0x10c6), %o1	! 2**32 / 1 000 000
 	call	.umul
 	 mov	%i1, %o1		! udelay_val
 	call	.umul
 	 mov	HZ, %o0			! >>32 earlier for wider range
 
diff -U10 -urpN linux-2.6.12.org/arch/sparc/kernel/sparc_ksyms.c linux-2.6.12.delay/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.12.org/arch/sparc/kernel/sparc_ksyms.c	Sun Jun 19 16:09:59 2005
+++ linux-2.6.12.delay/arch/sparc/kernel/sparc_ksyms.c	Thu Jun 30 19:57:13 2005
@@ -157,22 +157,22 @@ EXPORT_SYMBOL(synchronize_irq);
 
 /* Misc SMP information */
 EXPORT_SYMBOL(__cpu_number_map);
 EXPORT_SYMBOL(__cpu_logical_map);
 
 /* CPU online map and active count. */
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(phys_cpu_present_map);
 #endif
 
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__ndelay);
+EXPORT_SYMBOL(___udelay);
+EXPORT_SYMBOL(___ndelay);
 EXPORT_SYMBOL(rtc_lock);
 EXPORT_SYMBOL(mostek_lock);
 EXPORT_SYMBOL(mstk48t02_regs);
 #ifdef CONFIG_SUN_AUXIO
 EXPORT_SYMBOL(set_auxio);
 EXPORT_SYMBOL(get_auxio);
 #endif
 EXPORT_SYMBOL(request_fast_irq);
 EXPORT_SYMBOL(io_remap_page_range);
 EXPORT_SYMBOL(io_remap_pfn_range);
diff -U10 -urpN linux-2.6.12.org/arch/sparc64/kernel/sparc64_ksyms.c linux-2.6.12.delay/arch/sparc64/kernel/sparc64_ksyms.c
--- linux-2.6.12.org/arch/sparc64/kernel/sparc64_ksyms.c	Sun Jun 19 16:10:00 2005
+++ linux-2.6.12.delay/arch/sparc64/kernel/sparc64_ksyms.c	Thu Jun 30 20:35:43 2005
@@ -393,21 +393,20 @@ EXPORT_SYMBOL(__ret_efault);
 /* No version information on these, as gcc produces such symbols. */
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(strncmp);
 
 /* Delay routines. */
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__const_udelay);
 EXPORT_SYMBOL(__delay);
 
 void VISenter(void);
 /* RAID code needs this */
 EXPORT_SYMBOL(VISenter);
 
 /* for input/keybdev */
 EXPORT_SYMBOL(sun_do_break);
 EXPORT_SYMBOL(serial_console);
 EXPORT_SYMBOL(stop_a_enabled);
diff -U10 -urpN linux-2.6.12.org/arch/sparc64/lib/delay.c linux-2.6.12.delay/arch/sparc64/lib/delay.c
--- linux-2.6.12.org/arch/sparc64/lib/delay.c	Thu Mar  3 09:30:22 2005
+++ linux-2.6.12.delay/arch/sparc64/lib/delay.c	Thu Jun 30 20:35:40 2005
@@ -20,21 +20,21 @@ void __delay(unsigned long loops)
 "	 subcc	%0, 1, %0\n"
 	: "=&r" (loops)
 	: "0" (loops)
 	: "cc");
 }
 
 /* We used to multiply by HZ after shifting down by 32 bits
  * but that runs into problems for higher values of HZ and
  * slow cpus.
  */
-void __const_udelay(unsigned long n)
+static void __const_udelay(unsigned long n)
 {
 	n *= 4;
 
 	n *= (cpu_data(_smp_processor_id()).udelay_val * (HZ/4));
 	n >>= 32;
 
 	__delay(n + 1);
 }
 
 void __udelay(unsigned long n)
diff -U10 -urpN linux-2.6.12.org/arch/um/sys-i386/delay.c linux-2.6.12.delay/arch/um/sys-i386/delay.c
--- linux-2.6.12.org/arch/um/sys-i386/delay.c	Sun Jun 19 16:10:01 2005
+++ linux-2.6.12.delay/arch/um/sys-i386/delay.c	Thu Jun 30 22:43:14 2005
@@ -20,21 +20,10 @@ void __delay(unsigned long time)
 void __udelay(unsigned long usecs)
 {
 	int i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
         for(i=0;i<n;i++)
                 cpu_relax();
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
diff -U10 -urpN linux-2.6.12.org/arch/um/sys-i386/ksyms.c linux-2.6.12.delay/arch/um/sys-i386/ksyms.c
--- linux-2.6.12.org/arch/um/sys-i386/ksyms.c	Sun Jun 19 16:10:01 2005
+++ linux-2.6.12.delay/arch/um/sys-i386/ksyms.c	Thu Jun 30 22:43:50 2005
@@ -10,12 +10,11 @@
 
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
 EXPORT_SYMBOL(__down_failed_trylock);
 EXPORT_SYMBOL(__up_wakeup);
 
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial);
 
 /* delay core functions */
-EXPORT_SYMBOL(__const_udelay);
 EXPORT_SYMBOL(__udelay);
diff -U10 -urpN linux-2.6.12.org/arch/um/sys-x86_64/delay.c linux-2.6.12.delay/arch/um/sys-x86_64/delay.c
--- linux-2.6.12.org/arch/um/sys-x86_64/delay.c	Sun Jun 19 16:10:01 2005
+++ linux-2.6.12.delay/arch/um/sys-x86_64/delay.c	Thu Jun 30 22:43:27 2005
@@ -21,21 +21,10 @@ void __delay(unsigned long loops)
 void __udelay(unsigned long usecs)
 {
 	unsigned long i, n;
 
 	n = (loops_per_jiffy * HZ * usecs) / MILLION;
         for(i=0;i<n;i++)
                 cpu_relax();
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
diff -U10 -urpN linux-2.6.12.org/arch/x86_64/kernel/x8664_ksyms.c linux-2.6.12.delay/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.12.org/arch/x86_64/kernel/x8664_ksyms.c	Sun Jun 19 16:10:03 2005
+++ linux-2.6.12.delay/arch/x86_64/kernel/x8664_ksyms.c	Thu Jun 30 20:37:34 2005
@@ -66,21 +66,20 @@ EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
 EXPORT_SYMBOL(__down_failed_trylock);
 EXPORT_SYMBOL(__up_wakeup);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(ip_compute_csum);
 /* Delay loops */
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
 EXPORT_SYMBOL(__get_user_4);
 EXPORT_SYMBOL(__get_user_8);
 EXPORT_SYMBOL(__put_user_1);
 EXPORT_SYMBOL(__put_user_2);
 EXPORT_SYMBOL(__put_user_4);
 EXPORT_SYMBOL(__put_user_8);
 
diff -U10 -urpN linux-2.6.12.org/arch/x86_64/lib/delay.c linux-2.6.12.delay/arch/x86_64/lib/delay.c
--- linux-2.6.12.org/arch/x86_64/lib/delay.c	Sun Jun 19 16:10:03 2005
+++ linux-2.6.12.delay/arch/x86_64/lib/delay.c	Thu Jun 30 20:35:15 2005
@@ -25,21 +25,21 @@ void __delay(unsigned long loops)
 	
 	rdtscl(bclock);
 	do
 	{
 		rep_nop(); 
 		rdtscl(now);
 	}
 	while((now-bclock) < loops);
 }
 
-inline void __const_udelay(unsigned long xloops)
+static inline void __const_udelay(unsigned long xloops)
 {
 	__delay(((xloops * cpu_data[_smp_processor_id()].loops_per_jiffy) >> 32) * HZ);
 }
 
 void __udelay(unsigned long usecs)
 {
 	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
 }
 
 void __ndelay(unsigned long nsecs)
diff -U10 -urpN linux-2.6.12.org/include/asm-alpha/delay.h linux-2.6.12.delay/include/asm-alpha/delay.h
--- linux-2.6.12.org/include/asm-alpha/delay.h	Tue Oct 19 00:53:51 2004
+++ linux-2.6.12.delay/include/asm-alpha/delay.h	Thu Jun 30 19:58:07 2005
@@ -1,10 +1,9 @@
 #ifndef __ALPHA_DELAY_H
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
diff -U10 -urpN linux-2.6.12.org/include/asm-arm/delay.h linux-2.6.12.delay/include/asm-arm/delay.h
--- linux-2.6.12.org/include/asm-arm/delay.h	Thu Feb  3 11:40:05 2005
+++ linux-2.6.12.delay/include/asm-arm/delay.h	Thu Jun 30 20:24:49 2005
@@ -1,42 +1,16 @@
 /*
  * Copyright (C) 1995-2004 Russell King
  *
  * Delay routines, using a pre-computed "loops_per_second" value.
  */
 #ifndef __ASM_ARM_DELAY_H
 #define __ASM_ARM_DELAY_H
 
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
 
diff -U10 -urpN linux-2.6.12.org/include/asm-arm26/delay.h linux-2.6.12.delay/include/asm-arm26/delay.h
--- linux-2.6.12.org/include/asm-arm26/delay.h	Tue Oct 19 00:53:06 2004
+++ linux-2.6.12.delay/include/asm-arm26/delay.h	Thu Jun 30 19:38:27 2005
@@ -14,21 +14,21 @@ extern void __delay(int loops);
  * loss of precision.
  *
  * Use only for very small delays ( < 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
  * short delays.  This is a "reasonable" implementation, though (and the
  * first constant multiplications gets optimized away if the delay is
  * a constant)
  *
  * FIXME - lets improve it then...
  */
-extern void udelay(unsigned long usecs);
+extern void __udelay(unsigned long usecs);
 
 static inline unsigned long muldiv(unsigned long a, unsigned long b, unsigned long c)
 {
 	return a * b / c;
 }
 
 	
 
 #endif /* defined(_ARM_DELAY_H) */
 
diff -U10 -urpN linux-2.6.12.org/include/asm-cris/delay.h linux-2.6.12.delay/include/asm-cris/delay.h
--- linux-2.6.12.org/include/asm-cris/delay.h	Tue Oct 19 00:55:23 2004
+++ linux-2.6.12.delay/include/asm-cris/delay.h	Thu Jun 30 19:33:41 2005
@@ -6,19 +6,19 @@
  *
  * Delay routines, using a pre-computed "loops_per_second" value.
  */
 
 #include <asm/arch/delay.h>
 
 /* Use only for very small delays ( < 1 msec).  */
 
 extern unsigned long loops_per_usec; /* arch/cris/mm/init.c */
 
-extern __inline__ void udelay(unsigned long usecs)
+extern __inline__ void __udelay(unsigned long usecs)
 {
 	__delay(usecs * loops_per_usec);
 }
 
 #endif /* defined(_CRIS_DELAY_H) */
 
 
 
diff -U10 -urpN linux-2.6.12.org/include/asm-frv/delay.h linux-2.6.12.delay/include/asm-frv/delay.h
--- linux-2.6.12.org/include/asm-frv/delay.h	Thu Mar  3 09:31:07 2005
+++ linux-2.6.12.delay/include/asm-frv/delay.h	Thu Jun 30 19:22:31 2005
@@ -33,18 +33,18 @@ static inline void __delay(unsigned long
 /*
  * Use only for very small delays ( < 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
  * short delays.  This is a "reasonable" implementation, though (and the
  * first constant multiplications gets optimized away if the delay is
  * a constant)
  */
 
 extern unsigned long loops_per_jiffy;
 
-static inline void udelay(unsigned long usecs)
+static inline void __udelay(unsigned long usecs)
 {
 	__delay(usecs * __delay_loops_MHz);
 }
 
-#define ndelay(n)	udelay((n) * 5)
+//BOGUS! #define ndelay(n)	udelay((n) * 5)
 
 #endif /* _ASM_DELAY_H */
diff -U10 -urpN linux-2.6.12.org/include/asm-h8300/delay.h linux-2.6.12.delay/include/asm-h8300/delay.h
--- linux-2.6.12.org/include/asm-h8300/delay.h	Thu Feb  3 11:40:05 2005
+++ linux-2.6.12.delay/include/asm-h8300/delay.h	Thu Jun 30 19:38:09 2005
@@ -20,19 +20,19 @@ extern __inline__ void __delay(unsigned 
 /*
  * Use only for very small delays ( < 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
  * short delays.  This is a "reasonable" implementation, though (and the
  * first constant multiplications gets optimized away if the delay is
  * a constant)  
  */
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void udelay(unsigned long usecs)
+extern __inline__ void __udelay(unsigned long usecs)
 {
 	usecs *= 4295;		/* 2**32 / 1000000 */
 	usecs /= (loops_per_jiffy*HZ);
 	if (usecs)
 		__delay(usecs);
 }
 
 #endif /* _H8300_DELAY_H */
diff -U10 -urpN linux-2.6.12.org/include/asm-i386/delay.h linux-2.6.12.delay/include/asm-i386/delay.h
--- linux-2.6.12.org/include/asm-i386/delay.h	Tue Oct 19 00:53:05 2004
+++ linux-2.6.12.delay/include/asm-i386/delay.h	Thu Jun 30 20:34:21 2005
@@ -1,26 +1,15 @@
 #ifndef _I386_DELAY_H
 #define _I386_DELAY_H
 
 /*
  * Copyright (C) 1993 Linus Torvalds
  *
  * Delay routines calling functions in arch/i386/lib/delay.c
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
 
 #endif /* defined(_I386_DELAY_H) */
diff -U10 -urpN linux-2.6.12.org/include/asm-m32r/delay.h linux-2.6.12.delay/include/asm-m32r/delay.h
--- linux-2.6.12.org/include/asm-m32r/delay.h	Tue Oct 19 00:53:45 2004
+++ linux-2.6.12.delay/include/asm-m32r/delay.h	Thu Jun 30 20:32:48 2005
@@ -2,27 +2,16 @@
 #define _ASM_M32R_DELAY_H
 
 /* $Id$ */
 
 /*
  * Copyright (C) 1993 Linus Torvalds
  *
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
diff -U10 -urpN linux-2.6.12.org/include/asm-m68k/delay.h linux-2.6.12.delay/include/asm-m68k/delay.h
--- linux-2.6.12.org/include/asm-m68k/delay.h	Tue Oct 19 00:55:28 2004
+++ linux-2.6.12.delay/include/asm-m68k/delay.h	Thu Jun 30 20:29:04 2005
@@ -8,22 +8,20 @@
  *
  * Delay routines, using a pre-computed "loops_per_jiffy" value.
  */
 
 static inline void __delay(unsigned long loops)
 {
 	__asm__ __volatile__ ("1: subql #1,%0; jcc 1b"
 		: "=d" (loops) : "0" (loops));
 }
 
-extern void __bad_udelay(void);
-
 /*
  * Use only for very small delays ( < 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
  * short delays.  This is a "reasonable" implementation, though (and the
  * first constant multiplications gets optimized away if the delay is
  * a constant)
  */
 static inline void __const_udelay(unsigned long xloops)
 {
 	unsigned long tmp;
@@ -31,24 +29,20 @@ static inline void __const_udelay(unsign
 	__asm__ ("mulul %2,%0:%1"
 		: "=d" (xloops), "=d" (tmp)
 		: "d" (xloops), "1" (loops_per_jiffy));
 	__delay(xloops * HZ);
 }
 
 static inline void __udelay(unsigned long usecs)
 {
 	__const_udelay(usecs * 4295);	/* 2**32 / 1000000 */
 }
-
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 4295)) : \
-	__udelay(n))
 
 static inline unsigned long muldiv(unsigned long a, unsigned long b,
 				   unsigned long c)
 {
 	unsigned long tmp;
 
 	__asm__ ("mulul %2,%0:%1; divul %3,%0:%1"
 		: "=d" (tmp), "=d" (a)
 		: "d" (b), "d" (c), "1" (a));
 	return a;
diff -U10 -urpN linux-2.6.12.org/include/asm-m68knommu/delay.h linux-2.6.12.delay/include/asm-m68knommu/delay.h
--- linux-2.6.12.org/include/asm-m68knommu/delay.h	Thu Feb  3 11:40:08 2005
+++ linux-2.6.12.delay/include/asm-m68knommu/delay.h	Thu Jun 30 20:27:54 2005
@@ -1,76 +1,13 @@
 #ifndef _M68KNOMMU_DELAY_H
 #define _M68KNOMMU_DELAY_H
 
 /*
  * Copyright (C) 1994 Hamish Macdonald
  * Copyright (C) 2004 Greg Ungerer <gerg@snapgear.com>
  */
 
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
diff -U10 -urpN linux-2.6.12.org/include/asm-mips/delay.h linux-2.6.12.delay/include/asm-mips/delay.h
--- linux-2.6.12.org/include/asm-mips/delay.h	Thu Feb  3 11:40:09 2005
+++ linux-2.6.12.delay/include/asm-mips/delay.h	Thu Jun 30 20:29:34 2005
@@ -42,52 +42,50 @@ static inline void __delay(unsigned long
  * Division by multiplication: you don't have to worry about
  * loss of precision.
  *
  * Use only for very small delays ( < 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
  * short delays.  This is a "reasonable" implementation, though (and the
  * first constant multiplications gets optimized away if the delay is
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
 	 */
 #if defined(CONFIG_MIPS64) && (HZ == 128)
 	usecs *= 0x0008637bd05af6c7UL;		/* 2**64 / (1000000 / HZ) */
 #elif defined(CONFIG_MIPS64) && (HZ == 1000)
 	usecs *= 0x004189374BC6A7f0UL;		/* 2**64 / (1000000 / HZ) */
 #elif defined(CONFIG_MIPS64)
 	usecs *= (0x8000000000000000UL / (500000 / HZ));
 #else /* 32-bit junk follows here */
 	usecs *= (unsigned long) (((0x8000000000000000ULL / (500000 / HZ)) +
 	                           0x80000000ULL) >> 32);
 #endif
 
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
diff -U10 -urpN linux-2.6.12.org/include/asm-parisc/delay.h linux-2.6.12.delay/include/asm-parisc/delay.h
--- linux-2.6.12.org/include/asm-parisc/delay.h	Tue Oct 19 00:54:08 2004
+++ linux-2.6.12.delay/include/asm-parisc/delay.h	Thu Jun 30 20:28:18 2005
@@ -31,13 +31,11 @@ static __inline__ void __cr16_delay(unsi
 
 	start = mfctl(16);
 	while ((mfctl(16) - start) < clocks)
 	    ;
 }
 
 static __inline__ void __udelay(unsigned long usecs) {
 	__cr16_delay(usecs * ((unsigned long)boot_cpu_data.cpu_hz / 1000000UL));
 }
 
-#define udelay(n) __udelay(n)
-
 #endif /* defined(_PARISC_DELAY_H) */
diff -U10 -urpN linux-2.6.12.org/include/asm-ppc/delay.h linux-2.6.12.delay/include/asm-ppc/delay.h
--- linux-2.6.12.org/include/asm-ppc/delay.h	Tue Oct 19 00:54:39 2004
+++ linux-2.6.12.delay/include/asm-ppc/delay.h	Thu Jun 30 20:22:55 2005
@@ -43,24 +43,14 @@ extern __inline__ void __udelay(unsigned
 }
 
 extern __inline__ void __ndelay(unsigned int x)
 {
 	unsigned int loops;
 
 	__asm__("mulhwu %0,%1,%2" : "=r" (loops) :
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
diff -U10 -urpN linux-2.6.12.org/include/asm-ppc64/delay.h linux-2.6.12.delay/include/asm-ppc64/delay.h
--- linux-2.6.12.org/include/asm-ppc64/delay.h	Tue Oct 19 00:53:06 2004
+++ linux-2.6.12.delay/include/asm-ppc64/delay.h	Thu Jun 30 19:37:43 2005
@@ -31,18 +31,18 @@ static inline unsigned long __get_tb(voi
 static inline void __delay(unsigned long loops)
 {
 	unsigned long start = __get_tb();
 
 	while((__get_tb()-start) < loops)
 		__HMT_low();
 	__HMT_medium();
 	__barrier();
 }
 
-static inline void udelay(unsigned long usecs)
+static inline void __udelay(unsigned long usecs)
 {
 	unsigned long loops = tb_ticks_per_usec * usecs;
 
 	__delay(loops);
 }
 
 #endif /* _PPC64_DELAY_H */
diff -U10 -urpN linux-2.6.12.org/include/asm-s390/delay.h linux-2.6.12.delay/include/asm-s390/delay.h
--- linux-2.6.12.org/include/asm-s390/delay.h	Tue Oct 19 00:54:39 2004
+++ linux-2.6.12.delay/include/asm-s390/delay.h	Thu Jun 30 20:25:11 2005
@@ -10,13 +10,11 @@
  *
  *  Delay routines calling functions in arch/s390/lib/delay.c
  */
  
 #ifndef _S390_DELAY_H
 #define _S390_DELAY_H
 
 extern void __udelay(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) __udelay(n)
-
 #endif /* defined(_S390_DELAY_H) */
diff -U10 -urpN linux-2.6.12.org/include/asm-sh/delay.h linux-2.6.12.delay/include/asm-sh/delay.h
--- linux-2.6.12.org/include/asm-sh/delay.h	Tue Oct 19 00:55:24 2004
+++ linux-2.6.12.delay/include/asm-sh/delay.h	Thu Jun 30 20:37:05 2005
@@ -1,27 +1,15 @@
 #ifndef __ASM_SH_DELAY_H
 #define __ASM_SH_DELAY_H
 
 /*
  * Copyright (C) 1993 Linus Torvalds
  *
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
diff -U10 -urpN linux-2.6.12.org/include/asm-sh64/delay.h linux-2.6.12.delay/include/asm-sh64/delay.h
--- linux-2.6.12.org/include/asm-sh64/delay.h	Tue Oct 19 00:54:37 2004
+++ linux-2.6.12.delay/include/asm-sh64/delay.h	Thu Jun 30 20:25:04 2005
@@ -1,11 +1,10 @@
 #ifndef __ASM_SH64_DELAY_H
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
 
diff -U10 -urpN linux-2.6.12.org/include/asm-sparc/delay.h linux-2.6.12.delay/include/asm-sparc/delay.h
--- linux-2.6.12.org/include/asm-sparc/delay.h	Tue Oct 19 00:53:45 2004
+++ linux-2.6.12.delay/include/asm-sparc/delay.h	Thu Jun 30 19:57:52 2005
@@ -14,22 +14,22 @@ extern __inline__ void __delay(unsigned 
 {
 	__asm__ __volatile__("cmp %0, 0\n\t"
 			     "1: bne 1b\n\t"
 			     "subcc %0, 1, %0\n" :
 			     "=&r" (loops) :
 			     "0" (loops) :
 			     "cc");
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
diff -U10 -urpN linux-2.6.12.org/include/asm-sparc64/delay.h linux-2.6.12.delay/include/asm-sparc64/delay.h
--- linux-2.6.12.org/include/asm-sparc64/delay.h	Tue Oct 19 00:54:38 2004
+++ linux-2.6.12.delay/include/asm-sparc64/delay.h	Thu Jun 30 20:22:45 2005
@@ -10,29 +10,17 @@
 
 #ifndef __SPARC64_DELAY_H
 #define __SPARC64_DELAY_H
 
 #include <linux/config.h>
 #include <linux/param.h>
 #include <asm/cpudata.h>
 
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
 
 #endif /* defined(__SPARC64_DELAY_H) */
diff -U10 -urpN linux-2.6.12.org/include/asm-v850/delay.h linux-2.6.12.delay/include/asm-v850/delay.h
--- linux-2.6.12.org/include/asm-v850/delay.h	Tue Oct 19 00:55:24 2004
+++ linux-2.6.12.delay/include/asm-v850/delay.h	Thu Jun 30 19:24:39 2005
@@ -26,21 +26,21 @@ extern __inline__ void __delay(unsigned 
 /*
  * Use only for very small delays ( < 1 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
  * short delays.  This is a "reasonable" implementation, though (and the
  * first constant multiplications gets optimized away if the delay is
  * a constant)  
  */
 
 extern unsigned long loops_per_jiffy;
 
-extern __inline__ void udelay(unsigned long usecs)
+extern __inline__ void __udelay(unsigned long usecs)
 {
 	register unsigned long full_loops, part_loops;
 
 	full_loops = ((usecs * HZ) / 1000000) * loops_per_jiffy;
 	usecs %= (1000000 / HZ);
 	part_loops = (usecs * HZ * loops_per_jiffy) / 1000000;
 
 	__delay(full_loops + part_loops);
 }
 
diff -U10 -urpN linux-2.6.12.org/include/asm-x86_64/delay.h linux-2.6.12.delay/include/asm-x86_64/delay.h
--- linux-2.6.12.org/include/asm-x86_64/delay.h	Tue Oct 19 00:54:32 2004
+++ linux-2.6.12.delay/include/asm-x86_64/delay.h	Thu Jun 30 20:35:55 2005
@@ -1,27 +1,16 @@
 #ifndef _X8664_DELAY_H
 #define _X8664_DELAY_H
 
 /*
  * Copyright (C) 1993 Linus Torvalds
  *
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
diff -U10 -urpN linux-2.6.12.org/include/linux/delay.h linux-2.6.12.delay/include/linux/delay.h
--- linux-2.6.12.org/include/linux/delay.h	Thu Mar  3 09:31:14 2005
+++ linux-2.6.12.delay/include/linux/delay.h	Fri Jul  1 00:32:09 2005
@@ -5,46 +5,67 @@
  * Copyright (C) 1993 Linus Torvalds
  *
  * Delay routines, using a pre-computed "loops_per_jiffy" value.
  */
 
 extern unsigned long loops_per_jiffy;
 
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
 
-#ifndef ndelay
-#define ndelay(x)	udelay(((x)+999)/1000)
+#define udelay(n) ( \
+	(__builtin_constant_p(n) && (unsigned int)(n)>MAX_UDELAY_MS*1000) ? \
+	BUG_overlong_udelay() : _udelay(n))
+
+#ifndef __ndelay
+#define __ndelay(x)	__udelay(((x)+999)/1000)
 #endif
 
+#define ndelay(n) ( \
+	(__builtin_constant_p(n) && (unsigned int)(n)>MAX_UDELAY_MS*1000*1000) ? \
+	BUG_overlong_ndelay() : _ndelay(n))
+
 void calibrate_delay(void);
+void ssleep(unsigned int secs);
 void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
-
-static inline void ssleep(unsigned int seconds)
-{
-	msleep(seconds * 1000);
-}
 
 #endif /* defined(_LINUX_DELAY_H) */
diff -U10 -urpN linux-2.6.12.org/kernel/timer.c linux-2.6.12.delay/kernel/timer.c
--- linux-2.6.12.org/kernel/timer.c	Sun Jun 19 16:11:00 2005
+++ linux-2.6.12.delay/kernel/timer.c	Fri Jul  1 00:05:52 2005
@@ -26,20 +26,21 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/thread_info.h>
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/div64.h>
 #include <asm/timex.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_TIME_INTERPOLATION
 static void time_interpolator_update(long delta_nsec);
 #else
@@ -82,20 +83,70 @@ static inline void set_running_timer(tve
 					struct timer_list *timer)
 {
 #ifdef CONFIG_SMP
 	base->running_timer = timer;
 #endif
 }
 
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
+/***
+ * Arch __udelay() for intervals greater than a few milliseconds can
+ * risk overflow for high loops_per_jiffy (high bogomips) machines. The
+ * _mdelay() and _udelay() provide wrappers to prevent this.
+ *
+ * It's not inlined because we do not optimize delays for speed,
+ * but for code size at mdelay/udelay callsite
+ */
+void _mdelay(unsigned int msecs)
+{
+	if (msecs > MAX_MDELAY_MS) {
+		printk("BUG: delay too large: mdelay(%u)\n", msecs);
+		dump_stack();
+		msecs = MAX_MDELAY_MS;
+	}
+	while (msecs--)
+		__udelay(1000);
+}
+EXPORT_SYMBOL(_mdelay);
+
+void _udelay(unsigned int usecs)
+{
+	unsigned int k;
+	if (usecs > MAX_UDELAY_MS*1000) {
+		printk("BUG: delay too large: udelay(%u)\n", usecs);
+		dump_stack();
+		usecs = MAX_UDELAY_MS*1000;
+	}
+	k = usecs / 1024;
+	while (k--)
+		__udelay(1024);
+	__udelay(usecs % 1024);
+}
+EXPORT_SYMBOL(_udelay);
+
+void _ndelay(unsigned int nsecs)
+{
+	unsigned int k;
+	if (nsecs > MAX_UDELAY_MS*1000*1000) {
+		printk("BUG: delay too large: ndelay(%u)\n", nsecs);
+		dump_stack();
+		nsecs = MAX_UDELAY_MS*1000*1000;
+	}
+	k = nsecs / (64*1024);
+	while (k--)
+		__ndelay(64*1024);
+	__ndelay(nsecs % (64*1024));
+}
+EXPORT_SYMBOL(_ndelay);
+
 static void check_timer_failed(struct timer_list *timer)
 {
 	static int whine_count;
 	if (whine_count < 16) {
 		whine_count++;
 		printk("Uninitialised timer!\n");
 		printk("This is just a warning.  Your computer is OK\n");
 		printk("function=0x%p, data=0x%lx\n",
 			timer->function, timer->data);
 		dump_stack();
@@ -1583,22 +1634,27 @@ unregister_time_interpolator(struct time
  */
 void msleep(unsigned int msecs)
 {
 	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
 
 	while (timeout) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
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
  * @msecs: Time in milliseconds to sleep for
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
 	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
 
 	while (timeout && !signal_pending(current)) {

--Boundary-00=_L5QxCe/i+o/SeiV
Content-Type: application/x-bzip2;
  name="find.out.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="find.out.bz2"

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
EgNoLkAA

--Boundary-00=_L5QxCe/i+o/SeiV--

