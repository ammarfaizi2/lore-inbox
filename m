Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUCLCsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUCLCsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:48:08 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:11900 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261918AbUCLCr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:47:58 -0500
Message-ID: <405124DD.3020509@blueyonder.co.uk>
Date: Fri, 12 Mar 2004 02:47:57 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 entry.S errors x86_64
References: <1yJYn-3Hl-21@gated-at.bofh.it> <m3oequff53.fsf@averell.firstfloor.org>
In-Reply-To: <m3oequff53.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2004 02:47:57.0381 (UTC) FILETIME=[6CDC8F50:01C407DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Sid Boyce <sboyce@blueyonder.co.uk> writes:
>  
>
>>previous .cfi_startproc
>>arch/x86_64/kernel/entry.S:873: Error: no such instruction: `r8,3*8-(9*8+0)'
>>arch/x86_64/kernel/entry.S:873: Error: CFI instruction used without
>>previous .cfi_startproc
>>etc.
>>    
>>
>
>This patch should fix it. It has a few unrelated changes, but 
>I'm too lazy to untangle them now.
>
>Or alternatively disable CONFIG_DEBUG_INFO
>
>-Andi
>
>Clean up stack switching handling for IST exceptions.
>
>Pass right pt_regs to die_chain functions.
>
>Add missing cfi mnemonics to fix CONFIG_DEBUG_INFO compilation.
>
>diff -X ../KDIFX -burpN linux-2.6.4-x86_64-1/arch/x86_64/kernel/entry.S linux-2.6.4-amd64/arch/x86_64/kernel/entry.S
>--- linux-2.6.4-x86_64-1/arch/x86_64/kernel/entry.S	2004-03-18 14:32:08.000000000 +0100
>+++ linux-2.6.4-amd64/arch/x86_64/kernel/entry.S	2004-03-18 14:27:29.000000000 +0100
>@@ -803,9 +803,6 @@ ENTRY(debug)
> 	pushq $0
> 	CFI_ADJUST_CFA_OFFSET 8		
> 	paranoidentry do_debug
>-paranoid_stack_switch:	
>-	testq %rax,%rax
>-	jz paranoid_exit
> 	/* switch back to process stack to restore the state ptrace touched */
> 	movq %rax,%rsp	
> 	jmp paranoid_exit
>@@ -870,8 +867,11 @@ ENTRY(reserved)
> 
> 	/* runs on exception stack */
> ENTRY(double_fault)
>+	CFI_STARTPROC
> 	paranoidentry do_double_fault
>-	jmp paranoid_stack_switch
>+	movq %rax,%rsp
>+	jmp paranoid_exit
>+	CFI_ENDPROC
> 
> ENTRY(invalid_TSS)
> 	errorentry do_invalid_TSS
>@@ -881,8 +881,11 @@ ENTRY(segment_not_present)
> 
> 	/* runs on exception stack */
> ENTRY(stack_segment)
>+	CFI_STARTPROC
> 	paranoidentry do_stack_segment
>-	jmp paranoid_stack_switch
>+	movq %rax,%rsp
>+	jmp paranoid_exit
>+	CFI_ENDPROC
> 
> ENTRY(general_protection)
> 	errorentry do_general_protection
>diff -X ../KDIFX -burpN linux-2.6.4-x86_64-1/arch/x86_64/kernel/traps.c linux-2.6.4-amd64/arch/x86_64/kernel/traps.c
>--- linux-2.6.4-x86_64-1/arch/x86_64/kernel/traps.c	2004-03-18 14:32:08.000000000 +0100
>+++ linux-2.6.4-amd64/arch/x86_64/kernel/traps.c	2004-03-18 01:00:40.000000000 +0100
>@@ -477,15 +477,17 @@ DO_ERROR_INFO(17, SIGBUS, "alignment che
> DO_ERROR(18, SIGSEGV, "reserved", reserved)
> 
> #define DO_ERROR_STACK(trapnr, signr, str, name) \
>-asmlinkage unsigned long do_##name(struct pt_regs * regs, long error_code) \
>+asmlinkage void *do_##name(struct pt_regs * regs, long error_code) \
> { \
> 	struct pt_regs *pr = ((struct pt_regs *)(current->thread.rsp0))-1; \
> 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_BAD) \
>-		return 0; \
>-	if (regs->cs & 3) \
>+		return regs; \
>+	if (regs->cs & 3) { \
> 		memcpy(pr, regs, sizeof(struct pt_regs)); \
>+		regs = pr; \
>+	} \
> 	do_trap(trapnr, signr, str, regs, error_code, NULL); \
>-	return (regs->cs & 3) ? (unsigned long)pr : 0;		\
>+	return regs;		\
> }
> 
> DO_ERROR_STACK(12, SIGBUS,  "stack segment", stack_segment)
>@@ -605,16 +607,18 @@ asmlinkage void default_do_nmi(struct pt
> }
> 
> /* runs on IST stack. */
>-asmlinkage unsigned long do_debug(struct pt_regs * regs, unsigned long error_code)
>+asmlinkage void *do_debug(struct pt_regs * regs, unsigned long error_code)
> {
>-	struct pt_regs *processregs;
>+	struct pt_regs *pr;
> 	unsigned long condition;
> 	struct task_struct *tsk = current;
> 	siginfo_t info;
> 
>-	processregs = (struct pt_regs *)(current->thread.rsp0)-1;
>-	if (regs->cs & 3)
>-		memcpy(processregs, regs, sizeof(struct pt_regs));
>+	pr = (struct pt_regs *)(current->thread.rsp0)-1;
>+	if (regs->cs & 3) {
>+		memcpy(pr, regs, sizeof(struct pt_regs));
>+		regs = pr;
>+	}	
> 
> #ifdef CONFIG_CHECKING
>        { 
>@@ -673,8 +677,7 @@ asmlinkage unsigned long do_debug(struct
> clear_dr7:
> 	asm volatile("movq %0,%%db7"::"r"(0UL));
> 	notify_die(DIE_DEBUG, "debug", regs, condition, 1, SIGTRAP);
>-out:
>-	return (regs->cs & 3) ? (unsigned long)processregs : 0;
>+	return regs;
> 
> clear_TF_reenable:
> 	printk("clear_tf_reenable\n");
>@@ -685,8 +688,7 @@ clear_TF:
> 	if (notify_die(DIE_DEBUG, "debug2", regs, condition, 1, SIGTRAP) 
> 	    != NOTIFY_BAD)
> 	regs->eflags &= ~TF_MASK;
>-	
>-	goto out;
>+	return regs;	
> }
> 
> /*
>
>
>  
>
Thanks, I shall give it a try.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

