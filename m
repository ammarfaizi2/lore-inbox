Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTEKITJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 04:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTEKITJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 04:19:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9387 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261158AbTEKITD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 04:19:03 -0400
Date: Sun, 11 May 2003 01:32:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct page protection for put_dirty_page
Message-Id: <20030511013226.25e690bf.akpm@digeo.com>
In-Reply-To: <20030511080841.GA31266@averell>
References: <20030511080841.GA31266@averell>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 May 2003 08:31:39.0739 (UTC) FILETIME=[BE572AB0:01C31797]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> put_page_dirty must use the page protection of the stack VMA, not hardcoded
>  PAGE_COPY. They can be different e.g. when the stack is set non executable
>  via VM_STACK_FLAGS.

OK.  It seems a bit inefficient to go looking up the vma immediately after
having created it.

How about we simply pass the desired protection in to put_dirty_page()?


 arch/ia64/ia32/binfmt_elf32.c  |    4 ++--
 arch/s390/kernel/compat_exec.c |    5 ++---
 arch/x86_64/ia32/ia32_binfmt.c |    6 ++----
 fs/exec.c                      |   13 +++++++------
 include/linux/mm.h             |    3 ++-
 5 files changed, 15 insertions(+), 16 deletions(-)

diff -puN arch/ia64/ia32/binfmt_elf32.c~put_dirty_page-protection-fix arch/ia64/ia32/binfmt_elf32.c
--- 25/arch/ia64/ia32/binfmt_elf32.c~put_dirty_page-protection-fix	2003-05-11 01:23:04.000000000 -0700
+++ 25-akpm/arch/ia64/ia32/binfmt_elf32.c	2003-05-11 01:23:50.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 
 #include <linux/types.h>
+#include <linux/mm.h>
 
 #include <asm/param.h>
 #include <asm/signal.h>
@@ -40,7 +41,6 @@
 #define CLOCKS_PER_SEC	IA32_CLOCKS_PER_SEC
 
 extern void ia64_elf32_init (struct pt_regs *regs);
-extern void put_dirty_page (struct task_struct * tsk, struct page *page, unsigned long address);
 
 static void elf32_set_personality (void);
 
@@ -200,7 +200,7 @@ ia32_setup_arg_pages (struct linux_binpr
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current, page, stack_base);
+			put_dirty_page(current, page, stack_base, PAGE_COPY);
 		}
 		stack_base += PAGE_SIZE;
 	}
diff -puN arch/ia64/mm/init.c~put_dirty_page-protection-fix arch/ia64/mm/init.c
diff -puN arch/s390/kernel/compat_exec.c~put_dirty_page-protection-fix arch/s390/kernel/compat_exec.c
--- 25/arch/s390/kernel/compat_exec.c~put_dirty_page-protection-fix	2003-05-11 01:23:04.000000000 -0700
+++ 25-akpm/arch/s390/kernel/compat_exec.c	2003-05-11 01:24:20.000000000 -0700
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
+#include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/binfmts.h>
@@ -32,8 +33,6 @@
 #endif
 
 
-extern void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address);
-
 #undef STACK_TOP
 #define STACK_TOP TASK31_SIZE
 
@@ -81,7 +80,7 @@ int setup_arg_pages32(struct linux_binpr
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current,page,stack_base);
+			put_dirty_page(current,page,stack_base,PAGE_COPY);
 		}
 		stack_base += PAGE_SIZE;
 	}
diff -puN arch/x86_64/ia32/ia32_binfmt.c~put_dirty_page-protection-fix arch/x86_64/ia32/ia32_binfmt.c
--- 25/arch/x86_64/ia32/ia32_binfmt.c~put_dirty_page-protection-fix	2003-05-11 01:23:04.000000000 -0700
+++ 25-akpm/arch/x86_64/ia32/ia32_binfmt.c	2003-05-11 01:24:38.000000000 -0700
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/binfmts.h>
+#include <linux/mm.h>
 #include <asm/segment.h> 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -272,9 +273,6 @@ static void elf32_init(struct pt_regs *r
 	set_thread_flag(TIF_IA32); 
 }
 
-extern void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address);
- 
-
 int setup_arg_pages(struct linux_binprm *bprm)
 {
 	unsigned long stack_base;
@@ -319,7 +317,7 @@ int setup_arg_pages(struct linux_binprm 
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current,page,stack_base);
+			put_dirty_page(current,page,stack_base,PAGE_COPY_EXEC);
 		}
 		stack_base += PAGE_SIZE;
 	}
diff -puN fs/exec.c~put_dirty_page-protection-fix fs/exec.c
--- 25/fs/exec.c~put_dirty_page-protection-fix	2003-05-11 01:23:05.000000000 -0700
+++ 25-akpm/fs/exec.c	2003-05-11 01:26:16.000000000 -0700
@@ -287,7 +287,8 @@ int copy_strings_kernel(int argc,char **
  *
  * tsk->mmap_sem is held for writing.
  */
-void put_dirty_page(struct task_struct * tsk, struct page *page, unsigned long address)
+void put_dirty_page(struct task_struct *tsk, struct page *page,
+			unsigned long address, pgprot_t prot)
 {
 	pgd_t * pgd;
 	pmd_t * pmd;
@@ -295,7 +296,8 @@ void put_dirty_page(struct task_struct *
 	struct pte_chain *pte_chain;
 
 	if (page_count(page) != 1)
-		printk(KERN_ERR "mem_map disagrees with %p at %08lx\n", page, address);
+		printk(KERN_ERR "mem_map disagrees with %p at %08lx\n",
+				page, address);
 
 	pgd = pgd_offset(tsk->mm, address);
 	pte_chain = pte_chain_alloc(GFP_KERNEL);
@@ -314,7 +316,7 @@ void put_dirty_page(struct task_struct *
 	}
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
-	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
+	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, prot))));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
 	tsk->mm->rss++;
@@ -421,7 +423,8 @@ int setup_arg_pages(struct linux_binprm 
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			put_dirty_page(current,page,stack_base);
+			put_dirty_page(current, page, stack_base,
+					mpnt->vm_page_prot);
 		}
 		stack_base += PAGE_SIZE;
 	}
@@ -434,8 +437,6 @@ int setup_arg_pages(struct linux_binprm 
 
 #else
 
-#define put_dirty_page(tsk, page, address)
-#define setup_arg_pages(bprm)			(0)
 static inline void free_arg_pages(struct linux_binprm *bprm)
 {
 	int i;
diff -puN include/linux/mm.h~put_dirty_page-protection-fix include/linux/mm.h
--- 25/include/linux/mm.h~put_dirty_page-protection-fix	2003-05-11 01:23:05.000000000 -0700
+++ 25-akpm/include/linux/mm.h	2003-05-11 01:27:12.000000000 -0700
@@ -421,7 +421,8 @@ extern int handle_mm_fault(struct mm_str
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 extern long sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
-
+void put_dirty_page(struct task_struct *tsk, struct page *page,
+			unsigned long address, pgprot_t prot);
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);

_

