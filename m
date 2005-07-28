Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVG1Qmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVG1Qmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVG1Qmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:42:32 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:11180 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261692AbVG1QkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:40:05 -0400
Message-Id: <200507281626.j6SGQmup009486@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/7] UML - Fix load average >=1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jul 2005 12:26:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

update_process_times was missing its irq_enter/irq_exit wrapper.  This caused
ksoftirqd to be scheduled on every clock tick.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm2/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.12-rc3-mm2.orig/arch/um/kernel/time_kern.c	2005-07-28 11:06:35.000000000 -0400
+++ linux-2.6.12-rc3-mm2/arch/um/kernel/time_kern.c	2005-07-28 11:26:17.000000000 -0400
@@ -137,7 +137,10 @@
 void timer_handler(int sig, union uml_pt_regs *regs)
 {
 	local_irq_disable();
-	update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)), (regs)->skas.is_user));
+	irq_enter();
+	update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)), 
+					 (regs)->skas.is_user));
+	irq_exit();
 	local_irq_enable();
 	if(current_thread->cpu == 0)
 		timer_irq(regs);

