Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUHQDEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUHQDEV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUHQDEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:04:20 -0400
Received: from ozlabs.org ([203.10.76.45]:47765 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261951AbUHQDD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:03:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.30247.693717.232296@cargo.ozlabs.ibm.com>
Date: Tue, 17 Aug 2004 13:06:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Fix idle loop for offline cpu
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the default_idle and dedicated_idle loops, there are some inner
loops out of which we should break if the cpu is marked offline.
Otherwise, it is possible for the cpu to get stuck and never actually
go offline.  shared_idle is unaffected.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/idle.c~ppc64-fix-idle-loop-for-offline-cpu arch/ppc64/kernel/idle.c
--- 2.6.8-rc4/arch/ppc64/kernel/idle.c~ppc64-fix-idle-loop-for-offline-cpu	2004-08-11 10:44:29.000000000 -0500
+++ 2.6.8-rc4-nathanl/arch/ppc64/kernel/idle.c	2004-08-11 10:44:29.000000000 -0500
@@ -132,6 +132,7 @@ int iSeries_idle(void)
 int default_idle(void)
 {
 	long oldval;
+	unsigned int cpu = smp_processor_id();
 
 	while (1) {
 		oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
@@ -139,7 +140,7 @@ int default_idle(void)
 		if (!oldval) {
 			set_thread_flag(TIF_POLLING_NRFLAG);
 
-			while (!need_resched()) {
+			while (!need_resched() && !cpu_is_offline(cpu)) {
 				barrier();
 				HMT_low();
 			}
@@ -151,8 +152,7 @@ int default_idle(void)
 		}
 
 		schedule();
-		if (cpu_is_offline(smp_processor_id()) &&
-				system_state == SYSTEM_RUNNING)
+		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
 
@@ -169,8 +169,9 @@ int dedicated_idle(void)
 	struct paca_struct *lpaca = get_paca(), *ppaca;
 	unsigned long start_snooze;
 	unsigned long *smt_snooze_delay = &__get_cpu_var(smt_snooze_delay);
+	unsigned int cpu = smp_processor_id();
 
-	ppaca = &paca[smp_processor_id() ^ 1];
+	ppaca = &paca[cpu ^ 1];
 
 	while (1) {
 		/* Indicate to the HV that we are idle.  Now would be
@@ -182,7 +183,7 @@ int dedicated_idle(void)
 			set_thread_flag(TIF_POLLING_NRFLAG);
 			start_snooze = __get_tb() +
 				*smt_snooze_delay * tb_ticks_per_usec;
-			while (!need_resched()) {
+			while (!need_resched() && !cpu_is_offline(cpu)) {
 				/* need_resched could be 1 or 0 at this 
 				 * point.  If it is 0, set it to 0, so
 				 * an IPI/Prod is sent.  If it is 1, keep
@@ -241,8 +242,7 @@ int dedicated_idle(void)
 		HMT_medium();
 		lpaca->lppaca.xIdle = 0;
 		schedule();
-		if (cpu_is_offline(smp_processor_id()) &&
-				system_state == SYSTEM_RUNNING)
+		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
 	return 0;
