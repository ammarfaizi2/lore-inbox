Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbUKKJnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbUKKJnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 04:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUKKJlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 04:41:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:12196 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262198AbUKKJiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 04:38:09 -0500
Date: Thu, 11 Nov 2004 10:38:02 +0100 (MET)
Message-Id: <200411110938.iAB9c2Qo028771@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc1-mm4][4/4] perfctr virtual updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 4/4 of the perfctr interrupt fixes:
- When a task is resumed, check if suspend recorded
  that an overflow interrupt is pending. If so, handle
  the overflow and deliver the signal.
- Split interrupt handler in two parts: one used
  only for hardware interrupts, and one also used
  for software-generated interrupts.
- Change signal generation code to not wake up the
  target task (== current). Avoids lockups when the
  interrupt/signal is generated from switch_to().
- Remove obsolete comment at vperfctr_suspend().

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/virtual.c |   41 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 36 insertions(+), 5 deletions(-)

diff -rupN linux-2.6.10-rc1-mm4/drivers/perfctr/virtual.c linux-2.6.10-rc1-mm4.perfctr-virtual-update/drivers/perfctr/virtual.c
--- linux-2.6.10-rc1-mm4/drivers/perfctr/virtual.c	2004-11-10 18:02:56.000000000 +0100
+++ linux-2.6.10-rc1-mm4.perfctr-virtual-update/drivers/perfctr/virtual.c	2004-11-11 00:30:09.000000000 +0100
@@ -57,6 +57,7 @@ struct vperfctr {
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 
 static void vperfctr_ihandler(unsigned long pc);
+static void vperfctr_handle_overflow(struct task_struct*, struct vperfctr*);
 
 static inline void vperfctr_set_ihandler(void)
 {
@@ -202,8 +203,6 @@ static unsigned long long new_inheritanc
 
 /* PRE: IS_RUNNING(perfctr)
  * Suspend the counters.
- * XXX: When called from switch_to(), perfctr belongs to 'prev'
- * but current is 'next'.
  */
 static inline void vperfctr_suspend(struct vperfctr *perfctr)
 {
@@ -225,6 +224,18 @@ static inline void vperfctr_resume(struc
 	vperfctr_reset_sampling_timer(perfctr);
 }
 
+static inline void vperfctr_resume_with_overflow_check(struct vperfctr *perfctr)
+{
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+	if (perfctr->cpu_state.pending_interrupt) {
+		perfctr->cpu_state.pending_interrupt = 0;
+		vperfctr_handle_overflow(current, perfctr);
+		return;
+	}
+#endif
+	vperfctr_resume(perfctr);
+}
+
 /* Sample the counters but do not suspend them. */
 static void vperfctr_sample(struct vperfctr *perfctr)
 {
@@ -241,8 +252,6 @@ static void vperfctr_ihandler(unsigned l
 {
 	struct task_struct *tsk = current;
 	struct vperfctr *perfctr;
-	unsigned int pmc_mask;
-	siginfo_t si;
 
 	perfctr = tsk->thread.perfctr;
 	if (!perfctr) {
@@ -256,6 +265,16 @@ static void vperfctr_ihandler(unsigned l
 		return;
 	}
 	vperfctr_suspend(perfctr);
+	vperfctr_handle_overflow(tsk, perfctr);
+}
+
+static void vperfctr_handle_overflow(struct task_struct *tsk,
+				     struct vperfctr *perfctr)
+{
+	unsigned int pmc_mask;
+	siginfo_t si;
+	sigset_t old_blocked;
+
 	pmc_mask = perfctr_cpu_identify_overflow(&perfctr->cpu_state);
 	if (!pmc_mask) {
 		printk(KERN_ERR "%s: BUG! pid %d has unidentifiable overflow source\n",
@@ -274,8 +293,20 @@ static void vperfctr_ihandler(unsigned l
 	si.si_errno = 0;
 	si.si_code = SI_PMC_OVF;
 	si.si_pmc_ovf_mask = pmc_mask;
+
+	/* deliver signal without waking up the receiver */
+	spin_lock_irq(&tsk->sighand->siglock);
+	old_blocked = tsk->blocked;
+	sigaddset(&tsk->blocked, si.si_signo);
+	spin_unlock_irq(&tsk->sighand->siglock);
+
 	if (!send_sig_info(si.si_signo, &si, tsk))
 		send_sig(si.si_signo, tsk, 1);
+
+	spin_lock_irq(&tsk->sighand->siglock);
+	tsk->blocked = old_blocked;
+	recalc_sigpending();
+	spin_unlock_irq(&tsk->sighand->siglock);
 }
 #endif
 
@@ -462,7 +493,7 @@ void __vperfctr_resume(struct vperfctr *
 			return;
 		}
 #endif
-		vperfctr_resume(perfctr);
+		vperfctr_resume_with_overflow_check(perfctr);
 	}
 }
 
