Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUG3OFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUG3OFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 10:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267682AbUG3OFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 10:05:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:17635 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265773AbUG3OFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 10:05:23 -0400
Date: Fri, 30 Jul 2004 15:58:40 +0200
From: Karsten Keil <kkeil@suse.de>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [cleanup] do_general_protection doesn't disable irq
Message-ID: <20040730135840.GA12152@pingi3.kke.suse.de>
Mail-Followup-To: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20040730025349.GE30369@dualathlon.random> <4109CCED.5020808@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4109CCED.5020808@quark.didntduck.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.4-52-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 12:22:05AM -0400, Brian Gerst wrote:
> Andrea Arcangeli wrote:
> >A trap gate shouldn't affect the irq status at all.
> >
> >This should be a valid cleanup that removes a slightly confusing noop:
> >
> >Index: linux-2.5/arch/i386/kernel/traps.c
> >===================================================================
> >RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/kernel/traps.c,v
> >retrieving revision 1.77
> >diff -u -p -r1.77 traps.c
> >--- linux-2.5/arch/i386/kernel/traps.c	13 Jul 2004 18:02:33 -0000 
> >1.77
> >+++ linux-2.5/arch/i386/kernel/traps.c	30 Jul 2004 02:44:23 -0000
> >@@ -431,9 +431,6 @@ DO_ERROR_INFO(17, SIGBUS, "alignment che
> > 
> > asmlinkage void do_general_protection(struct pt_regs * regs, long 
> > error_code)
> > {
> >-	if (regs->eflags & X86_EFLAGS_IF)
> >-		local_irq_enable();
> >- 
> > 	if (regs->eflags & VM_MASK)
> > 		goto gp_in_vm86;
> > 
> >
> >Thanks to Karsten for noticing a trap gate doesn't actually enable irq
> >by default either (offtopic issue with the above patch, but while
> >reading the 2.6 code I found the above bit which just confused me more
> >since it's a noop, either that or you meant to use set_intr_gate, not
> >set_trap_gate on the do_general_protection handler, but it seems not
> >needed to use a trap gate since a trap gate shouldn't enable irqs by
> >default). Please correct me if wrong.
> 
> This is there for vm86 mode.  See http://tinyurl.com/3m5nr
> 

It makes also no sense, if the GP comes from VM86 mode, what you
need there is the second hunk in the patch which does local_irq_enable();
if it was from VM86. Note: the trap gate do not touch X86_EFLAGS_IF bit,
so the saved value in regs->eflags is the same as in the CPU EFLAGS register.

-- 
Karsten Keil
SuSE Labs
ISDN development
