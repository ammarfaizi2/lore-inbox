Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268335AbUH0V55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268335AbUH0V55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUH0Vye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:54:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17662 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267610AbUH0VxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:53:19 -0400
From: trini@kernel.crashing.org
Message-Id: <200408272153.OAA28851@av.mvista.com>
Subject: [patch 3/3] 
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org
Date: Fri, 27 Aug 2004 14:53:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Additional Makefile fixes for Solaris 2.8

On Solaris, 'head' doesn't take a -q argument.  But we can use 'grep -h'
instead, so do that in Makefile.mod{inst,post}.  The built-in test to
/bin/sh doesn't like 'if ! cmd' syntax, so when determining if we need
to do modversion stuff, invert the if/else cases.  The built-in test
also doesn't understand -ef, so invoke a real version of test which does.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
---

 linux-2.6-solaris-trini/Makefile                 |    8 ++++----
 linux-2.6-solaris-trini/scripts/Makefile.build   |    6 +++---
 linux-2.6-solaris-trini/scripts/Makefile.modinst |    2 +-
 linux-2.6-solaris-trini/scripts/Makefile.modpost |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff -puN Makefile~shell_commands Makefile
--- linux-2.6-solaris/Makefile~shell_commands	2004-08-27 14:47:07.033077973 -0700
+++ linux-2.6-solaris-trini/Makefile	2004-08-27 14:47:07.042075885 -0700
@@ -673,10 +673,10 @@ $(vmlinux-dirs): prepare-all scripts
 # using a seperate output directory. This allows convinient use
 # of make in output directory
 prepare2:
-	$(Q)if [ ! $(srctree) -ef $(objtree) ]; then       \
-	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile      \
-	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL) \
-	    > $(objtree)/Makefile;                         \
+	$(Q)if /usr/bin/env test ! $(srctree) -ef $(objtree); then \
+	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile              \
+	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)         \
+	    > $(objtree)/Makefile;                                 \
 	fi
 
 # prepare1 is used to check if we are building in a separate output directory,
diff -puN scripts/Makefile.build~shell_commands scripts/Makefile.build
--- linux-2.6-solaris/scripts/Makefile.build~shell_commands	2004-08-27 14:47:07.035077509 -0700
+++ linux-2.6-solaris-trini/scripts/Makefile.build	2004-08-27 14:47:07.043075653 -0700
@@ -160,9 +160,7 @@ else
 
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
 cmd_modversions =							\
-	if ! $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	\
-		mv $(@D)/.tmp_$(@F) $@;					\
-	else								\
+	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	\
 		$(CPP) -D__GENKSYMS__ $(c_flags) $<			\
 		| $(GENKSYMS)						\
 		> $(@D)/.tmp_$(@F:.o=.ver);				\
@@ -170,6 +168,8 @@ cmd_modversions =							\
 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);			\
 		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);	\
+	else								\
+		mv $(@D)/.tmp_$(@F) $@;					\
 	fi;
 endif
 
diff -puN scripts/Makefile.modinst~shell_commands scripts/Makefile.modinst
--- linux-2.6-solaris/scripts/Makefile.modinst~shell_commands	2004-08-27 14:47:07.036077277 -0700
+++ linux-2.6-solaris-trini/scripts/Makefile.modinst	2004-08-27 14:47:07.043075653 -0700
@@ -9,7 +9,7 @@ include scripts/Makefile.lib
 
 #
 
-__modules := $(sort $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod)))
+__modules := $(sort $(shell grep -h .ko /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
 .PHONY: $(modules)
diff -puN scripts/Makefile.modpost~shell_commands scripts/Makefile.modpost
--- linux-2.6-solaris/scripts/Makefile.modpost~shell_commands	2004-08-27 14:47:07.038076813 -0700
+++ linux-2.6-solaris-trini/scripts/Makefile.modpost	2004-08-27 14:47:07.043075653 -0700
@@ -41,7 +41,7 @@ include scripts/Makefile.lib
 symverfile := $(objtree)/Module.symvers
 
 # Step 1), find all modules listed in $(MODVERDIR)/
-__modules := $(sort $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod)))
+__modules := $(sort $(shell grep -h .ko /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules   := $(patsubst %.o,%.ko, $(wildcard $(__modules:.ko=.o)))
 
 _modpost: $(modules)
_
