Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTGOFDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTGOFDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:03:18 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:43197 "HELO
	develer.com") by vger.kernel.org with SMTP id S262254AbTGOFDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:03:08 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: george anzinger <george@mvista.com>
Subject: Re: do_div64 generic
Date: Tue, 15 Jul 2003 07:17:54 +0200
User-Agent: KMail/1.5.9
References: <3F1360F4.2040602@mvista.com>
In-Reply-To: <3F1360F4.2040602@mvista.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
       Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307150717.54981.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 04:03, george anzinger wrote:

> As part of the timer conversion and POSIX timers the following was
> added to the x86 kernels do_div64().  What we want is a u64/u32 that
> also returns the remainder.  (As in nsecs/NSEC_PER_SEC returns seconds
> and nsecs to fill in the timespec structure.)

I see. do_div() which updates the dividend in-place did not quite apply
to the usage pattern of the new timer code.

> The using code tests for the existance of div_long_long_rem and uses
> the longer do_div() if it does not exist.
>
> Could you consider adding this to the generic code?
>
> /*
>   * (long)X = ((long long)divs) / (long)div
>   * (long)rem = ((long long)divs) % (long)div
>   *
>   * Warning, this will do an exception if X overflows.
>   */
> #define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)
>
> extern inline long
> div_ll_X_l_rem(long long divs, long div, long *rem)
> {
> 	long dum2;
>        __asm__("divl %2":"=a"(dum2), "=d"(*rem)
>
>        :	"rm"(div), "A"(divs));
>
> 	return dum2;
>
> }

Here's a patch that takes care of all architectures. Being somewhat
invasive, I'd like to have this code tested on a few more archs
before asking Linus to apply. Could you please try it on your targets?

--------------------------------------------------------------------------

 - div_long_long_rem(): add a generic version in asm-generic/div64.h;

 - add div_long_long_rem() implemented in terms of do_div() for those
   architectures that define their own assembly optimized version;

 - asm-arm/div64.h:do_div(): add missing parenthesis for macro args

 - kill dupes of div_long_long_rem() defined on-the-fly in
   linux/time.h and kernel/posix-timers.c;

 - make div_long_long_rem() arguments consistent with do_div() and
   its current usage (it's u64/u32 -> u32/u32).

 - add casts where a signed integer was being passed for the remainder;

Applies to 2.6.0-test1. Tested on i386 and m68knommu. Sorry if it
breaks anything else (it shouldn't, but...).


diff -Nrup linux-2.6.0-test1.orig/include/asm-generic/div64.h linux-2.6.0-test1/include/asm-generic/div64.h
--- linux-2.6.0-test1.orig/include/asm-generic/div64.h	2003-07-14 05:37:32.000000000 +0200
+++ linux-2.6.0-test1/include/asm-generic/div64.h	2003-07-15 04:56:08.000000000 +0200
@@ -4,6 +4,7 @@
  * Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>
  * Based on former asm-ppc/div64.h and asm-m68knommu/div64.h
  *
+ *
  * The semantics of do_div() are:
  *
  * uint32_t do_div(uint64_t *n, uint32_t base)
@@ -15,6 +16,17 @@
  *
  * NOTE: macro parameter n is evaluated multiple times,
  *       beware of side effects!
+ *
+ *
+ * Semantics for div_long_long_rem():
+ *
+ * uint32_t div_long_long_rem(uint64_t n, uint32_t base, uint32_t *rem)
+ * {
+ * 	*rem = n % base;
+ * 	return n / base;
+ * }
+ *
+ * NOTE: this will do an exception if result overflows.
  */
 
 #include <linux/types.h>
@@ -30,6 +42,13 @@
 	__rem;							\
  })
 
+extern inline uint32_t
+div_long_long_rem(uint64_t n, uint32_t base, uint32_t *rem)
+{
+	*rem = n % base;
+	return n / base;
+}
+
 #elif BITS_PER_LONG == 32
 
 extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
@@ -49,6 +68,18 @@ extern uint32_t __div64_32(uint64_t *div
 	__rem;						\
  })
 
+extern inline uint32_t
+div_long_long_rem(uint64_t n, uint32_t base, uint32_t *rem)
+{
+	if (likely((n >> 32) == 0)) {
+		*rem = ((uint32_t)n) % base;
+		return ((uint32_t)n) / base;
+	} else {
+		*rem = __div64_32(&n, base);
+		return n;
+	}
+}
+
 #else /* BITS_PER_LONG == ?? */
 
 # error do_div() does not yet support the C64
@@ -56,3 +87,4 @@ extern uint32_t __div64_32(uint64_t *div
 #endif /* BITS_PER_LONG */
 
 #endif /* _ASM_GENERIC_DIV64_H */
+
diff -Nrup linux-2.6.0-test1.orig/include/asm-arm/div64.h linux-2.6.0-test1/include/asm-arm/div64.h
--- linux-2.6.0-test1.orig/include/asm-arm/div64.h	2003-07-14 05:33:50.000000000 +0200
+++ linux-2.6.0-test1/include/asm-arm/div64.h	2003-07-15 05:23:42.000000000 +0200
@@ -1,18 +1,32 @@
 #ifndef __ASM_ARM_DIV64
 #define __ASM_ARM_DIV64
 
+#include <linux/types.h>
+
 /* We're not 64-bit, but... */
 #define do_div(n,base)						\
 ({								\
-	register int __res asm("r2") = base;			\
-	register unsigned long long __n asm("r0") = n;		\
+	register int __res asm("r2") = (base);			\
+	register unsigned long long __n asm("r0") = (n);	\
 	asm("bl do_div64"					\
 		: "=r" (__n), "=r" (__res)			\
 		: "0" (__n), "1" (__res)			\
 		: "r3", "ip", "lr", "cc");			\
-	n = __n;						\
+	(n) = __n;						\
 	__res;							\
 })
 
+/*
+ * See <asm-generic/div64.h> for specifications.
+ *
+ * FIXME: performance could be improved by writing specific asm
+ */
+extern inline uint32_t
+div_long_long_rem(uint64_t n, uint32_t base, uint32_t *rem)
+{
+	*rem = do_div(n, base);
+	return n;
+}
+
 #endif
 
diff -Nrup linux-2.6.0-test1.orig/include/asm-i386/div64.h linux-2.6.0-test1/include/asm-i386/div64.h
--- linux-2.6.0-test1.orig/include/asm-i386/div64.h	2003-07-14 05:28:55.000000000 +0200
+++ linux-2.6.0-test1/include/asm-i386/div64.h	2003-07-15 06:02:42.000000000 +0200
@@ -1,6 +1,12 @@
 #ifndef __I386_DIV64
 #define __I386_DIV64
 
+#include <linux/types.h>
+
+/* See asm-generic/div64.h for semantics of
+ * do_div() and div_long_long_rem()
+ */
+
 #define do_div(n,base) ({ \
 	unsigned long __upper, __low, __high, __mod; \
 	asm("":"=a" (__low), "=d" (__high):"A" (n)); \
@@ -14,22 +20,14 @@
 	__mod; \
 })
 
-/*
- * (long)X = ((long long)divs) / (long)div
- * (long)rem = ((long long)divs) % (long)div
- *
- * Warning, this will do an exception if X overflows.
- */
-#define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)
-
-extern inline long
-div_ll_X_l_rem(long long divs, long div, long *rem)
+extern inline uint32_t
+div_long_long_rem(uint64_t divs, uint32_t div, uint32_t *rem)
 {
-	long dum2;
-      __asm__("divl %2":"=a"(dum2), "=d"(*rem)
-      :	"rm"(div), "A"(divs));
-
-	return dum2;
+	uint32_t result;
+	__asm__("divl %2":"=a"(result), "=d"(*rem)
+		: "rm"(div), "A"(divs));
 
+	return result;
 }
+
 #endif
diff -Nrup linux-2.6.0-test1.orig/include/asm-m68k/div64.h linux-2.6.0-test1/include/asm-m68k/div64.h
--- linux-2.6.0-test1.orig/include/asm-m68k/div64.h	2003-07-14 05:37:59.000000000 +0200
+++ linux-2.6.0-test1/include/asm-m68k/div64.h	2003-07-15 05:23:53.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _M68K_DIV64_H
 #define _M68K_DIV64_H
 
+#include <linux/types.h>
+
 /* n = n / base; return rem; */
 
 #define do_div(n, base) ({					\
@@ -23,4 +25,16 @@
 	__rem;							\
 })
 
+/*
+ * See <asm-generic/div64.h> for specifications.
+ *
+ * FIXME: performance could be improved by writing specific asm
+ */
+extern inline uint32_t
+div_long_long_rem(uint64_t n, uint32_t base, uint32_t *rem)
+{
+	*rem = do_div(n, base);
+	return n;
+}
+
 #endif /* _M68K_DIV64_H */
diff -Nrup linux-2.6.0-test1.orig/include/asm-mips/div64.h linux-2.6.0-test1/include/asm-mips/div64.h
--- linux-2.6.0-test1.orig/include/asm-mips/div64.h	2003-07-14 05:36:33.000000000 +0200
+++ linux-2.6.0-test1/include/asm-mips/div64.h	2003-07-15 05:24:16.000000000 +0200
@@ -8,6 +8,8 @@
 #ifndef _ASM_DIV64_H
 #define _ASM_DIV64_H
 
+#include <linux/types.h>
+
 /*
  * No traps on overflows for any of these...
  */
@@ -73,4 +75,16 @@
 	(n) = __quot; \
 	__mod; })
 
+/*
+ * See <asm-generic/div64.h> for specifications.
+ *
+ * FIXME: performance could be improved by writing specific asm
+ */
+extern inline uint32_t
+div_long_long_rem(uint64_t n, uint32_t base, uint32_t *rem)
+{
+	*rem = do_div(n, base);
+	return n;
+}
+
 #endif /* _ASM_DIV64_H */
diff -Nrup linux-2.6.0-test1.orig/include/asm-s390/div64.h linux-2.6.0-test1/include/asm-s390/div64.h
--- linux-2.6.0-test1.orig/include/asm-s390/div64.h	2003-07-14 05:35:52.000000000 +0200
+++ linux-2.6.0-test1/include/asm-s390/div64.h	2003-07-15 05:24:28.000000000 +0200
@@ -3,6 +3,8 @@
 
 #ifndef __s390x__
 
+#include <linux/types.h>
+
 /* for do_div "base" needs to be smaller than 2^31-1 */
 #define do_div(n, base) ({                                      \
 	unsigned long long __n = (n);				\
@@ -42,6 +44,18 @@
         __r;                                                    \
 })
 
+/*
+ * See <asm-generic/div64.h> for specifications.
+ *
+ * FIXME: performance could be improved by writing specific asm
+ */
+extern inline uint32_t
+div_long_long_rem(uint64_t n, uint32_t base, uint32_t *rem)
+{
+	*rem = do_div(n, base);
+	return n;
+}
+
 #else /* __s390x__ */
 #include <asm-generic/div64.h>
 #endif /* __s390x__ */
diff -Nrup linux-2.6.0-test1.orig/include/linux/time.h linux-2.6.0-test1/include/linux/time.h
--- linux-2.6.0-test1.orig/include/linux/time.h	2003-07-14 05:35:16.000000000 +0200
+++ linux-2.6.0-test1/include/linux/time.h	2003-07-15 05:20:26.000000000 +0200
@@ -28,14 +28,6 @@ struct timezone {
 #include <linux/seqlock.h>
 #include <linux/timex.h>
 #include <asm/div64.h>
-#ifndef div_long_long_rem
-
-#define div_long_long_rem(dividend,divisor,remainder) ({ \
-		       u64 result = dividend;		\
-		       *remainder = do_div(result,divisor); \
-		       result; })
-
-#endif
 
 /*
  * Have the 32 bit jiffies value wrap 5 minutes after boot
@@ -122,7 +114,7 @@ jiffies_to_timespec(unsigned long jiffie
 	 * one divide.
 	 */
 	u64 nsec = (u64)jiffies * TICK_NSEC; 
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, (uint32_t *)&value->tv_nsec);
 }
 
 /* Same for "timeval" */
@@ -150,7 +142,7 @@ jiffies_to_timeval(unsigned long jiffies
 	 * one divide.
 	 */
 	u64 nsec = (u64)jiffies * TICK_NSEC; 
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, (uint32_t *)&value->tv_usec);
 	value->tv_usec /= NSEC_PER_USEC;
 }
 
diff -Nrup linux-2.6.0-test1.orig/kernel/posix-timers.c linux-2.6.0-test1/kernel/posix-timers.c
--- linux-2.6.0-test1.orig/kernel/posix-timers.c	2003-07-14 05:34:32.000000000 +0200
+++ linux-2.6.0-test1/kernel/posix-timers.c	2003-07-15 05:21:24.000000000 +0200
@@ -23,16 +23,8 @@
 #include <linux/idr.h>
 #include <linux/posix-timers.h>
 #include <linux/wait.h>
-
-#ifndef div_long_long_rem
 #include <asm/div64.h>
 
-#define div_long_long_rem(dividend,divisor,remainder) ({ \
-		       u64 result = dividend;		\
-		       *remainder = do_div(result,divisor); \
-		       result; })
-
-#endif
 #define CLOCK_REALTIME_RES TICK_NSEC  // In nano seconds.
 
 static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
@@ -1226,7 +1218,7 @@ do_clock_nanosleep(clockid_t which_clock
 		left *= TICK_NSEC;
 		tsave->tv_sec = div_long_long_rem(left, 
 						  NSEC_PER_SEC, 
-						  &tsave->tv_nsec);
+						  (uint32_t *)&tsave->tv_nsec);
 		restart_block->fn = clock_nanosleep_restart;
 		restart_block->arg0 = which_clock;
 		restart_block->arg1 = (unsigned long)tsave;

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


