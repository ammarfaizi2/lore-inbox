Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUFWMcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUFWMcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbUFWMbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:31:47 -0400
Received: from gprs214-143.eurotel.cz ([160.218.214.143]:52363 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262547AbUFWMb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:31:29 -0400
Date: Wed, 23 Jun 2004 14:30:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: shuffle cpu.c to make it usable for smp suspend
Message-ID: <20040623123052.GA1053@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This moves fix_processor_context() so that additional prototype is not
needed, and adds context * to processor state saving functions, so
that they can be used on SMP. It should be done this way from the
beggining. Please consider applying,

Signed-off-by: Pavel Machek <pavel@suse.cz>
							Pavel

--- linux.orig/arch/i386/power/cpu.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/arch/i386/power/cpu.c	2004-06-09 14:38:54.000000000 +0200
@@ -27,7 +27,6 @@
 #include <asm/tlbflush.h>
 
 static struct saved_context saved_context;
-static void fix_processor_context(void);
 
 unsigned long saved_context_eax, saved_context_ebx;
 unsigned long saved_context_ecx, saved_context_edx;
@@ -37,33 +36,38 @@
 
 extern void enable_sep_cpu(void *);
 
-void save_processor_state(void)
+void __save_processor_state(struct saved_context *ctxt)
 {
 	kernel_fpu_begin();
 
 	/*
 	 * descriptor tables
 	 */
-	asm volatile ("sgdt %0" : "=m" (saved_context.gdt_limit));
-	asm volatile ("sidt %0" : "=m" (saved_context.idt_limit));
-	asm volatile ("sldt %0" : "=m" (saved_context.ldt));
-	asm volatile ("str %0"  : "=m" (saved_context.tr));
+	asm volatile ("sgdt %0" : "=m" (ctxt->gdt_limit));
+	asm volatile ("sidt %0" : "=m" (ctxt->idt_limit));
+	asm volatile ("sldt %0" : "=m" (ctxt->ldt));
+	asm volatile ("str %0"  : "=m" (ctxt->tr));
 
 	/*
 	 * segment registers
 	 */
-	asm volatile ("movw %%es, %0" : "=m" (saved_context.es));
-	asm volatile ("movw %%fs, %0" : "=m" (saved_context.fs));
-	asm volatile ("movw %%gs, %0" : "=m" (saved_context.gs));
-	asm volatile ("movw %%ss, %0" : "=m" (saved_context.ss));
+	asm volatile ("movw %%es, %0" : "=m" (ctxt->es));
+	asm volatile ("movw %%fs, %0" : "=m" (ctxt->fs));
+	asm volatile ("movw %%gs, %0" : "=m" (ctxt->gs));
+	asm volatile ("movw %%ss, %0" : "=m" (ctxt->ss));
 
 	/*
 	 * control registers 
 	 */
-	asm volatile ("movl %%cr0, %0" : "=r" (saved_context.cr0));
-	asm volatile ("movl %%cr2, %0" : "=r" (saved_context.cr2));
-	asm volatile ("movl %%cr3, %0" : "=r" (saved_context.cr3));
-	asm volatile ("movl %%cr4, %0" : "=r" (saved_context.cr4));
+	asm volatile ("movl %%cr0, %0" : "=r" (ctxt->cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (ctxt->cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (ctxt->cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (ctxt->cr4));
+}
+
+void save_processor_state(void)
+{
+	__save_processor_state(&saved_context);
 }
 
 static void
@@ -75,32 +79,59 @@
 	mxcsr_feature_mask_init();
 }
 
-void restore_processor_state(void)
+
+static void fix_processor_context(void)
+{
+	int cpu = smp_processor_id();
+	struct tss_struct * t = init_tss + cpu;
+
+	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
+        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
+
+	load_TR_desc();				/* This does ltr */
+	load_LDT(&current->active_mm->context);	/* This does lldt */
+
+	/*
+	 * Now maybe reload the debug registers
+	 */
+	if (current->thread.debugreg[7]){
+                loaddebug(&current->thread, 0);
+                loaddebug(&current->thread, 1);
+                loaddebug(&current->thread, 2);
+                loaddebug(&current->thread, 3);
+                /* no 4 and 5 */
+                loaddebug(&current->thread, 6);
+                loaddebug(&current->thread, 7);
+	}
+
+}
+
+void __restore_processor_state(struct saved_context *ctxt)
 {
 
 	/*
 	 * control registers
 	 */
-	asm volatile ("movl %0, %%cr4" :: "r" (saved_context.cr4));
-	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
-	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
-	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
+	asm volatile ("movl %0, %%cr4" :: "r" (ctxt->cr4));
+	asm volatile ("movl %0, %%cr3" :: "r" (ctxt->cr3));
+	asm volatile ("movl %0, %%cr2" :: "r" (ctxt->cr2));
+	asm volatile ("movl %0, %%cr0" :: "r" (ctxt->cr0));
 
 	/*
 	 * segment registers
 	 */
-	asm volatile ("movw %0, %%es" :: "r" (saved_context.es));
-	asm volatile ("movw %0, %%fs" :: "r" (saved_context.fs));
-	asm volatile ("movw %0, %%gs" :: "r" (saved_context.gs));
-	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
+	asm volatile ("movw %0, %%es" :: "r" (ctxt->es));
+	asm volatile ("movw %0, %%fs" :: "r" (ctxt->fs));
+	asm volatile ("movw %0, %%gs" :: "r" (ctxt->gs));
+	asm volatile ("movw %0, %%ss" :: "r" (ctxt->ss));
 
 	/*
 	 * now restore the descriptor tables to their proper values
 	 * ltr is done i fix_processor_context().
 	 */
-	asm volatile ("lgdt %0" :: "m" (saved_context.gdt_limit));
-	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));
-	asm volatile ("lldt %0" :: "m" (saved_context.ldt));
+	asm volatile ("lgdt %0" :: "m" (ctxt->gdt_limit));
+	asm volatile ("lidt %0" :: "m" (ctxt->idt_limit));
+	asm volatile ("lldt %0" :: "m" (ctxt->ldt));
 
 	/*
 	 * sysenter MSRs
@@ -112,31 +143,11 @@
 	do_fpu_end();
 }
 
-static void fix_processor_context(void)
+void restore_processor_state(void)
 {
-	int cpu = smp_processor_id();
-	struct tss_struct * t = init_tss + cpu;
-
-	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
-        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
-
-	load_TR_desc();				/* This does ltr */
-	load_LDT(&current->active_mm->context);	/* This does lldt */
-
-	/*
-	 * Now maybe reload the debug registers
-	 */
-	if (current->thread.debugreg[7]){
-                loaddebug(&current->thread, 0);
-                loaddebug(&current->thread, 1);
-                loaddebug(&current->thread, 2);
-                loaddebug(&current->thread, 3);
-                /* no 4 and 5 */
-                loaddebug(&current->thread, 6);
-                loaddebug(&current->thread, 7);
-	}
-
+	__restore_processor_state(&saved_context);
 }
 
+
 EXPORT_SYMBOL(save_processor_state);
 EXPORT_SYMBOL(restore_processor_state);


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
