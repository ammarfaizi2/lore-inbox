Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269510AbUIZLM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269510AbUIZLM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 07:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269511AbUIZLM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 07:12:28 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:19351 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269510AbUIZLMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 07:12:23 -0400
Date: Sun, 26 Sep 2004 13:13:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: i386 entry.S problems
Message-ID: <20040926111334.GA17756@elte.hu>
References: <s1543914.047@emea1-mh.id2.novell.com> <1096037828.2612.53.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096037828.2612.53.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjanv@redhat.com> wrote:

> On Fri, 2004-09-24 at 16:12, Jan Beulich wrote:
> > There appear to be two problems in i386's entry.S:
> > 
> > (1) With CONFIG_REGPARM, lcall7 and lcall27 did not work (they pass the
> > parameters to the actual handler procedure on the stack).
> 
> I wonder why we still have the lcall7/lcall27 entry points in the
> kernel; nothing can legitemately use them and in the last few years
> they have only caused a few security issues. Can I ask why you didn't
> just remove this code from the kernel ?

patch below (against BK-curr) zaps the orphaned lcall7/lcall27 code.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/entry.S.orig	
+++ linux/arch/i386/kernel/entry.S	
@@ -140,40 +140,6 @@ VM_MASK		= 0x00020000
 .previous
 
 
-
-ENTRY(lcall7)
-	pushfl			# We get a different stack layout with call
-				# gates, which has to be cleaned up later..
-	pushl %eax
-	SAVE_ALL
-	movl %esp, %ebp
-	pushl %ebp
-	pushl $0x7
-do_lcall:
-	movl EIP(%ebp), %eax	# due to call gates, this is eflags, not eip..
-	movl CS(%ebp), %edx	# this is eip..
-	movl EFLAGS(%ebp), %ecx	# and this is cs..
-	movl %eax,EFLAGS(%ebp)	#
-	movl %edx,EIP(%ebp)	# Now we move them to their "normal" places
-	movl %ecx,CS(%ebp)	#
-	GET_THREAD_INFO_WITH_ESP(%ebp)	# GET_THREAD_INFO
-	movl TI_exec_domain(%ebp), %edx	# Get the execution domain
-	call *EXEC_DOMAIN_handler(%edx)	# Call the handler for the domain
-	addl $4, %esp
-	popl %eax
-	jmp resume_userspace
-
-ENTRY(lcall27)
-	pushfl			# We get a different stack layout with call
-				# gates, which has to be cleaned up later..
-	pushl %eax
-	SAVE_ALL
-	movl %esp, %ebp
-	pushl %ebp
-	pushl $0x27
-	jmp do_lcall
-
-
 ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
--- linux/arch/i386/kernel/traps.c.orig	
+++ linux/arch/i386/kernel/traps.c	
@@ -57,8 +57,6 @@
 #include "mach_traps.h"
 
 asmlinkage int system_call(void);
-asmlinkage void lcall7(void);
-asmlinkage void lcall27(void);
 
 struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
 		{ 0, 0 }, { 0, 0 } };
@@ -1015,11 +1013,6 @@ static void __init set_system_gate(unsig
 	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
 }
 
-static void __init set_call_gate(void *a, void *addr)
-{
-	_set_gate(a,12,3,addr,__KERNEL_CS);
-}
-
 static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
 {
 	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
@@ -1064,13 +1057,6 @@ void __init trap_init(void)
 	set_system_gate(SYSCALL_VECTOR,&system_call);
 
 	/*
-	 * default LDT is a single-entry callgate to lcall7 for iBCS
-	 * and a callgate to lcall27 for Solaris/x86 binaries
-	 */
-	set_call_gate(&default_ldt[0],lcall7);
-	set_call_gate(&default_ldt[4],lcall27);
-
-	/*
 	 * Should be a barrier for any external CPU state.
 	 */
 	cpu_init();
