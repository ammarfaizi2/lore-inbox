Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270538AbUJUKsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270538AbUJUKsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbUJUKr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:47:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2176 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S270538AbUJUKpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:45:31 -0400
Message-ID: <41779345.8080009@in.ibm.com>
Date: Thu, 21 Oct 2004 16:15:25 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vara Prasad <varap@us.ibm.com>
Subject: [PATCH][1/4] kexec based dump: Loading kernel from non-default offset
References: <417792BA.8090205@in.ibm.com>
In-Reply-To: <417792BA.8090205@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080209060304090806010200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080209060304090806010200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch makes it possible for us to load i386 kernels 
from non-default physical addresses.

Regards, Hari

--------------080209060304090806010200
Content-Type: text/plain;
 name="kd-kern-offset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kd-kern-offset.patch"


Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-old-hari/arch/i386/Kconfig                 |   10 ++++
 linux-old-hari/arch/i386/boot/compressed/head.S  |    6 +-
 linux-old-hari/arch/i386/boot/compressed/misc.c  |    7 +-
 linux-old-hari/arch/i386/kernel/vmlinux.lds.S    |   56 +++++++++++++----------
 linux-old-hari/include/asm-generic/vmlinux.lds.h |    2 
 linux-old-hari/include/asm-i386/segment.h        |    2 
 6 files changed, 54 insertions(+), 29 deletions(-)

diff -puN arch/i386/Kconfig~kd-kern-offset arch/i386/Kconfig
--- linux-old/arch/i386/Kconfig~kd-kern-offset	2004-10-19 19:00:17.000000000 +0530
+++ linux-old-hari/arch/i386/Kconfig	2004-10-19 19:03:47.000000000 +0530
@@ -882,6 +882,16 @@ config REGPARM
 
 source "drivers/perfctr/Kconfig"
 
+config KERN_PHYS_OFFSET
+	int "Physical address where the kernel is loaded (1-112)MB"
+	range 1 112
+	default "1"
+	help
+	  This gives the physical address where the kernel is loaded.
+	  Primarily used in the case of kexec on panic where the
+	  recovery kernel needs to run at a different address than
+	  the panic-ed kernel.
+
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff -puN arch/i386/boot/compressed/head.S~kd-kern-offset arch/i386/boot/compressed/head.S
--- linux-old/arch/i386/boot/compressed/head.S~kd-kern-offset	2004-10-19 19:04:55.000000000 +0530
+++ linux-old-hari/arch/i386/boot/compressed/head.S	2004-10-19 19:06:02.000000000 +0530
@@ -74,7 +74,7 @@ startup_32:
 	popl %esi	# discard address
 	popl %esi	# real mode pointer
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $0x100000
+	ljmp $(__BOOT_CS), $KERN_PHYS_OFFSET
 
 /*
  * We come here, if we were loaded high.
@@ -99,7 +99,7 @@ startup_32:
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
-	movl $0x100000,%edi
+	movl $KERN_PHYS_OFFSET,%edi
 	cli		# make sure we don't get interrupted
 	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine
 
@@ -124,5 +124,5 @@ move_routine_start:
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $0x100000
+	ljmp $(__BOOT_CS), $KERN_PHYS_OFFSET
 move_routine_end:
diff -puN arch/i386/boot/compressed/misc.c~kd-kern-offset arch/i386/boot/compressed/misc.c
--- linux-old/arch/i386/boot/compressed/misc.c~kd-kern-offset	2004-10-19 19:04:55.000000000 +0530
+++ linux-old-hari/arch/i386/boot/compressed/misc.c	2004-10-19 19:08:07.000000000 +0530
@@ -14,6 +14,7 @@
 #include <linux/tty.h>
 #include <video/edid.h>
 #include <asm/io.h>
+#include <asm/segment.h>
 
 /*
  * gzip declarations
@@ -309,7 +310,7 @@ static void setup_normal_output_buffer(v
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (char *)0x100000; /* Points to 1M */
+	output_data = (char *)KERN_PHYS_OFFSET; /* Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -334,8 +335,8 @@ static void setup_output_buffer_if_we_ru
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
 	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (0x100000 + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(0x100000 + low_buffer_size);
+	if ( (KERN_PHYS_OFFSET + low_buffer_size) > ((ulg)high_buffer_start)) {
+		high_buffer_start = (uch *)(KERN_PHYS_OFFSET + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
diff -puN include/asm-i386/segment.h~kd-kern-offset include/asm-i386/segment.h
--- linux-old/include/asm-i386/segment.h~kd-kern-offset	2004-10-19 19:09:19.000000000 +0530
+++ linux-old-hari/include/asm-i386/segment.h	2004-10-19 19:09:59.000000000 +0530
@@ -95,4 +95,6 @@
  */
 #define IDT_ENTRIES 256
 
+#define KERN_PHYS_OFFSET (CONFIG_KERN_PHYS_OFFSET * 0x100000)
+
 #endif
diff -puN include/asm-generic/vmlinux.lds.h~kd-kern-offset include/asm-generic/vmlinux.lds.h
--- linux-old/include/asm-generic/vmlinux.lds.h~kd-kern-offset	2004-10-19 19:09:19.000000000 +0530
+++ linux-old-hari/include/asm-generic/vmlinux.lds.h	2004-10-19 19:21:09.000000000 +0530
@@ -70,7 +70,7 @@
 	}
 
 #define SECURITY_INIT							\
-	.security_initcall.init : {					\
+	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) {\
 		VMLINUX_SYMBOL(__security_initcall_start) = .;		\
 		*(.security_initcall.init) 				\
 		VMLINUX_SYMBOL(__security_initcall_end) = .;		\
diff -puN arch/i386/kernel/vmlinux.lds.S~kd-kern-offset arch/i386/kernel/vmlinux.lds.S
--- linux-old/arch/i386/kernel/vmlinux.lds.S~kd-kern-offset	2004-10-19 19:33:47.000000000 +0530
+++ linux-old-hari/arch/i386/kernel/vmlinux.lds.S	2004-10-19 19:43:27.000000000 +0530
@@ -2,20 +2,24 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
+#define LOAD_OFFSET __PAGE_OFFSET
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <asm/segment.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(startup_32)
+ENTRY(phys_startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = __PAGE_OFFSET + 0x100000;
+  . = LOAD_OFFSET + KERN_PHYS_OFFSET;
+  phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
   _text = .;			/* Text and read-only data */
-  .text : {
+  .text : AT(ADDR(.text) - LOAD_OFFSET) {
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
@@ -27,49 +31,51 @@ SECTIONS
 
   . = ALIGN(16);		/* Exception table */
   __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
+  __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { *(__ex_table) }
   __stop___ex_table = .;
 
   RODATA
 
   /* writeable */
-  .data : {			/* Data */
+  .data : AT(ADDR(.data) - LOAD_OFFSET) {			/* Data */
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
+  .data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) {
+	*(.data.cacheline_aligned)
+  }
 
   _edata = .;			/* End of data section */
 
   . = ALIGN(THREAD_SIZE);	/* init_task */
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
   __initcall_start = .;
-  .initcall.init : {
+  .initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
 	*(.initcall1.init) 
 	*(.initcall2.init) 
 	*(.initcall3.init) 
@@ -80,32 +86,38 @@ SECTIONS
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
-  __alt_instructions_end = .; 
- .altinstr_replacement : { *(.altinstr_replacement) } 
+  .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
+	*(.altinstructions)
+  }
+  __alt_instructions_end = .;
+ .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
+	*(.altinstr_replacement)
+ }
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
+  .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 	*(.bss.page_aligned)
 	*(.bss)
   }
_

--------------080209060304090806010200--
