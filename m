Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVFLL0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVFLL0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVFLLYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:24:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26085 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262205AbVFLLVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:21:23 -0400
Date: Sun, 12 Jun 2005 13:21:16 +0200 (MEST)
Message-Id: <200506121121.j5CBLGd4019750@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 7/9] gcc4: fix const function warnings
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc4 generates tons of compile-time warnings like:

/tmp/linux-2.4.31/include/linux/byteorder/swab.h:160: warning: type qualifiers ignored on function return type
/tmp/linux-2.4.31/include/linux/byteorder/swab.h:173: warning: type qualifiers ignored on function return type
/tmp/linux-2.4.31/include/linux/byteorder/swab.h:186: warning: type qualifiers ignored on function return type
/tmp/linux-2.4.31/include/linux/byteorder/swab.h:200: warning: type qualifiers ignored on function return type

This is because functions need to use an attribute to declare const-ness.
Simply putting a 'const' in the return type doesn't work.

The fix (backport from 2.6) is to add __attribute_const__ to compiler.h
and s/const/__attribute_const__/ in the offending function declarations.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 fs/hfs/trans.c                 |    3 ++-
 include/asm-i386/byteorder.h   |    5 +++--
 include/asm-ppc/byteorder.h    |    5 +++--
 include/asm-ppc/time.h         |    3 ++-
 include/asm-x86_64/byteorder.h |    5 +++--
 include/linux/byteorder/swab.h |   10 ++++++----
 include/linux/compiler.h       |    6 ++++++
 7 files changed, 25 insertions(+), 12 deletions(-)

diff -rupN linux-2.4.31/fs/hfs/trans.c linux-2.4.31.gcc4-const-function-warnings/fs/hfs/trans.c
--- linux-2.4.31/fs/hfs/trans.c	2001-02-22 15:23:47.000000000 +0100
+++ linux-2.4.31.gcc4-const-function-warnings/fs/hfs/trans.c	2005-06-12 11:48:10.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/hfs_fs_i.h>
 #include <linux/hfs_fs.h>
+#include <linux/compiler.h>
 
 /*================ File-local variables ================*/
 
@@ -78,7 +79,7 @@ static unsigned char mac2latin_map[128] 
  *
  * Given a hexadecimal digit in ASCII, return the integer representation.
  */
-static inline const unsigned char dehex(char c) {
+static inline __attribute_const__ unsigned char dehex(char c) {
 	if ((c>='0')&&(c<='9')) {
 		return c-'0';
 	}
diff -rupN linux-2.4.31/include/asm-i386/byteorder.h linux-2.4.31.gcc4-const-function-warnings/include/asm-i386/byteorder.h
--- linux-2.4.31/include/asm-i386/byteorder.h	2003-06-14 13:30:27.000000000 +0200
+++ linux-2.4.31.gcc4-const-function-warnings/include/asm-i386/byteorder.h	2005-06-12 11:48:10.000000000 +0200
@@ -2,6 +2,7 @@
 #define _I386_BYTEORDER_H
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
 #ifdef __GNUC__
 
@@ -10,7 +11,7 @@
 #include <linux/config.h>
 #endif
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 #ifdef CONFIG_X86_BSWAP
 	__asm__("bswap %0" : "=r" (x) : "0" (x));
@@ -26,7 +27,7 @@ static __inline__ __const__ __u32 ___arc
 
 /* gcc should generate this for open coded C now too. May be worth switching to 
    it because inline assembly cannot be scheduled. -AK */
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("xchgb %b0,%h0"		/* swap bytes		*/
 		: "=q" (x)
diff -rupN linux-2.4.31/include/asm-ppc/byteorder.h linux-2.4.31.gcc4-const-function-warnings/include/asm-ppc/byteorder.h
--- linux-2.4.31/include/asm-ppc/byteorder.h	2003-06-14 13:30:28.000000000 +0200
+++ linux-2.4.31.gcc4-const-function-warnings/include/asm-ppc/byteorder.h	2005-06-12 11:48:10.000000000 +0200
@@ -2,6 +2,7 @@
 #define _PPC_BYTEORDER_H
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
 #ifdef __GNUC__
 #ifdef __KERNEL__
@@ -50,7 +51,7 @@ extern __inline__ void st_le64(volatile 
 	__asm__ __volatile__ ("stwbrx  %1,0,%2" : "=m" (*addr) : "r" (val), "r" (taddr+4));
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
 {
 	__u16 result;
 
@@ -58,7 +59,7 @@ static __inline__ __const__ __u16 ___arc
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 value)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
diff -rupN linux-2.4.31/include/asm-ppc/time.h linux-2.4.31.gcc4-const-function-warnings/include/asm-ppc/time.h
--- linux-2.4.31/include/asm-ppc/time.h	2003-08-25 20:07:49.000000000 +0200
+++ linux-2.4.31.gcc4-const-function-warnings/include/asm-ppc/time.h	2005-06-12 11:48:10.000000000 +0200
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/mc146818rtc.h>
 #include <linux/threads.h>
+#include <linux/compiler.h>
 
 #include <asm/processor.h>
 
@@ -57,7 +58,7 @@ static __inline__ void set_dec(unsigned 
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
 #ifdef CONFIG_6xx
-extern __inline__ int const __USE_RTC(void) {
+extern __inline__ int __attribute_const__ __USE_RTC(void) {
 	return (mfspr(SPRN_PVR)>>16) == 1;
 }
 #else
diff -rupN linux-2.4.31/include/asm-x86_64/byteorder.h linux-2.4.31.gcc4-const-function-warnings/include/asm-x86_64/byteorder.h
--- linux-2.4.31/include/asm-x86_64/byteorder.h	2002-11-30 17:12:31.000000000 +0100
+++ linux-2.4.31.gcc4-const-function-warnings/include/asm-x86_64/byteorder.h	2005-06-12 11:48:10.000000000 +0200
@@ -2,16 +2,17 @@
 #define _X86_64_BYTEORDER_H
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 x)
 {
 	__asm__("bswapq %0" : "=r" (x) : "0" (x));
 	return x;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("bswapl %0" : "=r" (x) : "0" (x));
 	return x;
diff -rupN linux-2.4.31/include/linux/byteorder/swab.h linux-2.4.31.gcc4-const-function-warnings/include/linux/byteorder/swab.h
--- linux-2.4.31/include/linux/byteorder/swab.h	2002-11-30 17:12:31.000000000 +0100
+++ linux-2.4.31.gcc4-const-function-warnings/include/linux/byteorder/swab.h	2005-06-12 11:48:10.000000000 +0200
@@ -15,6 +15,8 @@
  *
  */
 
+#include <linux/compiler.h>
+
 /* casts are necessary for constants, because we never know how for sure
  * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
  */
@@ -156,7 +158,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u16 __fswab16(__u16 x)
+static __inline__ __attribute_const__ __u16 __fswab16(__u16 x)
 {
 	return __arch__swab16(x);
 }
@@ -169,7 +171,7 @@ static __inline__ void __swab16s(__u16 *
 	__arch__swab16s(addr);
 }
 
-static __inline__ __const__ __u32 __fswab24(__u32 x)
+static __inline__ __attribute_const__ __u32 __fswab24(__u32 x)
 {
 	return __arch__swab24(x);
 }
@@ -182,7 +184,7 @@ static __inline__ void __swab24s(__u32 *
 	__arch__swab24s(addr);
 }
 
-static __inline__ __const__ __u32 __fswab32(__u32 x)
+static __inline__ __attribute_const__ __u32 __fswab32(__u32 x)
 {
 	return __arch__swab32(x);
 }
@@ -196,7 +198,7 @@ static __inline__ void __swab32s(__u32 *
 }
 
 #ifdef __BYTEORDER_HAS_U64__
-static __inline__ __const__ __u64 __fswab64(__u64 x)
+static __inline__ __attribute_const__ __u64 __fswab64(__u64 x)
 {
 #  ifdef __SWAB_64_THRU_32__
 	__u32 h = x >> 32;
diff -rupN linux-2.4.31/include/linux/compiler.h linux-2.4.31.gcc4-const-function-warnings/include/linux/compiler.h
--- linux-2.4.31/include/linux/compiler.h	2004-11-17 18:36:42.000000000 +0100
+++ linux-2.4.31.gcc4-const-function-warnings/include/linux/compiler.h	2005-06-12 11:48:10.000000000 +0200
@@ -27,6 +27,12 @@
 #define __attribute_used__	/* not implemented */
 #endif /* __GNUC__ */
 
+#if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 96)
+#define __attribute_const__	__attribute__((__const__))
+#else
+#define __attribute_const__	/* unimplemented */
+#endif
+
 #if __GNUC__ == 3
 #if __GNUC_MINOR__ >= 1
 # define inline         __inline__ __attribute__((always_inline))
