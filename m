Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272275AbTHIFkE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 01:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272276AbTHIFkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 01:40:04 -0400
Received: from harlech.math.ucla.edu ([128.97.4.250]:14993 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S272275AbTHIFj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 01:39:59 -0400
Date: Fri, 8 Aug 2003 22:39:55 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>, michael@talamasca.ocis.net
Subject: [PATCH] time.c, 2.4.20, recovers lost ticks in i386
Message-ID: <Pine.LNX.4.53.0308082235230.5381@xena.cft.ca.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, when you read /proc/apm to get the battery status, certain BIOS
versions, particularly on various Dell Inspiron laptop models, drop you
in SMM mode, which causes clock interrupts to be lost.  (Credit for
insight: michael@talamasca.ocis.net "Michael Deutschmann" in
comp.protocols.time.ntp.)  On my system the dropout is about 15 msec and
when I run a monitor for temperature, wireless signal, battery, etc.
that updates once a second, it needs tick=10153, .  This is really bad.

The enclosed patch recovers the lost ticks on CPUs that have a TSC.  Any
lossage is detected, not just laptops in SMM.  I've been running it with
no problems (and tick=10001) for 3 weeks.  It is versus 2.4.20 from SuSE
8.2.  As far as I can see, there are no SuSE-specific hacks here, and
time.c changes rarely, so the patch should apply cleanly to other
versions.

Separately I'm posting a patch to apm.c that limits the frequency of
the battery status calls, reducing but not eliminating the lost ticks.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)


--- arch/i386/kernel/time.c.orig	2003-03-17 07:51:20.000000000 -0800
+++ arch/i386/kernel/time.c	2003-07-20 22:39:35.000000000 -0700
@@ -28,6 +28,8 @@
  * 1998-12-24 Copyright (C) 1998  Andrea Arcangeli
  *	Fixed a xtime SMP race (we need the xtime_lock rw spinlock to
  *	serialize accesses to xtime/lost_ticks).
+ * 2003-07-20    Jim Carter <jimc@math.ucla.edu>
+ *	timer_interrupt recovers lost ticks when flaky BIOS eats interrupts.
  */

 #include <linux/errno.h>
@@ -659,6 +661,9 @@
 static void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int count;
+	unsigned long since_prev = TICK_SIZE;	/* usecs since previous tick */
+	unsigned long two_ticks = 7*TICK_SIZE/4; /* Whether tick probably lost*/
+	register unsigned long eax;
 	static unsigned long last_whine = 0;

 	/*
@@ -687,6 +692,7 @@

 		/* read Pentium cycle counter */

+		since_prev = last_tsc_low;
 		rdtscl(last_tsc_low);

 		spin_lock(&i8253_lock);
@@ -714,6 +720,15 @@
 		}

 		spin_unlock(&i8253_lock);
+		/*
+		 * Converts TSC counts to microseconds since the last clock
+		 * interrupt.  Similar method as do_fast_gettimeoffset.
+		 */
+		since_prev = last_tsc_low - since_prev;
+		__asm__("mull %2"
+			:"=a" (eax), "=d" (since_prev)
+			:"rm" (fast_gettimeoffset_quotient),
+			 "0" (since_prev));

 		/* Some i8253 clones hold the LATCH value visible
 		   momentarily as they flip back to zero */
@@ -725,6 +740,20 @@
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 	}

+	/*
+	 * If the TSC says 2 (or more, but not seen in the wild) tick times
+	 * have elapsed, gives an extra jiffy.  This is seen on the Dell
+	 * Inspiron, various models, Phoenix BIOS, when APM BIOS checks the
+	 * battery -- someone attributed it to using the SMM bus.  Empirically,
+	 * delay_at_last_interrupt is seen up to 0.75*tick, so 1.75*tick is
+	 * the cutoff used to recognize a lost tick.  do_timer_interrupt is not
+	 * repeated since the lost time was in the BIOS and you don't want to
+	 * credit this in profiling.  -- <jimc@math.ucla.edu>
+	 */
+	while (since_prev >= two_ticks) {
+		since_prev -= TICK_SIZE;
+		(*(unsigned long *)&jiffies)++;
+	}
 	do_timer_interrupt(irq, NULL, regs);

 	fr_write_unlock(&xtime_lock);
