Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWHALIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWHALIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWHALH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:07:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22237 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161123AbWHALH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:07:27 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 30/33] x86_64: Remove CONFIG_PHYSICAL_START
Date: Tue,  1 Aug 2006 05:03:45 -0600
Message-Id: <11544302472935-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am about to add relocatable kernel support which has essentially
no cost so there is no point in retaining CONFIG_PHYSICAL_START
and retaining CONFIG_PHYSICAL_START makes implementation of and
testing of a relocatable kernel more difficult.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/Kconfig                |   19 -------------------
 arch/x86_64/boot/compressed/head.S |    6 +++---
 arch/x86_64/boot/compressed/misc.c |    6 +++---
 arch/x86_64/defconfig              |    1 -
 arch/x86_64/kernel/vmlinux.lds.S   |    2 +-
 arch/x86_64/mm/fault.c             |    4 ++--
 include/asm-x86_64/page.h          |    2 --
 7 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 28df7d8..763b25b 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -486,25 +486,6 @@ config CRASH_DUMP
 	help
 		Generate crash dump after being started by kexec.
 
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
diff --git a/arch/x86_64/boot/compressed/head.S b/arch/x86_64/boot/compressed/head.S
index 6f55565..cf55d09 100644
--- a/arch/x86_64/boot/compressed/head.S
+++ b/arch/x86_64/boot/compressed/head.S
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
 
 
diff --git a/arch/x86_64/boot/compressed/misc.c b/arch/x86_64/boot/compressed/misc.c
index 3755b2e..259bb05 100644
--- a/arch/x86_64/boot/compressed/misc.c
+++ b/arch/x86_64/boot/compressed/misc.c
@@ -288,7 +288,7 @@ #ifdef STANDARD_MEMORY_BIOS_CALL
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (unsigned char *)__PHYSICAL_START; /* Normally Points to 1M */
+	output_data = (unsigned char *)0x200000;
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -311,8 +311,8 @@ #endif	
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
diff --git a/arch/x86_64/defconfig b/arch/x86_64/defconfig
index 840d5d9..06cf378 100644
--- a/arch/x86_64/defconfig
+++ b/arch/x86_64/defconfig
@@ -158,7 +158,6 @@ CONFIG_X86_MCE_INTEL=y
 CONFIG_X86_MCE_AMD=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-CONFIG_PHYSICAL_START=0x200000
 CONFIG_SECCOMP=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
index 7c4de31..741487b 100644
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -15,7 +15,7 @@ ENTRY(phys_startup_64)
 jiffies_64 = jiffies;
 SECTIONS
 {
-  . = __START_KERNEL;
+  . = __START_KERNEL_map + 0x200000;
   phys_startup_64 = startup_64 - LOAD_OFFSET;
   _text = .;			/* Text and read-only data */
   .text :  AT(ADDR(.text) - LOAD_OFFSET) {
diff --git a/arch/x86_64/mm/fault.c b/arch/x86_64/mm/fault.c
index ac8ea66..26d315b 100644
--- a/arch/x86_64/mm/fault.c
+++ b/arch/x86_64/mm/fault.c
@@ -650,9 +650,9 @@ void vmalloc_sync_all(void)
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
diff --git a/include/asm-x86_64/page.h b/include/asm-x86_64/page.h
index 37f95ca..deed41a 100644
--- a/include/asm-x86_64/page.h
+++ b/include/asm-x86_64/page.h
@@ -75,8 +75,6 @@ #define __pgprot(x)	((pgprot_t) { (x) } 
 
 #endif /* !__ASSEMBLY__ */
 
-#define __PHYSICAL_START	_AC(CONFIG_PHYSICAL_START,UL)
-#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
 #define __START_KERNEL_map	_AC(0xffffffff80000000,UL)
 #define __PAGE_OFFSET           _AC(0xffff810000000000,UL)
 
-- 
1.4.2.rc2.g5209e

