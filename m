Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVCVTqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVCVTqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCVTov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:44:51 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:13440 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261710AbVCVTna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:43:30 -0500
Subject: [patch 09/12] uml - kbuild: link cmd
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:39 +0100
Message-Id: <20050322162139.50D4197672@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the cmd_* syntax to define a command for symlink creations in UML (to
reuse files from other archs).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/scripts/Makefile.rules |    3 +++
 linux-2.6.11-paolo/arch/um/sys-i386/Makefile      |   13 +++++--------
 linux-2.6.11-paolo/arch/um/sys-x86_64/Makefile    |   16 ++++++++--------
 linux-2.6.11-paolo/include/asm-um/signal.h        |    2 ++
 4 files changed, 18 insertions(+), 16 deletions(-)

diff -puN arch/um/sys-x86_64/Makefile~uml-kbuild-link-cmd arch/um/sys-x86_64/Makefile
--- linux-2.6.11/arch/um/sys-x86_64/Makefile~uml-kbuild-link-cmd	2005-03-21 19:53:36.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-x86_64/Makefile	2005-03-21 19:53:36.000000000 +0100
@@ -14,10 +14,15 @@ include arch/um/scripts/Makefile.rules
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
 	semaphore.c thunk.S
-SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
 
+# this needs to be before the foreach, because clean-files does not accept
+# complete paths like $(src)/$f.
 clean-files := $(SYMLINKS)
 
+targets += $(SYMLINKS)
+
+SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$f)
+
 bitops.c-dir = lib
 csum-copy.S-dir = lib
 csum-partial.c-dir = lib
@@ -26,12 +31,7 @@ memcpy.S-dir = lib
 semaphore.c-dir = kernel
 thunk.S-dir = lib
 
-define make_link
-       -rm -f $1
-       ln -sf $(srctree)/arch/x86_64/$($(notdir $1)-dir)/$(notdir $1) $1
-endef
-
-$(SYMLINKS):
-	$(call make_link,$@)
+$(SYMLINKS): FORCE
+	$(call if_changed,make_link)
 
 CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial
diff -puN arch/um/sys-i386/Makefile~uml-kbuild-link-cmd arch/um/sys-i386/Makefile
--- linux-2.6.11/arch/um/sys-i386/Makefile~uml-kbuild-link-cmd	2005-03-21 19:53:36.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-i386/Makefile	2005-03-21 19:53:36.000000000 +0100
@@ -14,19 +14,16 @@ SYMLINKS = bitops.c semaphore.c highmem.
 # complete paths like $(src)/$f.
 clean-files := $(SYMLINKS)
 
-SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
+targets += $(SYMLINKS)
+
+SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$f)
 
 bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
 
-define make_link
-	-rm -f $1
-	ln -sf $(srctree)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
-endef
-
-$(SYMLINKS): 
-	$(call make_link,$@)
+$(SYMLINKS): FORCE
+	$(call if_changed,make_link)
 
 subdir- := util
diff -puN arch/um/scripts/Makefile.rules~uml-kbuild-link-cmd arch/um/scripts/Makefile.rules
--- linux-2.6.11/arch/um/scripts/Makefile.rules~uml-kbuild-link-cmd	2005-03-21 19:53:36.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/scripts/Makefile.rules	2005-03-21 19:53:36.000000000 +0100
@@ -8,3 +8,6 @@ USER_OBJS += $(filter %_user.o,$(obj-y) 
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS): c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(notdir $@))
+
+quiet_cmd_make_link = SYMLINK $@
+cmd_make_link       = rm -f $@; ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
_
