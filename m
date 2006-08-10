Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWHJTga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWHJTga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWHJTgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:25488 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932530AbWHJTfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:48 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [33/145] i386/x86-64: Don't randomize stack top when no randomization personality is set
Message-Id: <20060810193546.E2FB313C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:46 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Based on patch from Frank van Maarseveen <frankvm@frankvm.com>, but
extended.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/process.c   |    3 ++-
 arch/x86_64/kernel/process.c |    2 +-
 fs/binfmt_elf.c              |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -845,7 +845,7 @@ int dump_task_regs(struct task_struct *t
 
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -37,6 +37,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/personality.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -905,7 +906,7 @@ asmlinkage int sys_get_thread_area(struc
 
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
Index: linux/fs/binfmt_elf.c
===================================================================
--- linux.orig/fs/binfmt_elf.c
+++ linux/fs/binfmt_elf.c
@@ -515,7 +515,8 @@ static unsigned long randomize_stack_top
 {
 	unsigned int random_variable = 0;
 
-	if (current->flags & PF_RANDOMIZE) {
+	if ((current->flags & PF_RANDOMIZE) &&
+		!(current->personality & ADDR_NO_RANDOMIZE)) {
 		random_variable = get_random_int() & STACK_RND_MASK;
 		random_variable <<= PAGE_SHIFT;
 	}
