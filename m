Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVHEDYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVHEDYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 23:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVHEDYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 23:24:39 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:41858 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262831AbVHEDYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 23:24:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH] dyn-tick3 tweaks respin
Date: Fri, 5 Aug 2005 13:20:39 +1000
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       tony@atomide.com, tuukka.tikkanen@elektrobit.com
References: <200508022225.31429.kernel@kolivas.org> <42F2B86D.8040701@yahoo.com.au> <200508051139.25024.kernel@kolivas.org>
In-Reply-To: <200508051139.25024.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ist8Cx8n6g5fY+7"
Message-Id: <200508051320.40034.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Ist8Cx8n6g5fY+7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 5 Aug 2005 11:39 am, Con Kolivas wrote:
> On Fri, 5 Aug 2005 10:53 am, Nick Piggin wrote:
> > All else being equal, it is much better if you unlock in the
> > same function that takes the lock. For readability.
> >
> > It looks like you should be able to leave all the flow control
> > and locking the same, and use update_monotonic_base() to
> > do the actual update?
>
> Good advice, thanks. Will respin.

Like this I assume you meant?

Cheers,
Con
---



--Boundary-00=_Ist8Cx8n6g5fY+7
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dtck3-tweaks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dtck3-tweaks.patch"

Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/timers/timer_tsc.c	2005-08-03 11:29:29.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c	2005-08-05 13:15:23.000000000 +1000
@@ -167,10 +167,19 @@ static void delay_tsc(unsigned long loop
 	} while ((now-bclock) < loops);
 }
 
+/* update the monotonic base value */
+static inline void update_monotonic_base(unsigned long long last_offset)
+{
+	unsigned long long this_offset;
+
+	this_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
+	monotonic_base += cycles_2_ns(this_offset - last_offset);
+}
+
 #ifdef CONFIG_HPET_TIMER
 static void mark_offset_tsc_hpet(void)
 {
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
  	unsigned long offset, temp, hpet_current;
 
 	write_seqlock(&monotonic_lock);
@@ -198,9 +207,7 @@ static void mark_offset_tsc_hpet(void)
 	}
 	hpet_last = hpet_current;
 
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
@@ -347,7 +354,7 @@ static void mark_offset_tsc(void)
 	int count;
 	int countmp;
 	static int count1 = 0;
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
 	static int lost_count = 0;
 
 	write_seqlock(&monotonic_lock);
@@ -368,8 +375,11 @@ static void mark_offset_tsc(void)
 
 	rdtsc(last_tsc_low, last_tsc_high);
 
-	if (dyn_tick_enabled())
-		goto monotonic_base;
+	if (dyn_tick_enabled()) {
+		update_monotonic_base(last_offset);
+		write_sequnlock(&monotonic_lock);
+		return;
+	}
 
 	spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
@@ -439,16 +449,9 @@ static void mark_offset_tsc(void)
 	} else
 		lost_count = 0;
 
- monotonic_base:
-
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
-	if (dyn_tick_enabled())
-		return;
-
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;

--Boundary-00=_Ist8Cx8n6g5fY+7--
