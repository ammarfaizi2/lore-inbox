Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVDZLaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVDZLaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVDZLaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:30:17 -0400
Received: from hades.snarc.org ([212.85.152.11]:15109 "EHLO hades.snarc.org")
	by vger.kernel.org with ESMTP id S261443AbVDZLaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:30:02 -0400
Date: Tue, 26 Apr 2005 13:29:59 +0200
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: ian.pratt@cl.cam.ac.uk, akpm@osdl.org
Subject: [PATCH 4/6][XEN][x86] Use more usermode macro
Message-ID: <20050426112959.GD26614@snarc.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ian.pratt@cl.cam.ac.uk, akpm@osdl.org
References: <20050426103805.2DF124BE18@darwin.snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426103805.2DF124BE18@darwin.snarc.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch use the user_mode macro where it's possible.

ignore my previous mail, really sorry for the noise.

Please apply, or comments.

	Signed-off-by: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>

diff -Naur linux-2.6.12-rc3.1/arch/i386/kernel/process.c linux-2.6.12-rc3.2/arch/i386/kernel/process.c
--- linux-2.6.12-rc3.1/arch/i386/kernel/process.c	2005-04-22 12:10:22.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/i386/kernel/process.c	2005-04-25 16:09:25.000000000 +0100
@@ -262,7 +262,7 @@
 	printk("EIP: %04x:[<%08lx>] CPU: %d\n",0xffff & regs->xcs,regs->eip, smp_processor_id());
 	print_symbol("EIP is at %s\n", regs->eip);
 
-	if (regs->xcs & 3)
+	if (user_mode(regs))
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
 	printk(" EFLAGS: %08lx    %s  (%s)\n",
 	       regs->eflags, print_tainted(), system_utsname.release);
diff -Naur linux-2.6.12-rc3.1/arch/i386/kernel/signal.c linux-2.6.12-rc3.2/arch/i386/kernel/signal.c
--- linux-2.6.12-rc3.1/arch/i386/kernel/signal.c	2005-04-21 11:45:46.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/i386/kernel/signal.c	2005-04-25 16:09:53.000000000 +0100
@@ -599,7 +599,7 @@
 	 * kernel mode. Just return without doing anything
 	 * if so.
 	 */
-	if ((regs->xcs & 3) != 3)
+	if (!user_mode(regs))
 		return 1;
 
 	if (current->flags & PF_FREEZE) {
diff -Naur linux-2.6.12-rc3.1/arch/i386/kernel/traps.c linux-2.6.12-rc3.2/arch/i386/kernel/traps.c
--- linux-2.6.12-rc3.1/arch/i386/kernel/traps.c	2005-04-21 11:45:46.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/i386/kernel/traps.c	2005-04-25 16:12:34.000000000 +0100
@@ -209,7 +209,7 @@
 
 	esp = (unsigned long) (&regs->esp);
 	ss = __KERNEL_DS;
-	if (regs->xcs & 3) {
+	if (user_mode(regs)) {
 		in_kernel = 0;
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
@@ -265,7 +265,7 @@
 	char c;
 	unsigned long eip;
 
-	if (regs->xcs & 3)
+	if (user_mode(regs))
 		goto no_bug;		/* Not in kernel */
 
 	eip = regs->eip;
@@ -353,7 +353,7 @@
 
 static inline void die_if_kernel(const char * str, struct pt_regs * regs, long err)
 {
-	if (!(regs->eflags & VM_MASK) && !(3 & regs->xcs))
+	if (!user_mode_vm(regs))
 		die(str, regs, err);
 }
 
@@ -366,7 +366,7 @@
 		goto trap_signal;
 	}
 
-	if (!(regs->xcs & 3))
+	if (!user_mode(regs))
 		goto kernel_trap;
 
 	trap_signal: {
@@ -487,7 +487,7 @@
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
 
-	if (!(regs->xcs & 3))
+	if (!user_mode(regs))
 		goto gp_in_kernel;
 
 	current->thread.error_code = error_code;
@@ -713,7 +713,7 @@
 		 * check for kernel mode by just checking the CPL
 		 * of CS.
 		 */
-		if ((regs->xcs & 3) == 0)
+		if (!user_mode(regs))
 			goto clear_TF_reenable;
 	}
 
