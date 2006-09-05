Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWIEPW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWIEPW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWIEPW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:22:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1502 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965158AbWIEPWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:22:54 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060905132530.GD9173@stusta.de> 
References: <20060905132530.GD9173@stusta.de>  <20060901015818.42767813.akpm@osdl.org> 
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: [PATCH] FRV: Fix {dis,en}able_irq_lockdep_irqrestore compile error 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 16:21:03 +0100
Message-ID: <5905.1157469663@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the lack of certain non-LOCKDEP stub functions in linux/interrupt.h and
also provide FRV with LOCKDEP variants.

This is to be applied to -mm kernel since not all of the functions added exist
in the main kernel.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-irq-lockdep-2618rc5mm1.diff 
 include/asm-frv/irq.h     |   43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/interrupt.h |    2 ++
 2 files changed, 45 insertions(+)

diff -urp ../kernels/linux-2.6.18-rc5-mm1/include/asm-frv/irq.h linux-2.6.18-rc5-mm1-frv/include/asm-frv/irq.h
--- ../kernels/linux-2.6.18-rc5-mm1/include/asm-frv/irq.h	2006-09-04 18:02:48.000000000 +0100
+++ linux-2.6.18-rc5-mm1-frv/include/asm-frv/irq.h	2006-09-05 15:59:08.000000000 +0100
@@ -39,5 +39,48 @@ extern void disable_irq_nosync(unsigned 
 extern void disable_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
 
+#ifdef CONFIG_LOCKDEP
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
+static inline void disable_irq_nosync_lockdep(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+	local_irq_disable();
+}
+
+static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
+{
+	disable_irq_nosync(irq);
+	local_irq_save(*flags);
+}
+
+static inline void disable_irq_lockdep(unsigned int irq)
+{
+	disable_irq(irq);
+	local_irq_disable();
+}
+
+static inline void enable_irq_lockdep(unsigned int irq)
+{
+	local_irq_enable();
+	enable_irq(irq);
+}
+
+static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
+{
+	local_irq_restore(*flags);
+	enable_irq(irq);
+}
+#endif /* CONFIG_LOCKDEP */
+
 
 #endif /* _ASM_IRQ_H_ */
diff -urp ../kernels/linux-2.6.18-rc5-mm1/include/linux/interrupt.h linux-2.6.18-rc5-mm1-frv/include/linux/interrupt.h
--- ../kernels/linux-2.6.18-rc5-mm1/include/linux/interrupt.h	2006-09-04 18:03:31.000000000 +0100
+++ linux-2.6.18-rc5-mm1-frv/include/linux/interrupt.h	2006-09-05 15:58:53.000000000 +0100
@@ -178,6 +178,8 @@ static inline int disable_irq_wake(unsig
 #  define disable_irq_nosync_lockdep(irq)	disable_irq_nosync(irq)
 #  define disable_irq_lockdep(irq)		disable_irq(irq)
 #  define enable_irq_lockdep(irq)		enable_irq(irq)
+#  define disable_irq_nosync_lockdep_irqsave(irq, flags) disable_irq_nosync(irq)
+#  define enable_irq_lockdep_irqrestore(irq, flags) enable_irq(irq)
 # endif
 
 #endif /* CONFIG_GENERIC_HARDIRQS */
