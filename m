Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSKBWvC>; Sat, 2 Nov 2002 17:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbSKBWvC>; Sat, 2 Nov 2002 17:51:02 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7435 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261481AbSKBWus>;
	Sat, 2 Nov 2002 17:50:48 -0500
Date: Sat, 2 Nov 2002 23:55:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH-RFC] ARM Makefile cleanup
Message-ID: <20021102225530.GC15134@mars.ravnborg.org>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell.

This is a cleanup of the ARM makefiles.
They looked pretty OK before, but I have updated then to use the new
make clean infrastructure, and deleted inclusion of Rules.make when I
touched a file that included that file.
I also converted a lot of ifeq (...) to use the more space saving xxx-$()
approach.

I never managed to find a config that was compileable on i386, so this is
unfortunately untested.
I have looked through the diff a couple of times and expect it to be
mostly OK.

Diffstat output:

 Makefile                 |  164 +++++++++++++++--------------------------------
 boot/Makefile            |  146 ++++++++++++-----------------------------
 boot/bootp/Makefile      |    4 -
 boot/compressed/Makefile |    9 --
 4 files changed, 100 insertions(+), 223 deletions(-)

As you can see I deleted more than I added.
Let me know if this is troublesome.

	Sam


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.872   -> 1.873  
#	arch/arm/boot/Makefile	1.17    -> 1.18   
#	arch/arm/boot/compressed/Makefile	1.11    -> 1.12   
#	   arch/arm/Makefile	1.27    -> 1.28   
#	arch/arm/boot/bootp/Makefile	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/02	sam@mars.ravnborg.org	1.873
# [ARM] Makefile tidy-up
# o Use new make clean infrastructure
# o More compact assignments
# o Avoid inclusion of Rules.make
# --------------------------------------------
#
diff -Nru a/arch/arm/Makefile b/arch/arm/Makefile
--- a/arch/arm/Makefile	Sat Nov  2 23:50:48 2002
+++ b/arch/arm/Makefile	Sat Nov  2 23:50:48 2002
@@ -33,14 +33,12 @@
 # Note that GCC is lame - it doesn't numerically define an
 # architecture version macro, but instead defines a whole
 # series of macros.
-arch-y				:=
 arch-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3 -march=armv3
 arch-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4 -march=armv4
 arch-$(CONFIG_CPU_32v5)		:=-D__LINUX_ARM_ARCH__=5 -march=armv5
 arch-$(CONFIG_CPU_XSCALE)	:=-D__LINUX_ARM_ARCH__=5 -march=armv4 -Wa,-mxscale #-march=armv5te
 
 # This selects how we optimise for the processor.
-tune-y				:=
 tune-$(CONFIG_CPU_ARM610)	:=-mtune=arm610
 tune-$(CONFIG_CPU_ARM710)	:=-mtune=arm710
 tune-$(CONFIG_CPU_ARM720T)	:=-mtune=arm7tdmi
@@ -57,121 +55,67 @@
 CFLAGS		+=$(apcs-y) $(arch-y) $(tune-y) -mshort-load-bytes -msoft-float -Wa,-mno-fpu
 AFLAGS		+=$(apcs-y) $(arch-y) -mno-fpu -msoft-float -Wa,-mno-fpu
 
+
+# Default value
+DATAADDR	:= .
+
+
 ifeq ($(CONFIG_CPU_26),y)
 PROCESSOR	:= armo
 HEAD		:= arch/arm/mach-arc/head.o arch/arm/kernel/init_task.o
   ifeq ($(CONFIG_ROM_KERNEL),y)
     DATAADDR	 = 0x02080000
-    TEXTADDR	 = 0x03800000
+    textaddr-y  := 0x03800000
   else
-    TEXTADDR	 = 0x02080000
+    textaddr-y  := 0x02080000
   endif
 endif
 
 ifeq ($(CONFIG_CPU_32),y)
 PROCESSOR	 = armv
 HEAD		:= arch/arm/kernel/head.o arch/arm/kernel/init_task.o
-TEXTADDR	 = 0xC0008000
-endif
-
-ifeq ($(CONFIG_ARCH_ARCA5K),y)
-MACHINE		 = arc
-endif
-
-ifeq ($(CONFIG_ARCH_RPC),y)
-MACHINE		 = rpc
-endif
-
-ifeq ($(CONFIG_ARCH_EBSA110),y)
-MACHINE		 = ebsa110
-endif
-
-ifeq ($(CONFIG_ARCH_CLPS7500),y)
-MACHINE		 = clps7500
-INCDIR		 = cl7500
-endif
-
-ifeq ($(CONFIG_FOOTBRIDGE),y)
-MACHINE		 = footbridge
-INCDIR		 = ebsa285
-endif
-
-ifeq ($(CONFIG_ARCH_CO285),y)
-TEXTADDR	 = 0x60008000
-MACHINE		 = footbridge
-INCDIR		 = ebsa285
-endif
-
-ifeq ($(CONFIG_ARCH_FTVPCI),y)
-MACHINE		 = ftvpci
-INCDIR		 = nexuspci
-endif
-
-ifeq ($(CONFIG_ARCH_TBOX),y)
-MACHINE		 = tbox
-endif
-
-ifeq ($(CONFIG_ARCH_SHARK),y)
-MACHINE		 = shark
+textaddr-y	:= 0xC0008000
 endif
 
+ machine-$(CONFIG_ARCH_ARCA5K)	   := arc
+ machine-$(CONFIG_ARCH_RPC)	   := rpc
+ machine-$(CONFIG_ARCH_EBSA110)	   := ebsa110
+ machine-$(CONFIG_ARCH_CLPS7500)   := clps7500
+  incdir-$(CONFIG_ARCH_CLPS7500)   := cl7500
+ machine-$(CONFIG_FOOTBRIDGE)	   := footbridge
+  incdir-$(CONFIG_FOOTBRIDGE)	   := ebsa285
+textaddr-$(CONFIG_ARCH_CO285)	   := 0x60008000
+ machine-$(CONFIG_ARCH_CO285)	   := footbridge
+  incdir-$(CONFIG_ARCH_CO285)	   := ebsa285
+ machine-$(CONFIG_ARCH_FTVPCI)	   := ftvpci
+  incdir-$(CONFIG_ARCH_FTVPCI)	   := nexuspci
+ machine-$(CONFIG_ARCH_TBOX)	   := tbox
+ machine-$(CONFIG_ARCH_SHARK)	   := shark
+ machine-$(CONFIG_ARCH_SA1100)	   := sa1100
 ifeq ($(CONFIG_ARCH_SA1100),y)
-ifeq ($(CONFIG_SA1111),y)
 # SA1111 DMA bug: we don't want the kernel to live in precious DMA-able memory
-TEXTADDR	 = 0xc0208000
-endif
-MACHINE		 = sa1100
+textaddr-$(CONFIG_SA1111)	   := 0xc0208000
 endif
-
-ifeq ($(CONFIG_ARCH_PXA),y)
-MACHINE		 = pxa
-endif
-
-ifeq ($(CONFIG_ARCH_L7200),y)
-MACHINE		 = l7200
-endif
-
-ifeq ($(CONFIG_ARCH_INTEGRATOR),y)
-MACHINE		 = integrator
-endif
-
-ifeq ($(CONFIG_ARCH_CAMELOT),y)
-MACHINE          = epxa10db
-endif
-
-ifeq ($(CONFIG_ARCH_CLPS711X),y)
-TEXTADDR	 = 0xc0028000
-MACHINE		 = clps711x
-endif
-
-ifeq ($(CONFIG_ARCH_FORTUNET),y)
-TEXTADDR	 = 0xc0008000
-endif
-
-ifeq ($(CONFIG_ARCH_ANAKIN),y)
-MACHINE		 = anakin
-endif
-
-ifeq ($(CONFIG_ARCH_IOP310),y)
-MACHINE		 = iop310
-endif
-
-ifeq ($(CONFIG_ARCH_ADIFCC),y)
-MACHINE		= adifcc
+ machine-$(CONFIG_ARCH_PXA)	   := pxa
+ machine-$(CONFIG_ARCH_L7200)	   := l7200
+ machine-$(CONFIG_ARCH_INTEGRATOR) := integrator
+ machine-$(CONFIG_ARCH_CAMELOT)	   := epxa10db
+textaddr-$(CONFIG_ARCH_CLPS711X)   := 0xc0028000
+ machine-$(CONFIG_ARCH_CLPS711X)   := clps711x
+textaddr-$(CONFIG_ARCH_FORTUNET)   := 0xc0008000
+ machine-$(CONFIG_ARCH_ANAKIN)	   := anakin
+ machine-$(CONFIG_ARCH_IOP310)	   := iop310
+ machine-$(CONFIG_ARCH_ADIFCC)	   := adifcc
+
+MACHINE  := $(machine-y)
+TEXTADDR := $(textaddr-y)
+ifeq ($(incdir-y),)
+incdir-y := $(MACHINE)
 endif
+INCDIR   := $(incdir-y)
 
 export	MACHINE PROCESSOR TEXTADDR GZFLAGS CFLAGS_BOOT
 
-# Only set INCDIR if its not already defined above
-# Grr, ?= doesn't work as all the other assignment operators do.  Make bug?
-ifeq ($(origin INCDIR), undefined)
-INCDIR		:=$(MACHINE)
-endif
-
-ifeq ($(origin DATAADDR), undefined)
-DATAADDR	:= .
-endif
-
 # Do we have FASTFPE?
 FASTFPE		:=arch/arm/fastfpe
 ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
@@ -191,7 +135,7 @@
 
 libs-y				+= arch/arm/lib/
 
-makeboot = $(call descend,arch/arm/boot,$(1))
+makeboot = $(Q)$(MAKE) -f scripts/Makefile.build obj=arch/arm/boot $(1)
 
 #	Update machine arch and proc symlinks if something which affects
 #	them changed.  We use .arch and .proc to indicate when they were
@@ -214,13 +158,13 @@
 .PHONY: maketools FORCE
 maketools: include/asm-arm/.arch include/asm-arm/.proc \
 	   include/asm-arm/constants.h include/linux/version.h FORCE
-	+@$(call descend,arch/arm/tools, include/asm-arm/mach-types.h)
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/arm/tools include/asm-arm/mach-types.h
 
 zImage Image bootpImage: vmlinux
-	+@$(call makeboot,arch/arm/boot/$@)
+	$(call makeboot,arch/arm/boot/$@)
 
 bzImage zinstall install: vmlinux
-	+@$(call makeboot,$@)
+	$(call makeboot,$@)
 
 MRPROPER_FILES	+= \
 	include/asm-arm/arch include/asm-arm/.arch \
@@ -230,15 +174,15 @@
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archmrproper:
-archclean: FORCE
-	+@$(call makeboot,clean)
+archclean:
+	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/arm/boot
 
 # My testing targets (that short circuit a few dependencies)
-zImg:;	+@$(call makeboot, zImage)
-Img:;	+@$(call makeboot, Image)
-i:;	+@$(call makeboot, install)
-zi:;	+@$(call makeboot, zinstall)
-bp:;	+@$(call makeboot, bootpImage)
+zImg:;	$(call makeboot, zImage)
+Img:;	$(call makeboot, Image)
+i:;	$(call makeboot, install)
+zi:;	$(call makeboot, zinstall)
+bp:;	$(call makeboot, bootpImage)
 
 #
 # Configuration targets.  Use these to select a
@@ -259,9 +203,7 @@
 arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
 				   include/config/MARKER
 
-include/asm-$(ARCH)/constants.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
-	@$(generate-asm-offsets.h) < $< > $@
-
-include/asm-$(ARCH)/constants.h: include/asm-$(ARCH)/constants.h.tmp
+include/asm-$(ARCH)/constants.h: arch/$(ARCH)/kernel/asm-offsets.s
 	@echo -n '  Generating $@'
+	@$(generate-asm-offsets.h) < $< > $@.tmp
 	@$(update-if-changed)
diff -Nru a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
--- a/arch/arm/boot/Makefile	Sat Nov  2 23:50:48 2002
+++ b/arch/arm/boot/Makefile	Sat Nov  2 23:50:48 2002
@@ -13,116 +13,62 @@
 #   PARAMS_PHYS must be with 4MB of ZRELADDR
 #   INITRD_PHYS must be in RAM
 
-ifeq ($(CONFIG_CPU_26),y)
-ZRELADDR	 = 0x02080000
-PARAMS_PHYS	 = 0x0207c000
-INITRD_PHYS	 = 0x02180000
-endif
-
-ifeq ($(CONFIG_ARCH_RPC),y)
-ZRELADDR	 = 0x10008000
-PARAMS_PHYS	 = 0x10000100
-INITRD_PHYS	 = 0x18000000
-endif
-
-ifeq ($(CONFIG_ARCH_CLPS7500),y)
-ZRELADDR	 = 0x10008000
-endif
-
-ifeq ($(CONFIG_ARCH_EBSA110),y)
-ZRELADDR	 = 0x00008000
-PARAMS_PHYS	 = 0x00000400
-INITRD_PHYS	 = 0x00800000
-endif
-
-ifeq ($(CONFIG_ARCH_SHARK),y)
-ZTEXTADDR	 = 0x08508000
-ZRELADDR	 = 0x08008000
-endif
-
-ifeq ($(CONFIG_FOOTBRIDGE),y)
-ZRELADDR	 = 0x00008000
-PARAMS_PHYS	 = 0x00000100
-INITRD_PHYS	 = 0x00800000
-endif
-
-ifeq ($(CONFIG_ARCH_INTEGRATOR),y)
-ZRELADDR	 = 0x00008000
-PARAMS_PHYS	 = 0x00000100
-INITRD_PHYS	 = 0x00800000
-endif
-
-ifeq ($(CONFIG_ARCH_CAMELOT),y)
-ZRELADDR	 = 0x00008000
-endif
-
-ifeq ($(CONFIG_ARCH_NEXUSPCI),y)
-ZRELADDR	 = 0x40008000
-endif
-
-ifeq ($(CONFIG_ARCH_L7200),y)
-ZRELADDR	 = 0xf0008000
-endif
-
+   zreladdr-$(CONFIG_CPU_26)		:= 0x02080000 
+params_phys-$(CONFIG_CPU_26)		:= 0x0207c000
+initrd_phys-$(CONFIG_CPU_26)		:= 0x02180000
+   zreladdr-$(CONFIG_ARCH_RPC)		:= 0x10008000
+params_phys-$(CONFIG_ARCH_RPC)		:= 0x10000100
+initrd_phys-$(CONFIG_ARCH_RPC)		:= 0x18000000
+   zreladdr-$(CONFIG_ARCH_CLPS7500)	:= 0x10008000
+   zreladdr-$(CONFIG_ARCH_CLPS7500)	:= 0x10008000
+   zreladdr-$(CONFIG_ARCH_EBSA110)	:= 0x00008000
+params_phys-$(CONFIG_ARCH_EBSA110)	:= 0x00000400
+initrd_phys-$(CONFIG_ARCH_EBSA110)	:= 0x00800000
+  ztextaddr-$(CONFIG_ARCH_SHARK)	:= 0x08508000
+   zreladdr-$(CONFIG_ARCH_SHARK)	:= 0x08008000
+   zreladdr-$(CONFIG_FOOTBRIDGE)	:= 0x00008000
+params_phys-$(CONFIG_FOOTBRIDGE)	:= 0x00000100
+initrd_phys-$(CONFIG_FOOTBRIDGE)	:= 0x00800000
+   zreladdr-$(CONFIG_ARCH_INTEGRATOR)	:= 0x00008000
+params_phys-$(CONFIG_ARCH_INTEGRATOR)	:= 0x00000100
+initrd_phys-$(CONFIG_ARCH_INTEGRATOR)	:= 0x00800000
+   zreladdr-$(CONFIG_ARCH_CAMELOT)	:= 0x00008000
+   zreladdr-$(CONFIG_ARCH_NEXUSPCI)	:= 0x40008000
+   zreladdr-$(CONFIG_ARCH_L7200)	:= 0xf0008000
 # The standard locations for stuff on CLPS711x type processors
-ifeq ($(CONFIG_ARCH_CLPS711X),y)
-ZRELADDR	 = 0xc0028000
-PARAMS_PHYS	 = 0xc0000100
-endif
-
+   zreladdr-$(CONFIG_ARCH_CLPS711X)	:= 0xc0028000 
+params_phys-$(CONFIG_ARCH_CLPS711X)	:= 0xc0000100
 # Should probably have some agreement on these...
-ifeq ($(CONFIG_ARCH_P720T),y)
-INITRD_PHYS	 = 0xc0400000
-endif
-ifeq ($(CONFIG_ARCH_CDB89712),y)
-INITRD_PHYS	 = 0x00700000
-endif
-
+initrd_phys-$(CONFIG_ARCH_P720T)	:= 0xc0400000
+initrd_phys-$(CONFIG_ARCH_CDB89712)	:= 0x00700000
+   zreladdr-$(CONFIG_ARCH_SA1100)	:= 0xc0008000
 ifeq ($(CONFIG_ARCH_SA1100),y)
-ZRELADDR	 = 0xc0008000
-# No defconfig file to move this into...
-#ifeq ($(CONFIG_SA1100_YOPY),y)
-#  ZTEXTADDR      = 0x00080000
-#  ZBSSADDR       = 0xc0200000
-#endif
-ifeq ($(CONFIG_SA1111),y)
-  ZRELADDR	 = 0xc0208000
-endif
-endif
-
-ifeq ($(CONFIG_ARCH_PXA),y)
-ZRELADDR	 = 0xa0008000
-endif
-
-ifeq ($(CONFIG_ARCH_ANAKIN),y)
-ZRELADDR	 = 0x20008000
-endif
-
-ifeq ($(CONFIG_ARCH_IQ80310),y)
-ZRELADDR	 = 0xa0008000
+   zreladdr-$(CONFIG_SA1111)		:= 0xc0208000
 endif
-
-ifeq ($(CONFIG_ARCH_ADIFCC),y)
-ZRELADDR	 = 0xc0008000
-endif
-
+  zreladdr-$(CONFIG_ARCH_PXA)		:= 0xa0008000
+  zreladdr-$(CONFIG_ARCH_ANAKIN)	:= 0x20008000
+  zreladdr-$(CONFIG_ARCH_IQ80310)	:= 0xa0008000
+  zreladdr-$(CONFIG_ARCH_ADIFCC)	:= 0xc0008000
+
+ZRELADDR    := $(zreladdr-y)
+ZTEXTADDR   := $(ztextaddr-y)
+PARAMS_PHYS := $(params_phys-y)
+INITRD_PHYS := $(initrd_phys-y)
 #
 # We now have a PIC decompressor implementation.  Decompressors running
 # from RAM should not define ZTEXTADDR.  Decompressors running directly
 # from ROM or Flash must define ZTEXTADDR (preferably via the config)
 #
 ifeq ($(CONFIG_ZBOOT_ROM),y)
-ZTEXTADDR	=$(CONFIG_ZBOOT_ROM_TEXT)
-ZBSSADDR	=$(CONFIG_ZBOOT_ROM_BSS)
+ZTEXTADDR	:= $(CONFIG_ZBOOT_ROM_TEXT)
+ZBSSADDR	:= $(CONFIG_ZBOOT_ROM_BSS)
 else
-ZTEXTADDR	=0
-ZBSSADDR	=ALIGN(4)
+ZTEXTADDR	:= 0
+ZBSSADDR	:= ALIGN(4)
 endif
 
 export	ZTEXTADDR ZBSSADDR ZRELADDR INITRD_PHYS PARAMS_PHYS
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
 
@@ -135,10 +81,10 @@
 	$(call if_changed,objcopy)
 
 $(obj)/compressed/vmlinux: vmlinux FORCE
-	+@$(call descend,arch/arm/boot/compressed, $(obj)/compressed/vmlinux)
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(dir $@) $@
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
-	+@$(call descend,arch/arm/boot/bootp, $(obj)/bootp/bootp)
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(dir $@) $@
 
 .PHONY: initrd
 initrd:
@@ -157,10 +103,8 @@
 	$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) \
 	$(obj)/zImage System.map "$(INSTALL_PATH)"
 
-clean:
-	$(RM) $(addprefix $(obj)/,Image zImage bootpImage)
-	+@$(call descend,arch/arm/boot/bootp, clean)
-	+@$(call descend,arch/arm/boot/compressed, clean)
+clean-files := $(addprefix $(obj)/,Image zImage bootpImage)
+subdir-	    := bootp/ compressed/
 
 archhelp:
 	@echo  '* bzImage/zImage- Compressed kernel image (arch/$(ARCH)/boot/zImage)'
diff -Nru a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
--- a/arch/arm/boot/bootp/Makefile	Sat Nov  2 23:50:48 2002
+++ b/arch/arm/boot/bootp/Makefile	Sat Nov  2 23:50:48 2002
@@ -9,8 +9,6 @@
 
 EXTRA_TARGETS := bootp
 
-include $(TOPDIR)/Rules.make
-
 # Note that bootp.lds picks up kernel.o and initrd.o
 $(obj)/bootp:	$(addprefix $(obj)/,init.o kernel.o initrd.o bootp.lds)
 		$(LD) $(ZLDFLAGS) -o $@ $(obj)/init.o
@@ -22,5 +20,3 @@
 		$(LD) -r -s -o $@ -b binary $(INITRD)
 
 .PHONY:		$(INITRD) $(ZSYSTEM)
-
-clean:;		$(RM) $(obj)/bootp
diff -Nru a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
--- a/arch/arm/boot/compressed/Makefile	Sat Nov  2 23:50:48 2002
+++ b/arch/arm/boot/compressed/Makefile	Sat Nov  2 23:50:48 2002
@@ -63,15 +63,12 @@
 OBJS		+= head-xscale.o
 endif
 
-SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/LOAD_ADDR/$(ZRELADDR)/;\
-s/BSS_START/$(ZBSSADDR)/;s#OBJ#$(obj)#
+SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/LOAD_ADDR/$(ZRELADDR)/;s/BSS_START/$(ZBSSADDR)/
 
 EXTRA_TARGETS := vmlinux piggy.o font.o head.o $(OBJS)
 EXTRA_CFLAGS  := $(CFLAGS_BOOT) -fpic
 EXTRA_AFLAGS  := -traditional
 
-include $(TOPDIR)/Rules.make
-
 LDFLAGS_vmlinux := -p -X \
 	$(shell $(CC) $(CFLAGS) --print-libgcc-file-name) -T
 
@@ -93,9 +90,7 @@
 $(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in Makefile arch/arm/boot/Makefile .config
 	@sed "$(SEDFLAGS)" < $< > $@
 
-.PHONY:	clean
-clean:
-	rm -f $(addprefix $(obj)/,vmlinux core piggy* vmlinux.lds)
+clean-files := $(addprefix $(obj)/,vmlinux piggy* vmlinux.lds)
 
 $(obj)/misc.o: $(obj)/misc.c include/asm/arch/uncompress.h lib/inflate.c
 
