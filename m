Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWH0J04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWH0J04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWH0JZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:25:50 -0400
Received: from 32.sub-70-198-1.myvzw.com ([70.198.1.32]:53698 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751362AbWH0JZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:25:35 -0400
Message-Id: <20060827084452.151407233@goop.org>
References: <20060827084417.918992193@goop.org>
User-Agent: quilt/0.45-1
Date: Sun, 27 Aug 2006 01:44:21 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH RFC 4/6] Fix places where using %gs changes the usermode ABI.
Content-Disposition: inline; filename=i386-pda-fix-abi.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few places where the change in struct pt_regs and the use
of %gs affect the userspace ABI.  These are primarily debugging
interfaces where thread state can be inspected or extracted.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/process.c |    6 +++---
 arch/i386/kernel/ptrace.c  |    8 +-------
 include/asm-i386/elf.h     |    2 +-
 include/asm-i386/unwind.h  |    1 +
 4 files changed, 6 insertions(+), 11 deletions(-)


===================================================================
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -305,8 +305,8 @@ void show_regs(struct pt_regs * regs)
 		regs->eax,regs->ebx,regs->ecx,regs->edx);
 	printk("ESI: %08lx EDI: %08lx EBP: %08lx",
 		regs->esi, regs->edi, regs->ebp);
-	printk(" DS: %04x ES: %04x\n",
-		0xffff & regs->xds,0xffff & regs->xes);
+	printk(" DS: %04x ES: %04x GS: %04x\n",
+	       0xffff & regs->xds,0xffff & regs->xes, 0xffff & regs->xgs);
 
 	cr0 = read_cr0();
 	cr2 = read_cr2();
@@ -500,7 +500,7 @@ void dump_thread(struct pt_regs * regs, 
 	dump->regs.ds = regs->xds;
 	dump->regs.es = regs->xes;
 	savesegment(fs,dump->regs.fs);
-	savesegment(gs,dump->regs.gs);
+	dump->regs.gs = regs->xgs;
 	dump->regs.orig_eax = regs->orig_eax;
 	dump->regs.eip = regs->eip;
 	dump->regs.cs = regs->xcs;
===================================================================
--- a/arch/i386/kernel/ptrace.c
+++ b/arch/i386/kernel/ptrace.c
@@ -94,13 +94,9 @@ static int putreg(struct task_struct *ch
 				return -EIO;
 			child->thread.fs = value;
 			return 0;
-		case GS:
-			if (value && (value & 3) != 3)
-				return -EIO;
-			child->thread.gs = value;
-			return 0;
 		case DS:
 		case ES:
+		case GS:
 			if (value && (value & 3) != 3)
 				return -EIO;
 			value &= 0xffff;
@@ -132,8 +128,6 @@ static unsigned long getreg(struct task_
 			retval = child->thread.fs;
 			break;
 		case GS:
-			retval = child->thread.gs;
-			break;
 		case DS:
 		case ES:
 		case SS:
===================================================================
--- a/include/asm-i386/elf.h
+++ b/include/asm-i386/elf.h
@@ -88,7 +88,7 @@ typedef struct user_fxsr_struct elf_fpxr
 	pr_reg[7] = regs->xds;				\
 	pr_reg[8] = regs->xes;				\
 	savesegment(fs,pr_reg[9]);			\
-	savesegment(gs,pr_reg[10]);			\
+	pr_reg[10] = regs->xgs;				\
 	pr_reg[11] = regs->orig_eax;			\
 	pr_reg[12] = regs->eip;				\
 	pr_reg[13] = regs->xcs;				\
===================================================================
--- a/include/asm-i386/unwind.h
+++ b/include/asm-i386/unwind.h
@@ -64,6 +64,7 @@ static inline void arch_unw_init_blocked
 	info->regs.xss = __KERNEL_DS;
 	info->regs.xds = __USER_DS;
 	info->regs.xes = __USER_DS;
+	info->regs.xgs = __KERNEL_PDA;
 }
 
 extern asmlinkage int arch_unwind_init_running(struct unwind_frame_info *,

--

