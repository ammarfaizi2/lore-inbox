Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318793AbSHRCTP>; Sat, 17 Aug 2002 22:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318795AbSHRCTP>; Sat, 17 Aug 2002 22:19:15 -0400
Received: from waste.org ([209.173.204.2]:28117 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318793AbSHRCTK>;
	Sat, 17 Aug 2002 22:19:10 -0400
Date: Sat, 17 Aug 2002 21:23:08 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (1/4) Entropy accounting fixes
Message-ID: <20020818022308.GB21643@waste.org>
References: <20020818021522.GA21643@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818021522.GA21643@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- change API to allow timing granularity, trusted vs untrusted sources
- smarter logarithm
- removal of static state arrays and source type methods
- use Benford's law to estimate entropy of sample
- use nr_context_switches to avoid polling and back-to-back interrupt attacks
- fix major bug in pool transfer accounting
- update comments

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-07-20 14:11:07.000000000 -0500
+++ b/drivers/char/random.c	2002-08-17 19:47:54.000000000 -0500
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
+ *	void add_timing_entropy(void *src, unsigned datum);
+ *
+ * create_entropy_source() returns a handle for future calls to
+ * add_timing_entropy. The granularity_khz parameter is used to
+ * describe the intrinsic timing granularity of the source, eg 33000
+ * for a fast PCI device or 9 for a 9600bps serial device. 
+ *
+ * Untrusted sources can simply call add_timing_entropy with a null
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
@@ -253,6 +249,8 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/tqueue.h>
+#include <linux/kernel_stat.h>
+#include <linux/bitops.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -430,41 +428,19 @@
 #endif
 
 /*
- * More asm magic....
- * 
  * For entropy estimation, we need to do an integral base 2
  * logarithm.  
- *
- * Note the "12bits" suffix - this is used for numbers between
- * 0 and 4095 only.  This allows a few shortcuts.
  */
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
+static inline __u32 int_log2_16bits(__u32 word)
 {
 	/* Smear msbit right to make an n-bit mask */
 	word |= word >> 8;
 	word |= word >> 4;
 	word |= word >> 2;
 	word |= word >> 1;
-	/* Remove one bit to make this a logarithm */
-	word >>= 1;
-	/* Count the bits set in the word */
-	word -= (word >> 1) & 0x555;
-	word = (word & 0x333) + ((word >> 2) & 0x333);
-	word += (word >> 4);
-	word += (word >> 8);
-	return word & 15;
+
+	return hweight16(word)-1;
 }
-#endif
 
 #if 0
 #define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
@@ -546,7 +522,7 @@
 }
 
 /*
- * This function adds a byte into the entropy "pool".  It does not
+ * This function adds a word into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
  * credit_entropy_store if this is appropriate.
  * 
@@ -646,11 +622,12 @@
 }
 
 /*
- * Changes to the entropy data is put into a queue rather than being added to
- * the entropy counts directly.  This is presumably to avoid doing heavy
- * hashing calculations during an interrupt in add_timer_randomness().
+ * Changes to the entropy data is put into a queue rather than being
+ * added to the entropy counts directly.  This is to avoid doing heavy
+ * hashing calculations during an interrupt in add_timing_entropy().
  * Instead, the entropy is only added to the pool once per timer tick.
  */
+
 void batch_entropy_store(u32 a, u32 b, int num)
 {
 	int	new;
@@ -705,42 +682,64 @@
  *
  *********************************************************************/
 
-/* There is one of these per entropy source */
-struct timer_rand_state {
-	__u32		last_time;
-	__s32		last_delta,last_delta2;
-	int		dont_count_entropy:1;
+#if defined (__i386__) || defined (__x86_64__)
+#define CLOCK_KHZ cpu_khz
+#else
+#define CLOCK_KHZ HZ/1000
+#endif
+
+struct entropy_source
+{
+	int shift;
+	__u32 time, delta;
 };
 
-static struct timer_rand_state keyboard_timer_state;
-static struct timer_rand_state mouse_timer_state;
-static struct timer_rand_state extract_timer_state;
-static struct timer_rand_state *irq_timer_state[NR_IRQS];
-static struct timer_rand_state *blkdev_timer_state[MAX_BLKDEV];
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
+	return (void *)es;
+}
+
+void free_entropy_source(void *src)
+{
+	kfree(src);
+}
 
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
+ * estimation of entropy contained in a n-bit delta from an exponential
+ * distribution, derived from Benford's Law (rounded down)
  */
-static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
+static int benford[16]={0,0,0,1,2,3,4,5,5,6,7,7,8,9,9,10};
+static int last_ctxt=0;
+
+void add_timing_entropy(void *src, unsigned datum)
 {
-	__u32		time;
-	__s32		delta, delta2, delta3;
-	int		entropy = 0;
+	struct entropy_source *es=(struct entropy_source *)src;
+	unsigned long ctxt;
+	__u32 time, delta;
+	__s32 delta2;
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
@@ -748,80 +747,26 @@
 	time = jiffies;
 #endif
 
-	/*
-	 * Calculate number of bits of randomness we probably added.
-	 * We take into account the first, second and third-order deltas
-	 * in order to make our estimate.
-	 */
-	if (!state->dont_count_entropy) {
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
-		entropy = int_ln_12bits(delta);
-	}
-	batch_entropy_store(num, time, entropy);
-}
-
-void add_keyboard_randomness(unsigned char scancode)
-{
-	static unsigned char last_scancode;
-	/* ignore autorepeat (multiple key down w/o key up) */
-	if (scancode != last_scancode) {
-		last_scancode = scancode;
-		add_timer_randomness(&keyboard_timer_state, scancode);
-	}
-}
-
-void add_mouse_randomness(__u32 mouse_data)
-{
-	add_timer_randomness(&mouse_timer_state, mouse_data);
-}
-
-void add_interrupt_randomness(int irq)
-{
-	if (irq >= NR_IRQS || irq_timer_state[irq] == 0)
-		return;
-
-	add_timer_randomness(irq_timer_state[irq], 0x100+irq);
-}
-
-void add_blkdev_randomness(int major)
-{
-	if (major >= MAX_BLKDEV)
-		return;
-
-	if (blkdev_timer_state[major] == 0) {
-		rand_initialize_blkdev(major, GFP_ATOMIC);
-		if (blkdev_timer_state[major] == 0)
-			return;
+	if(es) /* trusted */
+	{
+		/* Check for obvious periodicity in sources */
+		delta = time - es->time;
+		delta2 = delta - es->delta;
+		es->time = time;
+		es->delta = delta;
+		if (delta2 < 0)	delta2 = -delta2;
+		if (delta2 < delta) delta=delta2;
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
-		
-	add_timer_randomness(blkdev_timer_state[major], 0x200+major);
+	batch_entropy_store(datum, time, bits);
 }
 
 /******************************************************************
@@ -1239,18 +1184,18 @@
 
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
-		int nwords = min_t(int,
-				   r->poolinfo.poolwords - r->entropy_count/32,
-				   sizeof(tmp) / 4);
+		int bytes = min_t(int,
+				   nbytes - r->entropy_count/8,
+				   sizeof(tmp));
 
-		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
-			  nwords * 32,
+		DEBUG_ENT("xfer %d to %s (have %d, need %d)\n",
+			  bytes * 8,
 			  r == sec_random_state ? "secondary" : "unknown",
 			  r->entropy_count, nbytes * 8);
 
-		extract_entropy(random_state, tmp, nwords * 4, 0);
-		add_entropy_words(r, tmp, nwords);
-		credit_entropy_store(r, nwords * 32);
+		extract_entropy(random_state, tmp, bytes, 0);
+		add_entropy_words(r, tmp, (bytes+3)/4);
+		credit_entropy_store(r, bytes*8);
 	}
 	if (r->extract_count > 1024) {
 		DEBUG_ENT("reseeding %s with %d from primary\n",
@@ -1282,8 +1227,6 @@
 	__u32 tmp[TMP_BUF_SIZE];
 	__u32 x;
 
-	add_timer_randomness(&extract_timer_state, nbytes);
-
 	/* Redundant, but just in case... */
 	if (r->entropy_count > r->poolinfo.POOLBITS)
 		r->entropy_count = r->poolinfo.POOLBITS;
@@ -1366,7 +1309,6 @@
 		nbytes -= i;
 		buf += i;
 		ret += i;
-		add_timer_randomness(&extract_timer_state, nbytes);
 	}
 
 	/* Wipe data just returned from memory */
@@ -1429,8 +1371,6 @@
 
 void __init rand_initialize(void)
 {
-	int i;
-
 	if (create_entropy_store(DEFAULT_POOL_SIZE, &random_state))
 		return;		/* Error, return */
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
@@ -1443,53 +1383,8 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	for (i = 0; i < NR_IRQS; i++)
-		irq_timer_state[i] = NULL;
-	for (i = 0; i < MAX_BLKDEV; i++)
-		blkdev_timer_state[i] = NULL;
-	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
-	extract_timer_state.dont_count_entropy = 1;
 }
 
-void rand_initialize_irq(int irq)
-{
-	struct timer_rand_state *state;
-	
-	if (irq >= NR_IRQS || irq_timer_state[irq])
-		return;
-
-	/*
-	 * If kmalloc returns null, we just won't use that entropy
-	 * source.
-	 */
-	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
-	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
-		irq_timer_state[irq] = state;
-	}
-}
-
-void rand_initialize_blkdev(int major, int mode)
-{
-	struct timer_rand_state *state;
-	
-	if (major >= MAX_BLKDEV || blkdev_timer_state[major])
-		return;
-
-	/*
-	 * If kmalloc returns null, we just won't use that entropy
-	 * source.
-	 */
-	state = kmalloc(sizeof(struct timer_rand_state), mode);
-	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
-		blkdev_timer_state[major] = state;
-	}
-}
-
-
 static ssize_t
 random_read(struct file * file, char * buf, size_t nbytes, loff_t *ppos)
 {
@@ -1520,6 +1415,11 @@
 			schedule();
 			continue;
 		}
+
+		DEBUG_ENT("extracting %d bits, p: %d s: %d\n",
+			  n*8, random_state->entropy_count,
+			  sec_random_state->entropy_count);
+
 		n = extract_entropy(sec_random_state, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_SECONDARY);
@@ -2277,10 +2177,9 @@
 
 
 
-EXPORT_SYMBOL(add_keyboard_randomness);
-EXPORT_SYMBOL(add_mouse_randomness);
-EXPORT_SYMBOL(add_interrupt_randomness);
-EXPORT_SYMBOL(add_blkdev_randomness);
+EXPORT_SYMBOL(create_entropy_source);
+EXPORT_SYMBOL(free_entropy_source);
+EXPORT_SYMBOL(add_timing_entropy);
 EXPORT_SYMBOL(batch_entropy_store);
 EXPORT_SYMBOL(generate_random_uuid);
 
diff -ur a/include/linux/random.h b/include/linux/random.h
--- a/include/linux/random.h	2002-07-20 14:11:18.000000000 -0500
+++ b/include/linux/random.h	2002-08-17 19:34:37.000000000 -0500
@@ -43,15 +43,11 @@
 #ifdef __KERNEL__
 
 extern void rand_initialize(void);
-extern void rand_initialize_irq(int irq);
-extern void rand_initialize_blkdev(int irq, int mode);
 
 extern void batch_entropy_store(u32 a, u32 b, int num);
-
-extern void add_keyboard_randomness(unsigned char scancode);
-extern void add_mouse_randomness(__u32 mouse_data);
-extern void add_interrupt_randomness(int irq);
-extern void add_blkdev_randomness(int major);
+extern void *create_entropy_source(int granularity_khz);
+extern void free_entropy_source(void *src);
+extern void add_timing_entropy(void *src, unsigned datum);
 
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);



-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
