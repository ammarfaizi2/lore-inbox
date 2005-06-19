Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVFSJC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVFSJC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 05:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVFSJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 05:02:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33291 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261864AbVFSJCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 05:02:50 -0400
Date: Sun, 19 Jun 2005 10:02:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <20050619100226.A6499@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <1119134359.7675.38.camel@localhost.localdomain> <20050619001841.A7252@flint.arm.linux.org.uk> <1119144048.7675.101.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1119144048.7675.101.camel@localhost.localdomain>; from rpurdie@rpsys.net on Sun, Jun 19, 2005 at 02:20:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 02:20:48AM +0100, Richard Purdie wrote:
> On Sun, 2005-06-19 at 00:18 +0100, Russell King wrote: 
> > Thinking about what's probably happening, I suspect all the ARM suspend
> > and resume code needs to be reworked to save more state.  I'll try to
> > cook up a patch tomorrow to fix it, but I'll need you to provide
> > feedback.
> 
> Ok, thanks. I'm happy to test any fixes/patches.

This should resolve the problem - we now rely on the stack pointer for
each CPU mode to remain constant throughout the running time of the
kernel, which includes across suspend/resume cycles.

--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -38,6 +38,16 @@ ENTRY(pxa_cpu_suspend)
 #endif
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
 
+	@ preserve IRQ, abort and undefined mode stack pointers
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | IRQ_MODE
+	mov	r4, sp
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | ABT_MODE
+	mov	r5, sp
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | UND_MODE
+	mov	r6, sp
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
+	stmfd	sp!, {r4 - r6}
+
 	@ get coprocessor registers
 	mrc	p14, 0, r3, c6, c0, 0		@ clock configuration, for turbo mode
 	mrc	p15, 0, r4, c15, c1, 0		@ CP access reg
@@ -229,6 +239,17 @@ resume_after_mmu:
 #ifdef CONFIG_XSCALE_CACHE_ERRATA
 	bl	cpu_xscale_proc_init
 #endif
+
+	@ restore IRQ, abort and undefined mode stack pointers
+	ldmfd	sp!, {r4 - r6}
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | IRQ_MODE
+	mov	sp, r4
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | ABT_MODE
+	mov	sp, r5
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | UND_MODE
+	mov	sp, r6
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
+
 	ldmfd	sp!, {r2, r3}
 #ifndef CONFIG_IWMMXT
 	mar	acc0, r2, r3
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -37,6 +37,16 @@ ENTRY(sa1100_cpu_suspend)
 
 	stmfd	sp!, {r4 - r12, lr}		@ save registers on stack
 
+	@ preserve IRQ, abort and undefined mode stack pointers
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | IRQ_MODE
+	mov	r4, sp
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | ABT_MODE
+	mov	r5, sp
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | UND_MODE
+	mov	r6, sp
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
+	stmfd	sp!, {r4 - r6}
+
 	@ get coprocessor registers
 	mrc 	p15, 0, r4, c3, c0, 0		@ domain ID
 	mrc 	p15, 0, r5, c2, c0, 0		@ translation table base addr
@@ -210,6 +220,17 @@ sleep_save_sp:
 	.text
 resume_after_mmu:
 	mcr     p15, 0, r1, c15, c1, 2		@ enable clock switching
+
+	@ restore IRQ, abort and undefined mode stack pointers
+	ldmfd	sp!, {r4 - r6}
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | IRQ_MODE
+	mov	sp, r4
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | ABT_MODE
+	mov	sp, r5
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | UND_MODE
+	mov	sp, r6
+	msr	cpsr_c, #PSR_F_BIT | PSR_I_BIT | SVC_MODE
+
 	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
 
 
> > Please note that you may see other ARM breakage over the next month
> > or so - I'm going to be concentrating on merging ARM SMP support,
> > and whatever bashing other people like yourself can give the kernel
> > will help ensure that problems are picked up quickly.
> 
> In order to assist with that, can you publish these patches somewhere?
> That way, I can apply them against a known good Zaurus kernel tree and
> know straight away if they break anything (diff/patch format would be
> preferable as my Zaurus trees are all patch based).

I'll see what I can do, but I'm going to be working fairly rapidly on
merging this, so expect roughly a patch each day.  Hopefully though,
the later patches will only affect the Integrator platform.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
