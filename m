Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275790AbRJBHv5>; Tue, 2 Oct 2001 03:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275853AbRJBHvs>; Tue, 2 Oct 2001 03:51:48 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:24316 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275790AbRJBHva>; Tue, 2 Oct 2001 03:51:30 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 2 Oct 2001 01:51:14 -0600
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: /dev/random entropy calculations broken?
Message-ID: <20011002015114.A24826@turbolinux.com>
Mail-Followup-To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
In-Reply-To: <1001461026.9352.156.camel@phantasy> <9or70g$i59$1@abraham.cs.berkeley.edu> <tgadzbr8kq.fsf@mercury.rus.uni-stuttgart.de> <20011001105927.A22795@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011001105927.A22795@turbolinux.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 01, 2001  10:59 -0600, adilger wrote:
> Has anyone even checked whether the current entropy estimates even work
> properly?  I was testing this, and it appears something is terribly wrong.
> Check /proc/sys/kernel/random/entropy_avail.  On a system that has been
> running any length of time, it should be 4096 (512 bytes * 8 bits of
> entropy for a full pool).
> 
> Now, "dd if=/dev/random bs=16 count=1 | wc -c" and check entropy_avail
> again.  It "loses" thousands of bits of entropy for generating 16 bytes
> (128 bits) of random data.
> 
> Now if you do the above test on /dev/random several times in a row, you see
> that you really HAVE used up the entropy, because it will return a number
> of bytes less than what you requested.  At this point, however, it is at
> least consistent, returning a number of bytes = entropy_avail/8.

OK, after going through the code carefully, it appears that there are
several big problems in entropy accounting in drivers/char/random.c
which essentially mean that any time we read /dev/random or /dev/urandom
or /proc/sys/kernel/random/uuid we would entirely deplete the entropy pool.

While this in itself is not a security problem (i.e. we discard huge
amounts of entropy on each operation) it could be a problem for systems
that need entropy and don't want it wasted.  Similarly, it _may_ be a
factor in "inflating" entropy counts from sources, because we were
throwing so much away it wouldn't be usable without such high entropy
counts.  In my testing, be basically ALWAYS get 9-12 bits of entropy
from each keystroke, disk I/O, and (many, many) mouse interrupts, rather
than dribble in entropy in small bits at a time.


The below patch fixes these problems, at least to be sane in regards
to accounting of entropy in the system.  There are still some issues
to be discussed however.

First fix (minor): in batch_entropy_process() if the store had the maximum
  amount of entropy, the remaining entropy _appeared_ that it should go
  into the secondary store.  However, the test "entropy_count > max_entropy"
  could never be true (entropy_count is clamped in credit_entropy_store()).
  Fixed so we add entropy to secondary store until it is also full, and
  then alternate stirring in values into both stores (accumulates more
  entropy, and adds more randomness even if we don't account for entropy).

Second fix (minor): in batch_entropy_process() IF we switched to adding
  entropy to the secondary store, we credited this store with entropy
  that was actually added to the first store.  Also in this case we only
  woke up a reader if the _secondary_ store had enough entropy, and not
  it the _primary_ store had enough entropy (which is much more likely).

Third fix (minor): in xfer_secondary_pool() we extract entropy from the
  primary pool, even if the secondary pool is already full, if we request
  more entropy than can fit into the secondary pool.  The pool will be
  refilled anyways because it will be depleted after this action.  We now
  only refill the secondary pool if it is not already full (saving entropy).
  We could save even more entropy by only adding as much entropy as we need.

Fourth fix (minor): in xfer_secondary_pool() we credit the secondary pool
  with the correct number of BITS taken from the primary pool(*).  We were
  adding 1/4 of the number of bits taken from the primary to the secondary,
  and losing the other 3/4 of the entropy (byte/word mismatch?)(**).

Fifth fix: in extract_entropy() the "redundant but just in case" check was
  wrong, comparing entropy bit count and pool words.  This had the effect
  of losing 31/32 of the random pool on each access.  BAD, BAD program!


(*) It is my assumption that if you extract N bits of entropy from one
    pool, you add N bits into the other pool.  If this isn't true, then
    something needs to be fixed elsewhere.  I believe the problem is
    that extract_entropy() returns "nbytes" of data regardless of how
    much real entropy is in the pool, hence "creating" entropy where
    there was none in xfer_secondary_pool().  Either we should return
    the REAL amount of entropy backed data (and fix the urandom return
    values), or figure out some way to credit the secondary pool with
    only as much entropy as is really available.

(**) When using the SHA hash, we extract 5+80 words = 2720 bits from the
    primary pool and "add" it to the secondary pool.  However, the
    secondary pool is only 1024 bits in size, so we throw half of this
    entropy away each time (including extra CPU overhead).  Should we
    fix the secondary pool to be at least TMP_BUF_SIZE to hold this data?


The second patch is purely cosmetic fixes (added comments and such),
and also exports "generate_random_uuid()" for use in modules (I was
playing around with this in reiserfs as a module, and it needs to
be exported anyways, according to the comments above it).

Cheers, Andreas
===========================================================================
--- linux.orig/drivers/char/random.c	Tue Jul 10 17:05:24 2001
+++ linux/drivers/char/random.c	Tue Oct  2 00:17:40 2001
@@ -403,6 +403,12 @@
 #define MIN(a,b) (((a) < (b)) ? (a) : (b))
 #endif
 
+#if 0
+#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
+#else
+#define DEBUG_ENT(fmt, arg...) do {} while (0)
+#endif
+
 /*
  * Unfortunately, while the GCC optimizer for the i386 understands how
  * to optimize a static rotate left of x bits, it doesn't know how to
@@ -651,24 +670,23 @@
 
 static void batch_entropy_process(void *private_)
 {
-	int	num = 0;
-	int	max_entropy;
 	struct entropy_store *r	= (struct entropy_store *) private_, *p;
-	
+	int	max_entropy = r->poolinfo.poolwords*32;
+
 	if (!batch_max)
 		return;
 
-	max_entropy = r->poolinfo.poolwords*32;
+	p = r;
 	while (batch_head != batch_tail) {
+		if (r->entropy_count >= max_entropy) {
+			r = (r == sec_random_state) ?	random_state :
+							sec_random_state;
+		}
 		add_entropy_words(r, batch_entropy_pool + 2*batch_tail, 2);
-		p = r;
-		if (r->entropy_count > max_entropy && (num & 1))
-			r = sec_random_state;
 		credit_entropy_store(r, batch_entropy_credit[batch_tail]);
 		batch_tail = (batch_tail+1) & (batch_max-1);
-		num++;
 	}
-	if (r->entropy_count >= random_read_wakeup_thresh)
+	if (p->entropy_count >= random_read_wakeup_thresh)
 		wake_up_interruptible(&random_read_wait);
 }
 
@@ -1210,12 +1233,19 @@
 {
 	__u32	tmp[TMP_BUF_SIZE];
 
-	if (r->entropy_count < nbytes*8) {
+	if (r->entropy_count < nbytes*8 && r->entropy_count < r->poolsize*32) {
+		DEBUG_ENT("xfer %d from primary to %s (have %d need %d)\n",
+			  sizeof(tmp) * 8,
+			  r == sec_random_state ? "secondary" : "unknown",
+			  r->entropy_count, nbytes * 8);
 		extract_entropy(random_state, tmp, sizeof(tmp), 0);
 		add_entropy_words(r, tmp, TMP_BUF_SIZE);
-		credit_entropy_store(r, TMP_BUF_SIZE*8);
+		credit_entropy_store(r, TMP_BUF_SIZE*32);
 	}
 	if (r->extract_count > 1024) {
+		DEBUG_ENT("reseeding %s with %d from primary\n",
+			  r == sec_random_state ? "secondary" : "unknown",
+			  sizeof(tmp) * 8);
 		extract_entropy(random_state, tmp, sizeof(tmp), 0);
 		add_entropy_words(r, tmp, TMP_BUF_SIZE);
 		r->extract_count = 0;
@@ -1240,10 +1270,10 @@
 	__u32 x;
 
 	add_timer_randomness(&extract_timer_state, nbytes);
-	
+
 	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo.poolwords) 
-		r->entropy_count = r->poolinfo.poolwords;
+	if (r->entropy_count > r->poolinfo.poolwords * 32)
+		r->entropy_count = r->poolinfo.poolwords * 32;
 
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
 		xfer_secondary_pool(r, nbytes);



===========================================================================
--- linux.orig/drivers/char/random.c	Tue Jul 10 17:05:24 2001
+++ linux/drivers/char/random.c	Tue Oct  2 00:17:40 2001
@@ -272,8 +272,8 @@
 static int random_write_wakeup_thresh = 128;
 
 /*
- * A pool of size POOLWORDS is stirred with a primitive polynomial
- * of degree POOLWORDS over GF(2).  The taps for various sizes are
+ * A pool of size .poolwords is stirred with a primitive polynomial
+ * of degree .poolwords over GF(2).  The taps for various sizes are
  * defined below.  They are chosen to be evenly spaced (minimum RMS
  * distance from evenly spaced; the numbers in the comments are a
  * scaled squared error sum) except for the last tap, which is 1 to
@@ -552,11 +558,12 @@
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
 	unsigned i;
 	int new_rotate;
+	int wordmask = r->poolinfo.poolwords - 1;
 	__u32 w;
 
 	while (num--) {
 		w = rotate_left(r->input_rotate, *in);
-		i = r->add_ptr = (r->add_ptr - 1) & (r->poolinfo.poolwords-1);
+		i = r->add_ptr = (r->add_ptr - 1) & wordmask;
 		/*
 		 * Normally, we add 7 bits of rotation to the pool.
 		 * At the beginning of the pool, add an extra 7 bits
@@ -569,11 +576,11 @@
 		r->input_rotate = new_rotate & 31;
 
 		/* XOR in the various taps */
-		w ^= r->pool[(i+r->poolinfo.tap1)&(r->poolinfo.poolwords-1)];
-		w ^= r->pool[(i+r->poolinfo.tap2)&(r->poolinfo.poolwords-1)];
-		w ^= r->pool[(i+r->poolinfo.tap3)&(r->poolinfo.poolwords-1)];
-		w ^= r->pool[(i+r->poolinfo.tap4)&(r->poolinfo.poolwords-1)];
-		w ^= r->pool[(i+r->poolinfo.tap5)&(r->poolinfo.poolwords-1)];
+		w ^= r->pool[(i + r->poolinfo.tap1) & wordmask];
+		w ^= r->pool[(i + r->poolinfo.tap2) & wordmask];
+		w ^= r->pool[(i + r->poolinfo.tap3) & wordmask];
+		w ^= r->pool[(i + r->poolinfo.tap4) & wordmask];
+		w ^= r->pool[(i + r->poolinfo.tap5) & wordmask];
 		w ^= r->pool[i];
 		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
 	}
@@ -586,12 +593,20 @@
 {
 	int	max_entropy = r->poolinfo.poolwords*32;
 
-	if (r->entropy_count + num < 0)
+	if (r->entropy_count + num < 0) {
+		DEBUG_ENT("negative entropy/overflow (%d+%d)\n",
+			  r->entropy_count, num);
 		r->entropy_count = 0;
-	else if (r->entropy_count + num > max_entropy)
+	} else if (r->entropy_count + num > max_entropy) {
 		r->entropy_count = max_entropy;
-	else
-		r->entropy_count = r->entropy_count + num;
+	} else {
+		r->entropy_count += num;
+		if (num)
+			DEBUG_ENT("%s added %d bits, now %d\n",
+				  r == sec_random_state ? "secondary" :
+				  r == random_state ? "primary" : "unknown",
+				  num, r->entropy_count);
+	}
 }
 
 /**********************************************************************
@@ -627,6 +642,12 @@
 	return 0;
 }
 
+/*
+ * Changes to the entropy data are put into a queue rather than being added
+ * to the entropy counts directly.  This is presumably to avoid doing heavy
+ * hashing calculations during an interrupt in add_timer_randomness().
+ * Instead, the entropy is only added to the pool once per timer tick.
+ */
 void batch_entropy_store(u32 a, u32 b, int num)
 {
 	int	new;
@@ -643,12 +664,15 @@
 		queue_task(&batch_tqueue, &tq_timer);
 		batch_head = new;
 	} else {
-#if 0
-		printk(KERN_NOTICE "random: batch entropy buffer full\n");
-#endif
+		DEBUG_ENT("batch entropy buffer full\n");
 	}
 }
 
+/*
+ * Flush out the accumulated entropy operations, adding entropy to the passed
+ * store (normally random_state).  If that store has enough entropy, alternate
+ * between randomizing the data of the primary and secondary stores.
+ */
 static void batch_entropy_process(void *private_)
 {
 	struct entropy_store *r	= (struct entropy_store *) private_, *p;
@@ -1228,9 +1258,12 @@
  * bits of entropy are left in the pool, but it does not restrict the
  * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
  * flag is given, then the buf pointer is assumed to be in user space.
- * If the EXTRACT_ENTROPY_SECONDARY flag is given, then this function will 
  *
- * Note: extract_entropy() assumes that POOLWORDS is a multiple of 16 words.
+ * If the EXTRACT_ENTROPY_SECONDARY flag is given, then we are actually
+ * extracting entropy from the secondary pool, and can refill from the
+ * primary pool if needed.
+ *
+ * Note: extract_entropy() assumes that .poolwords is a multiple of 16 words.
  */
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
 			       size_t nbytes, int flags)
@@ -1248,6 +1278,11 @@
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
 		xfer_secondary_pool(r, nbytes);
 
+	DEBUG_ENT("%s has %d bits, want %d bits\n",
+		  r == sec_random_state ? "secondary" :
+		  r == random_state ? "primary" : "unknown",
+		  r->entropy_count, nbytes * 8);
+
 	if (r->entropy_count / 8 >= nbytes)
 		r->entropy_count -= nbytes*8;
 	else
@@ -2238,4 +2276,5 @@
 EXPORT_SYMBOL(add_interrupt_randomness);
 EXPORT_SYMBOL(add_blkdev_randomness);
 EXPORT_SYMBOL(batch_entropy_store);
+EXPORT_SYMBOL(generate_random_uuid);
 
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

