Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTIPVC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 17:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbTIPVC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 17:02:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:12942 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262502AbTIPVCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 17:02:22 -0400
Date: Tue, 16 Sep 2003 14:00:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use seq_lock for monotonic time
Message-Id: <20030916140001.7027d6e5.shemminger@osdl.org>
In-Reply-To: <20030916115935.64ebce3d.akpm@osdl.org>
References: <20030916102706.26bc4516.shemminger@osdl.org>
	<20030916115935.64ebce3d.akpm@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 11:59:35 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> So timer_cyclone and timer_hpet need the same change?

Yes.

diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Tue Sep 16 13:59:54 2003
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Tue Sep 16 13:59:54 2003
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
diff -Nru a/arch/i386/kernel/timers/timer_hpet.c b/arch/i386/kernel/timers/timer_hpet.c
--- a/arch/i386/kernel/timers/timer_hpet.c	Tue Sep 16 13:59:54 2003
+++ b/arch/i386/kernel/timers/timer_hpet.c	Tue Sep 16 13:59:54 2003
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
