Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVBLKOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVBLKOh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 05:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVBLKOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 05:14:37 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5137 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262385AbVBLKOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 05:14:32 -0500
Date: Sat, 12 Feb 2005 11:13:49 +0100
From: Willy Tarreau <willy@w.ods.org>
To: marcelo.tosatti@cyclades.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [2.4.30-pre1] Sparc SMP build fixes
Message-ID: <20050212101349.GA22759@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo and David,

The recent addition of an smp_rmb() in kfree_skb() by Herbert Xu
broke SMP builds on sparc and sparc64, but it's not Herbert's fault,
it's because of a few extra semi-colons in system.h for both archs.

The smp_rmb() has been inserted this way :

   if (likely(atomic_read(&skb->users) == 1))
       smp_rmb();
   else if (likely(!atomic_dec_and_test(&skb->users)))
       return;

But it's defined like this on sparc and sparc64 :

   #define smp_rmb()       __asm__ __volatile__("":::"memory");

So you get it :-)

I quickly grepped include/asm-* and found 85 obvious similar cases in
various files and on various defines. I'm not sure that everything
builds on every arch.

However, while I was fixing system.h for sparc and sparc64, I also
fixed a few more defines in the same file which had the same problem.
In case of sparc64, the use of "mb();" would have resulted in 3
consecutive semi-colons.

Please consider including this.

Cheers,
Willy


--- ./include/asm-sparc/system.h.bad	Sat Sep 18 14:15:43 2004
+++ ./include/asm-sparc/system.h	Sat Feb 12 10:55:05 2005
@@ -295,9 +295,9 @@
 #define wmb()	mb()
 #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
 #define set_wmb(__var, __value) set_mb(__var, __value)
-#define smp_mb()	__asm__ __volatile__("":::"memory");
-#define smp_rmb()	__asm__ __volatile__("":::"memory");
-#define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_mb()	__asm__ __volatile__("":::"memory")
+#define smp_rmb()	__asm__ __volatile__("":::"memory")
+#define smp_wmb()	__asm__ __volatile__("":::"memory")
 
 #define nop() __asm__ __volatile__ ("nop");
 

--- ./include/asm-sparc64/system.h.bad	Sat Feb 12 10:40:21 2005
+++ ./include/asm-sparc64/system.h	Sat Feb 12 10:54:17 2005
@@ -106,9 +106,9 @@
 
 #define nop() 		__asm__ __volatile__ ("nop")
 
-#define membar(type)	__asm__ __volatile__ ("membar " type : : : "memory");
+#define membar(type)	__asm__ __volatile__ ("membar " type : : : "memory")
 #define mb()		\
-	membar("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad");
+	membar("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad")
 #define rmb()		membar("#LoadLoad")
 #define wmb()		membar("#StoreStore")
 #define set_mb(__var, __value) \
@@ -121,9 +121,9 @@
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
 #else
-#define smp_mb()	__asm__ __volatile__("":::"memory");
-#define smp_rmb()	__asm__ __volatile__("":::"memory");
-#define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_mb()	__asm__ __volatile__("":::"memory")
+#define smp_rmb()	__asm__ __volatile__("":::"memory")
+#define smp_wmb()	__asm__ __volatile__("":::"memory")
 #endif
 
 #define flushi(addr)	__asm__ __volatile__ ("flush %0" : : "r" (addr) : "memory")
@@ -132,7 +132,7 @@
 
 /* Performance counter register access. */
 #define read_pcr(__p)  __asm__ __volatile__("rd	%%pcr, %0" : "=r" (__p))
-#define write_pcr(__p) __asm__ __volatile__("wr	%0, 0x0, %%pcr" : : "r" (__p));
+#define write_pcr(__p) __asm__ __volatile__("wr	%0, 0x0, %%pcr" : : "r" (__p))
 #define read_pic(__p)  __asm__ __volatile__("rd %%pic, %0" : "=r" (__p))
 
 /* Blackbird errata workaround.  See commentary in


