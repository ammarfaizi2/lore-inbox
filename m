Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753091AbWKCE2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbWKCE2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbWKCE1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:27:55 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:28545 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753084AbWKCE1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:27:52 -0500
Message-Id: <20061103042749.944489000@us.ibm.com>
References: <20061103042257.274316000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 02 Nov 2006 20:23:03 -0800
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/9] Task Watchers v2: Register IRQ flag tracing task watcher
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

Benchmark results:
System: 4 1.7GHz ppc64 (Power 4+) processors, 30968600MB RAM, 2.6.19-rc2-mm2 kernel

Clone	Number of Children Cloned
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17826.5 	18077.4 	18160.1 	18263.6 	18343	 	18350.8
Dev	305.841 	306.331 	283.323 	284.761 	292.732 	292.882
Err (%)	1.71565 	1.69455 	1.56014 	1.55917 	1.59588 	1.59602

Fork	Number of Children Forked
	5000		7500		10000		12500		15000		17500
	---------------------------------------------------------------------------------------
Mean	17813.5 	18062.4 	18140.5 	18246.7 	18237.8 	18275.2
Dev	305.816 	294.914 	294.779 	294.727 	323.996 	300.176
Err (%)	1.71677 	1.63275 	1.62498 	1.61523 	1.77651 	1.64253

Kernbench:
Elapsed: 124.4s User: 439.787s System: 46.485s CPU: 390.3%
439.70user 46.43system 2:04.64elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.92user 46.38system 2:04.47elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.79user 46.62system 2:04.44elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.83user 46.46system 2:04.29elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.73user 46.47system 2:04.12elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.83user 46.49system 2:04.10elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.76user 46.42system 2:04.41elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k
439.70user 46.64system 2:04.30elapsed 391%CPU (0avgtext+0avgdata 0maxresident)k
439.79user 46.47system 2:04.76elapsed 389%CPU (0avgtext+0avgdata 0maxresident)k
439.82user 46.47system 2:04.47elapsed 390%CPU (0avgtext+0avgdata 0maxresident)k

Index: linux-2.6.19-rc2-mm2/kernel/fork.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/fork.c
+++ linux-2.6.19-rc2-mm2/kernel/fork.c
@@ -1052,29 +1052,10 @@ static struct task_struct *copy_process(
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
Index: linux-2.6.19-rc2-mm2/kernel/irq/handle.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/irq/handle.c
+++ linux-2.6.19-rc2-mm2/kernel/irq/handle.c
@@ -13,10 +13,11 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/task_watchers.h>
 
 #include "internals.h"
 
 /**
  * handle_bad_irq - handle spurious and unhandled irqs
@@ -266,6 +267,29 @@ void early_init_irq_lock_class(void)
 
 	for (i = 0; i < NR_IRQS; i++)
 		lockdep_set_class(&irq_desc[i].lock, &irq_desc_lock_class);
 }
 
+static int init_task_trace_irqflags(unsigned long clone_flags,
+				    struct task_struct *p)
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
+task_watcher_func(init, init_task_trace_irqflags);
 #endif

--
