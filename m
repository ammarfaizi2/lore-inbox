Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269251AbTCBUG0>; Sun, 2 Mar 2003 15:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269253AbTCBUG0>; Sun, 2 Mar 2003 15:06:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:37129 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S269251AbTCBUGY>;
	Sun, 2 Mar 2003 15:06:24 -0500
Date: Sun, 2 Mar 2003 21:16:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix make -j4 on UP
Message-ID: <20030302201648.GA14770@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When executing make -j4 on my UP machine kbuild failed.
The culprint was that compile.h were generated twice:
1) Due to the newly added dependency when building modules
2) When descending down into the directories

The generation of compile.h were placed in init/, presumeably
for historical reasons.
The following patch moves the generation of compile.h to the
top-level makefile, and list it in the prepare rule.
Hereby the generation of compile.h is done before descending down
in the the directories.

	Sam

===== Makefile 1.389 vs edited =====
--- 1.389/Makefile	Sun Mar  2 21:01:58 2003
+++ edited/Makefile	Sun Mar  2 21:11:31 2003
@@ -400,7 +400,7 @@
 #	module versions are listed in "prepare"
 
 .PHONY: prepare
-prepare: include/linux/version.h include/asm include/config/MARKER
+prepare: include/linux/version.h include/linux/compile.h include/asm include/config/MARKER
 ifdef KBUILD_MODULES
 ifeq ($(origin SUBDIRS),file)
 	$(Q)rm -rf $(MODVERDIR)
@@ -484,6 +484,14 @@
 	) > $@.tmp
 	@$(update-if-changed)
 
+# compile.h changes depending on hostname, generation number, etc,
+# so we regenerate it always.
+# mkcompile_h will make sure to only update the
+# actual file if its content has changed.
+include/linux/compile.h: FORCE
+	@echo -n '  GEN     $@'
+	@sh $(srctree)/scripts/mkcompile_h $@ "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"
+
 # ---------------------------------------------------------------------------
 
 .PHONY: depend dep
@@ -501,11 +509,8 @@
 
 #	Build modules
 
-include/linux/compile.h: FORCE
-	$(Q)$(MAKE) $(build)=init include/linux/compile.h
-
 .PHONY: modules
-modules: $(SUBDIRS) $(if $(KBUILD_BUILTIN),vmlinux) include/linux/compile.h
+modules: $(SUBDIRS) $(if $(KBUILD_BUILTIN),vmlinux)
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f scripts/Makefile.modpost
 
@@ -644,7 +649,7 @@
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Files removed with 'make clean'
-CLEAN_FILES += vmlinux System.map MC*
+CLEAN_FILES += vmlinux System.map include/linux/compile.h
 
 # Files removed with 'make mrproper'
 MRPROPER_FILES += \
===== init/Makefile 1.23 vs edited =====
--- 1.23/init/Makefile	Sat Mar  1 23:47:42 2003
+++ edited/init/Makefile	Sun Mar  2 21:10:35 2003
@@ -6,19 +6,3 @@
 obj-$(CONFIG_DEVFS_FS)		+= do_mounts_devfs.o
 obj-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
 obj-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o
-
-# files to be removed upon make clean
-clean-files := ../include/linux/compile.h
-
-# dependencies on generated files need to be listed explicitly
-
-$(obj)/version.o: include/linux/compile.h
-
-# compile.h changes depending on hostname, generation number, etc,
-# so we regenerate it always.
-# mkcompile_h will make sure to only update the
-# actual file if its content has changed.
-
-include/linux/compile.h: FORCE
-	@echo -n '  GEN     $@'
-	@sh $(srctree)/scripts/mkcompile_h $@ "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"
