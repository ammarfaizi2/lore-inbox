Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbSKCNUz>; Sun, 3 Nov 2002 08:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSKCNUz>; Sun, 3 Nov 2002 08:20:55 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261868AbSKCNUy>; Sun, 3 Nov 2002 08:20:54 -0500
Message-Id: <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Sun, 3 Nov 2002 16:14:26 -0200
X-Mailer: KMail [version 1.3.2]
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 14:17, Denis Vlasenko wrote:
> It seems gcc started to de-inline large functions.
> We got bitten:
>
> # sort -t ' ' +2 <System.map
> ...
> c01876f0 t __cleanup_transaction
> c0150f90 t __clear_page_buffers
> c01d9fa0 T __clear_user
> c011b020 T __cond_resched
> c01d9ea0 T __const_udelay
> c0107150 t __constant_c_and_count_memset
> c0107fd0 t __constant_c_and_count_memset
>
> [~seven screenfuls (!) snipped]
>
> c010c7f0 t __constant_c_and_count_memset
> c010e210 t __constant_c_and_count_memset
> c03609e0 t __constant_c_and_count_memset
> c03634f0 t __constant_c_and_count_memset
> c0107ec0 t __constant_memcpy
> c010fc10 t __constant_memcpy

Here is the cure: force_inline will guarantee inlining.

To use _only_ with functions which meant to be almost
optimized away to nothing but are large and gcc might decide
they are _too_ large for inlining.

More to come if ok'ed for inclusion.
--
vda


diff -urN linux-2.5.45.orig/include/asm-i386/string.h linux-2.5.45fix/include/asm-i386/string.h
--- linux-2.5.45.orig/include/asm-i386/string.h	Wed Oct 30 22:43:46 2002
+++ linux-2.5.45fix/include/asm-i386/string.h	Sun Nov  3 15:58:08 2002
@@ -3,6 +3,7 @@
 
 #ifdef __KERNEL__
 #include <linux/config.h>
+#include <linux/compiler.h>
 /*
  * On a 486 or Pentium, we are better off not using the
  * byte string operations. But on a 386 or a PPro the
@@ -218,7 +219,7 @@
  * This looks horribly ugly, but the compiler can optimize it totally,
  * as the count is constant.
  */
-static inline void * __constant_memcpy(void * to, const void * from, size_t n)
+static force_inline void * __constant_memcpy(void * to, const void * from, size_t n)
 {
 	switch (n) {
 		case 0:
@@ -453,7 +454,7 @@
  * This looks horribly ugly, but the compiler can optimize it totally,
  * as we by now know that both pattern and count is constant..
  */
-static inline void * __constant_c_and_count_memset(void * s, unsigned long pattern, size_t count)
+static force_inline void * __constant_c_and_count_memset(void * s, unsigned long pattern, size_t count)
 {
 	switch (count) {
 		case 0:
diff -urN linux-2.5.45.orig/include/linux/compiler.h linux-2.5.45fix/include/linux/compiler.h
--- linux-2.5.45.orig/include/linux/compiler.h	Wed Oct 30 22:43:05 2002
+++ linux-2.5.45fix/include/linux/compiler.h	Sun Nov  3 15:19:20 2002
@@ -20,3 +20,11 @@
     __asm__ ("" : "=g"(__ptr) : "0"(ptr));		\
     (typeof(ptr)) (__ptr + (off)); })
 #endif /* __LINUX_COMPILER_H */
+
+/* GCC 3 (and probably earlier, I'm not sure) can be told to always inline
+   a function. */
+#if __GNUC__ < 3
+#define force_inline inline
+#else
+#define force_inline inline __attribute__ ((always_inline))
+#endif
