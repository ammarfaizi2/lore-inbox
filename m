Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbSKLRnc>; Tue, 12 Nov 2002 12:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266769AbSKLRnb>; Tue, 12 Nov 2002 12:43:31 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11268 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266716AbSKLRnJ>;
	Tue, 12 Nov 2002 12:43:09 -0500
Date: Tue, 12 Nov 2002 18:49:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: rewrite critical parts to assembly
Message-ID: <20021112174915.GA5133@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This rewrites parts that can not be safely written in C to
assembly. This time with S3 code, too, so you no longer see moves to
%esp in C code. Please apply,
								Pavel

--- clean/arch/i386/kernel/Makefile	2002-10-20 16:22:31.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/Makefile	2002-11-07 18:26:45.000000000 +0100
@@ -25,7 +25,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
--- clean/arch/i386/kernel/acpi_wakeup.S	2002-06-03 11:43:27.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-11-12 18:27:42.000000000 +0100
@@ -262,6 +267,48 @@
 
 ENTRY(saved_magic)	.long	0
 
+ENTRY(do_suspend_lowlevel)
+	cmpl $0,4(%esp)
+	jne .L1432
+	call save_processor_state
+
+	movl %esp, saved_context_esp
+	movl %eax, saved_context_eax
+	movl %ebx, saved_context_ebx
+	movl %ecx, saved_context_ecx
+	movl %edx, saved_context_edx
+	movl %ebp, saved_context_ebp
+	movl %esi, saved_context_esi
+	movl %edi, saved_context_edi
+	pushfl ; popl saved_context_eflags
+
+	movl $.L1432,saved_eip
+	movl %esp,saved_esp
+	movl %ebp,saved_ebp
+	movl %ebx,saved_ebx
+	movl %edi,saved_edi
+	movl %esi,saved_esi
+
+	pushl $3
+	call acpi_enter_sleep_state
+	addl $4,%esp
+	ret
+	.p2align 4,,7
+.L1432:
+	movl $104,%eax
+	movw %eax, %ds
+	movl saved_context_esp, %esp
+	movl saved_context_ebp, %ebp
+	movl saved_context_eax, %eax
+	movl saved_context_ebx, %ebx
+	movl saved_context_ecx, %ecx
+	movl saved_context_edx, %edx
+	movl saved_context_esi, %esi
+	movl saved_context_edi, %edi
+	call restore_processor_state
+	pushl saved_context_eflags ; popfl
+	ret
+
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
--- clean/arch/i386/kernel/suspend.c	2002-11-01 00:37:05.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend.c	2002-11-12 18:12:40.000000000 +0100
@@ -28,26 +28,11 @@
 #include <asm/tlbflush.h>
 
 static struct saved_context saved_context;
+unsigned long saved_context_eax, saved_context_ebx, saved_context_ecx, saved_context_edx;
+unsigned long saved_context_esp, saved_context_ebp, saved_context_esi, saved_context_edi;
+unsigned long saved_context_eflags;
 
-/*
- * save_processor_context
- * 
- * Save the state of the processor before we go to sleep.
- *
- * return_stack is the value of the stack pointer (%esp) as the caller sees it.
- * A good way could not be found to obtain it from here (don't want to make _too_
- * many assumptions about the layout of the stack this far down.) Also, the 
- * handy little __builtin_frame_pointer(level) where level > 0, is blatantly 
- * buggy - it returns the value of the stack at the proper location, not the 
- * location, like it should (as of gcc 2.91.66)
- * 
- * Note that the context and timing of this function is pretty critical.
- * With a minimal amount of things going on in the caller and in here, gcc
- * does a good job of being just a dumb compiler.  Watch the assembly output
- * if anything changes, though, and make sure everything is going in the right
- * place. 
- */
-static inline void save_processor_context (void)
+void save_processor_state(void)
 {
 	kernel_fpu_begin();
 
@@ -60,23 +45,6 @@
 	asm volatile ("str %0"  : "=m" (saved_context.tr));
 
 	/*
-	 * save the general registers.
-	 * note that gcc has constructs to specify output of certain registers,
-	 * but they're not used here, because it assumes that you want to modify
-	 * those registers, so it tries to be smart and save them beforehand.
-	 * It's really not necessary, and kinda fishy (check the assembly output),
-	 * so it's avoided. 
-	 */
-	asm volatile ("movl %%esp, %0" : "=m" (saved_context.esp));
-	asm volatile ("movl %%eax, %0" : "=m" (saved_context.eax));
-	asm volatile ("movl %%ebx, %0" : "=m" (saved_context.ebx));
-	asm volatile ("movl %%ecx, %0" : "=m" (saved_context.ecx));
-	asm volatile ("movl %%edx, %0" : "=m" (saved_context.edx));
-	asm volatile ("movl %%ebp, %0" : "=m" (saved_context.ebp));
-	asm volatile ("movl %%esi, %0" : "=m" (saved_context.esi));
-	asm volatile ("movl %%edi, %0" : "=m" (saved_context.edi));
-	/* FIXME: Need to save XMM0..XMM15? */
-	/*
 	 * segment registers
 	 */
 	asm volatile ("movw %%es, %0" : "=m" (saved_context.es));
@@ -91,11 +59,6 @@
 	asm volatile ("movl %%cr2, %0" : "=r" (saved_context.cr2));
 	asm volatile ("movl %%cr3, %0" : "=r" (saved_context.cr3));
 	asm volatile ("movl %%cr4, %0" : "=r" (saved_context.cr4));
-
-	/*
-	 * eflags
-	 */
-	asm volatile ("pushfl ; popl %0" : "=m" (saved_context.eflags));
 }
 
 static void
@@ -106,26 +69,8 @@
         kernel_fpu_end();
 }
 
-/*
- * restore_processor_context
- * 
- * Restore the processor context as it was before we went to sleep
- * - descriptor tables
- * - control registers
- * - segment registers
- * - flags
- * 
- * Note that it is critical that this function is declared inline.  
- * It was separated out from restore_state to make that function
- * a little clearer, but it needs to be inlined because we won't have a
- * stack when we get here (so we can't push a return address).
- */
-static inline void restore_processor_context (void)
+void restore_processor_state(void)
 {
-	/*
-	 * first restore %ds, so we can access our data properly
-	 */
-	asm volatile ("movw %0, %%ds" :: "r" (__KERNEL_DS));
 
 	/*
 	 * control registers
@@ -144,24 +89,6 @@
 	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
 
 	/*
-	 * the other general registers
-	 *
-	 * note that even though gcc has constructs to specify memory 
-	 * input into certain registers, it will try to be too smart
-	 * and save them at the beginning of the function.  This is esp.
-	 * bad since we don't have a stack set up when we enter, and we 
-	 * want to preserve the values on exit. So, we set them manually.
-	 */
-	asm volatile ("movl %0, %%esp" :: "m" (saved_context.esp));
-	asm volatile ("movl %0, %%ebp" :: "m" (saved_context.ebp));
-	asm volatile ("movl %0, %%eax" :: "m" (saved_context.eax));
-	asm volatile ("movl %0, %%ebx" :: "m" (saved_context.ebx));
-	asm volatile ("movl %0, %%ecx" :: "m" (saved_context.ecx));
-	asm volatile ("movl %0, %%edx" :: "m" (saved_context.edx));
-	asm volatile ("movl %0, %%esi" :: "m" (saved_context.esi));
-	asm volatile ("movl %0, %%edi" :: "m" (saved_context.edi));
-
-	/*
 	 * now restore the descriptor tables to their proper values
 	 * ltr is done i fix_processor_context().
 	 */
@@ -170,42 +97,15 @@
 	asm volatile ("lldt %0" :: "m" (saved_context.ldt));
 
 	fix_processor_context();
-
-	/*
-	 * the flags
-	 */
-	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context.eflags));
-
 	do_fpu_end();
 }
 
-#ifdef CONFIG_ACPI_SLEEP
-void do_suspend_lowlevel(int resume)
-{
-/*
- * FIXME: This function should really be written in assembly. Actually
- * requirement is that it does not touch stack, because %esp will be
- * wrong during resume before restore_processor_context(). Check
- * assembly if you modify this.
- */
-	if (!resume) {
-		save_processor_context();
-		acpi_save_register_state((unsigned long)&&acpi_sleep_done);
-		acpi_enter_sleep_state(3);
-		return;
-	}
-acpi_sleep_done:
-	acpi_restore_register_state();
-	restore_processor_context();
-}
-#endif
-
 void fix_processor_context(void)
 {
 	int cpu = smp_processor_id();
 	struct tss_struct * t = init_tss + cpu;
 
-	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
         cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
@@ -226,77 +126,9 @@
 
 }
 
-
 #ifdef CONFIG_SOFTWARE_SUSPEND
 /* Local variables for do_magic */
-static int loop __nosavedata = 0;
-static int loop2 __nosavedata = 0;
-
-/*
- * (KG): Since we affect stack here, we make this function as flat and easy
- * as possible in order to not provoke gcc to use local variables on the stack.
- * Note that on resume, all (expect nosave) variables will have the state from
- * the time of writing (suspend_save_image) and the registers (including the
- * stack pointer, but excluding the instruction pointer) will be loaded with 
- * the values saved at save_processor_context() time.
- */
-void do_magic(int resume)
-{
-	/* DANGER WILL ROBINSON!
-	 *
-	 * If this function is too difficult for gcc to optimize, it will crash and burn!
-	 * see above.
-	 *
-	 * DO NOT TOUCH.
-	 */
-
-	if (!resume) {
-		do_magic_suspend_1();
-		save_processor_context();	/* We need to capture registers and memory at "same time" */
-		do_magic_suspend_2();		/* If everything goes okay, this function does not return */
-		return;
-	}
+int loop __nosavedata = 0;
+int loop2 __nosavedata = 0;
 
-	/* We want to run from swapper_pg_dir, since swapper_pg_dir is stored in constant
-	 * place in memory 
-	 */
-
-        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
-
-/*
- * Final function for resuming: after copying the pages to their original
- * position, it restores the register state.
- *
- * What about page tables? Writing data pages may toggle
- * accessed/dirty bits in our page tables. That should be no problems
- * with 4MB page tables. That's why we require have_pse.  
- *
- * This loops destroys stack from under itself, so it better should
- * not use any stack space, itself. When this function is entered at
- * resume time, we move stack to _old_ place.  This is means that this
- * function must use no stack and no local variables in registers,
- * until calling restore_processor_context();
- *
- * Critical section here: noone should touch saved memory after
- * do_magic_resume_1; copying works, because nr_copy_pages,
- * pagedir_nosave, loop and loop2 are nosavedata.
- */
-	do_magic_resume_1();
-
-	for (loop=0; loop < nr_copy_pages; loop++) {
-		/* You may not call something (like copy_page) here: see above */
-		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
-			*(((char *)((pagedir_nosave+loop)->orig_address))+loop2) =
-				*(((char *)((pagedir_nosave+loop)->address))+loop2);
-			__flush_tlb();
-		}
-	}
-
-	restore_processor_context();
-
-/* Ahah, we now run with our old stack, and with registers copied from
-   suspend time */
-
-	do_magic_resume_2();
-}
 #endif
--- clean/arch/i386/kernel/suspend_asm.S	2002-11-07 18:26:08.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend_asm.S	2002-11-12 18:24:13.000000000 +0100
@@ -0,0 +1,80 @@
+.text
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+
+ENTRY(do_magic):
+	pushl %ebx
+	cmpl $0,8(%esp)
+	jne .L1450
+	call do_magic_suspend_1
+	call save_processor_state
+
+	movl %esp, saved_context_esp
+	movl %eax, saved_context_eax
+	movl %ebx, saved_context_ebx
+	movl %ecx, saved_context_ecx
+	movl %edx, saved_context_edx
+	movl %ebp, saved_context_ebp
+	movl %esi, saved_context_esi
+	movl %edi, saved_context_edi
+	pushfl ; popl saved_context_eflags
+
+	call do_magic_suspend_2
+	jmp .L1449
+	.p2align 4,,7
+.L1450:
+	movl $swapper_pg_dir-__PAGE_OFFSET,%ecx
+	movl %ecx,%cr3
+
+	call do_magic_resume_1
+	movl $0,loop
+	cmpl $0,nr_copy_pages
+	je .L1453
+	.p2align 4,,7
+.L1455:
+	movl $0,loop2
+	.p2align 4,,7
+.L1459:
+	movl pagedir_nosave,%ecx
+	movl loop,%eax
+	movl loop2,%edx
+	sall $4,%eax
+	movl 4(%ecx,%eax),%ebx
+	movl (%ecx,%eax),%eax
+	movb (%edx,%eax),%al
+	movb %al,(%edx,%ebx)
+	movl %cr3, %eax;              
+	movl %eax, %cr3;  # flush TLB 
+
+	movl loop2,%eax
+	leal 1(%eax),%edx
+	movl %edx,loop2
+	movl %edx,%eax
+	cmpl $4095,%eax
+	jbe .L1459
+	movl loop,%eax
+	leal 1(%eax),%edx
+	movl %edx,loop
+	movl %edx,%eax
+	cmpl nr_copy_pages,%eax
+	jb .L1455
+	.p2align 4,,7
+.L1453:
+	movl $104,%eax
+
+	movw %eax, %ds
+	movl saved_context_esp, %esp
+	movl saved_context_ebp, %ebp
+	movl saved_context_eax, %eax
+	movl saved_context_ebx, %ebx
+	movl saved_context_ecx, %ecx
+	movl saved_context_edx, %edx
+	movl saved_context_esi, %esi
+	movl saved_context_edi, %edi
+	call restore_processor_state
+	pushl saved_context_eflags ; popfl
+	call do_magic_resume_2
+.L1449:
+	popl %ebx
+	ret


--- clean/include/asm-i386/suspend.h	2002-11-01 00:37:39.000000000 +0100
+++ linux-swsusp/include/asm-i386/suspend.h	2002-11-07 17:57:46.000000000 +0100
@@ -15,8 +15,6 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	unsigned long eax, ebx, ecx, edx;
-	unsigned long esp, ebp, esi, edi;
   	u16 es, fs, gs, ss;
 	unsigned long cr0, cr2, cr3, cr4;
 	u16 gdt_pad;
@@ -30,9 +28,14 @@
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
-	unsigned long eflags;
 } __attribute__((packed));
 
+/* We'll access these from assembly, so we'd better have them outside struct */
+extern unsigned long saved_context_eax, saved_context_ebx, saved_context_ecx, saved_context_edx;
+extern unsigned long saved_context_esp, saved_context_ebp, saved_context_esi, saved_context_edi;
+extern unsigned long saved_context_eflags;
+
+
 #define loaddebug(thread,register) \
                __asm__("movl %0,%%db" #register  \
                        : /* no output */ \

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
