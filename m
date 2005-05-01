Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVEAVYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVEAVYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVEAVVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:21:15 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:25363 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262687AbVEAVSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:30 -0400
Message-Id: <200505012112.j41LCXFp016429@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH 9/22] UML - Finish cross-build support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

	O=... builds support.  Very easy, actually.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -urN RC12-rc3-uml-lib/arch/um/Makefile RC12-rc3-uml-O/arch/um/Makefile
--- RC12-rc3-uml-lib/arch/um/Makefile	Wed Apr 27 18:12:38 2005
+++ RC12-rc3-uml-O/arch/um/Makefile	Wed Apr 27 18:11:45 2005
@@ -44,6 +44,11 @@
 endif
 
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
+ifneq ($(KBUILD_SRC),)
+ARCH_INCLUDE	+= -I$(ARCH_DIR)/include2
+ARCH_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include
+MRPROPER_DIRS	+= $(ARCH_DIR)/include2
+endif
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
 include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
@@ -94,7 +99,12 @@
   echo '		   find in the kernel root.'
 endef
 
+ifneq ($(KBUILD_SRC),)
+$(shell mkdir -p $(ARCH_DIR) && ln -fsn $(srctree)/$(ARCH_DIR)/Kconfig_$(SUBARCH) $(ARCH_DIR)/Kconfig_arch)
+CLEAN_FILES += $(ARCH_DIR)/Kconfig_arch
+else
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig_$(SUBARCH) Kconfig_arch)
+endif
 
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
 
@@ -143,20 +153,40 @@
 
 $(SYMLINK_HEADERS):
 	@echo '  SYMLINK $@'
+ifneq ($(KBUILD_SRC),)
+	ln -fsn $(srctree)/include/asm-um/$(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $@
+else
 	$(Q)cd $(TOPDIR)/$(dir $@) ; \
 	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)
+endif
 
 include/asm-um/arch:
 	@echo '  SYMLINK $@'
+ifneq ($(KBUILD_SRC),)
+	$(Q)mkdir -p include/asm-um
+	$(Q)ln -fsn $(srctree)/include/asm-$(SUBARCH) include/asm-um/arch
+else
 	$(Q)cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
+endif
 
 $(ARCH_DIR)/include/sysdep:
 	@echo '  SYMLINK $@'
+ifneq ($(KBUILD_SRC),)
+	$(Q)mkdir -p $(ARCH_DIR)/include
+	$(Q)mkdir -p $(ARCH_DIR)/include2
+	$(Q)ln -fsn sysdep-$(SUBARCH) $(ARCH_DIR)/include/sysdep
+	$(Q)ln -fsn $(srctree)/$(ARCH_DIR)/include/sysdep-$(SUBARCH) $(ARCH_DIR)/include2/sysdep
+else
 	$(Q)cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
+endif
 
 $(ARCH_DIR)/os:
 	@echo '  SYMLINK $@'
+ifneq ($(KBUILD_SRC),)
+	$(Q)ln -fsn $(srctree)/$(ARCH_DIR)/os-$(OS) $(ARCH_DIR)/os
+else
 	$(Q)cd $(ARCH_DIR) && ln -sf os-$(OS) os
+endif
 
 # Generated files
 define filechk_umlconfig

