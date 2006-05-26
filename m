Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWEZAJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWEZAJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWEZAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:09:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:28322 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030210AbWEZAJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:09:49 -0400
Subject: [-mm PATCH] time: fix time going backward w/ clock=pit
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tim Mann <mann@vmware.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060518011116.68055275.akpm@osdl.org>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
	 <20060518011116.68055275.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 25 May 2006 17:09:55 -0700
Message-Id: <1148602195.7813.18.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 01:11 -0700, Andrew Morton wrote:
> Tim Mann <mann@vmware.com> wrote:
> >
> >  Currently, if you boot with clock=pit on the kernel command line and
> >  run a program that loops calling gettimeofday, on many machines you'll
> >  observe that time frequently goes backward by about one jiffy.  This
> >  patch fixes that symptom and also some other related bugs.
> 
> And for 2.6.18 we're hoping to get John's x86 timer rework merged up. 
> John, do those patches address this bug?
> 
> So if we decide these two patches are not-for-2.6.17 then I'll sit on them
> until we decide whether or not to merge John's patches.  If we do, and if
> those patches fix this problem then your two patches aren't needed.  If
> John's patches don't get merged then I'll need to merge these two.

Hey Andrew,
	Sorry I've been so slow here, just starting to recover from a  one week
+ flu. :P  Here is the PIT fix against the TOD patches that Tim pointed
out. Many thanks to Tim for hunting this down.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

Index: devmm/arch/i386/kernel/i8253.c
===================================================================
--- devmm.orig/arch/i386/kernel/i8253.c	2006-05-25 18:12:41.000000000 -0500
+++ devmm/arch/i386/kernel/i8253.c	2006-05-25 18:52:31.000000000 -0500
@@ -41,9 +41,25 @@
 {
 	unsigned long flags;
 	int count;
-	u64 jifs;
+	u32 jifs;
+	static int old_count;
+	static u32 old_jifs;
 
 	spin_lock_irqsave(&i8253_lock, flags);
+        /*
+	 * Although our caller may have the read side of xtime_lock,
+	 * this is now a seqlock, and we are cheating in this routine
+	 * by having side effects on state that we cannot undo if
+	 * there is a collision on the seqlock and our caller has to
+	 * retry.  (Namely, old_jifs and old_count.)  So we must treat
+	 * jiffies as volatile despite the lock.  We read jiffies
+	 * before latching the timer count to guarantee that although
+	 * the jiffies value might be older than the count (that is,
+	 * the counter may underflow between the last point where
+	 * jiffies was incremented and the point where we latch the
+	 * count), it cannot be newer.
+	 */
+	jifs = jiffies;
 	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
 	count = inb_p(PIT_CH0);	/* read the latched count */
 	count |= inb_p(PIT_CH0) << 8;
@@ -55,12 +71,29 @@
 		outb(LATCH >> 8, PIT_CH0);
 		count = LATCH - 1;
 	}
-	spin_unlock_irqrestore(&i8253_lock, flags);
 
-	jifs = jiffies_64;
+	/*
+	 * It's possible for count to appear to go the wrong way for a
+	 * couple of reasons:
+	 *
+	 *  1. The timer counter underflows, but we haven't handled the
+	 *     resulting interrupt and incremented jiffies yet.
+	 *  2. Hardware problem with the timer, not giving us continuous time,
+	 *     the counter does small "jumps" upwards on some Pentium systems,
+	 *     (see c't 95/10 page 335 for Neptun bug.)
+	 *
+	 * Previous attempts to handle these cases intelligently were
+	 * buggy, so we just do the simple thing now.
+	 */
+	if (count > old_count && jifs == old_jifs) {
+		count = old_count;
+	}
+	old_count = count;
+	old_jifs = jifs;
+
+	spin_unlock_irqrestore(&i8253_lock, flags);
 
-	jifs -= INITIAL_JIFFIES;
-	count = (LATCH-1) - count;
+	count = (LATCH - 1) - count;
 
 	return (cycle_t)(jifs * LATCH) + count;
 }
@@ -69,7 +102,7 @@
 	.name	= "pit",
 	.rating = 110,
 	.read	= pit_read,
-	.mask	= CLOCKSOURCE_MASK(64),
+	.mask	= CLOCKSOURCE_MASK(32),
 	.mult	= 0,
 	.shift	= 20,
 };


