Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWEQXEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWEQXEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWEQXEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:04:30 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:32015 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751139AbWEQXEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:04:30 -0400
Date: Wed, 17 May 2006 16:04:28 -0700
From: Tim Mann <mann@vmware.com>
To: linux-kernel@vger.kernel.org
Cc: mann@vmware.com, john stultz <johnstul@us.ibm.com>
Subject: Fix time going backward with clock=pit [1/2]
Message-ID: <20060517160428.62022efd@mann-lx.eng.vmware.com>
Organization: VMware, Inc.
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1 of a 2-patch series.  The diff is against the
2.6.17-rc3-git17 snapshot.

* * *

Currently, if you boot with clock=pit on the kernel command line and
run a program that loops calling gettimeofday, on many machines you'll
observe that time frequently goes backward by about one jiffy.  This
patch fixes that symptom and also some other related bugs.

Bugs and fixes:

1) get_offset_pit was assuming that jiffies could not change because
   the read side of xtime_lock is held by its caller, do_gettimeofday.
   But xtime_lock is a seqlock now, so jiffies can change; the seqlock
   only ensures that get_offset_pit will be retried if jiffies
   changes. This matters because get_offset_pit has side effects on
   internal state that are not undone in the retry case; in
   particular, it remembers the last values of jiffies and count.  If
   events occur in this order:

    * get_offset_pit latches the PIT count
    * the PIT counter overflows
    * the resulting interrupt is handled and jiffies is incremented
    * get_offset_pit reads jiffies

   ...then the resulting (jiffies, count) pair is about 1 jiffy ahead
   of real time.  Although do_gettimeofday's seqlock loop will discard
   this bogus value and call get_offset_pit again, that doesn't help,
   because get_offset_pit saved the bogus value in (jiffies_p,
   count_p).

   I fixed this by reading jiffies before latching the count, so we
   only have to deal with the case where jiffies is older than the
   count, never the case where it's newer.  (We always have to handle
   the case of jiffies being older, because events can happen in this
   order:)

     * the PIT counter overflows
     * get_offset_pit latches the count and reads jiffies (either order)
     * the PIT interrupt is handled and jiffies is incremented

2) do_timer_overflow was trying to detect the case where the counter
   has wrapped since jiffies was incremented by checking whether the
   timer interrupt is still pending in the PIC.  This is bogus for a
   couple of reasons: (a) There is a window between the point where
   the PIC interrupt is acknowledged and jiffies is incremented.  
   (b) Most systems use the IOAPIC for interrupt routing now.  The
   kernel has code that tries to also route the timer interrupt to the
   PIC and acknowledge it there, but this does not appear to work; in
   my testing on a couple of IOAPIC systems, do_timer_overflow always
   thought a timer interrupt was pending.  Also, this code has the
   same window as in (a).

   I fixed this by not calling do_timer_overflow, instead going with
   the simple solution of preventing count from going in the wrong
   direction within a jiffy.

 arch/i386/kernel/timers/timer_pit.c |   57 +++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 26 deletions(-)

Index: linux-2.6.17-rc3-git17/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.17-rc3-git17.orig/arch/i386/kernel/timers/timer_pit.c
+++ linux-2.6.17-rc3-git17/arch/i386/kernel/timers/timer_pit.c
@@ -93,24 +93,25 @@ static unsigned long get_offset_pit(void
 	int count;
 	unsigned long flags;
 	static unsigned long jiffies_p = 0;
-
-	/*
-	 * cache volatile jiffies temporarily; we have xtime_lock. 
-	 */
 	unsigned long jiffies_t;
 
 	spin_lock_irqsave(&i8253_lock, flags);
-	/* timer count may underflow right here */
-	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
-
-	count = inb_p(PIT_CH0);	/* read the latched count */
-
 	/*
-	 * We do this guaranteed double memory access instead of a _p 
-	 * postfix in the previous port access. Wheee, hackady hack
+	 * Although our caller has the read side of xtime_lock, this
+	 * is now a seqlock, and we are cheating in this routine by
+	 * having side effects on state that we cannot undo if
+	 * there is a collision on the seqlock and our caller has to
+	 * retry.  (Namely, jiffies_p and count_p.)  So we must treat
+	 * jiffies as volatile despite the lock.  We read jiffies
+	 * before latching the timer count to guarantee that although
+	 * the jiffies value might be older than the count (that is,
+	 * the counter may underflow between the last point where
+	 * jiffies was incremented and the point where we latch the
+	 * count), it cannot be newer.
 	 */
- 	jiffies_t = jiffies;
-
+	jiffies_t = jiffies;
+	outb_p(0x00, PIT_MODE);	/* latch the count */
+	count = inb_p(PIT_CH0);	/* read the latched count */
 	count |= inb_p(PIT_CH0) << 8;
 	
         /* VIA686a test code... reset the latch if count > max + 1 */
@@ -122,18 +123,22 @@ static unsigned long get_offset_pit(void
         }
 	
 	/*
-	 * avoiding timer inconsistencies (they are rare, but they happen)...
-	 * there are two kinds of problems that must be avoided here:
-	 *  1. the timer counter underflows
-	 *  2. hardware problem with the timer, not giving us continuous time,
-	 *     the counter does small "jumps" upwards on some Pentium systems,
-	 *     (see c't 95/10 page 335 for Neptun bug.)
+	 * There are two kinds of problems that may occur here:
+	 * 1. The timer counter underflowed between the point
+	 *     where jiffies was last incremented and the point
+	 *     where we latched the counter above.
+	 *  2. Hardware problem with the timer, not giving us
+	 *     continuous time. The counter does small "jumps" upwards
+	 *     on some Pentium systems (see c't 95/10 page 335 for
+	 *     Neptun bug).
+	 * Past attempts to distinguish these cases have been buggy, so we
+	 * do the simple thing: just don't allow time to go backward.
 	 */
 
 	if( jiffies_t == jiffies_p ) {
 		if( count > count_p ) {
 			/* the nutcase */
-			count = do_timer_overflow(count);
+			count = count_p;
 		}
 	} else
 		jiffies_p = jiffies_t;


-- 
Tim Mann  work: mann@vmware.com  home: tim@tim-mann.org
          http://www.vmware.com  http://tim-mann.org
