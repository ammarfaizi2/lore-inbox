Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVCCQP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVCCQP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVCCQP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:15:28 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:5383 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261875AbVCCQPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:15:21 -0500
Message-Id: <200503030804.j2384WBY016301@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1 
In-Reply-To: Your message of "Tue, 01 Mar 2005 13:49:16 PST."
             <20050301214916.GJ28536@shell0.pdx.osdl.net> 
References: <20050301012741.1d791cd2.akpm@osdl.org>  <20050301214916.GJ28536@shell0.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Mar 2005 03:04:32 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisw@osdl.org said:
> I just did a more complete grep of the symbols that can get config'd
> away (including CONFIG_AUDIT as well), and I think there's a few more
> missing pieces.  Sorry about that.  Jeff, Ralf, Martin, these look ok?

For UML, this is fine as far as it goes, but you're adding register references
to arch-independent code, so this is needed as well:

Index: linux-2.6.10/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/ptrace.c	2005-03-03 00:14:46.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/ptrace.c	2005-03-03 00:22:58.000000000 -0500
@@ -340,11 +341,15 @@
 
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
-			audit_syscall_entry(current, regs->orig_eax,
-					    regs->ebx, regs->ecx,
-					    regs->edx, regs->esi);
+			audit_syscall_entry(current, 
+					    UPT_SYSCALL_NR(&regs->regs),
+					    UPT_SYSCALL_ARG1(&regs->regs),
+					    UPT_SYSCALL_ARG2(&regs->regs),
+					    UPT_SYSCALL_ARG3(&regs->regs),
+					    UPT_SYSCALL_ARG4(&regs->regs));
 		else
-			audit_syscall_exit(current, regs->eax);
+			audit_syscall_exit(current, 
+					   UPT_SYSCALL_RET(&regs->regs));
 	}
 
 	/* Fake a debug trap */

