Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319056AbSHWSb5>; Fri, 23 Aug 2002 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319068AbSHWSb5>; Fri, 23 Aug 2002 14:31:57 -0400
Received: from waste.org ([209.173.204.2]:1197 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319056AbSHWSbw>;
	Fri, 23 Aug 2002 14:31:52 -0400
Date: Fri, 23 Aug 2002 13:36:01 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (6/7) core accounting
Message-ID: <20020823183601.GF2224@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds improved entropy estimation (timer granularity, entropy
estimates for scale invariant distribution, guarding against
back-to-back interrupts and busy waiting) and a new API for
registering entropy sources.

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-08-23 12:43:29.000000000 -0500
+++ b/drivers/char/random.c	2002-08-23 12:43:31.000000000 -0500
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
@@ -682,40 +678,71 @@
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
-static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
+void *create_entropy_source(int granularity_khz)
+{
+	int factor;
+	struct entropy_source *es;
+
+	es = kmalloc(sizeof(struct entropy_source), GFP_KERNEL);
+
+	if(!es) return 0; /* untrusted */
+
+	/* figure out how many bits of clock resolution we
+	 * have to throw out given the source granularity */
+
+	factor=CLOCK_KHZ/granularity_khz;
+	
+	/* count bits in factor */
+	es->shift=0;
+	while(factor>>=1) es->shift++;
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
 
 /*
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
+ * estimation of entropy contained in a n-bit delta from an exponential
+ * distribution, derived from Benford's Law (rounded down)
+ */
+
+static int benford[16]={0,0,0,1,2,3,4,5,5,6,7,7,8,9,9,10};
+static int last_ctxt=0;
+static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
+
+void add_timer_randomness(void *src, unsigned datum)
+{
+	struct entropy_source *es=(struct entropy_source *)src;
+	unsigned long ctxt;
+	__u32 time, delta;
+	__s32 delta2, delta3;
+	int bits = 0;
 
 #if defined (__i386__) || defined (__x86_64__)
 	if (cpu_has_tsc) {
 		__u32 high;
 		rdtsc(time, high);
-		num ^= high;
+		datum ^= high;
 	} else {
 		time = jiffies;
 	}
@@ -723,41 +750,28 @@
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
-		 */
-		delta >>= 1;
-		delta &= (1 << 12) - 1;
-
-		entropy = int_log2_16bits(delta);
+	if(es) /* trusted */
+	{
+		/* Check for obvious periodicity in sources */
+		delta = time - es->time;
+		delta2 = delta - es->delta;
+		if (delta2 < 0)	delta2 = -delta2;
+		delta3 = delta2 - es->delta2;
+		if (delta3 < 0)	delta3 = -delta3;
+		es->time = time;
+		es->delta = delta;
+		es->delta2 = delta2;
+		if (delta2 < delta) delta=delta2;
+		if (delta3 < delta) delta=delta3;
+
+		/* Check for possible busy waiting or irq flooding */
+		ctxt=nr_context_switches();
+		if (ctxt == last_ctxt) delta=0;
+		last_ctxt=ctxt;
+
+		/* Calculate entropy distribution */
+		delta>>=es->shift;
+		bits=benford[int_log2_16bits(delta & 0xffff)];
 	}
 	else if(trust_pct)
 	{
@@ -765,27 +779,23 @@
 		trust_break+=trust_pct;
 		if(trust_break >= 100)
 		{
-			entropy=1;
+			bits=1;
 			trust_break-=100;
 		}
 	}
 
-	batch_entropy_store(num^time, entropy);
+	batch_entropy_store(datum^time, bits);
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
@@ -1389,8 +1399,6 @@
 
 void __init rand_initialize(void)
 {
-	int i;
-
 	if (create_entropy_store(DEFAULT_POOL_SIZE, &random_state))
 		return;		/* Error, return */
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
@@ -1403,8 +1411,8 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
+	generic_kbd = create_entropy_source(1);
+	generic_mouse = create_entropy_source(1);
 }
 
 static ssize_t
@@ -2203,6 +2211,9 @@
 
 
 
+EXPORT_SYMBOL(create_entropy_source);
+EXPORT_SYMBOL(free_entropy_source);
+EXPORT_SYMBOL(add_timer_randomness);
 EXPORT_SYMBOL(add_keyboard_randomness);
 EXPORT_SYMBOL(add_mouse_randomness);
 EXPORT_SYMBOL(add_interrupt_randomness);
diff -ur a/include/linux/random.h b/include/linux/random.h
--- a/include/linux/random.h	2002-08-23 12:43:29.000000000 -0500
+++ b/include/linux/random.h	2002-08-23 12:43:31.000000000 -0500
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
