Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279018AbRJ2FlH>; Mon, 29 Oct 2001 00:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279022AbRJ2Fk7>; Mon, 29 Oct 2001 00:40:59 -0500
Received: from [63.231.122.81] ([63.231.122.81]:30012 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279019AbRJ2Fkm>;
	Mon, 29 Oct 2001 00:40:42 -0500
Date: Sun, 28 Oct 2001 22:37:54 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix
Message-ID: <20011028223754.G1311@lynx.no>
Mail-Followup-To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <adilger@turbolabs.com> <200110282357.f9SNv2kD011923@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200110282357.f9SNv2kD011923@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sun, Oct 28, 2001 at 08:57:02PM -0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 28, 2001  20:57 -0300, Horst von Brand wrote:
> Andreas Dilger <adilger@turbolabs.com> said:
> > OK, my bad.  At least the random variable-name cleanups let you SEE where
> > we are supposed to be using word sizes and byte sizes.  Even you were
> > confused about it ;-)
> 
> I have now seen various bits and pieces about this flying around. To get it
> right will be hard, as over/under estimates will show up only under unusual
> circumstances; and as you _can't_ really know how much "entropy" there
> should be, testing this is very hard.  So the only way to get it right is
> make it "obviously" right.

Yes, I have suspected the same thing.  When testing these changes, I almost
always got 9-12 bits of entropy per keypress, and hundreds of bits for a
mouse movement.  Granted, it may be reasonable given that I have a TSC,
which implies nearly random low order bits, but you would think that mouse
interrupts are at a fairly standard rate, so should have low entropy?

I left discussion about the actual entropy DATA out of my patch, and
focussed only on getting the accounting right.  We still "discard" some
entropy in places, but it is orders of magnitude smaller than before,
and discarding entropy is not a danger, unless you are forced to use
less-secure data as a result of not having enough entropy.

> How hard would it be to change the API to talk _all_ in the same units, be
> it bits, bytes, words, or whatever? I believe bits or bytes would be best,
> as word sizes differ. Bytes have the advantage that a simple sizeof() will
> give size in bytes for any random variable.

Not too hard (basic patch below).  This has the drawback of passing a
byte count to add_entropy(), but still using a word array for values.
It wouldn't be too hard to change add_entropy() to accept a byte array
(which we cast internally to a word array, don't really care about endian
issues here), and then do something* with any extra bytes.  As it is,
add_entropy() "uses" the unset bytes at the end of the last word if we
are called from random_write().  We also can't make credit_entropy_store()
use bytes as a parameter, so we haven't totally fixed the problem.

(*) I don't know enough about the hash functions to know how to add a
    few odd bytes into the store in a useful and safe way.  We don't
    really want to discard them either - think if a user-space random
    daemon on an otherwise entropy-free system only writes one byte at
    a time...

The second patch (incremental to the first) changes poolwords to poolbytes
in all places, but still doesn't fix add_entropy() to handle a byte array as
input.

Cheers, Andreas
==========================================================================
--- linux.orig/drivers/char/random.c	Thu Oct 25 03:04:34 2001
+++ linux/drivers/char/random.c	Sun Oct 28 21:28:23 2001
@@ -557,13 +553,13 @@
  * it's cheap to do so and helps slightly in the expected case where
  * the entropy is concentrated in the low-order bits.
  */
-static void add_entropy_words(struct entropy_store *r, const __u32 *in,
-			      int nwords)
+static void add_entropy(struct entropy_store *r, const __u32 *in, int nbytes)
 {
 	static __u32 const twist_table[8] = {
 		         0, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
 	unsigned i;
+	int nwords = nbytes / 4;
 	int new_rotate;
 	int wordmask = r->poolinfo.poolwords - 1;
 	__u32 w;
@@ -693,7 +689,7 @@
 							sec_random_state;
 			max_entropy = r->poolinfo.POOLBITS;
 		}
-		add_entropy_words(r, batch_entropy_pool + 2*batch_tail, 2);
+		add_entropy(r, batch_entropy_pool + 2*batch_tail, 8);
 		credit_entropy_store(r, batch_entropy_credit[batch_tail]);
 		batch_tail = (batch_tail+1) & (batch_max-1);
 	}
@@ -1245,24 +1241,24 @@
 
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
-		int nwords = min(r->poolinfo.poolwords - r->entropy_count/32,
-				 sizeof(tmp) / 4);
+		int cbytes = min(r->poolinfo.POOLBYTES - r->entropy_count/8,
+				 sizeof(tmp));
 
 		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
-			  nwords * 32,
+			  cbytes * 8,
 			  r == sec_random_state ? "secondary" : "unknown",
 			  r->entropy_count, nbytes * 8);
 
-		extract_entropy(random_state, tmp, nwords, 0);
-		add_entropy_words(r, tmp, nwords);
-		credit_entropy_store(r, nwords * 32);
+		extract_entropy(random_state, tmp, cbytes, 0);
+		add_entropy(r, tmp, cbytes);
+		credit_entropy_store(r, cbytes * 8);
 	}
 	if (r->extract_count > 1024) {
 		DEBUG_ENT("reseeding %s with %d from primary\n",
 			  r == sec_random_state ? "secondary" : "unknown",
 			  sizeof(tmp) * 8);
 		extract_entropy(random_state, tmp, sizeof(tmp), 0);
-		add_entropy_words(r, tmp, sizeof(tmp) / 4);
+		add_entropy(r, tmp, sizeof(tmp));
 		r->extract_count = 0;
 	}
 }
@@ -1343,7 +1339,7 @@
 		 */
 		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
 			HASH_TRANSFORM(tmp, r->pool+i);
-			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
+			add_entropy(r, &tmp[x%HASH_BUFFER_SIZE], 4);
 		}
 		
 		/*
@@ -1418,7 +1414,7 @@
 	do_gettimeofday(&tv);
 	words[0] = tv.tv_sec;
 	words[1] = tv.tv_usec;
-	add_entropy_words(r, words, 2);
+	add_entropy(r, words, sizeof(words));
 
 	/*
 	 *	This doesn't lock system.utsname. However, we are generating
@@ -1427,7 +1423,7 @@
 	p = (char *) &system_utsname;
 	for (i = sizeof(system_utsname) / sizeof(words); i; i--) {
 		memcpy(words, p, sizeof(words));
-		add_entropy_words(r, words, sizeof(words)/4);
+		add_entropy(r, words, sizeof(words));
 		p += sizeof(words);
 	}
 }
@@ -1596,7 +1591,7 @@
 		c -= bytes;
 		p += bytes;
 
-		add_entropy_words(random_state, buf, (bytes + 3) / 4);
+		add_entropy(random_state, buf, bytes);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1747,8 +1742,8 @@
 	if ((ret = create_entropy_store(poolsize, &new_store)))
 		return ret;
 
-	add_entropy_words(new_store, random_state->pool,
-			  random_state->poolinfo.poolwords);
+	add_entropy(new_store, random_state->pool,
+		    random_state->poolinfo.POOLBYTES);
 	credit_entropy_store(new_store, random_state->entropy_count);
 
 	sysctl_init_random(new_store);
============================================================================
--- linux/drivers/char/random.c~	Sun Oct 28 21:28:23 2001
+++ linux/drivers/char/random.c	Sun Oct 28 21:53:46 2001
@@ -279,57 +279,56 @@
 static int random_write_wakeup_thresh = 128;
 
 /*
- * A pool of size .poolwords is stirred with a primitive polynomial
- * of degree .poolwords over GF(2).  The taps for various sizes are
+ * A pool of size .poolbytes is stirred with a primitive polynomial
+ * of degree .poolbytes over GF(2).  The taps for various sizes are
  * defined below.  They are chosen to be evenly spaced (minimum RMS
  * distance from evenly spaced; the numbers in the comments are a
  * scaled squared error sum) except for the last tap, which is 1 to
  * get the twisting happening as fast as possible.
  */
 static struct poolinfo {
-	int	poolwords;
+	int	poolbytes;
 	int	tap1, tap2, tap3, tap4, tap5;
 } poolinfo_table[] = {
 	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
-	{ 2048,	1638,	1231,	819,	411,	1 },
+	{ 16384, 1638,	1231,	819,	411,	1 },
 
 	/* x^1024 + x^817 + x^615 + x^412 + x^204 + x + 1 -- 290 */
-	{ 1024,	817,	615,	412,	204,	1 },
+	{ 8192,	817,	615,	412,	204,	1 },
 #if 0				/* Alternate polynomial */
 	/* x^1024 + x^819 + x^616 + x^410 + x^207 + x^2 + 1 -- 115 */
-	{ 1024,	819,	616,	410,	207,	2 },
+	{ 8192,	819,	616,	410,	207,	2 },
 #endif
 
 	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
-	{ 512,	411,	308,	208,	104,	1 },
+	{ 4096,	411,	308,	208,	104,	1 },
 #if 0				/* Alternates */
 	/* x^512 + x^409 + x^307 + x^206 + x^102 + x^2 + 1 -- 95 */
-	{ 512,	409,	307,	206,	102,	2 },
+	{ 4096,	409,	307,	206,	102,	2 },
 	/* x^512 + x^409 + x^309 + x^205 + x^103 + x^2 + 1 -- 95 */
-	{ 512,	409,	309,	205,	103,	2 },
+	{ 4096,	409,	309,	205,	103,	2 },
 #endif
 
 	/* x^256 + x^205 + x^155 + x^101 + x^52 + x + 1 -- 125 */
-	{ 256,	205,	155,	101,	52,	1 },
+	{ 2048,	205,	155,	101,	52,	1 },
 
 	/* x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 -- 105 */
-	{ 128,	103,	76,	51,	25,	1 },
+	{ 1024,	103,	76,	51,	25,	1 },
 #if 0	/* Alternate polynomial */
 	/* x^128 + x^103 + x^78 + x^51 + x^27 + x^2 + 1 -- 70 */
-	{ 128,	103,	78,	51,	27,	2 },
+	{ 1024,	103,	78,	51,	27,	2 },
 #endif
 
 	/* x^64 + x^52 + x^39 + x^26 + x^14 + x + 1 -- 15 */
-	{ 64,	52,	39,	26,	14,	1 },
+	{ 512,	52,	39,	26,	14,	1 },
 
 	/* x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 -- 15 */
-	{ 32,	26,	20,	14,	7,	1 },
+	{ 256,	26,	20,	14,	7,	1 },
 
 	{ 0,	0,	0,	0,	0,	0 },
 };
 
-#define POOLBITS	poolwords*32
-#define POOLBYTES	poolwords*4
+#define POOLBITS	poolbytes*8
 
 /*
  * For the purposes of better mixing, we use the CRC-32 polynomial as
@@ -496,17 +495,16 @@
 {
 	struct	entropy_store	*r;
 	struct	poolinfo	*p;
-	int	poolwords;
+	int	poolbytes;
 
-	poolwords = (size + 3) / 4; /* Convert bytes->words */
-	/* The pool size must be a multiple of 16 32-bit words */
-	poolwords = ((poolwords + 15) / 16) * 16; 
+	/* The pool size must be a multiple of 16 32-bit words (64 bytes) */
+	poolbytes = ((poolbytes + 63) / 64) * 64; 
 
-	for (p = poolinfo_table; p->poolwords; p++) {
-		if (poolwords == p->poolwords)
+	for (p = poolinfo_table; p->poolbytes; p++) {
+		if (poolbytes == p->poolbytes)
 			break;
 	}
-	if (p->poolwords == 0)
+	if (p->poolbytes == 0)
 		return -EINVAL;
 
 	r = kmalloc(sizeof(struct entropy_store), GFP_KERNEL);
@@ -516,12 +514,12 @@
 	memset (r, 0, sizeof(struct entropy_store));
 	r->poolinfo = *p;
 
-	r->pool = kmalloc(POOLBYTES, GFP_KERNEL);
+	r->pool = kmalloc(poolbytes, GFP_KERNEL);
 	if (!r->pool) {
 		kfree(r);
 		return -ENOMEM;
 	}
-	memset(r->pool, 0, POOLBYTES);
+	memset(r->pool, 0, poolbytes);
 	*ret_bucket = r;
 	return 0;
 }
@@ -533,7 +531,7 @@
 	r->entropy_count = 0;
 	r->input_rotate = 0;
 	r->extract_count = 0;
-	memset(r->pool, 0, r->poolinfo.POOLBYTES);
+	memset(r->pool, 0, r->poolinfo.poolbytes);
 }
 
 static void free_entropy_store(struct entropy_store *r)
@@ -561,7 +559,7 @@
 	unsigned i;
 	int nwords = nbytes / 4;
 	int new_rotate;
-	int wordmask = r->poolinfo.poolwords - 1;
+	int wordmask = r->poolinfo.poolbytes * 4 - 1;
 	__u32 w;
 
 	while (nwords--) {
@@ -1241,7 +1239,7 @@
 
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
-		int cbytes = min(r->poolinfo.POOLBYTES - r->entropy_count/8,
+		int cbytes = min(r->poolinfo.poolbytes - r->entropy_count/8,
 				 sizeof(tmp));
 
 		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
@@ -1274,7 +1272,8 @@
  * extracting entropy from the secondary pool, and can refill from the
  * primary pool if needed.
  *
- * Note: extract_entropy() assumes that .poolwords is a multiple of 16 words.
+ * Note: extract_entropy() assumes that .poolbytes is a multiple of
+ *       16 32-bit words (64 bytes).
  */
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
 			       size_t nbytes, int flags)
@@ -1337,7 +1336,7 @@
 		 * attempts to find previous ouputs), unless the hash
 		 * function can be inverted.
 		 */
-		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
+		for (i = 0, x = 0; i < r->poolinfo.poolbytes; i += 64, x+=2) {
 			HASH_TRANSFORM(tmp, r->pool+i);
 			add_entropy(r, &tmp[x%HASH_BUFFER_SIZE], 4);
 		}
@@ -1635,13 +1634,14 @@
 		ent_count = random_state->entropy_count;
 		if (put_user(ent_count, p++) ||
 		    get_user(size, p) ||
-		    put_user(random_state->poolinfo.poolwords, p++))
+		    put_user(random_state->poolinfo.poolbytes / 4, p++))
 			return -EFAULT;
+		size *= 4;
 		if (size < 0)
 			return -EINVAL;
-		if (size > random_state->poolinfo.poolwords)
-			size = random_state->poolinfo.poolwords;
-		if (copy_to_user(p, random_state->pool, size * 4))
+		if (size > random_state->poolinfo.poolbytes)
+			size = random_state->poolinfo.poolbytes;
+		if (copy_to_user(p, random_state->pool, size))
 			return -EFAULT;
 		return 0;
 	case RNDADDENTROPY:
@@ -1743,7 +1743,7 @@
 		return ret;
 
 	add_entropy(new_store, random_state->pool,
-		    random_state->poolinfo.POOLBYTES);
+		    random_state->poolinfo.poolbytes);
 	credit_entropy_store(new_store, random_state->entropy_count);
 
 	sysctl_init_random(new_store);
@@ -1758,11 +1758,11 @@
 {
 	int	ret;
 
-	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
+	sysctl_poolsize = random_state->poolinfo.poolbytes;
 
 	ret = proc_dointvec(table, write, filp, buffer, lenp);
 	if (ret || !write ||
-	    (sysctl_poolsize == random_state->poolinfo.POOLBYTES))
+	    (sysctl_poolsize == random_state->poolinfo.poolbytes))
 		return ret;
 
 	return change_poolsize(sysctl_poolsize);
@@ -1774,7 +1774,7 @@
 {
 	int	len;
 	
-	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
+	sysctl_poolsize = random_state->poolinfo.poolbytes;
 
 	/*
 	 * We only handle the write case, since the read case gets
@@ -1789,7 +1789,7 @@
 			return -EFAULT;
 	}
 
-	if (sysctl_poolsize != random_state->poolinfo.POOLBYTES)
+	if (sysctl_poolsize != random_state->poolinfo.poolbytes)
 		return change_poolsize(sysctl_poolsize);
 
 	return 0;
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

