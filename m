Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbULTILo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbULTILo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbULTID5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:03:57 -0500
Received: from fsmlabs.com ([168.103.115.128]:28092 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261493AbULTHVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:21:48 -0500
Date: Mon, 20 Dec 2004 00:21:48 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Boottime allocated GDTs and doublefault handler
In-Reply-To: <Pine.LNX.4.58.0412191824280.4112@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0412192307490.18310@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412191730330.18272@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0412191824280.4112@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, 19 Dec 2004, Linus Torvalds wrote:

> It's not much of an issue for the gdt/tss checks, since those are very 
> unlikely to be wrong anyway, but if we want to make the code print out any 
> other information (like the old stack contents, and process info), then a 
> "ptr_ok()" thing that actually is dependable would be a lot more useful..
> 
> Hint hint..

Ok =), i've added the page table walker and some basic code to fish out 
'current' and dump a few words of its stack. Sorry about the noise in the 
patch but the nested if()s were beginning to go too far.

 arch/i386/kernel/doublefault.c |   85 +++++++++++++++++++++++++++++++----------
 arch/i386/kernel/traps.c       |    6 --
 include/asm-i386/thread_info.h |    6 ++
 3 files changed, 71 insertions(+), 26 deletions(-)

===== arch/i386/kernel/doublefault.c 1.4 vs edited =====
--- 1.4/arch/i386/kernel/doublefault.c	2004-08-24 03:08:41 -06:00
+++ edited/arch/i386/kernel/doublefault.c	2004-12-20 00:04:50 -07:00
@@ -13,37 +13,82 @@
 static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
 #define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
 
-#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + 0x1000000)
+static int ptr_ok(unsigned long vaddr)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t pte;
+
+	__asm__ __volatile__("movl %%cr3, %0" : "=r"(pgd));
+	pgd = __va(pgd);
+	pgd += pgd_index(vaddr);
+	pmd = pmd_offset(pgd, vaddr);
+	if (pmd_none(*pmd))
+		return 0;
+	else if (pmd_large(*pmd))
+		return 1;
+
+	pte = *pte_offset_kernel(pmd, vaddr);
+	if (!pte_present(pte) || PageHighMem(pte_page(pte)))
+		return 0;
+
+	return 1;
+}
 
 static void doublefault_fn(void)
 {
 	struct Xgt_desc_struct gdt_desc = {0, 0};
-	unsigned long gdt, tss;
+	struct tss_struct *t;
+	struct thread_info *ti;
+	struct task_struct *tsk;
+	unsigned long gdt, tss, *esp;
+	int r = 0;
 
 	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");
 	gdt = gdt_desc.address;
 
 	printk("double fault, gdt at %08lx [%d bytes]\n", gdt, gdt_desc.size);
 
-	if (ptr_ok(gdt)) {
-		gdt += GDT_ENTRY_TSS << 3;
-		tss = *(u16 *)(gdt+2);
-		tss += *(u8 *)(gdt+4) << 16;
-		tss += *(u8 *)(gdt+7) << 24;
-		printk("double fault, tss at %08lx\n", tss);
-
-		if (ptr_ok(tss)) {
-			struct tss_struct *t = (struct tss_struct *)tss;
-
-			printk("eip = %08lx, esp = %08lx\n", t->eip, t->esp);
-
-			printk("eax = %08lx, ebx = %08lx, ecx = %08lx, edx = %08lx\n",
-				t->eax, t->ebx, t->ecx, t->edx);
-			printk("esi = %08lx, edi = %08lx\n",
-				t->esi, t->edi);
-		}
-	}
+	if (!ptr_ok(gdt))
+		goto done;
+
+	gdt += GDT_ENTRY_TSS << 3;
+	tss = *(u16 *)(gdt+2);
+	tss += *(u8 *)(gdt+4) << 16;
+	tss += *(u8 *)(gdt+7) << 24;
+	printk("double fault, tss at %08lx\n", tss);
+
+	if (!ptr_ok(tss))
+		goto done;
+
+	t = (struct tss_struct *)tss;
+	printk("eip = %08lx, esp = %08lx\n", t->eip, t->esp);
+	printk("eax = %08lx, ebx = %08lx, ecx = %08lx, edx = %08lx\n",
+		t->eax, t->ebx, t->ecx, t->edx);
+	printk("esi = %08lx, edi = %08lx\n",
+		t->esi, t->edi);
+
+	if (!ptr_ok(t->esp))
+		goto done;
+
+	ti = (struct thread_info *)(t->esp & ~(THREAD_SIZE - 1));
+	tsk = ti->task;
+	if (!ptr_ok((unsigned long)tsk))
+		goto done;
+
+	esp = (unsigned long *)t->esp;
+	printk("task: %p (%s) stack:\n", tsk, tsk->comm);
+#if 0
+	show_stack(tsk, esp);
+#else
+	while (ptr_ok((unsigned long)esp) && valid_stack_ptr(ti, esp)) {
+		printk("%08lx ", *esp++);
+		if (!(++r % 8))
+			printk("\n");
+        }
+#endif
 
+done:
 	for (;;) /* nothing */;
 }
 
===== arch/i386/kernel/traps.c 1.91 vs edited =====
--- 1.91/arch/i386/kernel/traps.c	2004-11-23 17:47:27 -07:00
+++ edited/arch/i386/kernel/traps.c	2004-12-20 00:04:38 -07:00
@@ -105,12 +105,6 @@ int register_die_notifier(struct notifie
 	return err;
 }
 
-static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
-{
-	return	p > (void *)tinfo &&
-		p < (void *)tinfo + THREAD_SIZE - 3;
-}
-
 static inline unsigned long print_context_stack(struct thread_info *tinfo,
 				unsigned long *stack, unsigned long ebp)
 {
===== include/asm-i386/thread_info.h 1.23 vs edited =====
--- 1.23/include/asm-i386/thread_info.h	2004-11-19 00:03:11 -07:00
+++ edited/include/asm-i386/thread_info.h	2004-12-20 00:09:19 -07:00
@@ -95,6 +95,12 @@ static inline struct thread_info *curren
 /* how to get the current stack pointer from C */
 register unsigned long current_stack_pointer asm("esp") __attribute_used__;
 
+static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
+{
+        return  p > (void *)tinfo &&
+                p < (void *)tinfo + THREAD_SIZE - 3;
+}
+
 /* thread information allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE
 #define alloc_thread_info(tsk)					\
