Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272518AbTHPBJV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 21:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272533AbTHPBJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 21:09:21 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:49612 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S272518AbTHPBJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 21:09:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: Using get_cycles for add_timer_randomness
Date: Sat, 16 Aug 2003 03:03:17 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308160303.17612.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

	Arnd <><

===== drivers/char/random.c 1.35 vs edited =====
--- 1.35/drivers/char/random.c	Wed Aug  6 19:59:31 2003
+++ edited/drivers/char/random.c	Sat Aug 16 02:05:34 2003
@@ -711,8 +711,8 @@
 
 /* There is one of these per entropy source */
 struct timer_rand_state {
-	__u32		last_time;
-	__s32		last_delta,last_delta2;
+	cycles_t	last_time;
+	long		last_delta,last_delta2;
 	int		dont_count_entropy:1;
 };
 
@@ -729,27 +729,28 @@
  * The number "num" is also added to the pool - it should somehow describe
  * the type of event which just happened.  This is currently 0-255 for
  * keyboard scan codes, and 256 upwards for interrupts.
- * On the i386, this is assumed to be at most 16 bits, and the high bits
- * are used for a high-resolution timer.
+ * This is assumed to be at most 16 bits, and the high bits are used for
+ * high-resolution timers.
  *
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
-	__u32		time;
-	__s32		delta, delta2, delta3;
+	cycles_t	time;
+	long		delta, delta2, delta3;
 	int		entropy = 0;
 
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
+		if (sizeof (time) > 4) {
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
===== include/asm-i386/timex.h 1.5 vs edited =====
--- 1.5/include/asm-i386/timex.h	Mon Jun  9 14:41:23 2003
+++ edited/include/asm-i386/timex.h	Sat Aug 16 02:17:05 2003
@@ -7,7 +7,7 @@
 #define _ASMi386_TIMEX_H
 
 #include <linux/config.h>
-#include <asm/msr.h>
+#include <asm/processor.h>
 
 #ifdef CONFIG_X86_PC9800
    extern int CLOCK_TICK_RATE;
@@ -44,14 +44,17 @@
 
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
