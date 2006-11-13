Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754410AbWKMQyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbWKMQyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218AbWKMQyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:54:08 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:64654 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755210AbWKMQxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:53:54 -0500
Date: Mon, 13 Nov 2006 11:48:34 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 14/16] x86_64: Remove CONFIG_PHYSICAL_START
Message-ID: <20061113164834.GO17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am about to add relocatable kernel support which has essentially
no cost so there is no point in retaining CONFIG_PHYSICAL_START
and retaining CONFIG_PHYSICAL_START makes implementation of and
testing of a relocatable kernel more difficult.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/Kconfig                |   19 -------------------
 arch/x86_64/boot/compressed/head.S |    6 +++---
 arch/x86_64/boot/compressed/misc.c |    6 +++---
 arch/x86_64/defconfig              |    1 -
 arch/x86_64/kernel/vmlinux.lds.S   |    2 +-
 arch/x86_64/mm/fault.c             |    4 ++--
 include/asm-x86_64/page.h          |    2 --
 7 files changed, 9 insertions(+), 31 deletions(-)

diff -puN arch/x86_64/boot/compressed/head.S~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/boot/compressed/head.S
--- linux-2.6.19-rc5-reloc/arch/x86_64/boot/compressed/head.S~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-09 23:05:52.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/boot/compressed/head.S	2006-11-09 23:05:52.000000000 -0500
@@ -76,7 +76,7 @@ startup_32:
 	jnz  3f
 	addl $8,%esp
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $__PHYSICAL_START
+	ljmp $(__KERNEL_CS), $0x200000
 
 /*
  * We come here, if we were loaded high.
@@ -102,7 +102,7 @@ startup_32:
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
-	movl $__PHYSICAL_START,%edi
+	movl $0x200000,%edi
 	cli		# make sure we don't get interrupted
 	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
 
@@ -127,7 +127,7 @@ move_routine_start:
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $__PHYSICAL_START
+	ljmp $(__KERNEL_CS), $0x200000
 move_routine_end:
 
 
diff -puN arch/x86_64/boot/compressed/misc.c~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/boot/compressed/misc.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/boot/compressed/misc.c~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-09 23:05:52.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/boot/compressed/misc.c	2006-11-09 23:05:52.000000000 -0500
@@ -288,7 +288,7 @@ static void setup_normal_output_buffer(v
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (unsigned char *)__PHYSICAL_START; /* Normally Points to 1M */
+	output_data = (unsigned char *)0x200000;
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -311,8 +311,8 @@ static void setup_output_buffer_if_we_ru
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
 	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (__PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(__PHYSICAL_START + low_buffer_size);
+	if ( (0x200000 + low_buffer_size) > ((ulg)high_buffer_start)) {
+		high_buffer_start = (uch *)(0x200000 + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
diff -puN arch/x86_64/defconfig~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/defconfig
--- linux-2.6.19-rc5-reloc/arch/x86_64/defconfig~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-09 23:05:52.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/defconfig	2006-11-09 23:05:52.000000000 -0500
@@ -165,7 +165,6 @@ CONFIG_X86_MCE_INTEL=y
 CONFIG_X86_MCE_AMD=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-CONFIG_PHYSICAL_START=0x200000
 CONFIG_SECCOMP=y
 # CONFIG_CC_STACKPROTECTOR is not set
 # CONFIG_HZ_100 is not set
diff -puN arch/x86_64/Kconfig~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/Kconfig
--- linux-2.6.19-rc5-reloc/arch/x86_64/Kconfig~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-09 23:05:52.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/Kconfig	2006-11-09 23:05:52.000000000 -0500
@@ -513,25 +513,6 @@ config CRASH_DUMP
 	  PHYSICAL_START.
           For more details see Documentation/kdump/kdump.txt
 
-config PHYSICAL_START
-	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
-	default "0x1000000" if CRASH_DUMP
-	default "0x200000"
-	help
-	  This gives the physical address where the kernel is loaded. Normally
-	  for regular kernels this value is 0x200000 (2MB). But in the case
-	  of kexec on panic the fail safe kernel needs to run at a different
-	  address than the panic-ed kernel. This option is used to set the load
-	  address for kernels used to capture crash dump on being kexec'ed
-	  after panic. The default value for crash dump kernels is
-	  0x1000000 (16MB). This can also be set based on the "X" value as
-	  specified in the "crashkernel=YM@XM" command line boot parameter
-	  passed to the panic-ed kernel. Typically this parameter is set as
-	  crashkernel=64M@16M. Please take a look at
-	  Documentation/kdump/kdump.txt for more details about crash dumps.
-
-	  Don't change this unless you know what you are doing.
-
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff -puN arch/x86_64/kernel/vmlinux.lds.S~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/vmlinux.lds.S~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-09 23:05:52.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/vmlinux.lds.S	2006-11-09 23:05:52.000000000 -0500
@@ -22,7 +22,7 @@ PHDRS {
 }
 SECTIONS
 {
-  . = __START_KERNEL;
+  . = __START_KERNEL_map + 0x200000;
   phys_startup_64 = startup_64 - LOAD_OFFSET;
   _text = .;			/* Text and read-only data */
   .text :  AT(ADDR(.text) - LOAD_OFFSET) {
diff -puN arch/x86_64/mm/fault.c~x86_64-Remove-CONFIG_PHYSICAL_START arch/x86_64/mm/fault.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/mm/fault.c~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-09 23:05:52.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/mm/fault.c	2006-11-09 23:05:52.000000000 -0500
@@ -644,9 +644,9 @@ void vmalloc_sync_all(void)
 			start = address + PGDIR_SIZE;
 	}
 	/* Check that there is no need to do the same for the modules area. */
-	BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
+	BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL_map));
 	BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) == 
-				(__START_KERNEL & PGDIR_MASK)));
+				(__START_KERNEL_map & PGDIR_MASK)));
 }
 
 static int __init enable_pagefaulttrace(char *str)
diff -puN include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START include/asm-x86_64/page.h
--- linux-2.6.19-rc5-reloc/include/asm-x86_64/page.h~x86_64-Remove-CONFIG_PHYSICAL_START	2006-11-09 23:05:52.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/include/asm-x86_64/page.h	2006-11-09 23:05:52.000000000 -0500
@@ -75,8 +75,6 @@ typedef struct { unsigned long pgprot; }
 
 #endif /* !__ASSEMBLY__ */
 
-#define __PHYSICAL_START	_AC(CONFIG_PHYSICAL_START,UL)
-#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
 #define __START_KERNEL_map	_AC(0xffffffff80000000,UL)
 #define __PAGE_OFFSET           _AC(0xffff810000000000,UL)
 
_
