Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbTFCBxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 21:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264872AbTFCBxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 21:53:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54007 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264871AbTFCBxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 21:53:39 -0400
Subject: [RFC][PATCH] linux-2.5.70_monotonic-seqlock_A0
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054605866.32091.758.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jun 2003 19:04:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, All,
	As requested, here is a quick patch that converts the rwlock_t
monotonic_lock (which protects the monotonic_base value used in
monotonic_clock()) to a seqlock. 

Let me know if you have any comments. 

thanks
-john



diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Jun  2 19:01:13 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Jun  2 19:01:13 2003
@@ -36,7 +36,7 @@
 static u32 last_cyclone_low;
 static u32 last_cyclone_high;
 static unsigned long long monotonic_base;
-static rwlock_t monotonic_lock = RW_LOCK_UNLOCKED;
+static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
 /* helper macro to atomically read both cyclone counter registers */
 #define read_cyclone_counter(low,high) \
@@ -52,7 +52,7 @@
 	int count;
 	unsigned long long this_offset, last_offset;
 
-	write_lock(&monotonic_lock);
+	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
 	
 	spin_lock(&i8253_lock);
@@ -77,7 +77,7 @@
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
 	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
-	write_unlock(&monotonic_lock);
+	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
@@ -118,12 +118,16 @@
 	u32 now_low, now_high;
 	unsigned long long last_offset, this_offset, base;
 	unsigned long long ret;
+	unsigned long seq;
 
 	/* atomically read monotonic base & last_offset */
-	read_lock_irq(&monotonic_lock);
-	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
-	base = monotonic_base;
-	read_unlock_irq(&monotonic_lock);
+	do {
+		seq = read_seqbegin(&monotonic_lock);
+
+		last_offset = 
+			((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+		base = monotonic_base;
+	} while (read_seqretry(&monotonic_lock, seq));
 
 	/* Read the cyclone counter */
 	read_cyclone_counter(now_low,now_high);
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Jun  2 19:01:13 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Jun  2 19:01:13 2003
@@ -30,7 +30,7 @@
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
 static unsigned long long monotonic_base;
-static rwlock_t monotonic_lock = RW_LOCK_UNLOCKED;
+static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
 /* convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
@@ -102,12 +102,15 @@
 static unsigned long long monotonic_clock_tsc(void)
 {
 	unsigned long long last_offset, this_offset, base;
-	
+	unsigned long seq;
+
 	/* atomically read monotonic base & last_offset */
-	read_lock_irq(&monotonic_lock);
-	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	base = monotonic_base;
-	read_unlock_irq(&monotonic_lock);
+	do {
+		seq = read_seqbegin(&monotonic_lock);
+	
+		last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+		base = monotonic_base;
+	} while (read_seqretry(&monotonic_lock, seq));
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);
@@ -125,7 +128,7 @@
 	static int count1 = 0;
 	unsigned long long this_offset, last_offset;
 	
-	write_lock(&monotonic_lock);
+	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	/*
 	 * It is important that these two operations happen almost at
@@ -184,7 +187,7 @@
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_unlock(&monotonic_lock);
+	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;



