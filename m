Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262732AbSI1FsF>; Sat, 28 Sep 2002 01:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262725AbSI1Frt>; Sat, 28 Sep 2002 01:47:49 -0400
Received: from waste.org ([209.173.204.2]:22929 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262727AbSI1FqL>;
	Sat, 28 Sep 2002 01:46:11 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] /dev/random cleanup: 02-untrusted
Message-Id: <E17vAVZ-0002Jg-00@ash>
From: Oliver Xymoron <oxymoron@waste.org>
Date: Sat, 28 Sep 2002 00:51:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes irq and blkdev interrupts untrusted and allows adding a bit
of entropy for a configurable percentage of untrusted samples,
controlled by a new sysctl. This defaults to 0 for safety, but can be
used on headless machines without a hardware RNG to continue to use
/dev/random with some confidence.

This also smartens up and simplifies the batch entropy pool to allow
unlimited amounts of untrusted mixing without blocking out trusted
samples.

diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2002-09-28 00:16:14.000000000 -0500
+++ work/drivers/char/random.c	2002-09-28 00:16:14.000000000 -0500
@@ -544,7 +544,7 @@
 }
 
 /*
- * This function adds a byte into the entropy "pool".  It does not
+ * This function adds a word into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
  * credit_entropy_store if this is appropriate.
  * 
@@ -618,25 +618,19 @@
  *
  **********************************************************************/
 
-static __u32	*batch_entropy_pool;
-static int	*batch_entropy_credit;
-static int	batch_max;
-static int	batch_head, batch_tail;
+static __u32 *batch_entropy_pool=0;
+static int batch_max, batch_pos, batch_credit, batch_samples;
 static struct tq_struct	batch_tqueue;
 static void batch_entropy_process(void *private_);
 
 /* note: the size must be a power of 2 */
 static int __init batch_entropy_init(int size, struct entropy_store *r)
 {
-	batch_entropy_pool = kmalloc(2*size*sizeof(__u32), GFP_KERNEL);
+	batch_entropy_pool = kmalloc(size*sizeof(__u32), GFP_KERNEL);
 	if (!batch_entropy_pool)
 		return -1;
-	batch_entropy_credit =kmalloc(size*sizeof(int), GFP_KERNEL);
-	if (!batch_entropy_credit) {
-		kfree(batch_entropy_pool);
-		return -1;
-	}
-	batch_head = batch_tail = 0;
+
+	batch_pos = batch_credit = batch_samples = 0;
 	batch_max = size;
 	batch_tqueue.routine = batch_entropy_process;
 	batch_tqueue.data = r;
@@ -644,56 +638,61 @@
 }
 
 /*
- * Changes to the entropy data is put into a queue rather than being added to
- * the entropy counts directly.  This is presumably to avoid doing heavy
- * hashing calculations during an interrupt in add_timer_randomness().
+ * Changes to the entropy data are put into a queue rather than being
+ * added to the entropy counts directly.  This is to avoid doing heavy
+ * hashing calculations during an interrupt in add_timing_entropy().
  * Instead, the entropy is only added to the pool once per timer tick.
+ *
+ * The batch pool intentionally allows wrap-around, to protect against
+ * flooding of untrusted data. Non-random data will not correlate with
+ * random data and can be safely XORed over existing data.
  */
-void batch_entropy_store(u32 a, u32 b, int num)
-{
-	int	new;
 
+void batch_entropy_store(u32 val, int bits)
+{
 	if (!batch_max)
 		return;
 	
-	batch_entropy_pool[2*batch_head] = a;
-	batch_entropy_pool[(2*batch_head) + 1] = b;
-	batch_entropy_credit[batch_head] = num;
-
-	new = (batch_head+1) & (batch_max-1);
-	if (new != batch_tail) {
-		queue_task(&batch_tqueue, &tq_timer);
-		batch_head = new;
-	} else {
-		DEBUG_ENT("batch entropy buffer full\n");
-	}
+	batch_entropy_pool[batch_pos] ^= val;
+	batch_credit+=bits;
+	batch_samples++;
+	batch_pos = (batch_pos+1) & (batch_max-1);
+
+	queue_task(&batch_tqueue, &tq_timer);
 }
 
 /*
- * Flush out the accumulated entropy operations, adding entropy to the passed
- * store (normally random_state).  If that store has enough entropy, alternate
- * between randomizing the data of the primary and secondary stores.
+ * Flush out the accumulated entropy operations, adding entropy to the
+ * passed store (normally random_state). Alternate between randomizing
+ * the data of the primary and secondary stores.
  */
 static void batch_entropy_process(void *private_)
 {
-	struct entropy_store *r	= (struct entropy_store *) private_, *p;
-	int max_entropy = r->poolinfo.POOLBITS;
-
+	struct entropy_store *r	= (struct entropy_store *) private_;
+	int samples, credit;
+	
 	if (!batch_max)
 		return;
 
-	p = r;
-	while (batch_head != batch_tail) {
-		if (r->entropy_count >= max_entropy) {
-			r = (r == sec_random_state) ?	random_state :
-							sec_random_state;
-			max_entropy = r->poolinfo.POOLBITS;
-		}
-		add_entropy_words(r, batch_entropy_pool + 2*batch_tail, 2);
-		credit_entropy_store(r, batch_entropy_credit[batch_tail]);
-		batch_tail = (batch_tail+1) & (batch_max-1);
+	/* switch pools if current full */
+	if (r->entropy_count >= r->poolinfo.POOLBITS) {
+		r = (r == sec_random_state) ? 
+			random_state : sec_random_state;
 	}
-	if (p->entropy_count >= random_read_wakeup_thresh)
+
+	credit=batch_credit;
+	samples=batch_samples;
+	batch_pos = batch_credit = batch_samples = 0;
+
+	/* Don't allow more credit BITS than pool WORDS */
+	if(credit > batch_max) credit=batch_max;
+	/* Check for pool wrap-around */
+	if(samples > batch_max) samples=batch_max;
+
+	add_entropy_words(r, batch_entropy_pool, samples);
+	credit_entropy_store(r, credit);
+
+	if (r->entropy_count >= random_read_wakeup_thresh)
 		wake_up_interruptible(&random_read_wait);
 }
 
@@ -707,14 +706,12 @@
 struct timer_rand_state {
 	__u32		last_time;
 	__s32		last_delta,last_delta2;
-	int		dont_count_entropy:1;
 };
 
 static struct timer_rand_state keyboard_timer_state;
 static struct timer_rand_state mouse_timer_state;
 static struct timer_rand_state extract_timer_state;
-static struct timer_rand_state *irq_timer_state[NR_IRQS];
-static struct timer_rand_state *blkdev_timer_state[MAX_BLKDEV];
+static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
 
 /*
  * This function adds entropy to the entropy "pool" by using timing
@@ -751,7 +748,7 @@
 	 * We take into account the first, second and third-order deltas
 	 * in order to make our estimate.
 	 */
-	if (!state->dont_count_entropy) {
+	if (state) {
 		delta = time - state->last_time;
 		state->last_time = time;
 
@@ -782,7 +779,18 @@
 
 		entropy = int_ln_12bits(delta);
 	}
-	batch_entropy_store(num, time, entropy);
+	else if(trust_pct)
+	{
+		/* Count an untrusted bit as entropy trust_pct% of the time */
+		trust_break+=trust_pct;
+		if(trust_break >= 100)
+		{
+			entropy=1;
+			trust_break-=100;
+		}
+	}
+
+	batch_entropy_store(num^time, entropy);
 }
 
 void add_keyboard_randomness(unsigned char scancode)
@@ -802,24 +810,12 @@
 
 void add_interrupt_randomness(int irq)
 {
-	if (irq >= NR_IRQS || irq_timer_state[irq] == 0)
-		return;
-
-	add_timer_randomness(irq_timer_state[irq], 0x100+irq);
+	add_timer_randomness(0, irq);
 }
 
 void add_blkdev_randomness(int major)
 {
-	if (major >= MAX_BLKDEV)
-		return;
-
-	if (blkdev_timer_state[major] == 0) {
-		rand_initialize_blkdev(major, GFP_ATOMIC);
-		if (blkdev_timer_state[major] == 0)
-			return;
-	}
-		
-	add_timer_randomness(blkdev_timer_state[major], 0x200+major);
+	add_timer_randomness(0, 0x200+major);
 }
 
 /******************************************************************
@@ -1270,8 +1266,6 @@
 	__u32 tmp[TMP_BUF_SIZE];
 	__u32 x;
 
-	add_timer_randomness(&extract_timer_state, nbytes);
-
 	/* Redundant, but just in case... */
 	if (r->entropy_count > r->poolinfo.POOLBITS)
 		r->entropy_count = r->poolinfo.POOLBITS;
@@ -1352,7 +1346,6 @@
 		nbytes -= i;
 		buf += i;
 		ret += i;
-		add_timer_randomness(&extract_timer_state, nbytes);
 	}
 
 	/* Wipe data just returned from memory */
@@ -1429,53 +1422,18 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	for (i = 0; i < NR_IRQS; i++)
-		irq_timer_state[i] = NULL;
-	for (i = 0; i < MAX_BLKDEV; i++)
-		blkdev_timer_state[i] = NULL;
 	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
 	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
-	extract_timer_state.dont_count_entropy = 1;
 }
 
 void rand_initialize_irq(int irq)
 {
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
 }
 
 void rand_initialize_blkdev(int major, int mode)
 {
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
 }
 
-
 static ssize_t
 random_read(struct file * file, char * buf, size_t nbytes, loff_t *ppos)
 {
@@ -1872,6 +1830,10 @@
 	{RANDOM_UUID, "uuid",
 	 NULL, 16, 0444, NULL,
 	 &proc_do_uuid, &uuid_strategy},
+	{RANDOM_TRUST_PCT, "trust_pct",
+	 &trust_pct, sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, 0,
+	 &trust_min, &trust_max},
 	{0}
 };
 
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/random.h work/include/linux/random.h
--- orig/include/linux/random.h	2002-07-20 14:11:18.000000000 -0500
+++ work/include/linux/random.h	2002-09-28 00:16:14.000000000 -0500
@@ -46,7 +46,7 @@
 extern void rand_initialize_irq(int irq);
 extern void rand_initialize_blkdev(int irq, int mode);
 
-extern void batch_entropy_store(u32 a, u32 b, int num);
+extern void batch_entropy_store(u32 val, int bits);
 
 extern void add_keyboard_randomness(unsigned char scancode);
 extern void add_mouse_randomness(__u32 mouse_data);
diff -urN -x '.patch*' -x '*.orig' orig/include/linux/sysctl.h work/include/linux/sysctl.h
--- orig/include/linux/sysctl.h	2002-09-20 11:03:37.000000000 -0500
+++ work/include/linux/sysctl.h	2002-09-28 00:16:14.000000000 -0500
@@ -185,7 +185,8 @@
 	RANDOM_READ_THRESH=3,
 	RANDOM_WRITE_THRESH=4,
 	RANDOM_BOOT_ID=5,
-	RANDOM_UUID=6
+	RANDOM_UUID=6,
+	RANDOM_TRUST_PCT=7
 };
 
 /* /proc/sys/bus/isa */
