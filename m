Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVASIMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVASIMM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVASILg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:11:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55999 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261615AbVASHdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:50 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/29] x86_64-vmlinux-fix-physical-addrs
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The vmlinux on x86_64 does not report the correct physical address of
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

 Makefile             |    2 
 kernel/vmlinux.lds.S |  130 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 88 insertions(+), 44 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-vmlinux-fix-physical-addrs/arch/x86_64/Makefile linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/Makefile
--- linux-2.6.11-rc1-mm1-nokexec-x86-vmlinux-fix-physical-addrs/arch/x86_64/Makefile	Fri Jan 14 04:28:33 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/Makefile	Tue Jan 18 22:46:07 2005
@@ -35,7 +35,7 @@
 
 LDFLAGS		:= -m elf_x86_64
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
-LDFLAGS_vmlinux := -e stext
+LDFLAGS_vmlinux :=
 
 CHECKFLAGS      += -D__x86_64__ -m64
 
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-vmlinux-fix-physical-addrs/arch/x86_64/kernel/vmlinux.lds.S linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.11-rc1-mm1-nokexec-x86-vmlinux-fix-physical-addrs/arch/x86_64/kernel/vmlinux.lds.S	Fri Jan  7 12:53:50 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-vmlinux-fix-physical-addrs/arch/x86_64/kernel/vmlinux.lds.S	Tue Jan 18 22:46:07 2005
@@ -2,36 +2,41 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
+#define LOAD_OFFSET __START_KERNEL_map
+
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
 #include <linux/config.h>
 
 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
 OUTPUT_ARCH(i386:x86-64)
-ENTRY(_start)
+ENTRY(stext)
 jiffies_64 = jiffies;
 SECTIONS
 {
-  . = 0xffffffff80100000;
+  . = __START_KERNEL;
   _text = .;			/* Text and read-only data */
-  .text : {
+  .text :  AT(ADDR(.text) - LOAD_OFFSET) {
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
+  				/* out-of-line lock text */
+  .text.lock : AT(ADDR(.text.lock) - LOAD_OFFSET) { *(.text.lock) }
 
   _etext = .;			/* End of text section */
 
   . = ALIGN(16);		/* Exception table */
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { *(__ex_table) }
   __stop___ex_table = .;
 
   RODATA
 
-  .data : {			/* Data */
+				/* Data */
+  .data : AT(ADDR(.data) - LOAD_OFFSET) {
 	*(.data)
 	CONSTRUCTORS
 	}
@@ -39,62 +44,95 @@
   _edata = .;			/* End of data section */
 
   __bss_start = .;		/* BSS */
-  .bss : {
+  .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 	*(.bss.page_aligned)	
 	*(.bss)
 	}
   __bss_end = .;
 
+  . = ALIGN(PAGE_SIZE);
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) {
+	*(.data.cacheline_aligned)
+  }
 
-#define AFTER(x)      BINALIGN(LOADADDR(x) + SIZEOF(x), 16)
-#define BINALIGN(x,y) (((x) + (y) - 1)  & ~((y) - 1))
-#define CACHE_ALIGN(x) BINALIGN(x, CONFIG_X86_L1_CACHE_BYTES)
+#define VSYSCALL_ADDR (-10*1024*1024)
+#define VSYSCALL_PHYS_ADDR ((LOADADDR(.data.cacheline_aligned) + SIZEOF(.data.cacheline_aligned) + 4095) & ~(4095))
+#define VSYSCALL_VIRT_ADDR ((ADDR(.data.cacheline_aligned) + SIZEOF(.data.cacheline_aligned) + 4095) & ~(4095))
+
+#define VLOAD_OFFSET (VSYSCALL_ADDR - VSYSCALL_PHYS_ADDR)
+#define VLOAD(x) (ADDR(x) - VLOAD_OFFSET)
+
+#define VVIRT_OFFSET (VSYSCALL_ADDR - VSYSCALL_VIRT_ADDR)
+#define VVIRT(x) (ADDR(x) - VVIRT_OFFSET)
+
+  . = VSYSCALL_ADDR;
+  .vsyscall_0 :	 AT(VSYSCALL_PHYS_ADDR) { *(.vsyscall_0) }
+  __vsyscall_0 = VSYSCALL_VIRT_ADDR;
 
-  .vsyscall_0 -10*1024*1024: AT ((LOADADDR(.data.cacheline_aligned) + SIZEOF(.data.cacheline_aligned) + 4095) & ~(4095)) { *(.vsyscall_0) }
-  __vsyscall_0 = LOADADDR(.vsyscall_0);
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .xtime_lock : AT CACHE_ALIGN(AFTER(.vsyscall_0)) { *(.xtime_lock) }
-  xtime_lock = LOADADDR(.xtime_lock);
-  .vxtime : AT AFTER(.xtime_lock) { *(.vxtime) }
-  vxtime = LOADADDR(.vxtime);
-  .wall_jiffies : AT AFTER(.vxtime) { *(.wall_jiffies) }
-  wall_jiffies = LOADADDR(.wall_jiffies);
-  .sys_tz : AT AFTER(.wall_jiffies) { *(.sys_tz) }
-  sys_tz = LOADADDR(.sys_tz);
-  .sysctl_vsyscall : AT AFTER(.sys_tz) { *(.sysctl_vsyscall) }
-  sysctl_vsyscall = LOADADDR(.sysctl_vsyscall); 
-  .xtime : AT AFTER(.sysctl_vsyscall) { *(.xtime) }
-  xtime = LOADADDR(.xtime);
+  .xtime_lock : AT(VLOAD(.xtime_lock)) { *(.xtime_lock) }
+  xtime_lock = VVIRT(.xtime_lock);
+
+  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
+  vxtime = VVIRT(.vxtime);
+
+  .wall_jiffies : AT(VLOAD(.wall_jiffies)) { *(.wall_jiffies) }
+  wall_jiffies = VVIRT(.wall_jiffies);
+
+  .sys_tz : AT(VLOAD(.sys_tz)) { *(.sys_tz) }
+  sys_tz = VVIRT(.sys_tz);
+
+  .sysctl_vsyscall : AT(VLOAD(.sysctl_vsyscall)) { *(.sysctl_vsyscall) }
+  sysctl_vsyscall = VVIRT(.sysctl_vsyscall);
+
+  .xtime : AT(VLOAD(.xtime)) { *(.xtime) }
+  xtime = VVIRT(.xtime);
+
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
-  .jiffies : AT CACHE_ALIGN(AFTER(.xtime)) { *(.jiffies) }
-  jiffies = LOADADDR(.jiffies);
-  .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT (LOADADDR(.vsyscall_0) + 1024) { *(.vsyscall_1) }
-  . = LOADADDR(.vsyscall_0) + 4096;
+  .jiffies : AT(VLOAD(.jiffies)) { *(.jiffies) }
+  jiffies = VVIRT(.jiffies);
+
+  .vsyscall_1 ADDR(.vsyscall_0) + 1024: AT(VLOAD(.vsyscall_1)) { *(.vsyscall_1) }
+  .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
+  .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) { *(.vsyscall_3) }
+
+  . = VSYSCALL_VIRT_ADDR + 4096;
+
+#undef VSYSCALL_ADDR
+#undef VSYSCALL_PHYS_ADDR
+#undef VSYSCALL_VIRT_ADDR
+#undef VLOAD_OFFSET
+#undef VLOAD
+#undef VVIRT_OFFSET
+#undef VVIRT
 
   . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
+  .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
+	*(.data.init_task)
+  }
 
   . = ALIGN(4096);
-  .data.page_aligned : { *(.data.page_aligned) }
+  .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
+	*(.data.page_aligned)
+  }
 
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .init.text : { 
+  .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
 	_sinittext = .;
 	*(.init.text)
 	_einittext = .;
   }
   __initdata_begin = .;
-  .init.data : { *(.init.data) }
+  .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) { *(.init.data) }
   __initdata_end = .;
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
@@ -105,32 +143,38 @@
   }
   __initcall_end = .;
   __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
+  .con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
+	*(.con_initcall.init)
+  }
   __con_initcall_end = .;
   SECURITY_INIT
   . = ALIGN(8);
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
+  .exit.data : AT(ADDR(.ext.data) - LOAD_OFFSET) { *(.exit.data) }
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
 
   . = ALIGN(4096);
   __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
+  .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) { *(.data.nosave) }
   . = ALIGN(4096);
   __nosave_end = .;
 
