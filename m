Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVGWHOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVGWHOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 03:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVGWHOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 03:14:24 -0400
Received: from siaag2ag.compuserve.com ([149.174.40.140]:13530 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S261552AbVGWHOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 03:14:04 -0400
Date: Sat, 23 Jul 2005 03:09:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>
Message-ID: <200507230313_MC3-1-A554-6927@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005 at 13:27:56 +1000, Andrew Morton wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:

> > After:
> > 
> >  12534 math_state_restore                       130.5625
> >   8354 device_not_available                     203.7561
> >  -----
> >  20888

> > Next step should be to physically place math_state_restore() after
> > device_not_available().  Would such a patch be accepted?  (Yes it
> > would be ugly and require linker script changes.)
>
> Depends on the benefit/ugly ratio ;)

This patch (may not apply cleanly to unpatched -rc3) drops overhead
a few more percent:

 11835 math_state_restore                       144.3293
  8096 device_not_available                     197.4634
 -----
 19931

Most of the exception/interrupt handlers should get the same treatment but
the linker script would grow.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Index: 2.6.13-rc3a/arch/i386/kernel/entry.S
===================================================================
--- 2.6.13-rc3a.orig/arch/i386/kernel/entry.S	2005-07-16 18:09:48.000000000 -0400
+++ 2.6.13-rc3a/arch/i386/kernel/entry.S	2005-07-22 05:19:22.000000000 -0400
@@ -469,6 +469,7 @@
 	pushl $do_simd_coprocessor_error
 	jmp error_code
 
+	.section ".text.i387_1", "a"
 ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
@@ -484,6 +485,8 @@
 	addl $4, %esp
 	jmp ret_from_exception
 
+	.previous
+
 /*
  * Debug traps and NMI can happen at the one SYSENTER instruction
  * that sets up the real kernel stack. Check here, since we can't
Index: 2.6.13-rc3a/arch/i386/kernel/traps.c
===================================================================
--- 2.6.13-rc3a.orig/arch/i386/kernel/traps.c	2005-07-16 18:05:40.000000000 -0400
+++ 2.6.13-rc3a/arch/i386/kernel/traps.c	2005-07-22 14:02:50.000000000 -0400
@@ -972,7 +972,8 @@
  * Must be called with kernel preemption disabled (in this case,
  * local interrupts are disabled at the call-site in entry.S).
  */
-asmlinkage void math_state_restore(struct pt_regs regs)
+asmlinkage void __attribute__((__section__(".text.i387_2")))
+math_state_restore(struct pt_regs regs)
 {
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = thread->task;
Index: 2.6.13-rc3a/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- 2.6.13-rc3a.orig/arch/i386/kernel/vmlinux.lds.S	2005-07-16 18:05:39.000000000 -0400
+++ 2.6.13-rc3a/arch/i386/kernel/vmlinux.lds.S	2005-07-22 05:20:30.000000000 -0400
@@ -20,6 +20,8 @@
   _text = .;			/* Text and read-only data */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
 	*(.text)
+	*(.text.i387_1)
+	*(.text.i387_2)
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
__
Chuck
