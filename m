Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVHEA15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVHEA15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVHEA15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:27:57 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:32154 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262723AbVHEA1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:27:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] dyn-tick3 tweaks
Date: Fri, 5 Aug 2005 10:23:38 +1000
User-Agent: KMail/1.8.1
Cc: kernel list <linux-kernel@vger.kernel.org>, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508022225.31429.kernel@kolivas.org> <200508051002.17344.kernel@kolivas.org> <200508051005.27162.kernel@kolivas.org>
In-Reply-To: <200508051005.27162.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KGr8Ce18ghDAHqB"
Message-Id: <200508051023.38234.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_KGr8Ce18ghDAHqB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 5 Aug 2005 10:05 am, Con Kolivas wrote:
> Looking yet further into this, if it gotos monotonic_base it will return
> without using any of these variables so it's a harmless warning but we may
> as well initialise them to quieten it.

Something like this on top is cleaner and quieter. I'll add this to pending 
changes for another version.

Cheers,
Con
---



--Boundary-00=_KGr8Ce18ghDAHqB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dtck3-tweaks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dtck3-tweaks.patch"

Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/timers/timer_tsc.c	2005-08-03 11:29:29.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c	2005-08-05 10:22:25.000000000 +1000
@@ -167,10 +167,20 @@ static void delay_tsc(unsigned long loop
 	} while ((now-bclock) < loops);
 }
 
+/* update the monotonic base value */
+static inline void update_monotonic_base(unsigned long long last_offset)
+{
+	unsigned long long this_offset;
+
+	this_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
+	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	write_sequnlock(&monotonic_lock);
+}
+
 #ifdef CONFIG_HPET_TIMER
 static void mark_offset_tsc_hpet(void)
 {
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
  	unsigned long offset, temp, hpet_current;
 
 	write_seqlock(&monotonic_lock);
@@ -198,10 +208,7 @@ static void mark_offset_tsc_hpet(void)
 	}
 	hpet_last = hpet_current;
 
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_sequnlock(&monotonic_lock);
+	update_monotonic_base(last_offset);
 
 	/* calculate delay_at_last_interrupt */
 	/*
@@ -347,7 +354,7 @@ static void mark_offset_tsc(void)
 	int count;
 	int countmp;
 	static int count1 = 0;
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
 	static int lost_count = 0;
 
 	write_seqlock(&monotonic_lock);
@@ -368,8 +375,10 @@ static void mark_offset_tsc(void)
 
 	rdtsc(last_tsc_low, last_tsc_high);
 
-	if (dyn_tick_enabled())
-		goto monotonic_base;
+	if (dyn_tick_enabled()) {
+		update_monotonic_base(last_offset);
+		return;
+	}
 
 	spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
@@ -439,15 +448,7 @@ static void mark_offset_tsc(void)
 	} else
 		lost_count = 0;
 
- monotonic_base:
-
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_sequnlock(&monotonic_lock);
-
-	if (dyn_tick_enabled())
-		return;
+	update_monotonic_base(last_offset);
 
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;

--Boundary-00=_KGr8Ce18ghDAHqB--
