Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVASIUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVASIUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVASIUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:20:17 -0500
Received: from waste.org ([216.27.176.166]:27820 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261666AbVASIRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:17:01 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <12.64403262@selenic.com>
Message-Id: <13.64403262@selenic.com>
Subject: [PATCH 12/12] random pt3: Remove entropy batching
Date: Wed, 19 Jan 2005 00:17:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than batching up entropy samples, resulting in longer lock hold
times when we actually process the samples, mix in samples
immediately. The trickle code should eliminate almost all the
additional interrupt-time overhead this would otherwise incur, with or
without locking.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:45:13.176966505 -0800
+++ rnd/drivers/char/random.c	2005-01-18 11:01:30.616353586 -0800
@@ -238,7 +238,6 @@
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/workqueue.h>
 #include <linux/genhd.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
@@ -254,7 +253,6 @@
  */
 #define INPUT_POOL_WORDS 128
 #define OUTPUT_POOL_WORDS 32
-#define BATCH_ENTROPY_SIZE 256
 #define SEC_XFER_SIZE 512
 
 /*
@@ -552,118 +550,6 @@
 	spin_unlock_irqrestore(&r->lock, flags);
 }
 
-/**********************************************************************
- *
- * Entropy batch input management
- *
- * We batch entropy to be added to avoid increasing interrupt latency
- *
- **********************************************************************/
-
-struct sample {
-	__u32 data[2];
-	int credit;
-};
-
-static struct sample *batch_entropy_pool, *batch_entropy_copy;
-static int batch_head, batch_tail;
-static spinlock_t batch_lock = SPIN_LOCK_UNLOCKED;
-
-static int batch_max;
-static void batch_entropy_process(void *private_);
-static DECLARE_WORK(batch_work, batch_entropy_process, NULL);
-
-/* note: the size must be a power of 2 */
-static int __init batch_entropy_init(int size, struct entropy_store *r)
-{
-	batch_entropy_pool = kmalloc(size*sizeof(struct sample), GFP_KERNEL);
-	if (!batch_entropy_pool)
-		return -1;
-	batch_entropy_copy = kmalloc(size*sizeof(struct sample), GFP_KERNEL);
-	if (!batch_entropy_copy) {
-		kfree(batch_entropy_pool);
-		return -1;
-	}
-	batch_head = batch_tail = 0;
-	batch_work.data = r;
-	batch_max = size;
-	return 0;
-}
-
-/*
- * Changes to the entropy data is put into a queue rather than being added to
- * the entropy counts directly.  This is presumably to avoid doing heavy
- * hashing calculations during an interrupt in add_timer_randomness().
- * Instead, the entropy is only added to the pool by keventd.
- */
-static void batch_entropy_store(u32 a, u32 b, int num)
-{
-	int new;
-	unsigned long flags;
-
-	if (!batch_max)
-		return;
-
-	spin_lock_irqsave(&batch_lock, flags);
-
-	batch_entropy_pool[batch_head].data[0] = a;
-	batch_entropy_pool[batch_head].data[1] = b;
-	batch_entropy_pool[batch_head].credit = num;
-
-	if (((batch_head - batch_tail) & (batch_max - 1)) >= (batch_max / 2))
-		schedule_delayed_work(&batch_work, 1);
-
-	new = (batch_head + 1) & (batch_max - 1);
-	if (new == batch_tail)
-		DEBUG_ENT("batch entropy buffer full\n");
-	else
-		batch_head = new;
-
-	spin_unlock_irqrestore(&batch_lock, flags);
-}
-
-/*
- * Flush out the accumulated entropy operations, adding entropy to the
- * input pool.  If that pool has enough entropy, alternate
- * between randomizing the data of all pools.
- */
-static void batch_entropy_process(void *private_)
-{
-	struct entropy_store *r	= (struct entropy_store *) private_, *p;
-	int max_entropy = r->poolinfo->POOLBITS;
-	unsigned head, tail;
-
-	/* Mixing into the pool is expensive, so copy over the batch
-	 * data and release the batch lock. The pool is at least half
-	 * full, so don't worry too much about copying only the used
-	 * part.
-	 */
-	spin_lock_irq(&batch_lock);
-
-	memcpy(batch_entropy_copy, batch_entropy_pool,
-	       batch_max * sizeof(struct sample));
-
-	head = batch_head;
-	tail = batch_tail;
-	batch_tail = batch_head;
-
-	spin_unlock_irq(&batch_lock);
-
-	p = r;
-	while (head != tail) {
-		if (r->entropy_count >= max_entropy) {
-			r = (r == &blocking_pool) ? &input_pool :
-				&blocking_pool;
-			max_entropy = r->poolinfo->POOLBITS;
-		}
-		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
-		credit_entropy_store(r, batch_entropy_copy[tail].credit);
-		tail = (tail + 1) & (batch_max - 1);
-	}
-	if (p->entropy_count >= random_read_wakeup_thresh)
-		wake_up_interruptible(&random_read_wait);
-}
-
 /*********************************************************************
  *
  * Entropy input management
@@ -692,9 +578,12 @@
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
-	cycles_t data;
-	long delta, delta2, delta3, time;
-	int entropy = 0;
+	struct {
+		cycles_t cycles;
+		long jiffies;
+		unsigned num;
+	} sample;
+	long delta, delta2, delta3;
 
 	preempt_disable();
 	/* if over the trickle threshold, use only 1 in 4096 samples */
@@ -702,16 +591,20 @@
 	    (__get_cpu_var(trickle_count)++ & 0xfff))
 		goto out;
 
+	sample.jiffies = jiffies;
+	sample.cycles = get_cycles();
+	sample.num = num;
+	add_entropy_words(&input_pool, (u32 *)&sample, sizeof(sample)/4);
+
 	/*
 	 * Calculate number of bits of randomness we probably added.
 	 * We take into account the first, second and third-order deltas
 	 * in order to make our estimate.
 	 */
-	time = jiffies;
 
 	if (!state->dont_count_entropy) {
-		delta = time - state->last_time;
-		state->last_time = time;
+		delta = sample.jiffies - state->last_time;
+		state->last_time = sample.jiffies;
 
 		delta2 = delta - state->last_delta;
 		state->last_delta = delta;
@@ -735,20 +628,13 @@
 		 * Round down by 1 bit on general principles,
 		 * and limit entropy entimate to 12 bits.
 		 */
-		entropy = min_t(int, fls(delta>>1), 11);
+		credit_entropy_store(&input_pool,
+				     min_t(int, fls(delta>>1), 11));
 	}
 
-	/*
-	 * Use get_cycles() if implemented, otherwise fall back to
-	 * jiffies.
-	 */
-	data = get_cycles();
-	if (data)
-		num ^= (u32)((data >> 31) >> 1);
-	else
-		data = time;
+	if(input_pool.entropy_count >= random_read_wakeup_thresh)
+		wake_up_interruptible(&random_read_wait);
 
-	batch_entropy_store(num, data, entropy);
 out:
 	preempt_enable();
 }
@@ -1273,9 +1159,6 @@
 
 static int __init rand_initialize(void)
 {
-	if (batch_entropy_init(BATCH_ENTROPY_SIZE, &input_pool))
-		return -1;
-
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	init_std_data(&nonblocking_pool);
