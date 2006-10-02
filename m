Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWJBGuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWJBGuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWJBGuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:50:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54999 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932690AbWJBGuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:50:06 -0400
Date: Mon, 2 Oct 2006 08:41:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch] dynticks: core, NMI watchdog fix
Message-ID: <20061002064127.GA20841@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <20061001225724.985115000@cruncher.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061001225724.985115000@cruncher.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew: find below a fix for a bug that could cause lockups if NO_HZ, 
lockdep and the NMI watchdog are all activated. This patch comes after 
dynticks-core.patch. Compile and boot tested.

	Ingo

----------------->
Subject: dynticks: core, NMI watchdog fix
From: Ingo Molnar <mingo@elte.hu>

fix an NMI-watchdog interaction: we dont want to call
hrtimer_update_jiffies() in NMI contexts ...

create __irq_enter() (which is symmetric to __irq_exit())
and use it in nmi_enter() and irq_enter().

[ Note: like __irq_exit() it needs to be a macro because
  hardirq.h is included early on and types like struct
  task_struct are not available yet. ]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 include/linux/hardirq.h |   12 +++++++++++-
 kernel/softirq.c        |    5 +----
 2 files changed, 12 insertions(+), 5 deletions(-)

Index: linux/include/linux/hardirq.h
===================================================================
--- linux.orig/include/linux/hardirq.h
+++ linux/include/linux/hardirq.h
@@ -106,6 +106,16 @@ static inline void account_system_vtime(
  * always balanced, so the interrupted value of ->hardirq_context
  * will always be restored.
  */
+#define __irq_enter()					\
+	do {						\
+		account_system_vtime(current);		\
+		add_preempt_count(HARDIRQ_OFFSET);	\
+		trace_hardirq_enter();			\
+	} while (0)
+
+/*
+ * Enter irq context (on NO_HZ, update jiffies):
+ */
 extern void irq_enter(void);
 
 /*
@@ -123,7 +133,7 @@ extern void irq_enter(void);
  */
 extern void irq_exit(void);
 
-#define nmi_enter()		do { lockdep_off(); irq_enter(); } while (0)
+#define nmi_enter()		do { lockdep_off(); __irq_enter(); } while (0)
 #define nmi_exit()		do { __irq_exit(); lockdep_on(); } while (0)
 
 #endif /* LINUX_HARDIRQ_H */
Index: linux/kernel/softirq.c
===================================================================
--- linux.orig/kernel/softirq.c
+++ linux/kernel/softirq.c
@@ -278,10 +278,7 @@ EXPORT_SYMBOL(do_softirq);
  */
 void irq_enter(void)
 {
-	account_system_vtime(current);
-	add_preempt_count(HARDIRQ_OFFSET);
-	trace_hardirq_enter();
-
+	__irq_enter();
 #ifdef CONFIG_NO_HZ
 	if (idle_cpu(smp_processor_id()))
 		hrtimer_update_jiffies();
