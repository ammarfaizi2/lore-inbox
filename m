Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSI1Fsv>; Sat, 28 Sep 2002 01:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbSI1Fsl>; Sat, 28 Sep 2002 01:48:41 -0400
Received: from waste.org ([209.173.204.2]:23441 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262730AbSI1FqR>;
	Sat, 28 Sep 2002 01:46:17 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] /dev/random cleanup: 03-entropy-estimation
Message-Id: <E17vAVb-0002Jm-00@ash>
From: Oliver Xymoron <oxymoron@waste.org>
Date: Sat, 28 Sep 2002 00:51:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds improved entropy estimation based on source timing
granularity and a new API for registering entropy sources.

This also detects potential polling or back-to-back interrupt attacks
that could be used to observe or force event timing. If a context
switch doesn't occur between events, one of these two attacks might be
occurring. We can rule out a polling attack by checking if the CPU is
sleeping and we can rule out an interrupt flood if jiffies has
changed since the last event. 

This removes the improperly named "ln" function and replaces it with a
call to the potentially arch-optimized fls. This also adjusts the
entropy count appropriately taking into consideration the expected
entropy in sections of a scale-invariant distribution (see "Benford's
Law"). Thanks to Arend Bayer for additional help with this analysis.

diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2002-09-28 00:16:14.000000000 -0500
+++ work/drivers/char/random.c	2002-09-28 00:16:14.000000000 -0500
@@ -1,7 +1,8 @@
 /*
  * random.c -- A strong random number generator
  *
- * Version 1.89, last modified 19-Sep-99
+ * Version 2.0, last modified 8-Aug-2002 
+ * by Oliver Xymoron <oxymoron@waste.org>
  * 
  * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
  * rights reserved.
@@ -116,8 +117,9 @@
  * The /dev/urandom device does not have this limit, and will return
  * as many bytes as are requested.  As more and more random bytes are
  * requested without giving time for the entropy pool to recharge,
- * this will result in random numbers that are merely cryptographically
- * strong.  For many applications, however, this is acceptable.
+ * this will result in random numbers that are merely
+ * cryptographically strong.  For almost all applications other than
+ * generation of large public/private key pairs, this is acceptable.
  *
  * Exported interfaces ---- input
  * ==============================
@@ -125,30 +127,24 @@
  * The current exported interfaces for gathering environmental noise
  * from the devices are:
  * 
- * 	void add_keyboard_randomness(unsigned char scancode);
- * 	void add_mouse_randomness(__u32 mouse_data);
- * 	void add_interrupt_randomness(int irq);
- * 	void add_blkdev_randomness(int irq);
- * 
- * add_keyboard_randomness() uses the inter-keypress timing, as well as the
- * scancode as random inputs into the "entropy pool".
- * 
- * add_mouse_randomness() uses the mouse interrupt timing, as well as
- * the reported position of the mouse from the hardware.
- *
- * add_interrupt_randomness() uses the inter-interrupt timing as random
- * inputs to the entropy pool.  Note that not all interrupts are good
- * sources of randomness!  For example, the timer interrupts is not a
- * good choice, because the periodicity of the interrupts is too
- * regular, and hence predictable to an attacker.  Disk interrupts are
- * a better measure, since the timing of the disk interrupts are more
- * unpredictable.
- * 
- * add_blkdev_randomness() times the finishing time of block requests.
- * 
- * All of these routines try to estimate how many bits of randomness a
- * particular randomness source.  They do this by keeping track of the
- * first and second order deltas of the event timings.
+ *	struct entropy_source *create_entropy_source(int granularity_khz);
+ *	void free_entropy_source(struct entropy_source *src);
+ *	void add_timer_randomness(struct entropy_source *src, unsigned num);
+ *
+ * create_entropy_source() returns a handle for future calls to
+ * add_timer_randomness. The granularity_khz parameter is used to
+ * describe the intrinsic timing granularity of the source, eg 33000
+ * for a fast PCI device or 9 for a 9600bps serial device. 
+ *
+ * Untrusted sources can simply call add_timer_randomness with a null
+ * handle. Note that network timings cannot be trusted, nor can disk
+ * timings if they're immediately fed to the network! We'll assume the
+ * user has a modern ssh implementation that doesn't leak local
+ * keyboard and mouse timings.
+ *
+ * add_timing_entropy() mixes timing information and the given num
+ * into the pool after making initial checks for randomness and
+ * estimating the number of usable entropy bits. 
  *
  * Ensuring unpredictability at system startup
  * ============================================
@@ -253,6 +249,8 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/tqueue.h>
+#include <linux/kernel_stat.h>
+#include <linux/bitops.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -429,43 +427,6 @@
 }
 #endif
 
-/*
- * More asm magic....
- * 
- * For entropy estimation, we need to do an integral base 2
- * logarithm.  
- *
- * Note the "12bits" suffix - this is used for numbers between
- * 0 and 4095 only.  This allows a few shortcuts.
- */
-#if 0	/* Slow but clear version */
-static inline __u32 int_ln_12bits(__u32 word)
-{
-	__u32 nbits = 0;
-	
-	while (word >>= 1)
-		nbits++;
-	return nbits;
-}
-#else	/* Faster (more clever) version, courtesy Colin Plumb */
-static inline __u32 int_ln_12bits(__u32 word)
-{
-	/* Smear msbit right to make an n-bit mask */
-	word |= word >> 8;
-	word |= word >> 4;
-	word |= word >> 2;
-	word |= word >> 1;
-	/* Remove one bit to make this a logarithm */
-	word >>= 1;
-	/* Count the bits set in the word */
-	word -= (word >> 1) & 0x555;
-	word = (word & 0x333) + ((word >> 2) & 0x333);
-	word += (word >> 4);
-	word += (word >> 8);
-	return word & 15;
-}
-#endif
-
 #if 0
 #define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
 #else
@@ -702,34 +663,53 @@
  *
  *********************************************************************/
 
-/* There is one of these per entropy source */
-struct timer_rand_state {
-	__u32		last_time;
-	__s32		last_delta,last_delta2;
+#if defined (__i386__) || defined (__x86_64__)
+#define CLOCK_KHZ cpu_khz
+#else
+#define CLOCK_KHZ HZ/1000
+#endif
+
+struct entropy_source
+{
+	int shift;
+	__u32 time, delta, delta2;
 };
 
-static struct timer_rand_state keyboard_timer_state;
-static struct timer_rand_state mouse_timer_state;
-static struct timer_rand_state extract_timer_state;
+struct entropy_source *create_entropy_source(int granularity_khz)
+{
+	struct entropy_source *es;
+
+	es = kmalloc(sizeof(struct entropy_source), GFP_KERNEL);
+
+	if(!es) return 0; /* untrusted */
+
+	/* figure out how many bits of clock resolution we
+	 * have to throw out given the source granularity */
+
+	es->shift=fls(CLOCK_KHZ/granularity_khz);
+	
+	DEBUG_ENT("new entropy source granularity %d kHZ, shift %d\n",
+		  granularity_khz, es->shift);
+
+	return es;
+}
+
+void free_entropy_source(struct entropy_source *src)
+{
+	kfree(src);
+}
+
+static struct entropy_source *generic_kbd, *generic_mouse;
+
+static unsigned long last_ctxt=0, last_jiffies=0;
 static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
 
-/*
- * This function adds entropy to the entropy "pool" by using timing
- * delays.  It uses the timer_rand_state structure to make an estimate
- * of how many bits of entropy this call has added to the pool.
- *
- * The number "num" is also added to the pool - it should somehow describe
- * the type of event which just happened.  This is currently 0-255 for
- * keyboard scan codes, and 256 upwards for interrupts.
- * On the i386, this is assumed to be at most 16 bits, and the high bits
- * are used for a high-resolution timer.
- *
- */
-static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
-{
-	__u32		time;
-	__s32		delta, delta2, delta3;
-	int		entropy = 0;
+void add_timer_randomness(struct entropy_source *es, unsigned num)
+{
+	unsigned long ctxt;
+	__u32 time, delta;
+	__s32 delta2, delta3;
+	int entropy = 0;
 
 #if defined (__i386__) || defined (__x86_64__)
 	if (cpu_has_tsc) {
@@ -743,41 +723,39 @@
 	time = jiffies;
 #endif
 
-	/*
-	 * Calculate number of bits of randomness we probably added.
-	 * We take into account the first, second and third-order deltas
-	 * in order to make our estimate.
-	 */
-	if (state) {
-		delta = time - state->last_time;
-		state->last_time = time;
-
-		delta2 = delta - state->last_delta;
-		state->last_delta = delta;
-
-		delta3 = delta2 - state->last_delta2;
-		state->last_delta2 = delta2;
-
-		if (delta < 0)
-			delta = -delta;
-		if (delta2 < 0)
-			delta2 = -delta2;
-		if (delta3 < 0)
-			delta3 = -delta3;
-		if (delta > delta2)
-			delta = delta2;
-		if (delta > delta3)
-			delta = delta3;
-
-		/*
-		 * delta is now minimum absolute delta.
-		 * Round down by 1 bit on general principles,
-		 * and limit entropy entimate to 12 bits.
+	if(es) /* trusted */
+	{
+		/* Check for obvious periodicity in sources */
+		delta = time - es->time;
+		delta2 = delta - es->delta;
+		if (delta2 < 0)	delta2 = -delta2;
+		delta3 = delta2 - es->delta2;
+		if (delta3 < 0)	delta3 = -delta3;
+
+		es->time = time;
+		es->delta = delta;
+		es->delta2 = delta2;
+
+		if (delta2 < delta) delta=delta2;
+		if (delta3 < delta) delta=delta3; 
+
+		/* Check for possible latency polling or irq flood attacks */
+		ctxt = nr_context_switches();
+		if (ctxt == last_ctxt &&  /* not switching */
+		    (!idle_cpu(smp_processor_id()) ||  /* possibly polling */
+		     jiffies == last_jiffies)) /* possible back to back irq */
+			delta=0;
+ 		last_ctxt=ctxt;
+		last_jiffies=jiffies;
+
+		/* Numerical integration of exponential (scale
+		 * invariant) distribution suggests that x-bit numbers
+		 * have no more than x-2 bits of entropy across their
+		 * range. Throw out 3 bits to be safe and cap at 12
+		 * bits.
 		 */
-		delta >>= 1;
-		delta &= (1 << 12) - 1;
-
-		entropy = int_ln_12bits(delta);
+ 
+		entropy = fls((delta>>(es->shift+3)) & 0xfff);
 	}
 	else if(trust_pct)
 	{
@@ -795,17 +773,13 @@
 
 void add_keyboard_randomness(unsigned char scancode)
 {
-	static unsigned char last_scancode;
-	/* ignore autorepeat (multiple key down w/o key up) */
-	if (scancode != last_scancode) {
-		last_scancode = scancode;
-		add_timer_randomness(&keyboard_timer_state, scancode);
-	}
+	/* autorepeat ignored based on coarse timing */
+	add_timer_randomness(generic_kbd, scancode);
 }
 
 void add_mouse_randomness(__u32 mouse_data)
 {
-	add_timer_randomness(&mouse_timer_state, mouse_data);
+	add_timer_randomness(generic_mouse, mouse_data);
 }
 
 void add_interrupt_randomness(int irq)
@@ -1408,8 +1382,6 @@
 
 void __init rand_initialize(void)
 {
-	int i;
-
 	if (create_entropy_store(DEFAULT_POOL_SIZE, &random_state))
 		return;		/* Error, return */
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
@@ -1422,8 +1394,8 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
+	generic_kbd = create_entropy_source(1);
+	generic_mouse = create_entropy_source(1);
 }
 
 void rand_initialize_irq(int irq)
@@ -2257,6 +2229,9 @@
 
 
 
+EXPORT_SYMBOL(create_entropy_source);
+EXPORT_SYMBOL(free_entropy_source);
+EXPORT_SYMBOL(add_timer_randomness);
 EXPORT_SYMBOL(add_keyboard_randomness);
 EXPORT_SYMBOL(add_mouse_randomness);
 EXPORT_SYMBOL(add_interrupt_randomness);
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/random.h work/include/linux/random.h
--- orig/include/linux/random.h	2002-09-28 00:16:14.000000000 -0500
+++ work/include/linux/random.h	2002-09-28 00:16:14.000000000 -0500
@@ -48,6 +48,10 @@
 
 extern void batch_entropy_store(u32 val, int bits);
 
+struct entropy_source;
+extern struct entropy_source *create_entropy_source(int granularity_khz);
+extern void free_entropy_source(struct entropy_source *src);
+extern void add_timer_randomness(struct entropy_source *src, unsigned num);
 extern void add_keyboard_randomness(unsigned char scancode);
 extern void add_mouse_randomness(__u32 mouse_data);
 extern void add_interrupt_randomness(int irq);
