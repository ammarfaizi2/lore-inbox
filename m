Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWC1XAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWC1XAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWC1W7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:13 -0500
Received: from [198.99.130.12] ([198.99.130.12]:20419 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964783AbWC1W7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:02 -0500
Message-Id: <200603282300.k2SN08LA022977@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       viro@zeniv.linux.org.uk
Subject: [PATCH 4/10] UML - Clean up remapping code build magic
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:08 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
uml: kills unmap magic
 
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/Makefile               |    2 +-
 arch/um/scripts/Makefile.unmap |   22 ----------------------
 arch/um/sys-i386/Makefile      |    5 +++--
 arch/um/sys-x86_64/Makefile    |    5 +++--
 4 files changed, 7 insertions(+), 27 deletions(-)
 delete mode 100644 arch/um/scripts/Makefile.unmap

Index: linux-2.6.16-mm/arch/um/Makefile
===================================================================
--- linux-2.6.16-mm.orig/arch/um/Makefile	2006-03-28 09:30:36.000000000 -0500
+++ linux-2.6.16-mm/arch/um/Makefile	2006-03-28 09:34:20.000000000 -0500
@@ -129,7 +129,7 @@ CPPFLAGS_vmlinux.lds = -U$(SUBARCH) \
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT="$(ELF_FORMAT)" $(CPP_MODE-y) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE) \
-	-DUNMAP_PATH=arch/um/sys-$(SUBARCH)/unmap_fin.o
+	-DUNMAP_PATH=arch/um/sys-$(SUBARCH)/unmap.o
 
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
Index: linux-2.6.16-mm/arch/um/scripts/Makefile.unmap
===================================================================
--- linux-2.6.16-mm.orig/arch/um/scripts/Makefile.unmap	2005-10-28 12:58:12.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,22 +0,0 @@
-clean-files += unmap_tmp.o unmap_fin.o unmap.o
-
-ifdef CONFIG_MODE_TT
-
-#Always build unmap_fin.o
-extra-y += unmap_fin.o
-#Do dependency tracking for unmap.o (it will be always built, but won't get the tracking unless we use this).
-targets += unmap.o
-
-#XXX: partially copied from arch/um/scripts/Makefile.rules
-$(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))
-
-quiet_cmd_wrapld = LD      $@
-define cmd_wrapld
-	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< ; \
-	$(OBJCOPY) $(UML_OBJCOPYFLAGS) $(obj)/unmap_tmp.o $@ -G switcheroo
-endef
-
-$(obj)/unmap_fin.o : $(obj)/unmap.o FORCE
-	$(call if_changed,wrapld)
-
-endif
Index: linux-2.6.16-mm/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/Makefile	2006-03-28 09:34:18.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-i386/Makefile	2006-03-28 09:34:20.000000000 -0500
@@ -11,6 +11,7 @@ USER_OBJS := bugs.o ptrace_user.o sigcon
 
 include arch/um/scripts/Makefile.rules
 
-$(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
+extra-$(CONFIG_MODE_TT) += unmap.o
 
-include arch/um/scripts/Makefile.unmap
+$(obj)/stub_segv.o $(obj)/unmap.o: \
+	_c_flags = $(call unprofile,$(CFLAGS))
Index: linux-2.6.16-mm/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-x86_64/Makefile	2006-03-28 09:34:18.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-x86_64/Makefile	2006-03-28 09:34:20.000000000 -0500
@@ -19,6 +19,7 @@ USER_OBJS := ptrace_user.o sigcontext.o 
 
 include arch/um/scripts/Makefile.rules
 
-$(obj)/stub_segv.o: _c_flags = $(call unprofile,$(CFLAGS))
+extra-$(CONFIG_MODE_TT) += unmap.o
 
-include arch/um/scripts/Makefile.unmap
+$(obj)/stub_segv.o $(obj)/unmap.o: \
+	_c_flags = $(call unprofile,$(CFLAGS))

