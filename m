Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWAIVkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWAIVkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWAIVkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:40:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29712 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750734AbWAIVjL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:39:11 -0500
Subject: [PATCH 11/11] kbuild: KERNELRELEASE is only re-defined when buiding the kernel
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:54 +0100
Message-Id: <11368427343089@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To avoid running setlocalversion as root no longer (re-)define
KERNELRELEASE for each run. With this patch KERNELRELEASE is
only re-read when we do an actual kernel build.
Rationale behind this is "do as little as possible" when executing
make install - as root!

A new file named .kernelrelease is strored in the root of the kernel
tree containing the actual version string.
So when we use do a kernel build the .kernelrelease file will be updated.
But in all other situations it is left as-is.

To make it more visible the kernel now prints out the version being build.
Sample:
Building kernel 2.6.15-g63b794bf-dirty
...
...

The patch also un-exports VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION
since all users of these are anyway broken - and none is left in the
tree.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |   95 +++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 53 insertions(+), 42 deletions(-)

cb58455c48dc43536e5548bdba4e916b2f0cf13d
diff --git a/Makefile b/Makefile
index 50b07fa..df60aa1 100644
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
+# Read KERNELRELEASE from .kernelrelease (if it exists)
+KERNELRELEASE = $(shell cat .kernelrelease 2> /dev/null)
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
@@ -782,6 +747,50 @@ $(sort $(vmlinux-init) $(vmlinux-main)) 
 $(vmlinux-dirs): prepare scripts
 	$(Q)$(MAKE) $(build)=$@
 
+# Build the kernel release string
+# The KERNELRELEASE is stored in a file named .kernelrelease
+# to be used when executing for example make install or make modules_install
+#
+# Take the contents of any files called localversion* and the config
+# variable CONFIG_LOCALVERSION and append them to KERNELRELEASE.
+# LOCALVERSION from the command line override all of this
+
+nullstring :=
+space      := $(nullstring) # end of line
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
+# If CONFIG_LOCALVERSION_AUTO is set scripts/setlocalversion is called
+# and if the SCM is know a tag from the SCM is appended.
+# The appended tag is determinded by the SCM used.
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
+# Store (new) KERNELRELASE string in .kernelrelease
+kernelrelease = \
+       $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(localver-full)
+.kernelrelease: FORCE
+	$(Q)rm -f .kernelrelease
+	$(Q)echo $(kernelrelease) > .kernelrelease
+	$(Q)echo "  Building kernel $(kernelrelease)"
+
+
 # Things we need to do before we recursively start building the kernel
 # or the modules are listed in "prepare".
 # A multi level approach is used. prepareN is processed before prepareN-1.
@@ -798,8 +807,7 @@ $(vmlinux-dirs): prepare scripts
 # and if so do:
 # 1) Check that make has not been executed in the kernel src $(srctree)
 # 2) Create the include2 directory, used for the second asm symlink
-
-prepare3:
+prepare3: .kernelrelease
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
 	$(Q)if [ -f $(srctree)/.config ]; then \
@@ -986,7 +994,7 @@ CLEAN_FILES +=	vmlinux System.map \
 MRPROPER_DIRS  += include/config include2
 MRPROPER_FILES += .config .config.old include/asm .version .old_version \
                   include/linux/autoconf.h include/linux/version.h \
-                  Module.symvers tags TAGS cscope*
+		  .kernelrelease Module.symvers tags TAGS cscope*
 
 # clean - Delete most, but leave enough to build external modules
 #
@@ -1072,6 +1080,7 @@ help:
 	@echo  '  tags/TAGS	  - Generate tags file for editors'
 	@echo  '  cscope	  - Generate cscope index'
 	@echo  '  kernelrelease	  - Output the release version string'
+	@echo  '  kernelversion	  - Output the version stored in Makefile'
 	@echo  ''
 	@echo  'Static analysers'
 	@echo  '  buildcheck      - List dangling references to vmlinux discarded sections'
@@ -1293,6 +1302,8 @@ checkstack:
 
 kernelrelease:
 	@echo $(KERNELRELEASE)
+kernelversion:
+	@echo $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
-- 
1.0.GIT

