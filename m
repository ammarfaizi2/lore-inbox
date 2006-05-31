Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWEaT7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWEaT7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWEaT7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:59:08 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40089 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965142AbWEaT7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:59:06 -0400
Date: Wed, 31 May 2006 21:59:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator: introduce irq_[disable/enable]_lockdep()
Message-ID: <20060531195927.GA31584@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5196]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: introduce irq_[disable/enable]_lockdep()
From: Ingo Molnar <mingo@elte.hu>

Special lockdep variants of irq line disabling/enabling.

These should be used for locking constructs that
know that a particular irq context which is disabled,
and which is the only irq-context user of a lock,
that it's safe to take the lock in the irq-disabled
section without disabling hardirqs.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/interrupt.h |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: linux/include/linux/interrupt.h
===================================================================
--- linux.orig/include/linux/interrupt.h
+++ linux/include/linux/interrupt.h
@@ -53,6 +53,41 @@ static inline int disable_irq_wake(unsig
 
 #endif
 
+/*
+ * Special lockdep variants of irq disabling/enabling.
+ * These should be used for locking constructs that
+ * know that a particular irq context which is disabled,
+ * and which is the only irq-context user of a lock,
+ * that it's safe to take the lock in the irq-disabled
+ * section without disabling hardirqs.
+ *
+ * On !CONFIG_LOCKDEP they are equivalent to the normal
+ * irq disable/enable methods.
+ */
+static void disable_irq_nosync_lockdep(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+#ifdef CONFIG_LOCKDEP
+	local_irq_disable();
+#endif
+}
+
+static void disable_irq_lockdep(unsigned int irq)
+{
+	disable_irq(irq);
+#ifdef CONFIG_LOCKDEP
+	local_irq_disable();
+#endif
+}
+
+static void enable_irq_lockdep(unsigned int irq)
+{
+#ifdef CONFIG_LOCKDEP
+	local_irq_enable();
+#endif
+	enable_irq(irq);
+}
+
 #ifndef __ARCH_SET_SOFTIRQ_PENDING
 #define set_softirq_pending(x) (local_softirq_pending() = (x))
 #define or_softirq_pending(x)  (local_softirq_pending() |= (x))
