Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319074AbSHSUd4>; Mon, 19 Aug 2002 16:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319077AbSHSUd4>; Mon, 19 Aug 2002 16:33:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10681 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319074AbSHSUdk>; Mon, 19 Aug 2002 16:33:40 -0400
Message-ID: <3D615708.1010500@us.ibm.com>
Date: Mon, 19 Aug 2002 13:37:28 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, linux-mm@us.ibm.com,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: [PATCH] make PAGE_OFFSET config option on x86
Content-Type: multipart/mixed;
 boundary="------------030205050609010707080408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030205050609010707080408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Whether they're a user that is doing a scientific application that 
needs more than 3GB, or a large PAE machine that needs more 
ZONE_NORMAL, lots of people are applying patches to change 
PAGE_OFFSET.  This patch lets you do it in a config option.  It is a 
port from Andrea's 2.4 tree, and I believe that Ingo is the original 
author.

Andrea's patch didn't have a Config.help entry for this option, so I 
wrote one.  I may not have all of the necessary context to explain it, 
so any comments there would be appreciated.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------030205050609010707080408
Content-Type: text/plain;
 name="page_offset-config-2.5.31+bk-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="page_offset-config-2.5.31+bk-0.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.489   -> 1.491  
#	include/asm-i386/processor.h	1.28    -> 1.29   
#	arch/i386/Config.help	1.12    -> 1.13   
#	include/asm-i386/page.h	1.15    -> 1.16   
#	arch/i386/vmlinux.lds	1.9     ->         (deleted)      
#	 arch/i386/config.in	1.46    -> 1.47   
#	  arch/i386/Makefile	1.16    -> 1.17   
#	          Rules.make	1.68    -> 1.69   
#	         mm/memory.c	1.83    -> 1.85   
#	               (new)	        -> 1.1     arch/i386/vmlinux.lds.S
#	               (new)	        -> 1.1     include/asm-i386/page_offset.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/19	haveblue@elm3b96.(none)	1.490
# merge Andrea's PAGE_OFFSET configuration option
# --------------------------------------------
# 02/08/19	haveblue@elm3b96.(none)	1.491
# fix merge bug
# 
# add Config.help entry
# --------------------------------------------
#
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Mon Aug 19 13:28:19 2002
+++ b/Rules.make	Mon Aug 19 13:28:19 2002
@@ -149,12 +149,29 @@
 #
 # Added the SMP separator to stop module accidents between uniprocessor
 # and SMP Intel boxes - AC - from bits by Michael Chastain
+# Added separator for different PAGE_OFFSET memory models - Ingo.
 #
 
 ifdef CONFIG_SMP
 	genksyms_smp_prefix := -p smp_
 else
 	genksyms_smp_prefix := 
+endif
+
+ifdef CONFIG_2GB
+ifdef CONFIG_SMP
+	genksyms_smp_prefix := -p smp_2gig_
+else
+	genksyms_smp_prefix := -p 2gig_
+endif
+endif
+
+ifdef CONFIG_3GB
+ifdef CONFIG_SMP
+	genksyms_smp_prefix := -p smp_3gig_
+else
+	genksyms_smp_prefix := -p 3gig_
+endif
 endif
 
 #	Don't include modversions.h, we're just about to generate it here.
diff -Nru a/arch/i386/Config.help b/arch/i386/Config.help
--- a/arch/i386/Config.help	Mon Aug 19 13:28:19 2002
+++ b/arch/i386/Config.help	Mon Aug 19 13:28:19 2002
@@ -128,6 +128,27 @@
 
   If unsure, say "off".
 
+CONFIG_1GB
+  On i386, a process can only virtually address 4GB of memory.  This
+  lets you select how much of that virtual space you would like to 
+  devoted to userspace, and how much to the kernel.  
+  
+  Some userspace programs would like to address as much as possible and 
+  have few demands of the kernel other than it get out of the way.  These
+  users may opt to use the 3.5GB option to give their userspace program 
+  as much room as possible.  Due to alignment issues imposed by PAE, 
+  the "3.5GB" option is unavailable if "64GB" high memory support is 
+  enabled.
+
+  Other users (especially those who use PAE) may be running out of
+  ZONE_NORMAL memory.  Those users may benefit from increasing the
+  kernel's virtual address space size by taking it away from userspace, 
+  which may not need all of its space.  An indicator that this is 
+  happening is when /proc/Meminfo's "LowFree:" is a small percentage of
+  "LowTotal:" while "HighFree:" is very large.
+
+  If unsure, say "3GB"
+  
 CONFIG_HIGHPTE
   The VM uses one page table entry for each page of physical memory.
   For systems with a lot of RAM, this can be wasteful of precious
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Aug 19 13:28:19 2002
+++ b/arch/i386/Makefile	Mon Aug 19 13:28:19 2002
@@ -104,6 +104,9 @@
 
 MAKEBOOT = +$(MAKE) -C arch/$(ARCH)/boot
 
+arch/i386/vmlinux.lds: arch/i386/vmlinux.lds.S FORCE
+	$(CPP) -C -P -I$(HPATH) -imacros $(HPATH)/asm-i386/page_offset.h -Ui386 arch/i386/vmlinux.lds.S >arch/i386/vmlinux.lds
+
 vmlinux: arch/i386/vmlinux.lds
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
@@ -141,3 +144,4 @@
 	@$(MAKEBOOT) clean
 
 archmrproper:
+	rm -f arch/i386/vmlinux.lds
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Mon Aug 19 13:28:19 2002
+++ b/arch/i386/config.in	Mon Aug 19 13:28:19 2002
@@ -186,14 +186,24 @@
 	 4GB           CONFIG_HIGHMEM4G \
 	 64GB          CONFIG_HIGHMEM64G" off
 
-if [ "$CONFIG_HIGHMEM4G" = "y" ]; then
+if [ "$CONFIG_HIGHMEM4G" = "y" -o "$CONFIG_HIGHMEM64G" = "y" ]; then
    define_bool CONFIG_HIGHMEM y
 fi
 
 if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
-   define_bool CONFIG_HIGHMEM y
    define_bool CONFIG_X86_PAE y
+   choice 'User address space size' \
+	"3GB		CONFIG_1GB \
+	 2GB		CONFIG_2GB \
+	 1GB		CONFIG_3GB" 3GB
+else
+   choice 'User address space size' \
+	"3GB		CONFIG_1GB \
+ 	 2GB		CONFIG_2GB \
+	 1GB		CONFIG_3GB \
+	 3.5GB		CONFIG_05GB" 3GB
 fi
+	 
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
diff -Nru a/arch/i386/vmlinux.lds b/arch/i386/vmlinux.lds
--- a/arch/i386/vmlinux.lds	Mon Aug 19 13:28:19 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,101 +0,0 @@
-/* ld script to make i386 Linux kernel
- * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
- */
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
-OUTPUT_ARCH(i386)
-ENTRY(_start)
-jiffies = jiffies_64;
-SECTIONS
-{
-  . = 0xC0000000 + 0x100000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x9090
-
-  _etext = .;			/* End of text section */
-
-  .rodata : { *(.rodata) *(.rodata.*) }
-  .kstrtab : { *(.kstrtab) }
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
-  }
-  __initcall_end = .;
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-
-  . = ALIGN(4096);
-  __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
-  . = ALIGN(4096);
-  __nosave_end = .;
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  _end = . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-	*(.text.exit)
-	*(.data.exit)
-	*(.exitcall.exit)
-	}
-
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/vmlinux.lds.S	Mon Aug 19 13:28:19 2002
@@ -0,0 +1,101 @@
+/* ld script to make i386 Linux kernel
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
+ */
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+jiffies = jiffies_64;
+SECTIONS
+{
+  . = PAGE_OFFSET_RAW + 0x100000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x9090
+
+  _etext = .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
+
+  /* Sections to be discarded */
+  /DISCARD/ : {
+	*(.text.exit)
+	*(.data.exit)
+	*(.exitcall.exit)
+	}
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}
diff -Nru a/include/asm-i386/page.h b/include/asm-i386/page.h
--- a/include/asm-i386/page.h	Mon Aug 19 13:28:19 2002
+++ b/include/asm-i386/page.h	Mon Aug 19 13:28:19 2002
@@ -81,7 +81,9 @@
  * and CONFIG_HIGHMEM64G options in the kernel configuration.
  */
 
-#define __PAGE_OFFSET		(0xC0000000)
+#include <asm/page_offset.h>
+
+#define __PAGE_OFFSET		(PAGE_OFFSET_RAW)
 
 /*
  * This much address space is reserved for vmalloc() and iomap()
diff -Nru a/include/asm-i386/page_offset.h b/include/asm-i386/page_offset.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/page_offset.h	Mon Aug 19 13:28:19 2002
@@ -0,0 +1,10 @@
+#include <linux/config.h>
+#ifdef CONFIG_05GB
+#define PAGE_OFFSET_RAW 0xE0000000
+#elif defined(CONFIG_1GB)
+#define PAGE_OFFSET_RAW 0xC0000000
+#elif defined(CONFIG_2GB)
+#define PAGE_OFFSET_RAW 0x80000000
+#elif defined(CONFIG_3GB)
+#define PAGE_OFFSET_RAW 0x40000000
+#endif
diff -Nru a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Mon Aug 19 13:28:19 2002
+++ b/include/asm-i386/processor.h	Mon Aug 19 13:28:19 2002
@@ -270,7 +270,11 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
+#ifndef CONFIG_05GB
 #define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+#else
+#define TASK_UNMAPPED_BASE	(TASK_SIZE / 16)
+#endif
 
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Mon Aug 19 13:28:19 2002
+++ b/mm/memory.c	Mon Aug 19 13:28:19 2002
@@ -97,8 +97,7 @@
 
 static inline void free_one_pgd(mmu_gather_t *tlb, pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t * pmd, * md, * emd;
 
 	if (pgd_none(*dir))
 		return;
@@ -109,9 +108,23 @@
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++) {
-		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
-		free_one_pmd(tlb, pmd+j);
+
+	/*
+ 	 * Beware if changing the loop below.  It once used int j,
+	 *	for (j = 0; j < PTRS_PER_PMD; j++)
+	 *		free_one_pmd(pmd+j);
+	 * but some older i386 compilers (e.g. egcs-2.91.66, gcc-2.95.3)
+	 * terminated the loop with a _signed_ address comparison
+	 * using "jle", when configured for HIGHMEM64GB (X86_PAE).
+	 * If also configured for 3GB of kernel virtual address space,
+	 * if page at physical 0x3ffff000 virtual 0x7ffff000 is used as
+	 * a pmd, when that mm exits the loop goes on to free "entries"
+	 * found at 0x80000000 onwards.  The loop below compiles instead
+	 * to be terminated by unsigned address comparison using "jb".
+	 */
+	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
+		prefetchw(md+(PREFETCH_STRIDE/16));
+		free_one_pmd(tlb,md);
 	}
 	pmd_free_tlb(tlb, pmd);
 }

--------------030205050609010707080408--

