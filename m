Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317808AbSGVVPI>; Mon, 22 Jul 2002 17:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSGVVPI>; Mon, 22 Jul 2002 17:15:08 -0400
Received: from www.sgg.ru ([217.23.135.2]:10259 "EHLO mail.sgg.ru")
	by vger.kernel.org with ESMTP id <S317808AbSGVVPG>;
	Mon, 22 Jul 2002 17:15:06 -0400
Message-ID: <3D3C76F0.307C6C3@tv-sign.ru>
Date: Tue, 23 Jul 2002 01:19:44 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, george anzinger <george@mvista.com>
Subject: Re: [patch] big IRQ lock removal, 2.5.27-D9
References: <Pine.LNX.4.44.0207221650140.11103-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

George Anzinger wrote:
>
> > then preempt_stop (cli) can be killed in entry.S:ret_from_intr()
>
> Also at least some of the trap code returns with interrupts enabled.

Then linux already have a bug - ret_from_exception: bypasses
ret_from_intr:. But as far as i can see, it does not - all users of
ret_from_exception: do preempt_stop. And so it can be shifted to
ret_from_exception.

I beleive none of the traps need current_thread_info() in regs->ebx,
so GET_THREAD_INFO(%ebx) can be killed in error_code:,
common_interrupt:,
and BUILD_INTERRUPT().

Not sure it is right time to such minor cleanups, but...
Patch on top of remove-irqlock-2.5.27-E0:

--- arch/i386/kernel/entry.S.orig	Mon Jul 22 23:44:41 2002
+++ arch/i386/kernel/entry.S	Tue Jul 23 00:04:02 2002
@@ -185,8 +185,10 @@
 
 	# userspace resumption stub bypassing syscall exit tracing
 	ALIGN
-ret_from_intr:
 ret_from_exception:
+	preempt_stop
+ret_from_intr:
+	GET_THREAD_INFO(%ebx)
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	testl $(VM_MASK | 3), %eax
@@ -333,14 +335,12 @@
 common_interrupt:
 	SAVE_ALL
 	call do_IRQ
-	GET_THREAD_INFO(%ebx)
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
-	GET_THREAD_INFO(%ebx);		\
 	call smp_/**/name;	\
 	jmp ret_from_intr;
 
@@ -400,10 +400,8 @@
 	movl $(__KERNEL_DS), %edx
 	movl %edx, %ds
 	movl %edx, %es
-	GET_THREAD_INFO(%ebx)
 	call *%edi
 	addl $8, %esp
-	preempt_stop
 	jmp ret_from_exception
 
 ENTRY(coprocessor_error)
@@ -430,7 +428,6 @@
 	pushl $0			# temporary storage for ORIG_EIP
 	call math_emulate
 	addl $4, %esp
-	preempt_stop
 	jmp ret_from_exception
 
 ENTRY(debug)

Oleg.
