Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSJDRnX>; Fri, 4 Oct 2002 13:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbSJDRnX>; Fri, 4 Oct 2002 13:43:23 -0400
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:10907 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262821AbSJDRnN> convert rfc822-to-8bit; Fri, 4 Oct 2002 13:43:13 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (14/27): inline optimizations.
Date: Fri, 4 Oct 2002 16:30:32 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041630.32066.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inline csum_partial for s390, the only reason it was out-of-line previously
is that some older compilers could not get the inline version right.

diff -urN linux-2.5.40/arch/s390/lib/Makefile linux-2.5.40-s390/arch/s390/lib/Makefile
--- linux-2.5.40/arch/s390/lib/Makefile	Tue Oct  1 09:06:16 2002
+++ linux-2.5.40-s390/arch/s390/lib/Makefile	Fri Oct  4 16:15:49 2002
@@ -6,8 +6,7 @@
 
 EXTRA_AFLAGS := -traditional
 
-obj-y = checksum.o delay.o memset.o misaligned.o strcmp.o strncpy.o uaccess.o
-export-objs += misaligned.o
+obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-2.5.40/arch/s390/lib/checksum.c linux-2.5.40-s390/arch/s390/lib/checksum.c
--- linux-2.5.40/arch/s390/lib/checksum.c	Tue Oct  1 09:05:47 2002
+++ linux-2.5.40-s390/arch/s390/lib/checksum.c	Thu Jan  1 01:00:00 1970
@@ -1,57 +0,0 @@
-/*
- *  arch/s390/lib/checksum.c
- *    S390 fast network checksum routines
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Ulrich Hild        (first version),
- *               Martin Schwidefsky (schwidefsky@de.ibm.com),
- *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
- *
- * This file contains network checksum routines
- */
- 
-#include <linux/string.h>
-#include <linux/types.h>
-#include <asm/uaccess.h>
-#include <asm/byteorder.h>
-#include <asm/checksum.h>
-
-/*
- * computes a partial checksum, e.g. for TCP/UDP fragments
- */
-unsigned int
-csum_partial (const unsigned char *buff, int len, unsigned int sum)
-{
-	register_pair rp;
-	  /*
-	   * Experiments with ethernet and slip connections show that buff
-	   * is aligned on either a 2-byte or 4-byte boundary.
-	   */
-	rp.subreg.even = (unsigned long) buff;
-	rp.subreg.odd = (unsigned long) len;
-        __asm__ __volatile__ (
-                "0:  cksm %0,%1\n"    /* do checksum on longs */
-                "    jo   0b\n"
-                : "+&d" (sum), "+&a" (rp) : : "cc" );
-        return sum;
-}
-
-/*
- *	Fold a partial checksum without adding pseudo headers
- */
-unsigned short csum_fold(unsigned int sum)
-{
-	register_pair rp;
-
-	__asm__ __volatile__ (
-		"    slr  %N1,%N1\n" /* %0 = H L */
-		"    lr   %1,%0\n"   /* %0 = H L, %1 = H L 0 0 */
-		"    srdl %1,16\n"   /* %0 = H L, %1 = 0 H L 0 */
-		"    alr  %1,%N1\n"  /* %0 = H L, %1 = L H L 0 */
-		"    alr  %0,%1\n"   /* %0 = H+L+C L+H */
-		"    srl  %0,16\n"   /* %0 = H+L+C */
-		: "+&d" (sum), "=d" (rp) : : "cc" );
-	return ((unsigned short) ~sum);
-}
-
diff -urN linux-2.5.40/arch/s390/lib/misaligned.c linux-2.5.40-s390/arch/s390/lib/misaligned.c
--- linux-2.5.40/arch/s390/lib/misaligned.c	Tue Oct  1 09:07:05 2002
+++ linux-2.5.40-s390/arch/s390/lib/misaligned.c	Thu Jan  1 01:00:00 1970
@@ -1,29 +0,0 @@
-/*
- *  arch/s390/lib/misaligned.c
- *    S390 misalignment panic stubs
- *
- *  S390 version
- *    Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com).
- *
- * xchg wants to panic if the pointer is not aligned. To avoid multiplying
- * the panic message over and over again, the panic is done in the helper
- * functions __misaligned_u32 and __misaligned_u16.
- */
-
-#include <linux/module.h> 
-#include <linux/kernel.h>
-
-void __misaligned_u16(void)
-{
-	panic("misaligned (__u16 *) in __xchg\n");
-}
-
-void __misaligned_u32(void)
-{
-	panic("misaligned (__u32 *) in __xchg\n");
-}
-
-EXPORT_SYMBOL(__misaligned_u16);
-EXPORT_SYMBOL(__misaligned_u32);
-
diff -urN linux-2.5.40/arch/s390x/lib/Makefile linux-2.5.40-s390/arch/s390x/lib/Makefile
--- linux-2.5.40/arch/s390x/lib/Makefile	Tue Oct  1 09:06:17 2002
+++ linux-2.5.40-s390/arch/s390x/lib/Makefile	Fri Oct  4 16:15:49 2002
@@ -6,8 +6,7 @@
 
 EXTRA_AFLAGS := -traditional
 
-obj-y = checksum.o delay.o memset.o misaligned.o strcmp.o strncpy.o uaccess.o
-export-objs += misaligned.o
+obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-2.5.40/arch/s390x/lib/checksum.c linux-2.5.40-s390/arch/s390x/lib/checksum.c
--- linux-2.5.40/arch/s390x/lib/checksum.c	Tue Oct  1 09:07:02 2002
+++ linux-2.5.40-s390/arch/s390x/lib/checksum.c	Thu Jan  1 01:00:00 1970
@@ -1,40 +0,0 @@
-/*
- *  arch/s390/lib/checksum.c
- *    S390 fast network checksum routines
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Ulrich Hild        (first version),
- *               Martin Schwidefsky (schwidefsky@de.ibm.com),
- *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
- *
- * This file contains network checksum routines
- */
- 
-#include <linux/string.h>
-#include <linux/types.h>
-#include <asm/uaccess.h>
-#include <asm/byteorder.h>
-#include <asm/checksum.h>
-
-/*
- * computes a partial checksum, e.g. for TCP/UDP fragments
- */
-unsigned int
-csum_partial (const unsigned char *buff, int len, unsigned int sum)
-{
-	  /*
-	   * Experiments with ethernet and slip connections show that buff
-	   * is aligned on either a 2-byte or 4-byte boundary.
-	   */
-        __asm__ __volatile__ (
-                "    lgr  2,%1\n"    /* address in gpr 2 */
-                "    lgfr 3,%2\n"    /* length in gpr 3 */
-                "0:  cksm %0,2\n"    /* do checksum on longs */
-                "    jo   0b\n"
-                : "+&d" (sum)
-                : "d" (buff), "d" (len)
-                : "cc", "2", "3" );
-        return sum;
-}
-
diff -urN linux-2.5.40/arch/s390x/lib/misaligned.c linux-2.5.40-s390/arch/s390x/lib/misaligned.c
--- linux-2.5.40/arch/s390x/lib/misaligned.c	Tue Oct  1 09:07:34 2002
+++ linux-2.5.40-s390/arch/s390x/lib/misaligned.c	Thu Jan  1 01:00:00 1970
@@ -1,34 +0,0 @@
-/*
- *  arch/s390/lib/misaligned.c
- *    S390 misalignment panic stubs
- *
- *  S390 version
- *    Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com).
- *
- * xchg wants to panic if the pointer is not aligned. To avoid multiplying
- * the panic message over and over again, the panic is done in the helper
- * functions __misaligned_u64, __misaligned_u32 and __misaligned_u16.
- */
- 
-#include <linux/module.h>
-#include <linux/kernel.h>
-
-void __misaligned_u16(void)
-{
-	panic("misaligned (__u16 *) in __xchg\n");
-}
-
-void __misaligned_u32(void)
-{
-	panic("misaligned (__u32 *) in __xchg\n");
-}
-
-void __misaligned_u64(void)
-{
-	panic("misaligned (__u64 *) in __xchg\n");
-}
-
-EXPORT_SYMBOL(__misaligned_u16);
-EXPORT_SYMBOL(__misaligned_u32);
-EXPORT_SYMBOL(__misaligned_u64);
diff -urN linux-2.5.40/include/asm-s390/checksum.h linux-2.5.40-s390/include/asm-s390/checksum.h
--- linux-2.5.40/include/asm-s390/checksum.h	Tue Oct  1 09:05:48 2002
+++ linux-2.5.40-s390/include/asm-s390/checksum.h	Fri Oct  4 16:15:49 2002
@@ -27,13 +27,27 @@
  *
  * it's best to have buff aligned on a 32-bit boundary
  */
-unsigned int
-csum_partial(const unsigned char * buff, int len, unsigned int sum);
+static inline unsigned int
+csum_partial(const unsigned char * buff, int len, unsigned int sum)
+{
+	register_pair rp;
+	/*
+	 * Experiments with ethernet and slip connections show that buf
+	 * is aligned on either a 2-byte or 4-byte boundary.
+	 */
+	rp.subreg.even = (unsigned long) buff;
+	rp.subreg.odd = (unsigned long) len;
+	__asm__ __volatile__ (
+		"0:  cksm %0,%1\n"	/* do checksum on longs */
+		"    jo   0b\n"
+		: "+&d" (sum), "+&a" (rp) : : "cc" );
+	return sum;
+}
 
 /*
  * csum_partial as an inline function
  */
-extern inline unsigned int 
+static inline unsigned int 
 csum_partial_inline(const unsigned char * buff, int len, unsigned int sum)
 {
 	register_pair rp;
@@ -55,7 +69,7 @@
  * better 64-bit) boundary
  */
 
-extern inline unsigned int 
+static inline unsigned int 
 csum_partial_copy(const char *src, char *dst, int len,unsigned int sum)
 {
 	memcpy(dst,src,len);
@@ -71,7 +85,7 @@
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
  */
-extern inline unsigned int 
+static inline unsigned int 
 csum_partial_copy_from_user (const char *src, char *dst,
                                           int len, unsigned int sum,
                                           int *err_ptr)
@@ -88,7 +102,7 @@
 }
 
 
-extern inline unsigned int
+static inline unsigned int
 csum_partial_copy_nocheck (const char *src, char *dst, int len, unsigned int sum)
 {
         memcpy(dst,src,len);
@@ -98,10 +112,7 @@
 /*
  *      Fold a partial checksum without adding pseudo headers
  */
-#if 1
-unsigned short csum_fold(unsigned int sum);
-#else
-extern inline unsigned short
+static inline unsigned short
 csum_fold(unsigned int sum)
 {
 	register_pair rp;
@@ -116,14 +127,13 @@
 		: "+&d" (sum), "=d" (rp) : : "cc" );
 	return ((unsigned short) ~sum);
 }
-#endif
 
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,
  *	which always checksum on 4 octet boundaries.
  *
  */
-extern inline unsigned short
+static inline unsigned short
 ip_fast_csum(unsigned char *iph, unsigned int ihl)
 {
 	register_pair rp;
@@ -143,7 +153,7 @@
  * computes the checksum of the TCP/UDP pseudo-header
  * returns a 32-bit checksum
  */
-extern inline unsigned int 
+static inline unsigned int 
 csum_tcpudp_nofold(unsigned long saddr, unsigned long daddr,
                    unsigned short len, unsigned short proto,
                    unsigned int sum)
@@ -176,7 +186,7 @@
  * returns a 16-bit checksum, already complemented
  */
 
-extern inline unsigned short int
+static inline unsigned short int
 csum_tcpudp_magic(unsigned long saddr, unsigned long daddr,
                   unsigned short len, unsigned short proto,
                   unsigned int sum)
@@ -189,7 +199,7 @@
  * in icmp.c
  */
 
-extern inline unsigned short
+static inline unsigned short
 ip_compute_csum(unsigned char * buff, int len)
 {
 	return csum_fold(csum_partial(buff, len, 0));
diff -urN linux-2.5.40/include/asm-s390/system.h linux-2.5.40-s390/include/asm-s390/system.h
--- linux-2.5.40/include/asm-s390/system.h	Fri Oct  4 16:14:46 2002
+++ linux-2.5.40-s390/include/asm-s390/system.h	Fri Oct  4 16:15:49 2002
@@ -30,73 +30,56 @@
 
 #define nop() __asm__ __volatile__ ("nop")
 
-#define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
-
-extern void __misaligned_u16(void);
-extern void __misaligned_u32(void);
+#define xchg(ptr,x) \
+  ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 
 static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
 {
+	unsigned long addr, old;
+	int shift;
+
         switch (size) {
-                case 1:
-                        asm volatile (
-                                "   lhi   1,3\n"
-                                "   nr    1,%0\n"     /* isolate last 2 bits */
-                                "   xr    %0,1\n"     /* align ptr */
-                                "   bras  2,0f\n"
-                                "   icm   1,8,3(%1)\n"   /* for ptr&3 == 0 */
-                                "   stcm  0,8,3(%1)\n"
-                                "   icm   1,4,3(%1)\n"   /* for ptr&3 == 1 */
-                                "   stcm  0,4,3(%1)\n"
-                                "   icm   1,2,3(%1)\n"   /* for ptr&3 == 2 */
-                                "   stcm  0,2,3(%1)\n"
-                                "   icm   1,1,3(%1)\n"   /* for ptr&3 == 3 */
-                                "   stcm  0,1,3(%1)\n"
-                                "0: sll   1,3\n"
-                                "   la    2,0(1,2)\n" /* r2 points to an icm */
-                                "   l     0,0(%0)\n"  /* get fullword */
-                                "1: lr    1,0\n"      /* cs loop */
-                                "   ex    0,0(2)\n"   /* insert x */
-                                "   cs    0,1,0(%0)\n"
-                                "   jl    1b\n"
-                                "   ex    0,4(2)"     /* store *ptr to x */
-                                : "+a&" (ptr) : "a" (&x)
-                                : "memory", "cc", "0", "1", "2");
-			break;
-                case 2:
-                        if(((__u32)ptr)&1)
-				__misaligned_u16();
-                        asm volatile (
-                                "   lhi   1,2\n"
-                                "   nr    1,%0\n"     /* isolate bit 2^1 */
-                                "   xr    %0,1\n"     /* align ptr */
-                                "   bras  2,0f\n"
-                                "   icm   1,12,2(%1)\n"   /* for ptr&2 == 0 */
-                                "   stcm  0,12,2(%1)\n"
-                                "   icm   1,3,2(%1)\n"    /* for ptr&2 == 1 */
-                                "   stcm  0,3,2(%1)\n"
-                                "0: sll   1,2\n"
-                                "   la    2,0(1,2)\n" /* r2 points to an icm */
-                                "   l     0,0(%0)\n"  /* get fullword */
-                                "1: lr    1,0\n"      /* cs loop */
-                                "   ex    0,0(2)\n"   /* insert x */
-                                "   cs    0,1,0(%0)\n"
-                                "   jl    1b\n"
-                                "   ex    0,4(2)"     /* store *ptr to x */
-                                : "+a&" (ptr) : "a" (&x)
-                                : "memory", "cc", "0", "1", "2");
-                        break;
-                case 4:
-                        if(((__u32)ptr)&3)
-				__misaligned_u32();
-                        asm volatile (
-                                "    l   0,0(%1)\n"
-                                "0:  cs  0,%0,0(%1)\n"
-                                "    jl  0b\n"
-                                "    lr  %0,0\n"
-                                : "+d&" (x) : "a" (ptr)
-                                : "memory", "cc", "0" );
-                        break;
+	case 1:
+		addr = (unsigned long) ptr;
+		shift = (3 ^ (addr & 3)) << 3;
+		addr ^= addr & 3;
+		asm volatile(
+			"    l   %0,0(%3)\n"
+			"0:  lr  0,%0\n"
+			"    nr  0,%2\n"
+			"    or  0,%1\n"
+			"    cs  %0,0,0(%3)\n"
+			"    jl  0b\n"
+			: "=&d" (old)
+			: "d" (x << shift), "d" (~(255 << shift)), "a" (addr)
+			: "memory", "cc", "0" );
+		x = old >> shift;
+		break;
+	case 2:
+		addr = (unsigned long) ptr;
+		shift = (2 ^ (addr & 2)) << 3;
+		addr ^= addr & 2;
+		asm volatile(
+			"    l   %0,0(%3)\n"
+			"0:  lr  0,%0\n"
+			"    nr  0,%2\n"
+			"    or  0,%1\n"
+			"    cs  %0,0,0(%3)\n"
+			"    jl  0b\n"
+			: "=&d" (old) 
+			: "d" (x << shift), "d" (~(65535 << shift)), "a" (addr)
+			: "memory", "cc", "0" );
+		x = old >> shift;
+		break;
+	case 4:
+		asm volatile (
+			"    l   %0,0(%2)\n"
+			"0:  cs  %0,%1,0(%2)\n"
+			"    jl  0b\n"
+			: "=&d" (old) : "d" (x), "a" (ptr)
+			: "memory", "cc", "0" );
+		x = old;
+		break;
         }
         return x;
 }
diff -urN linux-2.5.40/include/asm-s390x/checksum.h linux-2.5.40-s390/include/asm-s390x/checksum.h
--- linux-2.5.40/include/asm-s390x/checksum.h	Tue Oct  1 09:07:36 2002
+++ linux-2.5.40-s390/include/asm-s390x/checksum.h	Fri Oct  4 16:15:49 2002
@@ -27,13 +27,29 @@
  *
  * it's best to have buff aligned on a 32-bit boundary
  */
-unsigned int
-csum_partial(const unsigned char * buff, int len, unsigned int sum);
+static inline unsigned int
+csum_partial(const unsigned char * buff, int len, unsigned int sum)
+{
+	/*
+	 * Experiments with ethernet and slip connections show that buff
+	 * is aligned on either a 2-byte or 4-byte boundary.
+	 */
+        __asm__ __volatile__ (
+                "    lgr  2,%1\n"    /* address in gpr 2 */
+                "    lgfr 3,%2\n"    /* length in gpr 3 */
+                "0:  cksm %0,2\n"    /* do checksum on longs */
+                "    jo   0b\n"
+                : "+&d" (sum)
+                : "d" (buff), "d" (len)
+                : "cc", "2", "3" );
+        return sum;
+	
+}
 
 /*
  * csum_partial as an inline function
  */
-extern inline unsigned int 
+static inline unsigned int 
 csum_partial_inline(const unsigned char * buff, int len, unsigned int sum)
 {
 	__asm__ __volatile__ (
@@ -55,7 +71,7 @@
  * better 64-bit) boundary
  */
 
-extern inline unsigned int 
+static inline unsigned int 
 csum_partial_copy(const char *src, char *dst, int len,unsigned int sum)
 {
 	memcpy(dst,src,len);
@@ -71,7 +87,7 @@
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
  */
-extern inline unsigned int 
+static inline unsigned int 
 csum_partial_copy_from_user (const char *src, char *dst,
                                           int len, unsigned int sum,
                                           int *err_ptr)
@@ -87,7 +103,7 @@
 	return csum_partial(dst, len, sum);
 }
 
-extern inline unsigned int
+static inline unsigned int
 csum_partial_copy_nocheck (const char *src, char *dst, int len, unsigned int sum)
 {
         memcpy(dst,src,len);
@@ -97,7 +113,7 @@
 /*
  *      Fold a partial checksum without adding pseudo headers
  */
-extern inline unsigned short
+static inline unsigned short
 csum_fold(unsigned int sum)
 {
 	__asm__ __volatile__ (
@@ -116,7 +132,7 @@
  *	which always checksum on 4 octet boundaries.
  *
  */
-extern inline unsigned short
+static inline unsigned short
 ip_fast_csum(unsigned char *iph, unsigned int ihl)
 {
 	unsigned long sum;
@@ -137,7 +153,7 @@
  * computes the checksum of the TCP/UDP pseudo-header
  * returns a 32-bit checksum
  */
-extern inline unsigned int 
+static inline unsigned int 
 csum_tcpudp_nofold(unsigned long saddr, unsigned long daddr,
                    unsigned short len, unsigned short proto,
                    unsigned int sum)
@@ -170,7 +186,7 @@
  * returns a 16-bit checksum, already complemented
  */
 
-extern inline unsigned short int
+static inline unsigned short int
 csum_tcpudp_magic(unsigned long saddr, unsigned long daddr,
                   unsigned short len, unsigned short proto,
                   unsigned int sum)
@@ -183,7 +199,7 @@
  * in icmp.c
  */
 
-extern inline unsigned short
+static inline unsigned short
 ip_compute_csum(unsigned char * buff, int len)
 {
 	return csum_fold(csum_partial_inline(buff, len, 0));
diff -urN linux-2.5.40/include/asm-s390x/system.h linux-2.5.40-s390/include/asm-s390x/system.h
--- linux-2.5.40/include/asm-s390x/system.h	Fri Oct  4 16:14:46 2002
+++ linux-2.5.40-s390/include/asm-s390x/system.h	Fri Oct  4 16:15:49 2002
@@ -39,77 +39,60 @@
 
 static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
 {
+	unsigned long addr, old;
+	int shift;
+
         switch (size) {
-                case 1:
-                        asm volatile (
-                                "   lghi  1,3\n"
-                                "   nr    1,%0\n"     /* isolate last 2 bits */
-                                "   xr    %0,1\n"     /* align ptr */
-                                "   bras  2,0f\n"
-                                "   icm   1,8,7(%1)\n"   /* for ptr&3 == 0 */
-                                "   stcm  0,8,7(%1)\n"
-                                "   icm   1,4,7(%1)\n"   /* for ptr&3 == 1 */
-                                "   stcm  0,4,7(%1)\n"
-                                "   icm   1,2,7(%1)\n"   /* for ptr&3 == 2 */
-                                "   stcm  0,2,7(%1)\n"
-                                "   icm   1,1,7(%1)\n"   /* for ptr&3 == 3 */
-                                "   stcm  0,1,7(%1)\n"
-                                "0: sll   1,3\n"
-                                "   la    2,0(1,2)\n" /* r2 points to an icm */
-                                "   l     0,0(%0)\n"  /* get fullword */
-                                "1: lr    1,0\n"      /* cs loop */
-                                "   ex    0,0(2)\n"   /* insert x */
-                                "   cs    0,1,0(%0)\n"
-                                "   jl    1b\n"
-                                "   ex    0,4(2)"     /* store *ptr to x */
-                                : "+&a" (ptr) : "a" (&x)
-                                : "memory", "cc", "0", "1", "2");
-			break;
-                case 2:
-                        if(((addr_t)ptr)&1)
-				__misaligned_u16();
-                        asm volatile (
-                                "   lghi  1,2\n"
-                                "   nr    1,%0\n"     /* isolate bit 2^1 */
-                                "   xr    %0,1\n"     /* align ptr */
-                                "   bras  2,0f\n"
-                                "   icm   1,12,6(%1)\n"   /* for ptr&2 == 0 */
-                                "   stcm  0,12,6(%1)\n"
-                                "   icm   1,3,2(%1)\n"    /* for ptr&2 == 1 */
-                                "   stcm  0,3,2(%1)\n"
-                                "0: sll   1,2\n"
-                                "   la    2,0(1,2)\n" /* r2 points to an icm */
-                                "   l     0,0(%0)\n"  /* get fullword */
-                                "1: lr    1,0\n"      /* cs loop */
-                                "   ex    0,0(2)\n"   /* insert x */
-                                "   cs    0,1,0(%0)\n"
-                                "   jl    1b\n"
-                                "   ex    0,4(2)"     /* store *ptr to x */
-                                : "+&a" (ptr) : "a" (&x)
-                                : "memory", "cc", "0", "1", "2");
-                        break;
-                case 4:
-                        if(((addr_t)ptr)&3)
-				__misaligned_u32();
-                        asm volatile (
-                                "    l    0,0(%1)\n"
-                                "0:  cs   0,%0,0(%1)\n"
-                                "    jl   0b\n"
-                                "    lgfr %0,0\n"
-                                : "+d" (x) : "a" (ptr)
-                                : "memory", "cc", "0" );
-                        break;
-                case 8:
-                        if(((addr_t)ptr)&7)
-				__misaligned_u64();
-                        asm volatile (
-                                "    lg  0,0(%1)\n"
-                                "0:  csg 0,%0,0(%1)\n"
-                                "    jl  0b\n"
-                                "    lgr %0,0\n"
-                                : "+d" (x) : "a" (ptr)
-                                : "memory", "cc", "0" );
-                        break;
+	case 1:
+		addr = (unsigned long) ptr;
+		shift = (3 ^ (addr & 3)) << 3;
+		addr ^= addr & 3;
+		asm volatile(
+			"    l   %0,0(%3)\n"
+			"0:  lr  0,%0\n"
+			"    nr  0,%2\n"
+			"    or  0,%1\n"
+			"    cs  %0,0,0(%3)\n"
+			"    jl  0b\n"
+			: "=&d" (old)
+			: "d" (x << shift), "d" (~(255 << shift)), "a" (addr)
+			: "memory", "cc", "0" );
+		x = old >> shift;
+		break;
+	case 2:
+		addr = (unsigned long) ptr;
+		shift = (2 ^ (addr & 2)) << 3;
+		addr ^= addr & 2;
+		asm volatile(
+			"    l   %0,0(%3)\n"
+			"0:  lr  0,%0\n"
+			"    nr  0,%2\n"
+			"    or  0,%1\n"
+			"    cs  %0,0,0(%3)\n"
+			"    jl  0b\n"
+			: "=&d" (old) 
+			: "d" (x << shift), "d" (~(65535 << shift)), "a" (addr)
+			: "memory", "cc", "0" );
+		x = old >> shift;
+		break;
+	case 4:
+		asm volatile (
+			"    l   %0,0(%2)\n"
+			"0:  cs  %0,%1,0(%2)\n"
+			"    jl  0b\n"
+			: "=&d" (old) : "d" (x), "a" (ptr)
+			: "memory", "cc", "0" );
+		x = old;
+		break;
+	case 8:
+		asm volatile (
+			"    lg  %0,0(%2)\n"
+			"0:  csg %0,%1,0(%2)\n"
+			"    jl  0b\n"
+			: "=&d" (old) : "d" (x), "a" (ptr)
+			: "memory", "cc", "0" );
+		x = old;
+		break;
         }
         return x;
 }

