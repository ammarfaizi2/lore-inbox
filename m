Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277900AbRJSXBV>; Fri, 19 Oct 2001 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRJSXBN>; Fri, 19 Oct 2001 19:01:13 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:22525 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277900AbRJSXA6>; Fri, 19 Oct 2001 19:00:58 -0400
Date: Fri, 19 Oct 2001 16:59:57 -0600
From: Andreas Dilger <adilger@turbolabs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: /dev/random entropy calculations broken?
Message-ID: <20011019165957.N402@turbolinux.com>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <1001461026.9352.156.camel@phantasy> <9or70g$i59$1@abraham.cs.berkeley.edu> <tgadzbr8kq.fsf@mercury.rus.uni-stuttgart.de> <20011001105927.A22795@turbolinux.com> <20011002015114.A24826@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011002015114.A24826@turbolinux.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never heard back from Ted on this issue, but it is plain to see that
entropy accounting for /dev/random is broken.  Linus, Alan, please apply
the new patch.

Testing for broken entropy accounting (in kernel debugging verifies this):

$cat /proc/sys/kernel/random/entropy_count	# current entropy count in bits
4096
$dd if=/dev/random bs=64 count=1 | wc -c	# should get 64 bytes back, and
1+0 records in					# reduce entropy count by 512
1+0 records out
     64
$cat /proc/sys/kernel/random/entropy_count	# the entropy is all gone!
81
$dd if=/dev/random bs=64 count=1 | wc -c	# we don't get 64 bytes back
0+1 records in
0+1 records out
     24


In my testing, the second "dd" returns a short read because the entropy has
disappeared because of bad accounting.

Attached are two patches - the first corrects the real bugs in the accounting,
and the second updates comments, cleans up the code a bit (no functional
changes just debugging and clarifying where we are using bits/bytes/ words
as quantities, which was the source of the original bug), removes some
extraneous whitespace, etc.

Note that I have NOT changed anything in the way that random data values are
calculated in either patch, only making the "accounting" of the entropy sane.

Cheers, Andreas

On Oct 02, 2001  01:51 -0600, adilger wrote:
> OK, after going through the code carefully, it appears that there are
> several big problems in entropy accounting in drivers/char/random.c
> which essentially mean that any time we read /dev/random or /dev/urandom
> or /proc/sys/kernel/random/uuid we would entirely deplete the entropy pool.
> 
> While this in itself is not a security problem (i.e. we discard huge
> amounts of entropy on each operation) it could be a problem for systems
> that are entropy poor and don't want it wasted.
> 
> 
> The below patch fixes these problems, at least to be sane in regards
> to accounting of entropy in the system.  There are still some issues
> to be discussed however.  Patch hunk descriptions with severity of bug:
> 
> First fix (small): in batch_entropy_process() if the store had the maximum
>   amount of entropy, the remaining entropy _appeared_ that it should go
>   into the secondary store.  However, the test "entropy_count > max_entropy"
>   could never be true (entropy_count is clamped in credit_entropy_store()).
>   Fixed so we add entropy to secondary store until it is also full, and
>   then alternate stirring in values into both stores (accumulates more
>   entropy, and adds more randomness even if we don't account for entropy).
> 
> Second fix (small): in batch_entropy_process() IF we switched to adding
>   entropy to the secondary store, we credited this store with entropy
>   that was actually added to the first store.  Also in this case we only
>   woke up a reader if the _secondary_ store had enough entropy, and not
>   it the _primary_ store had enough entropy (which is much more likely,
>   since we are adding entropy to the primary store first).
> 
> Third fix (small): in xfer_secondary_pool() we extract entropy from the
>   primary pool to add to the secondary pool, even if the secondary pool
>   is already full, if we make a large request.  The pool will be refilled
>   anyways because it will be depleted after this action.  We now only
>   refill the secondary pool if it is not already full (saving entropy).
> 
> Fourth fix (medium): in xfer_secondary_pool() we credit the secondary pool
>   with the correct number of BITS taken from the primary pool(*).  We were
>   adding 1/4 of the number of bits taken from the primary to the secondary,
>   and losing the other 3/4 of the entropy (byte/word mismatch?)(**).
> 
> Fifth fix (LARGE): in extract_entropy() the "redundant but just in case"
>   check was wrong, comparing entropy BITS and pool WORDS.  This had
>   the effect of losing 31/32 of the random pool each access.  BAD program!
> 
> 
> (*) It is my assumption that if you extract N bits of entropy from one
>     pool, you add N bits into the other pool.  If this isn't true, then
>     something needs to be fixed elsewhere.  I believe the problem is
>     that extract_entropy() returns "nbytes" of data regardless of how
>     much real entropy is in the pool, hence "creating" entropy where
>     there was none in xfer_secondary_pool().  Either we should return
>     the REAL amount of entropy backed data (and fix the urandom return
>     values), or figure out some way to credit the secondary pool with
>     only as much entropy as is really available.
> 
> (**) When using the SHA hash, we extract 5+80 words = 2720 bits from the
>     primary pool and "add" it to the secondary pool.  However, the
>     secondary pool is only 1024 bits in size, so we throw half of this
>     entropy away each time (including extra CPU overhead).  Should we
>     fix the secondary pool to be at least TMP_BUF_SIZE to hold this data?

===========================================================================
--- linux.orig/drivers/char/random.c	Tue Jul 10 17:05:24 2001
+++ linux/drivers/char/random.c	Fri Oct 19 14:41:07 2001
@@ -321,9 +325,12 @@
 	/* x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 -- 15 */
 	{ 32,	26,	20,	14,	7,	1 },
 
-	{ 0, 	0,	0,	0,	0,	0 },
-};		
-	
+	{ 0,	0,	0,	0,	0,	0 },
+};
+
+#define POOLBITS	poolwords*32
+#define POOLBYTES	poolwords*4
+
 /*
  * For the purposes of better mixing, we use the CRC-32 polynomial as
  * well to make a twisted Generalized Feedback Shift Reigster
@@ -461,6 +468,12 @@
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
@@ -649,26 +673,31 @@
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
+	int max_entropy = r->poolinfo.POOLBITS;
+
 	if (!batch_max)
 		return;
 
-	max_entropy = r->poolinfo.poolwords*32;
+	p = r;
 	while (batch_head != batch_tail) {
+		if (r->entropy_count >= max_entropy) {
+			r = (r == sec_random_state) ?	random_state :
+							sec_random_state;
+			max_entropy = r->poolinfo.POOLBITS;
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
 
@@ -1210,14 +1239,26 @@
 {
 	__u32	tmp[TMP_BUF_SIZE];
 
-	if (r->entropy_count < nbytes*8) {
-		extract_entropy(random_state, tmp, sizeof(tmp), 0);
-		add_entropy_words(r, tmp, TMP_BUF_SIZE);
-		credit_entropy_store(r, TMP_BUF_SIZE*8);
+	if (r->entropy_count < nbytes * 8 &&
+	    r->entropy_count < r->poolinfo.POOLBITS) {
+		int nwords = min(r->poolinfo.poolwords - r->entropy_count/32,
+				 sizeof(tmp) / 4);
+
+		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
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
@@ -1240,10 +1284,10 @@
 	__u32 x;
 
 	add_timer_randomness(&extract_timer_state, nbytes);
-	
+
 	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo.poolwords) 
-		r->entropy_count = r->poolinfo.poolwords;
+	if (r->entropy_count > r->poolinfo.POOLBITS)
+		r->entropy_count = r->poolinfo.POOLBITS;
 
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
 		xfer_secondary_pool(r, nbytes);
@@ -2238,4 +2284,5 @@
 EXPORT_SYMBOL(add_interrupt_randomness);
 EXPORT_SYMBOL(add_blkdev_randomness);
 EXPORT_SYMBOL(batch_entropy_store);
+EXPORT_SYMBOL(generate_random_uuid);
 
===========================================================================
--- linux.orig/drivers/char/random.c	Tue Jul 10 17:05:24 2001
+++ linux/drivers/char/random.c	Fri Oct 19 14:41:07 2001
@@ -164,25 +164,32 @@
  * sequence: 
  *
  *	echo "Initializing random number generator..."
- * 	random_seed=/var/run/random-seed
+ *	random_seed=/var/run/random-seed
  *	# Carry a random seed from start-up to start-up
- *	# Load and then save 512 bytes, which is the size of the entropy pool
- * 	if [ -f $random_seed ]; then
+ *	# Load and then save the whole entropy pool
+ *	if [ -f $random_seed ]; then
  *		cat $random_seed >/dev/urandom
- * 	fi
- *	dd if=/dev/urandom of=$random_seed count=1
- * 	chmod 600 $random_seed
+ *	else
+ *		touch $random_seed
+ *	fi
+ *	chmod 600 $random_seed
+ *	poolfile=/proc/sys/kernel/random/poolsize
+ *	[ -r $poolfile ] && bytes=`cat $poolfile` || bytes=512
+ *	dd if=/dev/urandom of=$random_seed count=1 bs=bytes
  *
  * and the following lines in an appropriate script which is run as
  * the system is shutdown:
- * 
+ *
  *	# Carry a random seed from shut-down to start-up
- *	# Save 512 bytes, which is the size of the entropy pool
+ *	# Save the whole entropy pool
  *	echo "Saving random seed..."
- * 	random_seed=/var/run/random-seed
- *	dd if=/dev/urandom of=$random_seed count=1
- * 	chmod 600 $random_seed
- * 
+ *	random_seed=/var/run/random-seed
+ *	touch $random_seed
+ *	chmod 600 $random_seed
+ *	poolfile=/proc/sys/kernel/random/poolsize
+ *	[ -r $poolfile ] && bytes=`cat $poolfile` || bytes=512
+ *	dd if=/dev/urandom of=$random_seed count=1 bs=bytes
+ *
  * For example, on most modern systems using the System V init
  * scripts, such code fragments would be found in
  * /etc/rc.d/init.d/random.  On older Linux systems, the correct script
@@ -272,8 +279,8 @@
 static int random_write_wakeup_thresh = 128;
 
 /*
- * A pool of size POOLWORDS is stirred with a primitive polynomial
- * of degree POOLWORDS over GF(2).  The taps for various sizes are
+ * A pool of size .poolwords is stirred with a primitive polynomial
+ * of degree .poolwords over GF(2).  The taps for various sizes are
  * defined below.  They are chosen to be evenly spaced (minimum RMS
  * distance from evenly spaced; the numbers in the comments are a
  * scaled squared error sum) except for the last tap, which is 1 to
@@ -284,19 +291,17 @@
 	int	tap1, tap2, tap3, tap4, tap5;
 } poolinfo_table[] = {
 	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
-	{ 2048,	1638,	1231,	819, 	411,	1 },
+	{ 2048,	1638,	1231,	819,	411,	1 },
 
 	/* x^1024 + x^817 + x^615 + x^412 + x^204 + x + 1 -- 290 */
-	{ 1024,	817, 	615,	412,	204,	1 },
-
+	{ 1024,	817,	615,	412,	204,	1 },
 #if 0				/* Alternate polynomial */
 	/* x^1024 + x^819 + x^616 + x^410 + x^207 + x^2 + 1 -- 115 */
 	{ 1024,	819,	616,	410,	207,	2 },
 #endif
-	
+
 	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
 	{ 512,	411,	308,	208,	104,	1 },
-
 #if 0				/* Alternates */
 	/* x^512 + x^409 + x^307 + x^206 + x^102 + x^2 + 1 -- 95 */
 	{ 512,	409,	307,	206,	102,	2 },
@@ -306,10 +311,9 @@
 
 	/* x^256 + x^205 + x^155 + x^101 + x^52 + x + 1 -- 125 */
 	{ 256,	205,	155,	101,	52,	1 },
-	
+
 	/* x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 -- 105 */
 	{ 128,	103,	76,	51,	25,	1 },
-
 #if 0	/* Alternate polynomial */
 	/* x^128 + x^103 + x^78 + x^51 + x^27 + x^2 + 1 -- 70 */
 	{ 128,	103,	78,	51,	27,	2 },
@@ -480,7 +493,7 @@
 /*
  * Initialize the entropy store.  The input argument is the size of
  * the random pool.
- * 
+ *
  * Returns an negative error if there is a problem.
  */
 static int create_entropy_store(int size, struct entropy_store **ret_bucket)
@@ -507,12 +520,12 @@
 	memset (r, 0, sizeof(struct entropy_store));
 	r->poolinfo = *p;
 
-	r->pool = kmalloc(poolwords*4, GFP_KERNEL);
+	r->pool = kmalloc(POOLBYTES, GFP_KERNEL);
 	if (!r->pool) {
 		kfree(r);
 		return -ENOMEM;
 	}
-	memset(r->pool, 0, poolwords*4);
+	memset(r->pool, 0, POOLBYTES);
 	*ret_bucket = r;
 	return 0;
 }
@@ -524,7 +537,7 @@
 	r->entropy_count = 0;
 	r->input_rotate = 0;
 	r->extract_count = 0;
-	memset(r->pool, 0, r->poolinfo.poolwords*4);
+	memset(r->pool, 0, r->poolinfo.POOLBYTES);
 }
 
 static void free_entropy_store(struct entropy_store *r)
@@ -545,18 +558,19 @@
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
@@ -569,11 +583,11 @@
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
@@ -582,16 +596,22 @@
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
+	} else if (r->entropy_count + nbits > r->poolinfo.POOLBITS) {
+		r->entropy_count = r->poolinfo.POOLBITS;
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
@@ -627,6 +647,12 @@
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
@@ -643,9 +669,7 @@
 		queue_task(&batch_tqueue, &tq_timer);
 		batch_head = new;
 	} else {
-#if 0
-		printk(KERN_NOTICE "random: batch entropy buffer full\n");
-#endif
+		DEBUG_ENT("batch entropy buffer full\n");
 	}
 }
 
@@ -1200,9 +1229,9 @@
 
 /*
  * This utility inline function is responsible for transfering entropy
- * from the primary pool to the secondary extraction pool.  We pull 
- * randomness under two conditions; one is if there isn't enough entropy 
- * in the secondary pool.  The other is after we have extract 1024 bytes,
+ * from the primary pool to the secondary extraction pool.  We pull
+ * randomness under two conditions; one is if there isn't enough entropy
+ * in the secondary pool.  The other is after we have extracted 1024 bytes,
  * at which point we do a "catastrophic reseeding".
  */
 static inline void xfer_secondary_pool(struct entropy_store *r,
@@ -1228,9 +1269,12 @@
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
@@ -1248,6 +1292,11 @@
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
@@ -1543,9 +1592,7 @@
 		c -= bytes;
 		p += bytes;
 
-		/* Convert bytes to words */
-		bytes = (bytes + 3) / sizeof(__u32);
-		add_entropy_words(random_state, buf, bytes);
+		add_entropy_words(random_state, buf, (bytes + 3) / 4);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1589,7 +1636,7 @@
 		ent_count = random_state->entropy_count;
 		if (put_user(ent_count, p++))
 			return -EFAULT;
-			
+
 		if (get_user(size, p))
 			return -EFAULT;
 		if (put_user(random_state->poolinfo.poolwords, p++))
@@ -1598,7 +1645,7 @@
 			return -EINVAL;
 		if (size > random_state->poolinfo.poolwords)
 			size = random_state->poolinfo.poolwords;
-		if (copy_to_user(p, random_state->pool, size*sizeof(__u32)))
+		if (copy_to_user(p, random_state->pool, size * 4))
 			return -EFAULT;
 		return 0;
 	case RNDADDENTROPY:
@@ -1715,11 +1762,11 @@
 {
 	int	ret;
 
-	sysctl_poolsize = random_state->poolinfo.poolwords * 4;
+	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
 
 	ret = proc_dointvec(table, write, filp, buffer, lenp);
 	if (ret || !write ||
-	    (sysctl_poolsize == random_state->poolinfo.poolwords * 4))
+	    (sysctl_poolsize == random_state->poolinfo.POOLBYTES))
 		return ret;
 
 	return change_poolsize(sysctl_poolsize);
@@ -1731,7 +1778,7 @@
 {
 	int	len;
 	
-	sysctl_poolsize = random_state->poolinfo.poolwords * 4;
+	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
 
 	/*
 	 * We only handle the write case, since the read case gets
@@ -1746,7 +1793,7 @@
 			return -EFAULT;
 	}
 
-	if (sysctl_poolsize != random_state->poolinfo.poolwords * 4)
+	if (sysctl_poolsize != random_state->poolinfo.POOLBYTES)
 		return change_poolsize(sysctl_poolsize);
 
 	return 0;
@@ -1845,8 +1892,7 @@
 {
 	min_read_thresh = 8;
 	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh =
-		random_state->poolinfo.poolwords * 32;
+	max_read_thresh = max_write_thresh = random_state->poolinfo.POOLBITS;
 	random_table[1].data = &random_state->entropy_count;
 }
 #endif 	/* CONFIG_SYSCTL */

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

