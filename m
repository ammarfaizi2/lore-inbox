Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTDPHGh (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 03:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbTDPHGg 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 03:06:36 -0400
Received: from [212.50.18.217] ([212.50.18.217]:15368 "EHLO gw.zaxl.net")
	by vger.kernel.org with ESMTP id S262703AbTDPHGd 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 03:06:33 -0400
Date: Wed, 16 Apr 2003 10:18:18 +0300 (EEST)
From: Alexander Atanasov <alex@ssi.bg>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] get_offset_pit and do_timer_overflow vs IRQ locking
Message-ID: <Pine.LNX.4.21.0304160943330.7792-100000@mars.zaxl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

Spin lock debuging got this on UP+preempt:
arch/i386/kernel/i8259.c:176:spin_lock(arch/i386/kernel/i8259.c:c03d4838)
already locked by include/asm-i386/mach-default/do_timer.h/50
include/asm-i386/mach-default/do_timer.h:56:
spin_unlock(arch/i386/kernel/i8259.c:c03d4838) not locked
arch/i386/kernel/i8259.c:176:spin_lock(arch/i386/kernel/i8259.c:c03d4838)
already locked by include/asm-i386/mach-default/do_timer.h/50
include/asm-i386/mach-default/do_timer.h:56:
spin_unlock(arch/i386/kernel/i8259.c:c03d4838) not locked

This due to do_timer_overflow expecting to be called with IRQs disabled,
the whole path used to do that until converted to xtime_lock, but 
do_timer_overflow seems to be missed. Patch changes get_offset_pit to hold
i8253_lock while calling do_timer_overflow.

	Is the hack with caching jiffies in get_offset_pit still needed,
according to comments there, it is not?

-- 
have fun,
alex

BK current:

===== arch/i386/kernel/timers/timer_pit.c 1.10 vs edited =====
--- 1.10/arch/i386/kernel/timers/timer_pit.c	Mon Mar 31 19:03:54 2003
+++ edited/arch/i386/kernel/timers/timer_pit.c	Wed Apr 16 09:27:03 2003
@@ -50,7 +50,7 @@
 }
 
 
-/* This function must be called with interrupts disabled 
+/* This function must be called with xtime_lock held.
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
  * 
  * However, the pc-audio speaker driver changes the divisor so that
@@ -90,7 +90,7 @@
 	static unsigned long jiffies_p = 0;
 
 	/*
-	 * cache volatile jiffies temporarily; we have IRQs turned off. 
+	 * cache volatile jiffies temporarily; we have xtime_lock. 
 	 */
 	unsigned long jiffies_t;
 
@@ -109,14 +109,12 @@
 	count |= inb_p(0x40) << 8;
 	
         /* VIA686a test code... reset the latch if count > max + 1 */
-        if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
-                count = LATCH - 1;
-        }
-	
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	if (count > LATCH) {
+		outb_p(0x34, 0x43);
+		outb_p(LATCH & 0xff, 0x40);
+		outb(LATCH >> 8, 0x40);
+		count = LATCH - 1;
+	}
 
 	/*
 	 * avoiding timer inconsistencies (they are rare, but they happen)...
@@ -127,7 +125,6 @@
 	 *     (see c't 95/10 page 335 for Neptun bug.)
 	 */
 
-
 	if( jiffies_t == jiffies_p ) {
 		if( count > count_p ) {
 			/* the nutcase */
@@ -135,6 +132,8 @@
 		}
 	} else
 		jiffies_p = jiffies_t;
+
+	spin_unlock_irqrestore(&i8253_lock, flags);
 
 	count_p = count;
 
===== include/asm-i386/mach-default/do_timer.h 1.8 vs edited =====
--- 1.8/include/asm-i386/mach-default/do_timer.h	Tue Feb 25 11:39:08 2003
+++ edited/include/asm-i386/mach-default/do_timer.h	Tue Apr 15 23:47:39 2003
@@ -47,14 +47,12 @@
 {
 	int i;
 
-	spin_lock(&i8259A_lock);
 	/*
 	 * This is tricky when I/O APICs are used;
 	 * see do_timer_interrupt().
 	 */
 	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
-	
+
 	/* assumption about timer being IRQ0 */
 	if (i & 0x01) {
 		/*
===== include/asm-i386/mach-pc9800/do_timer.h 1.1 vs edited =====
--- 1.1/include/asm-i386/mach-pc9800/do_timer.h	Fri Mar 14 03:17:16 2003
+++ edited/include/asm-i386/mach-pc9800/do_timer.h	Tue Apr 15 23:47:39 2003
@@ -47,14 +47,12 @@
 {
 	int i;
 
-	spin_lock(&i8259A_lock);
 	/*
 	 * This is tricky when I/O APICs are used;
 	 * see do_timer_interrupt().
 	 */
 	i = inb(0x00);
-	spin_unlock(&i8259A_lock);
-	
+
 	/* assumption about timer being IRQ0 */
 	if (i & 0x01) {
 		/*
===== include/asm-i386/mach-visws/do_timer.h 1.6 vs edited =====
--- 1.6/include/asm-i386/mach-visws/do_timer.h	Wed Feb 19 04:58:56 2003
+++ edited/include/asm-i386/mach-visws/do_timer.h	Tue Apr 15 23:47:39 2003
@@ -26,14 +26,12 @@
 {
 	int i;
 
-	spin_lock(&i8259A_lock);
 	/*
 	 * This is tricky when I/O APICs are used;
 	 * see do_timer_interrupt().
 	 */
 	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
-	
+
 	/* assumption about timer being IRQ0 */
 	if (i & 0x01) {
 		/*

