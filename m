Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293104AbSBWGNm>; Sat, 23 Feb 2002 01:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293107AbSBWGNd>; Sat, 23 Feb 2002 01:13:33 -0500
Received: from zero.tech9.net ([209.61.188.187]:60424 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293104AbSBWGNU>;
	Sat, 23 Feb 2002 01:13:20 -0500
Subject: [PATCH] only irq-safe atomic ops
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 01:13:29 -0500
Message-Id: <1014444810.1003.53.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch implements i386 versions of atomic_inc and
atomic_dec that are LOCK-less but provide IRQ-atomicity and act as a
memory-barrier.

An applicable use would be data that needs to be IRQ-safe but not
SMP-safe (or, more likely, is already SMP-safe for some other reason).

Additionally, these variants could prevent having to use
preempt_disable/enable or "full" atomic ops around per-CPU data with a
preemptible kernel.

The patch is against 2.5.5.  Enjoy,

	Robert Love

diff -urN linux-2.5.5/include/asm-i386/atomic.h linux/include/asm-i386/atomic.h
--- linux-2.5.5/include/asm-i386/atomic.h	Tue Feb 19 21:10:58 2002
+++ linux/include/asm-i386/atomic.h	Fri Feb 22 22:42:02 2002
@@ -111,6 +111,21 @@
 }
 
 /**
+ * atomic_inc_irq - increment atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * This is an IRQ-safe and memory-barrier
+ * increment without lock
+ */
+static __inline__ void atomic_inc_irq(atomic_t *v)
+{
+	__asm__ __volatile__(
+		"incl %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+/**
  * atomic_dec - decrement atomic variable
  * @v: pointer of type atomic_t
  * 
@@ -124,6 +139,21 @@
 		:"=m" (v->counter)
 		:"m" (v->counter));
 }
+
+/**
+ * atomic_dec_irq - decrement atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * This is an IRQ-safe and memory-barrier
+ * decrement without lock
+ */
+static __inline__ void atomic_dec_irq(atomic_t *v)
+{
+	__asm__ __volatile__(
+		"decl %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
 
 /**
  * atomic_dec_and_test - decrement and test


