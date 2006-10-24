Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWJXINI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWJXINI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJXINH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:07 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:50930 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932429AbWJXINF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:05 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 1/8] AVR32: Minor Makefile cleanup
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:39 +0200
Message-Id: <11616775663220-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <1161677566706-git-send-email-hskinnemoen@atmel.com>
References: <1161677566706-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't generate listing by default, remove unused LIBGCC variable and
rename generated disassembly and listing files to vmlinux.{s,lst}.

Also make sure that files generated during the build are actually
removed with make clean.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/Makefile             |   21 +++++++++++++--------
 arch/avr32/boot/images/Makefile |    4 +---
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/avr32/Makefile b/arch/avr32/Makefile
index cefc95a..7b842e9 100644
--- a/arch/avr32/Makefile
+++ b/arch/avr32/Makefile
@@ -7,7 +7,7 @@ # Copyright (C) 2004-2006 Atmel Corporat
 
 # Default target when executing plain make
 .PHONY: all
-all: uImage vmlinux.elf linux.lst
+all: uImage vmlinux.elf
 
 KBUILD_DEFCONFIG	:= atstk1002_defconfig
 
@@ -21,9 +21,7 @@ cpuflags-$(CONFIG_CPU_AP7000)	+= -mcpu=a
 CFLAGS		+= $(cpuflags-y)
 AFLAGS		+= $(cpuflags-y)
 
-CHECKFLAGS	+= -D__avr32__
-
-LIBGCC		:= $(shell $(CC) $(CFLAGS) -print-libgcc-file-name)
+CHECKFLAGS	+= -D__avr32__ -D__BIG_ENDIAN
 
 head-$(CONFIG_LOADER_U_BOOT)		+= arch/avr32/boot/u-boot/head.o
 head-y					+= arch/avr32/kernel/head.o
@@ -32,7 +30,7 @@ core-$(CONFIG_BOARD_ATSTK1000)		+= arch/
 core-$(CONFIG_LOADER_U_BOOT)		+= arch/avr32/boot/u-boot/
 core-y					+= arch/avr32/kernel/
 core-y					+= arch/avr32/mm/
-libs-y					+= arch/avr32/lib/ #$(LIBGCC)
+libs-y					+= arch/avr32/lib/
 
 archincdir-$(CONFIG_PLATFORM_AT32AP)	:= arch-at32ap
 
@@ -48,6 +46,8 @@ endif
 
 archprepare: include/asm-avr32/.arch
 
+CLEAN_FILES += include/asm-avr32/.arch include/asm-avr32/arch
+
 BOOT_TARGETS := vmlinux.elf vmlinux.bin uImage uImage.srec
 
 .PHONY: $(BOOT_TARGETS) install
@@ -71,14 +71,19 @@ vmlinux.elf vmlinux.bin uImage.srec uIma
 install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
 
-linux.s: vmlinux
+vmlinux.s: vmlinux
 	$(call if_changed,disasm)
 
-linux.lst: vmlinux
+vmlinux.lst: vmlinux
 	$(call if_changed,listing)
 
+CLEAN_FILES += vmlinux.s vmlinux.lst
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+
 define archhelp
   @echo '* vmlinux.elf		- ELF image with load address 0'
   @echo '  vmlinux.cso		- PathFinder CSO image'
-  @echo '  uImage		- Create a bootable image for U-Boot'
+  @echo '* uImage		- Create a bootable image for U-Boot'
 endef
diff --git a/arch/avr32/boot/images/Makefile b/arch/avr32/boot/images/Makefile
index ccd74ee..219720a 100644
--- a/arch/avr32/boot/images/Makefile
+++ b/arch/avr32/boot/images/Makefile
@@ -37,14 +37,12 @@ OBJCOPYFLAGS_vmlinux.elf := --change-sec
 			    --change-section-lma .data-0x80000000 \
 			    --change-section-lma .init-0x80000000 \
 			    --change-section-lma .bss-0x80000000 \
-			    --change-section-lma .initrd-0x80000000 \
 			    --change-section-lma __param-0x80000000 \
 			    --change-section-lma __ksymtab-0x80000000 \
 			    --change-section-lma __ksymtab_gpl-0x80000000 \
 			    --change-section-lma __kcrctab-0x80000000 \
 			    --change-section-lma __kcrctab_gpl-0x80000000 \
 			    --change-section-lma __ksymtab_strings-0x80000000 \
-			    --change-section-lma .got-0x80000000 \
 			    --set-start 0xa0000000
 $(obj)/vmlinux.elf: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -59,4 +57,4 @@ install: $(BOOTIMAGE)
 	sh $(srctree)/install-kernel.sh $<
 
 # Generated files to be removed upon make clean
-clean-files	:= vmlinux* uImage uImage.srec
+clean-files	:= vmlinux.elf vmlinux.bin vmlinux.gz uImage uImage.srec
-- 
1.4.1.1

