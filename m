Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269038AbUINV6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269038AbUINV6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269592AbUINRKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:10:00 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:56812 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S269531AbUINQNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:13:04 -0400
Date: Wed, 15 Sep 2004 01:12:53 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fixed do_signal in arch/mips/kernel/signal.c
Message-Id: <20040915011253.6c0a1bb1.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The change of get_signal_to_deliver() is followed.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff vr-orig/arch/mips/kernel/signal.c vr/arch/mips/kernel/signal.c
--- vr-orig/arch/mips/kernel/signal.c	Wed Sep 15 00:50:11 2004
+++ vr/arch/mips/kernel/signal.c	Wed Sep 15 00:31:06 2004
@@ -480,10 +480,8 @@
 	struct pt_regs *regs, int signr, sigset_t *set, siginfo_t *info);
 
 static inline void handle_signal(unsigned long sig, siginfo_t *info,
-	sigset_t *oldset, struct pt_regs *regs)
+	struct k_sigaction *ka, sigset_t *oldset, struct pt_regs *regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 	switch(regs->regs[0]) {
 	case ERESTART_RESTARTBLOCK:
 	case ERESTARTNOHAND:
@@ -535,6 +533,7 @@
 
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
+	struct k_sigaction ka;
 	siginfo_t info;
 	int signr;
 
@@ -560,9 +559,9 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka, oldset, regs);
 		return 1;
 	}
 
