Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUKXXgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUKXXgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUKXXee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:34:34 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:26116
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262940AbUKXXUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:20:30 -0500
Message-Id: <200411242305.iAON5qbn005388@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] UML - Build cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Nov 2004 18:05:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uml-specific patch (which requires a mainline hook, mailed separately).

This patch avoid the linking kludge which leaves kbuild link vmlinux and
then link it with libc inside linux. This kludge has the big problem of
making kallsyms break, since the kallsyms pass is done on a completely
different binary than the running one.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>
Index: 2.6.9/arch/um/Makefile
===================================================================
--- 2.6.9.orig/arch/um/Makefile	2004-11-24 15:27:12.000000000 -0500
+++ 2.6.9/arch/um/Makefile	2004-11-24 15:30:26.000000000 -0500
@@ -65,11 +65,6 @@
 
 .PHONY: linux
 
-all: linux
-
-linux: vmlinux
-	ln -f $< $@
-
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for backward'
   echo '		   compatibility only, this creates a hard link to the'
@@ -77,6 +72,14 @@
   echo '		   find in the kernel root.'
 endef
 
+all : linux
+
+linux : vmlinux
+	$(RM) $@
+	ln $< $@
+
+include/linux/version.h: arch/$(ARCH)/Makefile
+
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
 	$(ARCH_DIR)/kernel/vmlinux.lds.S
 
@@ -150,8 +153,8 @@
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
-#We need to re-preprocess this when the symlink dest changes.
-#So we touch it.
+# We need to re-preprocess this when the symlink dest changes.
+# So we touch it.
 $(ARCH_DIR)/kernel/vmlinux.lds.S: FORCE
 	@echo '  SYMLINK $@'
 	$(Q)ln -sf $(LD_SCRIPT-y) $@

