Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUIJDbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUIJDbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267879AbUIJD3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:29:21 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:57258 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267918AbUIJD1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:27:49 -0400
Date: Fri, 10 Sep 2004 12:30:15 +0900 (JST)
Message-Id: <200409100330.i8A3UFYV007120@mailsv.bs1.fc.nec.co.jp>
To: akpm@osdl.org, hugh@veritas.com, spyro@f2s.com
Cc: wli@holomorphy.com, takata.hirokazu@renesas.com, kaigai@ak.jp.nec.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] atomic_inc_return() for arm26[1/5] (Re: atomic_inc_return)
In-Reply-To: Your message of "Thu, 9 Sep 2004 20:48:27 +0100 (BST)".
	<Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
From: kaigai@ak.jp.nec.com (Kaigai Kohei)
X-Mailer: mnews [version 1.22PL1] 2000-02/15(Tue)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[4/5] atomic_inc_return-linux-2.6.9-rc1.arm26.patch
  This patch implements atomic_inc_return() and so on for ARM26.
  Because Hugh says that SMP is not supported in arm26, it is implemented
  by normal operations between local_irq_save() and local_irq_restore()
  like another atomic operations.
  This patch has not been tested, since we don't have ARM26 machine.
  I want to let this reviewed by ARM26 specialists.

Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
--------
Kai Gai <kaigai@ak.jp.nec.com>


diff -rNU4 linux-2.6.9-rc1/include/asm-arm26/atomic.h linux-2.6.9-rc1.atomic_inc_return/include/asm-arm26/atomic.h
--- linux-2.6.9-rc1/include/asm-arm26/atomic.h	2004-08-24 16:02:32.000000000 +0900
+++ linux-2.6.9-rc1.atomic_inc_return/include/asm-arm26/atomic.h	2004-09-10 10:20:29.000000000 +0900
@@ -104,8 +104,29 @@
 	*addr &= ~mask;
 	local_irq_restore(flags);
 }
 
+static inline int atomic_add_return(int i, volatile atomic_t *v)
+{
+	unsigned long flags;
+	int val;
+
+	local_irq_save(flags);
+	val = v->counter + i;
+	v->counter = val;
+	local_irq_restore(flags);
+
+	return val;
+}
+
+static inline int atomic_sub_return(int i, volatile atomic_t *v)
+{
+	return atomic_add_return(-i, v);
+}
+
+#define atomic_inc_return(v)  (atomic_add_return(1,v))
+#define atomic_dec_return(v)  (atomic_sub_return(1,v))
+
 /* Atomic operations are already serializing on ARM */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
 #define smp_mb__before_atomic_inc()	barrier()
