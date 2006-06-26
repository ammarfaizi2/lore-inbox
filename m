Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWFZA6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWFZA6f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWFZA6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:32 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14991 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964974AbWFZA6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:19 -0400
Date: Sun, 25 Jun 2006 17:58:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 09/43] kbuild: support single targets for klibc and klibc programs
Message-Id: <klibc.200606251757.09@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the following patch kbuild now supports:
make usr/dash/arith_yylex.i
make usr/klibc/umount.o
make usr/klibc/umount.s

Patch does also fix indention of CPP command

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit a36102c485caf951294301425ee8e87aa6ab4d92
tree 88d3e4aebe253cb3d6c417eac3cd2c1fa14db694
parent 15ad2d153c3c214522eef889a14f3cd97f40864a
author Sam Ravnborg <sam@ravnborg.org> Mon, 17 Apr 2006 13:54:47 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:47:01 -0700

 Makefile               |   24 ++++++++++++++++--------
 scripts/Kbuild.include |    5 +++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 897e647..ea1bae0 100644
--- a/Makefile
+++ b/Makefile
@@ -181,6 +181,11 @@ UTS_MACHINE	:= $(ARCH)
 # Architecture used to compile user-space code
 KLIBCARCH	?= $(subst powerpc,ppc,$(ARCH))
 
+# klibc definitions
+export KLIBCINC := usr/include
+export KLIBCSRC := $(srctree)/usr/klibc
+export KLIBCOBJ := $(objtree)/usr/klibc
+
 # SHELL used by kbuild
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
 	  else if [ -x /bin/bash ]; then echo /bin/bash; \
@@ -1281,39 +1286,42 @@ # Single targets are compatible with:
 # - build whith mixed source and output
 # - build with separate output dir 'make O=...'
 # - external modules
+# - klibc library and klibc programs (everything under usr/)
 #
 #  target-dir => where to store outputfile
 #  build-dir  => directory in kernel source tree to use
 
 ifeq ($(KBUILD_EXTMOD),)
+        singlebld  = $(if $(filter usr/%,$(dir $@)),$(klibc),$(build))
         build-dir  = $(patsubst %/,%,$(dir $@))
         target-dir = $(dir $@)
 else
+        singlebld  = $(build)
         zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
         build-dir  = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
         target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
 endif
 
 %.s: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.i: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.lst: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.s: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
 / %/: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
-	$(build)=$(build-dir)
+	$(singlebld)=$(build-dir)
 %.ko: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
-	$(build)=$(build-dir) $(@:.ko=.o)
+	$(singlebld)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
 # FIXME Should go into a make.lib or something 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b0d067b..3c90468 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -87,6 +87,11 @@ # Usage:
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.build obj
 
+# Shorthand for $(Q)$(MAKE) -f scripts/Kbuild.klibc obj=
+# Usage:
+# $(Q)$(MAKE) $(klibc)=dir
+klibc := -f $(srctree)/scripts/Kbuild.klibc obj
+
 # Prefix -I with $(srctree) if it is not an absolute path
 addtree = $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1)
 # Find all -I options and call addtree
