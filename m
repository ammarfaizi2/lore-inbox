Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWFVIUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWFVIUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWFVIUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:20:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:35265 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964850AbWFVIUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:20:09 -0400
Date: Thu, 22 Jun 2006 10:15:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch] lock validator: clean up IRQ entry/exit
Message-ID: <20060622081510.GA25138@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: clean up IRQ entry/exit
From: Ingo Molnar <mingo@elte.hu>

preparation for the resurrection of handling NMIs under the lock 
validator:

- introduce __irq_exit() as a no-softirqs variant of IRQ exit
- make NMI exit use __irq_exit()
- make the locking API self-tests use irq_enter/__irq_exit.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/hardirq.h |   23 ++++++++++++++++-------
 lib/locking-selftest.c  |    4 ++--
 2 files changed, 18 insertions(+), 9 deletions(-)

Index: linux/include/linux/hardirq.h
===================================================================
--- linux.orig/include/linux/hardirq.h
+++ linux/include/linux/hardirq.h
@@ -86,13 +86,6 @@ extern void synchronize_irq(unsigned int
 # define synchronize_irq(irq)	barrier()
 #endif
 
-#define nmi_enter()		irq_enter()
-#define nmi_exit()					\
-	do {						\
-		sub_preempt_count(HARDIRQ_OFFSET);	\
-		trace_hardirq_exit();			\
-	} while (0)
-
 struct task_struct;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
@@ -114,6 +107,22 @@ static inline void account_system_vtime(
 		trace_hardirq_enter();			\
 	} while (0)
 
+/*
+ * Exit irq context without processing softirqs:
+ */
+#define __irq_exit()					\
+	do {						\
+		trace_hardirq_exit();			\
+		account_system_vtime(current);		\
+		sub_preempt_count(HARDIRQ_OFFSET);	\
+	} while (0)
+
+/*
+ * Exit irq context and process softirqs if needed:
+ */
 extern void irq_exit(void);
 
+#define nmi_enter()		irq_enter()
+#define nmi_exit()		__irq_exit()
+
 #endif /* LINUX_HARDIRQ_H */
Index: linux/lib/locking-selftest.c
===================================================================
--- linux.orig/lib/locking-selftest.c
+++ linux/lib/locking-selftest.c
@@ -144,11 +144,11 @@ static void init_shared_types(void)
 
 #define HARDIRQ_ENTER()				\
 	local_irq_disable();			\
-	nmi_enter();				\
+	irq_enter();				\
 	WARN_ON(!in_irq());
 
 #define HARDIRQ_EXIT()				\
-	nmi_exit();				\
+	__irq_exit();				\
 	local_irq_enable();
 
 #define SOFTIRQ_DISABLE		local_bh_disable
