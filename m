Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUDMGiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 02:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbUDMGiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 02:38:52 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:48675 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263435AbUDMGit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 02:38:49 -0400
Date: Tue, 13 Apr 2004 08:45:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Create .tmp_versions when building external modules
Message-ID: <20040413064549.GA2148@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus - please apply. People are hit by this oversight.

When building external modules the $PWD/.tmp_versions directory
is used. The .tmp_versions directory in the kernel tree cannot
be used because this would clutter up the kernel tree
especially when more than one external module is being build for the
same kernel tree.

This patch make sure to create $PWD/.tmp_versions, and to delete it
during make clean.
It also removes  warning about 'messed with SUBDIRS', this is no longer
relevant when .tmp_versions is made outside the kernel tree.

	Sam

--- linux-2.6.5/Makefile	2004-04-12 20:58:30.000000000 +0200
+++ extmod/Makefile	2004-04-12 20:46:24.000000000 +0200
@@ -787,12 +787,6 @@ endef
 # make mrproper  Delete the current configuration, and all generated files
 # make distclean Remove editor backup files, patch leftover files and the like
 
-quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
-      cmd_rmdirs = rm -rf $(rm-dirs)
-
-quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
-      cmd_rmfiles = rm -f $(rm-files)
-
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
 CLEAN_FILES +=	vmlinux System.map kernel.spec \
@@ -951,9 +945,12 @@ else # KBUILD_EXTMOD
 
 # We are always building modules
 KBUILD_MODULES := 1
+.PHONY: crmodverdir
+crmodverdir: FORCE
+	$(Q)mkdir -p $(MODVERDIR)
 
 .PHONY: $(KBUILD_EXTMOD)
-$(KBUILD_EXTMOD): FORCE
+$(KBUILD_EXTMOD): crmodverdir FORCE
 	$(Q)$(MAKE) $(build)=$@
 
 .PHONY: modules
@@ -971,7 +968,9 @@ clean-dirs := _clean_$(KBUILD_EXTMOD)
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
+clean:	rm-dirs := $(MODVERDIR)
 clean: $(clean-dirs)
+	$(call cmd,rmdirs)
 	@find $(KBUILD_EXTMOD) $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
@@ -1058,6 +1057,13 @@ endif #ifeq ($(mixed-targets),1)
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 
+quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
+      cmd_rmdirs = rm -rf $(rm-dirs)
+
+quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
+      cmd_rmfiles = rm -f $(rm-files)
+
+
 a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) \
 	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
--- linux-2.6.5/scripts/Makefile.modinst	2004-04-04 05:37:23.000000000 +0200
+++ extmod/scripts/Makefile.modinst	2004-04-13 08:41:15.000000000 +0200
@@ -12,10 +12,6 @@ include scripts/Makefile.lib
 __modules := $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
-ifneq ($(filter-out $(modules),$(__modules)),)
-  $(warning *** Uh-oh, you have stale module entries. You messed with SUBDIRS, do not complain if something goes wrong.)
-endif
-
 .PHONY: $(modules)
 __modinst: $(modules)
 	@:
