Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbTALV7M>; Sun, 12 Jan 2003 16:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTALV7M>; Sun, 12 Jan 2003 16:59:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51472 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267545AbTALV6x>;
	Sun, 12 Jan 2003 16:58:53 -0500
Date: Sun, 12 Jan 2003 23:07:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [RFC] Consolidate vmlinux.lds.S files
Message-ID: <20030112220741.GA15849@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we have seen seveal changes to arch/*/vmlinux-lds.S,
mainly introduced by the module support but also other changes.

This is first version, where I have converted i386, s390 and sparc64.
The latter two is not tested, only to make sure it can be used by more
than one platform.

include/asm-generic/vmlinux.lds contains common definitions.
inserted below + three diffs.

 i386/vmlinux.lds.S    |  148 ++++++++++++++---------------------------------
 s390/vmlinux.lds.S    |  138 +++++++++++++-------------------------------
 sparc64/vmlinux.lds.S |  156 +++++++++++++++++++-------------------------------
 3 files changed, 149 insertions(+), 293 deletions(-)

The architecture specific files became smaller.
And adding new stuff is easier.

If this the correct way of doing it - or do you have any better ways
to do it?

Comments appreciated!

	Sam

/*
 * Generic Linker definitions
 *
 * Used to share linker definitions across architectures.
 */


/* .text section - default for all code
 * start: 	where .text section starts.
 * fill:	fill gaps with this value
 * extra:	additional sections as part of .text
 **/
#define TEXT_SECTION_CMD(start, vma, fill, extra)	\
	TEXT_SECTION_START(start, vma) {		\
		TEXT_SECTION_CONTENT			\
		extra					\
	} = (fill)					\
	TEXT_SECTION_END

/* start specify where .text starts */
#define TEXT_SECTION_START(start, vma)		\
	. = (start);				\
	_text = .;				\
	.text vma :

#define TEXT_SECTION_CONTENT		\
		*(.text)		\
		*(.fixup)		\
		*(.gnu.warning)		\

/* End of TEXT section. Allow architectures to put something in between. */
#define TEXT_SECTION_END		\
	_etext = .;			\
	PROVIDE(etext = .);


/* FIXME: Purpose? */
#define RODATA	\
	.rodata : { *(.rodata) *(.rodata.*) }

/* FIXME: Kernel strings */
#define KSTRTAB	\
	.kstrtab : { *(.kstrtab) }

/* Exception table */
#define EXCEPTIONTABLE(align)		\
	. = ALIGN(align);		\
	__start___ex_table = .;		\
	__ex_table : { *(__ex_table) }	\
	__stop___ex_table = .;

/* Kernel symbol table */
#define KERNEL_SYMBOLS				\
	. = ALIGN(64);				\
	__start___ksymtab = .;			\
	__ksymtab : { *(__ksymtab) }		\
	__stop___ksymtab = .;			\
\
	/* Symbol table for GPL symbols */	\
	__start___gpl_ksymtab = . ;		\
	__gpl_ksymtab : { *(__gpl_ksymtab) }	\
	__stop___gpl_ksymtab = . ;		\
\
	/* All kernel symbols */		\
	__start___kallsyms = .;			\
	__kallsyms : { *(__kallsyms) }		\
	__stop___kallsyms = .;


/* Start of Data section. Use . if no specific start address */
#define DATA_SECTION_START(start)		\
	. = (start);				\
	.data :
	
/* .data section content */	
#define DATA_SECTION				\
		*(.data)			\
		CONSTRUCTORS
		
/* End of DATA section. Allow architectures to put something in between. */
#define DATA_SECTION_END			\
	_edata = .;				\
	PROVIDE(edata = .);

	
#define NOSAVE(nosave_align)			\
	/* FIXME: Purpose */			\
	. = ALIGN(nosave_align);		\
	__nosave_begin = .;			\
	.data_nosave :				\
		{ *(.data.nosave) }		\
	. = ALIGN(nosave_align);		\
	__nosave_end = .;

#define DATA_PAGE_ALIGN(page_align)		\
	. = ALIGN(page_align);			\
	.data.page_aligned : { *(.data.idt) }

#define DATA_CACHELINE_ALIGN(cache_align)	\
	. = ALIGN(cache_align);			\
	.data.cacheline_aligned :		\
		{ *(.data.cacheline_aligned) }


/* Initial thread structure (init_task) */
#define DATA_INIT_TASK(task_align)		\
  . = ALIGN(task_align);			\
  .data.init_task : { *(.data.init_task) }


/* __init_begin mars start of chunk of memory
 * that will be freed after init
 **/
#define INIT_BEGIN(align)			\
  . = ALIGN(align);				\
  __init_begin = .;
  
/* .init.text and .init.data is used for early initialisation */
#define INIT_TEXTDATA				\
  .init.text : { *(.init.text) }		\
  .init.data : { *(.init.data) }

/* Obsolete section used for module parameters */
#define INIT_SETUP(align)			\
	. = ALIGN (align) ;			\
	__setup_start = . ;			\
	.init.setup : { *(.init.setup) }	\
	__setup_end = . ;

/* Module / boot parameters */
#define MODULE_PARAM				\
	__start___param = . ;			\
	__param : { *(__param) }		\
	__stop___param = . ;

/* Init call tables */
#define INIT_CALLS				\
	__initcall_start = .;			\
	.initcall.init : {			\
		*(.initcall.init)		\
		*(.initcall1.init)		\
		*(.initcall2.init)		\
		*(.initcall3.init)		\
		*(.initcall4.init)		\
		*(.initcall5.init)		\
		*(.initcall6.init)		\
		*(.initcall7.init)		\
	}					\
	__initcall_end = . ;

#define INIT_RAMFS(ramfs_align)			\
	. = ALIGN(ramfs_align);			\
	__initramfs_start = .;			\
	.init.ramfs : { *(.init.ramfs) }	\
	__initramfs_end = .;

#define PERCPU(align)				\
  . = ALIGN(align);				\
  __per_cpu_start = .;				\
  .data.percpu  : { *(.data.percpu) }		\
  __per_cpu_end = .;

#define INIT_END(end_align)			\
	. = ALIGN(end_align);			\
	__init_end = .;
	
#define BSS(bss_start, bss_align)		\
	. = bss_start;				\
	__bss_start = ALIGN(bss_align);		\
	.bss : { *(.bss) }			\
	__bss_stop = .;

/* Following list of sections are discarded by the linker.
 * Most architectures can use the default.
 * To extend the list use the following syntax:
 * /DISCARD/ : {
 * 	DISCARD_SECTION
 * 	*(section.exit.text)
 * }
 **/
#define DISCARD_SECTION_CMD			\
	/DISCARD/ : {				\
		DISCARD_SECTION			\
	}

/* Default sections to be discarded */
#define DISCARD_SECTION				\
		*(.exit.text)			\
		*(.exit.data)			\
		*(.exitcall.exit)		\

/* Stabs debugging sections.  */
#define STABS_DEBUG					\
	.stab 0 : { *(.stab) }				\
	.stabstr 0 : { *(.stabstr) }			\
	.stab.excl 0 : { *(.stab.excl) }		\
	.stab.exclstr 0 : { *(.stab.exclstr) }		\
	.stab.index 0 : { *(.stab.index) }		\
	.stab.indexstr 0 : { *(.stab.indexstr) }	\
	.comment 0 : { *(.comment) }

/* Default INIT section.
 * All sections within this part are freed after init
 * by the kernel.
 * Architectures has different alignment requirments,
 * reflected in the parameters passed.
 **/
#define INIT_SECTION_CMD(align, setup, ramfs, percpu)	\
	INIT_BEGIN(align)				\
		INIT_TEXTDATA				\
		/* Obsolete? init.setup section */	\
		INIT_SETUP(setup)			\
		/* boot / module parameters */		\
		MODULE_PARAM				\
		INIT_CALLS				\
		INIT_RAMFS(ramfs)			\
		PERCPU(percpu)				\
	INIT_END(align)

===== arch/i386/vmlinux.lds.S 1.21 vs edited =====
--- 1.21/arch/i386/vmlinux.lds.S	Tue Dec  3 02:03:16 2002
+++ edited/arch/i386/vmlinux.lds.S	Sun Jan 12 22:55:49 2003
@@ -1,117 +1,59 @@
 /* ld script to make i386 Linux kernel
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
+
+#include <asm-generic/vmlinux.lds>
+
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
 jiffies = jiffies_64;
+
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
-  /* read-only */
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
-  . = ALIGN(64);
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  __start___kallsyms = .;       /* All kernel symbols */
-  __kallsyms : { *(__kallsyms) }
-  __stop___kallsyms = .;
-
-  /* writeable */
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
+	/* Start  = 0xC...
+	 * vma    =
+	 * extra  =
+	 */
+	TEXT_SECTION_CMD(0xC0000000 + 0x100000,, 0x9090, )
+	RODATA
+	KSTRTAB
+	EXCEPTIONTABLE(16)
+	KERNEL_SYMBOLS
+
+	/* start = .
+	 * aling = 1
+	 */
+	DATA_SECTION_START(.)
+	{
+		DATA_SECTION
 	}
 
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
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .init.text : { *(.init.text) }
-  .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
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
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-  /* freed after init ends here */
+		NOSAVE(4096)
+		DATA_PAGE_ALIGN(4096)
+		DATA_CACHELINE_ALIGN(32)
+	DATA_SECTION_END
+
+	DATA_INIT_TASK(8192)
+
+	/* The following is freed by kernel after init
+	 * Alignment		4096
+	 * init.setup alignment	12
+	 * ramfs alignment	4096
+	 * percpu alignment	32
+	 **/
+	INIT_SECTION_CMD(4096, 16, 4096, 32)
+
+	/* No specific bss alignment */
+	BSS(., 1)
+
+	/* Global end marker */
+	_end = . ;
 	
-  __bss_start = .;		/* BSS */
-  .bss : { *(.bss) }
-  __bss_stop = .; 
-
-  _end = . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-	*(.exit.text)
-	*(.exit.data)
-	*(.exitcall.exit)
-	}
+	/* Will be discarded */
+	DISCARD_SECTION_CMD
 
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+	/* Stabs for debugging */
+	STABS_DEBUG
 }
+
===== arch/s390/vmlinux.lds.S 1.5 vs edited =====
--- 1.5/arch/s390/vmlinux.lds.S	Mon Nov 18 21:11:00 2002
+++ edited/arch/s390/vmlinux.lds.S	Sun Jan 12 22:53:54 2003
@@ -7,108 +7,54 @@
 jiffies = jiffies_64 + 4;
 SECTIONS
 {
-  . = 0x00000000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x0700
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
-  . = ALIGN(64);
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
+	/* Start = 0x0
+	 * fill  = 0x0700
+	TEXT_SECTION_CMD(0x0, , 0x0700,)
+
+	RODATA
+	KSTRTAB
+
+	EXCEPTIONTABLE(16)
+	KERNEL_SYMBOLS
 
 #ifdef CONFIG_SHARED_KERNEL
-  . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
+	. = ALIGN(1048576);	/* VM shared segments are 1MB aligned */
 
-  _eshared = .;			/* End of shareable data */
+	_eshared = .;		/* End of shareable data */
 #endif
 
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
+	/* Data */
+	DATA_SECTION_START(.) {
+		DATA_SECTION
 	}
+		DATA_SECTION_END
 
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
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .init.text : { *(.init.text) }
-  .init.data : { *(.init.data) }
-  . = ALIGN(256);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
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
-  . = ALIGN(256);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.initramfs) }
-  __initramfs_end = .;
-  . = ALIGN(256);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-  /* freed after init ends here */
-
-  __bss_start = .;		/* BSS */
-  .bss : { *(.bss) }
-  __bss_stop = .;
-
-  _end = . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-	*(.exit.text)
-	*(.exit.data)
-	*(.exitcall.exit)
-	}
+		NOSAVE(4096)
+		DATA_PAGE_ALIGN(4096)
+		DATA_CACHE_LINE_ALIGN(32)
+	DATA_SECTION_END
+
+
+	DATA_INIT_TASK(8192);
+
+	/* The following is freed by kernel after init
+	 * Alignment		4096
+	 * init.setup alignment	256	
+	 * ramfs alignment	256
+	 * percpu alignment	256
+	 * Note: includes MODULE_PARAM, which is unused on S390
+	 **/
+	INIT_SECTION_CMD(4096, 256, 256, 256)
+
+	/* start = .
+	 * align = 1
+	 */
+	BSS(., 1)
+
+	_end = . ;
+
+	DISCARD_SECTION_CMD
 
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+	/* Stabs debugging sections.  */
+	STABS_DEBUG
 }
===== arch/sparc64/vmlinux.lds.S 1.13 vs edited =====
--- 1.13/arch/sparc64/vmlinux.lds.S	Tue Dec  3 02:03:16 2002
+++ edited/arch/sparc64/vmlinux.lds.S	Sun Jan 12 22:54:07 2003
@@ -1,4 +1,7 @@
 /* ld script to make UltraLinux kernel */
+
+#include <asm-generic/vmlinux.lds>
+
 OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
 OUTPUT_ARCH(sparc:v9a)
 ENTRY(_start)
@@ -6,98 +9,63 @@
 jiffies = jiffies_64;
 SECTIONS
 {
-  swapper_pmd_dir = 0x0000000000402000;
-  empty_pg_dir = 0x0000000000403000;
-  . = 0x4000;
-  .text 0x0000000000404000 :
-  {
-    *(.text)
-    *(.gnu.warning)
-  } =0
-  _etext = .;
-  PROVIDE (etext = .);
-  .rodata    : { *(.rodata) *(.rodata.*) }
-  .rodata1   : { *(.rodata1) }
-  .data    :
-  {
-    *(.data)
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  . = ALIGN(64);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-  _edata  =  .;
-  PROVIDE (edata = .);
-  .fixup   : { *(.fixup) }
-
-  . = ALIGN(16);
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  . = ALIGN(64);
-  __start___ksymtab = .;
-  __ksymtab  : { *(__ksymtab) }
-  __stop___ksymtab = .;
-  __kstrtab  : { *(.kstrtab) }
-  __start___kallsyms = .;	/* All kernel symbols */
-  __kallsyms : { *(__kallsyms) }
-  __stop___kallsyms = .;
-  . = ALIGN(8192);
-  __init_begin = .;
-  .init.text : { *(.init.text) }
-  .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
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
-  . = ALIGN(8192); 
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
-  __per_cpu_end = .;
-  . = ALIGN(8192);
-  __init_end = .;
-  __bss_start = .;
-  .sbss      : { *(.sbss) *(.scommon) }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
-  _end = . ;
-  PROVIDE (end = .);
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-  .debug          0 : { *(.debug) }
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  .line           0 : { *(.line) }
-  /DISCARD/ : { *(.exit.text) *(.exit.data) *(.exitcall.exit) }
+	swapper_pmd_dir = 0x0000000000402000;
+	empty_pg_dir = 0x0000000000403000;
+
+	. = 0x4000;
+	.text 0x0000000000404000 : {
+		*(.text)
+	*(.gnu.warning)
+	} =0
+	_etext = .;
+	PROVIDE (etext = .);
+
+	RODATA
+	.rodata1   : { *(.rodata1) }
+
+	DATA_SECTION_START(.)
+	{
+		DATA_SECTION
+	}
+  		.data1   : { *(.data1) }
+		DATA_CACHELINE_ALIGN(64)
+	DATA_SECTION_END
+
+	.fixup   : { *(.fixup) }
+
+	EXCEPTIONTABLE(16)
+
+	KERNEL_SYMBOLS
+	/* The following is freed by kernel after init
+	 * Alignment		8192
+	 * init.setup alignment	16
+	 * ramfs alignment	8192
+	 * percpu alignment	32
+	 **/
+	INIT_SECTION_CMD(8192, 16, 8192, 32)
+
+	__bss_start = .;
+	.sbss      : {
+		*(.sbss)
+		*(.scommon)
+	}
+	.bss       : {
+		*(.dynbss)
+		*(.bss)
+		*(COMMON)
+	}
+	_end = . ;
+	PROVIDE (end = .);
+
+	/* Stabs debugging sections.  */
+	STABS_DEBUG
+
+	.debug          0 : { *(.debug) }
+	.debug_srcinfo  0 : { *(.debug_srcinfo) }
+	.debug_aranges  0 : { *(.debug_aranges) }
+	.debug_pubnames 0 : { *(.debug_pubnames) }
+	.debug_sfnames  0 : { *(.debug_sfnames) }
+	.line           0 : { *(.line) }
+
+	DISCARD_SECTION_CMD
 }
