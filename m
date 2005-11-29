Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVK2TYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVK2TYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVK2TYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:24:04 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23794 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751316AbVK2TYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:24:02 -0500
Subject: floating point register corruption
From: Paolo Galtieri <pgaltieri@mvista.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 12:24:01 -0700
Message-Id: <1133292241.26244.11.camel@playin.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
  I recently discovered a bug on PPC which causes the floating
point registers to get corrupted when CONFIG_PREEMPT=y.

The problem occurred while running a multi threaded Java application
that does floating point.  The problem could be reproduced in
anywhere from 2 to 6 hours.  With the patch I have included below
it ran for over a week without failure.

Paolo

Signed-off-by: pgaltieri@mvista.com

--- linux-2.6.15-rc3/arch/ppc/kernel/process.c	2005-11-29
07:01:55.000000000 -0700
+++ new-linux-2.6.15-rc3/arch/ppc/kernel/process.c	2005-11-29
07:20:37.000000000 -0700
@@ -417,6 +417,7 @@
 
 void exit_thread(void)
 {
+	preempt_disable();
 	if (last_task_used_math == current)
 		last_task_used_math = NULL;
 	if (last_task_used_altivec == current)
@@ -425,10 +426,12 @@
 	if (last_task_used_spe == current)
 		last_task_used_spe = NULL;
 #endif
+	preempt_enable();
 }
 
 void flush_thread(void)
 {
+	preempt_disable();
 	if (last_task_used_math == current)
 		last_task_used_math = NULL;
 	if (last_task_used_altivec == current)
@@ -437,6 +440,7 @@
 	if (last_task_used_spe == current)
 		last_task_used_spe = NULL;
 #endif
+	preempt_enable();
 }
 
 void
@@ -535,6 +539,7 @@
 	regs->nip = nip;
 	regs->gpr[1] = sp;
 	regs->msr = MSR_USER;
+	preempt_disable();
 	if (last_task_used_math == current)
 		last_task_used_math = NULL;
 	if (last_task_used_altivec == current)
@@ -543,6 +548,7 @@
 	if (last_task_used_spe == current)
 		last_task_used_spe = NULL;
 #endif
+	preempt_enable();
 	memset(current->thread.fpr, 0, sizeof(current->thread.fpr));
 	current->thread.fpscr.val = 0;
 #ifdef CONFIG_ALTIVEC


