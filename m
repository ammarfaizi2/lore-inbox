Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUG1SgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUG1SgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUG1SgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:36:20 -0400
Received: from mail1.slu.se ([130.238.96.11]:36008 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S261875AbUG1SgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:36:03 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16647.61953.158512.433946@robur.slu.se>
Date: Wed, 28 Jul 2004 20:35:45 +0200
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <Pine.LNX.4.44.0407272348590.13195-100000@silmu.st.jyu.fi>
References: <16646.47585.814327.628319@robur.slu.se>
	<Pine.LNX.4.44.0407272348590.13195-100000@silmu.st.jyu.fi>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pasi Sjoholm writes:
 > On Tue, 27 Jul 2004, Robert Olsson wrote:

 > It would be nice that one could use the full capacity of his/her computer.
 > This is not a big problem for everyday use for a workstation but prevents 
 > 2.6-series to be used in production-enviroments in the servers.
 > But hey.. we need to do some work and maybe we will resolve this. =)

Well the 2.6 problem we ran into was due to the fact that RCU suffered
from this userland starvation. I think Dipankar is pushing a patch for RCU
this now. But it does not address userland starvation so if you your workload 
can give reproduceably results wrt starvation (Alexey's app) we can do some
tests. First I think should be collect data from current system and check 
that results a reproduceable. 

Below is a patch to monitor softirq's it uses fastroute stats in softnet_stat
you may have to hack it.

And maybe we should take the experiment disussions off the list.

Cheers.
						--ro


--- kernel/softirq.c.orig	2004-03-11 03:55:24.000000000 +0100
+++ kernel/softirq.c	2004-03-31 18:15:26.000000000 +0200
@@ -69,7 +69,13 @@
  */
 #define MAX_SOFTIRQ_RESTART 10
 
-asmlinkage void do_softirq(void)
+
+/* Use the fastroute stats. */
+
+#include <linux/netdevice.h>
+DECLARE_PER_CPU(struct netif_rx_stats, netdev_rx_stat);
+
+asmlinkage void do_softirq(int from)
 {
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	__u32 pending;
@@ -84,9 +90,44 @@
 
 	if (pending) {
 		struct softirq_action *h;
+		struct task_struct *tsk = __get_cpu_var(ksoftirqd);
 
 		local_bh_disable();
+#if 0		
+		/* Avoid softirq's from DoS'ing user apps incl. RCU's etc */
+
+                if (unlikely(from != SIRQ_FROM_KSOFTIRQD && 
+			     tsk  &&
+			     sched_clock() - tsk->timestamp > 
+			     (unsigned long long) 2*1000000000 &&
+			     !(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
+			
+			set_tsk_need_resched(current);
+			local_irq_disable();
+			goto done;
+                }
+#endif
+
 restart:
+		switch (from) {
+			
+		case SIRQ_FROM_BH:
+			__get_cpu_var(netdev_rx_stat).fastroute_hit++;
+			break;
+			
+		case SIRQ_FROM_KSOFTIRQD:
+			__get_cpu_var(netdev_rx_stat).fastroute_success++;
+			break;
+
+		case SIRQ_FROM_IRQEXIT:
+			__get_cpu_var(netdev_rx_stat).fastroute_defer++;
+			break;
+  
+
+		default:
+			__get_cpu_var(netdev_rx_stat).fastroute_deferred_out++;
+			
+		}
 		/* Reset the pending bitmask before enabling irqs */
 		local_softirq_pending() = 0;
 
@@ -106,6 +147,7 @@
 		pending = local_softirq_pending();
 		if (pending && --max_restart)
 			goto restart;
+ done:
 		if (pending)
 			wakeup_softirqd();
 		__local_bh_enable();
@@ -122,7 +164,7 @@
 	WARN_ON(irqs_disabled());
 	if (unlikely(!in_interrupt() &&
 		     local_softirq_pending()))
-		invoke_softirq();
+		invoke_softirq(SIRQ_FROM_BH);
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(local_bh_enable);
@@ -324,7 +366,7 @@
 		__set_current_state(TASK_RUNNING);
 
 		while (local_softirq_pending()) {
-			do_softirq();
+			do_softirq(SIRQ_FROM_KSOFTIRQD);
 			cond_resched();
 		}
 
--- include/linux/netdevice.h~	2004-03-11 03:55:44.000000000 +0100
+++ include/linux/netdevice.h	2004-03-31 12:24:57.000000000 +0200
@@ -669,7 +669,7 @@
 {
        int err = netif_rx(skb);
        if (softirq_pending(smp_processor_id()))
-               do_softirq();
+               do_softirq(SIRQ_FROM_NETIF_RX_NI);
        return err;
 }
 
--- include/linux/interrupt.h.orig	2004-03-31 18:24:03.000000000 +0200
+++ include/linux/interrupt.h	2004-03-31 18:19:28.000000000 +0200
@@ -92,7 +92,17 @@
 	void	*data;
 };
 
-asmlinkage void do_softirq(void);
+/* Softirq originator */
+enum 
+{
+	SIRQ_FROM_KSOFTIRQD=0,
+	SIRQ_FROM_IRQEXIT,
+	SIRQ_FROM_BH,
+	SIRQ_FROM_NETIF_RX_NI,
+	SIRQ_FROM_PKTGEN
+};
+
+asmlinkage void do_softirq(int from);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
 extern void softirq_init(void);
 #define __raise_softirq_irqoff(nr) do { local_softirq_pending() |= 1UL << (nr); } while (0)
@@ -100,7 +110,7 @@
 extern void FASTCALL(raise_softirq(unsigned int nr));
 
 #ifndef invoke_softirq
-#define invoke_softirq() do_softirq()
+#define invoke_softirq(from) do_softirq(from)
 #endif
 
 
--- include/asm-i386/hardirq.h.orig	2004-03-11 03:55:37.000000000 +0100
+++ include/asm-i386/hardirq.h	2004-03-31 18:27:17.000000000 +0200
@@ -88,7 +88,7 @@
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
 		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
+			do_softirq(SIRQ_FROM_IRQEXIT);			\
 		preempt_enable_no_resched();				\
 } while (0)
 
--- net/core/pktgen.c~	2004-03-11 03:55:36.000000000 +0100
+++ net/core/pktgen.c	2004-03-31 12:24:57.000000000 +0200
@@ -710,7 +710,7 @@
 				if (need_resched())
 					schedule();
 				else
-					do_softirq();
+					do_softirq(SIRQ_FROM_PKTGEN);
 			} while (netif_queue_stopped(odev));
 			idle = cycles() - idle_start;
 			info->idle_acc += idle;



