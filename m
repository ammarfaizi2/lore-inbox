Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbTGHUmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTGHUmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:42:24 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:41094 "HELO
	develer.com") by vger.kernel.org with SMTP id S265350AbTGHUmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:42:21 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix do_div() for all architectures
Date: Tue, 8 Jul 2003 22:56:57 +0200
User-Agent: KMail/1.5.9
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, andrea@suse.de,
       peter@chubb.wattle.id.au, akpm@digeo.com, spyro@f2s.com
References: <200307060133.15312.bernie@develer.com> <200307082027.26233.bernie@develer.com> <20030708113155.031b4bc2.akpm@osdl.org>
In-Reply-To: <20030708113155.031b4bc2.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307082256.57007.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 July 2003 20:31, Andrew Morton wrote:
 > Bernardo Innocenti <bernie@develer.com> wrote:
 > >  Andrew, would you like to pick this patch up for me and forward it
 > > to Linus after it received some testing in -mm?
 >
 > It got merged ages ago ;)  Linus simply removed the pure thing.

 Oops. He didn't remove it, he just picked up my older version
which also missed an important bug fix.

 Here's an incremental patch against 2.5.74-bk4. Please apply.

---------------------------------------------------------------------

Fix problem introduced by previous do_div() patch:

 - export the __div64_32 symbol for modules;

 - add likely() to the fast path (divisor>>32 == 0);

 - add __attribute__((pure)) to __div64_32() prototype so
   the compiler knows global memory isn't clobbered;

 - avoid building __div64_32() on 64bit architectures.


diff -Nru linux-2.5.74-bk4.orig/include/asm-generic/div64.h linux-2.5.74-bk4/include/asm-generic/div64.h
--- linux-2.5.74-bk4.orig/include/asm-generic/div64.h	2003-07-08 22:29:32.000000000 +0200
+++ linux-2.5.74-bk4/include/asm-generic/div64.h	2003-07-08 22:45:21.000000000 +0200
@@ -18,6 +18,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/compiler.h>
 
 #if BITS_PER_LONG == 64
 
@@ -31,12 +32,12 @@
 
 #elif BITS_PER_LONG == 32
 
-extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
+extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor) __attribute_pure__;
 
 # define do_div(n,base) ({				\
 	uint32_t __base = (base);			\
 	uint32_t __rem;					\
-	if (((n) >> 32) == 0) {				\
+	if (likely(((n) >> 32) == 0)) {			\
 		__rem = (uint32_t)(n) % __base;		\
 		(n) = (uint32_t)(n) / __base;		\
 	} else 						\
diff -Nru linux-2.5.74-bk4.orig/include/linux/compiler.h linux-2.5.74-bk4/include/linux/compiler.h
--- linux-2.5.74-bk4.orig/include/linux/compiler.h	2003-07-08 22:23:25.000000000 +0200
+++ linux-2.5.74-bk4/include/linux/compiler.h	2003-07-08 22:45:21.000000000 +0200
@@ -56,6 +56,24 @@
 #define __attribute_used__	__attribute__((__unused__))
 #endif
 
+/*
+ * From the GCC manual:
+ *
+ * Many functions have no effects except the return value and their
+ * return value depends only on the parameters and/or global
+ * variables.  Such a function can be subject to common subexpression
+ * elimination and loop optimization just as an arithmetic operator
+ * would be.
+ * [...]
+ * The attribute `pure' is not implemented in GCC versions earlier
+ * than 2.96.
+ */
+#if (__GNUC__ == 2 && __GNUC_MINOR >= 96) || __GNUC__ > 2
+#define __attribute_pure__	__attribute__((pure))
+#else
+#define __attribute_pure__	/* unimplemented */
+#endif
+
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\
diff -Nru linux-2.5.74-bk4.orig/lib/div64.c linux-2.5.74-bk4/lib/div64.c
--- linux-2.5.74-bk4.orig/lib/div64.c	2003-07-08 22:29:32.000000000 +0200
+++ linux-2.5.74-bk4/lib/div64.c	2003-07-08 22:45:21.000000000 +0200
@@ -12,13 +12,17 @@
  * The fast case for (n>>32 == 0) is handled inline by do_div(). 
  *
  * Code generated for this function might be very inefficient
- * for some CPUs. div64_32() can be overridden by linking arch-specific
+ * for some CPUs. __div64_32() can be overridden by linking arch-specific
  * assembly versions such as arch/ppc/lib/div64.S and arch/sh/lib/div64.S.
  */
 
 #include <linux/types.h>
+#include <linux/module.h>
 #include <asm/div64.h>
 
+/* Not needed on 64bit architectures */
+#if BITS_PER_LONG == 32
+
 uint32_t __div64_32(uint64_t *n, uint32_t base)
 {
 	uint32_t low, low2, high, rem;
@@ -43,3 +47,6 @@
 	return rem;
 }
 
+EXPORT_SYMBOL(__div64_32);
+
+#endif /* BITS_PER_LONG == 32 */



-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


