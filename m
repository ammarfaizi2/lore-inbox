Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVAJLfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVAJLfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVAJLfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:35:44 -0500
Received: from ozlabs.org ([203.10.76.45]:26776 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262210AbVAJLfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:35:31 -0500
Date: Mon, 10 Jan 2005 22:34:48 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: ppc64: enhance oops printing
Message-ID: <20050110113447.GP14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some changes to the oops printout, stuff that would have been
useful when I was chasing various bugs.

- print out instructions around the fail (3/4 before 1/4 after).
- print out CTR and CR registers, make some space by cutting down XER
  (its only 32bit)
- always print the DAR and DSISR, its sometimes useful
- print_modules() like x86

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/process.c~oopsprint arch/ppc64/kernel/process.c
--- foobar2/arch/ppc64/kernel/process.c~oopsprint	2005-01-10 20:46:05.161421578 +1100
+++ foobar2-anton/arch/ppc64/kernel/process.c	2005-01-10 22:22:22.863518165 +1100
@@ -214,23 +214,57 @@ struct task_struct *__switch_to(struct t
 	return last;
 }
 
+static int instructions_to_print = 16;
+
+static void show_instructions(struct pt_regs *regs)
+{
+	int i;
+	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
+			sizeof(int));
+
+	printk("Instruction dump:");
+
+	for (i = 0; i < instructions_to_print; i++) {
+		int instr;
+
+		if (!(i % 8))
+			printk("\n");
+
+		if (((REGION_ID(pc) != KERNEL_REGION_ID) &&
+		     (REGION_ID(pc) != VMALLOC_REGION_ID)) ||
+		     __get_user(instr, (unsigned int *)pc)) {
+			printk("XXXXXXXX ");
+		} else {
+			if (regs->nip == pc)
+				printk("<%08x> ", instr);
+			else
+				printk("%08x ", instr);
+		}
+
+		pc += sizeof(int);
+	}
+
+	printk("\n");
+}
+
 void show_regs(struct pt_regs * regs)
 {
 	int i;
 	unsigned long trap;
 
-	printk("NIP: %016lX XER: %016lX LR: %016lX\n",
-	       regs->nip, regs->xer, regs->link);
+	printk("NIP: %016lX XER: %08X LR: %016lX CTR: %016lX\n",
+	       regs->nip, (unsigned int)regs->xer, regs->link, regs->ctr);
 	printk("REGS: %p TRAP: %04lx   %s  (%s)\n",
 	       regs, regs->trap, print_tainted(), UTS_RELEASE);
-	printk("MSR: %016lx EE: %01x PR: %01x FP: %01x ME: %01x IR/DR: %01x%01x\n",
+	printk("MSR: %016lx EE: %01x PR: %01x FP: %01x ME: %01x "
+	       "IR/DR: %01x%01x CR: %08X\n",
 	       regs->msr, regs->msr&MSR_EE ? 1 : 0, regs->msr&MSR_PR ? 1 : 0,
 	       regs->msr & MSR_FP ? 1 : 0,regs->msr&MSR_ME ? 1 : 0,
 	       regs->msr&MSR_IR ? 1 : 0,
-	       regs->msr&MSR_DR ? 1 : 0);
+	       regs->msr&MSR_DR ? 1 : 0,
+	       (unsigned int)regs->ccr);
 	trap = TRAP(regs);
-	if (trap == 0x300 || trap == 0x380 || trap == 0x600)
-		printk("DAR: %016lx, DSISR: %016lx\n", regs->dar, regs->dsisr);
+	printk("DAR: %016lx DSISR: %016lx\n", regs->dar, regs->dsisr);
 	printk("TASK: %p[%d] '%s' THREAD: %p",
 	       current, current->pid, current->comm, current->thread_info);
 
@@ -257,6 +291,8 @@ void show_regs(struct pt_regs * regs)
 	printk("LR [%016lx] ", regs->link);
 	print_symbol("%s\n", regs->link);
 	show_stack(current, (unsigned long *)regs->gpr[1]);
+	if (!user_mode(regs))
+		show_instructions(regs);
 }
 
 void exit_thread(void)
diff -puN arch/ppc64/kernel/traps.c~oopsprint arch/ppc64/kernel/traps.c
--- foobar2/arch/ppc64/kernel/traps.c~oopsprint	2005-01-10 20:46:05.166421199 +1100
+++ foobar2-anton/arch/ppc64/kernel/traps.c	2005-01-10 22:22:26.850871990 +1100
@@ -127,6 +127,7 @@ int die(const char *str, struct pt_regs 
 	}
 	if (nl)
 		printk("\n");
+	print_modules();
 	show_regs(regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
_
