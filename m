Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUGGNzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUGGNzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbUGGNzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:55:35 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:1695
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S265007AbUGGNzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 09:55:32 -0400
Date: Wed, 7 Jul 2004 14:55:13 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200407071355.i67DtDF1019243@voidhawk.shadowen.org>
To: akpm@osdl.org, apw@shadowen.org
Subject: Re: [RFC] [PATCH] add TRAP_BAD_SYSCALL_EXITS config for i386
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040702163219.7ec698e2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The TRAP_BAD_SYSCALL stuff is actually a bloa^Wfeature which was added
> via the kgdb patch, so it is not in -bk.
> 
> I've never used it, dunno what it does.  I'll roll your two patches into the
> kgdb patches in -mm, thanks.

This adds code to the syscall return path to check that we are
not returning with preempt_count() != 0.  I think that this is a
pretty useful diagnostics tool.  I think that this part should be
split off and considered for inclusion separatly from the GBD part.
It seems that they intended to cause a breakpoint when this occurs.
The small assembly stub combined with something like the patch
below would stand alone.  I've used it as a diagnotics tool.

I could put together a patch to separate this functionality off
from the GDB patches.  If you agree its worthwhile I am happy to
talk to the GDB people about it.

-apw

=== 8< ===
When we detect that a system call has returned with preempt still disabled
report this situation, including the system call number, return value and
preempt value, as well a dropping a register dump.  In the spirit of other
oops handling attempt to recover from it and continue.

Revision: $Rev: 371 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/kernel/entry.S current/arch/i386/kernel/entry.S
--- reference/arch/i386/kernel/entry.S	2004-07-07 14:34:58.000000000 +0100
+++ current/arch/i386/kernel/entry.S	2004-07-07 14:40:19.000000000 +0100
@@ -317,7 +317,13 @@ restore_all:
 	cmpl $0,TI_preempt_count(%ebp)  # non-zero preempt_count ?
 	jz resume_kernelX
 
-        int $3
+        movl %esp, %ebx			# Record the original register dump
+	movl ORIG_EAX(%esp), %eax	# Recover the return value from syscall
+
+	pushl EAX(%esp)			# Recover the original system call #
+	pushl %eax
+	pushl %ebx
+	call do_bad_syscall_exit
 
 resume_kernelX:
 #endif
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/kernel/traps.c current/arch/i386/kernel/traps.c
--- reference/arch/i386/kernel/traps.c	2004-07-07 14:34:59.000000000 +0100
+++ current/arch/i386/kernel/traps.c	2004-07-07 14:56:37.000000000 +0100
@@ -874,6 +874,20 @@ asmlinkage void do_spurious_interrupt_bu
 #endif
 }
 
+#ifdef CONFIG_TRAP_BAD_SYSCALL_EXITS
+void do_bad_syscall_exit(struct pt_regs *regs, long syscall, long error_code)
+{
+	/*
+	 * Report the preempt count.  Then fix it so we can kill the
+	 * process and continue.  We _may_ get away with it.
+	 */
+	printk("Bad syscall exit - syscall %ld returned %ld preempt %08x\n",
+		syscall, error_code, preempt_count());
+	preempt_count() = 0;
+	die("Bad syscall exit - preempt non-zero", regs, syscall);
+}
+#endif
+
 /*
  *  'math_state_restore()' saves the current math information in the
  * old math state array, and gets the new ones from the current task
