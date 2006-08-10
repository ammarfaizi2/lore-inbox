Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWHJTuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWHJTuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWHJThW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:9873 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932654AbWHJThC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:02 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [103/145] i386/x86-64: rename is_at_popf(), add iret to tests and fix
Message-Id: <20060810193701.439E913C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:01 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Chuck Ebbert <76306.1226@compuserve.com>

is_at_popf() needs to test for the iret instruction as well as
popf.  So add that test and rename it to is_setting_trap_flag().

Also change max insn length from 16 to 15 to match reality.

LAHF / SAHF can't affect TF, so the comment in x86_64 is removed.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---

Tested on x86_64.

---
 arch/i386/kernel/ptrace.c   |   10 +++++-----
 arch/x86_64/kernel/ptrace.c |   12 +++++-------
 2 files changed, 10 insertions(+), 12 deletions(-)

Index: linux/arch/i386/kernel/ptrace.c
===================================================================
--- linux.orig/arch/i386/kernel/ptrace.c
+++ linux/arch/i386/kernel/ptrace.c
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
Index: linux/arch/x86_64/kernel/ptrace.c
===================================================================
--- linux.orig/arch/x86_64/kernel/ptrace.c
+++ linux/arch/x86_64/kernel/ptrace.c
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
