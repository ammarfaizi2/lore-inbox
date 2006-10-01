Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWJAKxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWJAKxW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWJAKxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:53:14 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:10909 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751571AbWJAKwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:52:50 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@neptun.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 11/13] kbuild: make modpost processing configurable
Reply-To: sam@ravnborg.org
Date: Sun, 01 Oct 2006 12:52:44 +0200
Message-Id: <11596999683256-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <115969996811-git-send-email-sam@ravnborg.org>
References: <1159699966691-git-send-email-sam@ravnborg.org> <1159699967600-git-send-email-sam@ravnborg.org> <11596999673562-git-send-email-sam@ravnborg.org> <115969996719-git-send-email-sam@ravnborg.org> <11596999673039-git-send-email-sam@ravnborg.org> <11596999672694-git-send-email-sam@ravnborg.org> <11596999673444-git-send-email-sam@ravnborg.org> <11596999672988-git-send-email-sam@ravnborg.org> <1159699967673-git-send-email-sam@ravnborg.org> <115969996811-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@neptun.ravnborg.org>

On request from Al Viro make modpost processing configurable.

KBUILD_MODPOST_WARN can be set to make modpost warn instead of
error out in case on unresolved symbols in final module link.

KBUILD_MODPOST_NOFINAL can be set to avoid the final and timeconsuming
.c file generation and link of .ko files. This is solely useful for
speeding up when doing compile checks with for example allmodconfig

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/Makefile.modpost |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 4b2721c..6c5469b 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -32,6 +32,10 @@ #     - See include/linux/module.h for m
 # Step 4 is solely used to allow module versioning in external modules,
 # where the CRC of each module is retrieved from the Module.symers file.
 
+# KBUILD_MODPOST_WARN can be set to avoid error out in case of undefined
+# symbols in the final module linking stage
+# KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
+# This is solely usefull to speed up test compiles
 PHONY := _modpost
 _modpost: __modpost
 
@@ -46,7 +50,8 @@ # Step 1), find all modules listed in $(
 __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules   := $(patsubst %.o,%.ko, $(wildcard $(__modules:.ko=.o)))
 
-_modpost: $(modules)
+# Stop after building .o files if NOFINAL is set. Makes compile tests quicker
+_modpost: $(if $(KBUILD_MODPOST_NOFINAL), $(modules:.ko:.o),$(modules))
 
 
 # Step 2), invoke modpost
@@ -58,7 +63,7 @@ quiet_cmd_modpost = MODPOST $(words $(fi
 	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile) \
 	$(if $(KBUILD_EXTMOD),-I $(modulesymfile)) \
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
-	$(if $(KBUILD_EXTMOD),-w) \
+	$(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w) \
 	$(wildcard vmlinux) $(filter-out FORCE,$^)
 
 PHONY += __modpost
@@ -92,7 +97,7 @@ targets += $(modules:.ko=.mod.o)
 
 # Step 6), final link of the modules
 quiet_cmd_ld_ko_o = LD [M]  $@
-      cmd_ld_ko_o = $(LD) $(LDFLAGS) $(LDFLAGS_MODULE) -o $@ 		\
+      cmd_ld_ko_o = $(LD) $(LDFLAGS) $(LDFLAGS_MODULE) -o $@		\
 			  $(filter-out FORCE,$^)
 
 $(modules): %.ko :%.o %.mod.o FORCE
-- 
1.4.1

