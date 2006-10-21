Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993144AbWJUQxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993144AbWJUQxY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993154AbWJUQvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:53 -0400
Received: from ns1.suse.de ([195.135.220.2]:48796 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993147AbWJUQvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:37 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: jbeulich@novell.com, patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [16/19] x86: Revert new unwind kernel stack termination
Message-Id: <20061021165136.9936113C4D@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:36 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan convinced me that it was unnecessary because the assembly stubs do 
this already on the stack.

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/process.c |    6 +-----
 arch/x86_64/kernel/entry.S |    5 -----
 2 files changed, 1 insertion(+), 10 deletions(-)

Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -336,7 +336,6 @@ extern void kernel_thread_helper(void);
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	struct pt_regs regs;
-	int err;
 
 	memset(&regs, 0, sizeof(regs));
 
@@ -351,10 +350,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
-	err = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
-	if (err == 0) /* terminate kernel stack */
-		task_pt_regs(current)->eip = 0;
-	return err;
+	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 }
 EXPORT_SYMBOL(kernel_thread);
 
Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -980,11 +980,6 @@ ENTRY(kernel_thread)
 	call do_fork
 	movq %rax,RAX(%rsp)
 	xorl %edi,%edi
-	test %rax,%rax
-	jnz  1f
-	/* terminate stack in child */
-	movq %rdi,RIP(%rsp)
-1:
 
 	/*
 	 * It isn't worth to check for reschedule here,
