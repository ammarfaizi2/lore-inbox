Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVG2TjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVG2TjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVG2TgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:36:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3466 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262755AbVG2TfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:35:13 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: vmlinux.lds.S Distinguish absolute symbols
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 13:35:04 -0600
Message-ID: <m1u0id1k47.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ld knows about 2 kinds of symbols,  absolute and section
relative.  Section relative symbols symbols change value
when a section is moved and absolute symbols do not.

Currently in the linker script we have several labels
marking the beginning and ending of sections that
are outside of sections, making them absolute symbols.
Having a mixture of absolute and section relative
symbols refereing to the same data is currently harmless
but it is confusing.

My ultimate goal is to build a relocatable kernel.  The
safest and least intrusive technique is to generate
relocation entries so the kernel can be relocated at load
time.  The only penalty would be an increase in the size
of the kernel binary.  The problem is that if absolute and
relocatable symbols are not properly specified absolute symbols
will be relocated or section relative symbols won't be, which
is fatal.

The practical motivation is that when generating kernels that
will run from a reserved area for analyzing what caused
a kernel panic, it is simpler if you don't need to hard code
the physical memory location they will run at, especially
for the distributions.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/i386/kernel/vmlinux.lds.S |   90 ++++++++++++++++++++++++----------------
 1 files changed, 55 insertions(+), 35 deletions(-)

070fe8129c7762d256bfa012a08a6687e1f69071
diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -17,21 +17,22 @@ SECTIONS
   . = __KERNEL_START;
   phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
-  _text = .;			/* Text and read-only data */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
+	  _text = .;		/* Text and read-only data */
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x9090
-
-  _etext = .;			/* End of text section */
+	_etext = .;		/* End of text section */
+  } = 0x9090
 
   . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { *(__ex_table) }
-  __stop___ex_table = .;
+  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { 
+	__start___ex_table = .;
+	*(__ex_table) 
+	__stop___ex_table = .;
+  }
 
   RODATA
 
@@ -39,13 +40,15 @@ SECTIONS
   .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
 	*(.data)
 	CONSTRUCTORS
-	}
+  }
 
   . = ALIGN(4096);
-  __nosave_begin = .;
-  .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) { *(.data.nosave) }
-  . = ALIGN(4096);
-  __nosave_end = .;
+  .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) { 
+	__nosave_begin = .;
+	*(.data.nosave) 
+	. = ALIGN(4096);
+	__nosave_end = .;
+  }
 
   . = ALIGN(4096);
   .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
@@ -60,7 +63,9 @@ SECTIONS
   /* rarely changed data like cpu maps */
   . = ALIGN(32);
   .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) { *(.data.read_mostly) }
-  _edata = .;			/* End of data section */
+  .data.end : AT(ADDR(.data.end) - LOAD_OFFSET) {
+	_edata = .;		/* End of data section */
+  }	
 
   . = ALIGN(THREAD_SIZE);	/* init_task */
   .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
@@ -69,7 +74,9 @@ SECTIONS
 
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
+  .init.begin : AT(ADDR(.init.begin) - LOAD_OFFSET) {
+  	__init_begin = .;
+  }
   .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
 	_sinittext = .;
 	*(.init.text)
@@ -77,11 +84,13 @@ SECTIONS
   }
   .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) { *(.init.data) }
   . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) { *(.init.setup) }
-  __setup_end = .;
-  __initcall_start = .;
+  .init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
+	__setup_start = .;
+	*(.init.setup)
+	__setup_end = .;
+  }
   .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
+	__initcall_start = .;
 	*(.initcall1.init) 
 	*(.initcall2.init) 
 	*(.initcall3.init) 
@@ -89,20 +98,20 @@ SECTIONS
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	__initcall_end = .;
   }
-  __initcall_end = .;
-  __con_initcall_start = .;
   .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
+	__con_initcall_start = .;
 	*(.con_initcall.init)
+	__con_initcall_end = .;
   }
-  __con_initcall_end = .;
   SECURITY_INIT
   . = ALIGN(4);
-  __alt_instructions = .;
   .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+	__alt_instructions = .;
 	*(.altinstructions)
+	__alt_instructions_end = .;
   }
-  __alt_instructions_end = .; 
   .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
 	*(.altinstr_replacement)
   }
@@ -111,18 +120,26 @@ SECTIONS
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
   .exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) { *(.exit.data) }
   . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
-  __initramfs_end = .;
+  .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { 
+	__initramfs_start = .;
+	*(.init.ramfs)
+	__initramfs_end = .;
+  }
   . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
-  __per_cpu_end = .;
+  .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {
+	__per_cpu_start = .;
+	*(.data.percpu)
+	__per_cpu_end = .;
+  }
   . = ALIGN(4096);
-  __init_end = .;
+  .init.end : AT(ADDR(.init.end) - LOAD_OFFSET) {
+	__init_end = .;
+  }	
   /* freed after init ends here */
 	
-  __bss_start = .;		/* BSS */
+  .bss.start : AT(ADDR(.bss.start) - LOAD_OFFSET) {  
+	__bss_start = .;		/* BSS */
+  }
   .bss.page_aligned : AT(ADDR(.bss.page_aligned) - LOAD_OFFSET) {
 	*(.bss.page_aligned)
   }
@@ -130,13 +147,16 @@ SECTIONS
 	*(.bss)
   }
   . = ALIGN(4);
-  __bss_stop = .; 
-
-  _end = . ;
+  .bss.end : AT(ADDR(.bss.end) - LOAD_OFFSET) {	
+  	__bss_stop = .; 
+  	_end = . ;
+  }
 
   /* This is where the kernel creates the early boot page tables */
   . = ALIGN(4096);
-  pg0 = .;
+  .pg : AT(ADDR(.pg) - LOAD_OFFSET) {	
+	pg0 = .;
+  }
 
   /* Sections to be discarded */
   /DISCARD/ : {
