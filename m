Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319038AbSHWSXh>; Fri, 23 Aug 2002 14:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319044AbSHWSXh>; Fri, 23 Aug 2002 14:23:37 -0400
Received: from waste.org ([209.173.204.2]:60331 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319038AbSHWSXe>;
	Fri, 23 Aug 2002 14:23:34 -0400
Date: Fri, 23 Aug 2002 13:27:43 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (2/7) entropy batching
Message-ID: <20020823182743.GB2224@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This smartens up and simplifies the batch entropy pool.

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-08-23 12:43:20.000000000 -0500
+++ b/drivers/char/random.c	2002-08-23 12:43:22.000000000 -0500
@@ -526,7 +526,7 @@
 }
 
 /*
- * This function adds a byte into the entropy "pool".  It does not
+ * This function adds a word into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
  * credit_entropy_store if this is appropriate.
  * 
@@ -600,25 +600,19 @@
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
@@ -626,56 +620,61 @@
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
 
@@ -764,7 +763,7 @@
 
 		entropy = int_log2_16bits(delta);
 	}
-	batch_entropy_store(num, time, entropy);
+	batch_entropy_store(num^time, entropy);
 }
 
 void add_keyboard_randomness(unsigned char scancode)
diff -ur a/include/linux/random.h b/include/linux/random.h
--- a/include/linux/random.h	2002-07-20 14:11:18.000000000 -0500
+++ b/include/linux/random.h	2002-08-23 12:43:22.000000000 -0500
@@ -46,7 +46,7 @@
 extern void rand_initialize_irq(int irq);
 extern void rand_initialize_blkdev(int irq, int mode);
 
-extern void batch_entropy_store(u32 a, u32 b, int num);
+extern void batch_entropy_store(u32 val, int bits);
 
 extern void add_keyboard_randomness(unsigned char scancode);
 extern void add_mouse_randomness(__u32 mouse_data);

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
