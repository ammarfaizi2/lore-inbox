Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUELNez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUELNez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUELNey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:34:54 -0400
Received: from ns.suse.de ([195.135.220.2]:9935 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265043AbUELNdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:33:11 -0400
Subject: [PATCH] kbuild SUBDIRS="more/ than/ one/"
From: Andreas Gruenbacher <agruen@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1084368663.6038.10.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 15:31:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that re-adds support for more than one directory in
SUBDIRS. We have a number of packages that use this.

The FORCE dependency of crmodverdir seems unnecessary; removing.


Index: linux-2.6.5/Makefile
===================================================================
--- linux-2.6.5.orig/Makefile
+++ linux-2.6.5/Makefile
@@ -110,7 +110,7 @@ $(if $(wildcard $(KBUILD_OUTPUT)),, \
 $(filter-out _all,$(MAKECMDGOALS)) _all:
 	$(if $(KBUILD_VERBOSE:1=),@)$(MAKE) -C $(KBUILD_OUTPUT)		\
 	KBUILD_SRC=$(CURDIR)	     KBUILD_VERBOSE=$(KBUILD_VERBOSE)	\
-	KBUILD_CHECK=$(KBUILD_CHECK) KBUILD_EXTMOD=$(KBUILD_EXTMOD)     \
+	KBUILD_CHECK=$(KBUILD_CHECK) KBUILD_EXTMOD="$(KBUILD_EXTMOD)"	\
         -f $(CURDIR)/Makefile $@
 
 # Leave processing to above invocation of make
@@ -325,7 +325,7 @@ export AFLAGS AFLAGS_KERNEL AFLAGS_MODUL
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
 # even be read-only.
-export MODVERDIR := $(if
$(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/).tmp_versions
+export MODVERDIR := $(if $(KBUILD_EXTMOD),$(firstword
$(KBUILD_EXTMOD))/).tmp_versions
 
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
@@ -951,15 +951,15 @@ else # KBUILD_EXTMOD
 # We are always building modules
 KBUILD_MODULES := 1
 .PHONY: crmodverdir
-crmodverdir: FORCE
+crmodverdir:
 	$(Q)mkdir -p $(MODVERDIR)
 
-.PHONY: $(KBUILD_EXTMOD)
-$(KBUILD_EXTMOD): crmodverdir FORCE
-	$(Q)$(MAKE) $(build)=$@
-
-.PHONY: modules
-modules: $(KBUILD_EXTMOD)
+module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
+.PHONY: $(module-dirs) modules
+$(module-dirs): crmodverdir
+	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
+ 
+modules: $(module-dirs)
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
@@ -967,7 +967,7 @@ modules: $(KBUILD_EXTMOD)
 modules_install:
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
 
-clean-dirs := _clean_$(KBUILD_EXTMOD)
+clean-dirs := $(addprefix _clean_,$(KBUILD_EXTMOD))
 
 .PHONY: $(clean-dirs) clean
 $(clean-dirs):


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


