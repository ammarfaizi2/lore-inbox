Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVASHxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVASHxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVASHwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:52:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50879 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261623AbVASHdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:17 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/29] x86-config-kernel-start
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For one kernel to report a crash another kernel has created we need
to have 2 kernels loaded simultaneously in memory.  To accomplish this
the two kernels need to built to run at different physical addresses.

This patch adds the CONFIG_PHYSICAL_START option to the x86 kernel
so we can do just that.  You need to know what you are doing and
the ramifications are before changing this value, and most users
won't care so I have made it depend on CONFIG_EMBEDDED

bzImage kernels will work and run at a different address when compiled
with this option but they will still load at 1MB.  If you need a kernel
loaded at a different address as well you need to boot a vmlinux.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 arch/i386/Kconfig                |   11 +++++++++++
 arch/i386/boot/compressed/head.S |    7 ++++---
 arch/i386/boot/compressed/misc.c |    7 ++++---
 arch/i386/kernel/vmlinux.lds.S   |    2 +-
 include/asm-i386/page.h          |    3 +++
 5 files changed, 23 insertions(+), 7 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/i386/Kconfig linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/i386/Kconfig
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/i386/Kconfig	Fri Jan 14 04:32:22 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/i386/Kconfig	Tue Jan 18 22:46:40 2005
@@ -890,6 +890,17 @@
 
 source "drivers/perfctr/Kconfig"
 
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
+
 endmenu
 
 
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/i386/boot/compressed/head.S linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/i386/boot/compressed/head.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/i386/boot/compressed/head.S	Mon Oct 18 15:55:27 2004
+++ linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/i386/boot/compressed/head.S	Tue Jan 18 22:46:40 2005
@@ -25,6 +25,7 @@
 
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/page.h>
 
 	.globl startup_32
 	
@@ -74,7 +75,7 @@
 	popl %esi	# discard address
 	popl %esi	# real mode pointer
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $0x100000
+	ljmp $(__BOOT_CS), $__PHYSICAL_START
 
 /*
  * We come here, if we were loaded high.
@@ -99,7 +100,7 @@
 	popl %ecx	# lcount
 	popl %edx	# high_buffer_start
 	popl %eax	# hcount
-	movl $0x100000,%edi
+	movl $__PHYSICAL_START,%edi
 	cli		# make sure we don't get interrupted
 	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine
 
@@ -124,5 +125,5 @@
 	movsl
 	movl %ebx,%esi	# Restore setup pointer
 	xorl %ebx,%ebx
-	ljmp $(__BOOT_CS), $0x100000
+	ljmp $(__BOOT_CS), $__PHYSICAL_START
 move_routine_end:
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/i386/boot/compressed/misc.c linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/i386/boot/compressed/misc.c
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/i386/boot/compressed/misc.c	Mon Oct 18 15:54:32 2004
+++ linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/i386/boot/compressed/misc.c	Tue Jan 18 22:46:40 2005
@@ -14,6 +14,7 @@
 #include <linux/tty.h>
 #include <video/edid.h>
 #include <asm/io.h>
+#include <asm/page.h>
 
 /*
  * gzip declarations
@@ -309,7 +310,7 @@
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (char *)0x100000; /* Points to 1M */
+	output_data = (char *)__PHYSICAL_START; /* Normally Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -334,8 +335,8 @@
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
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/i386/kernel/vmlinux.lds.S linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/arch/i386/kernel/vmlinux.lds.S	Tue Jan 18 22:45:51 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/arch/i386/kernel/vmlinux.lds.S	Tue Jan 18 22:46:40 2005
@@ -14,7 +14,7 @@
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = LOAD_OFFSET + 0x100000;
+  . = __KERNEL_START;
   phys_startup_32 = startup_32 - LOAD_OFFSET;
   /* read-only */
   _text = .;			/* Text and read-only data */
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/include/asm-i386/page.h linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/include/asm-i386/page.h
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-entry64/include/asm-i386/page.h	Fri Jan 14 04:32:27 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-config-kernel-start/include/asm-i386/page.h	Tue Jan 18 22:46:40 2005
@@ -122,9 +122,12 @@
 
 #ifdef __ASSEMBLY__
 #define __PAGE_OFFSET		(0xC0000000)
+#define __PHYSICAL_START	CONFIG_PHYSICAL_START
 #else
 #define __PAGE_OFFSET		(0xC0000000UL)
+#define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
 #endif
+#define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)
 
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
