Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263623AbUFHMIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUFHMIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 08:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbUFHMIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 08:08:50 -0400
Received: from ozlabs.org ([203.10.76.45]:10404 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263623AbUFHMIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 08:08:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16581.44245.915504.200875@cargo.ozlabs.ibm.com>
Date: Tue, 8 Jun 2004 22:11:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH][PPC64] Single-stepping emulated instructions
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally the ppc64 kernel emulates a usermode instruction, for
example in the alignment exception handler.  Kumar Gala pointed out
(in the context of the ppc32 kernel) that if the instruction was being
single-stepped, and we end up emulating the instruction, we should
then send the process a SIGTRAP as if it had not been emulated and the
process had then taken a single-step exception.  This patch implements
this for ppc64.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/traps.c b/arch/ppc64/kernel/traps.c
--- linux-2.5/arch/ppc64/kernel/traps.c	2004-06-08 21:37:05.344964616 +1000
+++ b/arch/ppc64/kernel/traps.c	2004-06-08 15:31:36.000000000 +1000
@@ -500,6 +500,18 @@
 	_exception(SIGTRAP, &info, regs);	
 }
 
+/*
+ * After we have successfully emulated an instruction, we have to
+ * check if the instruction was being single-stepped, and if so,
+ * pretend we got a single-step exception.  This was pointed out
+ * by Kumar Gala.  -- paulus
+ */
+static inline void emulate_single_step(struct pt_regs *regs)
+{
+	if (regs->msr & MSR_SE)
+		SingleStepException(regs);
+}
+
 static void dummy_perf(struct pt_regs *regs)
 {
 }
@@ -521,10 +533,8 @@
 	fixed = fix_alignment(regs);
 
 	if (fixed == 1) {
-		if (!user_mode(regs))
-			PPCDBG(PPCDBG_ALIGNFIXUP, "fix alignment at %lx\n",
-			       regs->nip);
 		regs->nip += 4;	/* skip over emulated instruction */
+		emulate_single_step(regs);
 		return;
 	}
 
