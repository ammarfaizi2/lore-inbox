Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270239AbTHBUPP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 16:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbTHBUPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 16:15:15 -0400
Received: from waste.org ([209.173.204.2]:57293 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270239AbTHBUO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 16:14:58 -0400
Date: Sat, 2 Aug 2003 15:14:55 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
Message-ID: <20030802201455.GL22824@waste.org>
References: <20030802042445.GD22824@waste.org> <20030802040015.0fcafda2.akpm@osdl.org> <20030802143222.GG22824@waste.org> <20030802120023.7390f68f.akpm@osdl.org> <20030802193306.GK22824@waste.org> <20030802124647.62ad775f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802124647.62ad775f.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 12:46:47PM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > +		spin_lock(&random_state->lock);
> 
> This needs to be spin_lock_irqsave().
> 
> >  +	fail:
> >  +		spin_unlock(&random_state->lock);
> 
> Double unlock ;)

Damnit. Will you take a patch that just returns -ENOTTY here? Direct
access to the pool is only useful for debugging the driver (or after
you've broken root and want to do backtracking attacks) and hasn't
been useful for that since the second pool was added (sometime in 1.3
IIRC) because you need to be able to snapshot both pools atomically.

Anyway, fixed version.

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-07-13 22:30:36.000000000 -0500
+++ work/drivers/char/random.c	2003-08-02 15:05:18.000000000 -0500
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
@@ -563,6 +565,9 @@
 	int new_rotate;
 	int wordmask = r->poolinfo.poolwords - 1;
 	__u32 w;
+	unsigned long flags;
+
+	spin_lock_irqsave(&r->lock, flags);
 
 	while (nwords--) {
 		w = rotate_left(r->input_rotate, *in++);
@@ -587,6 +592,8 @@
 		w ^= r->pool[i];
 		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
 	}
+
+	spin_unlock_irqrestore(&r->lock, flags);
 }
 
 /*
@@ -594,6 +601,10 @@
  */
 static void credit_entropy_store(struct entropy_store *r, int nbits)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&r->lock, flags);
+
 	if (r->entropy_count + nbits < 0) {
 		DEBUG_ENT("negative entropy/overflow (%d+%d)\n",
 			  r->entropy_count, nbits);
@@ -608,6 +619,8 @@
 				  r == random_state ? "primary" : "unknown",
 				  nbits, r->entropy_count);
 	}
+
+	spin_unlock_irqrestore(&r->lock, flags);
 }
 
 /**********************************************************************
@@ -618,27 +631,33 @@
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
 
@@ -650,27 +669,33 @@
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
@@ -682,20 +707,34 @@
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
@@ -1274,6 +1313,7 @@
 	ssize_t ret, i;
 	__u32 tmp[TMP_BUF_SIZE];
 	__u32 x;
+	unsigned long cpuflags;
 
 	add_timer_randomness(&extract_timer_state, nbytes);
 
@@ -1284,6 +1324,9 @@
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
 		xfer_secondary_pool(r, nbytes, tmp);
 
+	/* Hold lock while accounting */
+	spin_lock_irqsave(&r->lock, cpuflags);
+
 	DEBUG_ENT("%s has %d bits, want %d bits\n",
 		  r == sec_random_state ? "secondary" :
 		  r == random_state ? "primary" : "unknown",
@@ -1298,6 +1341,8 @@
 		wake_up_interruptible(&random_write_wait);
 
 	r->extract_count += nbytes;
+
+	spin_unlock_irqrestore(&r->lock, cpuflags);
 	
 	ret = 0;
 	while (nbytes) {
@@ -1593,8 +1638,9 @@
 random_ioctl(struct inode * inode, struct file * file,
 	     unsigned int cmd, unsigned long arg)
 {
-	int *p, size, ent_count;
+	int *p, *tmp, size, ent_count;
 	int retval;
+	unsigned long flags;
 	
 	switch (cmd) {
 	case RNDGETENTCNT:
@@ -1619,17 +1665,36 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		p = (int *) arg;
-		ent_count = random_state->entropy_count;
-		if (put_user(ent_count, p++) ||
-		    get_user(size, p) ||
+		if (get_user(size, p) ||
 		    put_user(random_state->poolinfo.poolwords, p++))
 			return -EFAULT;
 		if (size < 0)
-			return -EINVAL;
+			return -EFAULT;
 		if (size > random_state->poolinfo.poolwords)
 			size = random_state->poolinfo.poolwords;
-		if (copy_to_user(p, random_state->pool, size * sizeof(__u32)))
+		
+		/* prepare to atomically snapshot pool */
+
+		tmp = kmalloc(size * sizeof(__u32), GFP_KERNEL);
+		
+		if (!tmp)
+			return -EFAULT;
+
+		spin_lock_irqsave(&random_state->lock, flags);
+		ent_count = random_state->entropy_count;
+		memcpy(tmp, random_state->pool, size * sizeof(__u32));
+		spin_unlock_irqrestore(&random_state->lock, flags);
+
+		if (!copy_to_user(p, tmp, size * sizeof(__u32))) {
+			kfree(tmp);
 			return -EFAULT;
+		}
+
+		kfree(tmp);
+
+		if(put_user(ent_count, p++))
+			return -EFAULT;
+
 		return 0;
 	case RNDADDENTROPY:
 		if (!capable(CAP_SYS_ADMIN))


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
