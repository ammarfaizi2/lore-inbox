Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTJ0RlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTJ0RlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:41:18 -0500
Received: from front3.chartermi.net ([24.213.60.109]:49098 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id S263444AbTJ0RlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:41:07 -0500
Message-ID: <3F9D58B1.7000602@didntduck.org>
Date: Mon, 27 Oct 2003 12:41:05 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix sysenter disabling in vm86 mode
Content-Type: multipart/mixed;
 boundary="------------050801080604010301050308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050801080604010301050308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The current code disables sysenter when first entering vm86 mode, but 
does not disable it again when coming back to a vm86 task after a task 
switch.

--
				Brian Gerst

--------------050801080604010301050308
Content-Type: text/plain;
 name="vm86-sysenter"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm86-sysenter"

diff -urN linux-2.6.0-test8-bk/arch/i386/kernel/cpu/common.c linux/arch/i386/kernel/cpu/common.c
--- linux-2.6.0-test8-bk/arch/i386/kernel/cpu/common.c	2003-09-28 10:20:31.000000000 -0400
+++ linux/arch/i386/kernel/cpu/common.c	2003-10-22 10:10:39.932356584 -0400
@@ -510,7 +510,7 @@
 		BUG();
 	enter_lazy_tlb(&init_mm, current);
 
-	load_esp0(t, thread->esp0);
+	load_esp0(t, thread);
 	set_tss_desc(cpu,t);
 	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
diff -urN linux-2.6.0-test8-bk/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- linux-2.6.0-test8-bk/arch/i386/kernel/process.c	2003-10-08 16:11:44.000000000 -0400
+++ linux/arch/i386/kernel/process.c	2003-10-22 10:10:39.933356432 -0400
@@ -507,7 +507,7 @@
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
-	load_esp0(tss, next->esp0);
+	load_esp0(tss, next);
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
diff -urN linux-2.6.0-test8-bk/arch/i386/kernel/vm86.c linux/arch/i386/kernel/vm86.c
--- linux-2.6.0-test8-bk/arch/i386/kernel/vm86.c	2003-07-27 12:57:40.000000000 -0400
+++ linux/arch/i386/kernel/vm86.c	2003-10-22 10:10:39.934356280 -0400
@@ -117,7 +117,8 @@
 
 	tss = init_tss + get_cpu();
 	current->thread.esp0 = current->thread.saved_esp0;
-	load_esp0(tss, current->thread.esp0);
+	current->thread.sysenter_cs = __KERNEL_CS;
+	load_esp0(tss, &current->thread);
 	current->thread.saved_esp0 = 0;
 	put_cpu();
 
@@ -294,8 +295,10 @@
 	asm volatile("movl %%gs,%0":"=m" (tsk->thread.saved_gs));
 
 	tss = init_tss + get_cpu();
-	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
-	disable_sysenter(tss);
+	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
+	if (cpu_has_sep)
+		tsk->thread.sysenter_cs = 0;
+	load_esp0(tss, &tsk->thread);
 	put_cpu();
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
diff -urN linux-2.6.0-test8-bk/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-2.6.0-test8-bk/include/asm-i386/processor.h	2003-10-18 09:29:32.000000000 -0400
+++ linux/include/asm-i386/processor.h	2003-10-22 10:10:50.824700696 -0400
@@ -407,6 +407,7 @@
 /* cached TLS descriptors. */
 	struct desc_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
 	unsigned long	esp0;
+	unsigned long	sysenter_cs;
 	unsigned long	eip;
 	unsigned long	esp;
 	unsigned long	fs;
@@ -428,6 +429,7 @@
 
 #define INIT_THREAD  {							\
 	.vm86_info = NULL,						\
+	.sysenter_cs = __KERNEL_CS,					\
 	.io_bitmap_ptr = NULL,						\
 }
 
@@ -447,21 +449,13 @@
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0 },		\
 }
 
-static inline void load_esp0(struct tss_struct *tss, unsigned long esp0)
+static inline void load_esp0(struct tss_struct *tss, struct thread_struct *thread)
 {
-	tss->esp0 = esp0;
+	tss->esp0 = thread->esp0;
 	/* This can only happen when SEP is enabled, no need to test "SEP"arately */
-	if ((unlikely(tss->ss1 != __KERNEL_CS))) {
-		tss->ss1 = __KERNEL_CS;
-		wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
-	}
-}
-
-static inline void disable_sysenter(struct tss_struct *tss)
-{
-	if (cpu_has_sep)  {
-		tss->ss1 = 0;
-		wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);
+	if (unlikely(tss->ss1 != thread->sysenter_cs)) {
+		tss->ss1 = thread->sysenter_cs;
+		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
 	}
 }
 

--------------050801080604010301050308--

