Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWEIHAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWEIHAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWEIHAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:00:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:34498 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751432AbWEIHAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:00:02 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 9 May 2006 16:59:40 +1000
Message-Id: <1060509065940.10406@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH-RFC] Improve randomness of hash_long on 64bit.
References: <20060509165610.10378.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm still bothered by the poor showing on hash_long on 64bit
on number that differ only in the 3rd or 4th byte (as IP addresses might
on a little-endian host).
I hacked around the problem in net/sunrpc/svcauth_unix.c until this
issue got resolved, but it never did.  So I am pushing again.

The problem is that the bit-spares prime that is close to the
golden ratio isn't really close enough.

I propose 'fixing' it by using hash_u32 on the upper and lower halfs
of a 64bit value.  This is slightly less efficient, but most code would
probably be happy calling hash_u32 anyway.

More comments in the code.

Cc: William Lee Irwin III <wli@holomorphy.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/hash.h |   69 ++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff ./include/linux/hash.h~current~ ./include/linux/hash.h
--- ./include/linux/hash.h~current~	2006-05-09 16:52:57.000000000 +1000
+++ ./include/linux/hash.h	2006-05-09 16:55:37.000000000 +1000
@@ -12,45 +12,56 @@
  * These primes are chosen to be bit-sparse, that is operations on
  * them can use shifts and additions instead of multiplications for
  * machines where multiplications are slow.
+ *
+ * Unfortunately, the closeness to the golden ratio appears to be
+ * more important than the primality:  The bit-sparse 64bit number
+ * provides particularly poor hashing for values that differ in the
+ * third or fourth bytes only (the 0xffff0000 bits), though the 32bit
+ * prime seems to work reasonably well.
+ *
+ * We never actually need anything close to 64bits from this hash function.
+ * The most any caller in the kernel asked for (as at 2.6.16) is 14 bits (pid_hash).
+ * Thus limiting the return to 32bits is safe.  So we hash 64bit
+ * quantities with a double 32bit hash.
+ *
+ * And in many cases, we only really want hash_u32, even on a 64bit arch.
  */
-#if BITS_PER_LONG == 32
 /* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
-#define GOLDEN_RATIO_PRIME 0x9e370001UL
-#elif BITS_PER_LONG == 64
+#define GOLDEN_RATIO_PRIME_32 0x9e370001UL
 /*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
-#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
-#else
-#error Define GOLDEN_RATIO_PRIME for your wordsize.
-#endif
+#define GOLDEN_RATIO_PRIME_64 0x9e37fffffffc0001UL
 
-static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+static inline u32 hash_u32(u32 val, unsigned int bits)
 {
-	unsigned long hash = val;
+	u32 hash = val;
 
-#if BITS_PER_LONG == 64
-	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
-	unsigned long n = hash;
-	n <<= 18;
-	hash -= n;
-	n <<= 33;
-	hash -= n;
-	n <<= 3;
-	hash += n;
-	n <<= 3;
-	hash -= n;
-	n <<= 4;
-	hash += n;
-	n <<= 2;
-	hash += n;
-#else
 	/* On some cpus multiply is faster, on others gcc will do shifts */
-	hash *= GOLDEN_RATIO_PRIME;
-#endif
+	hash *= GOLDEN_RATIO_PRIME_32;
 
 	/* High bits are more random, so use them. */
-	return hash >> (BITS_PER_LONG - bits);
+	return hash >> (32 - bits);
+}
+
+static inline u32 hash_u64(u64 val, unsigned int bits)
+{
+	u32 hi = val >> 32;
+	return hash_u32( hash_u32( (u32)val , 32) ^ hi ,
+			 bits);
+}
+
+#if BITS_PER_LONG == 32
+static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+{
+	return (unsigned long)hash_u32( (u32)val, bits);
+}
+#endif
+#if BITS_PER_LONG == 64
+static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+{
+	return (unsigned long)hash_u64( (u64)val, bits);
 }
-	
+#endif
+
 static inline unsigned long hash_ptr(void *ptr, unsigned int bits)
 {
 	return hash_long((unsigned long)ptr, bits);
