Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVA0KO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVA0KO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVA0KOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:14:08 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:42244 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262547AbVA0KNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:13:24 -0500
Date: Thu, 27 Jan 2005 10:13:22 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050127101322.GE9760@infradead.org>
References: <20050127101117.GA9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127101117.GA9760@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The patch below replaces the existing 8Kb randomisation of the userspace
stack pointer (which is currently only done for Hyperthreaded P-IVs) with a 
more general randomisation over a 64Kb range.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-step-2/arch/i386/kernel/process.c linux-step-4/arch/i386/kernel/process.c
--- linux-step-2/arch/i386/kernel/process.c	2005-01-26 18:24:35.472822000 +0100
+++ linux-step-4/arch/i386/kernel/process.c	2005-01-26 21:22:00.465537920 +0100
@@ -36,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -828,3 +829,9 @@ asmlinkage int sys_get_thread_area(struc
 	return 0;
 }
 
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (randomize_va_space)
+		sp -= ((get_random_int() % 4096) << 4);
+	return sp & ~0xf;
+}
diff -purN linux-step-2/arch/x86_64/kernel/process.c linux-step-4/arch/x86_64/kernel/process.c
--- linux-step-2/arch/x86_64/kernel/process.c	2005-01-26 18:24:49.000000000 +0100
+++ linux-step-4/arch/x86_64/kernel/process.c	2005-01-26 20:48:02.000000000 +0100
@@ -743,3 +743,10 @@ int dump_task_regs(struct task_struct *t
  
 	return 1;
 }
+
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (randomize_vs_space)
+		sp -= ((get_random_int() % 4096) << 4);
+	return sp & ~0xf;
+}
diff -purN linux-step-2/fs/binfmt_elf.c linux-step-4/fs/binfmt_elf.c
--- linux-step-2/fs/binfmt_elf.c	2005-01-26 21:14:51.464755952 +0100
+++ linux-step-4/fs/binfmt_elf.c	2005-01-26 21:18:49.017642424 +0100
@@ -165,20 +165,14 @@ create_elf_tables(struct linux_binprm *b
 	if (k_platform) {
 		size_t len = strlen(k_platform) + 1;
 
-#ifdef CONFIG_X86_HT
+#ifdef __HAVE_ARCH_ALIGN_STACK
 		/*
 		 * In some cases (e.g. Hyper-Threading), we want to avoid L1
 		 * evictions by the processes running on the same package. One
 		 * thing we can do is to shuffle the initial stack for them.
-		 *
-		 * The conditionals here are unneeded, but kept in to make the
-		 * code behaviour the same as pre change unless we have
-		 * hyperthreaded processors. This should be cleaned up
-		 * before 2.6
 		 */
 	 
-		if (smp_num_siblings > 1)
-			STACK_ALLOC(p, ((current->pid % 64) << 7));
+		p = arch_align_stack((unsigned long)p);
 #endif
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
 		if (__copy_to_user(u_platform, k_platform, len))
diff -purN linux-step-2/fs/exec.c linux-step-4/fs/exec.c
--- linux-step-2/fs/exec.c	2005-01-26 21:15:33.860310848 +0100
+++ linux-step-4/fs/exec.c	2005-01-26 21:25:22.678796832 +0100
@@ -400,7 +400,12 @@ int setup_arg_pages(struct linux_binprm 
 	while (i < MAX_ARG_PAGES)
 		bprm->page[i++] = NULL;
 #else
-	stack_base = stack_top - MAX_ARG_PAGES * PAGE_SIZE;
+#ifdef __HAVE_ARCH_ALIGN_STACK
+	stack_base = arch_align_stack(STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE);
+	stack_base = PAGE_ALIGN(stack_base);
+#else
+	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
+#endif
 	bprm->p += stack_base;
 	mm->arg_start = bprm->p;
 	arg_size = stack_top - (PAGE_MASK & (unsigned long) mm->arg_start);
diff -purN linux-step-2/include/asm-i386/system.h linux-step-4/include/asm-i386/system.h
--- linux-step-2/include/asm-i386/system.h	2005-01-26 18:24:39.226252000 +0100
+++ linux-step-4/include/asm-i386/system.h	2005-01-26 20:49:59.000000000 +0100
@@ -468,4 +468,7 @@ void enable_hlt(void);
 extern int es7000_plat;
 void cpu_idle_wait(void);
 
+#define __HAVE_ARCH_ALIGN_STACK
+extern unsigned long arch_align_stack(unsigned long sp);
+
 #endif
diff -purN linux-step-2/include/asm-x86_64/system.h linux-step-4/include/asm-x86_64/system.h
--- linux-step-2/include/asm-x86_64/system.h	2005-01-26 18:24:39.000000000 +0100
+++ linux-step-4/include/asm-x86_64/system.h	2005-01-26 20:50:14.000000000 +0100
@@ -338,4 +338,7 @@ void enable_hlt(void);
 #define HAVE_EAT_KEY
 void eat_key(void);
 
+#define __HAVE_ARCH_ALIGN_STACK
+extern unsigned long arch_align_stack(unsigned long sp);
+
 #endif
