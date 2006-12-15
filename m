Return-Path: <linux-kernel-owner+w=401wt.eu-S1750865AbWLOAYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWLOAYv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWLOAXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:23:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:42182 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbWLOAXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:23:41 -0500
Message-Id: <20061215000819.253054000@us.ibm.com>
References: <20061215000754.764718000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:08:00 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>
Subject: Register IRQ flag tracing task watcher
Content-Disposition: inline; filename=task-watchers-register-trace-irqflags
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register an irq-flag-tracing task watcher instead of hooking into
copy_process().

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/fork.c       |   19 -------------------
 kernel/irq/handle.c |   24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 19 deletions(-)

Index: linux-2.6.19/kernel/fork.c
===================================================================
--- linux-2.6.19.orig/kernel/fork.c
+++ linux-2.6.19/kernel/fork.c
@@ -1059,29 +1059,10 @@ static struct task_struct *copy_process(
 		p->tgid = current->tgid;
 
 	retval = notify_task_watchers(WATCH_TASK_INIT, clone_flags, p);
 	if (retval < 0)
 		goto bad_fork_cleanup_delays_binfmt;
-#ifdef CONFIG_TRACE_IRQFLAGS
-	p->irq_events = 0;
-#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
-	p->hardirqs_enabled = 1;
-#else
-	p->hardirqs_enabled = 0;
-#endif
-	p->hardirq_enable_ip = 0;
-	p->hardirq_enable_event = 0;
-	p->hardirq_disable_ip = _THIS_IP_;
-	p->hardirq_disable_event = 0;
-	p->softirqs_enabled = 1;
-	p->softirq_enable_ip = _THIS_IP_;
-	p->softirq_enable_event = 0;
-	p->softirq_disable_ip = 0;
-	p->softirq_disable_event = 0;
-	p->hardirq_context = 0;
-	p->softirq_context = 0;
-#endif
 #ifdef CONFIG_LOCKDEP
 	p->lockdep_depth = 0; /* no locks held yet */
 	p->curr_chain_key = 0;
 	p->lockdep_recursion = 0;
 #endif
Index: linux-2.6.19/kernel/irq/handle.c
===================================================================
--- linux-2.6.19.orig/kernel/irq/handle.c
+++ linux-2.6.19/kernel/irq/handle.c
@@ -13,10 +13,11 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/init.h>
 
 #include "internals.h"
 
 /**
  * handle_bad_irq - handle spurious and unhandled irqs
@@ -266,6 +267,29 @@ void early_init_irq_lock_class(void)
 
 	for (i = 0; i < NR_IRQS; i++)
 		lockdep_set_class(&irq_desc[i].lock, &irq_desc_lock_class);
 }
 
+static int __task_init init_task_trace_irqflags(unsigned long clone_flags,
+			    			struct task_struct *p)
+{
+	p->irq_events = 0;
+#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+	p->hardirqs_enabled = 1;
+#else
+	p->hardirqs_enabled = 0;
+#endif
+	p->hardirq_enable_ip = 0;
+	p->hardirq_enable_event = 0;
+	p->hardirq_disable_ip = _THIS_IP_;
+	p->hardirq_disable_event = 0;
+	p->softirqs_enabled = 1;
+	p->softirq_enable_ip = _THIS_IP_;
+	p->softirq_enable_event = 0;
+	p->softirq_disable_ip = 0;
+	p->softirq_disable_event = 0;
+	p->hardirq_context = 0;
+	p->softirq_context = 0;
+	return 0;
+}
+DEFINE_TASK_INITCALL(init_task_trace_irqflags);
 #endif

--
