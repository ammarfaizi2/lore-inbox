Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTJHTAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTJHS77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:59:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:8832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261746AbTJHS74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:59:56 -0400
Date: Wed, 8 Oct 2003 11:58:20 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: john stultz <johnstul@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] monotonic seqlock for HPET timer
Message-Id: <20031008115820.435c97c1.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace read/write lock used for HPET timer monotonic_lock with seqlock.
Similar to locking used on xtime and monotonic_lock in timers/timer_tsc.c

It builds and runs, but I don't have hardware with HPET support to test.
Not a big deal (yet) since only hangcheck timer uses monotonic clock so far.

diff -urN -X dontdiff linux-2.5/arch/i386/kernel/timers/timer_hpet.c linux-2.5-net/arch/i386/kernel/timers/timer_hpet.c
--- linux-2.5/arch/i386/kernel/timers/timer_hpet.c	2003-09-30 13:53:48.000000000 -0700
+++ linux-2.5-net/arch/i386/kernel/timers/timer_hpet.c	2003-09-16 12:54:26.000000000 -0700
@@ -24,7 +24,7 @@
 static unsigned long last_tsc_low;	/* lsb 32 bits of Time Stamp Counter */
 static unsigned long last_tsc_high; 	/* msb 32 bits of Time Stamp Counter */
 static unsigned long long monotonic_base;
-static rwlock_t monotonic_lock = RW_LOCK_UNLOCKED;
+static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
 /* convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
@@ -57,12 +57,14 @@
 static unsigned long long monotonic_clock_hpet(void)
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
@@ -99,7 +101,7 @@
 	unsigned long long this_offset, last_offset;
 	unsigned long offset;
 
-	write_lock(&monotonic_lock);
+	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	rdtsc(last_tsc_low, last_tsc_high);
 
@@ -113,7 +115,7 @@
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_unlock(&monotonic_lock);
+	write_sequnlock(&monotonic_lock);
 }
 
 void delay_hpet(unsigned long loops)
