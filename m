Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264645AbSKDLPs>; Mon, 4 Nov 2002 06:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbSKDLPs>; Mon, 4 Nov 2002 06:15:48 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:5 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264651AbSKDLPr>; Mon, 4 Nov 2002 06:15:47 -0500
Message-Id: <200211041116.gA4BGGp32124@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Mon, 4 Nov 2002 14:08:10 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <200211031928.gA3JSSp29136@Port.imtp.ilyichevsk.odessa.ua> <1036355312.30629.25.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1036355312.30629.25.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 18:28, Alan Cox wrote:
> On Mon, 2002-11-04 at 00:20, Denis Vlasenko wrote:
> > __constant_c_and_count_memset *has to* be inlined.
> > There is large switch statement which meant to be optimized out.
> > It does optimize out *only if* count is compile-time constant.
>
> gcc already allows you to check for constants that means you can
> generate
>
> 	(is a constant ? inline: noninline)(to, from, len)
			 ^^^^^^
>
> and I would hope gcc does the right thing. Similarly your switch will
> be optimised out so the default case for the constant one can be the
> invocation of uninlined code and it should optimise back to the
> straight expected call.

Yes. That is how it is done right now in 2.4 and 2.5. The problem is
that gcc 3.2 did *not* inline __constant_c_and_count_memset()
as we all expected.

What's the verdict on my patch?
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
