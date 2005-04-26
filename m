Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVDZLek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVDZLek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVDZLek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:34:40 -0400
Received: from hades.snarc.org ([212.85.152.11]:17925 "EHLO hades.snarc.org")
	by vger.kernel.org with ESMTP id S261450AbVDZLdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:33:40 -0400
Date: Tue, 26 Apr 2005 13:33:38 +0200
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: ian.pratt@cl.cam.ac.uk, akpm@osdl.org, ak@suse.de
Subject: [PATCH 6/6][XEN][x86_64] use more usermode macro
Message-ID: <20050426113338.GF26614@snarc.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ian.pratt@cl.cam.ac.uk, akpm@osdl.org, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch make use of the user_mode macro where it's possible.
This is useful for Xen because it will need only to redefine only the macro
to a hypervisor call. 

Please apply, or comments.

	Signed-off-by: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>

diff -Naur linux-2.6.12-rc3/arch/x86_64/kernel/signal.c linux-2.6.12-rc3.1/arch/x86_64/kernel/signal.c
--- linux-2.6.12-rc3/arch/x86_64/kernel/signal.c	2005-04-25 11:51:30.273601998 +0100
+++ linux-2.6.12-rc3.1/arch/x86_64/kernel/signal.c	2005-04-25 14:19:05.483124219 +0100
@@ -416,7 +416,7 @@
 	 * kernel mode. Just return without doing anything
 	 * if so.
 	 */
-	if ((regs->cs & 3) != 3)
+	if (!user_mode(regs))
 		return 1;
 
 	if (try_to_freeze(0))
diff -Naur linux-2.6.12-rc3/arch/x86_64/kernel/traps.c linux-2.6.12-rc3.1/arch/x86_64/kernel/traps.c
--- linux-2.6.12-rc3/arch/x86_64/kernel/traps.c	2005-04-25 11:51:30.276601300 +0100
+++ linux-2.6.12-rc3.1/arch/x86_64/kernel/traps.c	2005-04-25 12:01:25.285166226 +0100
@@ -274,7 +274,7 @@
 void show_registers(struct pt_regs *regs)
 {
 	int i;
-	int in_kernel = (regs->cs & 3) == 0;
+	int in_kernel = !user_mode(regs);
 	unsigned long rsp;
 	const int cpu = safe_smp_processor_id(); 
 	struct task_struct *cur = cpu_pda[cpu].pcurrent; 
@@ -318,7 +318,7 @@
 	struct bug_frame f;
 	char tmp;
 
-	if (regs->cs & 3)
+	if (user_mode(regs))
 		return; 
 	if (__copy_from_user(&f, (struct bug_frame *) regs->rip, 
 			     sizeof(struct bug_frame)))
@@ -435,7 +435,7 @@
        }
 #endif
 
-	if ((regs->cs & 3)  != 0) { 
+	if (user_mode(regs)) { 
 		struct task_struct *tsk = current;
 
 		if (exception_trace && unhandled_signal(tsk, signr))
@@ -520,7 +520,7 @@
        }
 #endif
 
-	if ((regs->cs & 3)!=0) { 
+	if (user_mode(regs)) { 
 		struct task_struct *tsk = current;
 
 		if (exception_trace && unhandled_signal(tsk, SIGSEGV))
@@ -636,7 +636,7 @@
 	if (eregs == (struct pt_regs *)eregs->rsp)
 		;
 	/* Exception from user space */
-	else if (eregs->cs & 3)
+	else if (user_mode(eregs))
 		regs = ((struct pt_regs *)current->thread.rsp0) - 1;
 	/* Exception from kernel and interrupts are enabled. Move to
  	   kernel process stack. */
@@ -695,7 +695,7 @@
 		 * allowing programs to debug themselves without the ptrace()
 		 * interface.
 		 */
-                if ((regs->cs & 3) == 0)
+                if (!user_mode(regs))
                        goto clear_TF_reenable;
 		/*
 		 * Was the TF flag set by a debugger? If so, clear it now,
@@ -713,7 +713,7 @@
 	info.si_signo = SIGTRAP;
 	info.si_errno = 0;
 	info.si_code = TRAP_BRKPT;
-	if ((regs->cs & 3) == 0) 
+	if (!user_mode(regs)) 
 		goto clear_dr7; 
 
 	info.si_addr = (void __user *)regs->rip;
@@ -754,7 +754,7 @@
 	unsigned short cwd, swd;
 
 	conditional_sti(regs);
-	if ((regs->cs & 3) == 0 &&
+	if (!user_mode(regs) &&
 	    kernel_math_error(regs, "kernel x87 math error"))
 		return;
 
@@ -820,7 +820,7 @@
 	unsigned short mxcsr;
 
 	conditional_sti(regs);
-	if ((regs->cs & 3) == 0 &&
+	if (!user_mode(regs) &&
         	kernel_math_error(regs, "kernel simd math error"))
 		return;
 
diff -Naur linux-2.6.12-rc3/arch/x86_64/mm/fault.c linux-2.6.12-rc3.1/arch/x86_64/mm/fault.c
--- linux-2.6.12-rc3/arch/x86_64/mm/fault.c	2005-04-25 11:51:30.279600603 +0100
+++ linux-2.6.12-rc3.1/arch/x86_64/mm/fault.c	2005-04-25 12:04:34.921045881 +0100
@@ -74,7 +74,7 @@
 	instr = (unsigned char *)convert_rip_to_linear(current, regs);
 	max_instr = instr + 15;
 
-	if ((regs->cs & 3) != 0 && instr >= (unsigned char *)TASK_SIZE)
+	if (user_mode(regs) && instr >= (unsigned char *)TASK_SIZE)
 		return 0;
 
 	while (scan_more && instr < max_instr) { 
@@ -106,7 +106,7 @@
 			/* Could check the LDT for lm, but for now it's good
 			   enough to assume that long mode only uses well known
 			   segments or kernel. */
-			scan_more = ((regs->cs & 3) == 0) || (regs->cs == __USER_CS);
+			scan_more = (!user_mode(regs)) || (regs->cs == __USER_CS);
 			break;
 			
 		case 0x60:
