Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271094AbTHLVHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTHLVHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:07:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1992 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271094AbTHLVHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:07:22 -0400
Date: Tue, 12 Aug 2003 22:07:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Better argument size tracking in fs/exec.c
Message-ID: <20030812210721.GH10015@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce a new variable "arg_size" and set it appropriately in each
arm of the CONFIG_STACK_GROWSUP.  This patch fixes a bug for PA-RISC
and makes the code cleaner for everyone.

diff -urpNX dontdiff linus-2.6/fs/exec.c parisc-2.6/fs/exec.c
--- linus-2.6/fs/exec.c	Tue Aug 12 13:11:16 2003
+++ parisc-2.6/fs/exec.c	Tue Aug 12 13:29:42 2003
@@ -341,6 +341,7 @@ int setup_arg_pages(struct linux_binprm 
 	struct vm_area_struct *mpnt;
 	struct mm_struct *mm = current->mm;
 	int i;
+	long arg_size;
 
 #ifdef CONFIG_STACK_GROWSUP
 	/* Move the argument and environment strings to the bottom of the
@@ -375,6 +376,7 @@ int setup_arg_pages(struct linux_binprm 
 	bprm->p = PAGE_SIZE * i - offset;
 	stack_base = STACK_TOP - current->rlim[RLIMIT_STACK].rlim_max;
 	mm->arg_start = stack_base;
+	arg_size = i << PAGE_SHIFT;
 
 	/* zero pages that were copied above */
 	while (i < MAX_ARG_PAGES)
@@ -382,6 +390,7 @@ int setup_arg_pages(struct linux_binprm 
 #else
 	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
+	arg_size = STACK_TOP - (PAGE_MASK & (unsigned long) mm->arg_start);
 #endif
 
 	bprm->p += stack_base;
@@ -393,7 +402,7 @@ int setup_arg_pages(struct linux_binprm 
 	if (!mpnt)
 		return -ENOMEM;
 
-	if (security_vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
+	if (security_vm_enough_memory(arg_size >> PAGE_SHIFT)) {
 		kmem_cache_free(vm_area_cachep, mpnt);
 		return -ENOMEM;
 	}

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
