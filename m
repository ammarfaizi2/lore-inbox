Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUIJD1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUIJD1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUIJD1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:27:49 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:60291 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267702AbUIJD0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:26:04 -0400
Date: Fri, 10 Sep 2004 12:27:45 +0900 (JST)
Message-Id: <200409100327.i8A3RjYV007102@mailsv.bs1.fc.nec.co.jp>
To: akpm@osdl.org, hugh@veritas.com, ak@muc.de
Cc: wli@holomorphy.com, takata.hirokazu@renesas.com, kaigai@ak.jp.nec.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] atomic_inc_return() for x86_64[2/5] (Re: atomic_inc_return)
In-Reply-To: Your message of "Thu, 9 Sep 2004 20:48:27 +0100 (BST)".
	<Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
From: kaigai@ak.jp.nec.com (Kaigai Kohei)
X-Mailer: mnews [version 1.22PL1] 2000-02/15(Tue)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[2/5] atomic_inc_return-linux-2.6.9-rc1.x86_64.patch
  This patch implements atomic_inc_return() and so on for x86_64.
  It is same as I posted to LKML and Andi Kleen at '04/09/01.

Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
--------
Kai Gai <kaigai@ak.jp.nec.com>


diff -rNU4 linux-2.6.9-rc1/include/asm-x86_64/atomic.h linux-2.6.9-rc1.atomic_inc_return/include/asm-x86_64/atomic.h
--- linux-2.6.9-rc1/include/asm-x86_64/atomic.h	2004-08-24 16:03:38.000000000 +0900
+++ linux-2.6.9-rc1.atomic_inc_return/include/asm-x86_64/atomic.h	2004-09-10 10:15:18.000000000 +0900
@@ -177,8 +177,33 @@
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
+	int __i = i;
+	__asm__ __volatile__(
+		LOCK "xaddl %0, %1;"
+		:"=r"(i)
+		:"m"(v->counter), "0"(i));
+	return i + __i;
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
