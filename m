Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSKJNQX>; Sun, 10 Nov 2002 08:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSKJNQX>; Sun, 10 Nov 2002 08:16:23 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13572 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264856AbSKJNQR>;
	Sun, 10 Nov 2002 08:16:17 -0500
Date: Sun, 10 Nov 2002 14:21:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: swsusp critical code rewritten to assembly
Message-ID: <20021110132122.GA364@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

do_magic was really too fragile to be written in C. This patch
rewrites it into assembly, to make sure C compiler does not generate
stack access and corrupt memory that way. Plus it cleans up suspend.c
a bit, makes it really free memory it needs, an no longer calls
drivers from atomic context.

Please apply,
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
--- clean/arch/i386/kernel/suspend.c	2002-11-01 00:37:05.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend.c	2002-11-07 18:35:10.000000000 +0100
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
@@ -106,6 +69,109 @@
         kernel_fpu_end();
 }
 
+void restore_processor_state(void)
+{
+
+	/*
+	 * control registers
+	 */
+	asm volatile ("movl %0, %%cr4" :: "r" (saved_context.cr4));
+	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
+	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
+	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %0, %%es" :: "r" (saved_context.es));
+	asm volatile ("movw %0, %%fs" :: "r" (saved_context.fs));
+	asm volatile ("movw %0, %%gs" :: "r" (saved_context.gs));
+	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
+
+	/*
+	 * now restore the descriptor tables to their proper values
+	 * ltr is done i fix_processor_context().
+	 */
+	asm volatile ("lgdt %0" :: "m" (saved_context.gdt_limit));
+	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));
+	asm volatile ("lldt %0" :: "m" (saved_context.ldt));
+
+	fix_processor_context();
+	do_fpu_end();
+}
+
+void fix_processor_context(void)
+{
+	int cpu = smp_processor_id();
+	struct tss_struct * t = init_tss + cpu;
+
+	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
+
+	load_TR_desc();				/* This does ltr */
+	load_LDT(&current->mm->context);	/* This does lldt */
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
+/*
+ * save_processor_context
+ * 
+ * Save the state of the processor before we go to sleep.
+ *
+ * return_stack is the value of the stack pointer (%esp) as the caller sees it.
+ * A good way could not be found to obtain it from here (don't want to make _too_
+ * many assumptions about the layout of the stack this far down.) Also, the 
+ * handy little __builtin_frame_pointer(level) where level > 0, is blatantly 
+ * buggy - it returns the value of the stack at the proper location, not the 
+ * location, like it should (as of gcc 2.91.66)
+ * 
+ * Note that the context and timing of this function is pretty critical.
+ * With a minimal amount of things going on in the caller and in here, gcc
+ * does a good job of being just a dumb compiler.  Watch the assembly output
+ * if anything changes, though, and make sure everything is going in the right
+ * place. 
+ */
+static inline void save_processor_context (void)
+{
+	save_processor_state();
+
+	/*
+	 * save the general registers.
+	 * note that gcc has constructs to specify output of certain registers,
+	 * but they're not used here, because it assumes that you want to modify
+	 * those registers, so it tries to be smart and save them beforehand.
+	 * It's really not necessary, and kinda fishy (check the assembly output),
+	 * so it's avoided. 
+	 */
+	asm volatile ("movl %%esp, %0" : "=m" (saved_context_esp));
+	asm volatile ("movl %%eax, %0" : "=m" (saved_context_eax));
+	asm volatile ("movl %%ebx, %0" : "=m" (saved_context_ebx));
+	asm volatile ("movl %%ecx, %0" : "=m" (saved_context_ecx));
+	asm volatile ("movl %%edx, %0" : "=m" (saved_context_edx));
+	asm volatile ("movl %%ebp, %0" : "=m" (saved_context_ebp));
+	asm volatile ("movl %%esi, %0" : "=m" (saved_context_esi));
+	asm volatile ("movl %%edi, %0" : "=m" (saved_context_edi));
+	/* FIXME: Need to save XMM0..XMM15? */
+
+	/*
+	 * eflags
+	 */
+	asm volatile ("pushfl ; popl %0" : "=m" (saved_context_eflags));
+}
+
 /*
  * restore_processor_context
  * 
@@ -126,23 +192,6 @@
 	 * first restore %ds, so we can access our data properly
 	 */
 	asm volatile ("movw %0, %%ds" :: "r" (__KERNEL_DS));
-
-	/*
-	 * control registers
-	 */
-	asm volatile ("movl %0, %%cr4" :: "r" (saved_context.cr4));
-	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
-	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
-	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
-
-	/*
-	 * segment registers
-	 */
-	asm volatile ("movw %0, %%es" :: "r" (saved_context.es));
-	asm volatile ("movw %0, %%fs" :: "r" (saved_context.fs));
-	asm volatile ("movw %0, %%gs" :: "r" (saved_context.gs));
-	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
-
 	/*
 	 * the other general registers
 	 *
@@ -152,31 +201,21 @@
 	 * bad since we don't have a stack set up when we enter, and we 
 	 * want to preserve the values on exit. So, we set them manually.
 	 */
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
-	 * now restore the descriptor tables to their proper values
-	 * ltr is done i fix_processor_context().
-	 */
-	asm volatile ("lgdt %0" :: "m" (saved_context.gdt_limit));
-	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));
-	asm volatile ("lldt %0" :: "m" (saved_context.ldt));
+	asm volatile ("movl %0, %%esp" :: "m" (saved_context_esp));
+	asm volatile ("movl %0, %%ebp" :: "m" (saved_context_ebp));
+	asm volatile ("movl %0, %%eax" :: "m" (saved_context_eax));
+	asm volatile ("movl %0, %%ebx" :: "m" (saved_context_ebx));
+	asm volatile ("movl %0, %%ecx" :: "m" (saved_context_ecx));
+	asm volatile ("movl %0, %%edx" :: "m" (saved_context_edx));
+	asm volatile ("movl %0, %%esi" :: "m" (saved_context_esi));
+	asm volatile ("movl %0, %%edi" :: "m" (saved_context_edi));
 
-	fix_processor_context();
+	restore_processor_state();
 
 	/*
 	 * the flags
 	 */
-	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context.eflags));
-
-	do_fpu_end();
+	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context_eflags));
 }
 
 #ifdef CONFIG_ACPI_SLEEP
@@ -197,41 +236,18 @@
 acpi_sleep_done:
 	acpi_restore_register_state();
 	restore_processor_context();
+	printk(KERN_CRIT  "do_suspend_lowlevel okay\n");
+	mdelay(1000);
 }
 #endif
 
-void fix_processor_context(void)
-{
-	int cpu = smp_processor_id();
-	struct tss_struct * t = init_tss + cpu;
-
-	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
-        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
-
-	load_TR_desc();				/* This does ltr */
-	load_LDT(&current->mm->context);	/* This does lldt */
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
-}
-
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 /* Local variables for do_magic */
-static int loop __nosavedata = 0;
-static int loop2 __nosavedata = 0;
+int loop __nosavedata = 0;
+int loop2 __nosavedata = 0;
 
+#if 0
 /*
  * (KG): Since we affect stack here, we make this function as flat and easy
  * as possible in order to not provoke gcc to use local variables on the stack.
@@ -300,3 +316,4 @@
 	do_magic_resume_2();
 }
 #endif
+#endif
--- clean/arch/i386/kernel/suspend_asm.S	2002-11-07 18:26:08.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend_asm.S	2002-11-07 18:34:43.000000000 +0100
@@ -0,0 +1,87 @@
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
+#APP
+	movl %esp, saved_context_esp
+	movl %eax, saved_context_eax
+	movl %ebx, saved_context_ebx
+	movl %ecx, saved_context_ecx
+	movl %edx, saved_context_edx
+	movl %ebp, saved_context_ebp
+	movl %esi, saved_context_esi
+	movl %edi, saved_context_edi
+	pushfl ; popl saved_context_eflags
+#NO_APP
+	call do_magic_suspend_2
+	jmp .L1449
+	.p2align 4,,7
+.L1450:
+	movl $swapper_pg_dir-__PAGE_OFFSET,%ecx
+#APP
+	movl %ecx,%cr3
+
+#NO_APP
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
+#APP
+	movl %cr3, %eax;              
+movl %eax, %cr3;  # flush TLB 
+
+#NO_APP
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
+#APP
+	movw %eax, %ds
+	movl saved_context_esp, %esp
+	movl saved_context_ebp, %ebp
+	movl saved_context_eax, %eax
+	movl saved_context_ebx, %ebx
+	movl saved_context_ecx, %ecx
+	movl saved_context_edx, %edx
+	movl saved_context_esi, %esi
+	movl saved_context_edi, %edi
+#NO_APP
+	call restore_processor_state
+#APP
+	pushl saved_context_eflags ; popfl
+#NO_APP
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
--- clean/kernel/suspend.c	2002-11-01 00:37:42.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-08 11:37:06.000000000 +0100
@@ -235,6 +235,7 @@
 	} while(todo);
 	
 	printk( "|\n" );
+	BUG_ON(in_atomic());
 	return 0;
 }
 
@@ -489,7 +490,6 @@
 			if (PageNosave(page))
 				continue;
 
-
 			if ((chunk_size=is_head_of_free_region(page))!=0) {
 				pfn += chunk_size - 1;
 				continue;
@@ -500,9 +500,8 @@
 			/*
 			 * Just copy whole code segment. Hopefully it is not that big.
 			 */
-			if (ADDRESS(pfn) >= (unsigned long)
-				&__nosave_begin && ADDRESS(pfn) < 
-				(unsigned long)&__nosave_end) {
+			if ((ADDRESS(pfn) >= (unsigned long) &__nosave_begin) && 
+			    (ADDRESS(pfn) <  (unsigned long) &__nosave_end)) {
 				PRINTK("[nosave %x]", ADDRESS(pfn));
 				continue;
 			}
@@ -623,7 +623,7 @@
 static void free_some_memory(void)
 {
 	printk("Freeing memory: ");
-	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
+	while (shrink_all_memory(10000))
 		printk(".");
 	printk("|\n");
 }
@@ -676,7 +676,7 @@
 	}
 }
 
-static int suspend_save_image(void)
+static int suspend_prepare_image(void)
 {
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
@@ -725,9 +725,15 @@
 	 *
 	 * Following line enforces not writing to disk until we choose.
 	 */
-	drivers_unsuspend();
-	spin_unlock_irq(&suspend_pagedir_lock);
+
 	printk( "critical section/: done (%d pages copied)\n", nr_copy_pages );
+	spin_unlock_irq(&suspend_pagedir_lock);
+	return 0;
+}
+
+void suspend_save_image(void)
+{
+	drivers_unsuspend();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -738,7 +744,6 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-	return 0;
 }
 
 void suspend_power_down(void)
@@ -788,8 +793,8 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
-	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
+	drivers_resume(RESUME_ALL_PHASES);
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -804,14 +809,17 @@
 {
 	mb();
 	barrier();
+	BUG_ON(in_atomic());
 	spin_lock_irq(&suspend_pagedir_lock);
 }
 
 void do_magic_suspend_2(void)
 {
 	read_swapfiles();
-	if (!suspend_save_image())
+	if (!suspend_prepare_image()) {	/* suspend_save_image realeses suspend_pagedir_lock */
+		suspend_save_image();
 		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
+	}
 
 	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
 	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
