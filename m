Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVFGLOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVFGLOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVFGLOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:14:14 -0400
Received: from ozlabs.org ([203.10.76.45]:64671 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261826AbVFGLOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:14:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17061.33146.809450.784765@cargo.ozlabs.ibm.com>
Date: Tue, 7 Jun 2005 21:14:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, anton@samba.org, ananth@in.ibm.com
Subject: [PATCH 2/2] ppc64 kprobes: remove spurious MSR_SE masking
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Remove spurious MSR_SE reset during kprobe processing. single_step_exception()
already does it for us. Reset it to be safe when executing the fault_handler.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN linux-2.6/arch/ppc64/kernel/kprobes.c g5-ppc64/arch/ppc64/kernel/kprobes.c
--- linux-2.6/arch/ppc64/kernel/kprobes.c	2005-04-26 15:37:55.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/kprobes.c	2005-06-07 21:06:38.000000000 +1000
@@ -177,8 +177,6 @@
 	ret = emulate_step(regs, p->ainsn.insn[0]);
 	if (ret == 0)
 		regs->nip = (unsigned long)p->addr + 4;
-
-	regs->msr &= ~MSR_SE;
 }
 
 static inline int post_kprobe_handler(struct pt_regs *regs)
@@ -215,6 +213,7 @@
 
 	if (kprobe_status & KPROBE_HIT_SS) {
 		resume_execution(current_kprobe, regs);
+		regs->msr &= ~MSR_SE;
 		regs->msr |= kprobe_saved_msr;
 
 		unlock_kprobes();
