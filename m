Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbVIAWYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbVIAWYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbVIAWYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:24:33 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:30480 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030465AbVIAWYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:24:32 -0400
Message-Id: <200509012217.j81MH23j011535@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 4/12] UML - build cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:17:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

Added missing include list to uml AFLAGS
Killed magic for stubs. [So] - it was needed only because of messed AFLAGS
Switched segv_stubs.c to kernel CFLAGS sans profile, instead of user ones
Killed STUBS_CFLAGS - it's not needed and the only remaining use had been
gratitious - it only polluted CFLAGS

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>


Index: test/arch/um/Makefile-i386
===================================================================
--- test.orig/arch/um/Makefile-i386	2005-09-01 16:03:16.000000000 -0400
+++ test/arch/um/Makefile-i386	2005-09-01 16:04:30.000000000 -0400
@@ -27,8 +27,7 @@
 endif
 endif
 
-CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) $(STUB_CFLAGS) \
-	  -Iinclude/asm-i386/mach-default \
+CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) -Iinclude/asm-i386/mach-default \
           $(if $(KBUILD_SRC),-Iinclude2/asm-i386/mach-default -I$(srctree)/include/asm-i386/mach-default)
 
 ifneq ($(CONFIG_GPROF),y)
Index: test/arch/um/Makefile-x86_64
===================================================================
--- test.orig/arch/um/Makefile-x86_64	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/Makefile-x86_64	2005-09-01 16:04:30.000000000 -0400
@@ -6,7 +6,7 @@
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ -fno-builtin $(STUB_CFLAGS)
+CFLAGS += -U__$(SUBARCH)__ -fno-builtin
 USER_CFLAGS += -fno-builtin
 
 ELF_ARCH := i386:x86-64
Index: test/arch/um/sys-i386/Makefile
===================================================================
--- test.orig/arch/um/sys-i386/Makefile	2005-09-01 16:03:16.000000000 -0400
+++ test/arch/um/sys-i386/Makefile	2005-09-01 16:04:30.000000000 -0400
@@ -16,11 +16,7 @@
 highmem.c-dir = mm
 module.c-dir = kernel
 
-STUB_CFLAGS = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
-
-# _cflags works with kernel files, not with userspace ones, but c_flags does,
-# why ask why?
-$(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
+$(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
 
 subdir- := util
 
Index: test/arch/um/sys-i386/stub_segv.c
===================================================================
--- test.orig/arch/um/sys-i386/stub_segv.c	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/sys-i386/stub_segv.c	2005-09-01 16:04:30.000000000 -0400
@@ -3,8 +3,7 @@
  * Licensed under the GPL
  */
 
-#include <signal.h>
-#include <asm/sigcontext.h>
+#include <asm/signal.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
Index: test/arch/um/sys-x86_64/Makefile
===================================================================
--- test.orig/arch/um/sys-x86_64/Makefile	2005-09-01 16:04:05.000000000 -0400
+++ test/arch/um/sys-x86_64/Makefile	2005-09-01 16:04:30.000000000 -0400
@@ -27,11 +27,7 @@
 thunk.S-dir = lib
 module.c-dir = kernel
 
-STUB_CFLAGS = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
-
-# _cflags works with kernel files, not with userspace ones, but c_flags does,
-# why ask why?
-$(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
+$(obj)/stub_segv.o: _c_flags = $(call unprofile,$(CFLAGS))
 
 subdir- := util
 
Index: test/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- test.orig/arch/um/sys-x86_64/stub_segv.c	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/sys-x86_64/stub_segv.c	2005-09-01 16:04:30.000000000 -0400
@@ -3,9 +3,10 @@
  * Licensed under the GPL
  */
 
-#include <signal.h>
+#include <asm/signal.h>
 #include <linux/compiler.h>
 #include <asm/unistd.h>
+#include <asm/ucontext.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"

