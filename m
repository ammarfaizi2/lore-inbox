Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWHBMnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWHBMnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 08:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWHBMnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 08:43:47 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:1699 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750783AbWHBMnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 08:43:46 -0400
Date: Wed, 2 Aug 2006 08:37:59 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86: rename is_at_popf(), add iret to tests and fix
  insn length
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200608020840_MC3-1-C6D8-A1A6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is_at_popf() needs to test for the iret instruction as well as
popf.  So add that test and rename it to is_setting_trap_flag().

Also change max insn length from 16 to 15 to match reality.

LAHF / SAHF can't affect TF, so the comment in x86_64 is removed.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

Tested on x86_64.

--- 2.6.18-rc3-64.orig/arch/i386/kernel/ptrace.c
+++ 2.6.18-rc3-64/arch/i386/kernel/ptrace.c
@@ -185,17 +185,17 @@ static unsigned long convert_eip_to_line
 	return addr;
 }
 
-static inline int is_at_popf(struct task_struct *child, struct pt_regs *regs)
+static inline int is_setting_trap_flag(struct task_struct *child, struct pt_regs *regs)
 {
 	int i, copied;
-	unsigned char opcode[16];
+	unsigned char opcode[15];
 	unsigned long addr = convert_eip_to_linear(child, regs);
 
 	copied = access_process_vm(child, addr, opcode, sizeof(opcode), 0);
 	for (i = 0; i < copied; i++) {
 		switch (opcode[i]) {
-		/* popf */
-		case 0x9d:
+		/* popf and iret */
+		case 0x9d: case 0xcf:
 			return 1;
 		/* opcode and address size prefixes */
 		case 0x66: case 0x67:
@@ -247,7 +247,7 @@ static void set_singlestep(struct task_s
 	 * don't mark it as being "us" that set it, so that we
 	 * won't clear it by hand later.
 	 */
-	if (is_at_popf(child, regs))
+	if (is_setting_trap_flag(child, regs))
 		return;
 	
 	child->ptrace |= PT_DTRACE;
--- 2.6.18-rc3-64.orig/arch/x86_64/kernel/ptrace.c
+++ 2.6.18-rc3-64/arch/x86_64/kernel/ptrace.c
@@ -116,17 +116,17 @@ unsigned long convert_rip_to_linear(stru
 	return addr;
 }
 
-static int is_at_popf(struct task_struct *child, struct pt_regs *regs)
+static int is_setting_trap_flag(struct task_struct *child, struct pt_regs *regs)
 {
 	int i, copied;
-	unsigned char opcode[16];
+	unsigned char opcode[15];
 	unsigned long addr = convert_rip_to_linear(child, regs);
 
 	copied = access_process_vm(child, addr, opcode, sizeof(opcode), 0);
 	for (i = 0; i < copied; i++) {
 		switch (opcode[i]) {
-		/* popf */
-		case 0x9d:
+		/* popf and iret */
+		case 0x9d: case 0xcf:
 			return 1;
 
 			/* CHECKME: 64 65 */
@@ -189,10 +189,8 @@ static void set_singlestep(struct task_s
 	 * ..but if TF is changed by the instruction we will trace,
 	 * don't mark it as being "us" that set it, so that we
 	 * won't clear it by hand later.
-	 *
-	 * AK: this is not enough, LAHF and IRET can change TF in user space too.
 	 */
-	if (is_at_popf(child, regs))
+	if (is_setting_trap_flag(child, regs))
 		return;
 
 	child->ptrace |= PT_DTRACE;
-- 
Chuck
