Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSHZUX0>; Mon, 26 Aug 2002 16:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSHZUX0>; Mon, 26 Aug 2002 16:23:26 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:59909
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318230AbSHZUXY>; Mon, 26 Aug 2002 16:23:24 -0400
Subject: Re: [PATCH] per-arch load balancing
From: Robert Love <rml@tech9.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020826211159.A6186@infradead.org>
References: <1030392283.1020.407.camel@phantasy> 
	<20020826211159.A6186@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 16:27:36 -0400
Message-Id: <1030393657.861.440.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 16:11, Christoph Hellwig wrote:

> Can we have a asm/sched.h instead?  especially if we might add additional
> per-arch scheduler bits.  Also I think a asm-generic version is better than
> linux/smp_balance.h + the ARCH_HAS_SMP_BALANCE hack.  I'd prefer if you
> would move the #include ontop ot sched.c, too - includes in the middle of
> a file are really messy.

These are all good ideas.  Here we go again:

This patch implements per-arch scheduler support with specific support
(currently) for per-arch load balancing.  We implement an
asm-generic/sched.h with default methods.  Each architecture needs to
define its own asm/sched.h but by default it would just include
asm-generic/sched.h.

Better?

	Robert Love

diff -urN linux-2.5.31/include/asm-generic/sched.h linux/include/asm-generic/sched.h
--- linux-2.5.31/include/asm-generic/sched.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-generic/sched.h	Mon Aug 26 16:20:50 2002
@@ -0,0 +1,14 @@
+#ifndef _LINUX_SCHED_H
+#define _LINUX_SCHED_H
+
+/*
+ * include/asm-generic/sched.h - generic and default versions of per-arch
+ * scheduler bits
+ */
+
+/*
+ * per-architecture load balancing logic, e.g. for hyperthreading
+ */
+#define arch_load_balance(x, y)		(0)
+
+#endif /* _LINUX_SCHED_H */
diff -urN linux-2.5.31/include/asm-i386/sched.h linux/include/asm-i386/sched.h
--- linux-2.5.31/include/asm-i386/sched.h	Wed Dec 31 19:00:00 1969
+++ linux/include/asm-i386/sched.h	Mon Aug 26 16:22:33 2002
@@ -0,0 +1,7 @@
+#ifndef _I386_SCHED_H
+#define _I386_SCHED_H
+
+/* nothing to see here, move along */
+#include <asm-generic/sched.h>
+
+#endif /* _I386_SCHED_H */
diff -urN linux-2.5.31/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.31/kernel/sched.c	Sat Aug 10 21:41:24 2002
+++ linux/kernel/sched.c	Mon Aug 26 16:21:35 2002
@@ -29,6 +29,7 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
+#include <asm/sched.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -639,6 +640,12 @@
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

