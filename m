Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTJHS7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 14:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTJHS7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:59:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:14318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261740AbTJHS7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:59:03 -0400
Date: Wed, 8 Oct 2003 11:58:19 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>,
       john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] monotonic seqlock for cyclone timer
Message-Id: <20031008115819.2404cd2a.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace read/write lock used for cyclone timer monotonic_lock with seqlock.
Similar to locking used on xtime and monotonic_lock in timers/timer_tsc.c

It builds and runs, but I don't have hardware with cyclone support to test.
Not a big deal (yet) since only hangcheck timer uses monotonic clock so far.

diff -urN -X dontdiff linux-2.5/arch/i386/kernel/timers/timer_cyclone.c linux-2.5-net/arch/i386/kernel/timers/timer_cyclone.c
--- linux-2.5/arch/i386/kernel/timers/timer_cyclone.c	2003-09-30 13:53:48.000000000 -0700
+++ linux-2.5-net/arch/i386/kernel/timers/timer_cyclone.c	2003-09-16 12:54:05.000000000 -0700
@@ -35,7 +35,7 @@
 static u32 last_cyclone_low;
 static u32 last_cyclone_high;
 static unsigned long long monotonic_base;
-static rwlock_t monotonic_lock = RW_LOCK_UNLOCKED;
+static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
 /* helper macro to atomically read both cyclone counter registers */
 #define read_cyclone_counter(low,high) \
@@ -51,7 +51,7 @@
 	int count;
 	unsigned long long this_offset, last_offset;
 
-	write_lock(&monotonic_lock);
+	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
 	
 	spin_lock(&i8253_lock);
@@ -76,7 +76,7 @@
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
 	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
-	write_unlock(&monotonic_lock);
+	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
@@ -117,12 +117,15 @@
 	u32 now_low, now_high;
 	unsigned long long last_offset, this_offset, base;
 	unsigned long long ret;
+	unsigned seq;
 
 	/* atomically read monotonic base & last_offset */
-	read_lock_irq(&monotonic_lock);
-	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
-	base = monotonic_base;
-	read_unlock_irq(&monotonic_lock);
+	do {
+		seq = read_seqbegin(&monotonic_lock);
+		last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+		base = monotonic_base;
+	} while (read_seqretry(&monotonic_lock, seq));
+
 
 	/* Read the cyclone counter */
 	read_cyclone_counter(now_low,now_high);
