Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265182AbSJPQts>; Wed, 16 Oct 2002 12:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265183AbSJPQsM>; Wed, 16 Oct 2002 12:48:12 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:51693 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265204AbSJPQpw> convert rfc822-to-8bit; Wed, 16 Oct 2002 12:45:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.43 s390 (1/6): Makefiles.
Date: Wed, 16 Oct 2002 18:46:35 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210161846.35354.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify Makefiles.

diff -urN linux-2.5.43/arch/s390/Makefile linux-2.5.43-s390/arch/s390/Makefile
--- linux-2.5.43/arch/s390/Makefile	Wed Oct 16 05:27:19 2002
+++ linux-2.5.43-s390/arch/s390/Makefile	Wed Oct 16 17:53:48 2002
@@ -28,18 +28,14 @@
 
 all: image listing
 
-listing: vmlinux
-	@$(MAKEBOOT) listing
+makeboot = $(call descend,arch/$(ARCH)/boot,$(1))
+BOOTIMAGE= arch/$(ARCH)/boot/image
 
-MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
-
-image: vmlinux 
-	@$(MAKEBOOT) image
-
-install: vmlinux
-	@$(MAKEBOOT) BOOTIMAGE=image install
+listing install image: vmlinux
+	+@$(call makeboot,BOOTIMAGE=$(BOOTIMAGE) $@)
 
 archclean:
+	+@$(call makeboot,clean)
 
 archmrproper:
 
diff -urN linux-2.5.43/arch/s390/boot/Makefile linux-2.5.43-s390/arch/s390/boot/Makefile
--- linux-2.5.43/arch/s390/boot/Makefile	Wed Oct 16 05:29:07 2002
+++ linux-2.5.43-s390/arch/s390/boot/Makefile	Wed Oct 16 17:53:48 2002
@@ -1,28 +1,27 @@
 #
-# arch/s390/boot/Makefile
+# Makefile for the linux s390-specific parts of the memory manager.
 #
 
 EXTRA_AFLAGS := -traditional
 
 include $(TOPDIR)/Rules.make
 
-%.lnk: %.o
-	$(LD) $(LDFLAGS) -Ttext 0x0 -o $@ $<
+quiet_cmd_listing = OBJDUMP $(echo_target)
+cmd_listing	  = $(OBJDUMP) --disassemble --disassemble-all \
+			--disassemble-zeroes --reloc vmlinux > $@
 
-%.boot: %.lnk
-	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@
+$(obj)/image: vmlinux
+	$(call if_changed,objcopy)
 
-image: $(TOPDIR)/vmlinux \
-	iplfba.boot ipleckd.boot ipldump.boot
-	$(OBJCOPY) $(OBJCOPYFLAGS) $(TOPDIR)/vmlinux image
-	$(NM) $(TOPDIR)/vmlinux | grep -v '\(compiled\)\|\( [aUw] \)\|\(\.\)\|\(LASH[RL]DI\)' | sort > $(TOPDIR)/System.map
+$(obj)/listing: vmlinux
+	$(call if_changed,listing)
 
-listing: ../../../vmlinux
-	$(OBJDUMP) --disassemble --disassemble-all --disassemble-zeroes --reloc $(TOPDIR)/vmlinux > listing
+image: $(obj)/image
+
+listing: $(obj)/listing
 
 clean:
-	rm -f image listing iplfba.boot ipleckd.boot ipldump.boot
+	rm -f $(obj)/image $(obj)/listing
 
 install: $(CONFIGURE) $(BOOTIMAGE)
-	sh -x ./install.sh $(KERNELRELEASE) $(BOOTIMAGE) $(TOPDIR)/System.map $(TOPDIR)/Kerntypes "$(INSTALL_PATH)"
-
+	sh -x $(obj)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map Kerntypes "$(INSTALL_PATH)"
diff -urN linux-2.5.43/arch/s390x/Makefile linux-2.5.43-s390/arch/s390x/Makefile
--- linux-2.5.43/arch/s390x/Makefile	Wed Oct 16 05:28:22 2002
+++ linux-2.5.43-s390/arch/s390x/Makefile	Wed Oct 16 17:53:48 2002
@@ -28,18 +28,14 @@
 
 all: image listing
 
-listing: vmlinux
-	@$(MAKEBOOT) listing
+makeboot = $(call descend,arch/$(ARCH)/boot,$(1))
+BOOTIMAGE= arch/$(ARCH)/boot/image
 
-MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
-
-image: vmlinux 
-	@$(MAKEBOOT) image
-
-install: vmlinux
-	@$(MAKEBOOT) BOOTIMAGE=image install
+listing install image: vmlinux
+	+@$(call makeboot,BOOTIMAGE=$(BOOTIMAGE) $@)
 
 archclean:
+	+@$(call makeboot,clean)
 
 archmrproper:
 
diff -urN linux-2.5.43/arch/s390x/boot/Makefile linux-2.5.43-s390/arch/s390x/boot/Makefile
--- linux-2.5.43/arch/s390x/boot/Makefile	Wed Oct 16 05:28:22 2002
+++ linux-2.5.43-s390/arch/s390x/boot/Makefile	Wed Oct 16 17:53:48 2002
@@ -6,22 +6,22 @@
 
 include $(TOPDIR)/Rules.make
 
-%.lnk: %.o
-	$(LD) -Ttext 0x0 -o $@ $<
+quiet_cmd_listing = OBJDUMP $(echo_target)
+cmd_listing	  = $(OBJDUMP) --disassemble --disassemble-all \
+			--disassemble-zeroes --reloc vmlinux > $@
 
-%.boot: %.lnk
-	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@
+$(obj)/image: vmlinux
+	$(call if_changed,objcopy)
 
-image: $(TOPDIR)/vmlinux \
-	iplfba.boot ipleckd.boot ipldump.boot
-	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@
-	$(NM) $(TOPDIR)/vmlinux | grep -v '\(compiled\)\|\( [aUw] \)\|\(\.\)\|\(LASH[RL]DI\)' | sort > $(TOPDIR)/System.map
+$(obj)/listing: vmlinux
+	$(call if_changed,listing)
 
-listing: ../../../vmlinux
-	$(OBJDUMP) --disassemble --disassemble-all --disassemble-zeroes --reloc $(TOPDIR)/vmlinux > listing
+image: $(obj)/image
+
+listing: $(obj)/listing
 
 clean:
-	rm -f image listing iplfba.boot ipleckd.boot ipldump.boot
+	rm -f $(obj)/image $(obj)/listing
 
 install: $(CONFIGURE) $(BOOTIMAGE)
-	sh -x ./install.sh $(KERNELRELEASE) $(BOOTIMAGE) $(TOPDIR)/System.map $(TOPDIR)/Kerntypes "$(INSTALL_PATH)"
+	sh -x $(obj)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map Kerntypes "$(INSTALL_PATH)"

