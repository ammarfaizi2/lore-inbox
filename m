Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbUCZARl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbUCZAGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:06:32 -0500
Received: from waste.org ([209.173.204.2]:54937 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263830AbUCYX6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:07 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <21.524465763@selenic.com>
Message-Id: <22.524465763@selenic.com>
Subject: [PATCH 21/22] /dev/random: kill batching of entropy mixing
Date: Thu, 25 Mar 2004 17:57:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  kill batching of entropy mixing

Rather than batching up entropy samples, resulting in longer lock hold
times when we actually process the samples, mix in samples
immediately. The trickle code should eliminate almost all the
additional interrupt-time overhead this would otherwise incur, with or
without locking.



 tiny-mpm/drivers/char/random.c  |  150 +++++-----------------------------------
 tiny-mpm/include/linux/random.h |    2 
 2 files changed, 19 insertions(+), 133 deletions(-)

diff -puN drivers/char/random.c~kill-batching drivers/char/random.c
--- tiny/drivers/char/random.c~kill-batching	2004-03-20 13:38:50.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:50.000000000 -0600
@@ -245,7 +245,6 @@
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/workqueue.h>
 #include <linux/genhd.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
@@ -262,7 +261,6 @@
  */
 #define INPUT_POOL_SIZE 512
 #define BLOCKING_POOL_SIZE 128
-#define BATCH_ENTROPY_SIZE 256
 
 /*
  * The minimum number of bits of entropy before we wake up a read on
@@ -541,123 +539,6 @@ static void credit_entropy_store(struct 
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
-static int	batch_head, batch_tail;
-static spinlock_t batch_lock = SPIN_LOCK_UNLOCKED;
-
-static int	batch_max;
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
-void batch_entropy_store(u32 a, u32 b, int num)
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
-	if (((batch_head - batch_tail) & (batch_max-1)) >= (batch_max / 2)) {
-		/*
-		 * Schedule it for the next timer tick:
-		 */
-		schedule_delayed_work(&batch_work, 1);
-	}
-
-	new = (batch_head+1) & (batch_max-1);
-	if (new == batch_tail) {
-		DEBUG_ENT("batch entropy buffer full\n");
-	} else {
-		batch_head = new;
-	}
-
-	spin_unlock_irqrestore(&batch_lock, flags);
-}
-
-EXPORT_SYMBOL(batch_entropy_store);
-
-/*
- * Flush out the accumulated entropy operations, adding entropy to the
- * input pool.  If that pool has enough entropy, alternate
- * between randomizing the data of all pools.
- */
-static void batch_entropy_process(void *private_)
-{
-	struct entropy_store *r	= input_pool;
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
-	       batch_max*sizeof(struct sample));
-
-	head = batch_head;
-	tail = batch_tail;
-	batch_tail = batch_head;
-
-	spin_unlock_irq(&batch_lock);
-
-	while (head != tail) {
-		if (r->entropy_count >= r->poolinfo->POOLBITS)
-			r = blocking_pool;
-		if (r->entropy_count >= r->poolinfo->POOLBITS)
-			r = nonblocking_pool;
-
-		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
-		credit_entropy_store(r, batch_entropy_copy[tail].credit);
-		tail = (tail+1) & (batch_max-1);
-	}
-	if (input_pool->entropy_count >= random_read_wakeup_thresh)
-		wake_up_interruptible(&random_read_wait);
-}
-
 /*********************************************************************
  *
  * Entropy input management
@@ -689,10 +570,10 @@ static struct timer_rand_state *irq_time
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
+	struct entropy_store *r	= input_pool;
 	long long clock;
-	u32 time;
-	__s32		delta, delta2, delta3;
-	int		entropy = 0;
+	u32 data[2], time;
+	__s32 delta, delta2, delta3;
 
 	/* if over the trickle threshold, use only 1 in 4096 samples */
 	if ( input_pool->entropy_count > trickle_thresh &&
@@ -702,6 +583,18 @@ static void add_timer_randomness(struct 
 	/* Use slow clock for conservative entropy estimation */
 	time = jiffies;
 
+	/* Mix in fast clock for entropy data */
+	clock = sched_clock();
+	data[0] = num ^ (clock >> 32);
+	data[1] = time ^ (u32)clock;
+
+	if (r->entropy_count >= r->poolinfo->POOLBITS)
+		r = blocking_pool;
+	if (r->entropy_count >= r->poolinfo->POOLBITS)
+		r = nonblocking_pool;
+
+	add_entropy_words(r, data, 2);
+
 	/*
 	 * Calculate number of bits of randomness we probably added.
 	 * We take into account the first, second and third-order deltas
@@ -733,13 +626,11 @@ static void add_timer_randomness(struct 
 		 * Round down by 1 bit on general principles,
 		 * and limit entropy entimate to 12 bits.
 		 */
-		entropy = min_t(int, fls(delta>>1), 11);
-	}
+		credit_entropy_store(r, min_t(int, fls(delta>>1), 11));
 
-	/* Mix in fast clock for entropy data */
-	clock = sched_clock();
-	num ^= clock >> 32;
-	batch_entropy_store(num, time ^ (u32)clock, entropy);
+		if (input_pool->entropy_count >= random_read_wakeup_thresh)
+			wake_up_interruptible(&random_read_wait);
+	}
 }
 
 void add_keyboard_randomness(unsigned char scancode)
@@ -1115,9 +1006,6 @@ static int __init rand_initialize(void)
 	if (!(input_pool && blocking_pool && nonblocking_pool))
 		return -1;
 
-	if (batch_entropy_init(BATCH_ENTROPY_SIZE, input_pool))
-		return -1;
-
 	init_std_data(input_pool);
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(input_pool);
diff -puN include/linux/random.h~kill-batching include/linux/random.h
--- tiny/include/linux/random.h~kill-batching	2004-03-20 13:38:50.000000000 -0600
+++ tiny-mpm/include/linux/random.h	2004-03-20 13:38:50.000000000 -0600
@@ -41,8 +41,6 @@ struct rand_pool_info {
 
 extern void rand_initialize_irq(int irq);
 
-extern void batch_entropy_store(u32 a, u32 b, int num);
-
 extern void add_keyboard_randomness(unsigned char scancode);
 extern void add_mouse_randomness(__u32 mouse_data);
 extern void add_interrupt_randomness(int irq);

_
