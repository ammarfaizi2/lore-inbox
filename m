Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbTAJLXT>; Fri, 10 Jan 2003 06:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbTAJLXT>; Fri, 10 Jan 2003 06:23:19 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:26802 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S264885AbTAJLXS>;
	Fri, 10 Jan 2003 06:23:18 -0500
Date: Fri, 10 Jan 2003 12:30:58 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <davej@codemonkey.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212241126020.1219-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0301101202020.1743-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Tue, 24 Dec 2002, Linus Torvalds wrote:

[That's old, I know. I'm slowly catching up on my email backlog after
almost 3 weeks away]

>
> Ok, one final optimization.
>
> We have traditionally held ES/DS constant at __KERNEL_DS in the kernel,
> and we've used that to avoid saving unnecessary segment registers over
> context switches etc.
>
> I realized that there is really no reason to use __KERNEL_DS for this, and
> that as far as the kernel is concerned, the only thing that matters is
> that it's a flat 32-bit segment. So we might as well make the kernel
> always load ES/DS with __USER_DS instead, which has the advantage that we
> can avoid one set of segment loads for the "sysenter/sysexit" case.
>
> (We still need to load ES/DS at entry to the kernel, since we cannot rely
> on user space not trying to do strange things. But once we load them with
> __USER_DS, we at least don't need to restore them on return to user mode
> any more, since "sysenter" only works in a flat 32-bit user mode anyway
> (*)).

We cannot rely either on userspace not setting NT bit in eflags. While
it won't cause an oops since the only instruction which ever depends on
it, iret, has a handler (which needs to be patched, see below),
I'm absolutely not convinced that all code paths are "NT safe" ;-)

For example, set NT and then execute sysenter with garbage in %eax, the
kernel will try to return (-ENOSYS) with iret and kill the task. As long
as it only allows a task to kill itself, it's not a big deal. But NT is
not cleared across task switches unless I miss something, and that looks
very dangerous.

It's so complex that I'm not sure that clearing NT in __switch_to is
sufficient, but clearing it in every sysenter path will make clock cycles
accountants scream (the only way is through popfl).

>
> This doesn't matter much for a P4 (surprisingly, a P4 does very well
> indeed on segment loads), but it does make a difference on PIII-class
> CPU's.
>
> This makes a PIII do a "getpid()" system call in something like 160
> cycles (a P4 is at 430 cycles, oh well).
>
> Ingo, would you mind taking a look at the patch, to see if you see any
> paths where we don't follow the new segment register rules. It looks like
> swsuspend isn't properly saving and restoring segment register contents.
> so that will need double-checking (it wasn't correct before either, so
> this doesn't make it any worse, at least).

I'm no Ingo, unfortunately, but you'll need at least the following patch
(the second hunk is only a typo fix) to the iret exception recovery code,
which used push and pops to get the smallest possible code size.

That's a minimal patch, let me know if you prefer to have a single copy of
the exception handler for all instances of RESTORE_ALL.

===== entry.S 1.49 vs edited =====
--- 1.49/arch/i386/kernel/entry.S	Sat Jan  4 19:06:07 2003
+++ edited/entry.S	Fri Jan 10 02:12:00 2003
@@ -126,10 +126,9 @@
 	addl $4, %esp;	\
 1:	iret;		\
 .section .fixup,"ax";   \
-2:	pushl %ss;	\
-	popl %ds;	\
-	pushl %ss;	\
-	popl %es;	\
+2:	movl $(__USER_DS), %edx; \
+	movl %edx, %ds; \
+	movl %edx, %es; \
 	pushl $11;	\
 	call do_exit;	\
 .previous;		\
@@ -225,7 +224,7 @@
 	movl TI_FLAGS(%ebx), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
-	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (execption path) ?
+	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 	jz restore_all
 	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebx)
 	sti


	Regards,
	Gabriel.

