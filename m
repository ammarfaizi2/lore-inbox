Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318798AbSHRC2M>; Sat, 17 Aug 2002 22:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318799AbSHRC2M>; Sat, 17 Aug 2002 22:28:12 -0400
Received: from waste.org ([209.173.204.2]:49621 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318798AbSHRC2I>;
	Sat, 17 Aug 2002 22:28:08 -0400
Date: Sat, 17 Aug 2002 21:32:07 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (4/4) entropy batching update
Message-ID: <20020818023207.GE21643@waste.org>
References: <20020818021522.GA21643@waste.org> <20020818022308.GB21643@waste.org> <20020818022657.GC21643@waste.org> <20020818022949.GD21643@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818022949.GD21643@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch lets the entropy batching pool safely wrap around, allowing
untrusted samples to be mixed in without risk of flooding out trusted 
samples.

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-08-17 19:55:31.000000000 -0500
+++ b/drivers/char/random.c	2002-08-17 19:55:38.000000000 -0500
@@ -596,25 +596,19 @@
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
@@ -622,57 +616,61 @@
 }
 
 /*
- * Changes to the entropy data is put into a queue rather than being
+ * Changes to the entropy data are put into a queue rather than being
  * added to the entropy counts directly.  This is to avoid doing heavy
  * hashing calculations during an interrupt in add_timing_entropy().
  * Instead, the entropy is only added to the pool once per timer tick.
+ *
+ * The batch pool intentionally allows wrap-around, to protect against
+ * flooding of untrusted data. Non-random data will not correlate with
+ * random data and can be safely XORed over existing data.
  */
 
-void batch_entropy_store(u32 a, u32 b, int num)
+void batch_entropy_store(u32 val, int bits)
 {
-	int	new;
-
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
+	/* Don't allow more credit BITS > pool WORDS */
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
 
@@ -766,7 +764,7 @@
 		delta>>=es->shift;
 		bits=benford[int_log2_16bits(delta & 0xffff)];
 	}
-	batch_entropy_store(datum, time, bits);
+	batch_entropy_store(datum^time, bits);
 }
 
 /******************************************************************
diff -ur a/include/linux/random.h b/include/linux/random.h
--- a/include/linux/random.h	2002-08-17 19:55:31.000000000 -0500
+++ b/include/linux/random.h	2002-08-17 19:55:38.000000000 -0500
@@ -44,7 +44,7 @@
 
 extern void rand_initialize(void);
 
-extern void batch_entropy_store(u32 a, u32 b, int num);
+extern void batch_entropy_store(u32 val, int bits);
 extern void *create_entropy_source(int granularity_khz);
 extern void free_entropy_source(void *src);
 extern void add_timing_entropy(void *src, unsigned datum);

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
