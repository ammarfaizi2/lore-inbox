Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUBZPFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUBZPFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:05:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50572 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261815AbUBZPEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:04:51 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Early memory patch, +accounting
References: <403ADCDD.8080206@zytor.com>
	<m1r7wjf22s.fsf@ebiederm.dsl.xmission.com>
	<403CEE33.3020601@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Feb 2004 07:56:49 -0700
In-Reply-To: <403CEE33.3020601@zytor.com>
Message-ID: <m1oerlevny.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > 
> > Two little tweaks I can think of.
> > 1) Can we reserve space between __bss_stop and _end for the page
> >    tables and the bitmap of memory?   
> >    
> >    This should make it obvious that the early boot code is touching
> >    that memory.
> > 
> 
> After thinking about this a little bit more, you will actually *cause*
> boot failures on low memory machines if you do this.

I think we have a failure to communicate.   I was not suggesting doing
anything different from what you were doing.  I just want to report
what is happening.

Now that I see that the bootmem bitmap is at most 128KB on a 32bit
architecture I have a very hard time believing we can do real
damage to a low mem machine.

On the odd bug list in removing pg0 you broke a couple of the x86
subarches, in particular the boot_ioremap code.

I have come up with a new version of the patch because otherwise I
don't think we will be communicating clearly.

The differences are:
- I have corrected the formula for how much memory beyond the page
  tables is needed.
- I have moved some data structures in head.S in the .data segment
- I have moved the early page tables and the bootmem bitmap between
   __bss_stop and _end  ( We are only talking about 32K in the normal case)
- I have made vmlinux report it's proper physical addresses of where
  it lives in memory.
- I saw a stupid optimization opportunity and I put boot_gdt in the
  null entry of boot_gdt_table so now only one label is needed.

I intend to export _end into setup.S so a bootloader can
tell what memory the kernel will attempt to use before looking at
the e820 map, the kernel command line, and the initrd location.
After that the kernel can properly dynamically allocate things.

Exporting _end will allow two things.
1) On systems with a 15M-16M I/O hole the bootloader can check to see
   if a big kernel will attempt to use memory in that region.

2) On small memory systems it will let the bootloader make a good
   estimate to see if everything will fit into memory.

  If 32KB of available ram makes the difference between being able
  to load everything into memory or not being able to load I suspect
  the system won't run for very well anyway.

  An exported top of memory value is just advisory and a bootloader
  is free to totally ignore it, or just warn when it does not look
  like things will fit.

  _end is advisory and an estimate so a bootloader is free to totally
  ignore it, or just warn when things 
  If not accounting for 32KB causes boot problems I suspect the
  system won't run very long anyway.

Anyway it is time for me to go to bed.

Eric



diff -uNrX linux-ignore-files linux-2.6.3-bk7/arch/i386/boot/tools/build.c linux-2.6.3-bk7.initpgtbl/arch/i386/boot/tools/build.c
--- linux-2.6.3-bk7/arch/i386/boot/tools/build.c	Wed Dec 17 19:58:49 2003
+++ linux-2.6.3-bk7.initpgtbl/arch/i386/boot/tools/build.c	Wed Feb 25 23:45:54 2004
@@ -150,10 +150,8 @@
 	sz = sb.st_size;
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
-	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
-		die("System is too big. Try using %smodules.",
-			is_big_kernel ? "" : "bzImage or ");
+	if (!is_big_kernel && sys_size > DEF_SYSSIZE)
+		die("System is too big. Try using bzImage or modules.");
 	while (sz > 0) {
 		int l, n;
 
diff -uNrX linux-ignore-files linux-2.6.3-bk7/arch/i386/kernel/head.S linux-2.6.3-bk7.initpgtbl/arch/i386/kernel/head.S
--- linux-2.6.3-bk7/arch/i386/kernel/head.S	Wed Feb 25 23:39:47 2004
+++ linux-2.6.3-bk7.initpgtbl/arch/i386/kernel/head.S	Thu Feb 26 07:17:50 2004
@@ -40,41 +40,21 @@
 #define X86_VENDOR_ID	CPU_PARAMS+36	/* offset dependent on NCAPINTS */
 
 /*
- * Initialize page tables
- */
-#define INIT_PAGE_TABLES \
-	movl $pg0 - __PAGE_OFFSET, %edi; \
-	/* "007" doesn't mean with license to kill, but	PRESENT+RW+USER */ \
-	movl $007, %eax; \
-2:	stosl; \
-	add $0x1000, %eax; \
-	cmp $empty_zero_page - __PAGE_OFFSET, %edi; \
-	jne 2b;
-
-/*
  * swapper_pg_dir is the main page directory, address 0x00101000
  *
- * On entry, %esi points to the real-mode code as a 32-bit pointer.
+ * On entry, %esi points to the real-mode code as a 32-bit pointer,
+ * and %bx is zero iff this is the boot CPU.
+ * %cs is a flat 32bit segment with a base of 0
+ * %ds is a flat 32bit segment with a base of 0		
  */
 ENTRY(startup_32)
-
-#ifdef CONFIG_X86_VISWS
-/*
- * On SGI Visual Workstations boot CPU starts in protected mode.
- */
-	orw %bx, %bx
-	jnz 1f
-	INIT_PAGE_TABLES
-	movl $swapper_pg_dir - __PAGE_OFFSET, %eax
-	movl %eax, %cr3
-	lgdt boot_gdt
-1:
-#endif
-
 /*
- * Set segments to known values
+ * Set segments to known values.  Note that __BOOT_CS and __BOOT_DS
+ * must be the appropriate selectors; this is an entry condition to
+ * this function.
  */
 	cld
+	lgdt boot_gdt - __PAGE_OFFSET
 	movl $(__BOOT_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
@@ -107,7 +87,34 @@
 	jmp 3f
 1:
 #endif
-	INIT_PAGE_TABLES
+
+/*
+ * Initialize page tables.  This creates a PDE and a set of page
+ * tables, which are located at the end of the kernel memory image.
+ * The variable init_pg_tables_end is set up to point at the end
+ * of the boot page tables.
+ *
+ * Warning: don't use %ebx, %esi or the stack in this code!
+ */
+page_pde_offset = (__PAGE_OFFSET >> 20);
+	
+	movl $(pg0 - __PAGE_OFFSET), %edi
+	movl $(swapper_pg_dir - __PAGE_OFFSET), %edx
+	movl $0x007, %eax	/* 0x007 = PRESENT+RW+USER */
+10:
+	leal 0x007(%edi),%ecx	/* Create PDE entry */
+	movl %ecx,(%edx)	/* Store identity PDE entry */
+	movl %ecx,page_pde_offset(%edx)		/* Store kernel PDE entry */
+	addl $4,%edx
+	movl $1024, %ecx
+11:
+	stosl
+	addl $0x1000,%eax
+	loop 11b
+	cmpl $(_end - __PAGE_OFFSET + 0x007), %eax
+	jb 10b
+	movl %edi,(init_pg_tables_end - __PAGE_OFFSET)
+
 /*
  * Enable paging
  */
@@ -117,10 +124,7 @@
 	movl %cr0,%eax
 	orl $0x80000000,%eax
 	movl %eax,%cr0		/* ..and set paging (PG) bit */
-	jmp 1f			/* flush the prefetch-queue */
-1:
-	movl $1f,%eax
-	jmp *%eax		/* make sure eip is relocated */
+	ljmp $__BOOT_CS,$1f	/* Clear prefetch and normalize %eip */
 1:
 	/* Set up the stack pointer */
 	lss stack_start,%esp
@@ -142,8 +146,8 @@
 	movl $__bss_start,%edi
 	movl $__bss_stop,%ecx
 	subl %edi,%ecx
-	rep
-	stosb
+	shrl $2,%ecx
+	rep ; stosl
 
 /*
  * start system 32-bit setup. We need to re-do some of the things done
@@ -355,6 +359,34 @@
 	iret
 
 /*
+ * Real beginning of normal "text" segment
+ */
+ENTRY(stext)
+ENTRY(_stext)
+
+/*
+ * This starts the data section. Note that the above is all
+ * in the text section because it has alignment requirements
+ * that we cannot fulfill any other way.
+ */
+.data
+
+ /*
+ * This is initialized to create an identity-mapping at 0-_end (for bootup
+ * purposes) and another mapping of the 0-_end area at virtual address
+ * PAGE_OFFSET.  The values put here should be all invalid (zero); the valid
+ * entries are created at INIT_PAGE_TABLES.
+ */
+.balign 4096
+ENTRY(swapper_pg_dir)
+	.fill 1024,4,0
+
+.balign 4096
+ENTRY(empty_zero_page)
+	.fill 4096,1,0
+
+
+/*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
  * only used by the lidt and lgdt instructions. They are not
  * like usual segment descriptors - they consist of a 16-bit
@@ -377,70 +409,23 @@
 	.long cpu_gdt_table
 
 	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
-
-/*
- * This is initialized to create an identity-mapping at 0-8M (for bootup
- * purposes) and another mapping of the 0-8M area at virtual address
- * PAGE_OFFSET.
- */
-.org 0x1000
-ENTRY(swapper_pg_dir)
-	.long 0x00102007
-	.long 0x00103007
-	.fill BOOT_USER_PGD_PTRS-2,4,0
-	/* default: 766 entries */
-	.long 0x00102007
-	.long 0x00103007
-	/* default: 254 entries */
-	.fill BOOT_KERNEL_PGD_PTRS-2,4,0
-
-/*
- * The page tables are initialized to only 8MB here - the final page
- * tables are set up later depending on memory size.
- */
-.org 0x2000
-ENTRY(pg0)
-
-.org 0x3000
-ENTRY(pg1)
-
-/*
- * empty_zero_page must immediately follow the page tables ! (The
- * initialization loop counts until empty_zero_page)
- */
-
-.org 0x4000
-ENTRY(empty_zero_page)
-
-.org 0x5000
-
-/*
- * Real beginning of normal "text" segment
- */
-ENTRY(stext)
-ENTRY(_stext)
-
-/*
- * This starts the data section. Note that the above is all
- * in the text section because it has alignment requirements
- * that we cannot fulfill any other way.
- */
-.data
-
-/*
- * The Global Descriptor Table contains 28 quadwords, per-CPU.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_X86_VISWS)
+       
 /*
  * The boot_gdt_table must mirror the equivalent in setup.S and is
- * used only by the trampoline for booting other CPUs
+ * used only for booting.
  */
 	.align L1_CACHE_BYTES
-ENTRY(boot_gdt_table)
-	.fill GDT_ENTRY_BOOT_CS,8,0
+ENTRY(boot_gdt)
+	.word __BOOT_DS + 7		/* gdt limit */
+	.long boot_gdt - __PAGE_OFFSET	/* gdt base */
+	.word 0				/* pointer embedded in NULL descriptor */
+	.fill GDT_ENTRY_BOOT_CS-1,8,0
 	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
 	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
-#endif
+
+/*
+ * The Global Descriptor Table contains 28 quadwords, per-CPU.
+ */
 	.align L1_CACHE_BYTES
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
@@ -488,4 +473,3 @@
 #ifdef CONFIG_SMP
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
 #endif
-
diff -uNrX linux-ignore-files linux-2.6.3-bk7/arch/i386/kernel/setup.c linux-2.6.3-bk7.initpgtbl/arch/i386/kernel/setup.c
--- linux-2.6.3-bk7/arch/i386/kernel/setup.c	Wed Feb 25 23:39:47 2004
+++ linux-2.6.3-bk7.initpgtbl/arch/i386/kernel/setup.c	Wed Feb 25 23:45:54 2004
@@ -50,6 +50,11 @@
 #include "setup_arch_pre.h"
 #include "mach_resources.h"
 
+/* This value is set up by the early boot code to point to the value
+   immediately after the boot time page tables.  It contains a *physical*
+   address, and must not be in the .bss segment! */
+unsigned long init_pg_tables_end __initdata = ~0UL;
+
 int disable_pse __initdata = 0;
 
 static inline char * __init machine_specific_memory_setup(void);
@@ -115,7 +120,6 @@
 extern void dmi_scan_machine(void);
 extern void generic_apic_probe(char *);
 extern int root_mountflags;
-extern char _end[];
 
 unsigned long saved_videomode;
 
@@ -785,7 +789,7 @@
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
 	 */
-	start_pfn = PFN_UP(__pa(_end));
+	start_pfn = PFN_UP(init_pg_tables_end);
 
 	find_max_pfn();
 
@@ -1097,7 +1101,7 @@
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
-	init_mm.brk = (unsigned long) _end;
+	init_mm.brk = init_pg_tables_end + PAGE_OFFSET;
 
 	code_resource.start = virt_to_phys(_text);
 	code_resource.end = virt_to_phys(_etext)-1;
diff -uNrX linux-ignore-files linux-2.6.3-bk7/arch/i386/kernel/trampoline.S linux-2.6.3-bk7.initpgtbl/arch/i386/kernel/trampoline.S
--- linux-2.6.3-bk7/arch/i386/kernel/trampoline.S	Wed Dec 17 19:58:45 2003
+++ linux-2.6.3-bk7.initpgtbl/arch/i386/kernel/trampoline.S	Wed Feb 25 23:47:09 2004
@@ -63,13 +63,5 @@
 	.word	0			# idt limit = 0
 	.word	0, 0			# idt base = 0L
 
-#
-# NOTE: here we actually use CPU#0's GDT - but that is OK, we reload
-# the proper GDT shortly after booting up the secondary CPUs.
-#
-ENTRY(boot_gdt)
-	.word	__BOOT_DS + 7			# gdt limit
-	.long	boot_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
-
 .globl trampoline_end
 trampoline_end:
diff -uNrX linux-ignore-files linux-2.6.3-bk7/arch/i386/kernel/vmlinux.lds.S linux-2.6.3-bk7.initpgtbl/arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.3-bk7/arch/i386/kernel/vmlinux.lds.S	Wed Dec 17 19:58:18 2003
+++ linux-2.6.3-bk7.initpgtbl/arch/i386/kernel/vmlinux.lds.S	Thu Feb 26 06:46:42 2004
@@ -2,18 +2,25 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
+#include <asm/page.h>
+
+#define LOAD_OFFSET	__PAGE_OFFSET
 #include <asm-generic/vmlinux.lds.h>
-	
+
+#define MAX_BOOTMEM_BITMAP_SIZE ((MAXMEM >> PAGE_SHIFT) / 8)
+
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(startup_32)
+ENTRY(phys_startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  phys_startup_32 = startup_32 - LOAD_OFFSET;
+
+  . = LOAD_OFFSET + 0x100000;
   /* read-only */
   _text = .;			/* Text and read-only data */
-  .text : {
+  .text : AT(ADDR(.text) - LOAD_OFFSET) {
 	*(.text)
 	*(.fixup)
 	*(.gnu.warning)
@@ -23,52 +30,52 @@
 
   . = ALIGN(16);		/* Exception table */
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { *(__ex_table) }
   __stop___ex_table = .;
 
   RODATA
 
   /* writeable */
-  .data : {			/* Data */
+  .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
 	}
 
   . = ALIGN(4096);
   __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
+  .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) { *(.data.nosave) }
   . = ALIGN(4096);
   __nosave_end = .;
 
   . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
+  .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) { *(.data.idt) }
 
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) { *(.data.cacheline_aligned) }
 
   _edata = .;			/* End of data section */
 
   . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
+  .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) { *(.data.init_task) }
 
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { 
+  .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) { 
 	_sinittext = .;
 	*(.init.text)
 	_einittext = .;
   }
-  .init.data : { *(.init.data) }
+  .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
-  .init.setup : { *(.init.setup) }
+  .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) { *(.init.setup) }
   __setup_end = .;
   __start___param = .;
-  __param : { *(__param) }
+  __param : AT(ADDR(__param) - LOAD_OFFSET) { *(__param) }
   __stop___param = .;
   __initcall_start = .;
-  .initcall.init : {
+  .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
 	*(.initcall1.init) 
 	*(.initcall2.init) 
 	*(.initcall3.init) 
@@ -79,34 +86,65 @@
   }
   __initcall_end = .;
   __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
+  .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) { *(.con_initcall.init) }
   __con_initcall_end = .;
   SECURITY_INIT
   . = ALIGN(4);
   __alt_instructions = .;
-  .altinstructions : { *(.altinstructions) } 
+  .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) { *(.altinstructions) } 
   __alt_instructions_end = .; 
- .altinstr_replacement : { *(.altinstr_replacement) } 
+ .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) { *(.altinstr_replacement) } 
   /* .exit.text is discard at runtime, not link time, to deal with references
      from .altinstructions and .eh_frame */
-  .exit.text : { *(.exit.text) }
-  .exit.data : { *(.exit.data) }
+  .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
+  .exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) { *(.exit.data) }
   . = ALIGN(4096);
   __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
+  .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
   __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
+  .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
   . = ALIGN(4096);
   __init_end = .;
   /* freed after init ends here */
-	
-  __bss_start = .;		/* BSS */
-  .bss : { *(.bss) }
-  __bss_stop = .; 
 
+
+  /* BSS */
+  .bss : AT(ADDR(.bss) - LOAD_OFFSET) { 
+	__bss_start = .;
+	*(.bss) 
+	. = ALIGN(4);
+	__bss_stop = .;
+	. = ALIGN(4096);
+	pg0 = ABSOLUTE(.) ;
+	/* Reserve space for the boot page table.
+	 * Count the number of bytes in the kernel image,
+	 * add the number of bytes in the low 1M,
+	 * add the number of bytes in the worst case boot page table 4M (for a 4G kernel),
+	 * add the number of bytes in the worst case bootmem bitmap,
+	 * convert to pages and then multiply by 4 to get the worst
+	 * case number of bytes in boot page table.
+	 *
+	 * In the worst case this can allocate just over 4K extra.
+	 * That plus the page alignment make this hard to get under 8K.
+	 */
+	. += ((
+		(pg0 - _text) +
+		0x100000 +		/* Low 1M */
+		4*1024*1024 +		/* Max Page table size */
+		MAX_BOOTMEM_BITMAP_SIZE + 
+		0 ) >> PAGE_SHIFT) * 4 ;
+	. = ALIGN(4096);
+
+	/* Reserve space for the worst possible bootmem bitmap.
+	 * This can range from 128K 4G/4G kernel to about 28K
+	 * with a normal kernel.  The actual consumption is
+	 * 32bytes are used for every 1MB of ram in the system.
+	 */
+	. += MAX_BOOTMEM_BITMAP_SIZE ;
+  }
   _end = . ;
 
   /* Sections to be discarded */
diff -uNrX linux-ignore-files linux-2.6.3-bk7/arch/i386/mm/discontig.c linux-2.6.3-bk7.initpgtbl/arch/i386/mm/discontig.c
--- linux-2.6.3-bk7/arch/i386/mm/discontig.c	Wed Dec 17 19:58:57 2003
+++ linux-2.6.3-bk7.initpgtbl/arch/i386/mm/discontig.c	Wed Feb 25 23:46:15 2004
@@ -66,7 +66,7 @@
 extern void one_highpage_init(struct page *, int, int);
 
 extern struct e820map e820;
-extern char _end;
+extern unsigned long init_pg_tables_end;
 extern unsigned long highend_pfn, highstart_pfn;
 extern unsigned long max_low_pfn;
 extern unsigned long totalram_pages;
@@ -237,7 +237,7 @@
 	reserve_pages = calculate_numa_remap_pages();
 
 	/* partially used pages are not usable - thus round upwards */
-	system_start_pfn = min_low_pfn = PFN_UP(__pa(&_end));
+	system_start_pfn = min_low_pfn = PFN_UP(init_pg_tables_end);
 
 	find_max_pfn();
 	system_max_low_pfn = max_low_pfn = find_max_low_pfn();
diff -uNrX linux-ignore-files linux-2.6.3-bk7/include/asm-i386/page.h linux-2.6.3-bk7.initpgtbl/include/asm-i386/page.h
--- linux-2.6.3-bk7/include/asm-i386/page.h	Wed Dec 17 19:58:16 2003
+++ linux-2.6.3-bk7.initpgtbl/include/asm-i386/page.h	Thu Feb 26 02:35:44 2004
@@ -116,14 +116,17 @@
 
 #ifdef __ASSEMBLY__
 #define __PAGE_OFFSET		(0xC0000000)
+/* ld does not reliabely negate numbers */
+#define __MAXMEM		(0x40000000 - __VMALLOC_RESERVE)
 #else
 #define __PAGE_OFFSET		(0xC0000000UL)
+#define __MAXMEM		(-__PAGE_OFFSET - __VMALLOC_RESERVE)
 #endif
 
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM			__MAXMEM
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)

