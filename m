Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVASHmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVASHmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVASHky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:40:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50367 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261621AbVASHdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:13 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/29] x86-vmlinux-fix-physical-addrs
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The vmlinux on i386 does not report the correct physical address of
the kernel.  Instead in the physical address field it currently
reports the virtual address of the kernel.

This is patch is a bug fix that corrects vmlinux to report the
proper physical addresses.

This is potentially a help for crash dump analysis tools.

This definitiely allows bootloaders that load vmlinux as a standard
ELF executable.  Bootloaders directly loading vmlinux become of
practical importance when we consider the kexec on panic case.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 vmlinux.lds.S |   59 +++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 38 insertions(+), 21 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-vmlinux-fix-physical-addrs/arch/i386/kernel/vmlinux.lds.S linux-2.6.11-rc1-mm1-nokexec-x86-vmlinux-fix-physical-addrs/arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.11-rc1-mm1-nokexec-vmlinux-fix-physical-addrs/arch/i386/kernel/vmlinux.lds.S	Mon Oct 18 15:53:43 2004
+++ linux-2.6.11-rc1-mm1-nokexec-x86-vmlinux-fix-physical-addrs/arch/i386/kernel/vmlinux.lds.S	Tue Jan 18 22:45:51 2005
@@ -2,20 +2,23 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
+#define LOAD_OFFSET __PAGE_OFFSET
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(startup_32)
+ENTRY(phys_startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = __PAGE_OFFSET + 0x100000;
+  . = LOAD_OFFSET + 0x100000;
+  phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
   _text = .;			/* Text and read-only data */
-  .text : {
+  .text : AT(ADDR(.text) - LOAD_OFFSET) {
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
@@ -27,49 +30,55 @@
 
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
+  .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) { 
+	*(.data.idt) 
+  }
 
   . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) {
+	*(.data.cacheline_aligned)
+  }
 
   _edata = .;			/* End of data section */
 
   . = ALIGN(THREAD_SIZE);	/* init_task */
-  .data.init_task : { *(.data.init_task) }
+  .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
+	*(.data.init_task) 
+  }
 
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
   __initcall_start = .;
-  .initcall.init : {
+  .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
 	*(.initcall1.init) 
 	*(.initcall2.init) 
 	*(.initcall3.init) 
@@ -80,33 +89,41 @@
   }
   __initcall_end = .;
   __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
+  .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
+	*(.con_initcall.init)
+  }
   __con_initcall_end = .;
   SECURITY_INIT
   . = ALIGN(4);
   __alt_instructions = .;
-  .altinstructions : { *(.altinstructions) } 
+  .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+	*(.altinstructions)
+  }
   __alt_instructions_end = .; 
- .altinstr_replacement : { *(.altinstr_replacement) } 
+  .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
+	*(.altinstr_replacement)
+  }
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
 	
   __bss_start = .;		/* BSS */
-  .bss : {
+  .bss.page_aligned : AT(ADDR(.bss.page_aligned) - LOAD_OFFSET) {
 	*(.bss.page_aligned)
+  }
+  .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 	*(.bss)
   }
   . = ALIGN(4);
