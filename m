Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWI3ALw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWI3ALw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWI3AKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:10:04 -0400
Received: from www.osadl.org ([213.239.205.134]:10900 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422786AbWI3AEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:04 -0400
Message-Id: <20060929234439.721237000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:27 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 08/23] dynticks: prepare the RCU code
Content-Disposition: inline; filename=rcu-prepare-for-nohz.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

prepare the RCU code for dynticks/nohz. Since on nohz kernels there
is no guaranteed timer IRQ that processes RCU callbacks, the idle
code has to make sure that all RCU callbacks that can be finished
off are indeed finished off. This patch adds the necessary APIs:
rcu_advance_callbacks() [to register quiescent state] and
rcu_process_callbacks() [to finish finishable RCU callbacks].

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 include/linux/rcupdate.h |    2 ++
 kernel/rcupdate.c        |   13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/include/linux/rcupdate.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/rcupdate.h	2006-09-30 01:41:13.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/rcupdate.h	2006-09-30 01:41:16.000000000 +0200
@@ -271,6 +271,7 @@ extern int rcu_needs_cpu(int cpu);
 
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
+extern void rcu_advance_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
 extern long rcu_batches_completed(void);
 extern long rcu_batches_completed_bh(void);
@@ -283,6 +284,7 @@ extern void FASTCALL(call_rcu_bh(struct 
 extern void synchronize_rcu(void);
 void synchronize_idle(void);
 extern void rcu_barrier(void);
+extern void rcu_process_callbacks(unsigned long unused);
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */
Index: linux-2.6.18-mm2/kernel/rcupdate.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/rcupdate.c	2006-09-30 01:41:13.000000000 +0200
+++ linux-2.6.18-mm2/kernel/rcupdate.c	2006-09-30 01:41:16.000000000 +0200
@@ -460,7 +460,7 @@ static void __rcu_process_callbacks(stru
 		rcu_do_batch(rdp);
 }
 
-static void rcu_process_callbacks(unsigned long unused)
+void rcu_process_callbacks(unsigned long unused)
 {
 	__rcu_process_callbacks(&rcu_ctrlblk, &__get_cpu_var(rcu_data));
 	__rcu_process_callbacks(&rcu_bh_ctrlblk, &__get_cpu_var(rcu_bh_data));
@@ -515,6 +515,17 @@ int rcu_needs_cpu(int cpu)
 	return (!!rdp->curlist || !!rdp_bh->curlist || rcu_pending(cpu));
 }
 
+void rcu_advance_callbacks(int cpu, int user)
+{
+	if (user ||
+	    (idle_cpu(cpu) && !in_softirq() &&
+				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
+		rcu_qsctr_inc(cpu);
+		rcu_bh_qsctr_inc(cpu);
+	} else if (!in_softirq())
+		rcu_bh_qsctr_inc(cpu);
+}
+
 void rcu_check_callbacks(int cpu, int user)
 {
 	if (user || 

--

