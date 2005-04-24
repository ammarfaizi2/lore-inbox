Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVDXSWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVDXSWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVDXSVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:21:37 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:25231 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262361AbVDXSUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:20:12 -0400
Subject: [patch 3/6] uml: support AES i586 crypto driver [for 2.6.12]
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:10:02 +0200
Message-Id: <20050424181002.6D8D755CFD@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We want to make possible, for the user, to enable the i586 AES implementation.
This requires a restructure.

1) Add a CONFIG_UML_X86 to notify that we are building a UML for i386.
2) Rename CONFIG_64_BIT to CONFIG_64BIT as is used for all other archs
3) Tell crypto/Kconfig that UML_X86 is as good as X86
4) Tell it that it must exclude not X86_64 but 64BIT, which will give the same
results.
5) Tell kbuild to descend down into arch/i386/crypto/ to build what's needed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/Kconfig                 |    1 +
 linux-2.6.12-paolo/arch/um/Kconfig_i386            |    6 +++++-
 linux-2.6.12-paolo/arch/um/Kconfig_x86_64          |    6 +++++-
 linux-2.6.12-paolo/arch/um/Makefile-i386           |    2 +-
 linux-2.6.12-paolo/arch/um/defconfig               |   10 +++++-----
 linux-2.6.12-paolo/crypto/Kconfig                  |    4 ++--
 linux-2.6.12-paolo/include/asm-um/elf.h            |    2 +-
 linux-2.6.12-paolo/include/asm-um/page.h           |    2 +-
 linux-2.6.12-paolo/include/asm-um/pgtable-3level.h |    2 +-
 9 files changed, 22 insertions(+), 13 deletions(-)

diff -puN crypto/Kconfig~uml-crypto-i586 crypto/Kconfig
--- linux-2.6.12/crypto/Kconfig~uml-crypto-i586	2005-04-24 19:45:51.000000000 +0200
+++ linux-2.6.12-paolo/crypto/Kconfig	2005-04-24 19:45:51.000000000 +0200
@@ -146,7 +146,7 @@ config CRYPTO_SERPENT
 
 config CRYPTO_AES
 	tristate "AES cipher algorithms"
-	depends on CRYPTO && !(X86 && !X86_64)
+	depends on CRYPTO && !((X86 || UML_X86) && !64BIT)
 	help
 	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
 	  algorithm.
@@ -166,7 +166,7 @@ config CRYPTO_AES
 
 config CRYPTO_AES_586
 	tristate "AES cipher algorithms (i586)"
-	depends on CRYPTO && (X86 && !X86_64)
+	depends on CRYPTO && ((X86 || UML_X86) && !64BIT)
 	help
 	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
 	  algorithm.
diff -puN arch/um/Kconfig_i386~uml-crypto-i586 arch/um/Kconfig_i386
--- linux-2.6.12/arch/um/Kconfig_i386~uml-crypto-i586	2005-04-24 19:45:51.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/Kconfig_i386	2005-04-24 19:45:51.000000000 +0200
@@ -1,4 +1,8 @@
-config 64_BIT
+config UML_X86
+	bool
+	default y
+
+config 64BIT
 	bool
 	default n
 
diff -puN arch/um/Kconfig_x86_64~uml-crypto-i586 arch/um/Kconfig_x86_64
--- linux-2.6.12/arch/um/Kconfig_x86_64~uml-crypto-i586	2005-04-24 19:45:51.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/Kconfig_x86_64	2005-04-24 19:45:51.000000000 +0200
@@ -1,4 +1,8 @@
-config 64_BIT
+config UML_X86
+	bool
+	default y
+
+config 64BIT
 	bool
 	default y
 
diff -puN arch/um/Makefile-i386~uml-crypto-i586 arch/um/Makefile-i386
--- linux-2.6.12/arch/um/Makefile-i386~uml-crypto-i586	2005-04-24 19:45:51.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/Makefile-i386	2005-04-24 19:45:51.000000000 +0200
@@ -1,4 +1,4 @@
-SUBARCH_CORE := arch/um/sys-i386/
+SUBARCH_CORE := arch/um/sys-i386/ arch/i386/crypto/
 
 TOP_ADDR := $(CONFIG_TOP_ADDR)
 
diff -puN include/asm-um/page.h~uml-crypto-i586 include/asm-um/page.h
--- linux-2.6.12/include/asm-um/page.h~uml-crypto-i586	2005-04-24 19:45:51.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/page.h	2005-04-24 19:45:51.000000000 +0200
@@ -27,7 +27,7 @@ struct page;
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#if defined(CONFIG_3_LEVEL_PGTABLES) && !defined(CONFIG_64_BIT)
+#if defined(CONFIG_3_LEVEL_PGTABLES) && !defined(CONFIG_64BIT)
 
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
 typedef struct { unsigned long long pmd; } pmd_t;
diff -puN arch/um/Kconfig~uml-crypto-i586 arch/um/Kconfig
--- linux-2.6.12/arch/um/Kconfig~uml-crypto-i586	2005-04-24 19:45:51.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/Kconfig	2005-04-24 19:45:51.000000000 +0200
@@ -244,6 +244,7 @@ config KERNEL_HALF_GIGS
 
 config HIGHMEM
 	bool "Highmem support"
+	depends on !64BIT
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
diff -puN include/asm-um/elf.h~uml-crypto-i586 include/asm-um/elf.h
--- linux-2.6.12/include/asm-um/elf.h~uml-crypto-i586	2005-04-24 19:45:51.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/elf.h	2005-04-24 19:45:51.000000000 +0200
@@ -13,7 +13,7 @@ extern long elf_aux_hwcap;
 
 #define elf_check_arch(x) (1)
 
-#ifdef CONFIG_64_BIT
+#ifdef CONFIG_64BIT
 #define ELF_CLASS ELFCLASS64
 #else
 #define ELF_CLASS ELFCLASS32
diff -puN include/asm-um/pgtable-3level.h~uml-crypto-i586 include/asm-um/pgtable-3level.h
--- linux-2.6.12/include/asm-um/pgtable-3level.h~uml-crypto-i586	2005-04-24 19:45:51.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/pgtable-3level.h	2005-04-24 19:45:51.000000000 +0200
@@ -145,7 +145,7 @@ static inline pmd_t pfn_pmd(pfn_t page_n
  */
 #define PTE_FILE_MAX_BITS	32
 
-#ifdef CONFIG_64_BIT
+#ifdef CONFIG_64BIT
 
 #define pte_to_pgoff(p) ((p).pte >> 32)
 
diff -puN arch/um/defconfig~uml-crypto-i586 arch/um/defconfig
--- linux-2.6.12/arch/um/defconfig~uml-crypto-i586	2005-04-24 19:52:33.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/defconfig	2005-04-24 19:46:10.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc1-bk1
-# Sun Mar 20 16:53:00 2005
+# Linux kernel version: 2.6.12-rc3-skas3-v9-pre2
+# Sun Apr 24 19:46:10 2005
 #
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_UML=y
@@ -15,7 +15,8 @@ CONFIG_GENERIC_CALIBRATE_DELAY=y
 #
 CONFIG_MODE_TT=y
 CONFIG_MODE_SKAS=y
-# CONFIG_64_BIT is not set
+CONFIG_UML_X86=y
+# CONFIG_64BIT is not set
 CONFIG_TOP_ADDR=0xc0000000
 # CONFIG_3_LEVEL_PGTABLES is not set
 CONFIG_ARCH_HAS_SC_SIGNALS=y
@@ -41,6 +42,7 @@ CONFIG_UML_REAL_TIME_CLOCK=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -158,7 +160,6 @@ CONFIG_UML_NET_SLIRP=y
 #
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -412,6 +413,5 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_FS is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_PT_PROXY=y
-# CONFIG_GPROF is not set
 # CONFIG_GCOV is not set
 # CONFIG_SYSCALL_DEBUG is not set
_
