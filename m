Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVASIMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVASIMM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVASIJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:09:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55743 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261633AbVASHdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:50 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/29] x86_64-config-kernel-start
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
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
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



For one kernel to report a crash another kernel has created we need
to have 2 kernels loaded simultaneously in memory.  To accomplish this
the two kernels need to built to run at different physical addresses.

This patch adds the CONFIG_PHYSICAL_START option to the x86_64 kernel
so we can do just that.  You need to know what you are doing and
the ramifications are before changing this value, and most users
won't care so I have made it depend on CONFIG_EMBEDDED

bzImage kernels will work and run at a different address when compiled
with this option but they will still load at 1MB.  If you need a kernel
loaded at a different address as well you need to boot a vmlinux.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 arch/x86_64/Kconfig                |   11 +++++++++++
 arch/x86_64/boot/compressed/head.S |    7 ++++---
 arch/x86_64/boot/compressed/misc.c |    7 ++++---
 arch/x86_64/kernel/head.S          |   18 +++++++++---------
 include/asm-x86_64/page.h          |    6 ++++--
 5 files changed, 32 insertions(+), 17 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/x86_64/Kconfig linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/arch/x86_64/Kconfig
--- linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/x86_64/Kconfig	Fri Jan 14 04:32:23 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/arch/x86_64/Kconfig	Tue Jan 18 22:46:57 2005
@@ -359,6 +359,17 @@
 	help
 	   Additional support for intel specific MCE features such as
 	   the thermal monitor.
+
+config PHYSICAL_START
+	hex "Physical address where the kernel is loaded" if EMBEDDED
+	default "0x100000"
+	help
+	  This gives the physical address where the kernel is loaded.
+	  Primarily used in the case of kexec on panic where the
+	  fail safe kernel needs to run at a different address than
+	  the panic-ed kernel.
+          
+	  Don't change this unless you know what you are doing.
 endmenu
 
 #
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/x86_64/boot/compressed/head.S linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/arch/x86_64/boot/compressed/head.S
--- linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/x86_64/boot/compressed/head.S	Mon Oct 18 15:55:28 2004
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/arch/x86_64/boot/compressed/head.S	Tue Jan 18 22:46:57 2005
@@ -28,6 +28,7 @@
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/page.h>
 
 	.code32
 	.globl startup_32
@@ -77,7 +78,7 @@
 	jnz  3f
 	addl $8,%esp
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+	ljmp $(__KERNEL_CS), $__PHYSICAL_START
 
 /*
  * We come here, if we were loaded high.
@@ -103,7 +104,7 @@
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
-	movl $0x100000,%edi
+	movl $__PHYSICAL_START,%edi
 	cli		# make sure we don't get interrupted
 	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
 
@@ -128,7 +129,7 @@
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__KERNEL_CS), $0x100000
+	ljmp $(__KERNEL_CS), $__PHYSICAL_START
 move_routine_end:
 
 
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/x86_64/boot/compressed/misc.c linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/arch/x86_64/boot/compressed/misc.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/x86_64/boot/compressed/misc.c	Mon Oct 18 15:53:51 2004
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/arch/x86_64/boot/compressed/misc.c	Tue Jan 18 22:46:57 2005
@@ -11,6 +11,7 @@
 
 #include "miscsetup.h"
 #include <asm/io.h>
+#include <asm/page.h>
 
 /*
  * gzip declarations
@@ -284,7 +285,7 @@
 #else
 	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (char *)0x100000; /* Points to 1M */
+	output_data = (char *)__PHYSICAL_START; /* Normally Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -307,8 +308,8 @@
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
 	high_loaded = 1;
 	free_mem_end_ptr = (long)high_buffer_start;
-	if ( (0x100000 + low_buffer_size) > ((ulg)high_buffer_start)) {
-		high_buffer_start = (uch *)(0x100000 + low_buffer_size);
+	if ( (__PHYSICAL_START + low_buffer_size) > ((ulg)high_buffer_start)) {
+		high_buffer_start = (uch *)(__PHYSICAL_START + low_buffer_size);
 		mv->hcount = 0; /* say: we need not to move high_buffer */
 	}
 	else mv->hcount = -1;
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/x86_64/kernel/head.S linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/arch/x86_64/kernel/head.S
--- linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/x86_64/kernel/head.S	Tue Jan 18 22:46:24 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/arch/x86_64/kernel/head.S	Tue Jan 18 22:46:57 2005
@@ -235,23 +235,23 @@
 	 */
 .org 0x1000
 ENTRY(init_level4_pgt)
-	.quad	0x0000000000102007		/* -> level3_ident_pgt */
+	.quad	0x0000000000002007 + __PHYSICAL_START	/* -> level3_ident_pgt */
 	.fill	255,8,0
-	.quad	0x000000000010a007
+	.quad	0x000000000000a007 + __PHYSICAL_START
 	.fill	254,8,0
 	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
-	.quad	0x0000000000103007		/* -> level3_kernel_pgt */
+	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
 
 .org 0x2000
 ENTRY(level3_ident_pgt)
-	.quad	0x0000000000104007
+	.quad	0x0000000000004007 + __PHYSICAL_START
 	.fill	511,8,0
 
 .org 0x3000
 ENTRY(level3_kernel_pgt)
 	.fill	510,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
-	.quad	0x0000000000105007		/* -> level2_kernel_pgt */
+	.quad	0x0000000000005007 + __PHYSICAL_START	/* -> level2_kernel_pgt */
 	.fill	1,8,0
 
 .org 0x4000
@@ -324,17 +324,17 @@
 
 .org 0xa000
 ENTRY(level3_physmem_pgt)
-	.quad	0x0000000000105007		/* -> level2_kernel_pgt (so that __va works even before pagetable_init) */
+	.quad	0x0000000000005007 + __PHYSICAL_START	/* -> level2_kernel_pgt (so that __va works even before pagetable_init) */
 
 	.org 0xb000
 #ifdef CONFIG_ACPI_SLEEP
 ENTRY(wakeup_level4_pgt)
-	.quad	0x0000000000102007		/* -> level3_ident_pgt */
+	.quad	0x0000000000002007 + __PHYSICAL_START	/* -> level3_ident_pgt */
 	.fill	255,8,0
-	.quad	0x000000000010a007
+	.quad	0x000000000000a007 + __PHYSICAL_START
 	.fill	254,8,0
 	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
-	.quad	0x0000000000103007		/* -> level3_kernel_pgt */
+	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
 #endif
 
 	.data
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/include/asm-x86_64/page.h linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/include/asm-x86_64/page.h
--- linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/include/asm-x86_64/page.h	Fri Jan 14 04:32:27 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86_64-config-kernel-start/include/asm-x86_64/page.h	Tue Jan 18 22:46:57 2005
@@ -65,12 +65,14 @@
 extern unsigned long vm_data_default_flags, vm_data_default_flags32;
 extern unsigned long vm_force_exec32;
 
-#define __START_KERNEL		0xffffffff80100000UL
+#define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
+#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
 #define __START_KERNEL_map	0xffffffff80000000UL
 #define __PAGE_OFFSET           0xffff810000000000UL
 
 #else
-#define __START_KERNEL		0xffffffff80100000
+#define __PHYSICAL_START	CONFIG_PHYSICAL_START
+#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
 #define __START_KERNEL_map	0xffffffff80000000
 #define __PAGE_OFFSET           0xffff810000000000
 #endif /* !__ASSEMBLY__ */
