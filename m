Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWDIP3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWDIP3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWDIP3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:29:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33706 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750786AbWDIP3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:29:16 -0400
Date: Sun, 9 Apr 2006 17:29:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 11/19] kconfig: move .kernelrelease
Message-ID: <Pine.LNX.4.64.0604091728560.23148@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This moves the .kernelrelease file into include/config directory.
Remove its generation from the config step, if the config step doesn't
leave a proper .config behind, it triggers a call to silentoldconfig.
Instead its generation can be done via proper dependencies.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 Makefile |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Index: linux-2.6-git/Makefile
===================================================================
--- linux-2.6-git.orig/Makefile
+++ linux-2.6-git/Makefile
@@ -309,8 +309,8 @@ CFLAGS 		:= -Wall -Wundef -Wstrict-proto
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
-# Read KERNELRELEASE from .kernelrelease (if it exists)
-KERNELRELEASE = $(shell cat .kernelrelease 2> /dev/null)
+# Read KERNELRELEASE from include/config/kernel.release (if it exists)
+KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
 export	VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION \
@@ -408,7 +408,6 @@ export KBUILD_DEFCONFIG
 config %config: scripts_basic outputmakefile FORCE
 	$(Q)mkdir -p include/linux include/config
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-	$(Q)$(MAKE) -C $(srctree) KBUILD_SRC= .kernelrelease
 
 else
 # ===========================================================================
@@ -716,7 +715,7 @@ $(vmlinux-dirs): prepare scripts
 	$(Q)$(MAKE) $(build)=$@
 
 # Build the kernel release string
-# The KERNELRELEASE is stored in a file named .kernelrelease
+# The KERNELRELEASE is stored in a file named include/config/kernel.release
 # to be used when executing for example make install or make modules_install
 #
 # Take the contents of any files called localversion* and the config
@@ -750,9 +749,9 @@ endif
 
 localver-full = $(localver)$(localver-auto)
 
-# Store (new) KERNELRELASE string in .kernelrelease
+# Store (new) KERNELRELASE string in include/config/kernel.release
 kernelrelease = $(KERNELVERSION)$(localver-full)
-.kernelrelease: FORCE
+include/config/kernel.release: include/config/auto.conf FORCE
 	$(Q)rm -f $@
 	$(Q)echo $(kernelrelease) > $@
 
@@ -773,7 +772,7 @@ PHONY += prepare-all
 # and if so do:
 # 1) Check that make has not been executed in the kernel src $(srctree)
 # 2) Create the include2 directory, used for the second asm symlink
-prepare3: .kernelrelease
+prepare3: include/config/kernel.release
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
 	$(Q)if [ -f $(srctree)/.config -o -d $(srctree)/include/config ]; then \
@@ -836,7 +835,7 @@ define filechk_version.h
 	)
 endef
 
-include/linux/version.h: $(srctree)/Makefile .config .kernelrelease FORCE
+include/linux/version.h: $(srctree)/Makefile include/config/kernel.release FORCE
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------
@@ -932,7 +931,7 @@ CLEAN_FILES +=	vmlinux System.map \
 MRPROPER_DIRS  += include/config include2
 MRPROPER_FILES += .config .config.old include/asm .version .old_version \
                   include/linux/autoconf.h include/linux/version.h \
-		  .kernelrelease Module.symvers tags TAGS cscope*
+		  Module.symvers tags TAGS cscope*
 
 # clean - Delete most, but leave enough to build external modules
 #
@@ -1256,8 +1255,8 @@ checkstack:
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
 
 kernelrelease:
-	$(if $(wildcard .kernelrelease), $(Q)echo $(KERNELRELEASE), \
-	$(error kernelrelease not valid - run 'make *config' to update it))
+	$(if $(wildcard include/config/kernel.release), $(Q)echo $(KERNELRELEASE), \
+	$(error kernelrelease not valid - run 'make prepare' to update it))
 kernelversion:
 	@echo $(KERNELVERSION)
 
