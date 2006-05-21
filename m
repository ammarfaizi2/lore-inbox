Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWEVKZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWEVKZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEVKZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:25:16 -0400
Received: from thunk.org ([69.25.196.29]:6540 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750728AbWEVKYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:24:45 -0400
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] Add option for stripping modules while installing them
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1Fhx03-0001e5-N6@candygram.thunk.org>
Date: Sun, 21 May 2006 19:06:15 -0400
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This function adds support for stripping modules while they are being
installed.  CONFIG_DEBUG_KERNEL (which will probably become more
popular as developers use kdump) causes the size of the installed
modules to grow by a factor of 9 or so.  

Some kernel package systems solve this problem by stripping the debug
information from /lib/modules after running "make modules_install",
but that may not work for people who are installing directly into
/lib/modules --- root partitions that were sized to handle 16 megs
worth of modules may not be quite so happy with 145 megs of modules,
so the "make modules_install" never succeeds.

This patch allows such users to request modules_install to strip the
modules as they are installed.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6/Makefile
===================================================================
--- linux-2.6.orig/Makefile	2006-04-28 21:16:50.000000000 -0400
+++ linux-2.6/Makefile	2006-05-21 19:01:06.000000000 -0400
@@ -518,6 +518,23 @@
 MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 export MODLIB
 
+#
+#  INSTALL_MOD_STRIP, if defined, will cause modules to be
+#  stripped after they are installed.  If INSTALL_MOD_STRIP is '1', then
+#  the default option --strip-debug will be used.  Otherwise,
+#  INSTALL_MOD_STRIP will used as the options to the strip command.
+
+ifdef INSTALL_MOD_STRIP
+ifeq ($(INSTALL_MOD_STRIP),1)
+mod_strip_cmd = strip --strip-debug
+else
+mod_strip_cmd = strip $(INSTALL_MOD_STRIP)
+endif # INSTALL_MOD_STRIP=1
+else
+mod_strip_cmd = true
+endif # INSTALL_MOD_STRIP
+export mod_strip_cmd
+
 
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
Index: linux-2.6/scripts/Makefile.modinst
===================================================================
--- linux-2.6.orig/scripts/Makefile.modinst	2006-03-25 21:26:41.000000000 -0500
+++ linux-2.6/scripts/Makefile.modinst	2006-05-21 19:01:06.000000000 -0400
@@ -17,7 +17,7 @@
 	@:
 
 quiet_cmd_modules_install = INSTALL $@
-      cmd_modules_install = mkdir -p $(2); cp $@ $(2)
+      cmd_modules_install = mkdir -p $(2); cp $@ $(2) ; $(mod_strip_cmd) $(2)/$(notdir $@)
 
 # Modules built outside the kernel source tree go into extra by default
 INSTALL_MOD_DIR ?= extra
Index: linux-2.6/Documentation/kbuild/makefiles.txt
===================================================================
--- linux-2.6.orig/Documentation/kbuild/makefiles.txt	2006-03-25 21:26:07.000000000 -0500
+++ linux-2.6/Documentation/kbuild/makefiles.txt	2006-05-21 19:01:07.000000000 -0400
@@ -1123,6 +1123,14 @@
 	$(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE).  The user may
 	override this value on the command line if desired.
 
+    INSTALL_MOD_STRIP
+
+	If this variable is specified, will cause modules to be stripped
+	after they are installed.  If INSTALL_MOD_STRIP is '1', then the
+	default option --strip-debug will be used.  Otherwise,
+	INSTALL_MOD_STRIP will used as the option(s) to the strip command.
+
+
 === 8 Makefile language
 
 The kernel Makefiles are designed to run with GNU Make.  The Makefiles
