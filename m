Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVDLTsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVDLTsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVDLTqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:46:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:64456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262178AbVDLKcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:02 -0400
Message-Id: <200504121031.j3CAVqq5005431@shell0.pdx.osdl.net>
Subject: [patch 076/198] x86_64: Handle programs that set TF in user space using popf while single stepping
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Ported from i386/Linus

Still won't handle other TF changing instructions like IRET or LAHF.

Prefix handling must be double checked...

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/ptrace.c |   88 ++++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+)

diff -puN arch/x86_64/kernel/ptrace.c~x86_64-handle-programs-that-set-tf-in-user-space-using arch/x86_64/kernel/ptrace.c
--- 25/arch/x86_64/kernel/ptrace.c~x86_64-handle-programs-that-set-tf-in-user-space-using	2005-04-12 03:21:21.572857328 -0700
+++ 25-akpm/arch/x86_64/kernel/ptrace.c	2005-04-12 03:21:21.576856720 -0700
@@ -86,6 +86,84 @@ static inline long put_stack_long(struct
 	return 0;
 }
 
+#define LDT_SEGMENT 4
+
+unsigned long convert_rip_to_linear(struct task_struct *child, struct pt_regs *regs)
+{
+	unsigned long addr, seg;
+
+	addr = regs->rip;
+	seg = regs->cs & 0xffff;
+
+	/*
+	 * We'll assume that the code segments in the GDT
+	 * are all zero-based. That is largely true: the
+	 * TLS segments are used for data, and the PNPBIOS
+	 * and APM bios ones we just ignore here.
+	 */
+	if (seg & LDT_SEGMENT) {
+		u32 *desc;
+		unsigned long base;
+
+		down(&child->mm->context.sem);
+		desc = child->mm->context.ldt + (seg & ~7);
+		base = (desc[0] >> 16) | ((desc[1] & 0xff) << 16) | (desc[1] & 0xff000000);
+
+		/* 16-bit code segment? */
+		if (!((desc[1] >> 22) & 1))
+			addr &= 0xffff;
+		addr += base;
+		up(&child->mm->context.sem);
+	}
+	return addr;
+}
+
+static int is_at_popf(struct task_struct *child, struct pt_regs *regs)
+{
+	int i, copied;
+	unsigned char opcode[16];
+	unsigned long addr = convert_rip_to_linear(child, regs);
+
+	copied = access_process_vm(child, addr, opcode, sizeof(opcode), 0);
+	for (i = 0; i < copied; i++) {
+		switch (opcode[i]) {
+		/* popf */
+		case 0x9d:
+			return 1;
+
+			/* CHECKME: 64 65 */
+
+		/* opcode and address size prefixes */
+		case 0x66: case 0x67:
+			continue;
+		/* irrelevant prefixes (segment overrides and repeats) */
+		case 0x26: case 0x2e:
+		case 0x36: case 0x3e:
+		case 0x64: case 0x65:
+		case 0xf0: case 0xf2: case 0xf3:
+			continue;
+
+		/* REX prefixes */
+		case 0x40 ... 0x4f:
+			continue;
+
+			/* CHECKME: f0, f2, f3 */
+
+		/*
+		 * pushf: NOTE! We should probably not let
+		 * the user see the TF bit being set. But
+		 * it's more pain than it's worth to avoid
+		 * it, and a debugger could emulate this
+		 * all in user space if it _really_ cares.
+		 */
+		case 0x9c:
+		default:
+			return 0;
+		}
+	}
+	return 0;
+}
+
 static void set_singlestep(struct task_struct *child)
 {
 	struct pt_regs *regs = get_child_regs(child);
@@ -106,6 +184,16 @@ static void set_singlestep(struct task_s
 	/* Set TF on the kernel stack.. */
 	regs->eflags |= TRAP_FLAG;
 
+	/*
+	 * ..but if TF is changed by the instruction we will trace,
+	 * don't mark it as being "us" that set it, so that we
+	 * won't clear it by hand later.
+	 *
+	 * AK: this is not enough, LAHF and IRET can change TF in user space too.
+	 */
+	if (is_at_popf(child, regs))
+		return;
+
 	child->ptrace |= PT_DTRACE;
 }
 
_
