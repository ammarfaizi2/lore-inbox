Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272637AbTHBEY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 00:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272638AbTHBEY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 00:24:56 -0400
Received: from waste.org ([209.173.204.2]:49579 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272637AbTHBEYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 00:24:49 -0400
Date: Fri, 1 Aug 2003 23:24:45 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] [1/2] random: SMP locking
Message-ID: <20030802042445.GD22824@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds locking for SMP. Apparently Willy never managed to
revive his laptop with his version so I revived mine.

The batch pool is copied as a block to avoid long lock hold times
while mixing it into the primary pool. 

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-07-13 22:30:36.000000000 -0500
+++ work/drivers/char/random.c	2003-08-01 22:15:42.000000000 -0500
@@ -484,6 +484,7 @@
 	int		extract_count;
 	struct poolinfo poolinfo;
 	__u32		*pool;
+	spinlock_t lock;
 };
 
 /*
@@ -522,6 +523,7 @@
 		return -ENOMEM;
 	}
 	memset(r->pool, 0, POOLBYTES);
+	r->lock = SPIN_LOCK_UNLOCKED; 
 	*ret_bucket = r;
 	return 0;
 }
@@ -564,6 +566,8 @@
 	int wordmask = r->poolinfo.poolwords - 1;
 	__u32 w;
 
+	spin_lock(&r->lock);
+
 	while (nwords--) {
 		w = rotate_left(r->input_rotate, *in++);
 		i = r->add_ptr = (r->add_ptr - 1) & wordmask;
@@ -587,6 +591,8 @@
 		w ^= r->pool[i];
 		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
 	}
+
+	spin_unlock(&r->lock);
 }
 
 /*
@@ -594,6 +600,8 @@
  */
 static void credit_entropy_store(struct entropy_store *r, int nbits)
 {
+	spin_lock(&r->lock);
+
 	if (r->entropy_count + nbits < 0) {
 		DEBUG_ENT("negative entropy/overflow (%d+%d)\n",
 			  r->entropy_count, nbits);
@@ -608,6 +616,8 @@
 				  r == random_state ? "primary" : "unknown",
 				  nbits, r->entropy_count);
 	}
+
+	spin_unlock(&r->lock);
 }
 
 /**********************************************************************
@@ -618,27 +628,33 @@
  *
  **********************************************************************/
 
-static __u32	*batch_entropy_pool;
-static int	*batch_entropy_credit;
-static int	batch_max;
+struct sample { 
+	__u32 data[2];
+	int credit;
+};
+
+static struct sample *batch_entropy_pool, *batch_entropy_copy;
 static int	batch_head, batch_tail;
+static spinlock_t batch_lock = SPIN_LOCK_UNLOCKED; 
+
+static int	batch_max;
 static void batch_entropy_process(void *private_);
 static DECLARE_WORK(batch_work, batch_entropy_process, NULL);
 
 /* note: the size must be a power of 2 */
 static int __init batch_entropy_init(int size, struct entropy_store *r)
 {
-	batch_entropy_pool = kmalloc(2*size*sizeof(__u32), GFP_KERNEL);
+	batch_entropy_pool = kmalloc(size*sizeof(struct sample), GFP_KERNEL);
 	if (!batch_entropy_pool)
 		return -1;
-	batch_entropy_credit =kmalloc(size*sizeof(int), GFP_KERNEL);
-	if (!batch_entropy_credit) {
+	batch_entropy_copy = kmalloc(size*sizeof(struct sample), GFP_KERNEL);
+	if (!batch_entropy_copy) {
 		kfree(batch_entropy_pool);
 		return -1;
 	}
 	batch_head = batch_tail = 0;
-	batch_max = size;
 	batch_work.data = r;
+	batch_max = size;
 	return 0;
 }
 
@@ -650,27 +666,33 @@
  */
 void batch_entropy_store(u32 a, u32 b, int num)
 {
-	int	new;
+	int new;
+	unsigned long flags;
 
 	if (!batch_max)
 		return;
+
+	spin_lock_irqsave(&batch_lock, flags);
 	
-	batch_entropy_pool[2*batch_head] = a;
-	batch_entropy_pool[(2*batch_head) + 1] = b;
-	batch_entropy_credit[batch_head] = num;
+	batch_entropy_pool[batch_head].data[0] = a;
+	batch_entropy_pool[batch_head].data[1] = b;
+	batch_entropy_pool[batch_head].credit = num;
 
-	new = (batch_head+1) & (batch_max-1);
-	if ((unsigned)(new - batch_tail) >= (unsigned)(batch_max / 2)) {
+	if (((batch_head - batch_tail) & (batch_max-1)) >= (batch_max / 2)) {
 		/*
 		 * Schedule it for the next timer tick:
 		 */
 		schedule_delayed_work(&batch_work, 1);
-		batch_head = new;
-	} else if (new == batch_tail) {
+	} 
+
+	new = (batch_head+1) & (batch_max-1);
+	if (new == batch_tail) {
 		DEBUG_ENT("batch entropy buffer full\n");
 	} else {
 		batch_head = new;
 	}
+
+	spin_unlock_irqrestore(&batch_lock, flags);
 }
 
 /*
@@ -682,20 +704,34 @@
 {
 	struct entropy_store *r	= (struct entropy_store *) private_, *p;
 	int max_entropy = r->poolinfo.POOLBITS;
+	unsigned head, tail;
 
-	if (!batch_max)
-		return;
+	/* Mixing into the pool is expensive, so copy over the batch
+	 * data and release the batch lock. The pool is at least half
+	 * full, so don't worry too much about copying only the used
+	 * part.
+	 */
+	spin_lock_irq(&batch_lock);
+
+	memcpy(batch_entropy_copy, batch_entropy_pool, 
+	       batch_max*sizeof(struct sample));
+
+	head = batch_head;
+	tail = batch_tail;
+	batch_tail = batch_head;
+	
+	spin_unlock_irq(&batch_lock);
 
 	p = r;
-	while (batch_head != batch_tail) {
+	while (head != tail) {
 		if (r->entropy_count >= max_entropy) {
 			r = (r == sec_random_state) ?	random_state :
 							sec_random_state;
 			max_entropy = r->poolinfo.POOLBITS;
 		}
-		add_entropy_words(r, batch_entropy_pool + 2*batch_tail, 2);
-		credit_entropy_store(r, batch_entropy_credit[batch_tail]);
-		batch_tail = (batch_tail+1) & (batch_max-1);
+		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
+		credit_entropy_store(r, batch_entropy_copy[tail].credit);
+		tail = (tail+1) & (batch_max-1);
 	}
 	if (p->entropy_count >= random_read_wakeup_thresh)
 		wake_up_interruptible(&random_read_wait);
@@ -1286,6 +1322,9 @@
 
 	DEBUG_ENT("%s has %d bits, want %d bits\n",
 		  r == sec_random_state ? "secondary" :
+	/* Hold lock while accounting */
+	spin_lock(&r->lock);
+
 		  r == random_state ? "primary" : "unknown",
 		  r->entropy_count, nbytes * 8);
 
@@ -1298,6 +1337,8 @@
 		wake_up_interruptible(&random_write_wait);
 
 	r->extract_count += nbytes;
+
+	spin_unlock(&r->lock);
 	
 	ret = 0;
 	while (nbytes) {
@@ -1619,18 +1660,23 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		p = (int *) arg;
+		spin_lock(&random_state->lock);
 		ent_count = random_state->entropy_count;
 		if (put_user(ent_count, p++) ||
 		    get_user(size, p) ||
 		    put_user(random_state->poolinfo.poolwords, p++))
-			return -EFAULT;
+			goto fail;
 		if (size < 0)
-			return -EINVAL;
+			goto fail;
 		if (size > random_state->poolinfo.poolwords)
 			size = random_state->poolinfo.poolwords;
 		if (copy_to_user(p, random_state->pool, size * sizeof(__u32)))
-			return -EFAULT;
+			goto fail;
+		spin_unlock(&random_state->lock);
 		return 0;
+	fail:
+		spin_unlock(&random_state->lock);
+		return -EFAULT;
 	case RNDADDENTROPY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
