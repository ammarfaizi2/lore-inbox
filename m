Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWAHUiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWAHUiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 15:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWAHUiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:38:09 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1797 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161196AbWAHUiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:38:08 -0500
Date: Sun, 8 Jan 2006 21:37:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] kernelrelase only recomputed when necessary
Message-ID: <20060108203749.GA7193@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch goes on top of patch from hpa titled:
Drop vmlinux dependency from "make install"

What is does is to avoid calling setlocalversion except when we
build the kernel.
Rationale behind this is "do as little as possible" when executing
make install - as root!

A new file named .kernelrelease is strored in the root of the kernel
tree containing the actual version string.
So when we use the normal build targets we will update the file, and for
all other targets we will just read the stored file.

When building the kernel is now prints out:
Building kernel 2.6.15-g63b794bf-dirty
...
...

The patch also un-exports VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION
since all users of these are anyway broken - and none is left in the
tree. (the one in frv is dealt with in my tree already).

I will wait a day or so before pushing this out to see if there is any
comments until then.

	Sam


diff --git a/Makefile b/Makefile
index 50b07fa..2118ff7 100644
--- a/Makefile
+++ b/Makefile
@@ -141,24 +141,6 @@ VPATH		:= $(srctree)
 
 export srctree objtree VPATH TOPDIR
 
-nullstring :=
-space      := $(nullstring) # end of line
-
-# Take the contents of any files called localversion* and the config
-# variable CONFIG_LOCALVERSION and append them to KERNELRELEASE. Be
-# careful not to include files twice if building in the source
-# directory. LOCALVERSION from the command line override all of this
-
-localver := $(objtree)/localversion* $(srctree)/localversion*
-localver := $(sort $(wildcard $(localver)))
-# skip backup files (containing '~')
-localver := $(foreach f, $(localver), $(if $(findstring ~, $(f)),,$(f)))
-
-LOCALVERSION = $(subst $(space),, \
-	       $(shell cat /dev/null $(localver)) \
-	       $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
-
-KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
@@ -353,7 +335,10 @@ CFLAGS 		:= -Wall -Wundef -Wstrict-proto
 		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
 
-export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE \
+# read KERNELRELEASE from .kernelrelease (if it exists)
+KERNELRELEASE = $(shell cat .kernelrelease /dev/null 2> /dev/null)
+
+export	KERNELRELEASE \
 	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
@@ -551,26 +536,6 @@ export KBUILD_IMAGE ?= vmlinux
 # images. Default is /boot, but you can set it to other values
 export	INSTALL_PATH ?= /boot
 
-# If CONFIG_LOCALVERSION_AUTO is set, we automatically perform some tests
-# and try to determine if the current source tree is a release tree, of any sort,
-# or if is a pure development tree.
-#
-# A 'release tree' is any tree with a git TAG associated
-# with it.  The primary goal of this is to make it safe for a native
-# git/CVS/SVN user to build a release tree (i.e, 2.6.9) and also to
-# continue developing against the current Linus tree, without having the Linus
-# tree overwrite the 2.6.9 tree when installed.
-#
-# Currently, only git is supported.
-# Other SCMs can edit scripts/setlocalversion and add the appropriate
-# checks as needed.
-
-
-ifdef CONFIG_LOCALVERSION_AUTO
-	localversion-auto := $(shell $(PERL) $(srctree)/scripts/setlocalversion $(srctree))
-	LOCALVERSION := $(LOCALVERSION)$(localversion-auto)
-endif
-
 #
 # INSTALL_MOD_PATH specifies a prefix to MODLIB for module directory
 # relocations required by build roots.  This is not defined in the
@@ -782,6 +747,47 @@ $(sort $(vmlinux-init) $(vmlinux-main)) 
 $(vmlinux-dirs): prepare scripts
 	$(Q)$(MAKE) $(build)=$@
 
+# Build the kernel release string
+# The kernelrelease is stored in a file named .kernelrelease
+# to be used when executing for example make install or make modules_install
+
+nullstring :=
+space      := $(nullstring) # end of line
+
+# Take the contents of any files called localversion* and the config
+# variable CONFIG_LOCALVERSION and append them to KERNELRELEASE. Be
+# careful not to include files twice if building in the source
+# directory. LOCALVERSION from the command line override all of this
+
+___localver = $(objtree)/localversion* $(srctree)/localversion*
+__localver  = $(sort $(wildcard $(___localver)))
+# skip backup files (containing '~')
+_localver = $(foreach f, $(__localver), $(if $(findstring ~, $(f)),,$(f)))
+
+localver = $(subst $(space),, \
+	   $(shell cat /dev/null $(_localver)) \
+	   $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
+	       
+# If CONFIG_LOCALVERSION_AUTO is set, we automatically perform some tests
+# and try to determine if the current source tree is a release tree,
+# if any sort, or if is a pure development tree.
+# A 'release tree' is any tree with a git TAG associated
+# with it.  The primary goal of this is to make it safe for a native
+# git user to build a release tree (i.e, 2.6.9) and also to
+# continue developing against the current Linus tree, without having the Linus
+# tree overwrite the 2.6.9 tree when installed.
+#
+# Currently, only git is supported.
+# Other SCMs can edit scripts/setlocalversion and add the appropriate
+# checks as needed.
+ifdef CONFIG_LOCALVERSION_AUTO
+	_localver-auto = $(shell $(CONFIG_SHELL) \
+	                  $(srctree)/scripts/setlocalversion $(srctree))
+	localver-auto  = $(LOCALVERSION)$(_localver-auto)
+endif
+
+localver-full = $(localver)$(localver-auto)
+
 # Things we need to do before we recursively start building the kernel
 # or the modules are listed in "prepare".
 # A multi level approach is used. prepareN is processed before prepareN-1.
@@ -789,17 +795,23 @@ $(vmlinux-dirs): prepare scripts
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-.PHONY: prepare archprepare prepare0 prepare1 prepare2 prepare3
+.PHONY: prepare archprepare prepare0 prepare1 prepare2 prepare3 prepare4
 
 # prepare-all is deprecated, use prepare as valid replacement
 .PHONY: prepare-all
 
+# prepare4 is used to store new kernelrelease string in .kernelrelease
+kernelrelease = \
+       $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(localver-full)
+prepare4:
+	$(shell echo $(kernelrelease) > .kernelrelease)
+	$(Q)echo "  Building kernel $(KERNELRELEASE)"
+
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
 # 1) Check that make has not been executed in the kernel src $(srctree)
 # 2) Create the include2 directory, used for the second asm symlink
-
-prepare3:
+prepare3: prepare4
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
 	$(Q)if [ -f $(srctree)/.config ]; then \
@@ -986,7 +998,7 @@ CLEAN_FILES +=	vmlinux System.map \
 MRPROPER_DIRS  += include/config include2
 MRPROPER_FILES += .config .config.old include/asm .version .old_version \
                   include/linux/autoconf.h include/linux/version.h \
-                  Module.symvers tags TAGS cscope*
+		  .kernelrelease Module.symvers tags TAGS cscope*
 
 # clean - Delete most, but leave enough to build external modules
 #
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index a9cd42e..663dbdb 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -80,7 +80,7 @@ bzlilo: vmlinux
 bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
 
-install fdimage fdimage144 fdimage288: vmlinux
+install fdimage fdimage144 fdimage288:
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
 
 archclean:
