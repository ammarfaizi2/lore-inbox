Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWALRSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWALRSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWALRRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:17:55 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:51678 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932302AbWALRRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:17:50 -0500
Date: Thu, 12 Jan 2006 18:17:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 11/13] s390: cputime misaccounting.
Message-ID: <20060112171745.GL16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 11/13] s390: cputime misaccounting.

finish_arch_switch needs to update the user cpu time as well, not
just the system cpu time. Otherwise the partial user cpu time
of a process that is stored in the lowcore will be (mis-)accounted
to the next process.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/kernel/time.c   |    2 +-
 arch/s390/kernel/vtime.c  |   27 ++++++++++++++++++++++++++-
 include/asm-s390/system.h |    5 +++--
 include/linux/hardirq.h   |    4 ----
 4 files changed, 30 insertions(+), 8 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/time.c	2006-01-12 15:44:01.000000000 +0100
@@ -214,7 +214,7 @@ void account_ticks(struct pt_regs *regs)
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-	account_user_vtime(current);
+	account_tick_vtime(current);
 #else
 	while (ticks--)
 		update_process_times(user_mode(regs));
diff -urpN linux-2.6/arch/s390/kernel/vtime.c linux-2.6-patched/arch/s390/kernel/vtime.c
--- linux-2.6/arch/s390/kernel/vtime.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/vtime.c	2006-01-12 15:44:01.000000000 +0100
@@ -32,7 +32,7 @@ DEFINE_PER_CPU(struct vtimer_queue, virt
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-void account_user_vtime(struct task_struct *tsk)
+void account_tick_vtime(struct task_struct *tsk)
 {
 	cputime_t cputime;
 	__u64 timer, clock;
@@ -76,6 +76,31 @@ void account_user_vtime(struct task_stru
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
+void account_vtime(struct task_struct *tsk)
+{
+	cputime_t cputime;
+	__u64 timer;
+
+	timer = S390_lowcore.last_update_timer;
+	asm volatile ("  STPT %0"    /* Store current cpu timer value */
+		      : "=m" (S390_lowcore.last_update_timer) );
+	S390_lowcore.system_timer += timer - S390_lowcore.last_update_timer;
+
+	cputime = S390_lowcore.user_timer >> 12;
+	S390_lowcore.user_timer -= cputime << 12;
+	S390_lowcore.steal_clock -= cputime << 12;
+	account_user_time(tsk, cputime);
+
+	cputime =  S390_lowcore.system_timer >> 12;
+	S390_lowcore.system_timer -= cputime << 12;
+	S390_lowcore.steal_clock -= cputime << 12;
+	account_system_time(tsk, 0, cputime);
+}
+
+/*
+ * Update process times based on virtual cpu times stored by entry.S
+ * to the lowcore fields user_timer, system_timer & steal_clock.
+ */
 void account_system_vtime(struct task_struct *tsk)
 {
 	cputime_t cputime;
diff -urpN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/system.h	2006-01-12 15:44:01.000000000 +0100
@@ -105,13 +105,14 @@ static inline void restore_access_regs(u
 } while (0)
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-extern void account_user_vtime(struct task_struct *);
+extern void account_vtime(struct task_struct *);
+extern void account_tick_vtime(struct task_struct *);
 extern void account_system_vtime(struct task_struct *);
 #endif
 
 #define finish_arch_switch(prev) do {					     \
 	set_fs(current->thread.mm_segment);				     \
-	account_system_vtime(prev);					     \
+	account_vtime(prev);						     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urpN linux-2.6/include/linux/hardirq.h linux-2.6-patched/include/linux/hardirq.h
--- linux-2.6/include/linux/hardirq.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/include/linux/hardirq.h	2006-01-12 15:44:01.000000000 +0100
@@ -93,10 +93,6 @@ extern void synchronize_irq(unsigned int
 struct task_struct;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
-static inline void account_user_vtime(struct task_struct *tsk)
-{
-}
-
 static inline void account_system_vtime(struct task_struct *tsk)
 {
 }
