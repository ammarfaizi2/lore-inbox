Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUG3CyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUG3CyB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUG3CyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:54:01 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:43932 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S265212AbUG3Cx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:53:59 -0400
Date: Fri, 30 Jul 2004 04:53:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [cleanup] do_general_protection doesn't disable irq
Message-ID: <20040730025349.GE30369@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A trap gate shouldn't affect the irq status at all.

This should be a valid cleanup that removes a slightly confusing noop:

Index: linux-2.5/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/kernel/traps.c,v
retrieving revision 1.77
diff -u -p -r1.77 traps.c
--- linux-2.5/arch/i386/kernel/traps.c	13 Jul 2004 18:02:33 -0000	1.77
+++ linux-2.5/arch/i386/kernel/traps.c	30 Jul 2004 02:44:23 -0000
@@ -431,9 +431,6 @@ DO_ERROR_INFO(17, SIGBUS, "alignment che
 
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
-	if (regs->eflags & X86_EFLAGS_IF)
-		local_irq_enable();
- 
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
 

Thanks to Karsten for noticing a trap gate doesn't actually enable irq
by default either (offtopic issue with the above patch, but while
reading the 2.6 code I found the above bit which just confused me more
since it's a noop, either that or you meant to use set_intr_gate, not
set_trap_gate on the do_general_protection handler, but it seems not
needed to use a trap gate since a trap gate shouldn't enable irqs by
default). Please correct me if wrong.

thanks.
