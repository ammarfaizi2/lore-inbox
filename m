Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVASIn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVASIn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVASI1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:27:48 -0500
Received: from waste.org ([216.27.176.166]:30380 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261670AbVASIRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:17:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8.64403262@selenic.com>
Message-Id: <9.64403262@selenic.com>
Subject: [PATCH 8/12] random pt3: Break up extract_user
Date: Wed, 19 Jan 2005 00:17:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Break apart extract_entropy into kernel and user versions, remove last
extract flag and some unnecessary variables. This makes the code more
readable and amenable to sparse.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:39:47.360504569 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:40:00.654809689 -0800
@@ -1183,19 +1183,18 @@
  *
  *********************************************************************/
 
-#define EXTRACT_ENTROPY_USER		1
 #define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int min, int rsvd, int flags);
+			       size_t nbytes, int min, int rsvd);
 
 /*
  * This utility inline function is responsible for transfering entropy
  * from the primary pool to the secondary extraction pool. We make
  * sure we pull enough for a 'catastrophic reseed'.
  */
-static inline void xfer_secondary_pool(struct entropy_store *r,
+static void xfer_secondary_pool(struct entropy_store *r,
 				       size_t nbytes, __u32 *tmp)
 {
 	if (r->pull && r->entropy_count < nbytes * 8 &&
@@ -1209,18 +1208,15 @@
 			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(r->pull, tmp, bytes,
-				      random_read_wakeup_thresh / 8, rsvd, 0);
+				      random_read_wakeup_thresh / 8, rsvd);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
 	}
 }
 
 /*
- * This function extracts randomness from the "entropy pool", and
- * returns it in a buffer.  This function computes how many remaining
- * bits of entropy are left in the pool, but it does not restrict the
- * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
- * flag is given, then the buf pointer is assumed to be in user space.
+ * These functions extracts randomness from the "entropy pool", and
+ * returns it in a buffer.
  *
  * The min parameter specifies the minimum amount we can pull before
  * failing to avoid races that defeat catastrophic reseeding while the
@@ -1229,22 +1225,16 @@
  *
  * Note: extract_entropy() assumes that .poolwords is a multiple of 16 words.
  */
-static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int min, int reserved, int flags)
+
+static size_t account(struct entropy_store *r, size_t nbytes, int min,
+		      int reserved)
 {
-	ssize_t ret, i;
-	__u32 tmp[TMP_BUF_SIZE], data[16];
-	__u32 x;
-	unsigned long cpuflags;
-
-	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo->POOLBITS)
-		r->entropy_count = r->poolinfo->POOLBITS;
+	unsigned long flags;
 
-	xfer_secondary_pool(r, nbytes, tmp);
+	BUG_ON(r->entropy_count > r->poolinfo->POOLBITS);
 
 	/* Hold lock while accounting */
-	spin_lock_irqsave(&r->lock, cpuflags);
+	spin_lock_irqsave(&r->lock, flags);
 
 	DEBUG_ENT("trying to extract %d bits from %s\n",
 		  nbytes * 8, r->name);
@@ -1269,75 +1259,111 @@
 	DEBUG_ENT("debiting %d entropy credits from %s%s\n",
 		  nbytes * 8, r->name, r->limit ? "" : " (unlimited)");
 
-	spin_unlock_irqrestore(&r->lock, cpuflags);
+	spin_unlock_irqrestore(&r->lock, flags);
+
+	return nbytes;
+}
+
+static void extract_buf(struct entropy_store *r, __u32 *buf)
+{
+	int i, x;
+	__u32 data[16];
+
+	/* Hash the pool to get the output */
+	buf[0] = 0x67452301;
+	buf[1] = 0xefcdab89;
+	buf[2] = 0x98badcfe;
+	buf[3] = 0x10325476;
+#ifdef USE_SHA
+	buf[4] = 0xc3d2e1f0;
+#endif
+
+	/*
+	 * As we hash the pool, we mix intermediate values of
+	 * the hash back into the pool.  This eliminates
+	 * backtracking attacks (where the attacker knows
+	 * the state of the pool plus the current outputs, and
+	 * attempts to find previous ouputs), unless the hash
+	 * function can be inverted.
+	 */
+	for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
+		HASH_TRANSFORM(buf, r->pool+i);
+		add_entropy_words(r, &buf[x%HASH_BUFFER_SIZE], 1);
+	}
+
+	/*
+	 * To avoid duplicates, we atomically extract a
+	 * portion of the pool while mixing, and hash one
+	 * final time.
+	 */
+	__add_entropy_words(r, &buf[x%HASH_BUFFER_SIZE], 1, data);
+	HASH_TRANSFORM(buf, data);
+
+	/*
+	 * In case the hash function has some recognizable
+	 * output pattern, we fold it in half.
+	 */
+	for (i = 0; i <  HASH_BUFFER_SIZE / 2; i++)
+		buf[i] ^= buf[i + (HASH_BUFFER_SIZE + 1) / 2];
+
+	if (HASH_BUFFER_SIZE & 1) {
+		/* There's a middle word to deal with */
+		x = buf[HASH_BUFFER_SIZE/2];
+		x ^= (x >> 16);	/* Fold it in half */
+		((__u16 *)buf)[HASH_BUFFER_SIZE - 1] = (__u16)x;
+	}
+}
+
+static ssize_t extract_entropy(struct entropy_store *r, void * buf,
+			       size_t nbytes, int min, int reserved)
+{
+	ssize_t ret = 0, i;
+	__u32 tmp[TMP_BUF_SIZE];
+
+	xfer_secondary_pool(r, nbytes, tmp);
+	nbytes = account(r, nbytes, min, reserved);
 
-	ret = 0;
 	while (nbytes) {
-		/*
-		 * Check if we need to break out or reschedule....
-		 */
-		if ((flags & EXTRACT_ENTROPY_USER) && need_resched()) {
+		extract_buf(r, tmp);
+		i = min(nbytes, HASH_BUFFER_SIZE * sizeof(__u32) / 2);
+		memcpy(buf, (__u8 const *)tmp, i);
+		nbytes -= i;
+		buf += i;
+		ret += i;
+	}
+
+	/* Wipe data just returned from memory */
+	memset(tmp, 0, sizeof(tmp));
+
+	return ret;
+}
+
+static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
+				    size_t nbytes)
+{
+	ssize_t ret = 0, i;
+	__u32 tmp[TMP_BUF_SIZE];
+
+	xfer_secondary_pool(r, nbytes, tmp);
+	nbytes = account(r, nbytes, 0, 0);
+
+	while (nbytes) {
+		if (need_resched()) {
 			if (signal_pending(current)) {
 				if (ret == 0)
 					ret = -ERESTARTSYS;
 				break;
 			}
-
 			schedule();
 		}
 
-		/* Hash the pool to get the output */
-		tmp[0] = 0x67452301;
-		tmp[1] = 0xefcdab89;
-		tmp[2] = 0x98badcfe;
-		tmp[3] = 0x10325476;
-#ifdef USE_SHA
-		tmp[4] = 0xc3d2e1f0;
-#endif
-		/*
-		 * As we hash the pool, we mix intermediate values of
-		 * the hash back into the pool.  This eliminates
-		 * backtracking attacks (where the attacker knows
-		 * the state of the pool plus the current outputs, and
-		 * attempts to find previous ouputs), unless the hash
-		 * function can be inverted.
-		 */
-		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
-			HASH_TRANSFORM(tmp, r->pool+i);
-			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
+		extract_buf(r, tmp);
+		i = min(nbytes, HASH_BUFFER_SIZE * sizeof(__u32) / 2);
+		if (copy_to_user(buf, tmp, i)) {
+			ret = -EFAULT;
+			break;
 		}
 
-		/*
-		 * To avoid duplicates, we atomically extract a
-		 * portion of the pool while mixing, and hash one
-		 * final time.
-		 */
-		__add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1, data);
-		HASH_TRANSFORM(tmp, data);
-
-		/*
-		 * In case the hash function has some recognizable
-		 * output pattern, we fold it in half.
-		 */
-		for (i = 0; i <  HASH_BUFFER_SIZE/2; i++)
-			tmp[i] ^= tmp[i + (HASH_BUFFER_SIZE+1)/2];
-#if HASH_BUFFER_SIZE & 1	/* There's a middle word to deal with */
-		x = tmp[HASH_BUFFER_SIZE/2];
-		x ^= (x >> 16);		/* Fold it in half */
-		((__u16 *)tmp)[HASH_BUFFER_SIZE-1] = (__u16)x;
-#endif
-
-		/* Copy data to destination buffer */
-		i = min(nbytes, HASH_BUFFER_SIZE*sizeof(__u32)/2);
-		if (flags & EXTRACT_ENTROPY_USER) {
-			i -= copy_to_user(buf, (__u8 const *)tmp, i);
-			if (!i) {
-				ret = -EFAULT;
-				break;
-			}
-		} else
-			memcpy(buf, (__u8 const *)tmp, i);
-
 		nbytes -= i;
 		buf += i;
 		ret += i;
@@ -1356,7 +1382,7 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	extract_entropy(&nonblocking_pool, (char *) buf, nbytes, 0, 0, 0);
+	extract_entropy(&nonblocking_pool, buf, nbytes, 0, 0);
 }
 
 EXPORT_SYMBOL(get_random_bytes);
@@ -1445,8 +1471,7 @@
 
 		DEBUG_ENT("reading %d bits\n", n*8);
 
-		n = extract_entropy(&blocking_pool, buf, n, 0, 0,
-				    EXTRACT_ENTROPY_USER);
+		n = extract_entropy_user(&blocking_pool, buf, n);
 
 		DEBUG_ENT("read got %d bits (%d still needed)\n",
 			  n*8, (nbytes-n)*8);
@@ -1497,8 +1522,7 @@
 urandom_read(struct file * file, char __user * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(&nonblocking_pool, buf, nbytes, 0, 0,
-			       EXTRACT_ENTROPY_USER);
+	return extract_entropy_user(&nonblocking_pool, buf, nbytes);
 }
 
 static unsigned int
