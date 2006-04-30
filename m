Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWD3OR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWD3OR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 10:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWD3OR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 10:17:58 -0400
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]:21656
	"EHLO zion.home.lan") by vger.kernel.org with ESMTP
	id S1751128AbWD3OR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 10:17:57 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/7] uml: use Kbuild tracking for all files and fix compilation output
Date: Sun, 30 Apr 2006 16:16:17 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060430141616.9060.36486.stgit@zion.home.lan>
In-Reply-To: <20060430141512.9060.39338.stgit@zion.home.lan>
References: <20060430141512.9060.39338.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Move the build of user-offsets to arch/um/sys-$(SUBARCH), where it's located. So
we can also build it via Kbuild with its dependency tracking rather than by hand.
While hacking here, fix also a lot of little cosmetic things.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile            |   13 ++++++-------
 arch/um/sys-i386/Makefile   |    5 ++++-
 arch/um/sys-x86_64/Makefile |    5 ++++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index a508e7a..930e006 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -96,7 +96,8 @@ PHONY += linux
 all: linux
 
 linux: vmlinux
-	ln -f $< $@
+	@echo '  SYMLINK $@'
+	$(Q)ln -f $< $@
 
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for backward'
@@ -203,8 +204,8 @@ endef
 $(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
 	$(call filechk,umlconfig)
 
-$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
-	$(CC) $(USER_CFLAGS) -S -o $@ $<
+$(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.s: FORCE
+	$(Q)$(MAKE) $(build)=$(ARCH_DIR)/sys-$(SUBARCH) $@
 
 define filechk_gen-asm-offsets
         (set -e; \
@@ -219,13 +220,11 @@ define filechk_gen-asm-offsets
          echo ""; )
 endef
 
-$(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/user-offsets.s
+$(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-CLEAN_FILES += $(ARCH_DIR)/user-offsets.s
-
 $(ARCH_DIR)/include/kern_constants.h: $(objtree)/$(ARCH_DIR)/include
 	@echo '  SYMLINK $@'
-	$(Q) ln -sf ../../../include/asm-um/asm-offsets.h $@
+	$(Q)ln -sf ../../../include/asm-um/asm-offsets.h $@
 
 export SUBARCH USER_CFLAGS OS
diff --git a/arch/um/sys-i386/Makefile b/arch/um/sys-i386/Makefile
index 98b20b7..82121ab 100644
--- a/arch/um/sys-i386/Makefile
+++ b/arch/um/sys-i386/Makefile
@@ -10,9 +10,12 @@ subarch-obj-$(CONFIG_MODULES) += kernel/
 
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o stub_segv.o
 
-include arch/um/scripts/Makefile.rules
+USER_OBJS += user-offsets.s
+extra-y += user-offsets.s
 
 extra-$(CONFIG_MODE_TT) += unmap.o
 
+include arch/um/scripts/Makefile.rules
+
 $(obj)/stub_segv.o $(obj)/unmap.o: \
 	_c_flags = $(call unprofile,$(CFLAGS))
diff --git a/arch/um/sys-x86_64/Makefile b/arch/um/sys-x86_64/Makefile
index b5fc22b..f739bea 100644
--- a/arch/um/sys-x86_64/Makefile
+++ b/arch/um/sys-x86_64/Makefile
@@ -18,9 +18,12 @@ ldt-y = ../sys-i386/ldt.o
 
 USER_OBJS := ptrace_user.o sigcontext.o stub_segv.o
 
-include arch/um/scripts/Makefile.rules
+USER_OBJS += user-offsets.s
+extra-y += user-offsets.s
 
 extra-$(CONFIG_MODE_TT) += unmap.o
 
+include arch/um/scripts/Makefile.rules
+
 $(obj)/stub_segv.o $(obj)/unmap.o: \
 	_c_flags = $(call unprofile,$(CFLAGS))
