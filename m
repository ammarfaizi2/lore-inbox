Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274916AbTHPUoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 16:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274929AbTHPUod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 16:44:33 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:15885 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S274916AbTHPUoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 16:44:20 -0400
Date: Sat, 16 Aug 2003 22:44:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: =?iso-8859-1?B?W1BBVENIXaBNb3Y=?=
	=?iso-8859-1?Q?e?= config targets to kconfig/Makefile
Message-ID: <20030816204416.GA7034@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus. Fixes a bug with multiple targets. Please apply.

Olaf Hering reported that the build failed for PowerPc if used like this:
make oldconfig zImage

The reason for this was that .config was not present for any targets
specified in arch/$(ARCH)/Makefile and below. Thats because
.config would not be included when oldconfig is present in the
list of targets.
Fix has been to move handling of *config task to the kconfig/Makefile.
Furthermore logic in top-level makefile has changed a bit, creating
a more logial structure.
When building a fresh kernel, the user is now told that .config is missing,
not an anonymous report that .config did not exist.

The error has survided this long because the targets used in i386/boot in
general does not use CONFIG_ symbols.

Olaf Hering has tested this patch with success.

 Makefile                 |  157 ++++++++++++++++-------------------------------
 scripts/Makefile.build   |    5 -
 scripts/kconfig/Makefile |   59 +++++++++++++++--
 3 files changed, 109 insertions(+), 112 deletions(-)

	Sam

===== Makefile 1.420 vs edited =====
--- 1.420/Makefile	Sat Aug  9 06:09:32 2003
+++ edited/Makefile	Sat Aug 16 22:23:27 2003
@@ -243,17 +243,15 @@
 comma := ,
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
-noconfig_targets := xconfig gconfig menuconfig config oldconfig randconfig \
-		    defconfig allyesconfig allnoconfig allmodconfig \
-		    clean mrproper distclean rpm \
-		    help tags TAGS cscope %docs \
-		    checkconfig checkhelp checkincludes
+# Files to ignore in find ... statements
 
 RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS \) -prune -o
 RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS
 
+# ===========================================================================
+# Rules shared between *config targets and build targets
+
 # Helpers built in scripts/
-# ---------------------------------------------------------------------------
 
 scripts/docproc scripts/fixdep scripts/split-include : scripts ;
 
@@ -261,9 +259,49 @@
 scripts:
 	$(Q)$(MAKE) $(build)=scripts
 
-# Objects we will link into vmlinux / subdirs we need to visit
-# ---------------------------------------------------------------------------
 
+# To make sure we do not include .config for any of the *config targets
+# catch them early, and hand them over to scripts/kconfig/Makefile
+# It is allowed to specify more targets when calling make, including
+# mixing *config targets and build targets.
+# For example 'make oldconfig all'. 
+# Detect when mixed targets is specified, and make a second invocation
+# of make so .config is not included in this case either (for *config).
+
+config-targets := 0
+mixed-targets  := 0
+ifneq ($(filter config %config,$(MAKECMDGOALS)),)
+	config-targets := 1
+	ifneq ($(filter-out config %config,$(MAKECMDGOALS)),)
+		mixed-targets := 1
+	endif
+endif
+
+ifeq ($(mixed-targets),1)
+# ===========================================================================
+# We're called with mixed targets (*config and build targets).
+# Handle them one by one.
+
+%:: FORCE
+	$(Q)$(MAKE) $@
+
+else
+ifeq ($(config-targets),1)
+# ===========================================================================
+# *config targets only - make sure prerequisites are updated, and descend
+# in scripts/kconfig to make the *config target
+
+%config: scripts/fixdep FORCE
+	$(Q)$(MAKE) $(build)=scripts/kconfig $@
+config : scripts/fixdep FORCE
+	$(Q)$(MAKE) $(build)=scripts/kconfig $@
+
+else
+# ===========================================================================
+# Build targets only - this includes vmlinux, arch specific targets, clean
+# targets and others. In general all targets except *config targets.
+
+# Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
 drivers-y	:= drivers/ sound/
 net-y		:= net/
@@ -271,14 +309,8 @@
 core-y		:= usr/
 SUBDIRS		:=
 
-ifeq ($(filter $(noconfig_targets),$(MAKECMDGOALS)),)
-
-export include_config := 1
-
 -include .config
 
-endif
-
 include arch/$(ARCH)/Makefile
 
 # Let architecture Makefiles change CPPFLAGS if needed
@@ -304,10 +336,8 @@
 libs-y2		:= $(patsubst %/, %/built-in.o, $(libs-y))
 libs-y		:= $(libs-y1) $(libs-y2)
 
-ifdef include_config
-
 # Here goes the main Makefile
-# ===========================================================================
+# ---------------------------------------------------------------------------
 #
 # If the user gave a *config target, it'll be handled in another
 # section below, since in this case we cannot include .config
@@ -608,72 +638,6 @@
 	 echo "#endif" )
 endef
 
-else # ifdef include_config
-
-ifeq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
-
-# Targets which don't need .config
-# ===========================================================================
-#
-# These targets basically have their own Makefile - not quite, but at
-# least its own exclusive section in the same Makefile. The reason for
-# this is the following:
-# To know the configuration, the main Makefile has to include
-# .config. That's a obviously a problem when .config doesn't exist
-# yet, but that could be kludged around with only including it if it
-# exists.
-# However, the larger problem is: If you run make *config, make will
-# include the old .config, then execute your *config. It will then
-# notice that a piece it included (.config) did change and restart from
-# scratch. Which will cause execution of *config again. You get the
-# picture.
-# If we don't explicitly let the Makefile know that .config is changed
-# by *config (the old way), it won't reread .config after *config,
-# thus working with possibly stale values - we don't that either.
-#
-# So we divide things: This part here is for making *config targets,
-# and other targets which should work when no .config exists yet.
-# The main part above takes care of the rest after a .config exists.
-
-# Kernel configuration
-# ---------------------------------------------------------------------------
-
-.PHONY: oldconfig xconfig gconfig menuconfig config \
-	make_with_config rpm
-
-scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf scripts/kconfig/gconf: scripts/fixdep FORCE
-	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-
-xconfig: scripts/kconfig/qconf
-	./scripts/kconfig/qconf arch/$(ARCH)/Kconfig
-
-gconfig: scripts/kconfig/gconf
-	./scripts/kconfig/gconf arch/$(ARCH)/Kconfig
-
-menuconfig: scripts/kconfig/mconf
-	$(Q)$(MAKE) $(build)=scripts/lxdialog
-	./scripts/kconfig/mconf arch/$(ARCH)/Kconfig
-
-config: scripts/kconfig/conf
-	./scripts/kconfig/conf arch/$(ARCH)/Kconfig
-
-oldconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -o arch/$(ARCH)/Kconfig
-
-randconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -r arch/$(ARCH)/Kconfig
-
-allyesconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -y arch/$(ARCH)/Kconfig
-
-allnoconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -n arch/$(ARCH)/Kconfig
-
-allmodconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -m arch/$(ARCH)/Kconfig
-
-defconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -d arch/$(ARCH)/Kconfig
 
 ###
 # Cleaning is done on three levels.
@@ -778,6 +742,8 @@
 # RPM target
 # ---------------------------------------------------------------------------
 
+.PHONY: rpm
+
 #	If you do a make spec before packing the tarball you can rpm -ta it
 
 spec:
@@ -813,14 +779,7 @@
 	@echo  '  mrproper	  - remove all generated files + config + various backup files'
 	@echo  ''
 	@echo  'Configuration targets:'
-	@echo  '  oldconfig	  - Update current config utilising a line-oriented program'
-	@echo  '  menuconfig	  - Update current config utilising a menu based program'
-	@echo  '  xconfig	  - Update current config utilising a QT based front-end'
-	@echo  '  gconfig	  - Update current config utilising a GTK based front-end'
-	@echo  '  defconfig	  - New config with default answer to all options'
-	@echo  '  allmodconfig	  - New config selecting modules when possible'
-	@echo  '  allyesconfig	  - New config where all options are accepted with yes'
-	@echo  '  allnoconfig	  - New minimal config'
+	@$(MAKE) -f scripts/kconfig/Makefile help
 	@echo  ''
 	@echo  'Other generic targets:'
 	@echo  '  all		  - Build all targets marked with [*]'
@@ -833,7 +792,7 @@
 	@echo  '  tags/TAGS	  - Generate tags file for editors'
 	@echo  ''
 	@echo  'Documentation targets:'
-	@$(MAKE) --no-print-directory -f Documentation/DocBook/Makefile dochelp
+	@$(MAKE) -f Documentation/DocBook/Makefile dochelp
 	@echo  ''
 	@echo  'Architecture specific targets ($(ARCH)):'
 	@$(if $(archhelp),$(archhelp),\
@@ -864,17 +823,8 @@
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkincludes.pl
 
-else # ifneq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
-
-# We're called with both targets which do and do not need
-# .config included. Handle them one after the other.
-# ===========================================================================
-
-%:: FORCE
-	$(Q)$(MAKE) $@
-
-endif # ifeq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
-endif # ifdef include_config
+endif #ifeq ($(config-targets),1)
+endif #ifeq ($(mixed-targets),1)
 
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
@@ -894,6 +844,7 @@
 cmd_files := $(wildcard .*.cmd $(foreach f,$(targets),$(dir $(f)).$(notdir $(f)).cmd))
 
 ifneq ($(cmd_files),)
+  $(cmd_files): ;	# Do not try to update included dependency files
   include $(cmd_files)
 endif
 
===== scripts/Makefile.build 1.38 vs edited =====
--- 1.38/scripts/Makefile.build	Thu Jun 12 05:36:33 2003
+++ edited/scripts/Makefile.build	Fri Aug 15 20:50:14 2003
@@ -7,9 +7,8 @@
 .PHONY: __build
 __build:
 
-ifdef include_config
-include .config
-endif
+# Read .config if it exist, otherwise ignore
+-include .config
 
 include $(obj)/Makefile
 
===== scripts/kconfig/Makefile 1.6 vs edited =====
--- 1.6/scripts/kconfig/Makefile	Sat Mar 15 18:25:56 2003
+++ edited/scripts/kconfig/Makefile	Sat Aug 16 22:17:57 2003
@@ -1,6 +1,55 @@
-#################
-#
-# Shared Makefile for the various lkc executables:
+# ===========================================================================
+# Kernel configuration targets
+# These targets are used from top-level makefile
+
+.PHONY: oldconfig xconfig gconfig menuconfig config
+
+xconfig: scripts/kconfig/qconf
+	./scripts/kconfig/qconf arch/$(ARCH)/Kconfig
+
+gconfig: scripts/kconfig/gconf
+	./scripts/kconfig/gconf arch/$(ARCH)/Kconfig
+
+menuconfig: scripts/kconfig/mconf
+	$(Q)$(MAKE) $(build)=scripts/lxdialog
+	./scripts/kconfig/mconf arch/$(ARCH)/Kconfig
+
+config: scripts/kconfig/conf
+	./scripts/kconfig/conf arch/$(ARCH)/Kconfig
+
+oldconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -o arch/$(ARCH)/Kconfig
+
+.PHONY: randconfig allyesconfig allnoconfig allmodconfig defconfig
+
+randconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -r arch/$(ARCH)/Kconfig
+
+allyesconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -y arch/$(ARCH)/Kconfig
+
+allnoconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -n arch/$(ARCH)/Kconfig
+
+allmodconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -m arch/$(ARCH)/Kconfig
+
+defconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -d arch/$(ARCH)/Kconfig
+
+# Help text used by make help
+help:
+	@echo  '  oldconfig	  - Update current config utilising a line-oriented program'
+	@echo  '  menuconfig	  - Update current config utilising a menu based program'
+	@echo  '  xconfig	  - Update current config utilising a QT based front-end'
+	@echo  '  gconfig	  - Update current config utilising a GTK based front-end'
+	@echo  '  defconfig	  - New config with default answer to all options'
+	@echo  '  allmodconfig	  - New config selecting modules when possible'
+	@echo  '  allyesconfig	  - New config where all options are accepted with yes'
+	@echo  '  allnoconfig	  - New minimal config'
+
+# ===========================================================================
+# Shared Makefile for the various kconfig executables:
 # conf:	  Used for defconfig, oldconfig and related targets
 # mconf:  Used for the mconfig target.
 #         Utilizes the lxdialog package
@@ -8,10 +57,8 @@
 #         Based on QT which needs to be installed to compile it
 # gconf:  Used for the gconfig target
 #         Based on GTK which needs to be installed to compile it
-#
-#################
+# object files used by all kconfig flavours
 
-# object files used by all lkc flavours
 libkconfig-objs := zconf.tab.o
 
 host-progs	:= conf mconf qconf gconf
