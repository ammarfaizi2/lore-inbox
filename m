Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUJIVLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUJIVLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUJIVLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:11:47 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:6298 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267431AbUJIVLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:11:05 -0400
Date: Sat, 9 Oct 2004 23:11:04 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] Various User/Kernel Splits
Message-ID: <20041009211104.GA14864@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew! Folks!

this allows the user to select various memory splits
to either overcome the lowmem shortage (2-4GB systems)
or to avoid the highmem completely (systems < 3GB)

after the last missing pieces to make the addresses
configureable have been included in recent trees
(2.6.9-rc3-bk9) this has become fairly trivial ...

so here is a patch against 2.6.9-rc3-bk9, but I guess
it will apply and work for later versions too 
(compile and run tested)

best,
Herbert

Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.9-rc3-bk9/arch/i386/Kconfig linux-2.6.9-rc3-bk9-split/arch/i386/Kconfig
--- linux-2.6.9-rc3-bk9/arch/i386/Kconfig	2004-09-30 19:01:24.000000000 +0200
+++ linux-2.6.9-rc3-bk9-split/arch/i386/Kconfig	2004-10-09 16:47:59.000000000 +0200
@@ -714,6 +714,46 @@ config HIGHMEM64G
 
 endchoice
 
+choice
+	prompt "Memory Split User Space"
+	default SPLIT_3GB
+	help
+	  A different Userspace/Kernel split allows you to
+	  utilize up to alsmost 3GB of RAM without the requirement
+	  for HIGHMEM. It also increases the available lowmem.
+
+config SPLIT_3GB
+	bool "3.0GB/1.0GB Kernel (Default)"
+	help
+	  This is the default split of 3GB userspace to 1GB kernel
+	  space, which will result in about 860MB of lowmem.
+
+config SPLIT_25GB
+	bool "2.5GB/1.5GB Kernel"
+	help
+	  This split provides 2.5GB userspace and 1.5GB kernel
+	  space, which will result in about 1370MB of lowmem.
+
+config SPLIT_2GB
+	bool "2.0GB/2.0GB Kernel"
+	help
+	  This split provides 2GB userspace and 2GB kernel
+	  space, which will result in about 1880MB of lowmem.
+
+config SPLIT_15GB
+	bool "1.5GB/2.5GB Kernel"
+	help
+	  This split provides 1.5GB userspace and 2.5GB kernel
+	  space, which will result in about 2390MB of lowmem.
+
+config SPLIT_1GB
+	bool "1.0GB/3.0GB Kernel"
+	help
+	  This split provides 1GB userspace and 3GB kernel
+	  space, which will result in about 2900MB of lowmem.
+
+endchoice
+
 config HIGHMEM
 	bool
 	depends on HIGHMEM64G || HIGHMEM4G
diff -NurpP --minimal linux-2.6.9-rc3-bk9/include/asm-i386/elf.h linux-2.6.9-rc3-bk9-split/include/asm-i386/elf.h
--- linux-2.6.9-rc3-bk9/include/asm-i386/elf.h	2004-09-30 19:01:37.000000000 +0200
+++ linux-2.6.9-rc3-bk9-split/include/asm-i386/elf.h	2004-10-09 16:47:59.000000000 +0200
@@ -70,7 +70,7 @@ typedef struct user_fxsr_struct elf_fpxr
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
+#define ELF_ET_DYN_BASE		((TASK_UNMAPPED_BASE) * 2)
 
 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
    now struct_user_regs, they are different) */
diff -NurpP --minimal linux-2.6.9-rc3-bk9/include/asm-i386/page.h linux-2.6.9-rc3-bk9-split/include/asm-i386/page.h
--- linux-2.6.9-rc3-bk9/include/asm-i386/page.h	2004-09-30 19:01:37.000000000 +0200
+++ linux-2.6.9-rc3-bk9-split/include/asm-i386/page.h	2004-10-09 16:50:25.000000000 +0200
@@ -120,16 +120,23 @@ extern int sysctl_legacy_va_layout;
 
 #endif /* __ASSEMBLY__ */
 
-#ifdef __ASSEMBLY__
+#if   defined(CONFIG_SPLIT_3GB)
 #define __PAGE_OFFSET		(0xC0000000)
-#else
-#define __PAGE_OFFSET		(0xC0000000UL)
+#elif defined(CONFIG_SPLIT_25GB)
+#define __PAGE_OFFSET		(0xA0000000)
+#elif defined(CONFIG_SPLIT_2GB)
+#define __PAGE_OFFSET		(0x80000000)
+#elif defined(CONFIG_SPLIT_15GB)
+#define __PAGE_OFFSET		(0x60000000)
+#elif defined(CONFIG_SPLIT_1GB)
+#define __PAGE_OFFSET		(0x40000000)
 #endif
 
-
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define __MAXMEM		(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM			((unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE))
+
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
diff -NurpP --minimal linux-2.6.9-rc3-bk9/include/asm-i386/processor.h linux-2.6.9-rc3-bk9-split/include/asm-i386/processor.h
--- linux-2.6.9-rc3-bk9/include/asm-i386/processor.h	2004-09-30 19:01:37.000000000 +0200
+++ linux-2.6.9-rc3-bk9-split/include/asm-i386/processor.h	2004-10-09 16:50:48.000000000 +0200
@@ -288,9 +288,10 @@ extern unsigned int BIOS_revision;
 extern unsigned int mca_pentium_flag;
 
 /*
- * User space process size: 3GB (default).
+ * User space process size: (3GB default).
  */
-#define TASK_SIZE	(PAGE_OFFSET)
+#define __TASK_SIZE		(__PAGE_OFFSET)
+#define TASK_SIZE		((unsigned long)__TASK_SIZE)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
