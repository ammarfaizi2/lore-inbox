Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUI0Hk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUI0Hk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 03:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUI0Hk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 03:40:29 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:7962
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S266183AbUI0HkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 03:40:18 -0400
Message-Id: <s157d1f1.029@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Mon, 27 Sep 2004 09:40:57 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <mingo@elte.hu>, <arjanv@redhat.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: i386 entry.S problems
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to Andi Kleen's statement: Along with removing the remaining
default LDT handling, wouldn't it be reasonable to then also remove the
ill i386-specific code in kernel/exec_domain.c? Jan

>>> Ingo Molnar <mingo@elte.hu> 26.09.04 13:13:34 >>>

* Arjan van de Ven <arjanv@redhat.com> wrote:

> On Fri, 2004-09-24 at 16:12, Jan Beulich wrote:
> > There appear to be two problems in i386's entry.S:
> > 
> > (1) With CONFIG_REGPARM, lcall7 and lcall27 did not work (they pass
the
> > parameters to the actual handler procedure on the stack).
> 
> I wonder why we still have the lcall7/lcall27 entry points in the
> kernel; nothing can legitemately use them and in the last few years
> they have only caused a few security issues. Can I ask why you
didn't
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
-	pushfl			# We get a different stack layout with
call
-				# gates, which has to be cleaned up
later..
-	pushl %eax
-	SAVE_ALL
-	movl %esp, %ebp
-	pushl %ebp
-	pushl $0x7
-do_lcall:
-	movl EIP(%ebp), %eax	# due to call gates, this is eflags, not
eip..
-	movl CS(%ebp), %edx	# this is eip..
-	movl EFLAGS(%ebp), %ecx	# and this is cs..
-	movl %eax,EFLAGS(%ebp)	#
-	movl %edx,EIP(%ebp)	# Now we move them to their "normal"
places
-	movl %ecx,CS(%ebp)	#
-	GET_THREAD_INFO_WITH_ESP(%ebp)	# GET_THREAD_INFO
-	movl TI_exec_domain(%ebp), %edx	# Get the execution domain
-	call *EXEC_DOMAIN_handler(%edx)	# Call the handler for the
domain
-	addl $4, %esp
-	popl %eax
-	jmp resume_userspace
-
-ENTRY(lcall27)
-	pushfl			# We get a different stack layout with
call
-				# gates, which has to be cleaned up
later..
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
 static void __init set_task_gate(unsigned int n, unsigned int
gdt_entry)
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
