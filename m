Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVHUVgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVHUVgF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVHUVgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:36:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45260 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751138AbVHUVfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:35:47 -0400
Date: Sun, 21 Aug 2005 10:52:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Ondrej Zary <linux@rainbow-software.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: FPU-intensive programs crashing with floating point   exception
 on Cyrix MII
In-Reply-To: <200508210550_MC3-1-A7CF-D29E@compuserve.com>
Message-ID: <Pine.LNX.4.58.0508211043520.3317@g5.osdl.org>
References: <200508210550_MC3-1-A7CF-D29E@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Aug 2005, Chuck Ebbert wrote:
>
> > MATH ERROR: cwd = 0x37f, swd = 0x2800     <===========
> 
>  The error I marked has no exception flags set.  The rest are all (masked)
> denormal exceptions.  Why your Cyrix MII would cause an FPU exception in these
> cases is beyond me.  Could you try the statically-linked mprime program?

Also, please try this one, to see where it happens.

			Linus

---
diff --git a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c
+++ b/arch/i386/kernel/i8259.c
@@ -357,11 +357,11 @@ void init_8259A(int auto_eoi)
 
 static irqreturn_t math_error_irq(int cpl, void *dev_id, struct pt_regs *regs)
 {
-	extern void math_error(void __user *);
+	extern void math_error(struct pt_regs *);
 	outb(0,0xF0);
 	if (ignore_fpu_irq || !boot_cpu_data.hard_math)
 		return IRQ_NONE;
-	math_error((void __user *)regs->eip);
+	math_error(regs);
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -774,8 +774,9 @@ clear_TF_reenable:
  * the correct behaviour even in the presence of the asynchronous
  * IRQ13 behaviour
  */
-void math_error(void __user *eip)
+void math_error(struct pt_regs *regs)
 {
+	void __user *eip = (void __user *)regs->eip;
 	struct task_struct * task;
 	siginfo_t info;
 	unsigned short cwd, swd;
@@ -805,6 +806,7 @@ void math_error(void __user *eip)
 	swd = get_fpu_swd(task);
 	switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
 		case 0x000:
+			show_regs(regs);
 		default:
 			break;
 		case 0x001: /* Invalid Op */
@@ -833,7 +835,7 @@ void math_error(void __user *eip)
 fastcall void do_coprocessor_error(struct pt_regs * regs, long error_code)
 {
 	ignore_fpu_irq = 1;
-	math_error((void __user *)regs->eip);
+	math_error(regs);
 }
 
 static void simd_math_error(void __user *eip)
