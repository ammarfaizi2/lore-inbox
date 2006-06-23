Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWFWN1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWFWN1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFWN1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:27:34 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:40972 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751377AbWFWN1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:27:33 -0400
Date: Fri, 23 Jun 2006 15:26:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [patch 3/4] lock validator: s390 mcck handler cleanup+fix
Message-ID: <20060623132657.GG9446@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use lockdep_off/on instead of raw_spinlocks in machine check code.
Also add a missing TRACE_IRQ_OFF/ON pair.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/entry.S   |    2 ++
 arch/s390/kernel/entry64.S |    2 ++
 drivers/s390/s390mach.c    |    9 ++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-2.6.17-mm1/arch/s390/kernel/entry.S
===================================================================
--- linux-2.6.17-mm1.orig/arch/s390/kernel/entry.S
+++ linux-2.6.17-mm1/arch/s390/kernel/entry.S
@@ -733,8 +733,10 @@ mcck_no_vtime:
 	stosm	__SF_EMPTY(%r15),0x04	# turn dat on
 	tm	__TI_flags+3(%r9),_TIF_MCCK_PENDING
 	bno	BASED(mcck_return)
+	TRACE_IRQS_OFF
 	l	%r1,BASED(.Ls390_handle_mcck)
 	basr	%r14,%r1		# call machine check handler
+	TRACE_IRQS_ON
 mcck_return:
         RESTORE_ALL __LC_RETURN_MCCK_PSW,0
 
Index: linux-2.6.17-mm1/arch/s390/kernel/entry64.S
===================================================================
--- linux-2.6.17-mm1.orig/arch/s390/kernel/entry64.S
+++ linux-2.6.17-mm1/arch/s390/kernel/entry64.S
@@ -744,7 +744,9 @@ mcck_no_vtime:
 	stosm	__SF_EMPTY(%r15),0x04	# turn dat on
 	tm	__TI_flags+7(%r9),_TIF_MCCK_PENDING
 	jno	mcck_return
+	TRACE_IRQS_OFF
 	brasl	%r14,s390_handle_mcck
+	TRACE_IRQS_ON
 mcck_return:
         RESTORE_ALL __LC_RETURN_MCCK_PSW,0
 
Index: linux-2.6.17-mm1/drivers/s390/s390mach.c
===================================================================
--- linux-2.6.17-mm1.orig/drivers/s390/s390mach.c
+++ linux-2.6.17-mm1/drivers/s390/s390mach.c
@@ -371,7 +371,7 @@ s390_revalidate_registers(struct mci *mc
 void
 s390_do_machine_check(struct pt_regs *regs)
 {
-	static raw_spinlock_t ipd_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(ipd_lock);
 	static unsigned long long last_ipd;
 	static int ipd_count;
 	unsigned long long tmp;
@@ -379,6 +379,8 @@ s390_do_machine_check(struct pt_regs *re
 	struct mcck_struct *mcck;
 	int umode;
 
+	lockdep_off();
+
 	mci = (struct mci *) &S390_lowcore.mcck_interruption_code;
 	mcck = &__get_cpu_var(cpu_mcck);
 	umode = user_mode(regs);
@@ -417,7 +419,7 @@ s390_do_machine_check(struct pt_regs *re
 			 * retry this instruction.
 			 */
 
-			__raw_spin_lock(&ipd_lock);
+			spin_lock(&ipd_lock);
 
 			tmp = get_clock();
 
@@ -431,7 +433,7 @@ s390_do_machine_check(struct pt_regs *re
 			if (ipd_count == MAX_IPD_COUNT)
 				s390_handle_damage("too many ipd retries.");
 
-			__raw_spin_unlock(&ipd_lock);
+			spin_unlock(&ipd_lock);
 		}
 		else {
 			/* Processing damage -> stopping machine */
@@ -483,6 +485,7 @@ s390_do_machine_check(struct pt_regs *re
 		mcck->warning = 1;
 		set_thread_flag(TIF_MCCK_PENDING);
 	}
+	lockdep_on();
 }
 
 /*
