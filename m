Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTIPR1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbTIPR1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:27:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:3822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262513AbTIPR12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:27:28 -0400
Date: Tue, 16 Sep 2003 10:27:06 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use seq_lock for monotonic time
Message-Id: <20030916102706.26bc4516.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monotonic clock code uses reader/writer lock which is prone to same
starvation problems as we saw with xtime.  This patch changes it to seq_lock
which is faster and won't starve writers in face of lots of readers.

diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Sep 15 15:48:01 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Sep 15 15:48:01 2003
@@ -39,7 +39,7 @@
 static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
 static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
 static unsigned long long monotonic_base;
-static rwlock_t monotonic_lock = RW_LOCK_UNLOCKED;
+static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
 /* convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
@@ -111,12 +111,14 @@
 static unsigned long long monotonic_clock_tsc(void)
 {
 	unsigned long long last_offset, this_offset, base;
+	unsigned seq;
 	
 	/* atomically read monotonic base & last_offset */
-	read_lock_irq(&monotonic_lock);
-	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	base = monotonic_base;
-	read_unlock_irq(&monotonic_lock);
+	do {
+		seq = read_seqbegin(&monotonic_lock);
+		last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+		base = monotonic_base;
+	} while (read_seqretry(&monotonic_lock, seq));
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);
@@ -135,7 +137,7 @@
 	unsigned long long this_offset, last_offset;
 	static int lost_count = 0;
 	
-	write_lock(&monotonic_lock);
+	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	/*
 	 * It is important that these two operations happen almost at
@@ -204,7 +206,7 @@
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_unlock(&monotonic_lock);
+	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
@@ -236,7 +238,7 @@
 	unsigned long long this_offset, last_offset;
  	unsigned long offset, temp, hpet_current;
 
-	write_lock(&monotonic_lock);
+	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	/*
 	 * It is important that these two operations happen almost at
@@ -264,7 +266,7 @@
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_unlock(&monotonic_lock);
+	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
 	/*
