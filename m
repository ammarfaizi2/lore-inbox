Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262707AbSKDUIN>; Mon, 4 Nov 2002 15:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbSKDUIN>; Mon, 4 Nov 2002 15:08:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:47369 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262707AbSKDUIJ>;
	Mon, 4 Nov 2002 15:08:09 -0500
Date: Mon, 4 Nov 2002 21:14:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: [RFC] kconfig: Move config targets and lxdialog
Message-ID: <20021104201442.GA8542@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.

Played with the idea to shuffle a little around with stuff.
1) lxdialog is solely used for kconfig, so move it below scripts/kconfig
2) Move handling of all config targets to scripts/kconfig/Makefile
	This simplifies top-level makefile,
	and the actual rules is nicer as a side effect.

2) does in no way require 1), but I just combined it here.

I really like moving the config targets away from the top-level makefile.
Allthough I kept them in "make help", so they all still mentioned in
the toplevel Makefile.

Except form moving lxdialog the following files are touched:
 Makefile                 |   39 ++++-----------------------------------
 scripts/Makefile         |    8 ++------
 scripts/kconfig/Makefile |   35 +++++++++++++++++++++++++++++++++--
 scripts/kconfig/mconf.c  |    2 +-
 4 files changed, 40 insertions(+), 44 deletions(-)

	Sam

To try it out:
Execute "mv scripts/lxdialog scripts/kconfig/"
and apply the following patch:

===== Makefile 1.338 vs edited =====
--- 1.338/Makefile	Fri Nov  1 18:00:18 2002
+++ edited/Makefile	Mon Nov  4 21:11:45 2002
@@ -184,8 +184,7 @@
 # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
-noconfig_targets := xconfig menuconfig config oldconfig randconfig \
-		    defconfig allyesconfig allnoconfig allmodconfig \
+noconfig_targets := config %config\
 		    clean mrproper distclean \
 		    help tags TAGS sgmldocs psdocs pdfdocs htmldocs \
 		    checkconfig checkhelp checkincludes
@@ -632,41 +631,11 @@
 # Kernel configuration
 # ---------------------------------------------------------------------------
 
-.PHONY: oldconfig xconfig menuconfig config \
-	make_with_config
+.PHONY: config %config
 
-scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf: scripts/fixdep FORCE
-	+@$(call descend,scripts/kconfig,$@)
+config %config: scripts FORCE
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=scripts/kconfig $@
 
-xconfig: scripts/kconfig/qconf
-	./scripts/kconfig/qconf arch/$(ARCH)/Kconfig
-
-menuconfig: scripts/kconfig/mconf
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=scripts lxdialog
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
-
-###
 # Cleaning is done on three levels.
 # make clean     Delete all automatically generated files, including
 #                tools and firmware.
===== scripts/Makefile 1.21 vs edited =====
--- 1.21/scripts/Makefile	Wed Oct 30 02:16:49 2002
+++ edited/scripts/Makefile	Mon Nov  4 20:17:09 2002
@@ -11,7 +11,7 @@
 
 EXTRA_TARGETS := fixdep split-include docproc conmakehash
 
-subdir-	:= lxdialog kconfig
+subdir-	:= kconfig
 
 # Yikes. We need to build this stuff here even if the user only wants
 # modules.
@@ -52,11 +52,7 @@
 
 
 # ---------------------------------------------------------------------------
-# Targets hardcoded and wellknow in top-level makefile
-.PHONY: lxdialog
-lxdialog:
-	$(call descend,scripts/lxdialog,)
 
 # fixdep is needed to compile other host programs
 $(obj)/split-include $(obj)/docproc $(addprefix $(obj)/,$(tkparse-objs)) \
-$(obj)/conmakehash lxdialog: $(obj)/fixdep
+$(obj)/conmakehash: $(obj)/fixdep
===== scripts/kconfig/mconf.c 1.1 vs edited =====
--- 1.1/scripts/kconfig/mconf.c	Wed Oct 30 02:16:44 2002
+++ edited/scripts/kconfig/mconf.c	Mon Nov  4 20:34:04 2002
@@ -129,7 +129,7 @@
 	memset(args, 0, sizeof(args));
 	indent = 0;
 	child_count = 0;
-	cprint("./scripts/lxdialog/lxdialog");
+	cprint("./scripts/kconfig/lxdialog/lxdialog");
 	cprint("--backtitle");
 	cprint(menu_backtitle);
 }
===== scripts/kconfig/Makefile 1.2 vs edited =====
--- 1.2/scripts/kconfig/Makefile	Thu Oct 31 10:23:07 2002
+++ edited/scripts/kconfig/Makefile	Mon Nov  4 21:02:20 2002
@@ -18,11 +18,38 @@
 qconf-objs	:= kconfig_load.o
 qconf-cxxobjs	:= qconf.o
 
+subdir-		:= lxdialog
 clean-files	:= libkconfig.so lkc_defs.h qconf.moc .tmp_qtcheck \
 		   zconf.tab.c zconf.tab.h lex.zconf.c
 
-include $(TOPDIR)/Rules.make
+xconfig: $(obj)/qconf
+	$< arch/$(ARCH)/Kconfig
 
+menuconfig: $(obj)/lxdialog/lxdialog $(obj)/mconf
+	$(obj)/mconf arch/$(ARCH)/Kconfig
+
+config: $(obj)/conf
+	$< arch/$(ARCH)/Kconfig
+
+oldconfig: $(obj)/conf
+	$< -o arch/$(ARCH)/Kconfig
+
+randconfig: $(obj)/conf
+	$< -r arch/$(ARCH)/Kconfig
+
+allyesconfig: $(obj)/conf
+	$< -y arch/$(ARCH)/Kconfig
+
+allnoconfig: $(obj)/conf
+	$< -n arch/$(ARCH)/Kconfig
+
+allmodconfig: $(obj)/conf
+	$< -m arch/$(ARCH)/Kconfig
+
+defconfig: $(obj)/conf
+	$< -d arch/$(ARCH)/Kconfig
+
+###
 # generated files seem to need this to find local include files
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
@@ -30,11 +57,15 @@
 HOSTLOADLIBES_qconf	= -L$(QTDIR)/lib -Wl,-rpath,$(QTDIR)/lib -l$(QTLIB) -ldl
 HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include 
 
+# -----------------------------------------------------------------------------
 $(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o: $(obj)/zconf.tab.h
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
-ifeq ($(MAKECMDGOALS),$(obj)/qconf)
+$(obj)/lxdialog/lxdialog: FORCE
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/lxdialog
+
+ifeq ($(MAKECMDGOALS),xconfig)
 -include $(obj)/.tmp_qtcheck
 
 # QT needs some extra effort...
