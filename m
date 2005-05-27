Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVE0BFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVE0BFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVE0BFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:05:51 -0400
Received: from [151.97.230.9] ([151.97.230.9]:44049 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261380AbVE0BFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:20 -0400
Subject: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 27 May 2005 02:38:42 +0200
Message-Id: <20050527003843.433BA1AEE88@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After porting this fixlet to UML:

http://linux.bkbits.net:8080/linux-2.5/cset@41791ab52lfMuF2i3V-eTIGRBbDYKQ

, I've also added a warning which should refuse compilation with insane values
for PREEMPT_ACTIVE... maybe we should simply move PREEMPT_ACTIVE out of
architectures using GENERIC_IRQS.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/hardirq.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN include/linux/hardirq.h~coherence-test-preempt-active include/linux/hardirq.h
--- linux-2.6.git/include/linux/hardirq.h~coherence-test-preempt-active	2005-05-25 00:59:11.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/hardirq.h	2005-05-25 00:59:26.000000000 +0200
@@ -43,13 +43,17 @@
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
 #define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 
 #define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
 #define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
 #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 
+#if PREEMPT_ACTIVE < (1 << (HARDIRQ_SHIFT + HARDIRQ_BITS))
+#error PREEMPT_ACTIVE is too low!
+#endif
+
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 #define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
_
