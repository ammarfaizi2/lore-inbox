Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbSL3Lpa>; Mon, 30 Dec 2002 06:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSL3Lpa>; Mon, 30 Dec 2002 06:45:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:56082 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266924AbSL3LpP>;
	Mon, 30 Dec 2002 06:45:15 -0500
Date: Mon, 30 Dec 2002 12:53:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Subject: [CFT] arch/alpha: Makefiles update
Message-ID: <20021230115336.GA1089@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Richard Henderson <rth@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have given the Alpha Makefile a rehaul, but lacks the
binaries to actually test if it is OK.
Primary purpose is to make the architecture makefiles more look alike.

Anyone with alpha tools that want to give this a try?

When testing try out the following:

make
make msb
make srmboot
make boot
make bootimage

and try also
make KBUILD_VERBOSE=0 bootimage

Execute "find arch/alpha -name '*.o' | xargs rm"
to force the architecture specific files to be recompiled between each run.

I appreciate any feedback on the patch, as well as go/no-go reports.
With this amount of changes I expect a few bugs, although I have been
carefull reviewing my changes.

The target "rawboot" has been removed. Anyone using this?
Same question goes for msb (my-special-boot) and srmboot.

	Sam

Following files were changed:

 Makefile          |  147 ++++++++++++++++++++----------------------------------
 boot/Makefile     |  137 +++++++++++++++++++++++---------------------------
 kernel/Makefile   |    9 +--
 lib/Makefile      |   69 ++++++++++++-------------
 math-emu/Makefile |    3 -
 5 files changed, 158 insertions(+), 207 deletions(-)


===== arch/alpha/Makefile 1.18 vs edited =====
--- 1.18/arch/alpha/Makefile	Tue Nov  5 17:08:09 2002
+++ edited/arch/alpha/Makefile	Sun Dec 29 23:55:13 2002
@@ -10,13 +10,17 @@
 
 NM := $(NM) -B
 
-LDFLAGS_vmlinux = -static -N #-relax
-CFLAGS := $(CFLAGS) -pipe -mno-fp-regs -ffixed-8
-LDFLAGS_BLOB := --format binary --oformat elf64-alpha
+LDFLAGS_vmlinux	:= -static -N #-relax
+LDFLAGS_BLOB	:= --format binary --oformat elf64-alpha
+cflags-y	:= -pipe -mno-fp-regs -ffixed-8
 
 # Determine if we can use the BWX instructions with GAS.
 old_gas := $(shell if $(AS) --version 2>&1 | grep 'version 2.7' > /dev/null; then echo y; else echo n; fi)
 
+ifeq ($(old_gas),y)
+$(error The assembler '$(AS)' does not support the BWX instruction)
+endif
+
 # Determine if GCC understands the -mcpu= option.
 have_mcpu := $(shell if $(CC) -mcpu=ev5 -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo y; else echo n; fi)
 
@@ -27,68 +31,36 @@
 have_mcpu_ev67 := $(shell if $(CC) -mcpu=ev67 -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo y; else echo n; fi)
 
 have_msmall_data := $(shell if $(CC) -msmall-data -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo y; else echo n; fi)
-ifeq ($(have_msmall_data),y)
-  CFLAGS := $(CFLAGS) -msmall-data
-endif
 
-# Turn on the proper cpu optimizations.
-ifeq ($(have_mcpu),y)
-  # If GENERIC, make sure to turn off any instruction set extensions that
-  # the host compiler might have on by default.  Given that EV4 and EV5
-  # have the same instruction set, prefer EV5 because an EV5 schedule is
-  # more likely to keep an EV4 processor busy than vice-versa.
-  mcpu_done := n
-  ifeq ($(CONFIG_ALPHA_GENERIC),y)
-    CFLAGS := $(CFLAGS) -mcpu=ev5
-    mcpu_done := y
-  endif
-  ifeq ($(mcpu_done)$(CONFIG_ALPHA_SX164)$(have_mcpu_pca56),nyy)
-    CFLAGS := $(CFLAGS) -mcpu=pca56
-    mcpu_done := y
-  endif
-  ifeq ($(mcpu_done)$(CONFIG_ALPHA_POLARIS)$(have_mcpu_pca56),nyy)
-    CFLAGS := $(CFLAGS) -mcpu=pca56
-    mcpu_done := y
-  endif
-  ifeq ($(mcpu_done)$(CONFIG_ALPHA_EV4),ny)
-    CFLAGS := $(CFLAGS) -mcpu=ev4
-    mcpu_done := y
-  endif
-  ifeq ($(mcpu_done)$(CONFIG_ALPHA_EV56),ny)
-    CFLAGS := $(CFLAGS) -mcpu=ev56
-    mcpu_done := y
-  endif
-  ifeq ($(mcpu_done)$(CONFIG_ALPHA_EV5),ny)
-    CFLAGS := $(CFLAGS) -mcpu=ev5
-    mcpu_done := y
-  endif
-  ifeq ($(mcpu_done)$(CONFIG_ALPHA_EV67)$(have_mcpu_ev67),nyy)
-    CFLAGS := $(CFLAGS) -mcpu=ev67
-    mcpu_done := y
-  endif
-  ifeq ($(mcpu_done)$(CONFIG_ALPHA_EV6),ny)
-    ifeq ($(have_mcpu_ev6),y)
-      CFLAGS := $(CFLAGS) -mcpu=ev6
-    else
-      ifeq ($(have_mcpu_pca56),y)
-        CFLAGS := $(CFLAGS) -mcpu=pca56
-      else
-        CFLAGS := $(CFLAGS) -mcpu=ev56
-      endif
-    endif
-    mcpu_done := y
-  endif
-endif
+cflags-$(have_msmall_data) += -msmall-data
+
+# If ALPHA_GENERIC, make sure to turn off any instruction set extensions
+# that the host compiler might have on by default. Given that EV4 and EV5
+# have the same instruction set, prefer EV5 because an EV5 schedule is
+# more likely to keep an EV4 processor busy than vice-versa.
+ 
+# Default value
+mach-yy := ev56
+mach-$(have_mcpu_pca56)$(have_mcpu_pca56)	:= pca56
+
+#Machine depedent values, influenced by gcc capabilitites
+mach-$(CONFIG_ALPHA_SX164)$(have_mcpu_pca56)	:= pca56
+mach-$(CONFIG_ALPHA_POLARIS)$(have_mcpu_pca56)	:= pca56
+mach-$(CONFIG_ALPHA_EV67)$(have_mcpu_ev67)	:= ev67
+
+mach-y				:= $(mach-yy)
+mach-$(CONFIG_ALPHA_GENERIC)	:= ev5
+mach-$(CONFIG_ALPHA_EV4)	:= ev4
+mach-$(CONFIG_ALPHA_EV56)	:= ev56
+mach-$(CONFIG_ALPHA_EV5)	:= ev5
+mach-$(CONFIG_ALPHA_EV6)	:= ev6
+
+cflags-$(have_mcpu) += -mcpu=$(mach-y)
 
 # For TSUNAMI, we must have the assembler not emulate our instructions.
 # The same is true for IRONGATE, POLARIS, PYXIS.
 # BWX is most important, but we don't really want any emulation ever.
-
-ifeq ($(old_gas),y)
-  # How do we do #error in make?
-  CFLAGS := --error-please-upgrade-your-assembler
-endif
-CFLAGS := $(CFLAGS) -Wa,-mev6
+CFLAGS += $(cflags-y) -Wa,-mev6
 
 HEAD := arch/alpha/kernel/head.o
 
@@ -96,37 +68,21 @@
 core-$(CONFIG_MATHEMU)  += arch/alpha/math-emu/
 libs-y			+= arch/alpha/lib/
 
-export libs-y
+boot := arch/alpha/boot
 
-MAKEBOOT = $(MAKE) -C arch/alpha/boot
+#Default target when executing make with no arguments
+all boot: $(boot)/vmlinux.gz
 
-rawboot:	vmlinux
-	@$(MAKEBOOT) rawboot
+$(boot)/vmlinux.gz: vmlinux
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $@
 
-boot:	vmlinux
-	@$(MAKEBOOT)
+# My special boot (msb) writes directly to a specific disk partition,
+# I doubt most people will want to do that without changes..
+msb srmboot: vmlinux
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $@
 
-#
-# My boot writes directly to a specific disk partition, I doubt most
-# people will want to do that without changes..
-#
-msb my-special-boot:	vmlinux
-	@$(MAKEBOOT) msb
-
-bootimage:	vmlinux
-	@$(MAKEBOOT) bootimage
-
-srmboot:	vmlinux
-	@$(MAKEBOOT) srmboot
-
-archclean:
-	@$(MAKEBOOT) clean
-
-archmrproper:
-	rm -f include/asm-alpha/asm_offsets.h
-
-bootpfile:	vmlinux
-	@$(MAKEBOOT) bootpfile
+bootimage bootpfile: vmlinux
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $(boot)/$@
 
 
 prepare: include/asm-$(ARCH)/asm_offsets.h
@@ -134,12 +90,21 @@
 arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
 				   include/config/MARKER
 
-include/asm-$(ARCH)/asm_offsets.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
-	@$(generate-asm-offsets.h) < $< > $@
-
-include/asm-$(ARCH)/asm_offsets.h: include/asm-$(ARCH)/asm_offsets.h.tmp
+include/asm-$(ARCH)/asm_offsets.h: include/asm-$(ARCH)/asm_offsets.h
 	@echo -n '  Generating $@'
+	@$(generate-asm-offsets.h) < $< > $@.tmp
 	@$(update-if-changed)
 
+archclean:
+	$(Q)$(MAKE) -f scripts/Makefile.clean obj=$(boot)
+
 CLEAN_FILES += include/asm-$(ARCH)/offset.h.tmp \
 	       include/asm-$(ARCH)/offset.h
+
+define archhelp
+  echo '* boot		- Compressed kernel image (arch/alpha/boot/vmlinux.gz)'
+  echo '  bootimage	- Bootable image (arch/alpha/boot/bootimage)'
+  echo '  bootpfile	- INITRD image (arch/alpha(boot/bootpfile)'
+  echo '  srmboot	- Write bootimage to $$(BOOTDEV)'
+  echo '  msb		- My special boot???'
+endef
===== arch/alpha/boot/Makefile 1.10 vs edited =====
--- 1.10/arch/alpha/boot/Makefile	Tue Oct  8 16:14:54 2002
+++ edited/arch/alpha/boot/Makefile	Mon Dec 30 00:05:01 2002
@@ -8,58 +8,50 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
-LINKFLAGS = -static -T bootloader.lds -uvsprintf #-N -relax
 
-CFLAGS := $(CFLAGS) -I$(TOPDIR)/include
-
-.S.s:
-	$(CPP) $(AFLAGS) -traditional -o $*.o $<
-.S.o:
-	$(CC) $(AFLAGS) -traditional -c -o $*.o $<
-
-OBJECTS = head.o main.o
-BPOBJECTS = head.o bootp.o
-TARGETS = vmlinux.gz tools/objstrip # also needed by aboot & milo
-VMLINUX = $(TOPDIR)/vmlinux
-OBJSTRIP = tools/objstrip
-LIBS := $(addprefix $(TOPDIR)/,$(libs-y))
-
-all:	$(TARGETS)
-	@echo Ready to install kernel in $(shell pwd)/vmlinux.gz
-
-# normally no need to build these:
-rawboot: vmlinux.nh tools/lxboot tools/bootlx
-
-msb:	tools/lxboot tools/bootlx vmlinux.nh
-	( cat tools/lxboot tools/bootlx vmlinux.nh ) > /dev/rz0a
-	disklabel -rw rz0 'linux' tools/lxboot tools/bootlx
-
-bootimage:	tools/mkbb tools/lxboot tools/bootlx vmlinux.nh
-	( cat tools/lxboot tools/bootlx vmlinux.nh ) > bootimage
-	tools/mkbb bootimage tools/lxboot
-
-bootpfile:	tools/bootph vmlinux.nh
-	cat tools/bootph vmlinux.nh > bootpfile
+host-progs	:= tools/mkbb tools/objstrip
+EXTRA_TARGETS	:= vmlinux.gz vmlinux \
+		   vmlinux.nh tools/lxboot tools/bootlx tools/bootph \
+		   bootloader bootpheader 
+OBJSTRIP	:= $(obj)/tools/objstrip
+
+# normally no need to build these: (FIXME: Kill?)
+rawboot: $(obj)/vmlinux.nh $(obj)/tools/lxboot $(obj)/tools/bootlx
+
+# bootimage prepared with boot sector
+$(obj)/bootimage: $(addprefix $(obj)/tools/,mkbb lxboot bootlx) $(obj)/vmlinux.nh
+	( cat $(obj)/tools/lxboot $(obj)/tools/bootlx $(obj)/vmlinux.nh ) > $@ 
+	$(obj)/tools/mkbb $@ $(obj)/tools/lxboot
+	@echo '  Bootimage $@ is ready'
+
+# bootp file including INITRD
+$(obj)/bootpfile: $(obj)/tools/bootph $(obj)/vmlinux.nh
+	cat $(obj)/tools/bootph $(obj)/vmlinux.nh > $@
 ifdef INITRD
-	cat $(INITRD) >> bootpfile
+	cat $(INITRD) >> $@
 endif
 
-srmboot:	bootdevice bootimage
-	dd if=bootimage of=$(BOOTDEV) bs=512 seek=1 skip=1
-	tools/mkbb $(BOOTDEV) tools/lxboot
+# My special boot (FIXME: Kill?)
+msb:	$(obj)/tools/lxboot $(obj)/tools/bootlx $(obj)/vmlinux.nh
+	( cat $^ ) > /dev/rz0a
+	disklabel -rw rz0 'linux' $(obj)/tools/lxboot $(obj)/tools/bootlx
 
-bootdevice:
+# Bootimage copied to $(BOOTDEV)
+srmboot: $(obj)/bootimage
 	@test "$(BOOTDEV)" != ""  || (echo You must specify BOOTDEV ; exit -1)
+	dd if=$(obj)/bootimage of=$(BOOTDEV) bs=512 seek=1 skip=1
+	$(obj)/tools/mkbb $(BOOTDEV) $(obj)/tools/lxboot
 
-vmlinux.gz: vmlinux
-	gzip -fv9 vmlinux
-
-main.o: ksize.h
+# Compressed kernel image
+$(obj)/vmlinux.gz: $(obj)/vmlinux FORCE
+	$(call if_changed,gzip)
+	@echo '  Kernel $@ is ready'
 
-bootp.o: ksize.h
+$(obj)/main.o: $(obj)/ksize.h
+$(obj)/bootp.o: $(obj)/ksize.h
 
-ksize.h: vmlinux.nh FORCE
-	echo "#define KERNEL_SIZE `ls -l vmlinux.nh | awk '{print $$5}'`" > $@T
+$(obj)/ksize.h: $(obj)/vmlinux.nh FORCE
+	echo "#define KERNEL_SIZE `ls -l $(obj)/vmlinux.nh | awk '{print $$5}'`" > $@T
 ifdef INITRD
 	[ -f $(INITRD) ] || exit 1
 	echo "#define INITRD_IMAGE_SIZE `ls -l $(INITRD) | awk '{print $$5}'`" >> $@T
@@ -67,36 +59,37 @@
 	cmp -s $@T $@ || mv -f $@T $@
 	rm -f $@T
 
-vmlinux.nh: $(VMLINUX) $(OBJSTRIP)
-	$(OBJSTRIP) -v $(VMLINUX) vmlinux.nh
-
-vmlinux: $(TOPDIR)/vmlinux
-	$(STRIP) -o vmlinux $(VMLINUX)
-
-tools/lxboot: $(OBJSTRIP) bootloader
-	$(OBJSTRIP) -p bootloader tools/lxboot
-
-tools/bootlx: bootloader $(OBJSTRIP)
-	$(OBJSTRIP) -vb bootloader tools/bootlx
-
-tools/bootph: bootpheader $(OBJSTRIP)
-	$(OBJSTRIP) -vb bootpheader tools/bootph
-
-$(OBJSTRIP): $(OBJSTRIP).c
-	$(HOSTCC) $(HOSTCFLAGS) $< -o $@
-
-tools/mkbb: tools/mkbb.c
-	$(HOSTCC) tools/mkbb.c -o tools/mkbb
+quiet_cmd_strip = STRIP  $@
+      cmd_strip = $(STRIP) -o $@ $<
+$(obj)/vmlinux: vmlinux FORCE
+	$(call if_changed,strip)
+
+quiet_cmd_objstrip = OBJSTRIP $@
+      cmd_objstrip = $(OBJSTRIP) $(OSFLAGS_$(@F)) $< $@
+
+OSFLAGS_vmlinux.nh	:= -v
+OSFLAGS_lxboot		:= -p
+OSFLAGS_bootlx		:= -vb
+OSFLAGS_bootph		:= -vb
+
+$(obj)/vmlinux.nh: vmlinux $(OBJSTRIP) FORCE
+	$(call if_changed,objstrip)
+	
+$(obj)/tools/lxboot: $(obj)/bootloader $(OBJSTRIP) FORCE
+	$(call if_changed,objstrip)
+
+$(obj)/tools/bootlx: $(obj)/bootloader $(OBJSTRIP) FORCE
+	$(call if_changed,objstrip)
+
+$(obj)/tools/bootph: $(obj)/bootpheader $(OBJSTRIP) FORCE
+	$(call if_changed,objstrip)
 
-bootloader: $(OBJECTS)
-	$(LD) $(LINKFLAGS) $(OBJECTS) $(LIBS) -o bootloader
+LDFLAGS_bootloader  := -static -uvsprintf -T  #-N -relax
+LDFLAGS_bootpheader := -static -uvsprintf -T  #-N -relax
 
-bootpheader: $(BPOBJECTS)
-	$(LD) $(LINKFLAGS) $(BPOBJECTS) $(LIBS) -o bootpheader
+$(obj)/bootloader: $(obj)/bootloader.lds $(obj)/head.o $(obj)/main.o FORCE
+	$(call if_changed,ld)
 
-clean:
-	rm -f $(TARGETS) bootloader bootimage bootpfile bootpheader
-	rm -f tools/mkbb tools/bootlx tools/lxboot tools/bootph
-	rm -f vmlinux.nh ksize.h
+$(obj)/bootpheader: $(obj)/bootloader.lds $(obj)/head.o $(obj)/bootp.o FORCE
+	$(call if_changed,ld)
 
-FORCE:
===== arch/alpha/kernel/Makefile 1.15 vs edited =====
--- 1.15/arch/alpha/kernel/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/alpha/kernel/Makefile	Sat Dec 28 22:06:36 2002
@@ -19,12 +19,9 @@
 obj-y	 += irq_i8259.o irq_srm.o \
 	    es1888.o smc37c669.o smc37c93x.o ns87312.o
 
-ifdef CONFIG_VGA_HOSE
-obj-y	 += console.o
-endif
-
-obj-$(CONFIG_SMP)    += smp.o
-obj-$(CONFIG_PCI)    += pci.o pci_iommu.o
+obj-$(CONFIG_VGA_HOSE)	+= console.o
+obj-$(CONFIG_SMP)	+= smp.o
+obj-$(CONFIG_PCI)	+= pci.o pci_iommu.o
 obj-$(CONFIG_SRM_ENV)	+= srm_env.o
 
 ifdef CONFIG_ALPHA_GENERIC
===== arch/alpha/lib/Makefile 1.11 vs edited =====
--- 1.11/arch/alpha/lib/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/alpha/lib/Makefile	Sat Dec 28 22:31:41 2002
@@ -7,58 +7,55 @@
 
 # Many of these routines have implementations tuned for ev6.
 # Choose them iff we're targeting ev6 specifically.
-ev6 :=
-ifeq ($(CONFIG_ALPHA_EV6),y)
-  ev6 := ev6-
-endif
+ev6-$(CONFIG_ALPHA_EV6) := ev6-
 
 # Several make use of the cttz instruction introduced in ev67.
-ev67 :=
-ifeq ($(CONFIG_ALPHA_EV67),y)
-  ev67 := ev67-
-endif
+ev67-$(CONFIG_ALPHA_EV67) := ev67-
 
 obj-y =	__divqu.o __remqu.o __divlu.o __remlu.o \
 	udelay.o \
-	$(ev6)memset.o \
-	$(ev6)memcpy.o \
+	$(ev6-y)memset.o \
+	$(ev6-y)memcpy.o \
 	memmove.o \
 	io.o \
 	checksum.o \
 	csum_partial_copy.o \
-	$(ev67)strlen.o \
-	$(ev67)strcat.o \
+	$(ev67-y)strlen.o \
+	$(ev67-y)strcat.o \
 	strcpy.o \
-	$(ev67)strncat.o \
+	$(ev67-y)strncat.o \
 	strncpy.o \
-	$(ev6)stxcpy.o \
-	$(ev6)stxncpy.o \
-	$(ev67)strchr.o \
-	$(ev67)strrchr.o \
-	$(ev6)memchr.o \
-	$(ev6)copy_user.o \
-	$(ev6)clear_user.o \
-	$(ev6)strncpy_from_user.o \
-	$(ev67)strlen_user.o \
-	$(ev6)csum_ipv6_magic.o \
-	$(ev6)clear_page.o \
-	$(ev6)copy_page.o \
+	$(ev6-y)stxcpy.o \
+	$(ev6-y)stxncpy.o \
+	$(ev67-y)strchr.o \
+	$(ev67-y)strrchr.o \
+	$(ev6-y)memchr.o \
+	$(ev6-y)copy_user.o \
+	$(ev6-y)clear_user.o \
+	$(ev6-y)strncpy_from_user.o \
+	$(ev67-y)strlen_user.o \
+	$(ev6-y)csum_ipv6_magic.o \
+	$(ev6-y)clear_page.o \
+	$(ev6-y)copy_page.o \
 	strcasecmp.o \
 	fpreg.o \
 	callback_srm.o srm_puts.o srm_printk.o
 
 obj-$(CONFIG_SMP) += dec_and_lock.o
 
-$(obj)/__divqu.o: $(obj)/$(ev6)divide.S
-	$(CC) $(AFLAGS) -DDIV -c -o $(obj)/__divqu.o $(obj)/$(ev6)divide.S
+AFLAGS___divqu.o = -DDIV
+AFLAGS___remqu.o =       -DREM
+AFLAGS___divlu.o =               -DDIV   -DINTSIZE
+AFLAGS___remlu.o =       -DREM           -DINTSIZE
+
+$(obj)/__divqu.o: $(obj)/$(ev6-y)divide.S
+	$(cmd_as_o_S)
 
-$(obj)/__remqu.o: $(obj)/$(ev6)divide.S
-	$(CC) $(AFLAGS) -DREM -c -o $(obj)/__remqu.o $(obj)/$(ev6)divide.S
+$(obj)/__remqu.o: $(obj)/$(ev6-y)divide.S
+	$(cmd_as_o_S)
 
-$(obj)/__divlu.o: $(obj)/$(ev6)divide.S
-	$(CC) $(AFLAGS) -DDIV -DINTSIZE \
-		-c -o $(obj)/__divlu.o $(obj)/$(ev6)divide.S
-
-$(obj)/__remlu.o: $(obj)/$(ev6)divide.S
-	$(CC) $(AFLAGS) -DREM -DINTSIZE \
-		-c -o $(obj)/__remlu.o $(obj)/$(ev6)divide.S
+(obj)/__divlu.o: $(obj)/$(ev6-y)divide.S
+	$(cmd_as_o_S)
+
+$(obj)/__remlu.o: $(obj)/$(ev6-y)divide.S
+	$(cmd_as_o_S)
===== arch/alpha/math-emu/Makefile 1.6 vs edited =====
--- 1.6/arch/alpha/math-emu/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/arch/alpha/math-emu/Makefile	Sat Dec 28 22:33:53 2002
@@ -1,7 +1,6 @@
 #
 # Makefile for the FPU instruction emulation.
 #
-
-CFLAGS += -I. -I$(TOPDIR)/include/math-emu -w
+CFLAGS += -Iinclude/math-emu -w
 
 obj-$(CONFIG_MATHEMU) += math.o qrnnd.o
