Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318225AbSHZUAa>; Mon, 26 Aug 2002 16:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318229AbSHZUAa>; Mon, 26 Aug 2002 16:00:30 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4869
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318225AbSHZUA1>; Mon, 26 Aug 2002 16:00:27 -0400
Subject: [PATCH] per-arch load balancing
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 16:04:43 -0400
Message-Id: <1030392283.1020.407.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The attached patch implements (optional) per-architecture load balancing
so we can cleanly implement specialized load balancing behavior for
NUMA, hyperthreading, etc.

The new method is "arch_load_balance()" and is defined (if available) in
asm/smp_balance.h - otherwise it defines away.  Currently, we call it
from "find_busiest_queue()".

This patch, against current BK, only implements the infrastructure and
not any particular new logic.  This is a similar implementation as found
in 2.4-ac.

Please, apply.

	Robert Love

diff -urN linux-2.5.31/include/linux/smp_balance.h linux/include/linux/smp_balance.h
--- linux-2.5.31/include/linux/smp_balance.h	Wed Dec 31 19:00:00 1969
+++ linux/include/linux/smp_balance.h	Sat Aug 24 22:10:00 2002
@@ -0,0 +1,14 @@
+#ifndef _LINUX_SMP_BALANCE_H
+#define _LINUX_SMP_BALANCE_H
+
+/*
+ * per-architecture load balancing logic, e.g. for hyperthreading
+ */
+
+#ifdef ARCH_HAS_SMP_BALANCE
+#include <asm/smp_balance.h>
+#else
+#define arch_load_balance(x, y)		(0)
+#endif
+
+#endif /* _LINUX_SMP_BALANCE_H */
diff -urN linux-2.5.31/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.31/kernel/sched.c	Sat Aug 10 21:41:24 2002
+++ linux/kernel/sched.c	Sat Aug 24 22:10:00 2002
@@ -630,6 +630,8 @@
 	return nr_running;
 }
 
+#include <linux/smp_balance.h>
+
 /*
  * find_busiest_queue - find the busiest runqueue.
  */
@@ -639,6 +641,12 @@
 	runqueue_t *busiest, *rq_src;
 
 	/*
+	 * Handle architecture-specific balancing, such as hyperthreading.
+	 */
+	if (arch_load_balance(this_cpu, idle))
+		return NULL;
+
+	/*
 	 * We search all runqueues to find the most busy one.
 	 * We do this lockless to reduce cache-bouncing overhead,
 	 * we re-check the 'best' source CPU later on again, with



