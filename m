Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUIKUyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUIKUyI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUIKUx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:53:57 -0400
Received: from hcc022004.bai.ne.jp ([210.171.22.4]:43145 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S268314AbUIKUvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:51:21 -0400
Date: Sun, 12 Sep 2004 05:51:19 +0900 (JST)
Message-Id: <20040912.055119.424243625.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm4 5/6] [m32r] Update checksum functions
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
In-Reply-To: <20040912.052403.730551818.takata@linux-m32r.org>
References: <20040912.052403.730551818.takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc1-mm4 5/6] [m32r] Update checksum functions
  This patch update checksum routines.
  And EXPORT_SYMBOL() is moved from m32r_ksyms.c to csum_partial_copy.c.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/m32r_ksyms.c     |    2 
 arch/m32r/lib/csum_partial_copy.c |   39 ++--------
 include/asm-m32r/checksum.h       |  136 +++++++++++---------------------------
 3 files changed, 52 insertions(+), 125 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/m32r_ksyms.c linux-2.6.9-rc1-mm4/arch/m32r/kernel/m32r_ksyms.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/m32r_ksyms.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/kernel/m32r_ksyms.c	2004-09-09 01:39:58.000000000 +0900
@@ -14,7 +14,6 @@
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
 #include <asm/io.h>
-#include <asm/hardirq.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/tlbflush.h>
@@ -42,7 +41,6 @@ EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(__down_trylock);
 
 /* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy);
 /* Delay loops */
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/lib/csum_partial_copy.c linux-2.6.9-rc1-mm4/arch/m32r/lib/csum_partial_copy.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/lib/csum_partial_copy.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/lib/csum_partial_copy.c	2004-09-09 23:06:24.000000000 +0900
@@ -14,38 +14,34 @@
  *		as published by the Free Software Foundation; either version
  *		2 of the License, or (at your option) any later version.
  *
- * $Id$
  */
-#include <net/checksum.h>
+
+#include <linux/module.h>
 #include <linux/types.h>
+
+#include <net/checksum.h>
 #include <asm/byteorder.h>
 #include <asm/string.h>
 #include <asm/uaccess.h>
 
 /*
- * copy while checksumming, otherwise like csum_partial
+ * Copy while checksumming, otherwise like csum_partial
  */
-unsigned int csum_partial_copy(const char *src, char *dst,
-                               int len, int sum)
+unsigned int csum_partial_copy_nocheck (const char *src, char *dst,
+                                        int len, unsigned int sum)
 {
-	/*
-	 * It's 2:30 am and I don't feel like doing it real ...
-	 * This is lots slower than the real thing (tm)
-	 */
 	sum = csum_partial(src, len, sum);
 	memcpy(dst, src, len);
 
 	return sum;
 }
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
 /*
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
-unsigned int csum_partial_copy_from_user (const char *src, char *dst,
-                                          int len, unsigned int sum,
-                                          int *err_ptr)
  */
-unsigned int csum_partial_copy_generic_from (const char *src, char *dst,
+unsigned int csum_partial_copy_from_user (const char __user *src, char *dst,
                                           int len, unsigned int sum,
                                           int *err_ptr)
 {
@@ -59,19 +55,4 @@ unsigned int csum_partial_copy_generic_f
 
 	return csum_partial(dst, len-missing, sum);
 }
-unsigned int csum_partial_copy_generic_to (const char *src, char *dst,
-                                          int len, unsigned int sum,
-                                          int *err_ptr)
-{
-	int missing;
-
-	missing = copy_to_user(dst, src, len);
-	if (missing) {
-/*
-		memset(dst + len - missing, 0, missing);
-*/
-		*err_ptr = -EFAULT;
-	}
-
-	return csum_partial(src, len-missing, sum);
-}
+EXPORT_SYMBOL(csum_partial_copy_from_user);
diff -ruNp linux-2.6.9-rc1-mm4.orig/include/asm-m32r/checksum.h linux-2.6.9-rc1-mm4/include/asm-m32r/checksum.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/checksum.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4/include/asm-m32r/checksum.h	2004-09-09 21:05:16.000000000 +0900
@@ -1,14 +1,20 @@
+#ifdef __KERNEL__
 #ifndef _ASM_M32R_CHECKSUM_H
 #define _ASM_M32R_CHECKSUM_H
 
-/* $Id$ */
-
 /*
- *  linux/include/asm-m32r/atomic.h
- *    orig : i386 2.4.10
+ * include/asm-m32r/checksum.h
+ *
+ * IP/TCP/UDP checksum routines
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Some code taken from mips and parisc architecture.
  *
- *  M32R version:
  *    Copyright (C) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata
+ *    Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
  */
 
 #include <linux/in6.h>
@@ -25,71 +31,31 @@
  *
  * it's best to have buff aligned on a 32-bit boundary
  */
-asmlinkage unsigned int csum_partial(const unsigned char * buff, int len, unsigned int sum);
+asmlinkage unsigned int csum_partial(const unsigned char *buff, int len, unsigned int sum);
 
 /*
- * the same as csum_partial, but copies from src while it
- * checksums, and handles user-space pointer exceptions correctly, when needed.
+ * The same as csum_partial, but copies from src while it checksums.
  *
- * here even more important to align src and dst on a 32-bit (or even
+ * Here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-
-asmlinkage unsigned int csum_partial_copy_generic(const char *src, char *dst,
-		int len, int sum, int *src_err_ptr, int *dst_err_ptr);
+extern unsigned int csum_partial_copy_nocheck(const char *src, char *dst,
+                                              int len, unsigned int sum);
 
 /*
- *	Note: when you get a NULL pointer exception here this means someone
- *	passed in an incorrect kernel address to one of these functions.
- *
- *	If you use these functions directly please don't forget the
- *	verify_area().
+ * This is a new version of the above that records errors it finds in *errp,
+ * but continues and zeros thre rest of the buffer.
  */
-
-extern unsigned int csum_partial_copy(const char *src, char *dst,
-		int len, int sum);
-extern unsigned int csum_partial_copy_generic_from(const char *src,
-		char *dst, int len, unsigned int sum, int *err_ptr);
-extern unsigned int csum_partial_copy_generic_to (const char *src,
-		char *dst, int len, unsigned int sum, int *err_ptr);
-
-extern __inline__
-unsigned int csum_partial_copy_nocheck ( const char *src, char *dst,
-					int len, int sum)
-{
-#if 0
-	return csum_partial_copy_generic ( src, dst, len, sum, NULL, NULL);
-#else
-	return  csum_partial_copy( src, dst, len, sum);
-#endif
-}
-
-extern __inline__
-unsigned int csum_partial_copy_from_user ( const char __user *src, char *dst,
-						int len, int sum, int *err_ptr)
-{
-#if 0
-	return csum_partial_copy_generic ( src, dst, len, sum, err_ptr, NULL);
-#else
-	return csum_partial_copy_generic_from ( src, dst, len, sum, err_ptr);
-#endif
-}
-
-/*
- * These are the old (and unsafe) way of doing checksums, a warning message will be
- * printed if they are used and an exeption occurs.
- *
- * these functions should go away after some time.
- */
-
-#define csum_partial_copy_fromuser csum_partial_copy
-unsigned int csum_partial_copy( const char *src, char *dst, int len, int sum);
+extern unsigned int csum_partial_copy_from_user(const char __user *src,
+                                                char *dst,
+                                                int len, unsigned int sum,
+                                                int *err_ptr);
 
 /*
  *	Fold a partial checksum
  */
 
-static __inline__ unsigned int csum_fold(unsigned int sum)
+static inline unsigned int csum_fold(unsigned int sum)
 {
 	unsigned long tmpreg;
 	__asm__(
@@ -106,15 +72,12 @@ static __inline__ unsigned int csum_fold
 	);
 	return sum;
 }
-
+
 /*
- *	This is a version of ip_compute_csum() optimized for IP headers,
- *	which always checksum on 4 octet boundaries.
- *
- *	By Jorge Cwik <jorge@laser.satlink.net>, adapted for linux by
- *	Arnt Gulbrandsen.
+ * This is a version of ip_compute_csum() optimized for IP headers,
+ * which always checksum on 4 octet boundaries.
  */
-static __inline__ unsigned short ip_fast_csum(unsigned char * iph,
+static inline unsigned short ip_fast_csum(unsigned char * iph,
 					  unsigned int ihl) {
 	unsigned long sum, tmpreg0, tmpreg1;
 
@@ -150,11 +113,11 @@ static __inline__ unsigned short ip_fast
 	return csum_fold(sum);
 }
 
-static __inline__ unsigned long csum_tcpudp_nofold(unsigned long saddr,
-						   unsigned long daddr,
-						   unsigned short len,
-						   unsigned short proto,
-						   unsigned int sum)
+static inline unsigned long csum_tcpudp_nofold(unsigned long saddr,
+					       unsigned long daddr,
+					       unsigned short len,
+					       unsigned short proto,
+					       unsigned int sum)
 {
 #if defined(__LITTLE_ENDIAN)
 	unsigned long len_proto = (ntohs(len)<<16)+proto*256;
@@ -182,11 +145,11 @@ static __inline__ unsigned long csum_tcp
  * computes the checksum of the TCP/UDP pseudo-header
  * returns a 16-bit checksum, already complemented
  */
-static __inline__ unsigned short int csum_tcpudp_magic(unsigned long saddr,
+static inline unsigned short int csum_tcpudp_magic(unsigned long saddr,
 						   unsigned long daddr,
 						   unsigned short len,
 						   unsigned short proto,
-						   unsigned int sum)
+						   unsigned int sum)
 {
 	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
 }
@@ -196,16 +159,16 @@ static __inline__ unsigned short int csu
  * in icmp.c
  */
 
-static __inline__ unsigned short ip_compute_csum(unsigned char * buff, int len) {
+static inline unsigned short ip_compute_csum(unsigned char * buff, int len) {
 	return csum_fold (csum_partial(buff, len, 0));
 }
 
 #define _HAVE_ARCH_IPV6_CSUM
-static __inline__ unsigned short int csum_ipv6_magic(struct in6_addr *saddr,
-						     struct in6_addr *daddr,
-						     __u16 len,
-						     unsigned short proto,
-						     unsigned int sum)
+static inline unsigned short int csum_ipv6_magic(struct in6_addr *saddr,
+						 struct in6_addr *daddr,
+						 __u16 len,
+						 unsigned short proto,
+						 unsigned int sum)
 {
 	unsigned long tmpreg0, tmpreg1, tmpreg2, tmpreg3;
 	__asm__(
@@ -231,7 +194,7 @@ static __inline__ unsigned short int csu
 		"	addx	%0, %1 \n"
 		: "=&r" (sum), "=&r" (tmpreg0), "=&r" (tmpreg1),
 		  "=&r" (tmpreg2), "=&r" (tmpreg3)
-		: "r" (saddr), "r" (daddr),
+		: "r" (saddr), "r" (daddr),
 		  "r" (htonl((__u32) (len))), "r" (htonl(proto)), "0" (sum)
 		: "cbit"
 	);
@@ -239,20 +202,5 @@ static __inline__ unsigned short int csu
 	return csum_fold(sum);
 }
 
-/*
- *	Copy and checksum to user
- */
-#define HAVE_CSUM_COPY_USER
-static __inline__ unsigned int csum_and_copy_to_user (const char *src, char *dst,
-				    int len, int sum, int *err_ptr)
-{
-	if (access_ok(VERIFY_WRITE, dst, len))
-		return csum_partial_copy_generic_to(src, dst, len, sum, err_ptr);
-
-	if (len)
-		*err_ptr = -EFAULT;
-
-	return -1; /* invalid checksum */
-}
-
 #endif /* _ASM_M32R_CHECKSUM_H */
+#endif /* __KERNEL__ */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
