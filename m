Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTEODSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTEODSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:15 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:64747 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263760AbTEODSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:14 -0400
Date: Thu, 15 May 2003 04:31:00 +0100
Message-Id: <200305150331.h4F3V00h000522@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: i8253 locking.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are still a few places where we play with the RTC
directly, with no locking. This catches some of them.

--- bk-linus/arch/i386/kernel/apm.c	2003-05-11 22:59:28.000000000 +0100
+++ linux-2.5/arch/i386/kernel/apm.c	2003-05-15 03:10:19.000000000 +0100
@@ -1166,9 +1166,13 @@ static void get_time_diff(void)
 #endif
 }
 
-static inline void reinit_timer(void)
+static void reinit_timer(void)
 {
 #ifdef INIT_TIMER_AFTER_SUSPEND
+	unsigned long	flags;
+	extern spinlock_t i8253_lock;
+
+	spin_lock_irqsave(&i8253_lock, flags);
 	/* set the clock to 100 Hz */
 	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
@@ -1176,6 +1180,7 @@ static inline void reinit_timer(void)
 	udelay(10);
 	outb(LATCH >> 8, PIT_CH0);	/* MSB */
 	udelay(10);
+	spin_unlock_irqrestore(&i8253_lock, flags);
 #endif
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/i8259.c linux-2.5/arch/i386/kernel/i8259.c
--- bk-linus/arch/i386/kernel/i8259.c	2003-04-22 00:40:42.000000000 +0100
+++ linux-2.5/arch/i386/kernel/i8259.c	2003-04-22 01:23:12.000000000 +0100
@@ -373,11 +373,16 @@ void __init init_ISA_irqs (void)
 
 static void setup_timer(void)
 {
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
 	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
 	udelay(10);
 	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
 static int timer_resume(struct device *dev, u32 level)
