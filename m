Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbSLLSLg>; Thu, 12 Dec 2002 13:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSLLSJ0>; Thu, 12 Dec 2002 13:09:26 -0500
Received: from [195.212.29.5] ([195.212.29.5]:64201 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264984AbSLLSHo> convert rfc822-to-8bit; Thu, 12 Dec 2002 13:07:44 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/8): Makefiles.
Date: Thu, 12 Dec 2002 19:11:18 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121906.07714.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile changes by Sam Ravnborg. Summary of changes:
o Added FORCE prerequisite in boot/Makefile
o Do not use shorthand targets when calling the boot/Makefile
o No longer use BOOT_IMAGE, not needed now
o Use kbuild clean infrastructure when cleaning up in boot
o Offset generation shrinked with one rule
o removed inclusion of Rules.make in all Makefiles
o no longer use the descend macro, use $(Q)$(MAKE) as replacement

diffstat:
 arch/s390/Makefile          |   31 ++++++++++++++++---------------
 arch/s390/boot/Makefile     |   25 ++++++++++---------------
 arch/s390/defconfig         |    2 ++
 arch/s390/kernel/Makefile   |    2 --
 arch/s390/lib/Makefile      |    3 ---
 arch/s390/math-emu/Makefile |    8 ++------
 arch/s390/mm/Makefile       |    2 --
 arch/s390x/Makefile         |   27 ++++++++++++++-------------
 arch/s390x/boot/Makefile    |   25 ++++++++++---------------
 arch/s390x/defconfig        |    2 ++
 arch/s390x/kernel/Makefile  |    2 --
 arch/s390x/lib/Makefile     |    3 ---
 arch/s390x/mm/Makefile      |    4 +---
 drivers/s390/Makefile       |    2 +-
 drivers/s390/misc/Makefile  |    7 -------
 15 files changed, 58 insertions(+), 87 deletions(-)

diff -urN linux-2.5.51/arch/s390/Makefile linux-2.5.51-s390/arch/s390/Makefile
--- linux-2.5.51/arch/s390/Makefile	Tue Dec 10 03:45:46 2002
+++ linux-2.5.51-s390/arch/s390/Makefile	Thu Dec 12 18:59:01 2002
@@ -20,36 +20,37 @@
 
 CFLAGS += -pipe -fno-strength-reduce
 
-HEAD := arch/s390/kernel/head.o arch/s390/kernel/init_task.o
+HEAD := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
-core-y				+= arch/s390/mm/ arch/s390/kernel/
-drivers-y			+= drivers/s390/
-drivers-$(CONFIG_MATHEMU)	+= arch/s390/math-emu/
-libs-y				+= arch/s390/lib/
+core-y		+= arch/$(ARCH)/mm/ arch/$(ARCH)/kernel/
+libs-y		+= arch/$(ARCH)/lib/
+drivers-y	+= drivers/s390/
+drivers-$(CONFIG_MATHEMU) += arch/$(ARCH)/math-emu/
+
+
+makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/$(ARCH)/boot $(1)
 
 all: image listing
 
-makeboot = $(call descend,arch/$(ARCH)/boot,$(1))
-BOOTIMAGE= arch/$(ARCH)/boot/image
+listing image: vmlinux
+	$(call makeboot,arch/$(ARCH)/boot/$@)
 
-listing install image: vmlinux
-	+@$(call makeboot,BOOTIMAGE=$(BOOTIMAGE) $@)
+install: vmlinux
+	$(call makeboot, $@)
 
+archmrproper:
 archclean:
-	+@$(call makeboot,clean)
+	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/$(ARCH)/boot
 
-archmrproper:
 
 prepare: include/asm-$(ARCH)/offsets.h
 
 arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
 				   include/config/MARKER
 
-include/asm-$(ARCH)/offsets.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
-	@$(generate-asm-offsets.h) < $< > $@
-
-include/asm-$(ARCH)/offsets.h: include/asm-$(ARCH)/offsets.h.tmp
+include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
 	@echo -n '  Generating $@'
+	@$(generate-asm-offsets.h) < $< > $@.tmp
 	@$(update-if-changed)
 
 CLEAN_FILES += include/asm-$(ARCH)/offsets.h.tmp \
diff -urN linux-2.5.51/arch/s390/boot/Makefile linux-2.5.51-s390/arch/s390/boot/Makefile
--- linux-2.5.51/arch/s390/boot/Makefile	Tue Dec 10 03:46:27 2002
+++ linux-2.5.51-s390/arch/s390/boot/Makefile	Thu Dec 12 18:59:01 2002
@@ -2,26 +2,21 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
-EXTRA_AFLAGS := -traditional
+EXTRA_TARGETS := image listing
+EXTRA_AFLAGS  := -traditional
 
-include $(TOPDIR)/Rules.make
 
-quiet_cmd_listing = OBJDUMP $(echo_target)
-cmd_listing	  = $(OBJDUMP) --disassemble --disassemble-all \
-			--disassemble-zeroes --reloc vmlinux > $@
+quiet_cmd_listing = OBJDUMP $@
+      cmd_listing = $(OBJDUMP) --disassemble --disassemble-all \
+			       --disassemble-zeroes --reloc vmlinux > $@
 
-$(obj)/image: vmlinux
+$(obj)/image: vmlinux FORCE
 	$(call if_changed,objcopy)
 
-$(obj)/listing: vmlinux
+$(obj)/listing: vmlinux FORCE
 	$(call if_changed,listing)
 
-image: $(obj)/image
 
-listing: $(obj)/listing
-
-clean:
-	rm -f $(obj)/image $(obj)/listing
-
-install: $(CONFIGURE) $(BOOTIMAGE)
-	sh -x $(obj)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map Kerntypes "$(INSTALL_PATH)"
+install: $(CONFIGURE) $(obj)/image
+	sh -x $(obj)/install.sh $(KERNELRELEASE) $(obj)/image \
+	      System.map Kerntypes "$(INSTALL_PATH)"
diff -urN linux-2.5.51/arch/s390/defconfig linux-2.5.51-s390/arch/s390/defconfig
--- linux-2.5.51/arch/s390/defconfig	Tue Dec 10 03:46:16 2002
+++ linux-2.5.51-s390/arch/s390/defconfig	Thu Dec 12 18:59:01 2002
@@ -321,6 +321,8 @@
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff -urN linux-2.5.51/arch/s390/kernel/Makefile linux-2.5.51-s390/arch/s390/kernel/Makefile
--- linux-2.5.51/arch/s390/kernel/Makefile	Tue Dec 10 03:46:24 2002
+++ linux-2.5.51-s390/arch/s390/kernel/Makefile	Thu Dec 12 18:59:01 2002
@@ -17,5 +17,3 @@
 # Kernel debugging
 #
 obj-$(CONFIG_REMOTE_DEBUG)	+= gdb-stub.o #gdb-low.o 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51/arch/s390/lib/Makefile linux-2.5.51-s390/arch/s390/lib/Makefile
--- linux-2.5.51/arch/s390/lib/Makefile	Tue Dec 10 03:45:43 2002
+++ linux-2.5.51-s390/arch/s390/lib/Makefile	Thu Dec 12 18:59:01 2002
@@ -7,6 +7,3 @@
 EXTRA_AFLAGS := -traditional
 
 obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51/arch/s390/math-emu/Makefile linux-2.5.51-s390/arch/s390/math-emu/Makefile
--- linux-2.5.51/arch/s390/math-emu/Makefile	Tue Dec 10 03:45:52 2002
+++ linux-2.5.51-s390/arch/s390/math-emu/Makefile	Thu Dec 12 18:59:01 2002
@@ -4,9 +4,5 @@
 
 obj-$(CONFIG_MATHEMU) := math.o qrnnd.o
 
-EXTRA_CFLAGS = -I. -I$(TOPDIR)/include/math-emu -w
-EXTRA_AFLAGS	:= -traditional
-
-include $(TOPDIR)/Rules.make
-
-
+EXTRA_CFLAGS := -I$(src) -Iinclude/math-emu -w
+EXTRA_AFLAGS := -traditional
diff -urN linux-2.5.51/arch/s390/mm/Makefile linux-2.5.51-s390/arch/s390/mm/Makefile
--- linux-2.5.51/arch/s390/mm/Makefile	Tue Dec 10 03:46:24 2002
+++ linux-2.5.51-s390/arch/s390/mm/Makefile	Thu Dec 12 18:59:01 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y	 := init.o fault.o ioremap.o extable.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51/arch/s390x/Makefile linux-2.5.51-s390/arch/s390x/Makefile
--- linux-2.5.51/arch/s390x/Makefile	Tue Dec 10 03:46:00 2002
+++ linux-2.5.51-s390/arch/s390x/Makefile	Thu Dec 12 18:59:01 2002
@@ -21,35 +21,36 @@
 
 CFLAGS += -pipe -fno-strength-reduce
 
-HEAD := arch/s390x/kernel/head.o arch/s390x/kernel/init_task.o
+HEAD := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
-core-y		+= arch/s390x/mm/ arch/s390x/kernel/
+core-y		+= arch/$(ARCH)/mm/ arch/$(ARCH)/kernel/
+libs-y		+= arch/$(ARCH)/lib/
 drivers-y	+= drivers/s390/
-libs-y		+= arch/s390x/lib/
+
+
+makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/$(ARCH)/boot $(1)
 
 all: image listing
 
-makeboot = $(call descend,arch/$(ARCH)/boot,$(1))
-BOOTIMAGE= arch/$(ARCH)/boot/image
+listing image: vmlinux
+	$(call makeboot,arch/$(ARCH)/boot/$@)
 
-listing install image: vmlinux
-	+@$(call makeboot,BOOTIMAGE=$(BOOTIMAGE) $@)
+install: vmlinux
+	$(call makeboot, $@)
 
+archmrproper:
 archclean:
-	+@$(call makeboot,clean)
+	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/$(ARCH)/boot
 
-archmrproper:
 
 prepare: include/asm-$(ARCH)/offsets.h
 
 arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
 				   include/config/MARKER
 
-include/asm-$(ARCH)/offsets.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
-	@$(generate-asm-offsets.h) < $< > $@
-
-include/asm-$(ARCH)/offsets.h: include/asm-$(ARCH)/offsets.h.tmp
+include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
 	@echo -n '  Generating $@'
+	@$(generate-asm-offsets.h) < $< > $@.tmp
 	@$(update-if-changed)
 
 CLEAN_FILES += include/asm-$(ARCH)/offsets.h.tmp \
diff -urN linux-2.5.51/arch/s390x/boot/Makefile linux-2.5.51-s390/arch/s390x/boot/Makefile
--- linux-2.5.51/arch/s390x/boot/Makefile	Tue Dec 10 03:45:59 2002
+++ linux-2.5.51-s390/arch/s390x/boot/Makefile	Thu Dec 12 18:59:01 2002
@@ -2,26 +2,21 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
-EXTRA_AFLAGS := -traditional
+EXTRA_TARGETS := image listing
+EXTRA_AFLAGS  := -traditional
 
-include $(TOPDIR)/Rules.make
 
-quiet_cmd_listing = OBJDUMP $(echo_target)
-cmd_listing	  = $(OBJDUMP) --disassemble --disassemble-all \
-			--disassemble-zeroes --reloc vmlinux > $@
+quiet_cmd_listing = OBJDUMP $@
+      cmd_listing = $(OBJDUMP) --disassemble --disassemble-all \
+			       --disassemble-zeroes --reloc vmlinux > $@
 
-$(obj)/image: vmlinux
+$(obj)/image: vmlinux FORCE
 	$(call if_changed,objcopy)
 
-$(obj)/listing: vmlinux
+$(obj)/listing: vmlinux FORCE
 	$(call if_changed,listing)
 
-image: $(obj)/image
 
-listing: $(obj)/listing
-
-clean:
-	rm -f $(obj)/image $(obj)/listing
-
-install: $(CONFIGURE) $(BOOTIMAGE)
-	sh -x $(obj)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map Kerntypes "$(INSTALL_PATH)"
+install: $(CONFIGURE) $(obj)/image
+	sh -x $(obj)/install.sh $(KERNELRELEASE) $(obj)/image \
+	      System.map Kerntypes "$(INSTALL_PATH)"
diff -urN linux-2.5.51/arch/s390x/defconfig linux-2.5.51-s390/arch/s390x/defconfig
--- linux-2.5.51/arch/s390x/defconfig	Tue Dec 10 03:45:39 2002
+++ linux-2.5.51-s390/arch/s390x/defconfig	Thu Dec 12 18:59:01 2002
@@ -382,6 +382,8 @@
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff -urN linux-2.5.51/arch/s390x/kernel/Makefile linux-2.5.51-s390/arch/s390x/kernel/Makefile
--- linux-2.5.51/arch/s390x/kernel/Makefile	Tue Dec 10 03:45:54 2002
+++ linux-2.5.51-s390/arch/s390x/kernel/Makefile	Thu Dec 12 18:59:01 2002
@@ -24,8 +24,6 @@
 					 exec32.o exec_domain32.o
 obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
 
-include $(TOPDIR)/Rules.make
-
 #
 # This is just to get the dependencies...
 #
diff -urN linux-2.5.51/arch/s390x/lib/Makefile linux-2.5.51-s390/arch/s390x/lib/Makefile
--- linux-2.5.51/arch/s390x/lib/Makefile	Tue Dec 10 03:45:44 2002
+++ linux-2.5.51-s390/arch/s390x/lib/Makefile	Thu Dec 12 18:59:01 2002
@@ -7,6 +7,3 @@
 EXTRA_AFLAGS := -traditional
 
 obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51/arch/s390x/mm/Makefile linux-2.5.51-s390/arch/s390x/mm/Makefile
--- linux-2.5.51/arch/s390x/mm/Makefile	Tue Dec 10 03:46:10 2002
+++ linux-2.5.51-s390/arch/s390x/mm/Makefile	Thu Dec 12 18:59:01 2002
@@ -1,7 +1,5 @@
 #
-# Makefile for the linux i386-specific parts of the memory manager.
+# Makefile for the linux s390-specific parts of the memory manager.
 #
 
 obj-y	 := init.o fault.o ioremap.o extable.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51/drivers/s390/Makefile linux-2.5.51-s390/drivers/s390/Makefile
--- linux-2.5.51/drivers/s390/Makefile	Tue Dec 10 03:45:58 2002
+++ linux-2.5.51-s390/drivers/s390/Makefile	Thu Dec 12 18:59:12 2002
@@ -3,7 +3,7 @@
 #
 
 obj-y += s390mach.o sysinfo.o
-obj-y += cio/ block/ char/ misc/ net/
+obj-y += cio/ block/ char/ net/
 
 drivers-y += drivers/s390/built-in.o
 
diff -urN linux-2.5.51/drivers/s390/misc/Makefile linux-2.5.51-s390/drivers/s390/misc/Makefile
--- linux-2.5.51/drivers/s390/misc/Makefile	Tue Dec 10 03:46:24 2002
+++ linux-2.5.51-s390/drivers/s390/misc/Makefile	Thu Jan  1 01:00:00 1970
@@ -1,7 +0,0 @@
-#
-# S/390 miscellaneous devices
-#
-
-# placeholder for stuff to come...
-
-include $(TOPDIR)/Rules.make

