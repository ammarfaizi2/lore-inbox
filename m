Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbSLXT2I>; Tue, 24 Dec 2002 14:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbSLXT2I>; Tue, 24 Dec 2002 14:28:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20997 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265777AbSLXT2F>; Tue, 24 Dec 2002 14:28:05 -0500
Date: Tue, 24 Dec 2002 11:36:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212221111080.31068-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212241126020.1219-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, one final optimization.

We have traditionally held ES/DS constant at __KERNEL_DS in the kernel,
and we've used that to avoid saving unnecessary segment registers over
context switches etc.

I realized that there is really no reason to use __KERNEL_DS for this, and
that as far as the kernel is concerned, the only thing that matters is
that it's a flat 32-bit segment. So we might as well make the kernel
always load ES/DS with __USER_DS instead, which has the advantage that we
can avoid one set of segment loads for the "sysenter/sysexit" case.

(We still need to load ES/DS at entry to the kernel, since we cannot rely
on user space not trying to do strange things. But once we load them with
__USER_DS, we at least don't need to restore them on return to user mode
any more, since "sysenter" only works in a flat 32-bit user mode anyway
(*)).

This doesn't matter much for a P4 (surprisingly, a P4 does very well
indeed on segment loads), but it does make a difference on PIII-class
CPU's.

This makes a PIII do a "getpid()" system call in something like 160
cycles (a P4 is at 430 cycles, oh well).

Ingo, would you mind taking a look at the patch, to see if you see any
paths where we don't follow the new segment register rules. It looks like
swsuspend isn't properly saving and restoring segment register contents.
so that will need double-checking (it wasn't correct before either, so
this doesn't make it any worse, at least).

			Linus

(*) We could avoid even that initial load by instead _testing_ that the
values are the correct ones and jumping out if not, but I worry about vm86
mode being able to fool us with segments that have the right selectors but
the wrong segment caches. I disabled sysenter for vm86 mode, but it's so
subtle that I prefer just doing the segment loads rather than doing two
moves and comparisons.

###########################################
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/24	torvalds@home.transmeta.com	1.953
# Make the default values for DS/ES be the _user_ segment descriptors
# on x86 - the kernel doesn't really care (as long as it's all flat 32-bit),
# and it means that the return path for sysenter/sysexit can avoid re-loading
# the segment registers.
#
# NOTE! This means that _all_ kernel code (not just the sysenter path) must
# be appropriately changed, since the kernel knows the conventions and doesn't
# save/restore DS/ES internally on context switches etc.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Tue Dec 24 11:34:28 2002
+++ b/arch/i386/kernel/entry.S	Tue Dec 24 11:34:28 2002
@@ -91,18 +91,21 @@
 	pushl %edx; \
 	pushl %ecx; \
 	pushl %ebx; \
-	movl $(__KERNEL_DS), %edx; \
+	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es;

-#define RESTORE_REGS	\
+#define RESTORE_INT_REGS \
 	popl %ebx;	\
 	popl %ecx;	\
 	popl %edx;	\
 	popl %esi;	\
 	popl %edi;	\
 	popl %ebp;	\
-	popl %eax;	\
+	popl %eax
+
+#define RESTORE_REGS	\
+	RESTORE_INT_REGS; \
 1:	popl %ds;	\
 2:	popl %es;	\
 .section .fixup,"ax";	\
@@ -271,9 +274,9 @@
 	movl TI_FLAGS(%ebx), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
-	RESTORE_REGS
-	movl 4(%esp),%edx
-	movl 16(%esp),%ecx
+	RESTORE_INT_REGS
+	movl 12(%esp),%edx
+	movl 24(%esp),%ecx
 	sti
 	sysexit

@@ -428,7 +431,7 @@
 	movl %esp, %edx
 	pushl %esi			# push the error code
 	pushl %edx			# push the pt_regs pointer
-	movl $(__KERNEL_DS), %edx
+	movl $(__USER_DS), %edx
 	movl %edx, %ds
 	movl %edx, %es
 	call *%edi
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Tue Dec 24 11:34:28 2002
+++ b/arch/i386/kernel/head.S	Tue Dec 24 11:34:28 2002
@@ -235,12 +235,15 @@
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
 1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
-	movl %eax,%ds		# after changing gdt.
+	movl %eax,%ss			# after changing gdt.
+
+	movl $(__USER_DS),%eax		# DS/ES contains default USER segment
+	movl %eax,%ds
 	movl %eax,%es
+
+	xorl %eax,%eax			# Clear FS/GS and LDT
 	movl %eax,%fs
 	movl %eax,%gs
-	movl %eax,%ss
-	xorl %eax,%eax
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
 #ifdef CONFIG_SMP
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Tue Dec 24 11:34:28 2002
+++ b/arch/i386/kernel/process.c	Tue Dec 24 11:34:28 2002
@@ -219,8 +219,8 @@
 	regs.ebx = (unsigned long) fn;
 	regs.edx = (unsigned long) arg;

-	regs.xds = __KERNEL_DS;
-	regs.xes = __KERNEL_DS;
+	regs.xds = __USER_DS;
+	regs.xes = __USER_DS;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
 	regs.xcs = __KERNEL_CS;

