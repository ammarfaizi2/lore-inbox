Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbUBXFLV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 00:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUBXFLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 00:11:21 -0500
Received: from terminus.zytor.com ([63.209.29.3]:1711 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S262209AbUBXFLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 00:11:02 -0500
Message-ID: <403ADCDD.8080206@zytor.com>
Date: Mon, 23 Feb 2004 21:10:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Early memory patch, revised
Content-Type: multipart/mixed;
 boundary="------------000901060804060302060102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000901060804060302060102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

This is the latest version of the i386 early memory cleanup patch.  It 
has the additional advantage that it removes some of the special casing 
for VISWS -- this is still untested; if you have access to a VISWS 
*please* test this out.

The main difference other than the VISWS code is that it always sets up 
the GDT.  I agree with Eric this is a lot cleaner.

	-hpa

--------------000901060804060302060102
Content-Type: text/plain;
 name="earlymem-4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="earlymem-4.diff"

===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/boot/tools/build.c,v
retrieving revision 1.4
diff -u -r1.4 build.c
--- linux-2.5/arch/i386/boot/tools/build.c	7 Mar 2003 15:39:16 -0000	1.4
+++ linux-2.5/arch/i386/boot/tools/build.c	21 Feb 2004 01:44:11 -0000
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
 
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/kernel/head.S,v
retrieving revision 1.30
diff -u -r1.30 head.S
--- linux-2.5/arch/i386/kernel/head.S	19 Feb 2004 04:55:53 -0000	1.30
+++ linux-2.5/arch/i386/kernel/head.S	23 Feb 2004 01:07:18 -0000
@@ -39,42 +39,38 @@
 #define X86_CAPABILITY	CPU_PARAMS+12
 #define X86_VENDOR_ID	CPU_PARAMS+36	/* offset dependent on NCAPINTS */
 
-/*
- * Initialize page tables
+/* 
+ * This is how much memory *in addition to the memory covered up to
+ * and including _end* we need mapped initially.  We need one bit for
+ * each possible page, which currently means 2^36/4096/8 = 2 MB
+ * (64-bit-capable chips can do more, but if you have more than 64 GB
+ * of memory you *really* should be running a 64-bit kernel.  However,
+ * if this really bothers someone we could query this dynamically.)
+ *
+ * The other thing we may want to do dynamically in the future is to
+ * detect PSE and skip generating the PTEs.
+ *
+ * Modulo rounding, each megabyte assigned here requires a kilobyte of
+ * memory, which is currently unreclaimed.
+ *
+ * This should be a multiple of a page.
  */
-#define INIT_PAGE_TABLES \
-	movl $pg0 - __PAGE_OFFSET, %edi; \
-	/* "007" doesn't mean with license to kill, but	PRESENT+RW+USER */ \
-	movl $007, %eax; \
-2:	stosl; \
-	add $0x1000, %eax; \
-	cmp $empty_zero_page - __PAGE_OFFSET, %edi; \
-	jne 2b;
-
+#define INIT_MAP_BEYOND_END	(2*1024*1024)
+	
 /*
  * swapper_pg_dir is the main page directory, address 0x00101000
  *
- * On entry, %esi points to the real-mode code as a 32-bit pointer.
+ * On entry, %esi points to the real-mode code as a 32-bit pointer,
+ * and %bx is zero iff this is the boot CPU.
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
@@ -107,7 +103,37 @@
 	jmp 3f
 1:
 #endif
-	INIT_PAGE_TABLES
+
+/*
+ * Initialize page tables.  This creates a PDE and a set of page
+ * tables, which are located immediately beyond _end.  The variable
+ * init_pg_tables_end is set up to point to the first "safe" location.
+ *
+ * Warning: don't use %ebx, %esi or the stack in this code!
+ */
+page_pde_offset = (__PAGE_OFFSET >> 20);
+	
+	movl $((_end-__PAGE_OFFSET) + 0xfff), %edi
+	andl $(~0xfff), %edi
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
+	/* End condition: we must map up to and including INIT_MAP_BEYOND_END */
+	/* bytes beyond the end of our own page tables; the +0x007 is the attribute bits */
+	leal (INIT_MAP_BEYOND_END+0x007)(%edi),%ebp
+	cmpl %ebp,%eax
+	jb 10b
+	movl %edi,(init_pg_tables_end - __PAGE_OFFSET)
+
 /*
  * Enable paging
  */
@@ -117,10 +143,7 @@
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
@@ -142,8 +165,8 @@
 	movl $__bss_start,%edi
 	movl $__bss_stop,%ecx
 	subl %edi,%ecx
-	rep
-	stosb
+	shrl $2,%ecx
+	rep ; stosl
 
 /*
  * start system 32-bit setup. We need to re-do some of the things done
@@ -379,41 +402,20 @@
 	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
 
 /*
- * This is initialized to create an identity-mapping at 0-8M (for bootup
- * purposes) and another mapping of the 0-8M area at virtual address
- * PAGE_OFFSET.
+ * This is initialized to create an identity-mapping at 0-_end (for bootup
+ * purposes) and another mapping of the 0-_end area at virtual address
+ * PAGE_OFFSET.  The values put here should be all invalid (zero); the valid
+ * entries are created at INIT_PAGE_TABLES.
  */
 .org 0x1000
 ENTRY(swapper_pg_dir)
-	.long 0x00102007
-	.long 0x00103007
-	.fill BOOT_USER_PGD_PTRS-2,4,0
-	/* default: 766 entries */
-	.long 0x00102007
-	.long 0x00103007
-	/* default: 254 entries */
-	.fill BOOT_KERNEL_PGD_PTRS-2,4,0
+	.fill 1024,4,0
 
-/*
- * The page tables are initialized to only 8MB here - the final page
- * tables are set up later depending on memory size.
- */
 .org 0x2000
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
 ENTRY(empty_zero_page)
+	.fill 4096,1,0
 
-.org 0x5000
-
+.org 0x3000
 /*
  * Real beginning of normal "text" segment
  */
@@ -428,19 +430,22 @@
 .data
 
 /*
- * The Global Descriptor Table contains 28 quadwords, per-CPU.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_X86_VISWS)
-/*
  * The boot_gdt_table must mirror the equivalent in setup.S and is
- * used only by the trampoline for booting other CPUs
+ * used only for booting.
  */
+ENTRY(boot_gdt)
+	.word	__BOOT_DS + 7			# gdt limit
+	.long	boot_gdt_table-__PAGE_OFFSET	# gdt base
+
 	.align L1_CACHE_BYTES
 ENTRY(boot_gdt_table)
 	.fill GDT_ENTRY_BOOT_CS,8,0
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
@@ -488,4 +493,3 @@
 #ifdef CONFIG_SMP
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
 #endif
-
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/kernel/setup.c,v
retrieving revision 1.107
diff -u -r1.107 setup.c
--- linux-2.5/arch/i386/kernel/setup.c	19 Feb 2004 04:45:13 -0000	1.107
+++ linux-2.5/arch/i386/kernel/setup.c	21 Feb 2004 04:44:02 -0000
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
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/kernel/trampoline.S,v
retrieving revision 1.9
diff -u -r1.9 trampoline.S
--- linux-2.5/arch/i386/kernel/trampoline.S	26 May 2003 23:59:47 -0000	1.9
+++ linux-2.5/arch/i386/kernel/trampoline.S	23 Feb 2004 01:00:23 -0000
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
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/kernel/vmlinux.lds.S,v
retrieving revision 1.2
diff -u -r1.2 vmlinux.lds.S
--- linux-2.5/arch/i386/kernel/vmlinux.lds.S	18 Aug 2003 18:17:01 -0000	1.2
+++ linux-2.5/arch/i386/kernel/vmlinux.lds.S	21 Feb 2004 05:03:08 -0000
@@ -105,6 +105,7 @@
 	
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
+  . = ALIGN(4);
   __bss_stop = .; 
 
   _end = . ;
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/mm/discontig.c,v
retrieving revision 1.16
diff -u -r1.16 discontig.c
--- linux-2.5/arch/i386/mm/discontig.c	21 Sep 2003 22:39:20 -0000	1.16
+++ linux-2.5/arch/i386/mm/discontig.c	21 Feb 2004 01:48:30 -0000
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

--------------000901060804060302060102--
