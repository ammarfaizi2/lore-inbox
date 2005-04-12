Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVDMCZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVDMCZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVDLTot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:44:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:64200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262177AbVDLKcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:02 -0400
Message-Id: <200504121031.j3CAVrBo005435@shell0.pdx.osdl.net>
Subject: [patch 077/198] x86_64: Use a common function to find code segment bases
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

To avoid some code duplication.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/mm/fault.c      |   12 +++++-------
 25-akpm/include/asm-x86_64/ptrace.h |    5 +++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff -puN arch/x86_64/mm/fault.c~x86_64-use-a-common-function-to-find-code-segment-bases arch/x86_64/mm/fault.c
--- 25/arch/x86_64/mm/fault.c~x86_64-use-a-common-function-to-find-code-segment-bases	2005-04-12 03:21:21.786824800 -0700
+++ 25-akpm/arch/x86_64/mm/fault.c	2005-04-12 03:21:21.790824192 -0700
@@ -62,21 +62,19 @@ void bust_spinlocks(int yes)
 static noinline int is_prefetch(struct pt_regs *regs, unsigned long addr,
 				unsigned long error_code)
 { 
-	unsigned char *instr = (unsigned char *)(regs->rip);
+	unsigned char *instr;
 	int scan_more = 1;
 	int prefetch = 0; 
-	unsigned char *max_instr = instr + 15;
+	unsigned char *max_instr;
 
 	/* If it was a exec fault ignore */
 	if (error_code & (1<<4))
 		return 0;
 	
-	/* Code segments in LDT could have a non zero base. Don't check
-	   when that's possible */
-	if (regs->cs & (1<<2))
-		return 0;
+	instr = (unsigned char *)convert_rip_to_linear(current, regs);
+	max_instr = instr + 15;
 
-	if ((regs->cs & 3) != 0 && regs->rip >= TASK_SIZE)
+	if ((regs->cs & 3) != 0 && instr >= (unsigned char *)TASK_SIZE)
 		return 0;
 
 	while (scan_more && instr < max_instr) { 
diff -puN include/asm-x86_64/ptrace.h~x86_64-use-a-common-function-to-find-code-segment-bases include/asm-x86_64/ptrace.h
--- 25/include/asm-x86_64/ptrace.h~x86_64-use-a-common-function-to-find-code-segment-bases	2005-04-12 03:21:21.787824648 -0700
+++ 25-akpm/include/asm-x86_64/ptrace.h	2005-04-12 03:21:21.790824192 -0700
@@ -86,6 +86,11 @@ struct pt_regs {
 extern unsigned long profile_pc(struct pt_regs *regs);
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
+struct task_struct;
+
+extern unsigned long
+convert_rip_to_linear(struct task_struct *child, struct pt_regs *regs);
+
 enum {
         EF_CF   = 0x00000001,
         EF_PF   = 0x00000004,
_
