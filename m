Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbUKHPow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbUKHPow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbUKHPov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:44:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22723 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261873AbUKHOfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:25 -0500
Date: Mon, 8 Nov 2004 14:34:20 GMT
Message-Id: <200411081434.iA8EYKdN023627@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 19/20] FRV: change setup_arg_pages() to take stack pointer
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch changes setup_arg_pages() to take the proposed initial stack
top for the new executable image. This makes it easier for the binfmt to place
the stack at a non-fixed location, such as happens in !MMU configurations.

Signed-Off-By: dhowells@redhat.com
---
diffstat setup_arg_pages-2610rc1mm3.diff
 arch/x86_64/ia32/ia32_aout.c   |    5 +++--
 arch/x86_64/ia32/ia32_binfmt.c |    7 ++++---
 fs/binfmt_aout.c               |    2 +-
 fs/binfmt_elf.c                |    2 +-
 fs/binfmt_som.c                |    2 +-
 fs/exec.c                      |   12 +++++++-----
 include/linux/binfmts.h        |    4 +++-
 7 files changed, 20 insertions(+), 14 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/x86_64/ia32/ia32_aout.c linux-2.6.10-rc1-mm3-frv/arch/x86_64/ia32/ia32_aout.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/x86_64/ia32/ia32_aout.c	2004-10-27 17:32:14.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/x86_64/ia32/ia32_aout.c	2004-11-05 14:13:03.000000000 +0000
@@ -35,7 +35,8 @@
 #undef WARN_OLD
 #undef CORE_DUMP /* probably broken */
 
-extern int ia32_setup_arg_pages(struct linux_binprm *bprm, int exec_stack);
+extern int ia32_setup_arg_pages(struct linux_binprm *bprm,
+				unsigned long stack_top, int exec_stack);
 
 static int load_aout_binary(struct linux_binprm *, struct pt_regs * regs);
 static int load_aout_library(struct file*);
@@ -396,7 +397,7 @@ beyond_if:
 
 	set_brk(current->mm->start_brk, current->mm->brk);
 
-	retval = ia32_setup_arg_pages(bprm, EXSTACK_DEFAULT);
+	retval = ia32_setup_arg_pages(bprm, IA32_STACK_TOP, EXSTACK_DEFAULT);
 	if (retval < 0) { 
 		/* Someone check-me: is this error path enough? */ 
 		send_sig(SIGKILL, current, 0); 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/x86_64/ia32/ia32_binfmt.c linux-2.6.10-rc1-mm3-frv/arch/x86_64/ia32/ia32_binfmt.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/x86_64/ia32/ia32_binfmt.c	2004-10-27 17:32:14.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/x86_64/ia32/ia32_binfmt.c	2004-11-05 14:13:03.000000000 +0000
@@ -273,8 +273,9 @@ do {							\
 #define load_elf_binary load_elf32_binary
 
 #define ELF_PLAT_INIT(r, load_addr)	elf32_init(r)
-#define setup_arg_pages(bprm, exec_stack)	ia32_setup_arg_pages(bprm, exec_stack)
-int ia32_setup_arg_pages(struct linux_binprm *bprm, int executable_stack);
+#define setup_arg_pages(bprm, stack_top, exec_stack) \
+	ia32_setup_arg_pages(bprm, stack_top, exec_stack)
+int ia32_setup_arg_pages(struct linux_binprm *bprm, unsigned long stack_top, int executable_stack);
 
 #undef start_thread
 #define start_thread(regs,new_rip,new_rsp) do { \
@@ -329,7 +330,7 @@ static void elf32_init(struct pt_regs *r
 	me->thread.es = __USER_DS;
 }
 
-int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
+int setup_arg_pages(struct linux_binprm *bprm, unsigned long stack_top, int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/binfmt_aout.c linux-2.6.10-rc1-mm3-frv/fs/binfmt_aout.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/binfmt_aout.c	2004-10-27 17:32:30.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/fs/binfmt_aout.c	2004-11-05 14:13:03.000000000 +0000
@@ -415,7 +415,7 @@ beyond_if:
 
 	set_brk(current->mm->start_brk, current->mm->brk);
 
-	retval = setup_arg_pages(bprm, EXSTACK_DEFAULT);
+	retval = setup_arg_pages(bprm, STACK_TOP, EXSTACK_DEFAULT);
 	if (retval < 0) { 
 		/* Someone check-me: is this error path enough? */ 
 		send_sig(SIGKILL, current, 0); 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/binfmt_elf.c linux-2.6.10-rc1-mm3-frv/fs/binfmt_elf.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/binfmt_elf.c	2004-11-05 13:15:39.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/binfmt_elf.c	2004-11-05 14:13:03.000000000 +0000
@@ -718,7 +718,7 @@ static int load_elf_binary(struct linux_
 	   change some of these later */
 	current->mm->rss = 0;
 	current->mm->free_area_cache = current->mm->mmap_base;
-	retval = setup_arg_pages(bprm, executable_stack);
+	retval = setup_arg_pages(bprm, STACK_TOP, executable_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/binfmt_som.c linux-2.6.10-rc1-mm3-frv/fs/binfmt_som.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/binfmt_som.c	2004-06-18 13:43:59.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/fs/binfmt_som.c	2004-11-05 14:13:03.000000000 +0000
@@ -254,7 +254,7 @@ load_som_binary(struct linux_binprm * bp
 
 	set_binfmt(&som_format);
 	compute_creds(bprm);
-	setup_arg_pages(bprm, EXSTACK_DEFAULT);
+	setup_arg_pages(bprm, STACK_TOP, EXSTACK_DEFAULT);
 
 	create_som_tables(bprm);
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/exec.c linux-2.6.10-rc1-mm3-frv/fs/exec.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/exec.c	2004-11-05 13:15:39.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/exec.c	2004-11-05 14:13:03.769507090 +0000
@@ -342,7 +341,9 @@ out_sig:
 	force_sig(SIGKILL, current);
 }
 
-int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
+int setup_arg_pages(struct linux_binprm *bprm,
+		    unsigned long stack_top,
+		    int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
@@ -386,7 +387,7 @@ int setup_arg_pages(struct linux_binprm 
 	stack_base = current->signal->rlim[RLIMIT_STACK].rlim_max;
 	if (stack_base > (1 << 30))
 		stack_base = 1 << 30;
-	stack_base = PAGE_ALIGN(STACK_TOP - stack_base);
+	stack_base = PAGE_ALIGN(stack_top - stack_base);
 
 	mm->arg_start = stack_base;
 	arg_size = i << PAGE_SHIFT;
@@ -395,9 +396,9 @@ int setup_arg_pages(struct linux_binprm 
 	while (i < MAX_ARG_PAGES)
 		bprm->page[i++] = NULL;
 #else
-	stack_base = STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
+	stack_base = stack_top - MAX_ARG_PAGES * PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
-	arg_size = STACK_TOP - (PAGE_MASK & (unsigned long) mm->arg_start);
+	arg_size = stack_top - (PAGE_MASK & (unsigned long) mm->arg_start);
 #endif
 
 	bprm->p += stack_base;
@@ -425,7 +426,7 @@ int setup_arg_pages(struct linux_binprm 
 			(PAGE_SIZE - 1 + (unsigned long) bprm->p);
 #else
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
-		mpnt->vm_end = STACK_TOP;
+		mpnt->vm_end = stack_top;
 #endif
 		/* Adjust stack execute permissions; explicitly enable
 		 * for EXSTACK_ENABLE_X, disable for EXSTACK_DISABLE_X
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/binfmts.h linux-2.6.10-rc1-mm3-frv/include/linux/binfmts.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/binfmts.h	2004-09-16 12:06:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/linux/binfmts.h	2004-11-05 14:13:04.353457768 +0000
@@ -74,7 +74,9 @@ extern int flush_old_exec(struct linux_b
 #define EXSTACK_DISABLE_X 1	/* Disable executable stacks */
 #define EXSTACK_ENABLE_X  2	/* Enable executable stacks */
 
-extern int setup_arg_pages(struct linux_binprm * bprm, int executable_stack);
+extern int setup_arg_pages(struct linux_binprm * bprm,
+			   unsigned long stack_top,
+			   int executable_stack);
 extern int copy_strings(int argc,char __user * __user * argv,struct linux_binprm *bprm); 
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
 extern void compute_creds(struct linux_binprm *binprm);
