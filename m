Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276684AbRJBVDC>; Tue, 2 Oct 2001 17:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276689AbRJBVCy>; Tue, 2 Oct 2001 17:02:54 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:44029 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276684AbRJBVCp>; Tue, 2 Oct 2001 17:02:45 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 2 Oct 2001 15:02:33 -0600
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: Re: /dev/random entropy calculations broken?
Message-ID: <20011002150233.M8954@turbolinux.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Theodore Y. Ts'o" <tytso@MIT.EDU>
In-Reply-To: <20011002015114.A24826@turbolinux.com> <Pine.LNX.4.30.0110021031151.19213-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0110021031151.19213-100000@waste.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2001  10:37 -0500, Oliver Xymoron wrote:
> On Tue, 2 Oct 2001, Andreas Dilger wrote:
> > Fifth fix: in extract_entropy() the "redundant but just in case" check was
> >   wrong, comparing entropy bit count and pool words.  This had the effect
> >   of losing 31/32 of the random pool on each access.  BAD, BAD program!
> 
> > +	if (r->entropy_count > r->poolinfo.poolwords * 32)
> > +		r->entropy_count = r->poolinfo.poolwords * 32;
> 
> Damnit, I read that line 30 times yesterday!

So did I.  It wasn't till my system was spewing debugging output that I
saw where it was going.

> While we're on words/bytes/bits confusion, add_entropy_words() seems to
> get called with number of bytes rather than words.

Makes it that much more random, doesn't it ;-).  OK, here is a new version
of the patch.  It clears up the parameters to the functions, and makes sure
that we pass the right values to each.

Cheers, Andreas
===========================================================================
--- linux.orig/drivers/char/random.c	Tue Jul 10 17:05:24 2001
+++ linux/drivers/char/random.c	Tue Oct  2 14:50:19 2001
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
@@ -281,49 +281,47 @@
  */
 static struct poolinfo {
 	int	poolwords;
+	int	poolbits;	/* poolwords * 32 */
 	int	tap1, tap2, tap3, tap4, tap5;
 } poolinfo_table[] = {
 	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
-	{ 2048,	1638,	1231,	819, 	411,	1 },
+	{ 2048,	65536,	1638,	1231,	819,	411,	1 },
 
 	/* x^1024 + x^817 + x^615 + x^412 + x^204 + x + 1 -- 290 */
-	{ 1024,	817, 	615,	412,	204,	1 },
-
+	{ 1024,	32768,	817,	615,	412,	204,	1 },
 #if 0				/* Alternate polynomial */
 	/* x^1024 + x^819 + x^616 + x^410 + x^207 + x^2 + 1 -- 115 */
-	{ 1024,	819,	616,	410,	207,	2 },
+	{ 1024,	32768,	819,	616,	410,	207,	2 },
 #endif
-	
-	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
-	{ 512,	411,	308,	208,	104,	1 },
 
+	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
+	{ 512,	16384,	411,	308,	208,	104,	1 },
 #if 0				/* Alternates */
 	/* x^512 + x^409 + x^307 + x^206 + x^102 + x^2 + 1 -- 95 */
-	{ 512,	409,	307,	206,	102,	2 },
+	{ 512,	16384,	409,	307,	206,	102,	2 },
 	/* x^512 + x^409 + x^309 + x^205 + x^103 + x^2 + 1 -- 95 */
-	{ 512,	409,	309,	205,	103,	2 },
+	{ 512,	16384,	409,	309,	205,	103,	2 },
 #endif
 
 	/* x^256 + x^205 + x^155 + x^101 + x^52 + x + 1 -- 125 */
-	{ 256,	205,	155,	101,	52,	1 },
-	
-	/* x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 -- 105 */
-	{ 128,	103,	76,	51,	25,	1 },
+	{ 256,	8192,	205,	155,	101,	52,	1 },
 
+	/* x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 -- 105 */
+	{ 128,	4096,	103,	76,	51,	25,	1 },
 #if 0	/* Alternate polynomial */
 	/* x^128 + x^103 + x^78 + x^51 + x^27 + x^2 + 1 -- 70 */
-	{ 128,	103,	78,	51,	27,	2 },
+	{ 128,	4096,	103,	78,	51,	27,	2 },
 #endif
 
 	/* x^64 + x^52 + x^39 + x^26 + x^14 + x + 1 -- 15 */
-	{ 64,	52,	39,	26,	14,	1 },
+	{ 64,	2048,	52,	39,	26,	14,	1 },
 
 	/* x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 -- 15 */
-	{ 32,	26,	20,	14,	7,	1 },
+	{ 32,	1024,	26,	20,	14,	7,	1 },
+
+	{ 0,	0,	0,	0,	0,	0,	0 },
+};
 
-	{ 0, 	0,	0,	0,	0,	0 },
-};		
-	
 /*
  * For the purposes of better mixing, we use the CRC-32 polynomial as
  * well to make a twisted Generalized Feedback Shift Reigster
@@ -461,6 +459,12 @@
 }
 #endif
 
+#if 0
+#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
+#else
+#define DEBUG_ENT(fmt, arg...) do {} while (0)
+#endif
+
 /**********************************************************************
  *
  * OS independent entropy store.   Here are the functions which handle
@@ -545,18 +549,19 @@
  * the entropy is concentrated in the low-order bits.
  */
 static void add_entropy_words(struct entropy_store *r, const __u32 *in,
-			     int num)
+			      int nwords)
 {
 	static __u32 const twist_table[8] = {
 		         0, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
 	unsigned i;
 	int new_rotate;
+	int wordmask = r->poolinfo.poolwords - 1;
 	__u32 w;
 
-	while (num--) {
+	while (nwords--) {
 		w = rotate_left(r->input_rotate, *in);
-		i = r->add_ptr = (r->add_ptr - 1) & (r->poolinfo.poolwords-1);
+		i = r->add_ptr = (r->add_ptr - 1) & wordmask;
 		/*
 		 * Normally, we add 7 bits of rotation to the pool.
 		 * At the beginning of the pool, add an extra 7 bits
@@ -569,11 +574,11 @@
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
@@ -582,16 +587,22 @@
 /*
  * Credit (or debit) the entropy store with n bits of entropy
  */
-static void credit_entropy_store(struct entropy_store *r, int num)
+static void credit_entropy_store(struct entropy_store *r, int nbits)
 {
-	int	max_entropy = r->poolinfo.poolwords*32;
-
-	if (r->entropy_count + num < 0)
+	if (r->entropy_count + nbits < 0) {
+		DEBUG_ENT("negative entropy/overflow (%d+%d)\n",
+			  r->entropy_count, nbits);
 		r->entropy_count = 0;
-	else if (r->entropy_count + num > max_entropy)
-		r->entropy_count = max_entropy;
-	else
-		r->entropy_count = r->entropy_count + num;
+	} else if (r->entropy_count + nbits > r->poolinfo.poolbits) {
+		r->entropy_count = r->poolinfo.poolbits;
+	} else {
+		r->entropy_count += nbits;
+		if (nbits)
+			DEBUG_ENT("%s added %d bits, now %d\n",
+				  r == sec_random_state ? "secondary" :
+				  r == random_state ? "primary" : "unknown",
+				  nbits, r->entropy_count);
+	}
 }
 
 /**********************************************************************
@@ -627,6 +638,12 @@
 	return 0;
 }
 
+/*
+ * Changes to the entropy data is put into a queue rather than being added to
+ * the entropy counts directly.  This is presumably to avoid doing heavy
+ * hashing calculations during an interrupt in add_timer_randomness().
+ * Instead, the entropy is only added to the pool once per timer tick.
+ */
 void batch_entropy_store(u32 a, u32 b, int num)
 {
 	int	new;
@@ -643,32 +660,33 @@
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
-	int	num = 0;
-	int	max_entropy;
 	struct entropy_store *r	= (struct entropy_store *) private_, *p;
-	
+
 	if (!batch_max)
 		return;
 
-	max_entropy = r->poolinfo.poolwords*32;
+	p = r;
 	while (batch_head != batch_tail) {
+		if (r->entropy_count >= r->poolinfo.poolbits) {
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
 
@@ -1210,14 +1228,26 @@
 {
 	__u32	tmp[TMP_BUF_SIZE];
 
-	if (r->entropy_count < nbytes*8) {
-		extract_entropy(random_state, tmp, sizeof(tmp), 0);
-		add_entropy_words(r, tmp, TMP_BUF_SIZE);
-		credit_entropy_store(r, TMP_BUF_SIZE*8);
+	if (r->entropy_count < nbytes * 8 &&
+	    r->entropy_count < r->poolinfo.poolbits) {
+		int nwords = MIN(r->poolinfo.poolwords - r->entropy_count/32,
+				 sizeof(tmp) / 4);
+
+		DEBUG_ENT("xfer %d from primary to %s (have %d need %d)\n",
+			  nwords * 32,
+			  r == sec_random_state ? "secondary" : "unknown",
+			  r->entropy_count, nbytes * 8);
+
+		extract_entropy(random_state, tmp, nwords, 0);
+		add_entropy_words(r, tmp, nwords);
+		credit_entropy_store(r, nwords * 32);
 	}
 	if (r->extract_count > 1024) {
+		DEBUG_ENT("reseeding %s with %d from primary\n",
+			  r == sec_random_state ? "secondary" : "unknown",
+			  sizeof(tmp) * 8);
 		extract_entropy(random_state, tmp, sizeof(tmp), 0);
-		add_entropy_words(r, tmp, TMP_BUF_SIZE);
+		add_entropy_words(r, tmp, sizeof(tmp) / 4);
 		r->extract_count = 0;
 	}
 }
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
@@ -1240,14 +1273,19 @@
 	__u32 x;
 
 	add_timer_randomness(&extract_timer_state, nbytes);
-	
+
 	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo.poolwords) 
-		r->entropy_count = r->poolinfo.poolwords;
+	if (r->entropy_count > r->poolinfo.poolbits)
+		r->entropy_count = r->poolinfo.poolbits;
 
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
@@ -1543,9 +1581,7 @@
 		c -= bytes;
 		p += bytes;
 
-		/* Convert bytes to words */
-		bytes = (bytes + 3) / sizeof(__u32);
-		add_entropy_words(random_state, buf, bytes);
+		add_entropy_words(random_state, buf, (bytes + 3) / 4);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1589,7 +1625,7 @@
 		ent_count = random_state->entropy_count;
 		if (put_user(ent_count, p++))
 			return -EFAULT;
-			
+
 		if (get_user(size, p))
 			return -EFAULT;
 		if (put_user(random_state->poolinfo.poolwords, p++))
@@ -1598,7 +1634,7 @@
 			return -EINVAL;
 		if (size > random_state->poolinfo.poolwords)
 			size = random_state->poolinfo.poolwords;
-		if (copy_to_user(p, random_state->pool, size*sizeof(__u32)))
+		if (copy_to_user(p, random_state->pool, size * 4))
 			return -EFAULT;
 		return 0;
 	case RNDADDENTROPY:
@@ -1845,8 +1881,7 @@
 {
 	min_read_thresh = 8;
 	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh =
-		random_state->poolinfo.poolwords * 32;
+	max_read_thresh = max_write_thresh = random_state->poolinfo.poolbits;
 	random_table[1].data = &random_state->entropy_count;
 }
 #endif 	/* CONFIG_SYSCTL */
@@ -2238,4 +2273,5 @@
 EXPORT_SYMBOL(add_interrupt_randomness);
 EXPORT_SYMBOL(add_blkdev_randomness);
 EXPORT_SYMBOL(batch_entropy_store);
+EXPORT_SYMBOL(generate_random_uuid);
 
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

