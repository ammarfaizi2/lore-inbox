Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUHNShi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUHNShi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUHNShh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:37:37 -0400
Received: from ozlabs.org ([203.10.76.45]:24992 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264530AbUHNShI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:37:08 -0400
Date: Sun, 15 Aug 2004 04:36:23 +1000
From: Anton Blanchard <anton@samba.org>
To: Arnd Bergmann <arnd@arndb.de>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, richm@oldelvet.org.uk, tytso@mit.edu
Subject: Re: Using get_cycles for add_timer_randomness
Message-ID: <20040814183623.GB5637@krispykreme>
References: <200308160303.17612.arnd@arndb.de> <20040810162435.GK24690@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810162435.GK24690@krispykreme>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This sounded like a good idea at the time, any reason we cant merge
> this?

Merged against latest bk. I tested how long it took to do a dd from
/dev/random on ppc64 before and after this patch, while doing a ping
flood from another machine.

before:
# /usr/bin/time dd if=/dev/random of=/dev/zero count=1k
0+51 records in
Command terminated by signal 2
0.00user 0.00system 19:18.46elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k

I gave up after 19 minutes.

after:
# /usr/bin/time dd if=/dev/random of=/dev/zero count=1k
0+1024 records in
0.00user 0.00system 0:33.38elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k

Just over 33 seconds. Better.

Anton

--

From: Arnd Bergmann <arnd@arndb.de>

I noticed that only i386 and x86-64 are currently using
a high resolution timer source when adding randomness.
Since many architectures have a working get_cycles()
implementation, it seems rather straightforward to use
that.

Has this been discussed before, or can anyone comment
on the implementation below?

This patch attempts to take into account the size of
cycles_t, which is either 32 or 64 bits wide but
independent of the architecture's word size.

The behavior should be nearly identical to the
old one on i386, x86-64 and all architectures
without a time stamp counter, while finding
more entropy on the other architectures.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== drivers/char/random.c 1.45 vs edited =====
--- 1.45/drivers/char/random.c	Sun Aug  8 16:43:40 2004
+++ edited/drivers/char/random.c	Sun Aug 15 03:13:21 2004
@@ -781,8 +781,8 @@
 
 /* There is one of these per entropy source */
 struct timer_rand_state {
-	__u32		last_time;
-	__s32		last_delta,last_delta2;
+	cycles_t	last_time;
+	long		last_delta,last_delta2;
 	int		dont_count_entropy:1;
 };
 
@@ -799,14 +799,12 @@
  * The number "num" is also added to the pool - it should somehow describe
  * the type of event which just happened.  This is currently 0-255 for
  * keyboard scan codes, and 256 upwards for interrupts.
- * On the i386, this is assumed to be at most 16 bits, and the high bits
- * are used for a high-resolution timer.
  *
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
-	__u32		time;
-	__s32		delta, delta2, delta3;
+	cycles_t	time;
+	long		delta, delta2, delta3;
 	int		entropy = 0;
 
 	/* if over the trickle threshold, use only 1 in 4096 samples */
@@ -814,17 +812,18 @@
 	     (__get_cpu_var(trickle_count)++ & 0xfff))
 		return;
 
-#if defined (__i386__) || defined (__x86_64__)
-	if (cpu_has_tsc) {
-		__u32 high;
-		rdtsc(time, high);
-		num ^= high;
+	/*
+	 * Use get_cycles() if implemented, otherwise fall back to
+	 * jiffies.
+	 */
+	time = get_cycles();
+	if (time != 0) {
+		if (sizeof(time) > 4) {
+			num ^= (u32)(time >> 32);
+		}
 	} else {
 		time = jiffies;
 	}
-#else
-	time = jiffies;
-#endif
 
 	/*
 	 * Calculate number of bits of randomness we probably added.
===== include/asm-i386/timex.h 1.7 vs edited =====
--- 1.7/include/asm-i386/timex.h	Fri Jun 18 16:43:58 2004
+++ edited/include/asm-i386/timex.h	Sun Aug 15 02:41:55 2004
@@ -7,7 +7,7 @@
 #define _ASMi386_TIMEX_H
 
 #include <linux/config.h>
-#include <asm/msr.h>
+#include <asm/processor.h>
 
 #ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
@@ -40,14 +40,17 @@
 
 static inline cycles_t get_cycles (void)
 {
+	unsigned long long ret=0;
+
 #ifndef CONFIG_X86_TSC
-	return 0;
-#else
-	unsigned long long ret;
+	if (!cpu_has_tsc)
+		return 0;
+#endif
 
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
 	rdtscll(ret);
-	return ret;
 #endif
+	return ret;
 }
 
 extern unsigned long cpu_khz;
