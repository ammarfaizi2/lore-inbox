Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262437AbSJ2WqV>; Tue, 29 Oct 2002 17:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSJ2WqV>; Tue, 29 Oct 2002 17:46:21 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18692 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262437AbSJ2WqT>;
	Tue, 29 Oct 2002 17:46:19 -0500
Date: Wed, 30 Oct 2002 00:15:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp updates
Message-ID: <20021029231516.GA146@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This uses "better" constraints that do not go through the register
unneccessarily. Please apply,
								Pavel

--- clean/arch/i386/kernel/suspend.c	2002-09-22 23:46:53.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/suspend.c	2002-10-13 20:19:43.000000000 +0200
@@ -54,10 +54,10 @@
 	/*
 	 * descriptor tables
 	 */
-	asm volatile ("sgdt (%0)" : "=m" (saved_context.gdt_limit));
-	asm volatile ("sidt (%0)" : "=m" (saved_context.idt_limit));
-	asm volatile ("sldt (%0)" : "=m" (saved_context.ldt));
-	asm volatile ("str (%0)"  : "=m" (saved_context.tr));
+	asm volatile ("sgdt %0" : "=m" (saved_context.gdt_limit));
+	asm volatile ("sidt %0" : "=m" (saved_context.idt_limit));
+	asm volatile ("sldt %0" : "=m" (saved_context.ldt));
+	asm volatile ("str %0"  : "=m" (saved_context.tr));
 
 	/*
 	 * save the general registers.
@@ -67,22 +67,22 @@
 	 * It's really not necessary, and kinda fishy (check the assembly output),
 	 * so it's avoided. 
 	 */
-	asm volatile ("movl %%esp, (%0)" : "=m" (saved_context.esp));
-	asm volatile ("movl %%eax, (%0)" : "=m" (saved_context.eax));
-	asm volatile ("movl %%ebx, (%0)" : "=m" (saved_context.ebx));
-	asm volatile ("movl %%ecx, (%0)" : "=m" (saved_context.ecx));
-	asm volatile ("movl %%edx, (%0)" : "=m" (saved_context.edx));
-	asm volatile ("movl %%ebp, (%0)" : "=m" (saved_context.ebp));
-	asm volatile ("movl %%esi, (%0)" : "=m" (saved_context.esi));
-	asm volatile ("movl %%edi, (%0)" : "=m" (saved_context.edi));
-
+	asm volatile ("movl %%esp, %0" : "=m" (saved_context.esp));
+	asm volatile ("movl %%eax, %0" : "=m" (saved_context.eax));
+	asm volatile ("movl %%ebx, %0" : "=m" (saved_context.ebx));
+	asm volatile ("movl %%ecx, %0" : "=m" (saved_context.ecx));
+	asm volatile ("movl %%edx, %0" : "=m" (saved_context.edx));
+	asm volatile ("movl %%ebp, %0" : "=m" (saved_context.ebp));
+	asm volatile ("movl %%esi, %0" : "=m" (saved_context.esi));
+	asm volatile ("movl %%edi, %0" : "=m" (saved_context.edi));
+	/* FIXME: Need to save XMM0..XMM15? */
 	/*
 	 * segment registers
 	 */
-	asm volatile ("movw %%es, %0" : "=r" (saved_context.es));
-	asm volatile ("movw %%fs, %0" : "=r" (saved_context.fs));
-	asm volatile ("movw %%gs, %0" : "=r" (saved_context.gs));
-	asm volatile ("movw %%ss, %0" : "=r" (saved_context.ss));
+	asm volatile ("movw %%es, %0" : "=m" (saved_context.es));
+	asm volatile ("movw %%fs, %0" : "=m" (saved_context.fs));
+	asm volatile ("movw %%gs, %0" : "=m" (saved_context.gs));
+	asm volatile ("movw %%ss, %0" : "=m" (saved_context.ss));
 
 	/*
 	 * control registers 
@@ -95,7 +95,7 @@
 	/*
 	 * eflags
 	 */
-	asm volatile ("pushfl ; popl (%0)" : "=m" (saved_context.eflags));
+	asm volatile ("pushfl ; popl %0" : "=m" (saved_context.eflags));
 }
 
 static void
@@ -125,9 +125,7 @@
 	/*
 	 * first restore %ds, so we can access our data properly
 	 */
-	asm volatile (".align 4");
-	asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
-
+	asm volatile ("movw %0, %%ds" :: "r" (__KERNEL_DS));
 
 	/*
 	 * control registers
@@ -136,7 +134,7 @@
 	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
 	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
 	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
-	
+
 	/*
 	 * segment registers
 	 */
@@ -167,9 +165,9 @@
 	 * now restore the descriptor tables to their proper values
 	 * ltr is done i fix_processor_context().
 	 */
-	asm volatile ("lgdt (%0)" :: "m" (saved_context.gdt_limit));
-	asm volatile ("lidt (%0)" :: "m" (saved_context.idt_limit));
-	asm volatile ("lldt (%0)" :: "m" (saved_context.ldt));
+	asm volatile ("lgdt %0" :: "m" (saved_context.gdt_limit));
+	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));
+	asm volatile ("lldt %0" :: "m" (saved_context.ldt));
 
 	fix_processor_context();
 
--- clean/include/asm-i386/suspend.h	2002-07-23 10:40:05.000000000 +0200
+++ linux-swsusp/include/asm-i386/suspend.h	2002-10-08 12:14:12.000000000 +0200
@@ -15,22 +15,22 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	u32 eax, ebx, ecx, edx;
-	u32 esp, ebp, esi, edi;
-	u16 es, fs, gs, ss;
-	u32 cr0, cr2, cr3, cr4;
+	unsigned long eax, ebx, ecx, edx;
+	unsigned long esp, ebp, esi, edi;
+  	u16 es, fs, gs, ss;
+	unsigned long cr0, cr2, cr3, cr4;
 	u16 gdt_pad;
 	u16 gdt_limit;
-	u32 gdt_base;
+	unsigned long gdt_base;
 	u16 idt_pad;
 	u16 idt_limit;
-	u32 idt_base;
+	unsigned long idt_base;
 	u16 ldt;
 	u16 tss;
-	u32 tr;
-	u32 safety;
-	u32 return_address;
-	u32 eflags;
+	unsigned long tr;
+	unsigned long safety;
+	unsigned long return_address;
+	unsigned long eflags;
 } __attribute__((packed));
 
 #define loaddebug(thread,register) \
@@ -52,11 +52,11 @@
 static inline void acpi_save_register_state(unsigned long return_point)
 {
 	saved_eip = return_point;
-	asm volatile ("movl %%esp,(%0)" : "=m" (saved_esp));
-	asm volatile ("movl %%ebp,(%0)" : "=m" (saved_ebp));
-	asm volatile ("movl %%ebx,(%0)" : "=m" (saved_ebx));
-	asm volatile ("movl %%edi,(%0)" : "=m" (saved_edi));
-	asm volatile ("movl %%esi,(%0)" : "=m" (saved_esi));
+	asm volatile ("movl %%esp,%0" : "=m" (saved_esp));
+	asm volatile ("movl %%ebp,%0" : "=m" (saved_ebp));
+	asm volatile ("movl %%ebx,%0" : "=m" (saved_ebx));
+	asm volatile ("movl %%edi,%0" : "=m" (saved_edi));
+	asm volatile ("movl %%esi,%0" : "=m" (saved_esi));
 }
 
 #define acpi_restore_register_state()  do {} while (0)

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
