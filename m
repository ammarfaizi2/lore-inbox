Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280664AbRLHN61>; Sat, 8 Dec 2001 08:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280725AbRLHN6K>; Sat, 8 Dec 2001 08:58:10 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:15565 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280664AbRLHN5z>; Sat, 8 Dec 2001 08:57:55 -0500
From: "ChristianK."@t-online.de (Christian Koenig)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Making vmlinux Multiboot compliant and grub capable of loading modules at boot time. (1 Part)
Date: Sat, 8 Dec 2001 14:59:18 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_UU21KXX2WPDB2A8O6XF1"
Message-ID: <16ChzA-1vH6GWC@fwd01.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_UU21KXX2WPDB2A8O6XF1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

First this patch isn't "release ready", but I need some help with it.
I split this up in 2 Parts because it is a little bit large (~80Kb).

The patch is for 2.4.14 Kernel Source, but it should patch well on other 
Versions (at least the module loader).

This is the 2nd Part wich adds Multiboot compatibility to vmlinux, by adding a Multibootheader to 
arch/i386/kernel/head.S

The Multiboot information (apm-table, memmapping....) are converted to linux 
conform things, and the Memory used by the Modules is reserved with the 
bootmem bitmap in
arch/i386/kernel/setup.c

The reserved data is released in 
arch/i386/mm/init.c
when the Init data is released.

Then in 
init/main.c
a newly created elf-object loader is called in
kernel/boot_modules.c 
inserting the Modules into the kernel (this is in the 2Part of the Patch).

With this grub is capable of loading multiple modules at boot time, before 
the root fs is mounted..
This can't be done with initrd, because you could on load one single initrd 
Image.

Look at the "Debian Installation Disk's" for an example that this is usefull, at the moment they use 4 different kernel Images for the (i386) Installation disks, with this patch they would only need 1 kernel Image. 

My question is what should I do to make this patch "clean" ?
I know that vmlinux isn't compressed and contains unused elf-sections.
And I know that the elf-loader is a simple copy,paste & "make it working" from
the insmod sources.

Tell me what you thing about it.

MfG, Christian König. (and sorry for my poor English).




--------------Boundary-00=_UU21KXX2WPDB2A8O6XF1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mboot.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="mboot.diff"

diff -Nurb linux.orig/arch/i386/Makefile linux/arch/i386/Makefile
--- linux.orig/arch/i386/Makefile	Thu Apr 12 21:20:31 2001
+++ linux/arch/i386/Makefile	Wed Nov 28 00:26:22 2001
@@ -18,7 +18,7 @@
 
 LD=$(CROSS_COMPILE)ld -m elf_i386
 OBJCOPY=$(CROSS_COMPILE)objcopy -O binary -R .note -R .comment -S
-LDFLAGS=-e stext
+LDFLAGS=
 LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinux.lds $(LDFLAGS)
 
 CFLAGS += -pipe
diff -Nurb linux.orig/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux.orig/arch/i386/kernel/head.S	Wed Jun 20 20:00:53 2001
+++ linux/arch/i386/kernel/head.S	Fri Nov 30 21:40:30 2001
@@ -7,6 +7,9 @@
  *  and Martin Mares, November 1997.
  */
 
+#define ASM	1
+#include <asm/multiboot.h>
+
 .text
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -45,12 +48,36 @@
 /*
  * Set segments to known values
  */
-	cld
 	movl $(__KERNEL_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
 	movl %eax,%fs
 	movl %eax,%gs
+	movl %eax,%ss
+
+	jmp	real_startup_32
+
+	/* Align 32 bits boundary.  */
+	.align	4
+
+	/* Multiboot header.  */
+multiboot_header:
+
+	/* magic */
+	.long	MULTIBOOT_HEADER_MAGIC
+	/* flags */
+	.long	MULTIBOOT_HEADER_FLAGS
+	/* checksum */
+	.long	-(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)
+
+.globl SYMBOL_NAME(multiboot_entry)
+multiboot_entry:
+	movl %ebx,SYMBOL_NAME(mbootinfo) - __PAGE_OFFSET
+	xorl %ebx,%ebx
+
+real_startup_32:
+
+	cld
 #ifdef CONFIG_SMP
 	orw %bx,%bx
 	jz 1f
@@ -104,7 +131,7 @@
 	jmp *%eax		/* make sure eip is relocated */
 1:
 	/* Set up the stack pointer */
-	lss stack_start,%esp
+	movl stack_start,%esp
 
 #ifdef CONFIG_SMP
 	orw  %bx,%bx
@@ -119,6 +146,10 @@
  * Clear BSS first so that there are no surprises...
  * No need to cld as DF is already clear from cld above...
  */
+	movl SYMBOL_NAME(mbootinfo),%eax
+	andl %eax,%eax
+	jnz 1f			# We have a multiboot boot loader
+
 	xorl %eax,%eax
 	movl $ SYMBOL_NAME(__bss_start),%edi
 	movl $ SYMBOL_NAME(_end),%ecx
@@ -126,6 +157,8 @@
 	rep
 	stosb
 
+1:
+
 /*
  * start system 32-bit setup. We need to re-do some of the things done
  * in 16-bit mode for the "real" operations.
@@ -145,6 +178,10 @@
  *
  * Note: %esi still has the pointer to the real-mode data.
  */
+	movl SYMBOL_NAME(mbootinfo),%eax
+	andl %eax,%eax
+	jnz 1f			# We have a multiboot boot loader
+
 	movl $ SYMBOL_NAME(empty_zero_page),%edi
 	movl $512,%ecx
 	cld
@@ -358,6 +395,7 @@
 
 .globl SYMBOL_NAME(idt)
 .globl SYMBOL_NAME(gdt)
+.globl SYMBOL_NAME(mbootinfo)
 
 	ALIGN
 	.word 0
@@ -371,6 +409,11 @@
 	.word GDT_ENTRIES*8-1
 SYMBOL_NAME(gdt):
 	.long SYMBOL_NAME(gdt_table)
+
+	.word 0
+
+SYMBOL_NAME(mbootinfo):
+	.long 0
 
 /*
  * This is initialized to create an identity-mapping at 0-8M (for bootup
diff -Nurb linux.orig/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux.orig/arch/i386/kernel/setup.c	Thu Oct 25 22:53:46 2001
+++ linux/arch/i386/kernel/setup.c	Thu Dec  6 17:54:03 2001
@@ -108,6 +108,8 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#include <asm/multiboot.h>
+
 /*
  * Machine setup..
  */
@@ -156,6 +158,11 @@
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;

+unsigned long mboot_mem_start;
+unsigned long mboot_mem_end;
+unsigned long mboot_module_start;
+unsigned long mboot_module_end;
+
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -661,6 +668,28 @@
 }

 /*
+ * Converts the Multiboot Mem-Map into a e820 one.
+ */
+static int __init mboot_2_e820_map(struct e820entry * biosmap, int nr_map)
+{
+	struct multiboot_memory_map *addr;
+	addr = (struct multiboot_memory_map *)mbootinfo->mmap_addr;
+
+	while((char *)addr < (mbootinfo->mmap_addr + mbootinfo->mmap_length)) {
+
+		biosmap[nr_map].addr = addr->base_addr_low + ((unsigned long long)addr->base_addr_high << 32);
+		biosmap[nr_map].size = addr->length_low + ((unsigned long long)addr->length_high << 32);
+		biosmap[nr_map].type = addr->type;
+
+		addr = (struct multiboot_memory_map *)
+			((char *)addr + addr->size + sizeof (addr->size));
+		nr_map++;
+	}
+
+	return nr_map;
+}
+
+/*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
  */
@@ -676,10 +705,18 @@
 	 * Otherwise fake a memory map; one section from 0k->640k,
 	 * the next section from 1mb->appropriate_mem_k
 	 */
+	if (mbootinfo && (mbootinfo->flags & MBOOTINFO_HAVE_MEMMAP))
+		E820_MAP_NR = mboot_2_e820_map(E820_MAP, E820_MAP_NR);
 	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
 	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
 		unsigned long mem_size;

+		if (mbootinfo) {
+			who = "Multiboot-Loader:";
+			e820.nr_map = 0;
+			add_memory_region(0, mbootinfo->mem_lower << 10, E820_RAM);
+			add_memory_region(HIGH_MEMORY, mbootinfo->mem_upper << 10, E820_RAM);
+		} else {
 		/* compare results from other methods and take the greater */
 		if (ALT_MEM_K < EXT_MEM_K) {
 			mem_size = EXT_MEM_K;
@@ -693,6 +730,7 @@
 		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
 		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
   	}
+  	}
 	printk(KERN_INFO "BIOS-provided physical RAM map:\n");
 	print_memory_map(who);
 } /* setup_memory_region */
@@ -704,8 +742,11 @@
 	int len = 0;
 	int usermem = 0;

+	if ((mbootinfo) && (mbootinfo->flags & MBOOTINFO_HAVE_CMDLINE))
+		from = mbootinfo->cmdline;
+
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';

 	for (;;) {
@@ -768,6 +809,86 @@
 	}
 }

+#define INFBOUND(a,b)	if (b > a) a = b
+#define SUPBOUND(a,b)	if (b < a) a = b
+
+
+unsigned long get_bootmembitmap_addr(void)
+{
+	unsigned long start_pfn = __pa(&_end);
+
+#ifdef CONFIG_MODULES
+
+	if ((mbootinfo) && (mbootinfo->flags & MBOOTINFO_HAVE_MODULE)) {
+		int i;
+		struct multiboot_module *addr = mbootinfo->mods_addr;
+
+		mboot_module_start = 0xFFFFFFFF;
+		mboot_module_end = 0;
+
+		for(i=0;i<mbootinfo->mods_count;i++) {
+			INFBOUND(start_pfn,addr[i].mod_end);
+
+			addr[i].mod_start += __PAGE_OFFSET;
+			addr[i].mod_end += __PAGE_OFFSET;
+
+			SUPBOUND(mboot_module_start,addr[i].mod_start);
+			INFBOUND(mboot_module_end,addr[i].mod_end);
+
+		}
+		printk(KERN_INFO "Multiboot module mem 0x%lx - 0x%lx\n",mboot_module_start, mboot_module_end);
+	}
+
+#endif
+
+	return start_pfn;
+}
+
+#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+void reserve_mbootinfo_mem(void)
+{
+	if (mbootinfo) {
+		mboot_mem_start = (unsigned long)mbootinfo;
+		mboot_mem_end = (unsigned long)mbootinfo + sizeof(*mbootinfo);
+
+		if (mbootinfo->flags & MBOOTINFO_HAVE_MODULE) {
+			int i;
+
+			SUPBOUND(mboot_mem_start,(unsigned long)mbootinfo->mods_addr);
+			INFBOUND(mboot_mem_end,(unsigned long)mbootinfo->mods_addr +
+				sizeof(struct multiboot_module) * mbootinfo->mods_count);
+
+			for(i=0;i<mbootinfo->mods_count;i++) {
+				char *str;
+				struct multiboot_module *addr = &mbootinfo->mods_addr[i];
+
+				SUPBOUND(mboot_mem_start,(unsigned long)addr->string);
+				for(str = addr->string;str[0] != 0;str++);
+				INFBOUND(mboot_mem_end,(unsigned long)str);
+
+				(unsigned int)addr->string += __PAGE_OFFSET;
+			}
+			SUPBOUND(mboot_mem_start,(unsigned int)mbootinfo->mods_addr);
+			INFBOUND(mboot_mem_end,(unsigned int)mbootinfo->mods_addr);
+			(unsigned int)mbootinfo->mods_addr += __PAGE_OFFSET;
+
+		}
+
+		mboot_mem_start = PFN_PHYS(PFN_DOWN(mboot_mem_start));
+		mboot_mem_end   = PFN_PHYS(PFN_UP(mboot_mem_end));
+
+		printk(KERN_NOTICE "Reserving Multiboot Memory 0x%lx - 0x%lx\n",mboot_mem_start,mboot_mem_end);
+		reserve_bootmem(mboot_mem_start, mboot_mem_end - mboot_mem_start);
+
+		mboot_mem_start += __PAGE_OFFSET;
+		mboot_mem_end += __PAGE_OFFSET;
+		(unsigned int)mbootinfo += __PAGE_OFFSET;
+	}
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long bootmap_size, low_mem_size;
@@ -780,8 +901,27 @@

  	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
+
+	if (mbootinfo) {
+
+		screen_info.orig_x = 0;			/* 0x00 */
+		screen_info.orig_y = 0;			/* 0x01 */
+		screen_info.orig_video_page = 8;		/* 0x04 */
+		screen_info.orig_video_mode = 3;		/* 0x06 */
+		screen_info.orig_video_cols = 80;		/* 0x07 */
+		screen_info.orig_video_ega_bx = 3;	/* 0x0a */
+		screen_info.orig_video_lines = 25;	/* 0x0e */
+		screen_info.orig_video_isVGA = 1;	/* 0x0f */
+		screen_info.orig_video_points = 16;	/* 0x10 */
+
+		if (mbootinfo->flags & MBOOTINFO_HAVE_APMTABLE)
+			apm_info.bios = *mbootinfo->apm_table;
+
+	} else {
  	screen_info = SCREEN_INFO;
 	apm_info.bios = APM_BIOS_INFO;
+	}
+
 	if( SYS_DESC_TABLE.length != 0 ) {
 		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
 		machine_id = SYS_DESC_TABLE.table[0];
@@ -811,10 +951,6 @@

 	parse_mem_cmdline(cmdline_p);

-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
 /*
  * 128MB for vmalloc and initrd
  */
@@ -827,7 +963,7 @@
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
 	 */
-	start_pfn = PFN_UP(__pa(&_end));
+	start_pfn = PFN_UP(get_bootmembitmap_addr());

 	/*
 	 * Find the highest page frame number we have available
@@ -941,6 +1077,8 @@
 	 */
 	reserve_bootmem(PAGE_SIZE, PAGE_SIZE);
 #endif
+
+	reserve_mbootinfo_mem();

 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
diff -Nurb linux.orig/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux.orig/arch/i386/mm/init.c	Fri Sep 21 04:59:20 2001
+++ linux/arch/i386/mm/init.c	Wed Dec  5 23:59:33 2001
@@ -36,6 +36,7 @@
 #include <asm/e820.h>
 #include <asm/apic.h>
 #include <asm/tlb.h>
+#include <asm/multiboot.h>

 mmu_gather_t mmu_gathers[NR_CPUS];
 unsigned long highstart_pfn, highend_pfn;
@@ -541,18 +542,34 @@
 	return flag;
 }

+#define FREE_RESERVED_MEM(addr) {\
+	ClearPageReserved(virt_to_page(addr)); \
+	set_page_count(virt_to_page(addr), 1); \
+	free_page(addr); \
+	totalram_pages++; \
+}
+
 void free_initmem(void)
 {
 	unsigned long addr;
 
-	addr = (unsigned long)(&__init_begin);
-	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(addr));
-		set_page_count(virt_to_page(addr), 1);
-		free_page(addr);
-		totalram_pages++;
+	if (mbootinfo) {
+		for (addr = mboot_mem_start; addr < mboot_mem_end; addr += PAGE_SIZE)
+			FREE_RESERVED_MEM(addr);
+		printk ("Freeing Multiboot memory: %ldk freed\n", (mboot_mem_end - mboot_mem_start) >> 10);
+
+		if ((mbootinfo->flags & MBOOTINFO_HAVE_MODULE) && (mbootinfo->mods_count > 0)) {
+			for (addr = mboot_module_start; addr < mboot_module_end; addr += PAGE_SIZE)
+				FREE_RESERVED_MEM(addr);
+			printk ("Freeing Multiboot-Module memory: %ldk freed\n", (mboot_module_end - mboot_module_start) >> 10);
+		}
+
 	}
+	addr = (unsigned long)(&__init_begin);
+	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE)
+		FREE_RESERVED_MEM(addr);
 	printk ("Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
+
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -560,12 +577,8 @@
 {
 	if (start < end)
 		printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
-	for (; start < end; start += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(start));
-		set_page_count(virt_to_page(start), 1);
-		free_page(start);
-		totalram_pages++;
-	}
+	for (; start < end; start += PAGE_SIZE)
+		FREE_RESERVED_MEM(start);
 }
 #endif
 
diff -Nurb linux.orig/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
--- linux.orig/arch/i386/vmlinux.lds	Mon Jul  2 23:40:14 2001
+++ linux/arch/i386/vmlinux.lds	Wed Nov 28 00:11:57 2001
@@ -3,33 +3,34 @@
  */
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(_start)
+ENTRY(_lmabase)
 SECTIONS
 {
+  _lmabase = multiboot_entry - 0xC0000000;
   . = 0xC0000000 + 0x100000;
   _text = .;			/* Text and read-only data */
-  .text : {
+  .text : AT (ADDR(.text) - 0xC0000000) {
 	*(.text)
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
+  .text.lock : AT (ADDR(.text.lock) - 0xC0000000) { *(.text.lock) }	/* out-of-line lock text */
 
   _etext = .;			/* End of text section */
 
-  .rodata : { *(.rodata) *(.rodata.*) }
-  .kstrtab : { *(.kstrtab) }
+  .rodata : AT (ADDR(.rodata) - 0xC0000000) { *(.rodata) *(.rodata.*) }
+  .kstrtab : AT (ADDR(.kstrtab) - 0xC0000000) { *(.kstrtab) }
 
   . = ALIGN(16);		/* Exception table */
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : AT (ADDR(__ex_table) - 0xC0000000) { *(__ex_table) }
   __stop___ex_table = .;
 
   __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
+  __ksymtab : AT (ADDR(__ksymtab) - 0xC0000000) { *(__ksymtab) }
   __stop___ksymtab = .;
 
-  .data : {			/* Data */
+  .data : AT (ADDR(.data) - 0xC0000000) {			/* Data */
 	*(.data)
 	CONSTRUCTORS
 	}
@@ -37,30 +38,30 @@
   _edata = .;			/* End of data section */
 
   . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
+  .data.init_task : AT (ADDR(.data.init_task) - 0xC0000000) { *(.data.init_task) }
 
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
+  .text.init : AT (ADDR(.text.init) - 0xC0000000) { *(.text.init) }
+  .data.init : AT (ADDR(.data.init) - 0xC0000000) { *(.data.init) }
   . = ALIGN(16);
   __setup_start = .;
-  .setup.init : { *(.setup.init) }
+  .setup.init : AT (ADDR(.setup.init) - 0xC0000000) { *(.setup.init) }
   __setup_end = .;
   __initcall_start = .;
-  .initcall.init : { *(.initcall.init) }
+  .initcall.init : AT (ADDR(.initcall.init) - 0xC0000000) { *(.initcall.init) }
   __initcall_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
   . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
+  .data.page_aligned : AT (ADDR(.data.page_aligned) - 0xC0000000) { *(.data.idt) }
 
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .data.cacheline_aligned : AT (ADDR(.data.cacheline_aligned) - 0xC0000000) { *(.data.cacheline_aligned) }
 
   __bss_start = .;		/* BSS */
-  .bss : {
+  .bss : AT (ADDR(.bss) - 0xC0000000) {
 	*(.bss)
 	}
   _end = . ;
diff -Nurb linux.orig/include/asm-i386/multiboot.h linux/include/asm-i386/multiboot.h
--- linux.orig/include/asm-i386/multiboot.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-i386/multiboot.h	Thu Dec  6 17:39:44 2001
@@ -0,0 +1,147 @@
+/* multiboot.h - the header for Multiboot */
+/* Copyright (C) 1999, 2001  Free Software Foundation, Inc.
+   
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+   
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+   
+   You should have received a copy of the GNU General Public License
+   aint with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
+
+/* Macros.  */
+
+/* The magic number for the Multiboot header.  */
+#define MULTIBOOT_HEADER_MAGIC		0x1BADB002
+
+/* The flags for the Multiboot header.  */
+# define MULTIBOOT_HEADER_FLAGS		0x00000003
+
+/* The magic number passed by a Multiboot-compliant boot loader.  */
+#define MULTIBOOT_BOOTLOADER_MAGIC	0x2BADB002
+
+/* The size of our stack (16KB).  */
+#define STACK_SIZE			0x4000
+
+/* C symbol format. HAVE_ASM_USCORE is defined by configure.  */
+#ifdef HAVE_ASM_USCORE
+# define EXT_C(sym)			_ ## sym
+#else
+# define EXT_C(sym)			sym
+#endif
+
+#define MBOOTINFO_HAVE_MEMINFO		1
+#define MBOOTINFO_HAVE_BOOTDEVICE	2
+#define MBOOTINFO_HAVE_CMDLINE		4
+#define MBOOTINFO_HAVE_MODULE		8
+#define MBOOTINFO_HAVE_AOUTINFO		16
+#define MBOOTINFO_HAVE_ELFINFO		32
+#define MBOOTINFO_HAVE_MEMMAP		64
+#define MBOOTINFO_HAVE_DRIVEINFO	128
+#define MBOOTINFO_HAVE_ROMINFO		256
+#define MBOOTINFO_HAVE_LOADERNAME	512
+#define MBOOTINFO_HAVE_APMTABLE		1024
+#define MBOOTINFO_HAVE_VIDEOINFO	2048
+
+#ifndef ASM
+
+#include <linux/apm_bios.h>
+/* Do not include here in boot.S.  */
+
+extern struct multiboot_info *mbootinfo;
+extern unsigned long mboot_mem_start;
+extern unsigned long mboot_mem_end;
+extern unsigned long mboot_module_start;
+extern unsigned long mboot_module_end;
+
+/* Types.  */
+
+/* The Multiboot header.  */
+struct multiboot_header
+{
+  unsigned int magic;
+  unsigned int flags;
+  unsigned int checksum;
+  unsigned int header_addr;
+  unsigned int load_addr;
+  unsigned int load_end_addr;
+  unsigned int bss_end_addr;
+  unsigned int entry_addr;
+};
+
+/* The symbol table for a.out.  */
+struct multiboot_aout_symbol_table
+{
+  unsigned int tabsize;
+  unsigned int strsize;
+  unsigned int addr;
+  unsigned int reserved;
+};
+
+/* The section header table for ELF.  */
+struct multiboot_elf_section_header_table
+{
+  unsigned int num;
+  unsigned int size;
+  unsigned int addr;
+  unsigned int shndx;
+};
+
+/* The module structure.  */
+struct multiboot_module
+{
+  unsigned int mod_start;
+  unsigned int mod_end;
+  char *string;
+  unsigned int reserved;
+};
+
+/* The Multiboot information.  */
+struct multiboot_info
+{
+  unsigned int flags;
+  unsigned int mem_lower;
+  unsigned int mem_upper;
+  unsigned int boot_device;
+  char *cmdline;
+  unsigned int mods_count;
+  struct multiboot_module *mods_addr;
+  union
+  {
+    struct multiboot_aout_symbol_table aout_sym;
+    struct multiboot_elf_section_header_table elf_sec;
+  } u;
+  unsigned int mmap_length;
+  char *mmap_addr;
+  unsigned int drives_length;
+  unsigned int drives_addr;
+  unsigned int config_table;
+  char *boot_loader_name;
+  struct apm_bios_info *apm_table;
+  unsigned int vbe_control_info;
+  unsigned int vbe_mode_info;
+  unsigned short vbe_mode;
+  unsigned short vbe_interface_seg;
+  unsigned short vbe_interface_off;
+  unsigned short vbe_interface_len;
+};
+
+/* The memory map. Be careful that the offset 0 is base_addr_low
+   but no size.  */
+struct multiboot_memory_map
+{
+  unsigned int size;
+  unsigned int base_addr_low;
+  unsigned int base_addr_high;
+  unsigned int length_low;
+  unsigned int length_high;
+  unsigned int  type;
+};
+
+#endif /* ! ASM */

--------------Boundary-00=_UU21KXX2WPDB2A8O6XF1--

