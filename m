Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSLGWZz>; Sat, 7 Dec 2002 17:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSLGWZz>; Sat, 7 Dec 2002 17:25:55 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8202 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264836AbSLGWZw>;
	Sat, 7 Dec 2002 17:25:52 -0500
Date: Sat, 7 Dec 2002 23:30:07 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, com.ibm@arndb.de, idrys@gmx.de
Subject: Re: s390 update.
Message-ID: <20021207223007.GA4404@mars.ravnborg.org>
Mail-Followup-To: Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	com.ibm@arndb.de, idrys@gmx.de
References: <200212061944.22688.schwidefsky@de.ibm.com> <200212062227.28464.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212062227.28464.arnd@bergmann-dalldorf.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On fre, dec 06, 2002 at 10:28:12 +0100, Arnd Bergmann wrote:
> I have put all the patches on bkbits. Just pull from
Did that and took a look at the Makefiles.
Here is an update for s390.

They are untested, I did not have any 390 system handy :-)
In arch/s390/boot/Makefile I have added "FORCE" as prerequisite for
listing and image target. Thats the only real bug fixed.
The rest is just cleaning up.

A similar update is required for s390x, but I assume the s390 team will
do that.

Summary of changes:
o Added FORCE prerequisite in boot/Makefile
o Do not use shorthand targets when calling the boot/Makefile
o No longer use BOOT_IMAGE, not needed now
o Use kbuild clean infrastructure when cleaning up in boot
o Offset generation shrinked with one rule
o removed inclusion of Rules.make in all Makefiles
o no longer use the descend macro, use $(Q)$(MAKE) as replacement

Feedback welcome,
	Sam


 Makefile          |   21 +++++++++++----------
 boot/Makefile     |   25 ++++++++++---------------
 kernel/Makefile   |    2 --
 lib/Makefile      |    3 ---
 math-emu/Makefile |    8 ++------
 mm/Makefile       |    2 --
 6 files changed, 23 insertions(+), 38 deletions(-)


===== arch/s390/Makefile 1.19 vs edited =====
--- 1.19/arch/s390/Makefile	Mon Nov 18 21:11:00 2002
+++ edited/arch/s390/Makefile	Sat Dec  7 23:16:49 2002
@@ -27,29 +27,30 @@
 drivers-$(CONFIG_MATHEMU)	+= arch/s390/math-emu/
 libs-y				+= arch/s390/lib/
 
+
+makeboot =$(Q)$(MAKE) -f script/Makefile.build obj=arch/$(ARCH)/boot $(1)
+
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
===== arch/s390/boot/Makefile 1.12 vs edited =====
--- 1.12/arch/s390/boot/Makefile	Mon Nov 18 21:11:00 2002
+++ edited/arch/s390/boot/Makefile	Sat Dec  7 23:16:52 2002
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
===== arch/s390/kernel/Makefile 1.13 vs edited =====
--- 1.13/arch/s390/kernel/Makefile	Mon Nov 18 21:11:24 2002
+++ edited/arch/s390/kernel/Makefile	Sat Dec  7 23:17:42 2002
@@ -17,5 +17,3 @@
 # Kernel debugging
 #
 obj-$(CONFIG_REMOTE_DEBUG)	+= gdb-stub.o #gdb-low.o 
-
-include $(TOPDIR)/Rules.make
===== arch/s390/lib/Makefile 1.6 vs edited =====
--- 1.6/arch/s390/lib/Makefile	Fri Oct  4 18:15:49 2002
+++ edited/arch/s390/lib/Makefile	Sat Dec  7 23:19:26 2002
@@ -7,6 +7,3 @@
 EXTRA_AFLAGS := -traditional
 
 obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
-
-include $(TOPDIR)/Rules.make
-
===== arch/s390/math-emu/Makefile 1.3 vs edited =====
--- 1.3/arch/s390/math-emu/Makefile	Mon Sep 23 01:37:56 2002
+++ edited/arch/s390/math-emu/Makefile	Sat Dec  7 23:19:09 2002
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
===== arch/s390/mm/Makefile 1.4 vs edited =====
--- 1.4/arch/s390/mm/Makefile	Mon Sep 23 01:37:56 2002
+++ edited/arch/s390/mm/Makefile	Sat Dec  7 23:17:13 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y	 := init.o fault.o ioremap.o extable.o
-
-include $(TOPDIR)/Rules.make
