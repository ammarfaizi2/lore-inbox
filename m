Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVFSJLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVFSJLd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 05:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVFSJLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 05:11:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36361 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262082AbVFSJL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 05:11:26 -0400
Date: Sun, 19 Jun 2005 10:11:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <20050619101120.B6499@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <1119134359.7675.38.camel@localhost.localdomain> <20050619001841.A7252@flint.arm.linux.org.uk> <1119144048.7675.101.camel@localhost.localdomain> <20050619100226.A6499@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050619100226.A6499@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Jun 19, 2005 at 10:02:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 10:02:26AM +0100, Russell King wrote:
> On Sun, Jun 19, 2005 at 02:20:48AM +0100, Richard Purdie wrote:
> > On Sun, 2005-06-19 at 00:18 +0100, Russell King wrote: 
> > > Thinking about what's probably happening, I suspect all the ARM suspend
> > > and resume code needs to be reworked to save more state.  I'll try to
> > > cook up a patch tomorrow to fix it, but I'll need you to provide
> > > feedback.
> > 
> > Ok, thanks. I'm happy to test any fixes/patches.
> 
> This should resolve the problem - we now rely on the stack pointer for
> each CPU mode to remain constant throughout the running time of the
> kernel, which includes across suspend/resume cycles.

Actually, this patch is probably an all-round better solution.

--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -328,7 +328,7 @@ static void __init setup_processor(void)
  * cpu_init dumps the cache information, initialises SMP specific
  * information, and sets up the per-CPU stacks.
  */
-void __init cpu_init(void)
+void cpu_init(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct stack *stk = &stacks[cpu];
--- a/arch/arm/mach-pxa/pm.c
+++ b/arch/arm/mach-pxa/pm.c
@@ -133,6 +133,8 @@ static int pxa_pm_enter(suspend_state_t 
 	/* *** go zzz *** */
 	pxa_cpu_pm_enter(state);
 
+	cpu_init();
+
 	/* after sleeping, validate the checksum */
 	checksum = 0;
 	for (i = 0; i < SLEEP_SAVE_SIZE - 1; i++)
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -88,6 +88,8 @@ static int sa11x0_pm_enter(suspend_state
 	/* go zzz */
 	sa1100_cpu_suspend();
 
+	cpu_init();
+
 	/*
 	 * Ensure not to come back here if it wasn't intended
 	 */
--- a/include/asm-arm/system.h
+++ b/include/asm-arm/system.h
@@ -104,6 +104,7 @@ extern void show_pte(struct mm_struct *m
 extern void __show_regs(struct pt_regs *);
 
 extern int cpu_architecture(void);
+extern void cpu_init(void);
 
 #define set_cr(x)					\
 	__asm__ __volatile__(				\


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
