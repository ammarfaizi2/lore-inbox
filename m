Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265382AbTLHMdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 07:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbTLHMdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 07:33:20 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21209 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265382AbTLHMc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 07:32:57 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16340.28530.773834.441426@laputa.namesys.com>
Date: Mon, 8 Dec 2003 15:32:50 +0300
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
In-Reply-To: <br0jji$8b5$1@cesium.transmeta.com>
References: <br0jji$8b5$1@cesium.transmeta.com>
X-Mailer: VM 7.17 under 21.5 (patch 16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > I have been chasing down a bunch of warnings that have been annoying
 > me, and I have observed that a bunch of the byteorder functions are
 > defined in ways similar to:
 > 
 > static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
 > 
 > With -W -Wall at least gcc 3.2.2 will issue a warning:
 > 
 > warning: type qualifiers ignored on function return type
 > 
 > ... which seems to imply the __const__ is ignored.  Reading the gcc
 > documentation it appears the correct syntax is
 > __attribute__((__const__)) rather than __const__.
 > 
 > I have made a patch against the current tree defining
 > __attribute_const__ in <linux/compiler.h> and using it in the above
 > cases; does anyone know any reason why I should *NOT* submit this to
 > Linus?

How about this one: I sent such patch (see below) some time ago and it
did not avail?

 > 
 > 	-hpa

Nikita.

diff -puN include/asm-arm/current.h~const_fn include/asm-arm/current.h
--- i386/include/asm-arm/current.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-arm/current.h	Thu Nov 27 15:22:58 2003
@@ -2,8 +2,9 @@
 #define _ASMARM_CURRENT_H
 
 #include <linux/thread_info.h>
+#include <linux/compiler.h>
 
-static inline struct task_struct *get_current(void) __attribute__ (( __const__ ));
+static inline struct task_struct *get_current(void) __attribute_const__;
 
 static inline struct task_struct *get_current(void)
 {
diff -puN include/asm-arm/thread_info.h~const_fn include/asm-arm/thread_info.h
--- i386/include/asm-arm/thread_info.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-arm/thread_info.h	Thu Nov 27 15:22:58 2003
@@ -76,7 +76,7 @@ struct thread_info {
 /*
  * how to get the thread information struct from C
  */
-static inline struct thread_info *current_thread_info(void) __attribute__ (( __const__ ));
+static inline struct thread_info *current_thread_info(void) __const_fn;
 
 static inline struct thread_info *current_thread_info(void)
 {
diff -puN include/asm-i386/byteorder.h~const_fn include/asm-i386/byteorder.h
--- i386/include/asm-i386/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-i386/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -10,7 +10,9 @@
 #include <linux/config.h>
 #endif
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+#include <linux/compiler.h>
+
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x) 
 {
 #ifdef CONFIG_X86_BSWAP
 	__asm__("bswap %0" : "=r" (x) : "0" (x));
@@ -26,7 +28,7 @@ static __inline__ __const__ __u32 ___arc
 
 /* gcc should generate this for open coded C now too. May be worth switching to 
    it because inline assembly cannot be scheduled. -AK */
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("xchgb %b0,%h0"		/* swap bytes		*/
 		: "=q" (x)
@@ -35,7 +37,7 @@ static __inline__ __const__ __u16 ___arc
 }
 
 
-static inline __u64 ___arch__swab64(__u64 val) 
+static inline __attribute_const__ __u64 ___arch__swab64(__u64 val) 
 { 
 	union { 
 		struct { __u32 a,b; } s;
diff -puN include/asm-ia64/byteorder.h~const_fn include/asm-ia64/byteorder.h
--- i386/include/asm-ia64/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-ia64/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -8,8 +8,9 @@
 
 #include <asm/types.h>
 #include <asm/intrinsics.h>
-
-static __inline__ __const__ __u64
+#include <linux/compiler.h>
+  
+static __inline__ __attribute_const__ __u64
 __ia64_swab64 (__u64 x)
 {
 	__u64 result;
@@ -18,13 +19,13 @@ __ia64_swab64 (__u64 x)
 	return result;
 }
 
-static __inline__ __const__ __u32
+static __inline__ __attribute_const__ __u32
 __ia64_swab32 (__u32 x)
 {
 	return __ia64_swab64(x) >> 32;
 }
 
-static __inline__ __const__ __u16
+static __inline__ __attribute_const__ __u16
 __ia64_swab16(__u16 x)
 {
 	return __ia64_swab64(x) >> 48;
diff -puN include/asm-m68k/byteorder.h~const_fn include/asm-m68k/byteorder.h
--- i386/include/asm-m68k/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-m68k/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -5,7 +5,9 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 val)
+#include <linux/compiler.h>
+
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 val)
 {
 	__asm__("rolw #8,%0; swap %0; rolw #8,%0" : "=d" (val) : "0" (val));
 	return val;
diff -puN include/asm-parisc/byteorder.h~const_fn include/asm-parisc/byteorder.h
--- i386/include/asm-parisc/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-parisc/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -5,7 +5,7 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("dep %0, 15, 8, %0\n\t"		/* deposit 00ab -> 0bab */
 		"shd %%r0, %0, 8, %0"		/* shift 000000ab -> 00ba */
@@ -14,7 +14,7 @@ static __inline__ __const__ __u16 ___arc
 	return x;
 }
 
-static __inline__ __const__ __u32 ___arch__swab24(__u32 x)
+static __inline__ __attribute_const__ __u32 ___arch__swab24(__u32 x)
 {
 	__asm__("shd %0, %0, 8, %0\n\t"		/* shift xabcxabc -> cxab */
 		"dep %0, 15, 8, %0\n\t"		/* deposit cxab -> cbab */
@@ -24,7 +24,9 @@ static __inline__ __const__ __u32 ___arc
 	return x;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+#include <linux/compiler.h>
+
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 	unsigned int temp;
 	__asm__("shd %0, %0, 16, %1\n\t"	/* shift abcdabcd -> cdab */
@@ -47,7 +49,7 @@ static __inline__ __const__ __u32 ___arc
 **      HSHR    67452301 -> *6*4*2*0 into %0
 **      OR      %0 | %1  -> 76543210 into %0 (all done!)
 */
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x) {
+static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 x) {
 	__u64 temp;
 	__asm__("permh,3210 %0, %0\n\t"
 		"hshl %0, 8, %1\n\t"
@@ -60,7 +62,7 @@ static __inline__ __const__ __u64 ___arc
 #define __arch__swab64(x) ___arch__swab64(x)
 #define __BYTEORDER_HAS_U64__
 #elif !defined(__STRICT_ANSI__)
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 x)
 {
 	__u32 t1 = ___arch__swab32((__u32) x);
 	__u32 t2 = ___arch__swab32((__u32) (x >> 32));
diff -puN include/asm-ppc/byteorder.h~const_fn include/asm-ppc/byteorder.h
--- i386/include/asm-ppc/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-ppc/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -4,8 +4,11 @@
 #include <asm/types.h>
 
 #ifdef __GNUC__
+
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
+
 extern __inline__ unsigned ld_le16(const volatile unsigned short *addr)
 {
 	unsigned val;
@@ -32,7 +35,7 @@ extern __inline__ void st_le32(volatile 
 	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
 {
 	__u16 result;
 
@@ -40,7 +43,7 @@ static __inline__ __const__ __u16 ___arc
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 value)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
diff -puN include/asm-ppc64/byteorder.h~const_fn include/asm-ppc64/byteorder.h
--- i386/include/asm-ppc64/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-ppc64/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -13,6 +13,8 @@
 #ifdef __GNUC__
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
+
 static __inline__ __u16 ld_le16(const volatile __u16 *addr)
 {
 	__u16 val;
@@ -40,7 +42,7 @@ static __inline__ void st_le32(volatile 
 }
 
 #if 0
-static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
 {
 	__u16 result;
 
@@ -50,7 +52,7 @@ static __inline__ __const__ __u16 ___arc
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 value)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
@@ -62,7 +64,7 @@ static __inline__ __const__ __u32 ___arc
 	return result;
 }
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 value)
+static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 value)
 {
 	__u64 result;
 #error implement me
diff -puN include/asm-s390/byteorder.h~const_fn include/asm-s390/byteorder.h
--- i386/include/asm-s390/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-s390/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -13,8 +13,10 @@
 
 #ifdef __GNUC__
 
+#include <linux/compiler.h>
+
 #ifdef __s390x__
-static __inline__ __const__ __u64 ___arch__swab64p(__u64 *x)
+static __inline__ __attribute_const__ __u64 ___arch__swab64p(__u64 *x)
 {
 	__u64 result;
 
@@ -24,7 +26,7 @@ static __inline__ __const__ __u64 ___arc
 	return result;
 }
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 x)
 {
 	__u64 result;
 
@@ -40,7 +42,7 @@ static __inline__ void ___arch__swab64s(
 }
 #endif /* __s390x__ */
 
-static __inline__ __const__ __u32 ___arch__swab32p(__u32 *x)
+static __inline__ __attribute_const__ __u32 ___arch__swab32p(__u32 *x)
 {
 	__u32 result;
 	
@@ -58,7 +60,7 @@ static __inline__ __const__ __u32 ___arc
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 #ifndef __s390x__
 	return ___arch__swab32p(&x);
@@ -77,7 +79,7 @@ static __inline__ void ___arch__swab32s(
 	*x = ___arch__swab32p(x);
 }
 
-static __inline__ __const__ __u16 ___arch__swab16p(__u16 *x)
+static __inline__ __attribute_const__ __u16 ___arch__swab16p(__u16 *x)
 {
 	__u16 result;
 	
@@ -93,7 +95,7 @@ static __inline__ __const__ __u16 ___arc
 	return result;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	return ___arch__swab16p(&x);
 }
diff -puN include/asm-sh/byteorder.h~const_fn include/asm-sh/byteorder.h
--- i386/include/asm-sh/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-sh/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -6,8 +6,9 @@
  */
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("swap.b	%0, %0\n\t"
 		"swap.w %0, %0\n\t"
@@ -17,7 +18,7 @@ static __inline__ __const__ __u32 ___arc
 	return x;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("swap.b %0, %0"
 		: "=r" (x)
diff -puN include/asm-v850/byteorder.h~const_fn include/asm-v850/byteorder.h
--- i386/include/asm-v850/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-v850/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -18,14 +18,16 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u32 ___arch__swab32 (__u32 word)
+#include <linux/compiler.h>
+
+static __inline__ __attribute_const__ __u32 ___arch__swab32 (__u32 word)
 {
 	__u32 res;
 	__asm__ ("bsw %1, %0" : "=r" (res) : "r" (word));
 	return res;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16 (__u16 half_word)
+static __inline__ __attribute_const__ __u16 ___arch__swab16 (__u16 half_word)
 {
 	__u16 res;
 	__asm__ ("bsh %1, %0" : "=r" (res) : "r" (half_word));
diff -puN include/asm-x86_64/byteorder.h~const_fn include/asm-x86_64/byteorder.h
--- i386/include/asm-x86_64/byteorder.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/asm-x86_64/byteorder.h	Thu Nov 27 15:22:58 2003
@@ -5,13 +5,15 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+#include <linux/compiler.h>
+
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
diff -puN include/linux/compiler.h~const_fn include/linux/compiler.h
--- i386/include/linux/compiler.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/linux/compiler.h	Thu Nov 27 15:22:58 2003
@@ -76,6 +76,11 @@
 # define __attribute_pure__	/* unimplemented */
 #endif
 
+#ifndef __attribute_const__
+# define __attribute_const__	/* unimplemented */
+#endif
+
+
 /* Optimization barrier */
 #ifndef barrier
 # define barrier() __memory_barrier()
diff -puN include/linux/byteorder/swab.h~const_fn include/linux/byteorder/swab.h
--- i386/include/linux/byteorder/swab.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/linux/byteorder/swab.h	Thu Nov 27 15:22:58 2003
@@ -1,6 +1,8 @@
 #ifndef _LINUX_BYTEORDER_SWAB_H
 #define _LINUX_BYTEORDER_SWAB_H
 
+#include <linux/compiler.h>
+
 /*
  * linux/byteorder/swab.h
  * Byte-swapping, independently from CPU endianness
@@ -128,7 +130,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u16 __fswab16(__u16 x)
+static __inline__ __attribute_const__ __u16 __fswab16(__u16 x)
 {
 	return __arch__swab16(x);
 }
@@ -141,7 +143,7 @@ static __inline__ void __swab16s(__u16 *
 	__arch__swab16s(addr);
 }
 
-static __inline__ __const__ __u32 __fswab32(__u32 x)
+static __inline__ __attribute_const__ __u32 __fswab32(__u32 x)
 {
 	return __arch__swab32(x);
 }
@@ -155,7 +157,7 @@ static __inline__ void __swab32s(__u32 *
 }
 
 #ifdef __BYTEORDER_HAS_U64__
-static __inline__ __const__ __u64 __fswab64(__u64 x)
+static __inline__ __attribute_const__ __u64 __fswab64(__u64 x)
 {
 #  ifdef __SWAB_64_THRU_32__
 	__u32 h = x >> 32;
diff -puN include/linux/byteorder/swabb.h~const_fn include/linux/byteorder/swabb.h
--- i386/include/linux/byteorder/swabb.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/linux/byteorder/swabb.h	Thu Nov 27 15:22:58 2003
@@ -1,6 +1,8 @@
 #ifndef _LINUX_BYTEORDER_SWABB_H
 #define _LINUX_BYTEORDER_SWABB_H
 
+#include <linux/compiler.h>
+
 /*
  * linux/byteorder/swabb.h
  * SWAp Bytes Bizarrely
@@ -92,7 +94,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u32 __fswahw32(__u32 x)
+static __inline__ __attribute_const__ __u32 __fswahw32(__u32 x)
 {
 	return __arch__swahw32(x);
 }
@@ -106,7 +108,7 @@ static __inline__ void __swahw32s(__u32 
 }
 
 
-static __inline__ __const__ __u32 __fswahb32(__u32 x)
+static __inline__ __attribute_const__ __u32 __fswahb32(__u32 x)
 {
 	return __arch__swahb32(x);
 }
diff -puN include/linux/compiler-gcc2.h~const_fn include/linux/compiler-gcc2.h
--- i386/include/linux/compiler-gcc2.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/linux/compiler-gcc2.h	Thu Nov 27 15:22:58 2003
@@ -21,3 +21,9 @@
 #if __GNUC_MINOR__ >= 96
 # define __attribute_pure__	__attribute__((pure))
 #endif
+
+/* The attribute `const' is not implemented in GCC versions earlier than
+   2.5. We are not interested in elder compilers. */
+/* Basically this is just slightly more strict class than the `pure'
+   attribute */
+#define __attribute_const__ __attribute__ ((__const__))
diff -puN include/linux/compiler-gcc3.h~const_fn include/linux/compiler-gcc3.h
--- i386/include/linux/compiler-gcc3.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/linux/compiler-gcc3.h	Thu Nov 27 15:22:58 2003
@@ -20,3 +20,4 @@
 #endif
 
 #define __attribute_pure__	__attribute__((pure))
+#define __attribute_const__ __attribute__ ((__const__))
diff -puN include/linux/compiler-gcc+.h~const_fn include/linux/compiler-gcc+.h
--- i386/include/linux/compiler-gcc+.h~const_fn	Thu Nov 27 15:22:58 2003
+++ i386-nikita/include/linux/compiler-gcc+.h	Thu Nov 27 15:22:58 
