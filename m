Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSHGB6S>; Tue, 6 Aug 2002 21:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSHGB6O>; Tue, 6 Aug 2002 21:58:14 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:4005 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S316951AbSHGB5e>;
	Tue, 6 Aug 2002 21:57:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: vamsi@in.ibm.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30 
In-reply-to: Your message of "Tue, 06 Aug 2002 16:42:42 +0530."
             <20020806164242.B22164@in.ibm.com> 
Date: Wed, 07 Aug 2002 10:55:04 +1000
Message-Id: <20020807020259.70602418A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020806164242.B22164@in.ibm.com> you write:
> - move trap1 and trap3 interrupt gates only under CONFIG_KPROBES. Please
>   note that if we don't do this, we need to call restore_interrupts()
>   from the dummy (post_)kprobe_handler() in include/asm-i386/kprobes.h
>   when CONFIG_KPROBES is off. I didn't like this subtle side effect. hence
>   the #ifdef CONFIG_KPROBES around _set_trap_gate. Still, the calling 
>   conventions of do_debug and do_int3 remain independent of CONFIG_KPROBES.

Hmm, I thought about this but then decided against it.  Your way is
pretty subtle too: I think I prefer the restore_interrupts()
explicitly after the (failed) call to kprobe_handler, ie (on top of
your patch, which looks excellent):

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-kprobes-vamsi/arch/i386/kernel/traps.c working-2.5.30-kprobes/arch/i386/kernel/traps.c
--- working-2.5.30-kprobes-vamsi/arch/i386/kernel/traps.c	2002-08-07 10:45:26.000000000 +1000
+++ working-2.5.30-kprobes/arch/i386/kernel/traps.c	2002-08-07 10:51:28.000000000 +1000
@@ -517,6 +517,9 @@ asmlinkage int do_int3(struct pt_regs *r
 {
 	if (kprobe_handler(regs))
 		return 1;
+	/* This is an interrupt gate, because kprobes wants interrupts
+           disabled.  Normal trap handlers don't. */
+	restore_interrupts(regs);
 	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
 	return 0;
 }
@@ -554,6 +557,9 @@ asmlinkage int do_debug(struct pt_regs *
 	if (post_kprobe_handler(regs))
 		return 1;
 
+	/* Interrupts not disabled for normal trap handling. */
+	restore_interrupts(regs);
+
 	/* Mask out spurious debug traps due to lazy DR7 setting */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
 		if (!tsk->thread.debugreg[7])
@@ -961,14 +967,9 @@ void __init trap_init(void)
 #endif
 
 	set_trap_gate(0,&divide_error);
+	_set_gate(idt_table+1,14,3,&debug); /* debug trap for kprobes */
 	set_intr_gate(2,&nmi);
-#ifdef CONFIG_KPROBES
-	_set_gate(idt_table+1,14,3,&debug);
-	_set_gate(idt_table+3,14,3,&int3);
-#else
- 	set_trap_gate(1,&debug);
- 	set_system_gate(3,&int3);	/* int3-5 can be called from all */
-#endif
+	_set_gate(idt_table+3,14,3,&int3); /* int3-5 can be called from all */
 	set_system_gate(4,&overflow);
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-kprobes-vamsi/arch/i386/kernel/kprobes.c working-2.5.30-kprobes/arch/i386/kernel/kprobes.c
--- working-2.5.30-kprobes-vamsi/arch/i386/kernel/kprobes.c	2002-08-07 10:45:25.000000000 +1000
+++ working-2.5.30-kprobes/arch/i386/kernel/kprobes.c	2002-08-07 10:52:15.000000000 +1000
@@ -102,7 +102,6 @@ int kprobe_handler(struct pt_regs *regs)
 
 no_kprobe:
 	preempt_enable_no_resched();
-	restore_interrupts(regs);
 	return ret;
 }
 
@@ -119,7 +118,7 @@ static void rearm_kprobe(struct kprobe *
 int post_kprobe_handler(struct pt_regs *regs)
 {
 	if (!kprobe_running())
-		goto no_kprobe;
+		return 0;
 
 	if (current_kprobe->post_handler)
 		current_kprobe->post_handler(current_kprobe, regs, 0);
@@ -145,13 +144,9 @@ int post_kprobe_handler(struct pt_regs *
 	 * of do_debug, as if this is not a probe hit.
 	 */
 	if (regs->eflags & TF_MASK)
-		goto no_kprobe;
+		return 0;
 
 	return 1;
-
-no_kprobe:
-	restore_interrupts(regs);
-	return 0;
 }
 
 /* Interrupts disabled, kprobe_lock held. */
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
