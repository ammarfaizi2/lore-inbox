Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbTI1QTY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTI1QTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:19:24 -0400
Received: from front3.chartermi.net ([24.213.60.109]:31486 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id S262617AbTI1QTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:19:11 -0400
Message-ID: <3F7709FB.7020502@quark.didntduck.org>
Date: Sun, 28 Sep 2003 12:19:07 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Consolidate offset header rules
Content-Type: multipart/mixed;
 boundary="------------070704090708000803080707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070704090708000803080707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Move the rules to generate the offset header file to the main Makefile.

--
				Brian Gerst

--------------070704090708000803080707
Content-Type: text/plain;
 name="offsets-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="offsets-1"

diff -urN linux-2.6.0-test6/arch/alpha/Makefile linux/arch/alpha/Makefile
--- linux-2.6.0-test6/arch/alpha/Makefile	2003-09-28 10:20:04.650646000 -0400
+++ linux/arch/alpha/Makefile	2003-09-28 10:55:55.809620128 -0400
@@ -112,19 +112,11 @@
 	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $(boot)/$@
 
 
-prepare: include/asm-$(ARCH)/asm_offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
+OFFSETS := include/asm-$(ARCH)/asm_offsets.h
 
 archclean:
 	$(Q)$(MAKE) -f scripts/Makefile.clean obj=$(boot)
 
-CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
-
 define archhelp
   echo '* boot		- Compressed kernel image (arch/alpha/boot/vmlinux.gz)'
   echo '  bootimage	- SRM bootable image (arch/alpha/boot/bootimage)'
diff -urN linux-2.6.0-test6/arch/arm/Makefile linux/arch/arm/Makefile
--- linux-2.6.0-test6/arch/arm/Makefile	2003-09-28 10:20:29.374887344 -0400
+++ linux/arch/arm/Makefile	2003-09-28 12:01:21.330850192 -0400
@@ -140,9 +140,11 @@
 
 prepare: maketools
 
+OFFSETS := include/asm-$(ARCH)/constants.h
+
 .PHONY: maketools FORCE
 maketools: include/asm-arm/.arch \
-	   include/asm-arm/constants.h include/linux/version.h FORCE
+	   $(OFFSETS) include/linux/version.h FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/tools include/asm-arm/mach-types.h
 
 # Convert bzImage to zImage
@@ -171,12 +173,7 @@
 i:;	$(Q)$(MAKE) $(build)=$(boot) install
 zi:;	$(Q)$(MAKE) $(build)=$(boot) zinstall
 
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/asm-arm/.arch \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/constants.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
+arch/$(ARCH)/kernel/asm-offsets.s: include/asm-arm/.arch
 
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
diff -urN linux-2.6.0-test6/arch/arm26/Makefile linux/arch/arm26/Makefile
--- linux-2.6.0-test6/arch/arm26/Makefile	2003-09-28 10:20:20.558227680 -0400
+++ linux/arch/arm26/Makefile	2003-09-28 11:47:37.759052136 -0400
@@ -56,9 +56,7 @@
 
 boot := arch/arm26/boot
 
-prepare: include/asm-$(ARCH)/asm_offsets.h
-CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
-
+OFFSETS := include/asm-$(ARCH)/asm_offsets.h
 
 .PHONY: maketools FORCE
 maketools: FORCE
@@ -101,12 +99,6 @@
 	fi; \
 	)
 
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
diff -urN linux-2.6.0-test6/arch/cris/Makefile linux/arch/cris/Makefile
--- linux-2.6.0-test6/arch/cris/Makefile	2003-09-28 10:20:13.857246384 -0400
+++ linux/arch/cris/Makefile	2003-09-28 11:48:21.468407304 -0400
@@ -85,8 +85,9 @@
 	rm -f timage vmlinux.bin cramfs.img
 	rm -rf $(LD_SCRIPT).tmp
 
-prepare: arch/$(ARCH)/.links include/asm-$(ARCH)/.arch \
-	 include/asm-$(ARCH)/$(SARCH)/offset.h
+prepare: arch/$(ARCH)/.links include/asm-$(ARCH)/.arch
+
+OFFSETS := include/asm-$(ARCH)/$(SARCH)/offset.h
 
 # Create some links to make all tools happy
 arch/$(ARCH)/.links:
@@ -102,9 +103,3 @@
 	@rm -f include/asm-$(ARCH)/arch
 	@ln -sf $(SARCH) include/asm-$(ARCH)/arch
 	@touch $@
-
-arch/$(ARCH)/$(SARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-					include/config/MARKER
-
-include/asm-$(ARCH)/$(SARCH)/offset.h: arch/$(ARCH)/$(SARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
diff -urN linux-2.6.0-test6/arch/h8300/Makefile linux/arch/h8300/Makefile
--- linux-2.6.0-test6/arch/h8300/Makefile	2003-09-28 10:20:13.863245472 -0400
+++ linux/arch/h8300/Makefile	2003-09-28 11:48:54.077449976 -0400
@@ -62,17 +62,15 @@
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-$(ARCH)/machine-depend.h include/asm-$(ARCH)/asm-offsets.h
+prepare: include/asm-$(ARCH)/machine-depend.h 
+
+OFFSETS := include/asm-$(ARCH)/asm-offsets.h
 
 include/asm-$(ARCH)/machine-depend.h: include/asm-$(ARCH)/$(BOARD)/machine-depend.h
 	$(Q)ln -sf $(BOARD)/machine-depend.h \
                    include/asm-$(ARCH)/machine-depend.h
 	@echo '  Create include/asm-$(ARCH)/machine-depend.h'
 
-include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
-				   include/asm include/linux/version.h
-	$(call filechk,gen-asm-offsets)
-
 vmlinux.srec vmlinux.bin: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
@@ -81,4 +79,4 @@
   echo  'vmlinux.srec - Create srec binary'
 endef
 
-CLEAN_FILES += include/asm-$(ARCH)/asm-offsets.h include/asm-$(ARCH)/machine-depend.h
+CLEAN_FILES += include/asm-$(ARCH)/machine-depend.h
diff -urN linux-2.6.0-test6/arch/i386/Makefile linux/arch/i386/Makefile
--- linux-2.6.0-test6/arch/i386/Makefile	2003-09-28 10:20:31.259600824 -0400
+++ linux/arch/i386/Makefile	2003-09-28 10:58:43.250165296 -0400
@@ -123,14 +123,7 @@
 install fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
 
-prepare: include/asm-$(ARCH)/asm_offsets.h
-CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
+OFFSETS := include/asm-$(ARCH)/asm_offsets.h
 
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/i386/boot
diff -urN linux-2.6.0-test6/arch/ia64/Makefile linux/arch/ia64/Makefile
--- linux-2.6.0-test6/arch/ia64/Makefile	2003-09-28 10:20:31.366584560 -0400
+++ linux/arch/ia64/Makefile	2003-09-28 11:43:10.740645104 -0400
@@ -84,18 +84,15 @@
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-CLEAN_FILES += include/asm-ia64/.offsets.h.stamp include/asm-ia64/offsets.h vmlinux.gz bootloader
+CLEAN_FILES += include/asm-ia64/.offsets.h.stamp vmlinux.gz bootloader
 
-prepare: include/asm-ia64/offsets.h
-
-include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
+OFFSETS := include/asm-ia64/offsets.h
 
 arch/ia64/kernel/asm-offsets.s: include/asm-ia64/.offsets.h.stamp
 
 include/asm-ia64/.offsets.h.stamp:
-	[ -s include/asm-ia64/offsets.h ] \
-	 || echo "#define IA64_TASK_SIZE 0" > include/asm-ia64/offsets.h
+	[ -s $(OFFSETS) ] \
+	 || echo "#define IA64_TASK_SIZE 0" > $(OFFSETS)
 	touch $@
 
 boot:	lib/lib.a vmlinux
diff -urN linux-2.6.0-test6/arch/m68knommu/Makefile linux/arch/m68knommu/Makefile
--- linux-2.6.0-test6/arch/m68knommu/Makefile	2003-07-27 13:05:20.000000000 -0400
+++ linux/arch/m68knommu/Makefile	2003-09-28 11:01:54.728056232 -0400
@@ -87,21 +87,13 @@
 
 head-y := arch/m68knommu/platform/$(platform-y)/$(board-y)/crt0_$(model-y).o
 
-CLEAN_FILES := include/asm-$(ARCH)/asm-offsets.h \
-	       arch/$(ARCH)/kernel/asm-offsets.s
-
 core-y	+= arch/m68knommu/kernel/ \
 	   arch/m68knommu/mm/ \
 	   $(CLASSDIR) \
 	   arch/m68knommu/platform/$(PLATFORM)/
 libs-y	+= arch/m68knommu/lib/
 
-prepare: include/asm-$(ARCH)/asm-offsets.h
+OFFSETS := include/asm-$(ARCH)/asm-offsets.h
 
 archclean:
 	$(call descend arch/$(ARCH)/boot, subdirclean)
-
-include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
-				   include/asm include/linux/version.h \
-				   include/config/MARKER
-	$(call filechk,gen-asm-offsets)
diff -urN linux-2.6.0-test6/arch/parisc/Makefile linux/arch/parisc/Makefile
--- linux-2.6.0-test6/arch/parisc/Makefile	2003-09-28 10:20:31.617546408 -0400
+++ linux/arch/parisc/Makefile	2003-09-28 11:02:26.846173536 -0400
@@ -85,15 +85,9 @@
 # Shorthands for known targets not supported by parisc, use palo as default
 Image zImage bzImage: palo
 
-prepare: include/asm-parisc/offsets.h
+OFFSETS := include/asm-parisc/offsets.h
 
-arch/parisc/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-parisc/offsets.h: arch/parisc/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES	+= lifimage include/asm-parisc/offsets.h
+CLEAN_FILES	+= lifimage
 MRPROPER_FILES	+= palo.conf
 
 define archhelp
diff -urN linux-2.6.0-test6/arch/ppc/Makefile linux/arch/ppc/Makefile
--- linux-2.6.0-test6/arch/ppc/Makefile	2003-09-28 10:20:31.821515400 -0400
+++ linux/arch/ppc/Makefile	2003-09-28 11:03:12.442241880 -0400
@@ -71,13 +71,9 @@
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/ppc/boot
 
-prepare: include/asm-$(ARCH)/offsets.h checkbin
+prepare: checkbin
 
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
+OFFSETS := include/asm-$(ARCH)/offsets.h
 
 ifdef CONFIG_6xx
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later
@@ -97,6 +93,3 @@
 checkbin:
 	@true
 endif
-
-CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
-		arch/$(ARCH)/kernel/asm-offsets.s
diff -urN linux-2.6.0-test6/arch/ppc64/Makefile linux/arch/ppc64/Makefile
--- linux-2.6.0-test6/arch/ppc64/Makefile	2003-09-28 10:20:33.064326464 -0400
+++ linux/arch/ppc64/Makefile	2003-09-28 11:02:42.314821944 -0400
@@ -50,12 +50,4 @@
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-ppc64/offsets.h
-
-arch/ppc64/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-ppc64/offsets.h: arch/ppc64/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += include/asm-ppc64/offsets.h
+OFFSETS := include/asm-ppc64/offsets.h
diff -urN linux-2.6.0-test6/arch/s390/Makefile linux/arch/s390/Makefile
--- linux-2.6.0-test6/arch/s390/Makefile	2003-09-28 10:20:33.181308680 -0400
+++ linux/arch/s390/Makefile	2003-09-28 11:03:29.313677032 -0400
@@ -63,12 +63,4 @@
 	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/$(ARCH)/boot
 
 
-prepare: include/asm-$(ARCH)/offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += include/asm-$(ARCH)/offsets.h
+OFFSETS := include/asm-$(ARCH)/offsets.h
diff -urN linux-2.6.0-test6/arch/sparc/Makefile linux/arch/sparc/Makefile
--- linux-2.6.0-test6/arch/sparc/Makefile	2003-09-28 10:20:14.542142264 -0400
+++ linux/arch/sparc/Makefile	2003-09-28 11:03:46.241103672 -0400
@@ -62,16 +62,7 @@
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-$(ARCH)/asm_offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES +=	include/asm-$(ARCH)/asm_offsets.h	\
-		arch/$(ARCH)/kernel/asm-offsets.s
+OFFSETS := include/asm-$(ARCH)/asm_offsets.h
 
 # Don't use tabs in echo arguments.
 define archhelp
diff -urN linux-2.6.0-test6/arch/v850/Makefile linux/arch/v850/Makefile
--- linux-2.6.0-test6/arch/v850/Makefile	2003-07-27 13:12:11.000000000 -0400
+++ linux/arch/v850/Makefile	2003-09-28 11:04:29.655503680 -0400
@@ -48,16 +48,6 @@
 	$(OBJCOPY) $(OBJCOPY_FLAGS_BLOB) --rename-section .data=.root,alloc,load,readonly,data,contents $< root_fs_image.o
 endif
 
+OFFSETS := include/asm-$(ARCH)/asm-consts.h
 
-prepare: include/asm-$(ARCH)/asm-consts.h
-
-# Generate constants from C code for use by asm files
-arch/$(ARCH)/kernel/asm-consts.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm-consts.h: arch/$(ARCH)/kernel/asm-consts.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += include/asm-$(ARCH)/asm-consts.h \
-	       arch/$(ARCH)/kernel/asm-consts.s \
-	       root_fs_image.o
+CLEAN_FILES += root_fs_image.o
diff -urN linux-2.6.0-test6/arch/x86_64/Makefile linux/arch/x86_64/Makefile
--- linux-2.6.0-test6/arch/x86_64/Makefile	2003-09-28 10:20:33.586247120 -0400
+++ linux/arch/x86_64/Makefile	2003-09-28 11:04:40.635834416 -0400
@@ -87,15 +87,7 @@
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-$(ARCH)/offset.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/offset.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += include/asm-$(ARCH)/offset.h
+OFFSETS := include/asm-$(ARCH)/offset.h
 
 define archhelp
   echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
diff -urN linux-2.6.0-test6/Makefile linux/Makefile
--- linux-2.6.0-test6/Makefile	2003-09-28 10:20:29.369888104 -0400
+++ linux/Makefile	2003-09-28 11:14:37.567087072 -0400
@@ -718,6 +718,7 @@
 # Generate asm-offsets.h 
 # ---------------------------------------------------------------------------
 
+ifneq ($(OFFSETS),)
 define filechk_gen-asm-offsets
 	(set -e; \
 	 echo "#ifndef __ASM_OFFSETS_H__"; \
@@ -734,6 +735,16 @@
 	 echo "#endif" )
 endef
 
+prepare: $(OFFSETS)
+
+arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
+				   include/config/MARKER
+
+$(OFFSETS): arch/$(ARCH)/kernel/asm-offsets.s
+	$(call filechk,gen-asm-offsets)
+
+CLEAN_FILES += $(OFFSETS)
+endif
 
 ###
 # Cleaning is done on three levels.

--------------070704090708000803080707--

