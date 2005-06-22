Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVFVD3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVFVD3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 23:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVFVD3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 23:29:24 -0400
Received: from [82.179.72.26] ([82.179.72.26]:45330 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262554AbVFVDYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 23:24:55 -0400
Message-ID: <42B8D9FF.1070000@aknet.ru>
Date: Wed, 22 Jun 2005 07:24:47 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch] spinlock cleanup
Content-Type: multipart/mixed;
 boundary="------------080106060404030503090708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106060404030503090708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Here is another attempt to
remove the "extern i8253_lock"
from the C files.
It now uses the same #ifdefs for
including the header and using
the lock, so it hopefully no
longer breaks the compilation.
Does it look good this time?

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------080106060404030503090708
Content-Type: text/x-patch;
 name="linux-2.6.12-rc6-spinlk2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12-rc6-spinlk2.diff"

diff -urN linux-2.6.12-rc6/arch/i386/kernel/apic.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/apic.c
--- linux-2.6.12-rc6/arch/i386/kernel/apic.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/apic.c	2005-06-15 11:26:02.000000000 +0400
@@ -34,6 +34,7 @@
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include <asm/hpet.h>
+#include <asm/8253pit.h>
 
 #include <mach_apic.h>
 
@@ -857,7 +858,6 @@
  */
 static unsigned int __init get_8254_timer_count(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 
 	unsigned int count;
diff -urN linux-2.6.12-rc6/arch/i386/kernel/apm.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/apm.c
--- linux-2.6.12-rc6/arch/i386/kernel/apm.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/apm.c	2005-06-15 11:26:02.000000000 +0400
@@ -228,10 +228,10 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/desc.h>
+#include <asm/8253pit.h>
 
 #include "io_ports.h"
 
-extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
 
@@ -1169,7 +1169,6 @@
 {
 #ifdef INIT_TIMER_AFTER_SUSPEND
 	unsigned long	flags;
-	extern spinlock_t i8253_lock;
 
 	spin_lock_irqsave(&i8253_lock, flags);
 	/* set the clock to 100 Hz */
diff -urN linux-2.6.12-rc6/arch/i386/kernel/io_apic.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/io_apic.c
--- linux-2.6.12-rc6/arch/i386/kernel/io_apic.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/io_apic.c	2005-06-15 11:26:02.000000000 +0400
@@ -37,6 +37,7 @@
 #include <asm/smp.h>
 #include <asm/desc.h>
 #include <asm/timer.h>
+#include <asm/i8259.h>
 
 #include <mach_apic.h>
 
@@ -1565,7 +1566,6 @@
 
 void /*__init*/ print_PIC(void)
 {
-	extern spinlock_t i8259A_lock;
 	unsigned int v;
 	unsigned long flags;
 
diff -urN linux-2.6.12-rc6/arch/i386/kernel/time.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/time.c
--- linux-2.6.12-rc6/arch/i386/kernel/time.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/time.c	2005-06-20 09:51:09.000000000 +0400
@@ -63,12 +63,12 @@
 #include <linux/config.h>
 
 #include <asm/hpet.h>
+#include <asm/i8259.h>
 
 #include <asm/arch_hooks.h>
 
 #include "io_ports.h"
 
-extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
 #include "do_timer.h"
diff -urN linux-2.6.12-rc6/arch/i386/kernel/timers/timer_cyclone.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_cyclone.c
--- linux-2.6.12-rc6/arch/i386/kernel/timers/timer_cyclone.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_cyclone.c	2005-06-15 11:26:02.000000000 +0400
@@ -17,10 +17,9 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/fixmap.h>
+#include <asm/8253pit.h>
 #include "io_ports.h"
 
-extern spinlock_t i8253_lock;
-
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
diff -urN linux-2.6.12-rc6/arch/i386/kernel/timers/timer_pit.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.12-rc6/arch/i386/kernel/timers/timer_pit.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_pit.c	2005-06-20 09:51:09.000000000 +0400
@@ -15,9 +15,9 @@
 #include <asm/smp.h>
 #include <asm/io.h>
 #include <asm/arch_hooks.h>
+#include <asm/8253pit.h>
+#include <asm/i8259.h>
 
-extern spinlock_t i8259A_lock;
-extern spinlock_t i8253_lock;
 #include "do_timer.h"
 #include "io_ports.h"
 
@@ -166,7 +166,6 @@
 
 void setup_pit_timer(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 
 	spin_lock_irqsave(&i8253_lock, flags);
diff -urN linux-2.6.12-rc6/arch/i386/kernel/timers/timer_tsc.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.12-rc6/arch/i386/kernel/timers/timer_tsc.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_tsc.c	2005-06-15 11:26:02.000000000 +0400
@@ -17,6 +17,7 @@
 
 #include <asm/timer.h>
 #include <asm/io.h>
+#include <asm/8253pit.h>
 /* processor.h for distable_tsc flag */
 #include <asm/processor.h>
 
@@ -35,8 +36,6 @@
 
 int tsc_disable __initdata = 0;
 
-extern spinlock_t i8253_lock;
-
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
diff -urN linux-2.6.12-rc6/arch/i386/mach-voyager/voyager_basic.c linux-2.6.12-rc6-spinlk/arch/i386/mach-voyager/voyager_basic.c
--- linux-2.6.12-rc6/arch/i386/mach-voyager/voyager_basic.c	2005-06-07 11:11:31.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/mach-voyager/voyager_basic.c	2005-06-15 11:26:02.000000000 +0400
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
+#include <asm/8253pit.h>
 
 /*
  * Power off function, if any
@@ -182,7 +183,6 @@
 		 * and swiftly introduce it to something sharp and
 		 * pointy.  */
 		__u16 val;
-		extern spinlock_t i8253_lock;
 
 		spin_lock(&i8253_lock);
 		
diff -urN linux-2.6.12-rc6/drivers/ide/legacy/hd.c linux-2.6.12-rc6-spinlk/drivers/ide/legacy/hd.c
--- linux-2.6.12-rc6/drivers/ide/legacy/hd.c	2005-06-07 11:11:51.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/drivers/ide/legacy/hd.c	2005-06-20 11:27:31.000000000 +0400
@@ -112,6 +112,10 @@
 #define STAT_OK		(READY_STAT|SEEK_STAT)
 #define OK_STATUS(s)	(((s)&(STAT_OK|(BUSY_STAT|WRERR_STAT|ERR_STAT)))==STAT_OK)
 
+#if (HD_DELAY > 0)
+#include <asm/8253pit.h>
+#endif
+
 static void recal_intr(void);
 static void bad_rw_intr(void);
 
@@ -160,7 +164,6 @@
 
 unsigned long read_timer(void)
 {
-        extern spinlock_t i8253_lock;
 	unsigned long t, flags;
 	int i;
 
diff -urN linux-2.6.12-rc6/drivers/input/gameport/gameport.c linux-2.6.12-rc6-spinlk/drivers/input/gameport/gameport.c
--- linux-2.6.12-rc6/drivers/input/gameport/gameport.c	2005-06-07 11:11:49.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/drivers/input/gameport/gameport.c	2005-06-20 09:51:09.000000000 +0400
@@ -22,6 +22,9 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#if defined(__i386__)
+#include <asm/8253pit.h>
+#endif
 
 /*#include <asm/io.h>*/
 
@@ -66,7 +69,6 @@
 
 static unsigned int get_time_pit(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 	unsigned int count;
 
diff -urN linux-2.6.12-rc6/drivers/input/joystick/analog.c linux-2.6.12-rc6-spinlk/drivers/input/joystick/analog.c
--- linux-2.6.12-rc6/drivers/input/joystick/analog.c	2005-06-07 11:11:49.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/drivers/input/joystick/analog.c	2005-06-20 09:51:09.000000000 +0400
@@ -39,6 +39,9 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <asm/timex.h>
+#ifdef __i386__
+#include <asm/8253pit.h>
+#endif
 
 #define DRIVER_DESC	"Analog joystick and gamepad driver"
 
@@ -145,7 +148,6 @@
 #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 static unsigned int get_time_pit(void)
 {
-        extern spinlock_t i8253_lock;
         unsigned long flags;
         unsigned int count;
 
diff -urN linux-2.6.12-rc6/include/asm-alpha/8253pit.h linux-2.6.12-rc6-spinlk/include/asm-alpha/8253pit.h
--- linux-2.6.12-rc6/include/asm-alpha/8253pit.h	2005-06-07 11:12:33.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/include/asm-alpha/8253pit.h	2005-06-15 11:26:02.000000000 +0400
@@ -5,6 +5,9 @@
 #ifndef _8253PIT_H
 #define _8253PIT_H
 
+#include <linux/spinlock.h>
+
 #define PIT_TICK_RATE 	1193180UL
+extern spinlock_t i8253_lock;
 
 #endif
diff -urN linux-2.6.12-rc6/include/asm-i386/8253pit.h linux-2.6.12-rc6-spinlk/include/asm-i386/8253pit.h
--- linux-2.6.12-rc6/include/asm-i386/8253pit.h	2005-06-07 11:12:32.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/include/asm-i386/8253pit.h	2005-06-15 11:26:02.000000000 +0400
@@ -5,8 +5,10 @@
 #ifndef _8253PIT_H
 #define _8253PIT_H
 
+#include <linux/spinlock.h>
 #include <asm/timex.h>
 
 #define PIT_TICK_RATE 	CLOCK_TICK_RATE
+extern spinlock_t i8253_lock;
 
 #endif
diff -urN linux-2.6.12-rc6/include/asm-mips/8253pit.h linux-2.6.12-rc6-spinlk/include/asm-mips/8253pit.h
--- linux-2.6.12-rc6/include/asm-mips/8253pit.h	2005-06-07 11:12:27.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/include/asm-mips/8253pit.h	2005-06-15 11:26:02.000000000 +0400
@@ -5,6 +5,9 @@
 #ifndef _8253PIT_H
 #define _8253PIT_H
 
+#include <linux/spinlock.h>
+
 #define PIT_TICK_RATE 	1193182UL
+extern spinlock_t i8253_lock;
 
 #endif
diff -urN linux-2.6.12-rc6/include/asm-ppc/8253pit.h linux-2.6.12-rc6-spinlk/include/asm-ppc/8253pit.h
--- linux-2.6.12-rc6/include/asm-ppc/8253pit.h	2005-06-07 11:12:27.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/include/asm-ppc/8253pit.h	2005-06-15 11:26:02.000000000 +0400
@@ -5,6 +5,9 @@
 #ifndef _8253PIT_H
 #define _8253PIT_H
 
+#include <linux/spinlock.h>
+
 #define PIT_TICK_RATE 	1193182UL
+extern spinlock_t i8253_lock;
 
 #endif
diff -urN linux-2.6.12-rc6/include/asm-ppc64/8253pit.h linux-2.6.12-rc6-spinlk/include/asm-ppc64/8253pit.h
--- linux-2.6.12-rc6/include/asm-ppc64/8253pit.h	2005-06-07 11:12:31.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/include/asm-ppc64/8253pit.h	2005-06-15 11:26:02.000000000 +0400
@@ -5,6 +5,9 @@
 #ifndef _8253PIT_H
 #define _8253PIT_H
 
+#include <linux/spinlock.h>
+
 #define PIT_TICK_RATE 	1193182UL
+extern spinlock_t i8253_lock;
 
 #endif
diff -urN linux-2.6.12-rc6/include/asm-x86_64/8253pit.h linux-2.6.12-rc6-spinlk/include/asm-x86_64/8253pit.h
--- linux-2.6.12-rc6/include/asm-x86_64/8253pit.h	2005-06-07 11:12:30.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/include/asm-x86_64/8253pit.h	2005-06-15 11:26:02.000000000 +0400
@@ -5,6 +5,9 @@
 #ifndef _8253PIT_H
 #define _8253PIT_H
 
+#include <linux/spinlock.h>
+
 #define PIT_TICK_RATE 	1193182UL
+extern spinlock_t i8253_lock;
 
 #endif

--------------080106060404030503090708--
