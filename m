Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVAYQat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVAYQat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVAYQas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:30:48 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:57080 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262004AbVAYQ3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:29:52 -0500
Date: Wed, 26 Jan 2005 01:29:43 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc2-mm1] mips: fixed
 restore_sigcontext/restore_sigcontext32
Message-Id: <20050126012943.7bcbbdcc.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed restore_sigcontext/restore_sigcontext32 about MIPS.
This patch is only for 2.6.11-rc2-mm1.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/kernel/signal.c a/arch/mips/kernel/signal.c
--- a-orig/arch/mips/kernel/signal.c	Tue Jan 25 09:23:41 2005
+++ a/arch/mips/kernel/signal.c	Wed Jan 26 00:05:53 2005
@@ -154,6 +154,7 @@
 asmlinkage int restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
 	int err = 0;
+	unsigned int used_math;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
@@ -178,7 +179,8 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(!!used_math(), &sc->sc_used_math);
+	err |= __get_user(used_math, &sc->sc_used_math);
+	conditional_used_math(used_math);
 
 	preempt_disable();
 
diff -urN -X dontdiff a-orig/arch/mips/kernel/signal32.c a/arch/mips/kernel/signal32.c
--- a-orig/arch/mips/kernel/signal32.c	Tue Jan 25 09:23:41 2005
+++ a/arch/mips/kernel/signal32.c	Wed Jan 26 00:17:33 2005
@@ -337,6 +337,7 @@
 					   struct sigcontext32 *sc)
 {
 	int err = 0;
+	__u32 used_math;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
@@ -361,7 +362,8 @@
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(!!used_math(), &sc->sc_used_math);
+	err |= __get_user(used_math, &sc->sc_used_math);
+	conditional_used_math(used_math);
 
 	preempt_disable();
 

