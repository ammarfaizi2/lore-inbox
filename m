Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWFOIZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWFOIZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 04:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWFOIZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 04:25:40 -0400
Received: from ozlabs.org ([203.10.76.45]:28815 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751323AbWFOIZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 04:25:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17552.56810.818694.995923@cargo.ozlabs.ibm.com>
Date: Thu, 15 Jun 2006 14:11:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Fix mdelay badness on shared processor partitions
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Blanchard <anton@samba.org>

On partitioned PPC64 systems where a partition is given 1/10 of a
processor, we have seen mdelay() delaying for 10 times longer than it
should.  The reason is that the generic mdelay(n) does n delays of 1
millisecond each.  However, with 1/10 of a processor, we only get a
one-millisecond timeslice every 10ms.  Thus each 1 millisecond delay
loop ends up taking 10ms elapsed time.

The solution is just to use the PPC64 udelay function, which uses the
timebase to ensure that the delay is based on elapsed time rather than
how much processing time the partition has been given.  (Yes, the
generic mdelay uses the PPC64 udelay, but the problem is that the
start time gets reset every millisecond, and each time it gets reset
we lose another 9ms.)

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Andrew, if you are OK with this patch, send me an Acked-by and I'll
push it via the powerpc.git tree.

Index: build/include/asm-powerpc/delay.h
===================================================================
--- build.orig/include/asm-powerpc/delay.h	2006-06-08 10:57:41.000000000 +1000
+++ build/include/asm-powerpc/delay.h	2006-06-10 21:15:02.000000000 +1000
@@ -17,5 +17,18 @@
 extern void __delay(unsigned long loops);
 extern void udelay(unsigned long usecs);
 
+/*
+ * On shared processor machines the generic implementation of mdelay can
+ * result in large errors. While each iteration of the loop inside mdelay
+ * is supposed to take 1ms, the hypervisor could sleep our partition for
+ * longer (eg 10ms). With the right timing these errors can add up.
+ *
+ * Since there is no 32bit overflow issue on 64bit kernels, just call
+ * udelay directly.
+ */
+#ifdef CONFIG_PPC64
+#define mdelay(n)	udelay((n) * 1000)
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DELAY_H */
Index: build/include/linux/delay.h
===================================================================
--- build.orig/include/linux/delay.h	2006-06-08 10:57:41.000000000 +1000
+++ build/include/linux/delay.h	2006-06-10 21:04:58.000000000 +1000
@@ -25,10 +25,7 @@ extern unsigned long loops_per_jiffy;
 #define MAX_UDELAY_MS	5
 #endif
 
-#ifdef notdef
-#define mdelay(n) (\
-	{unsigned long __ms=(n); while (__ms--) udelay(1000);})
-#else
+#ifndef mdelay
 #define mdelay(n) (\
 	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
 	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
