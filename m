Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270363AbTGPIXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTGPIX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:23:28 -0400
Received: from dp.samba.org ([66.70.73.150]:931 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270363AbTGPIW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:22:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au, rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Centralize linker-generated symbols.
Date: Wed, 16 Jul 2003 18:15:46 +1000
Message-Id: <20030716083750.83B542C24B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

	Many places define _stext etc: I finally hit a clash.  The
asm/sections.h header seems to be the preferred place.  Unify them,
and make them RTH-compliant.

Name: Centralize linker symbols
Author: Rusty Russell
Status: Trivial

D: Richard Henderson point out a while back that linker generated symbols
D: should be declared as: "char _text[]" so that the compiler can't make
D: assumptions about them sitting in small sections, etc.
D: 
D: Centralize these defintions in asm/sections.h (where some already
D: are on x86).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30655-linux-2.6.0-test1/arch/i386/kernel/setup.c .30655-linux-2.6.0-test1.updated/arch/i386/kernel/setup.c
--- .30655-linux-2.6.0-test1/arch/i386/kernel/setup.c	2003-06-23 10:52:42.000000000 +1000
+++ .30655-linux-2.6.0-test1.updated/arch/i386/kernel/setup.c	2003-07-16 18:09:04.000000000 +1000
@@ -42,6 +42,7 @@
 #include <asm/edd.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
+#include <asm/sections.h>
 #include "setup_arch_pre.h"
 #include "mach_resources.h"
 
@@ -100,7 +101,7 @@ extern void early_cpu_init(void);
 extern void dmi_scan_machine(void);
 extern void generic_apic_probe(char *);
 extern int root_mountflags;
-extern char _text, _etext, _edata, _end;
+extern char _end[];
 
 unsigned long saved_videomode;
 
@@ -676,7 +677,7 @@ static unsigned long __init setup_memory
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
 	 */
-	start_pfn = PFN_UP(__pa(&_end));
+	start_pfn = PFN_UP(__pa(_end));
 
 	find_max_pfn();
 
@@ -947,15 +948,15 @@ void __init setup_arch(char **cmdline_p)
 
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
-	init_mm.start_code = (unsigned long) &_text;
-	init_mm.end_code = (unsigned long) &_etext;
-	init_mm.end_data = (unsigned long) &_edata;
-	init_mm.brk = (unsigned long) &_end;
+	init_mm.start_code = (unsigned long) _text;
+	init_mm.end_code = (unsigned long) _etext;
+	init_mm.end_data = (unsigned long) _edata;
+	init_mm.brk = (unsigned long) _end;
 
-	code_resource.start = virt_to_phys(&_text);
-	code_resource.end = virt_to_phys(&_etext)-1;
-	data_resource.start = virt_to_phys(&_etext);
-	data_resource.end = virt_to_phys(&_edata)-1;
+	code_resource.start = virt_to_phys(_text);
+	code_resource.end = virt_to_phys(_etext)-1;
+	data_resource.start = virt_to_phys(_etext);
+	data_resource.end = virt_to_phys(_edata)-1;
 
 	parse_cmdline_early(cmdline_p);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30655-linux-2.6.0-test1/arch/i386/mm/init.c .30655-linux-2.6.0-test1.updated/arch/i386/mm/init.c
--- .30655-linux-2.6.0-test1/arch/i386/mm/init.c	2003-06-23 10:52:42.000000000 +1000
+++ .30655-linux-2.6.0-test1.updated/arch/i386/mm/init.c	2003-07-16 18:09:04.000000000 +1000
@@ -565,7 +565,7 @@ void free_initmem(void)
 		free_page(addr);
 		totalram_pages++;
 	}
-	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
+	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30655-linux-2.6.0-test1/include/asm-generic/sections.h .30655-linux-2.6.0-test1.updated/include/asm-generic/sections.h
--- .30655-linux-2.6.0-test1/include/asm-generic/sections.h	2003-01-02 12:24:26.000000000 +1100
+++ .30655-linux-2.6.0-test1.updated/include/asm-generic/sections.h	2003-07-16 18:09:54.000000000 +1000
@@ -3,9 +3,10 @@
 
 /* References to section boundaries */
 
-extern char _text, _etext;
-extern char _data, _edata;
-extern char __bss_start;
-extern char __init_begin, __init_end;
+extern char _text[], _stext[], _etext[];
+extern char _data[], _sdata[], _edata[];
+extern char __bss_start[];
+extern char __init_begin[], __init_end[];
+extern char _sinittext[], _einittext[];
 
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30655-linux-2.6.0-test1/include/asm-i386/hw_irq.h .30655-linux-2.6.0-test1.updated/include/asm-i386/hw_irq.h
--- .30655-linux-2.6.0-test1/include/asm-i386/hw_irq.h	2003-03-25 12:17:28.000000000 +1100
+++ .30655-linux-2.6.0-test1.updated/include/asm-i386/hw_irq.h	2003-07-16 18:09:04.000000000 +1000
@@ -16,6 +16,7 @@
 #include <linux/profile.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
+#include <asm/sections.h>
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
@@ -63,8 +64,6 @@ extern unsigned long io_apic_irqs;
 extern atomic_t irq_err_count;
 extern atomic_t irq_mis_count;
 
-extern char _stext, _etext;
-
 #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
 
 /*
@@ -95,7 +94,7 @@ static inline void x86_do_profile(struct
 	if (!((1<<smp_processor_id()) & prof_cpu_mask))
 		return;
 
-	eip -= (unsigned long) &_stext;
+	eip -= (unsigned long)_stext;
 	eip >>= prof_shift;
 	/*
 	 * Don't ignore out-of-bounds EIP values silently,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30655-linux-2.6.0-test1/kernel/extable.c .30655-linux-2.6.0-test1.updated/kernel/extable.c
--- .30655-linux-2.6.0-test1/kernel/extable.c	2003-04-20 18:05:15.000000000 +1000
+++ .30655-linux-2.6.0-test1.updated/kernel/extable.c	2003-07-16 18:09:53.000000000 +1000
@@ -17,10 +17,10 @@
 */
 #include <linux/module.h>
 #include <asm/uaccess.h>
+#include <asm/sections.h>
 
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
-extern char _stext[], _etext[], _sinittext[], _einittext[];
 
 /* Given an address, look for it in the exception tables. */
 const struct exception_table_entry *search_exception_tables(unsigned long addr)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30655-linux-2.6.0-test1/kernel/profile.c .30655-linux-2.6.0-test1.updated/kernel/profile.c
--- .30655-linux-2.6.0-test1/kernel/profile.c	2003-02-25 10:11:11.000000000 +1100
+++ .30655-linux-2.6.0-test1.updated/kernel/profile.c	2003-07-16 18:09:04.000000000 +1000
@@ -8,8 +8,7 @@
 #include <linux/bootmem.h>
 #include <linux/notifier.h>
 #include <linux/mm.h>
-
-extern char _stext, _etext;
+#include <asm/sections.h>
 
 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -36,7 +35,7 @@ void __init profile_init(void)
 		return;
  
 	/* only text is profiled */
-	prof_len = (unsigned long) &_etext - (unsigned long) &_stext;
+	prof_len = _etext - _stext;
 	prof_len >>= prof_shift;
 		
 	size = prof_len * sizeof(unsigned int) + PAGE_SIZE - 1;
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
