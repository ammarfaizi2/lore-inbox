Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSIKFOX>; Wed, 11 Sep 2002 01:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318358AbSIKFOX>; Wed, 11 Sep 2002 01:14:23 -0400
Received: from waste.org ([209.173.204.2]:24468 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318357AbSIKFOG>;
	Wed, 11 Sep 2002 01:14:06 -0400
Date: Wed, 11 Sep 2002 00:18:51 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/11] Entropy fixes - core accounting
Message-ID: <20020911051851.GU31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
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

diff -urN clean/drivers/char/random.c patched/drivers/char/random.c
--- clean/drivers/char/random.c	2002-09-10 23:49:31.000000000 -0500
+++ patched/drivers/char/random.c	2002-09-10 23:50:10.000000000 -0500
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
+ *	void *create_entropy_source(int granularity_khz);
+ *	void free_entropy_source(void *src);
+ *	void add_timer_randomness(void *src, unsigned datum);
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
+ * add_timing_entropy() mixes timing information and the given datum
+ * into the pool after making initial checks for randomness and
+ * estimating the number of usable entropy bits. 
  *
  * Ensuring unpredictability at system startup
  * ============================================
@@ -667,40 +663,60 @@
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
+void *create_entropy_source(int granularity_khz)
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
+	return (void *)es;
+}
+
+void free_entropy_source(void *src)
+{
+	kfree(src);
+}
+
+static void *generic_kbd, *generic_mouse;
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
+void add_timer_randomness(void *src, unsigned datum)
+{
+	struct entropy_source *es=(struct entropy_source *)src;
+	unsigned long ctxt;
+	__u32 time, delta;
+	__s32 delta2, delta3;
+	int entropy = 0;
 
 #if defined (__i386__) || defined (__x86_64__)
 	if (cpu_has_tsc) {
 		__u32 high;
 		rdtsc(time, high);
-		num ^= high;
+		datum ^= high;
 	} else {
 		time = jiffies;
 	}
@@ -708,31 +724,30 @@
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
 
 		/* Numerical integration of exponential (scale
 		 * invariant) distribution suggests that x-bit numbers
@@ -741,7 +756,7 @@
 		 * bits.
 		 */
  
-		entropy = fls((delta>>3) & 0xfff);
+		entropy = fls((delta>>(es->shift+3)) & 0xfff);
 	}
 	else if(trust_pct)
 	{
@@ -754,22 +769,18 @@
 		}
 	}
 
-	batch_entropy_store(num^time, entropy);
+	batch_entropy_store(datum^time, entropy);
 }
 
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
@@ -1373,8 +1384,6 @@
 
 void __init rand_initialize(void)
 {
-	int i;
-
 	if (create_entropy_store(DEFAULT_POOL_SIZE, &random_state))
 		return;		/* Error, return */
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
@@ -1387,8 +1396,8 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
+	generic_kbd = create_entropy_source(1);
+	generic_mouse = create_entropy_source(1);
 }
 
 static ssize_t
@@ -2187,6 +2196,9 @@
 
 
 
+EXPORT_SYMBOL(create_entropy_source);
+EXPORT_SYMBOL(free_entropy_source);
+EXPORT_SYMBOL(add_timer_randomness);
 EXPORT_SYMBOL(add_keyboard_randomness);
 EXPORT_SYMBOL(add_mouse_randomness);
 EXPORT_SYMBOL(add_interrupt_randomness);
diff -urN clean/include/linux/random.h patched/include/linux/random.h
--- clean/include/linux/random.h	2002-09-10 23:49:31.000000000 -0500
+++ patched/include/linux/random.h	2002-09-10 23:49:32.000000000 -0500
@@ -46,6 +46,9 @@
 
 extern void batch_entropy_store(u32 val, int bits);
 
+extern void *create_entropy_source(int granularity_khz);
+extern void free_entropy_source(void *src);
+extern void add_timer_randomness(void *src, unsigned datum);
 extern void add_keyboard_randomness(unsigned char scancode);
 extern void add_mouse_randomness(__u32 mouse_data);
 extern void add_interrupt_randomness(int irq);


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
