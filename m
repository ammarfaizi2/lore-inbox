Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272272AbTHIHp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 03:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272274AbTHIHp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 03:45:29 -0400
Received: from waste.org ([209.173.204.2]:2223 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272272AbTHIHpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 03:45:12 -0400
Date: Sat, 9 Aug 2003 02:44:59 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au, davem@redhat.com
Subject: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030809074459.GQ31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached (lightly tested) patch gets rid of the SHA in the
/dev/random code and replaces it with cryptoapi, leaving us with just
one SHA implementation. It also updates syncookies. This code is
already at about 125% of baseline throughput, and can probably reach
250% with some tweaking of cryptoapi's redundant padding (in case
anyone else cares about being able to get 120Mb/s of cryptographically
strong random data).

The potentially controversial part is that the random driver is
currently non-optional and this patch would make cryptoapi
non-optional as well. I plan to cryptoapi-ify the outstanding
MD5 instance as well.

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-08-08 11:14:15.000000000 -0500
+++ work/drivers/char/random.c	2003-08-08 16:40:30.000000000 -0500
@@ -249,11 +249,13 @@
 #include <linux/genhd.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/crypto.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/io.h>
+#include <asm/scatterlist.h>
 
 /*
  * Configuration information
@@ -772,122 +774,6 @@
 	add_timer_randomness(disk->random, 0x100+MKDEV(disk->major, disk->first_minor));
 }
 
-/******************************************************************
- *
- * Hash function definition
- *
- *******************************************************************/
-
-/*
- * This chunk of code defines a function
- * void SHATransform(__u32 digest[HASH_BUFFER_SIZE + HASH_EXTRA_SIZE],
- * 		__u32 const data[16])
- * 
- * The function hashes the input data to produce a digest in the first
- * HASH_BUFFER_SIZE words of the digest[] array, and uses HASH_EXTRA_SIZE
- * more words for internal purposes.  (This buffer is exported so the
- * caller can wipe it once rather than this code doing it each call,
- * and tacking it onto the end of the digest[] array is the quick and
- * dirty way of doing it.)
- *
- * For /dev/random purposes, the length of the data being hashed is
- * fixed in length, so appending a bit count in the usual way is not
- * cryptographically necessary.
- */
-
-#define HASH_BUFFER_SIZE 5
-#define HASH_EXTRA_SIZE 80
-
-/*
- * SHA transform algorithm, taken from code written by Peter Gutmann,
- * and placed in the public domain.
- */
-
-/* The SHA f()-functions.  */
-
-#define f1(x,y,z)   ( z ^ (x & (y^z)) )		/* Rounds  0-19: x ? y : z */
-#define f2(x,y,z)   (x ^ y ^ z)			/* Rounds 20-39: XOR */
-#define f3(x,y,z)   ( (x & y) + (z & (x ^ y)) )	/* Rounds 40-59: majority */
-#define f4(x,y,z)   (x ^ y ^ z)			/* Rounds 60-79: XOR */
-
-/* The SHA Mysterious Constants */
-
-#define K1  0x5A827999L			/* Rounds  0-19: sqrt(2) * 2^30 */
-#define K2  0x6ED9EBA1L			/* Rounds 20-39: sqrt(3) * 2^30 */
-#define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
-#define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
-
-#define ROTL(n,X)  ( ( ( X ) << n ) | ( ( X ) >> ( 32 - n ) ) )
-
-#define subRound(a, b, c, d, e, f, k, data) \
-    ( e += ROTL( 5, a ) + f( b, c, d ) + k + data, b = ROTL( 30, b ) )
-
-
-static void SHATransform(__u32 digest[85], __u32 const data[16])
-{
-    __u32 A, B, C, D, E;     /* Local vars */
-    __u32 TEMP;
-    int	i;
-#define W (digest + HASH_BUFFER_SIZE)	/* Expanded data array */
-
-    /*
-     * Do the preliminary expansion of 16 to 80 words.  Doing it
-     * out-of-line line like this is faster than doing it in-line on
-     * register-starved machines like the x86, and not really any
-     * slower on real processors.
-     */
-    memcpy(W, data, 16*sizeof(__u32));
-    for (i = 0; i < 64; i++) {
-	    TEMP = W[i] ^ W[i+2] ^ W[i+8] ^ W[i+13];
-	    W[i+16] = ROTL(1, TEMP);
-    }
-
-    /* Set up first buffer and local data buffer */
-    A = digest[ 0 ];
-    B = digest[ 1 ];
-    C = digest[ 2 ];
-    D = digest[ 3 ];
-    E = digest[ 4 ];
-
-    /* Heavy mangling, in 4 sub-rounds of 20 iterations each. */
-    for (i = 0; i < 80; i++) {
-	if (i < 40) {
-	    if (i < 20)
-		TEMP = f1(B, C, D) + K1;
-	    else
-		TEMP = f2(B, C, D) + K2;
-	} else {
-	    if (i < 60)
-		TEMP = f3(B, C, D) + K3;
-	    else
-		TEMP = f4(B, C, D) + K4;
-	}
-	TEMP += ROTL(5, A) + E + W[i];
-	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
-    }
-
-    /* Build message digest */
-    digest[ 0 ] += A;
-    digest[ 1 ] += B;
-    digest[ 2 ] += C;
-    digest[ 3 ] += D;
-    digest[ 4 ] += E;
-
-	/* W is wiped by the caller */
-#undef W
-}
-
-#undef ROTL
-#undef f1
-#undef f2
-#undef f3
-#undef f4
-#undef K1	
-#undef K2
-#undef K3	
-#undef K4	
-#undef subRound
-
 /*********************************************************************
  *
  * Entropy extraction routines
@@ -896,8 +782,6 @@
 
 #define EXTRACT_ENTROPY_USER		1
 #define EXTRACT_ENTROPY_LIMIT		2
-#define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
-#define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
 			       size_t nbytes, int flags);
@@ -909,7 +793,7 @@
  */
 static void reseed_pool(struct entropy_store *r, int margin, int wanted)
 {
-	__u32 tmp[TMP_BUF_SIZE];
+	__u32 tmp[32]; /* 256 bits */
 	int bytes;
 
 	DEBUG_ENT("reseed %s wants %d bits (margin %d)\n",
@@ -944,14 +828,11 @@
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
 			       size_t nbytes, int flags)
 {
-	ssize_t ret, i;
-	__u32 tmp[TMP_BUF_SIZE];
-	__u32 x;
+	ssize_t ret, i, x;
 	unsigned long cpuflags;
-
-	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo->POOLBITS)
-		r->entropy_count = r->poolinfo->POOLBITS;
+	struct crypto_tfm *tfm;
+	struct scatterlist sg[1];
+	__u32 hash[5]; /* 160 bits */
 
 	/* Hold lock while accounting */
 	spin_lock_irqsave(&r->lock, cpuflags);
@@ -975,6 +856,9 @@
 	spin_unlock_irqrestore(&r->lock, cpuflags);
 
 	ret = 0;
+
+	tfm = crypto_alloc_tfm("sha1", 0);
+
 	while (nbytes) {
 		/*
 		 * Check if we need to break out or reschedule....
@@ -987,19 +871,10 @@
 			}
 
 			DEBUG_ENT("extract sleep (%d bytes left)\n", nbytes);
-
 			schedule();
-
 			DEBUG_ENT("extract wake\n");
 		}
 
-		/* Hash the pool to get the output */
-		tmp[0] = 0x67452301;
-		tmp[1] = 0xefcdab89;
-		tmp[2] = 0x98badcfe;
-		tmp[3] = 0x10325476;
-		tmp[4] = 0xc3d2e1f0;
-
 		/*
 		 * As we hash the pool, we mix intermediate values of
 		 * the hash back into the pool.  This eliminates
@@ -1008,40 +883,40 @@
 		 * attempts to find previous ouputs), unless the hash
 		 * function can be inverted.
 		 */
+
 		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
-			SHATransform(tmp, r->pool+i);
-			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
+			sg[0].page = virt_to_page(r->pool+i);
+			sg[0].offset = ((long)(r->pool+i) & ~PAGE_MASK);
+			sg[0].length = 64;
+			crypto_digest_digest(tfm, sg, 1, (char *)hash);
+			add_entropy_words(r, &hash[x%20], 1);
 		}
 		
 		/*
 		 * In case the hash function has some recognizable
 		 * output pattern, we fold it in half.
 		 */
-		for (i = 0; i <  HASH_BUFFER_SIZE/2; i++)
-			tmp[i] ^= tmp[i + (HASH_BUFFER_SIZE+1)/2];
-#if HASH_BUFFER_SIZE & 1	/* There's a middle word to deal with */
-		x = tmp[HASH_BUFFER_SIZE/2];
-		x ^= (x >> 16);		/* Fold it in half */
-		((__u16 *)tmp)[HASH_BUFFER_SIZE-1] = (__u16)x;
-#endif
+		hash[0] ^= hash[3];
+		hash[1] ^= hash[4];
 		
 		/* Copy data to destination buffer */
-		i = min(nbytes, HASH_BUFFER_SIZE*sizeof(__u32)/2);
+		i = min(nbytes, sizeof(hash)/2);
 		if (flags & EXTRACT_ENTROPY_USER) {
-			i -= copy_to_user(buf, (__u8 const *)tmp, i);
+			i -= copy_to_user(buf, (__u8 const *)hash, i);
 			if (!i) {
 				ret = -EFAULT;
 				break;
 			}
 		} else
-			memcpy(buf, (__u8 const *)tmp, i);
+			memcpy(buf, (__u8 const *)hash, i);
 		nbytes -= i;
 		buf += i;
 		ret += i;
 	}
 
 	/* Wipe data just returned from memory */
-	memset(tmp, 0, sizeof(tmp));
+	memset(hash, 0, sizeof(hash));
+	crypto_free_tfm(tfm);
 	
 	return ret;
 }
@@ -1160,15 +1035,10 @@
 static ssize_t
 random_read(struct file * file, char * buf, size_t nbytes, loff_t *ppos)
 {
-	ssize_t			n, retval = 0, count = 0;
+	ssize_t	n, retval = 0, count = 0;
 	
-	if (nbytes == 0)
-		return 0;
-
 	while (nbytes > 0) {
-		n = nbytes;
-		if (n > SEC_XFER_SIZE)
-			n = SEC_XFER_SIZE;
+		n = min_t(size_t, nbytes, BLOCKING_POOL_SIZE/8);
 
 		/* We can take all the entropy in the input pool */
 		reseed_pool(blocking_pool, 0, n);
@@ -1846,13 +1716,16 @@
 #define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
 
 static int	syncookie_init;
-static __u32	syncookie_secret[2][16-3+HASH_BUFFER_SIZE];
+static __u32	syncookie_secret[2][16-3];
 
 __u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
 		__u16 dport, __u32 sseq, __u32 count, __u32 data)
 {
-	__u32 	tmp[16 + HASH_BUFFER_SIZE + HASH_EXTRA_SIZE];
-	__u32	seq;
+	__u32 tmp[16]; /* 512 bits */
+	__u32 hash[5]; /* 160 bits */
+	__u32 seq;
+	struct crypto_tfm *tfm;
+	struct scatterlist sg[1];
 
 	/*
 	 * Pick two random secrets the first time we need a cookie.
@@ -1873,22 +1746,27 @@
 	 * MSS into the second hash value.
 	 */
 
-	memcpy(tmp+3, syncookie_secret[0], sizeof(syncookie_secret[0]));
+	sg[0].page = virt_to_page(tmp);
+	sg[0].offset = ((long) tmp & ~PAGE_MASK);
+	sg[0].length = sizeof(tmp);
+
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	SHATransform(tmp+16, tmp);
-	seq = tmp[17] + sseq + (count << COOKIEBITS);
+
+	memcpy(tmp+3, syncookie_secret[0], sizeof(syncookie_secret[0]));
+	tfm = crypto_alloc_tfm("sha1", 0);
+	crypto_digest_digest(tfm, sg, 1, (char *)hash);
+
+	seq = hash[1] + sseq + (count << COOKIEBITS);
 
 	memcpy(tmp+3, syncookie_secret[1], sizeof(syncookie_secret[1]));
-	tmp[0]=saddr;
-	tmp[1]=daddr;
-	tmp[2]=(sport << 16) + dport;
 	tmp[3] = count;	/* minute counter */
-	SHATransform(tmp+16, tmp);
+	crypto_digest_digest(tfm, sg, 1, (char *)hash);
+	crypto_free_tfm(tfm);
 
 	/* Add in the second hash and the data */
-	return seq + ((tmp[17] + data) & COOKIEMASK);
+	return seq + ((hash[1] + data) & COOKIEMASK);
 }
 
 /*
@@ -1903,19 +1781,29 @@
 __u32 check_tcp_syn_cookie(__u32 cookie, __u32 saddr, __u32 daddr, __u16 sport,
 		__u16 dport, __u32 sseq, __u32 count, __u32 maxdiff)
 {
-	__u32 	tmp[16 + HASH_BUFFER_SIZE + HASH_EXTRA_SIZE];
-	__u32	diff;
+	__u32 tmp[16]; /* 512 bits */
+	__u32 hash[5]; /* 160 bits */
+	__u32 diff;
+	struct crypto_tfm *tfm;
+	struct scatterlist sg[1];
 
 	if (syncookie_init == 0)
 		return (__u32)-1;	/* Well, duh! */
 
-	/* Strip away the layers from the cookie */
-	memcpy(tmp+3, syncookie_secret[0], sizeof(syncookie_secret[0]));
+	sg[0].page = virt_to_page(tmp);
+	sg[0].offset = ((long) tmp & ~PAGE_MASK);
+	sg[0].length = sizeof(tmp);
+
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	SHATransform(tmp+16, tmp);
-	cookie -= tmp[17] + sseq;
+
+	/* Strip away the layers from the cookie */
+	memcpy(tmp+3, syncookie_secret[0], sizeof(syncookie_secret[0]));
+	tfm = crypto_alloc_tfm("sha1", 0);
+	crypto_digest_digest(tfm, sg, 1, (char *)hash);
+
+	cookie -= hash[1] + sseq;
 	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
 
 	diff = (count - (cookie >> COOKIEBITS)) & ((__u32)-1 >> COOKIEBITS);
@@ -1923,13 +1811,11 @@
 		return (__u32)-1;
 
 	memcpy(tmp+3, syncookie_secret[1], sizeof(syncookie_secret[1]));
-	tmp[0] = saddr;
-	tmp[1] = daddr;
-	tmp[2] = (sport << 16) + dport;
 	tmp[3] = count - diff;	/* minute counter */
-	SHATransform(tmp+16, tmp);
+	crypto_digest_digest(tfm, sg, 1, (char *)hash);
+	crypto_free_tfm(tfm);
 
-	return (cookie - tmp[17]) & COOKIEMASK;	/* Leaving the data behind */
+	return (cookie - hash[1]) & COOKIEMASK;	/* Leaving the data behind */
 }
 #endif
 
-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
