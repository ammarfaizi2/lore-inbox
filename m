Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbSKMBWf>; Tue, 12 Nov 2002 20:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbSKMBWf>; Tue, 12 Nov 2002 20:22:35 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:4044 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S267081AbSKMBWe>;
	Tue, 12 Nov 2002 20:22:34 -0500
Date: Wed, 13 Nov 2002 02:28:54 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Message-ID: <20021113012854.GA1806@werewolf.able.es>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <20021103103710.D10988@devserv.devel.redhat.com> <1036340502.29642.36.camel@irongate.swansea.linux.org.uk> <200211031928.gA3JSSp29136@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200211031928.gA3JSSp29136@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Mon, Nov 04, 2002 at 01:20:25 +0100
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.04 Denis Vlasenko wrote:
[...]
> __constant_c_and_count_memset *has to* be inlined.
> There is large switch statement which meant to be optimized out.
> It does optimize out *only if* count is compile-time constant.

I also got tons of __copy_to_user and __copy_from_user in 2.4.
Do not show in 2.5 ?

This i what I applied to my 2.4 tree:

diff -urN linux-2.5.45.orig/include/linux/compiler.h linux-2.5.45fix/include/linux/compiler.h
--- linux-2.5.45.orig/include/linux/compiler.h	Wed Oct 30 22:43:05 2002
+++ linux-2.5.45fix/include/linux/compiler.h	Sun Nov  3 15:19:20 2002
@@ -13,4 +13,12 @@
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)
 
+/* GCC 3 (and probably earlier, I'm not sure) can be told to always inline
+   a function. */
+#if __GNUC__ < 3
+#define force_inline inline
+#else
+#define force_inline inline __attribute__ ((always_inline))
+#endif
+
 #endif /* __LINUX_COMPILER_H */
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
--- linux/include/asm-i386/uaccess.h.orig	2002-11-13 01:27:42.000000000 +0100
+++ linux/include/asm-i386/uaccess.h	2002-11-13 01:30:04.000000000 +0100
@@ -543,7 +543,7 @@
 unsigned long __generic_copy_to_user(void *, const void *, unsigned long);
 unsigned long __generic_copy_from_user(void *, const void *, unsigned long);
 
-static inline unsigned long
+static force_inline unsigned long
 __constant_copy_to_user(void *to, const void *from, unsigned long n)
 {
 	prefetch(from);
@@ -552,7 +552,7 @@
 	return n;
 }
 
-static inline unsigned long
+static force_inline unsigned long
 __constant_copy_from_user(void *to, const void *from, unsigned long n)
 {
 	if (access_ok(VERIFY_READ, from, n))
@@ -562,14 +562,14 @@
 	return n;
 }
 
-static inline unsigned long
+static force_inline unsigned long
 __constant_copy_to_user_nocheck(void *to, const void *from, unsigned long n)
 {
 	__constant_copy_user(to,from,n);
 	return n;
 }
 
-static inline unsigned long
+static force_inline unsigned long
 __constant_copy_from_user_nocheck(void *to, const void *from, unsigned long n)
 {
 	__constant_copy_user_zeroing(to,from,n);


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam2 (gcc 3.2 (Mandrake Linux 9.1 3.2-3mdk))
