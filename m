Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267888AbTCFHsJ>; Thu, 6 Mar 2003 02:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbTCFHsI>; Thu, 6 Mar 2003 02:48:08 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:62212 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267888AbTCFHsF>; Thu, 6 Mar 2003 02:48:05 -0500
Message-Id: <200303060749.h267nPu01086@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@digeo.com>, J Sloan <joe@tmsusa.com>
Subject: Re: Oops in 2.5.64
Date: Thu, 6 Mar 2003 09:46:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3E66E782.5010502@tmsusa.com> <20030305223638.77c22cb7.akpm@digeo.com>
In-Reply-To: <20030305223638.77c22cb7.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 March 2003 08:36, Andrew Morton wrote:
> J Sloan <joe@tmsusa.com> wrote:
> > ...
> > The console was frozen, with an oops -
>
> This is odd.
>
> > Mar  5 21:17:41 jyro init: Switching to runlevel: 3
> > Mar  5 21:17:42 jyro kernel: mtrr: MTRR 2 not used
> > Mar  5 21:17:43 jyro microcode_ctl: microcode_ctl startup succeeded
> > Mar  5 21:17:44 jyro kernel: Unable to handle kernel paging request
> > at virtual address d85b0000
>
> hmm, looks like a module address.
>
> > Mar  5 21:17:44 jyro kernel:  printing eip:
> > Mar  5 21:17:44 jyro kernel: c013ce25
> > Mar  5 21:17:44 jyro kernel: *pde = 185b1163
> > Mar  5 21:17:44 jyro kernel: *pte = 6c69614d
> > Mar  5 21:17:44 jyro kernel: Oops: 0003
> > Mar  5 21:17:44 jyro kernel: CPU:    0
> > Mar  5 21:17:44 jyro kernel: EIP:    0060:[<c013ce25>]    Not
> > tainted Mar  5 21:17:44 jyro kernel: EFLAGS: 00010216
> > Mar  5 21:17:44 jyro kernel: EIP is at
> > __constant_c_and_count_memset+0x85/0xa0
>
> Eh?  How come the compiler didn't inline
> __constant_c_and_count_memset? What compiler version are you using?

It was seen before:

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
--- linux-2.5.45.orig/include/asm-i386/string.h Wed Oct 30 22:43:46 2002
+++ linux-2.5.45fix/include/asm-i386/string.h   Sun Nov  3 15:58:08 2002
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
--- linux-2.5.45.orig/include/linux/compiler.h  Wed Oct 30 22:43:05 2002
+++ linux-2.5.45fix/include/linux/compiler.h    Sun Nov  3 15:19:20 2002
@@ -20,3 +20,11 @@
     __asm__ ("" : "=g"(__ptr) : "0"(ptr));             \
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
