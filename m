Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWHUVVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWHUVVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWHUVVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:21:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24846 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751132AbWHUVVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:21:54 -0400
Date: Mon, 21 Aug 2006 23:21:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@suse.de>
Subject: [2.6 patch] re-add -ffreestanding
Message-ID: <20060821212154.GO11651@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error with gcc 4.1.1 when trying to compile 
kernel 2.6.18-rc4-mm2 for m68k:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/m68k/amiga/built-in.o: In function `amiga_get_hardware_list':
config.c:(.text+0x882): undefined reference to `strcpy'
kernel/built-in.o: In function `prof_cpu_mask_read_proc':
profile.c:(.text+0x41ac): undefined reference to `strcpy'
kernel/built-in.o: In function `sysfs_show_available_clocksources':
clocksource.c:(.text+0x1434e): undefined reference to `strcpy'
kernel/built-in.o: In function `sysfs_show_current_clocksources':
clocksource.c:(.text+0x143a4): undefined reference to `strcpy'
fs/built-in.o: In function `lock_get_status':
locks.c:(.text+0x1198a): undefined reference to `strcpy'
fs/built-in.o:locks.c:(.text+0x119ae): more undefined references to `strcpy' follow
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

The Linux kernel is a freestanding environment, not a hosted one 
providing a full standard C library gcc can consider being present.

The fact that -ffreestanding had already been re-added on three 
architectures also reflects this fact.

If we want to use a all or subset of the gcc builtins on some or all 
architectures, we should make this explicitely through #define's.

This patch therefore reverts commit 
6edfba1b33c701108717f4e036320fc39abe1912 and re-adds -ffreestanding to 
the CFLAGS.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Makefile                    |    3 ++-
 arch/i386/Makefile          |    3 ---
 arch/mips/Makefile          |    2 --
 arch/um/Makefile-i386       |    4 ----
 include/asm-x86_64/string.h |   17 ++++++++++++++---
 5 files changed, 16 insertions(+), 13 deletions(-)

--- linux-2.6.18-rc4-mm2/Makefile.old	2006-08-21 20:28:30.000000000 +0200
+++ linux-2.6.18-rc4-mm2/Makefile	2006-08-21 20:40:15.000000000 +0200
@@ -308,7 +308,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+		   -fno-strict-aliasing -fno-common \
+		   -ffreestanding
 # Force gcc to behave correct even for buggy distributions
 CFLAGS          += $(call cc-option, -fno-stack-protector)
 
--- linux-2.6.18-rc4-mm2/arch/i386/Makefile.old	2006-08-21 20:40:26.000000000 +0200
+++ linux-2.6.18-rc4-mm2/arch/i386/Makefile	2006-08-21 20:40:33.000000000 +0200
@@ -39,9 +39,6 @@
 
 cflags-$(CONFIG_REGPARM) += -mregparm=3
 
-# temporary until string.h is fixed
-cflags-y += -ffreestanding
-
 # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
 # a lot more stack due to the lack of sharing of stacklots:
 CFLAGS				+= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo $(call cc-option,-fno-unit-at-a-time); fi ;)
--- linux-2.6.18-rc4-mm2/arch/mips/Makefile.old	2006-08-21 20:40:40.000000000 +0200
+++ linux-2.6.18-rc4-mm2/arch/mips/Makefile	2006-08-21 20:40:48.000000000 +0200
@@ -83,8 +83,6 @@
 LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
 MODFLAGS			+= -mlong-calls
 
-cflags-y += -ffreestanding
-
 #
 # We explicitly add the endianness specifier if needed, this allows
 # to compile kernels with a toolchain for the other endianness. We
--- linux-2.6.18-rc4-mm2/arch/um/Makefile-i386.old	2006-08-21 20:40:56.000000000 +0200
+++ linux-2.6.18-rc4-mm2/arch/um/Makefile-i386	2006-08-21 20:41:09.000000000 +0200
@@ -33,9 +33,5 @@
 # prevent gcc from keeping the stack 16 byte aligned. Taken from i386.
 cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 
-# Prevent sprintf in nfsd from being converted to strcpy and resulting in
-# an unresolved reference.
-cflags-y += -ffreestanding
-
 CFLAGS += $(cflags-y)
 USER_CFLAGS += $(cflags-y)
--- linux-2.6.18-rc4-mm2/include/asm-x86_64/string.h.old	2006-08-21 20:49:07.000000000 +0200
+++ linux-2.6.18-rc4-mm2/include/asm-x86_64/string.h	2006-08-21 20:49:22.000000000 +0200
@@ -41,15 +41,26 @@
 
 
 #define __HAVE_ARCH_MEMSET
-void *memset(void *s, int c, size_t n);
+#define memset __builtin_memset
 
 #define __HAVE_ARCH_MEMMOVE
 void * memmove(void * dest,const void *src,size_t count);
 
+/* Use C out of line version for memcmp */ 
+#define memcmp __builtin_memcmp
 int memcmp(const void * cs,const void * ct,size_t count);
+
+/* out of line string functions use always C versions */ 
+#define strlen __builtin_strlen
 size_t strlen(const char * s);
-char *strcpy(char * dest,const char *src);
-char *strcat(char * dest, const char * src);
+
+#define strcpy __builtin_strcpy
+char * strcpy(char * dest,const char *src);
+
+#define strcat __builtin_strcat
+char * strcat(char * dest, const char * src);
+
+#define strcmp __builtin_strcmp
 int strcmp(const char * cs,const char * ct);
 
 #endif /* __KERNEL__ */

