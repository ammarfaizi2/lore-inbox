Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUIJDYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUIJDYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUIJDYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:24:48 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:43650 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267633AbUIJDYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:24:44 -0400
Date: Fri, 10 Sep 2004 12:26:54 +0900 (JST)
Message-Id: <200409100326.i8A3QsYV007096@mailsv.bs1.fc.nec.co.jp>
To: akpm@osdl.org, hugh@veritas.com, ak@muc.de
Cc: wli@holomorphy.com, takata.hirokazu@renesas.com, kaigai@ak.jp.nec.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] atomic_inc_return() for i386[1/5] (Re: atomic_inc_return)
In-Reply-To: Your message of "Thu, 9 Sep 2004 20:48:27 +0100 (BST)".
	<Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
From: kaigai@ak.jp.nec.com (Kaigai Kohei)
X-Mailer: mnews [version 1.22PL1] 2000-02/15(Tue)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1/5] atomic_inc_return-linux-2.6.9-rc1.i386.patch
  This patch implements atomic_inc_return() and so on for i386,
  and includes runtime check whether CPU is legacy 386.
  It is same as I posted to LKML and Andi Kleen at '04/09/01.

Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
--------
Kai Gai <kaigai@ak.jp.nec.com>


diff -rNU4 linux-2.6.9-rc1/include/asm-i386/atomic.h linux-2.6.9-rc1.atomic_inc_return/include/asm-i386/atomic.h
--- linux-2.6.9-rc1/include/asm-i386/atomic.h	2004-08-24 16:02:24.000000000 +0900
+++ linux-2.6.9-rc1.atomic_inc_return/include/asm-i386/atomic.h	2004-09-10 10:15:18.000000000 +0900
@@ -1,8 +1,10 @@
 #ifndef __ARCH_I386_ATOMIC__
 #define __ARCH_I386_ATOMIC__
 
 #include <linux/config.h>
+#include <linux/compiler.h>
+#include <asm/processor.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
@@ -175,8 +177,48 @@
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
 }
 
+/**
+ * atomic_add_return - add and return
+ * @v: pointer of type atomic_t
+ * @i: integer value to add
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static __inline__ int atomic_add_return(int i, atomic_t *v)
+{
+	int __i;
+#ifdef CONFIG_M386
+	if(unlikely(boot_cpu_data.x86==3))
+		goto no_xadd;
+#endif
+	/* Modern 486+ processor */
+	__i = i;
+	__asm__ __volatile__(
+		LOCK "xaddl %0, %1;"
+		:"=r"(i)
+		:"m"(v->counter), "0"(i));
+	return i + __i;
+
+#ifdef CONFIG_M386
+no_xadd: /* Legacy 386 processor */
+	local_irq_disable();
+	__i = atomic_read(v);
+	atomic_set(v, i + __i);
+	local_irq_enable();
+	return i + __i;
+#endif
+}
+
+static __inline__ int atomic_sub_return(int i, atomic_t *v)
+{
+	return atomic_add_return(-i,v);
+}
+
+#define atomic_inc_return(v)  (atomic_add_return(1,v))
+#define atomic_dec_return(v)  (atomic_sub_return(1,v))
+
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
 __asm__ __volatile__(LOCK "andl %0,%1" \
 : : "r" (~(mask)),"m" (*addr) : "memory")
