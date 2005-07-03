Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVGCNUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVGCNUD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 09:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVGCNUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 09:20:03 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20403 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261435AbVGCNPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 09:15:19 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4/4] 64 bit rotation
Date: Sun, 3 Jul 2005 16:14:58 +0300
User-Agent: KMail/1.5.4
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
References: <200506201354.22187.vda@ilport.com.ua> <20050703113700.GA4848@gondor.apana.org.au> <200507031557.15416.vda@ilport.com.ua>
In-Reply-To: <200507031557.15416.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ST+xCfW8U/wUyyJ"
Message-Id: <200507031614.58799.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ST+xCfW8U/wUyyJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

we have rol/r32, why not rol/r64?

Add generic 64 rotation and i386 optimized one.
Use it in ia64 and sha512.
--
vda

--Boundary-00=_ST+xCfW8U/wUyyJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="4.rot64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="4.rot64.patch"

diff -urpN linux-2.6.12.3.n/arch/ia64/kernel/ptrace.c linux-2.6.12.4.rot64/arch/ia64/kernel/ptrace.c
--- linux-2.6.12.3.n/arch/ia64/kernel/ptrace.c	Sun Jun 19 16:09:51 2005
+++ linux-2.6.12.4.rot64/arch/ia64/kernel/ptrace.c	Mon Jun 20 13:23:48 2005
@@ -81,7 +81,7 @@ ia64_get_scratch_nat_bits (struct pt_reg
 			dist = 64 + bit - first;			\
 		else							\
 			dist = bit - first;				\
-		ia64_rotr(unat, dist) & mask;				\
+		ror64(unat, dist) & mask;				\
 	})
 	unsigned long val;
 
@@ -120,7 +120,7 @@ ia64_put_scratch_nat_bits (struct pt_reg
 			dist = 64 + bit - first;			\
 		else							\
 			dist = bit - first;				\
-		ia64_rotl(nat & mask, dist);				\
+		rol64(nat & mask, dist);				\
 	})
 	unsigned long scratch_unat;
 
diff -urpN linux-2.6.12.3.n/crypto/sha512.c linux-2.6.12.4.rot64/crypto/sha512.c
--- linux-2.6.12.3.n/crypto/sha512.c	Sun Jul  3 15:53:03 2005
+++ linux-2.6.12.4.rot64/crypto/sha512.c	Sun Jul  3 16:11:50 2005
@@ -45,11 +45,6 @@ static inline u64 Maj(u64 x, u64 y, u64 
         return (x & y) | (z & (x | y));
 }
 
-static inline u64 RORu64(u64 x, u64 y)
-{
-        return (x >> y) | (x << (64 - y));
-}
-
 static const u64 sha512_K[80] = {
         0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
         0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
@@ -80,10 +75,10 @@ static const u64 sha512_K[80] = {
         0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL,
 };
 
-#define e0(x)       (RORu64(x,28) ^ RORu64(x,34) ^ RORu64(x,39))
-#define e1(x)       (RORu64(x,14) ^ RORu64(x,18) ^ RORu64(x,41))
-#define s0(x)       (RORu64(x, 1) ^ RORu64(x, 8) ^ (x >> 7))
-#define s1(x)       (RORu64(x,19) ^ RORu64(x,61) ^ (x >> 6))
+#define e0(x)       (ror64(x,28) ^ ror64(x,34) ^ ror64(x,39))
+#define e1(x)       (ror64(x,14) ^ ror64(x,18) ^ ror64(x,41))
+#define s0(x)       (ror64(x, 1) ^ ror64(x, 8) ^ (x >> 7))
+#define s1(x)       (ror64(x,19) ^ ror64(x,61) ^ (x >> 6))
 
 /* H* initial state for SHA-512 */
 #define H0         0x6a09e667f3bcc908ULL
diff -urpN linux-2.6.12.3.n/include/asm-i386/bitops.h linux-2.6.12.4.rot64/include/asm-i386/bitops.h
--- linux-2.6.12.3.n/include/asm-i386/bitops.h	Tue Oct 19 00:54:37 2004
+++ linux-2.6.12.4.rot64/include/asm-i386/bitops.h	Mon Jun 20 13:23:48 2005
@@ -7,6 +7,7 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 /*
  * These have to be done with inline assembly: that way the bit-setting
@@ -39,7 +40,7 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void set_bit(int nr, volatile unsigned long * addr)
+static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %1,%0"
@@ -56,7 +57,7 @@ static inline void set_bit(int nr, volat
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __set_bit(int nr, volatile unsigned long * addr)
+static __inline__ void __set_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__(
 		"btsl %1,%0"
@@ -74,7 +75,7 @@ static inline void __set_bit(int nr, vol
  * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
  * in order to ensure changes are visible on other processors.
  */
-static inline void clear_bit(int nr, volatile unsigned long * addr)
+static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %1,%0"
@@ -82,7 +83,7 @@ static inline void clear_bit(int nr, vol
 		:"Ir" (nr));
 }
 
-static inline void __clear_bit(int nr, volatile unsigned long * addr)
+static __inline__ void __clear_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__(
 		"btrl %1,%0"
@@ -101,7 +102,7 @@ static inline void __clear_bit(int nr, v
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __change_bit(int nr, volatile unsigned long * addr)
+static __inline__ void __change_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__(
 		"btcl %1,%0"
@@ -119,7 +120,7 @@ static inline void __change_bit(int nr, 
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void change_bit(int nr, volatile unsigned long * addr)
+static __inline__ void change_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %1,%0"
@@ -136,7 +137,7 @@ static inline void change_bit(int nr, vo
  * It may be reordered on other architectures than x86.
  * It also implies a memory barrier.
  */
-static inline int test_and_set_bit(int nr, volatile unsigned long * addr)
+static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -156,7 +157,7 @@ static inline int test_and_set_bit(int n
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(int nr, volatile unsigned long * addr)
+static __inline__ int __test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -176,7 +177,7 @@ static inline int __test_and_set_bit(int
  * It can be reorderdered on other architectures other than x86.
  * It also implies a memory barrier.
  */
-static inline int test_and_clear_bit(int nr, volatile unsigned long * addr)
+static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -196,7 +197,7 @@ static inline int test_and_clear_bit(int
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -208,7 +209,7 @@ static inline int __test_and_clear_bit(i
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
+static __inline__ int __test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -227,7 +228,7 @@ static inline int __test_and_change_bit(
  * This operation is atomic and cannot be reordered.  
  * It also implies a memory barrier.
  */
-static inline int test_and_change_bit(int nr, volatile unsigned long* addr)
+static __inline__ int test_and_change_bit(int nr, volatile unsigned long* addr)
 {
 	int oldbit;
 
@@ -247,12 +248,12 @@ static inline int test_and_change_bit(in
 static int test_bit(int nr, const volatile void * addr);
 #endif
 
-static inline int constant_test_bit(int nr, const volatile unsigned long *addr)
+static __inline__ int constant_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return ((1UL << (nr & 31)) & (addr[nr >> 5])) != 0;
 }
 
-static inline int variable_test_bit(int nr, const volatile unsigned long * addr)
+static __inline__ int variable_test_bit(int nr, const volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -278,7 +279,7 @@ static inline int variable_test_bit(int 
  * Returns the bit-number of the first zero bit, not the number of the byte
  * containing a bit.
  */
-static inline int find_first_zero_bit(const unsigned long *addr, unsigned size)
+static __inline__ int find_first_zero_bit(const unsigned long *addr, unsigned size)
 {
 	int d0, d1, d2;
 	int res;
@@ -318,7 +319,7 @@ int find_next_zero_bit(const unsigned lo
  * Returns the bit-number of the first set bit, not the number of the byte
  * containing a bit.
  */
-static inline int find_first_bit(const unsigned long *addr, unsigned size)
+static __inline__ int find_first_bit(const unsigned long *addr, unsigned size)
 {
 	int d0, d1;
 	int res;
@@ -352,7 +353,7 @@ int find_next_bit(const unsigned long *a
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static inline unsigned long ffz(unsigned long word)
+static __inline__ unsigned long ffz(unsigned long word)
 {
 	__asm__("bsfl %1,%0"
 		:"=r" (word)
@@ -366,7 +367,7 @@ static inline unsigned long ffz(unsigned
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static inline unsigned long __ffs(unsigned long word)
+static __inline__ unsigned long __ffs(unsigned long word)
 {
 	__asm__("bsfl %1,%0"
 		:"=r" (word)
@@ -388,7 +389,7 @@ static inline unsigned long __ffs(unsign
  * unlikely to be set. It's guaranteed that at least one of the 140
  * bits is cleared.
  */
-static inline int sched_find_first_bit(const unsigned long *b)
+static __inline__ int sched_find_first_bit(const unsigned long *b)
 {
 	if (unlikely(b[0]))
 		return __ffs(b[0]);
@@ -409,7 +410,7 @@ static inline int sched_find_first_bit(c
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline int ffs(int x)
+static __inline__ int ffs(int x)
 {
 	int r;
 
@@ -431,9 +432,81 @@ static inline int ffs(int x)
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
-#endif /* __KERNEL__ */
+/*
+ * 64bit rotations
+ * (gcc3 seems to be clever enough to do 32bit ones just fine)
+ *
+ * Why "i" and "I" constraints do not work? gcc says:
+ * "warning: asm operand 2 probably doesn't match constraints"
+ * "error: impossible constraint in 'asm'"
+ * Will use "Ic" for now. If gcc will fail to do const propagation
+ * and will try to stuff constant into ecx, shld %3,... will expand
+ * to shld %ecx,... and assembler will moan.
+ * Do not 'fix' by changing to shld %b3,...
+ *
+ * Have to stick to edx,eax pair only because
+ * gcc has limited support for 64bit asm parameters
+ */
+#define constant_rol64(v,c) \
+	({						\
+	u64 vv = (v);					\
+	if(!(c&63)) {					\
+	} else if((c&63)==1) {				\
+		asm (					\
+		"	shldl	$1,%%edx,%%eax	\n"	\
+		"	rcll	$1,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv)				\
+		);					\
+	} else if((c&63)==63) {				\
+		asm (					\
+		"	shrdl	$1,%%edx,%%eax	\n"	\
+		"	rcrl	$1,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv)				\
+		);					\
+	} else if((c&63)<32) {				\
+		asm (					\
+		"	shldl	%3,%%edx,%%eax	\n"	\
+		"	shldl	%3,%2,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv), "r" (vv), "Ic" (c&63)	\
+		);					\
+	} else if((c&63)>32) {				\
+		asm (					\
+		"	shrdl	%3,%%edx,%%eax	\n"	\
+		"	shrdl	%3,%2,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv), "r" (vv), "Ic" (64-(c&63))	\
+		);					\
+	} else /* (c&63)==32 */ {			\
+		asm (					\
+		"	xchgl	%%edx,%%eax	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv)				\
+		);					\
+	}						\
+	vv;						\
+	})
+/*
+ * Unfortunately 64bit rotations with non-constant count
+ * have issues with cnt>=32. Using C code instead
+ */
+static __inline__ u64 rol64(u64 x,int num) {
+	if(__builtin_constant_p(num))
+		return constant_rol64(x,num);
+	/* Hmmm... shall we do cnt&=63 here? */
+	return ((x<<num) | (x>>(64-num)));
+}
+static __inline__ u64 ror64(u64 x,int num) {
+	if(__builtin_constant_p(num))
+		return constant_rol64(x,(64-num));
+	return ((x>>num) | (x<<(64-num)));
+}
+
+#define ARCH_HAS_ROL64
+#define ARCH_HAS_ROR64
 
-#ifdef __KERNEL__
 
 #define ext2_set_bit(nr,addr) \
 	__test_and_set_bit((nr),(unsigned long*)addr)
diff -urpN linux-2.6.12.3.n/include/asm-ia64/processor.h linux-2.6.12.4.rot64/include/asm-ia64/processor.h
--- linux-2.6.12.3.n/include/asm-ia64/processor.h	Sun Jun 19 16:10:49 2005
+++ linux-2.6.12.4.rot64/include/asm-ia64/processor.h	Mon Jun 20 13:23:48 2005
@@ -654,14 +654,6 @@ ia64_get_dbr (__u64 regnum)
 	return retval;
 }
 
-static inline __u64
-ia64_rotr (__u64 w, __u64 n)
-{
-	return (w >> n) | (w << (64 - n));
-}
-
-#define ia64_rotl(w,n)	ia64_rotr((w), (64) - (n))
-
 /*
  * Take a mapped kernel address and return the equivalent address
  * in the region 7 identity mapped virtual area.
diff -urpN linux-2.6.12.3.n/include/linux/bitops.h linux-2.6.12.4.rot64/include/linux/bitops.h
--- linux-2.6.12.3.n/include/linux/bitops.h	Sun Jun 19 16:10:55 2005
+++ linux-2.6.12.4.rot64/include/linux/bitops.h	Mon Jun 20 13:23:48 2005
@@ -8,7 +8,7 @@
  * differs in spirit from the above ffz (man ffs).
  */
 
-static inline int generic_ffs(int x)
+static __inline__ int generic_ffs(int x)
 {
 	int r = 1;
 
@@ -89,7 +89,7 @@ static __inline__ int get_bitmask_order(
  * of bits set) of a N-bit word
  */
 
-static inline unsigned int generic_hweight32(unsigned int w)
+static __inline__ unsigned int generic_hweight32(unsigned int w)
 {
         unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
         res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
@@ -98,7 +98,7 @@ static inline unsigned int generic_hweig
         return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
 }
 
-static inline unsigned int generic_hweight16(unsigned int w)
+static __inline__ unsigned int generic_hweight16(unsigned int w)
 {
         unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
         res = (res & 0x3333) + ((res >> 2) & 0x3333);
@@ -106,14 +106,14 @@ static inline unsigned int generic_hweig
         return (res & 0x00FF) + ((res >> 8) & 0x00FF);
 }
 
-static inline unsigned int generic_hweight8(unsigned int w)
+static __inline__ unsigned int generic_hweight8(unsigned int w)
 {
         unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
         res = (res & 0x33) + ((res >> 2) & 0x33);
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
 
-static inline unsigned long generic_hweight64(__u64 w)
+static __inline__ unsigned long generic_hweight64(__u64 w)
 {
 #if BITS_PER_LONG < 64
 	return generic_hweight32((unsigned int)(w >> 32)) +
@@ -129,7 +129,7 @@ static inline unsigned long generic_hwei
 #endif
 }
 
-static inline unsigned long hweight_long(unsigned long w)
+static __inline__ unsigned long hweight_long(unsigned long w)
 {
 	return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
 }
@@ -140,7 +140,7 @@ static inline unsigned long hweight_long
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u32 rol32(__u32 word, unsigned int shift)
+static __inline__ __u32 rol32(__u32 word, unsigned int shift)
 {
 	return (word << shift) | (word >> (32 - shift));
 }
@@ -151,9 +151,35 @@ static inline __u32 rol32(__u32 word, un
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u32 ror32(__u32 word, unsigned int shift)
+static __inline__ __u32 ror32(__u32 word, unsigned int shift)
 {
 	return (word >> shift) | (word << (32 - shift));
 }
+
+/*
+ * rol64 - rotate a 64-bit value left
+ *
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+#ifndef ARCH_HAS_ROL64
+static __inline__ __u64 rol64(__u64 word, unsigned int shift)
+{
+	return (word << shift) | (word >> (64 - shift));
+}
+#endif
+
+/*
+ * ror64 - rotate a 64-bit value right
+ *
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+#ifndef ARCH_HAS_ROR64
+static __inline__ __u64 ror64(__u64 word, unsigned int shift)
+{
+	return (word >> shift) | (word << (64 - shift));
+}
+#endif
 
 #endif

--Boundary-00=_ST+xCfW8U/wUyyJ--

