Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261355AbSJLVeH>; Sat, 12 Oct 2002 17:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbSJLVeH>; Sat, 12 Oct 2002 17:34:07 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:62991 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261355AbSJLVeB>;
	Sat, 12 Oct 2002 17:34:01 -0400
Date: Sat, 12 Oct 2002 23:38:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kai.germaschewski@gmx.de
Subject: Re: 2.5.42 broke ARM zImage/Image
Message-ID: <20021012233818.A9394@mars.ravnborg.org>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, kai.germaschewski@gmx.de
References: <20021012123256.C12955@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021012123256.C12955@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Oct 12, 2002 at 12:32:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 12:32:56PM +0100, Russell King wrote:
> Hi,
> 
> I'm trying to get 2.5.42 to build on ARM, and I've finally run out of
> ideas for things to try to get arch/arm/boot/Makefile and
> arch/arm/boot/compressed/Makefile to work correctly.
> 
> What I'm seeing is:
> 
> /home/rmk/bin/arm-linux-ld -p -X -T vmlinux.lds head.o misc.o piggy.o /home/rmk/arm-linux/lib/gcc-lib/arm-linux/2.95.3/libgcc.a -o vmlinux
> /home/rmk/bin/arm-linux-ld:vmlinux.lds:14: parse error
> make[2]: *** [vmlinux] Error 1
> make[1]: *** [compressed/vmlinux] Error 2
> make: *** [zImage] Error 2

Well, I have no idea why this particular errors has appeared,
but I took a look at the arm makefiles in 2.5.42.

This is my first sot at converting them to the new kbuild
way of doing things.
I have fixed several potential problems.
I also took advantage of the infrastructure in Rules.make, especially
in boot and boot/compressed.

I have installed arm-linux-gcc 2.95.3, but the compilations fails
early, so this is untested.

Let me know if you want me to proceed, and in that case where to get
a compile able arm-kernel.

	Sam

===== arch/arm/Makefile 1.23 vs edited =====
--- 1.23/arch/arm/Makefile	Mon Sep 23 01:33:05 2002
+++ edited/arch/arm/Makefile	Sat Oct 12 23:18:37 2002
@@ -179,8 +179,7 @@
 
 libs-y				+= arch/arm/lib/
 
-MAKEBOOT	 =$(MAKE) -C arch/$(ARCH)/boot
-MAKETOOLS	 =$(MAKE) -C arch/$(ARCH)/tools
+makeboot = $(call descend,arch/arm/boot,$(1))
 
 #	Update machine arch and proc symlinks if something which affects
 #	them changed.  We use .arch and .proc to indicate when they were
@@ -200,13 +199,13 @@
 
 prepare: maketools
 
-.PHONY: maketools
+.PHONY: maketools FORCE
 maketools: include/asm-arm/.arch include/asm-arm/.proc \
-	 include/asm-arm/constants.h include/linux/version.h FORCE
-	@$(MAKETOOLS)
+	   include/asm-arm/constants.h include/linux/version.h FORCE
+	+@$(call descend,arch/arm/tools, include/asm-arm/mach-types.h)
 
 bzImage zImage zinstall Image bootpImage install: vmlinux
-	@$(MAKEBOOT) $@
+	+@$(call makeboot,$@)
 
 MRPROPER_FILES	+= \
 	include/asm-arm/arch include/asm-arm/.arch \
@@ -215,18 +214,16 @@
 	include/asm-arm/mach-types.h
 
 # We use MRPROPER_FILES and CLEAN_FILES now
-archmrproper: FORCE
-	@/bin/true
-
+archmrproper:
 archclean: FORCE
-	@$(MAKEBOOT) clean
+	+@$(call makeboot,clean)
 
 # My testing targets (that short circuit a few dependencies)
-zImg:;	@$(MAKEBOOT) zImage
-Img:;	@$(MAKEBOOT) Image
-i:;	@$(MAKEBOOT) install
-zi:;	@$(MAKEBOOT) zinstall
-bp:;	@$(MAKEBOOT) bootpImage
+zImg:;	+@$(call makeboot, zImage)
+Img:;	+@$(call makeboot, Image)
+i:;	+@$(call makeboot, install)
+zi:;	+@$(call makeboot, zinstall)
+bp:;	+@$(call makeboot, bootpImage)
 
 #
 # Configuration targets.  Use these to select a
===== arch/arm/boot/Makefile 1.15 vs edited =====
--- 1.15/arch/arm/boot/Makefile	Wed Aug 21 17:00:38 2002
+++ edited/arch/arm/boot/Makefile	Sat Oct 12 22:18:57 2002
@@ -8,8 +8,6 @@
 # Copyright (C) 1995-2002 Russell King
 #
 
-SYSTEM	=$(TOPDIR)/vmlinux
-
 # Note: the following conditions must always be true:
 #   ZRELADDR == virt_to_phys(TEXTADDR)
 #   PARAMS_PHYS must be with 4MB of ZRELADDR
@@ -121,38 +119,46 @@
 ZBSSADDR	=ALIGN(4)
 endif
 
-export	SYSTEM ZTEXTADDR ZBSSADDR ZRELADDR INITRD_PHYS PARAMS_PHYS
+export	ZTEXTADDR ZBSSADDR ZRELADDR INITRD_PHYS PARAMS_PHYS
+
+include $(TOPDIR)/Rules.make
 
-Image:	$(SYSTEM)
-	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@
+$(obj)/Image: vmlinux FORCE
+	$(call if_changed,objcopy)
 
 bzImage: zImage
 
-zImage:	compressed/vmlinux
-	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@
+$(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
+	$(call if_changed,objcopy)
 
-bootpImage: bootp/bootp
-	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@
+$(obj)/bootpImage: $(obj)/bootp/bootp FORCE
+	$(call if_changed,objcopy)
 
-compressed/vmlinux: $(TOPDIR)/vmlinux FORCE
-	@$(MAKE) -C compressed vmlinux
+$(obj)/compressed/vmlinux: vmlinux FORCE
+	+@$(descend arch/arm/boot/compressed, vmlinux)
 
-bootp/bootp: zImage initrd FORCE
-	@$(MAKE) -C bootp bootp
+$(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
+	+@$(descend arch/arm/boot/bootp, bootp)
 
+.PHONY: initrd
 initrd:
-	@test "$(INITRD_PHYS)" != "" || (echo This machine does not support INITRD; exit -1)
-	@test "$(INITRD)" != "" || (echo You must specify INITRD; exit -1)
-
-install: Image
-	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) Image $(TOPDIR)/System.map "$(INSTALL_PATH)"
-
-zinstall: zImage
-	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) zImage $(TOPDIR)/System.map "$(INSTALL_PATH)"
+	@test "$(INITRD_PHYS)" != "" || \
+	(echo This machine does not support INITRD; exit -1)
+	@test "$(INITRD)" != "" || \
+	(echo You must specify INITRD; exit -1)
+
+install: $(obj)/Image
+	$(CONFIG_SHELL) $(obj)/install.sh \
+	$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) \
+	$(obj)/Image System.map "$(INSTALL_PATH)"
+
+zinstall: $(obj)/zImage
+	$(CONFIG_SHELL) $(obj)/install.sh \
+	$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) \
+	$(obj)/zImage System.map "$(INSTALL_PATH)"
 
 clean:
-	$(RM) Image zImage bootpImage
-	@$(MAKE) -C compressed clean
-	@$(MAKE) -C bootp clean
+	$(RM) $(addprefix $(obj)/,Image zImage bootpImage)
+	+@$(call descend arch/arm/boot/bootp, clean)
+	+@$(call descend arch/arm/boot/compressed, clean)
 
-FORCE:
===== arch/arm/boot/bootp/Makefile 1.5 vs edited =====
--- 1.5/arch/arm/boot/bootp/Makefile	Wed Aug 21 17:11:43 2002
+++ edited/arch/arm/boot/bootp/Makefile	Sat Oct 12 22:31:50 2002
@@ -2,23 +2,25 @@
 # linux/arch/arm/boot/bootp/Makefile
 #
 
-ZSYSTEM		=$(TOPDIR)/arch/arm/boot/zImage
-ZLDFLAGS	=-p -X -T bootp.lds \
+ZSYSTEM		= arch/arm/boot/zImage
+ZLDFLAGS	=-p -X -T $(obj)/bootp.lds \
 		 --defsym initrd_addr=$(INITRD_PHYS) \
 		 --defsym params=$(PARAMS_PHYS)
 
-all:		bootp
+EXTRA_TARGETS := bootp
+
+include $(TOPDIR)/Rules.make
 
 # Note that bootp.lds picks up kernel.o and initrd.o
-bootp:		init.o kernel.o initrd.o bootp.lds
-		$(LD) $(ZLDFLAGS) -o $@ init.o
+$(obj)/bootp:	$(addprefix $(obj)/,init.o kernel.o initrd.o bootp.lds)
+		$(LD) $(ZLDFLAGS) -o $@ $(obj)/init.o
 
-kernel.o:	$(ZSYSTEM)
+$(obj)/kernel.o: $(ZSYSTEM)
 		$(LD) -r -s -o $@ -b binary $(ZSYSTEM)
 
-initrd.o:	$(INITRD)
+$(obj)/initrd.o: $(INITRD)
 		$(LD) -r -s -o $@ -b binary $(INITRD)
 
 .PHONY:		$(INITRD) $(ZSYSTEM)
 
-clean:;		$(RM) bootp
+clean:;		$(RM) $(obj)/bootp
===== arch/arm/boot/compressed/Makefile 1.9 vs edited =====
--- 1.9/arch/arm/boot/compressed/Makefile	Thu Jun 20 20:35:13 2002
+++ edited/arch/arm/boot/compressed/Makefile	Sat Oct 12 22:19:16 2002
@@ -3,15 +3,13 @@
 #
 # create a compressed vmlinuz image from the original vmlinux
 #
-# Note! SYSTEM, ZTEXTADDR, ZBSSADDR and ZRELADDR are now exported
+# Note! ZTEXTADDR, ZBSSADDR and ZRELADDR are now exported
 # from arch/arm/boot/Makefile
 #
 
-HEAD		 = head.o
-OBJS		 = misc.o
-CFLAGS		 = $(CPPFLAGS) -O2 -DSTDC_HEADERS $(CFLAGS_BOOT) -fpic
-FONTC		 = $(TOPDIR)/drivers/video/font_acorn_8x8.c
-ZLDFLAGS	 = -p -X -T vmlinux.lds
+HEAD	= head.o
+OBJS	= misc.o
+FONTC	= drivers/video/font_acorn_8x8.c
 
 #
 # Architecture dependencies
@@ -67,33 +65,35 @@
 
 SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/LOAD_ADDR/$(ZRELADDR)/;s/BSS_START/$(ZBSSADDR)/
 
-LIBGCC		:= $(shell $(CC) $(CFLAGS) --print-libgcc-file-name)
+EXTRA_TARGETS := vmlinux piggy.o font.o head.o $(OBJS)
+EXTRA_CFLAGS  := $(CFLAGS_BOOT) -fpic
+EXTRA_AFLAGS  := -traditional
 
-all:		vmlinux
+include $(TOPDIR)/Rules.make
 
-vmlinux:	$(HEAD) $(OBJS) piggy.o vmlinux.lds
-		$(LD) $(ZLDFLAGS) $(HEAD) $(OBJS) piggy.o $(LIBGCC) -o vmlinux
+LDFLAGS_vmlinux := -p -X -T $(obj)/vmlinux.lds \
+	$(shell $(CC) $(CFLAGS) --print-libgcc-file-name)
 
-$(HEAD): 	$(HEAD:.o=.S)
-		$(CC) $(AFLAGS) -traditional -c $(HEAD:.o=.S)
+$(obj)/vmlinux: $(obj)/$(HEAD) $(obj)/piggy.o $(obj)/vmlinux.lds \
+	 	$(addprefix $(obj)/, $(OBJS))
+	$(call if_changed,ld)
 
-piggy.o:	$(SYSTEM)
-		$(OBJCOPY) $(OBJCOPYFLAGS) $(SYSTEM) piggy
-		gzip $(GZFLAGS) < piggy > piggy.gz
-		$(LD) -r -o $@ -b binary piggy.gz
-		rm -f piggy piggy.gz
 
-font.o:		$(FONTC)
-		$(CC) $(CFLAGS) -Dstatic= -c -o $@ $(FONTC)
+$(obj)/piggy:    vmlinux;	$(call if_changed,objcopy)
+$(obj)/piggy.gz: $(obj)/piggy;	$(call if_changed,gzip)
 
-vmlinux.lds:	vmlinux.lds.in Makefile $(TOPDIR)/arch/$(ARCH)/boot/Makefile $(TOPDIR)/.config
-		@sed "$(SEDFLAGS)" < vmlinux.lds.in > $@
+LDFLAGS_piggy.o := -r -b binary
+$(obj)/piggy.o:  $(obj)piggy.gz
+	$(call if_changed,ld)
 
-clean:;		rm -f vmlinux core piggy* vmlinux.lds
+CFLAGS_font.o := -Dstatic=
+$(obj)/font.o: $(FONTC)
+
+$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in Makefile arch/arm/boot/Makefile.config	@sed "$(SEDFLAGS)" < $< > $@
 
 .PHONY:	clean
+clean:
+	rm -f $(addprefix $(obj)/,vmlinux core piggy* vmlinux.lds)
 
-misc.o: misc.c $(TOPDIR)/include/asm/arch/uncompress.h $(TOPDIR)/lib/inflate.c
+$(obj)/misc.o: $(obj)/misc.c include/asm/arch/uncompress.h lib/inflate.c
 
-%.o: %.S
-	$(CC) $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$@) -c -o $@ $<
===== arch/arm/kernel/Makefile 1.10 vs edited =====
--- 1.10/arch/arm/kernel/Makefile	Mon Sep 23 01:33:05 2002
+++ edited/arch/arm/kernel/Makefile	Sat Oct 12 21:34:11 2002
@@ -43,6 +43,7 @@
 include $(TOPDIR)/Rules.make
 
 # Spell out some dependencies that `make dep' doesn't spot
-entry-armv.o: entry-header.S $(TOPDIR)/include/asm-arm/constants.h
-entry-armo.o: entry-header.S $(TOPDIR)/include/asm-arm/constants.h
-entry-common.o: entry-header.S calls.S $(TOPDIR)/include/asm-arm/constants.h
+$(obj)/entry-armv.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
+$(obj)/entry-armo.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
+$(obj)/entry-common.o: 	$(obj)/entry-header.S include/asm-arm/constants.h \
+			$(obj)/calls.S
===== arch/arm/lib/Makefile 1.11 vs edited =====
--- 1.11/arch/arm/lib/Makefile	Sun Sep 29 18:42:10 2002
+++ edited/arch/arm/lib/Makefile	Sat Oct 12 21:35:01 2002
@@ -43,6 +43,6 @@
 
 include $(TOPDIR)/Rules.make
 
-csumpartialcopy.o: csumpartialcopygeneric.S
-csumpartialcopyuser.o: csumpartialcopygeneric.S
+$(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
+$(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
===== arch/arm/mm/Makefile 1.12 vs edited =====
--- 1.12/arch/arm/mm/Makefile	Mon Sep 23 01:33:05 2002
+++ edited/arch/arm/mm/Makefile	Sat Oct 12 21:38:54 2002
@@ -42,4 +42,4 @@
 include $(TOPDIR)/Rules.make
 
 # Special dependencies
-$(p-y):	$(TOPDIR)/include/asm-arm/constants.h
+$(obj)/$(p-y):	include/asm-arm/constants.h
===== arch/arm/tools/Makefile 1.6 vs edited =====
--- 1.6/arch/arm/tools/Makefile	Sun Jun 16 02:49:51 2002
+++ edited/arch/arm/tools/Makefile	Sat Oct 12 23:18:26 2002
@@ -4,9 +4,8 @@
 # Copyright (C) 2001 Russell King
 #
 
-all:	$(TOPDIR)/include/asm-arm/mach-types.h
+include $(TOPDIR)/Rules.make
 
-$(TOPDIR)/include/asm-arm/mach-types.h: mach-types gen-mach-types
-	awk -f gen-mach-types mach-types > $@
+include/asm-arm/mach-types.h: $(obj)/mach-types $(obj)/gen-mach-types
+	awk -f $(obj)/gen-mach-types $(obj)/mach-types > $@
 
-.PHONY:	all
