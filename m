Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUCZAEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbUCZADi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:03:38 -0500
Received: from waste.org ([209.173.204.2]:52889 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263826AbUCYX6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:05 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <19.524465763@selenic.com>
Message-Id: <20.524465763@selenic.com>
Subject: [PATCH 19/22] /dev/random: use sched_clock for timing data
Date: Thu, 25 Mar 2004 17:57:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  use sched_clock for timing data

Use the sched_clock() source for timing data, to get jiffies or better
resolution on all arches.


 tiny-mpm/drivers/char/random.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff -puN drivers/char/random.c~random-sched-clock drivers/char/random.c
--- tiny/drivers/char/random.c~random-sched-clock	2004-03-20 13:38:46.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:46.000000000 -0600
@@ -250,6 +250,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
+#include <linux/sched.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -711,7 +712,8 @@ static struct timer_rand_state *irq_time
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
-	__u32		time;
+	long long clock;
+	u32 time;
 	__s32		delta, delta2, delta3;
 	int		entropy = 0;
 
@@ -720,17 +722,8 @@ static void add_timer_randomness(struct 
 	     (__get_cpu_var(trickle_count)++ & 0xfff))
 		return;
 
-#if defined (__i386__) || defined (__x86_64__)
-	if (cpu_has_tsc) {
-		__u32 high;
-		rdtsc(time, high);
-		num ^= high;
-	} else {
-		time = jiffies;
-	}
-#else
+	/* Use slow clock for conservative entropy estimation */
 	time = jiffies;
-#endif
 
 	/*
 	 * Calculate number of bits of randomness we probably added.
@@ -765,7 +758,11 @@ static void add_timer_randomness(struct 
 		 */
 		entropy = min_t(int, fls(delta>>1), 11);
 	}
-	batch_entropy_store(num, time, entropy);
+
+	/* Mix in fast clock for entropy data */
+	clock = sched_clock();
+	num ^= clock >> 32;
+	batch_entropy_store(num, time ^ (u32)clock, entropy);
 }
 
 void add_keyboard_randomness(unsigned char scancode)

_
