Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267604AbUG3Eq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267604AbUG3Eq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 00:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267601AbUG3Eq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 00:46:28 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:33988 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267605AbUG3EqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 00:46:09 -0400
Date: Fri, 30 Jul 2004 06:45:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [cleanup] do_general_protection doesn't disable irq
Message-ID: <20040730044547.GF30369@dualathlon.random>
References: <20040730025349.GE30369@dualathlon.random> <4109CCED.5020808@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4109CCED.5020808@quark.didntduck.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
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

and the one for vm86 mode is still there, this was the only needed bit
from the tinyurl you quoted:

 gp_in_vm86:
+       local_irq_enable();

the regs->eflags & X86_EFLAGS_IF I removed is still a noop and in turn
it cannot help vm86 as far as I can tell.
