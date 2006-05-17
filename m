Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWEQARc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWEQARc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEQAQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:56 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59548 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932297AbWEQAQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:34 -0400
Date: Wed, 17 May 2006 02:16:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 14/50] genirq: cleanup: no_irq_type cleanups
Message-ID: <20060517001618.GO12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

clean up no_irq_type: share the NOP functions where possible,
and properly name the ack_bad() function.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/handle.c |   38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -40,32 +40,30 @@ struct irq_desc irq_desc[NR_IRQS] __cach
 };
 
 /*
- * Generic 'no controller' code
+ * What should we do if we get a hw irq event on an illegal vector?
+ * Each architecture has to answer this themself.
  */
-static void end_none(unsigned int irq) { }
-static void enable_none(unsigned int irq) { }
-static void disable_none(unsigned int irq) { }
-static void shutdown_none(unsigned int irq) { }
-static unsigned int startup_none(unsigned int irq) { return 0; }
-
-static void ack_none(unsigned int irq)
+static void ack_bad(unsigned int irq)
 {
-	/*
-	 * 'what should we do if we get a hw irq event on an illegal vector'.
-	 * each architecture has to answer this themself.
-	 */
 	ack_bad_irq(irq);
 }
 
+/*
+ * NOP functions
+ */
+static void noop(unsigned int irq)
+{
+}
+
+/*
+ * Generic no controller implementation
+ */
 struct hw_interrupt_type no_irq_type = {
-	.typename = 	"none",
-	.startup = 	startup_none,
-	.shutdown = 	shutdown_none,
-	.enable = 	enable_none,
-	.disable = 	disable_none,
-	.ack = 		ack_none,
-	.end = 		end_none,
-	.set_affinity = NULL
+	.typename =	"none",
+	.enable =	noop,
+	.disable =	noop,
+	.ack =		ack_bad,
+	.end =		noop,
 };
 
 /*
