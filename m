Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTHBOch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 10:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTHBOch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 10:32:37 -0400
Received: from waste.org ([209.173.204.2]:63936 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263894AbTHBOca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 10:32:30 -0400
Date: Sat, 2 Aug 2003 09:32:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
Message-ID: <20030802143222.GG22824@waste.org>
References: <20030802042445.GD22824@waste.org> <20030802040015.0fcafda2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802040015.0fcafda2.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 04:00:15AM -0700, Andrew Morton wrote:
> Oliver Xymoron <oxymoron@waste.org> wrote:
> >
> > This patch adds locking for SMP. Apparently Willy never managed to
> > revive his laptop with his version so I revived mine.
> 
> hrm.  I'm a random ignoramus.   I'll look it over...
> 
> Are you really sure that all the decisions about where to use spin_lock()
> vs spin_lock_irq() vs spin_lock_irqsave() are correct?  They are
> non-obvious.

Aside from the put_user stuff below, yes.

&batch_lock
  batch_entropy_store can be called from any context, and typically from
  interrupts -> spin_lock_irqsave

  batch_entropy_process is called called via schedule_delayed_work and
  runs in process context -> spin_lock_irq

&r->lock
  the mixing process is too expensive to be called from an interrupt
  context and the basic worker function extract_entropy can sleep, so
  all this stuff can be under a normal spin_lock


> > @@ -1619,18 +1660,23 @@
> >  		if (!capable(CAP_SYS_ADMIN))
> >  			return -EPERM;
> >  		p = (int *) arg;
> > +		spin_lock(&random_state->lock);
> >  		ent_count = random_state->entropy_count;
> >  		if (put_user(ent_count, p++) ||
> >  		    get_user(size, p) ||
> >  		    put_user(random_state->poolinfo.poolwords, p++))
> 
> Cannot perform userspace access while holding a lock - a pagefault could
> occur, perform IO, schedule away and the same CPU tries to take the same
> lock via a different process.

Doh. Fixed. All the other userspace transfers are done without locks.

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-07-13 22:30:36.000000000 -0500
+++ work/drivers/char/random.c	2003-08-02 09:28:04.000000000 -0500
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
@@ -1593,7 +1634,7 @@
 random_ioctl(struct inode * inode, struct file * file,
 	     unsigned int cmd, unsigned long arg)
 {
-	int *p, size, ent_count;
+	int *p, *tmp, size, ent_count;
 	int retval;
 	
 	switch (cmd) {
@@ -1619,18 +1660,40 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		p = (int *) arg;
-		ent_count = random_state->entropy_count;
-		if (put_user(ent_count, p++) ||
-		    get_user(size, p) ||
+		if (get_user(size, p) ||
 		    put_user(random_state->poolinfo.poolwords, p++))
-			return -EFAULT;
+			goto fail;
 		if (size < 0)
-			return -EINVAL;
+			goto fail;
 		if (size > random_state->poolinfo.poolwords)
 			size = random_state->poolinfo.poolwords;
-		if (copy_to_user(p, random_state->pool, size * sizeof(__u32)))
-			return -EFAULT;
+		
+		/* prepare to atomically snapshot pool */
+
+		tmp = kmalloc(size * sizeof(__u32), GFP_KERNEL);
+		
+		if (!tmp)
+			goto fail;
+
+		spin_lock(&random_state->lock);
+		ent_count = random_state->entropy_count;
+		memcpy(tmp, random_state->pool, size * sizeof(__u32));
+		spin_unlock(&random_state->lock);
+
+		if (!copy_to_user(p, tmp, size * sizeof(__u32))) {
+			kfree(tmp);
+			goto fail;
+		}
+
+		kfree(tmp);
+
+		if(put_user(ent_count, p++))
+			goto fail;
+
 		return 0;
+	fail:
+		spin_unlock(&random_state->lock);
+		return -EFAULT;
 	case RNDADDENTROPY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
