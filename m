Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFNSnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFNSnF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVFNSnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:43:05 -0400
Received: from mail.aknet.ru ([82.179.72.26]:60428 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261294AbVFNSjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:39:16 -0400
Message-ID: <42AF2454.8090806@aknet.ru>
Date: Tue, 14 Jun 2005 22:39:16 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 1/2] pcspeaker driver update
Content-Type: multipart/mixed;
 boundary="------------070406030004000803020409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406030004000803020409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

The following patches is a small
update to the pcspeaker driver.

Attached one is just a clean-up:
it removes the extern definitions
for the i8253_lock and i8259A_lock,
making the use of the appropriate
headers instead.

Signed-off-by: stsp@aknet.ru


--------------070406030004000803020409
Content-Type: text/x-patch;
 name="linux-2.6.12-rc6-spinlk.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12-rc6-spinlk.diff"

diff -urN linux-2.6.12-rc6/arch/i386/kernel/apic.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/apic.c
--- linux-2.6.12-rc6/arch/i386/kernel/apic.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/apic.c	2005-06-14 12:57:50.000000000 +0400
@@ -34,6 +34,7 @@
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include <asm/hpet.h>
+#include <asm/timer.h>
 
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
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/apm.c	2005-06-14 12:57:50.000000000 +0400
@@ -228,10 +228,10 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/desc.h>
+#include <asm/timer.h>
 
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
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/io_apic.c	2005-06-14 12:57:50.000000000 +0400
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
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/time.c	2005-06-14 12:57:50.000000000 +0400
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
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_cyclone.c	2005-06-14 12:57:50.000000000 +0400
@@ -17,10 +17,9 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/fixmap.h>
+#include <asm/timer.h>
 #include "io_ports.h"
 
-extern spinlock_t i8253_lock;
-
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
diff -urN linux-2.6.12-rc6/arch/i386/kernel/timers/timer_pit.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.12-rc6/arch/i386/kernel/timers/timer_pit.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_pit.c	2005-06-14 12:57:50.000000000 +0400
@@ -15,9 +15,9 @@
 #include <asm/smp.h>
 #include <asm/io.h>
 #include <asm/arch_hooks.h>
+#include <asm/timer.h>
+#include <asm/i8259.h>
 
-extern spinlock_t i8259A_lock;
-extern spinlock_t i8253_lock;
 #include "do_timer.h"
 #include "io_ports.h"
 
@@ -166,7 +172,6 @@
 
 void setup_pit_timer(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 
 	spin_lock_irqsave(&i8253_lock, flags);
diff -urN linux-2.6.12-rc6/arch/i386/kernel/timers/timer_tsc.c linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.12-rc6/arch/i386/kernel/timers/timer_tsc.c	2005-06-07 11:11:34.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/arch/i386/kernel/timers/timer_tsc.c	2005-06-14 12:57:50.000000000 +0400
@@ -17,6 +17,7 @@
 
 #include <asm/timer.h>
 #include <asm/io.h>
+#include <asm/timer.h>
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
+++ linux-2.6.12-rc6-spinlk/arch/i386/mach-voyager/voyager_basic.c	2005-06-14 12:57:49.000000000 +0400
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
+#include <asm/timer.h>
 
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
+++ linux-2.6.12-rc6-spinlk/drivers/ide/legacy/hd.c	2005-06-14 12:58:00.000000000 +0400
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>
+#include <asm/timer.h>
 
 #define REALLY_SLOW_IO
 #include <asm/system.h>
@@ -160,7 +161,6 @@
 
 unsigned long read_timer(void)
 {
-        extern spinlock_t i8253_lock;
 	unsigned long t, flags;
 	int i;
 
diff -urN linux-2.6.12-rc6/drivers/input/gameport/gameport.c linux-2.6.12-rc6-spinlk/drivers/input/gameport/gameport.c
--- linux-2.6.12-rc6/drivers/input/gameport/gameport.c	2005-06-07 11:11:49.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/drivers/input/gameport/gameport.c	2005-06-14 12:57:59.000000000 +0400
@@ -22,6 +22,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <asm/timer.h>
 
 /*#include <asm/io.h>*/
 
@@ -66,7 +67,6 @@
 
 static unsigned int get_time_pit(void)
 {
-	extern spinlock_t i8253_lock;
 	unsigned long flags;
 	unsigned int count;
 
diff -urN linux-2.6.12-rc6/drivers/input/joystick/analog.c linux-2.6.12-rc6-spinlk/drivers/input/joystick/analog.c
--- linux-2.6.12-rc6/drivers/input/joystick/analog.c	2005-06-07 11:11:49.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/drivers/input/joystick/analog.c	2005-06-14 12:57:59.000000000 +0400
@@ -39,6 +39,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <asm/timex.h>
+#include <asm/timer.h>
 
 #define DRIVER_DESC	"Analog joystick and gamepad driver"
 
@@ -145,7 +146,6 @@
 #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 static unsigned int get_time_pit(void)
 {
-        extern spinlock_t i8253_lock;
         unsigned long flags;
         unsigned int count;
 
diff -urN linux-2.6.12-rc6/include/asm-i386/timer.h linux-2.6.12-rc6-spinlk/include/asm-i386/timer.h
--- linux-2.6.12-rc6/include/asm-i386/timer.h	2005-06-07 11:12:31.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/include/asm-i386/timer.h	2005-06-14 12:58:44.000000000 +0400
@@ -1,6 +1,7 @@
 #ifndef _ASMi386_TIMER_H
 #define _ASMi386_TIMER_H
 #include <linux/init.h>
+#include <linux/spinlock.h>
 
 /**
  * struct timer_ops - used to define a timer source
@@ -41,6 +42,7 @@
 
 extern struct timer_opts *cur_timer;
 extern int timer_ack;
+extern spinlock_t i8253_lock;
 
 /* list of externed timers */
 extern struct timer_opts timer_none;

--------------070406030004000803020409--
