Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTFBLip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTFBLio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:38:44 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:4563 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262192AbTFBLiT (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 2 Jun 2003 07:38:19 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16091.14923.815819.792026@laputa.namesys.com>
Date: Mon, 2 Jun 2003 15:51:39 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Gianni Tedesco <gianni@scaramanga.co.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>
Subject: Re: const from include/asm-i386/byteorder.h
In-Reply-To: <20030531185709.GK8978@holomorphy.com>
References: <16088.47088.814881.791196@laputa.namesys.com>
	<1054406992.4837.0.camel@sherbert>
	<20030531185709.GK8978@holomorphy.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
X-Windows: graphics hacking :: Roman numerals : sqrt (pi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Sat, 2003-05-31 at 15:10, Nikita Danilov wrote:
 > >> Hello, 
 > >> include/asm-i386/byteorder.h contains strange __const__'s in function
 > >> definitions that have no effect:
 > >> static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
 > >> static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
 > 
 > On Sat, May 31, 2003 at 07:49:53PM +0100, Gianni Tedesco wrote:
 > > shouldn't it be __attribute__((const)) to designate a pure function?
 > 
 > There is an __attribute__((pure)) IIRC.

Gcc info page:

`const'
     Many functions do not examine any values except their arguments,
     and have no effects except the return value.  Basically this is
     just slightly more strict class than the `pure' attribute above,
     since function is not allowed to read global memory.

So, it seems byte swapping functions should be __attribute__((const))

Here is a patch:

replace obsolete __const__ qualifiers on function return type with
__attribute__((const)). 

It also adds missing __attribute__((const)) for
include/asm-i386/byteorder.h:___arch__swab64()

Linus, please apply.

Nikita.
===== include/asm-arm/current.h 1.3 vs edited =====
--- 1.3/include/asm-arm/current.h	Sat Dec 28 19:26:45 2002
+++ edited/include/asm-arm/current.h	Mon Jun  2 14:44:24 2003
@@ -3,7 +3,7 @@
 
 #include <linux/thread_info.h>
 
-static inline struct task_struct *get_current(void) __attribute__ (( __const__ ));
+static inline struct task_struct *get_current(void) __attribute_const;
 
 static inline struct task_struct *get_current(void)
 {
===== include/asm-arm/thread_info.h 1.6 vs edited =====
--- 1.6/include/asm-arm/thread_info.h	Sat Dec 28 19:26:45 2002
+++ edited/include/asm-arm/thread_info.h	Mon Jun  2 14:44:24 2003
@@ -74,7 +74,7 @@
 /*
  * how to get the thread information struct from C
  */
-static inline struct thread_info *current_thread_info(void) __attribute__ (( __const__ ));
+static inline struct thread_info *current_thread_info(void) __attribute_const;
 
 static inline struct thread_info *current_thread_info(void)
 {
===== include/asm-cris/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-cris/byteorder.h	Tue Feb  5 20:56:43 2002
+++ edited/include/asm-cris/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -12,14 +12,14 @@
  * them together into ntohl etc.
  */
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 x)
 {
 	__asm__ ("swapwb %0" : "=r" (x) : "0" (x));
   
 	return(x);
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const __u16 ___arch__swab16(__u16 x)
 {
 	__asm__ ("swapb %0" : "=r" (x) : "0" (x));
 	
===== include/asm-i386/byteorder.h 1.2 vs edited =====
--- 1.2/include/asm-i386/byteorder.h	Fri Oct 11 21:15:35 2002
+++ edited/include/asm-i386/byteorder.h	Mon Jun  2 14:40:24 2003
@@ -8,9 +8,10 @@
 /* For avoiding bswap on i386 */
 #ifdef __KERNEL__
 #include <linux/config.h>
+#include <linux/compiler.h>
 #endif
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 x) 
 {
 #ifdef CONFIG_X86_BSWAP
 	__asm__("bswap %0" : "=r" (x) : "0" (x));
@@ -26,7 +27,7 @@
 
 /* gcc should generate this for open coded C now too. May be worth switching to 
    it because inline assembly cannot be scheduled. -AK */
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("xchgb %b0,%h0"		/* swap bytes		*/
 		: "=q" (x)
@@ -35,7 +36,7 @@
 }
 
 
-static inline __u64 ___arch__swab64(__u64 val) 
+static inline __attribute_const __u64 ___arch__swab64(__u64 val) 
 { 
 	union { 
 		struct { __u32 a,b; } s;
===== include/asm-ia64/byteorder.h 1.2 vs edited =====
--- 1.2/include/asm-ia64/byteorder.h	Tue Feb  5 10:39:14 2002
+++ edited/include/asm-ia64/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -8,7 +8,7 @@
 
 #include <asm/types.h>
 
-static __inline__ __const__ __u64
+static __inline__ __attribute_const __u64
 __ia64_swab64 (__u64 x)
 {
 	__u64 result;
@@ -17,13 +17,13 @@
 	return result;
 }
 
-static __inline__ __const__ __u32
+static __inline__ __attribute_const __u32
 __ia64_swab32 (__u32 x)
 {
 	return __ia64_swab64(x) >> 32;
 }
 
-static __inline__ __const__ __u16
+static __inline__ __attribute_const __u16
 __ia64_swab16(__u16 x)
 {
 	return __ia64_swab64(x) >> 48;
===== include/asm-m68k/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-m68k/byteorder.h	Tue Feb  5 20:39:46 2002
+++ edited/include/asm-m68k/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -5,7 +5,7 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 val)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 val)
 {
 	__asm__("rolw #8,%0; swap %0; rolw #8,%0" : "=d" (val) : "0" (val));
 	return val;
===== include/asm-parisc/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-parisc/byteorder.h	Tue Feb  5 20:39:57 2002
+++ edited/include/asm-parisc/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -5,7 +5,7 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 x)
 {
 	unsigned int temp;
 	__asm__("shd %0, %0, 16, %1\n\t"	/* shift abcdabcd -> cdab */
@@ -28,7 +28,7 @@
 **      HSHR    67452301 -> *6*4*2*0 into %0
 **      OR      %0 | %1  -> 76543210 into %0 (all done!)
 */
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x) {
+static __inline__ __attribute_const __u64 ___arch__swab64(__u64 x) {
 	__u64 temp;
 	__asm__("permh 3210, %0, %0\n\t"
 		"hshl %0, 8, %1\n\t"
@@ -40,7 +40,7 @@
 }
 #define __arch__swab64(x) ___arch__swab64(x)
 #else
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __attribute_const __u64 ___arch__swab64(__u64 x)
 {
 	__u32 t1 = (__u32) x;
 	__u32 t2 = (__u32) ((x) >> 32);
@@ -51,7 +51,7 @@
 #endif
 
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("dep %0, 15, 8, %0\n\t"		/* deposit 00ab -> 0bab */
 		"shd %r0, %0, 8, %0"		/* shift 000000ab -> 00ba */
===== include/asm-ppc/byteorder.h 1.5 vs edited =====
--- 1.5/include/asm-ppc/byteorder.h	Mon Sep 16 08:52:03 2002
+++ edited/include/asm-ppc/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -32,7 +32,7 @@
 	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
+static __inline__ __attribute_const __u16 ___arch__swab16(__u16 value)
 {
 	__u16 result;
 
@@ -40,7 +40,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 value)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
===== include/asm-ppc64/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-ppc64/byteorder.h	Thu Feb 14 15:14:36 2002
+++ edited/include/asm-ppc64/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -40,7 +40,7 @@
 }
 
 #if 0
-static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
+static __inline__ __attribute_const __u16 ___arch__swab16(__u16 value)
 {
 	__u16 result;
 
@@ -50,7 +50,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 value)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
@@ -62,7 +62,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 value)
+static __inline__ __attribute_const __u64 ___arch__swab64(__u64 value)
 {
 	__u64 result;
 #error implement me
===== include/asm-s390/byteorder.h 1.4 vs edited =====
--- 1.4/include/asm-s390/byteorder.h	Mon Apr 14 23:11:58 2003
+++ edited/include/asm-s390/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -14,7 +14,7 @@
 #ifdef __GNUC__
 
 #ifdef __s390x__
-static __inline__ __const__ __u64 ___arch__swab64p(__u64 *x)
+static __inline__ __attribute_const __u64 ___arch__swab64p(__u64 *x)
 {
 	__u64 result;
 
@@ -24,7 +24,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __attribute_const __u64 ___arch__swab64(__u64 x)
 {
 	__u64 result;
 
@@ -40,7 +40,7 @@
 }
 #endif /* __s390x__ */
 
-static __inline__ __const__ __u32 ___arch__swab32p(__u32 *x)
+static __inline__ __attribute_const __u32 ___arch__swab32p(__u32 *x)
 {
 	__u32 result;
 	
@@ -58,7 +58,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 x)
 {
 #ifndef __s390x__
 	return ___arch__swab32p(&x);
@@ -77,7 +77,7 @@
 	*x = ___arch__swab32p(x);
 }
 
-static __inline__ __const__ __u16 ___arch__swab16p(__u16 *x)
+static __inline__ __attribute_const __u16 ___arch__swab16p(__u16 *x)
 {
 	__u16 result;
 	
@@ -93,7 +93,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const __u16 ___arch__swab16(__u16 x)
 {
 	return ___arch__swab16p(&x);
 }
===== include/asm-sh/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-sh/byteorder.h	Tue Feb  5 20:39:53 2002
+++ edited/include/asm-sh/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -7,7 +7,7 @@
 
 #include <asm/types.h>
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("swap.b	%0, %0\n\t"
 		"swap.w %0, %0\n\t"
@@ -17,7 +17,7 @@
 	return x;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __attribute_const __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("swap.b %0, %0"
 		: "=r" (x)
===== include/asm-v850/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-v850/byteorder.h	Fri Nov  1 19:38:12 2002
+++ edited/include/asm-v850/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -18,14 +18,14 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u32 ___arch__swab32 (__u32 word)
+static __inline__ __attribute_const __u32 ___arch__swab32 (__u32 word)
 {
 	__u32 res;
 	__asm__ ("bsw %1, %0" : "=r" (res) : "r" (word));
 	return res;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16 (__u16 half_word)
+static __inline__ __attribute_const __u16 ___arch__swab16 (__u16 half_word)
 {
 	__u16 res;
 	__asm__ ("bsh %1, %0" : "=r" (res) : "r" (half_word));
===== include/asm-x86_64/byteorder.h 1.2 vs edited =====
--- 1.2/include/asm-x86_64/byteorder.h	Fri Apr  4 02:51:08 2003
+++ edited/include/asm-x86_64/byteorder.h	Mon Jun  2 14:44:24 2003
@@ -5,13 +5,13 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __attribute_const __u64 ___arch__swab64(__u64 x)
 {
 	__asm__("bswapq %0" : "=r" (x) : "0" (x));
 	return x;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __attribute_const __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("bswapl %0" : "=r" (x) : "0" (x));
 	return x;
===== include/linux/compiler.h 1.15 vs edited =====
--- 1.15/include/linux/compiler.h	Wed Apr  9 22:15:46 2003
+++ edited/include/linux/compiler.h	Mon Jun  2 14:44:18 2003
@@ -56,6 +56,22 @@
 #define __attribute_used__	__attribute__((__unused__))
 #endif
 
+/* The attribute `pure' is not implemented in GCC versions earlier than 2.96. */
+#if (__GNUC__ > 2) || (__GNUC__ == 2 && __GNUC_MINOR__ >= 96)
+#define __attribute_pure __attribute__ ((__pure__))
+#else
+#define __attribute_pure 
+#endif
+
+/* The attribute `const' is not implemented in GCC versions earlier than 2.5. */
+/* Basically this is just slightly more strict class than the `pure'
+   attribute */
+#if (__GNUC__ > 2) || (__GNUC__ == 2 && __GNUC_MINOR__ >= 5)
+#define __attribute_const __attribute__ ((__const__))
+#else
+#define __attribute_const
+#endif
+
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\
===== include/linux/byteorder/swab.h 1.2 vs edited =====
--- 1.2/include/linux/byteorder/swab.h	Tue Feb  5 10:43:00 2002
+++ edited/include/linux/byteorder/swab.h	Fri May 30 17:34:25 2003
@@ -128,7 +128,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u16 __fswab16(__u16 x)
+static __inline__ __attribute_const __u16 __fswab16(__u16 x)
 {
 	return __arch__swab16(x);
 }
@@ -141,7 +141,7 @@
 	__arch__swab16s(addr);
 }
 
-static __inline__ __const__ __u32 __fswab32(__u32 x)
+static __inline__ __attribute_const __u32 __fswab32(__u32 x)
 {
 	return __arch__swab32(x);
 }
@@ -155,7 +155,7 @@
 }
 
 #ifdef __BYTEORDER_HAS_U64__
-static __inline__ __const__ __u64 __fswab64(__u64 x)
+static __inline__ __attribute_const __u64 __fswab64(__u64 x)
 {
 #  ifdef __SWAB_64_THRU_32__
 	__u32 h = x >> 32;
===== include/linux/byteorder/swabb.h 1.2 vs edited =====
--- 1.2/include/linux/byteorder/swabb.h	Tue Feb  5 10:43:00 2002
+++ edited/include/linux/byteorder/swabb.h	Mon Jun  2 14:44:24 2003
@@ -92,7 +92,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u32 __fswahw32(__u32 x)
+static __inline__ __attribute_const __u32 __fswahw32(__u32 x)
 {
 	return __arch__swahw32(x);
 }
@@ -106,7 +106,7 @@
 }
 
 
-static __inline__ __const__ __u32 __fswahb32(__u32 x)
+static __inline__ __attribute_const __u32 __fswahb32(__u32 x)
 {
 	return __arch__swahb32(x);
 }
