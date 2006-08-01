Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWHALRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWHALRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161371AbWHALQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:16:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4317 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932651AbWHALFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:47 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/33] i386: vmlinux.lds.S Distinguish absolute symbols
Date: Tue,  1 Aug 2006 05:03:16 -0600
Message-Id: <11544302283864-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
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

This must be done carefully as newer revs of ld do not place
symbols that appear in sections without data and instead
ld makes those symbols global :(

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
 arch/i386/kernel/vmlinux.lds.S    |  111 ++++++++++++++++++++-----------------
 include/asm-generic/vmlinux.lds.h |    2 -
 2 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 2d4f138..db0833b 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -18,43 +18,46 @@ SECTIONS
   . = __KERNEL_START;
   phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
-  _text = .;			/* Text and read-only data */
   .text : AT(ADDR(.text) - LOAD_OFFSET) {
+	_text = .;		/* Text and read-only data */
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
 	KPROBES_TEXT
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
 
   . = ALIGN(4);
-  __tracedata_start = .;
   .tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {
+	__tracedata_start = .;
 	*(.tracedata)
+	__tracedata_end = .;
   }
-  __tracedata_end = .;
 
   /* writeable */
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
@@ -68,8 +71,10 @@ SECTIONS
 
   /* rarely changed data like cpu maps */
   . = ALIGN(32);
-  .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) { *(.data.read_mostly) }
-  _edata = .;			/* End of data section */
+  .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) {
+	*(.data.read_mostly)
+	_edata = .;		/* End of data section */
+  }
 
 #ifdef CONFIG_STACK_UNWIND
   . = ALIGN(4);
@@ -87,39 +92,41 @@ #endif
 
   /* might get freed after init */
   . = ALIGN(4096);
-  __smp_alt_begin = .;
-  __smp_alt_instructions = .;
   .smp_altinstructions : AT(ADDR(.smp_altinstructions) - LOAD_OFFSET) {
+	__smp_alt_begin = .;
+	__smp_alt_instructions = .;
 	*(.smp_altinstructions)
+	__smp_alt_instructions_end = .;
   }
-  __smp_alt_instructions_end = .;
   . = ALIGN(4);
-  __smp_locks = .;
   .smp_locks : AT(ADDR(.smp_locks) - LOAD_OFFSET) {
+	__smp_locks = .;
 	*(.smp_locks)
+	__smp_locks_end = .;
   }
-  __smp_locks_end = .;
   .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
 	*(.smp_altinstr_replacement)
+	. = ALIGN(4096);
+	__smp_alt_end = .;
   }
-  . = ALIGN(4096);
-  __smp_alt_end = .;
 
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
   .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
+  	__init_begin = .;
 	_sinittext = .;
 	*(.init.text)
 	_einittext = .;
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
@@ -127,20 +134,20 @@ #endif
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
@@ -149,32 +156,32 @@ #endif
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
   . = ALIGN(L1_CACHE_BYTES);
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
   /* freed after init ends here */
 	
-  __bss_start = .;		/* BSS */
-  .bss.page_aligned : AT(ADDR(.bss.page_aligned) - LOAD_OFFSET) {
-	*(.bss.page_aligned)
-  }
   .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
+	__init_end = .;
+	__bss_start = .;		/* BSS */
+	*(.bss.page_aligned)
 	*(.bss)
+	. = ALIGN(4);
+	__bss_stop = .;
+  	_end = . ;
+	/* This is where the kernel creates the early boot page tables */
+	. = ALIGN(4096);
+	pg0 = . ;
   }
-  . = ALIGN(4);
-  __bss_stop = .; 
-
-  _end = . ;
-
-  /* This is where the kernel creates the early boot page tables */
-  . = ALIGN(4096);
-  pg0 = .;
 
   /* Sections to be discarded */
   /DISCARD/ : {
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db5a373..7cd3c22 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -11,8 +11,8 @@ #define ALIGN_FUNCTION()  . = ALIGN(8)
 
 #define RODATA								\
 	. = ALIGN(4096);						\
-	__start_rodata = .;						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
+		VMLINUX_SYMBOL(__start_rodata) = .;			\
 		*(.rodata) *(.rodata.*)					\
 		*(__vermagic)		/* Kernel version magic */	\
 	}								\
-- 
1.4.2.rc2.g5209e

