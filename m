Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUDISnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUDISnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:43:42 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:7469 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261582AbUDISni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:43:38 -0400
Date: Fri, 9 Apr 2004 20:48:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: cleaning in three steps
Message-ID: <20040409184852.GA23602@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously 'make clean' deleted all automatically generated files.
The following patch revert this behaviour, and now 'make clean'
leaves enough behind to allow external modules to be built.

The cleaning is now done in three steps:

make clean     - delete everything not needed for building external modules
make mrproper  - delete all generated files, including .config
make distclean - delete all temporary files such as *.orig, *~, *.rej etc.

This fixes reports about nvidia and wmware build issues.

--- linux-2.6.5/Makefile	2004-04-09 14:03:35.000000000 +0200
+++ mm3/Makefile	2004-04-09 20:42:47.000000000 +0200
@@ -767,39 +767,39 @@ endef
 
 ###
 # Cleaning is done on three levels.
-# make clean     Delete all automatically generated files, including
-#                tools and firmware.
-# make mrproper  Delete the current configuration, and related files
-#                Any core files spread around are deleted as well
+# make clean     Delete most generated files
+#                Leave enough to build external modules
+# make mrproper  Delete the current configuration, and all generated files
 # make distclean Remove editor backup files, patch leftover files and the like
 
-# Directories & files removed with 'make clean'
-CLEAN_DIRS  += $(MODVERDIR) include/config include2
-CLEAN_FILES +=	vmlinux System.map \
-		include/linux/autoconf.h include/linux/version.h \
-		include/asm include/linux/modversions.h \
-		kernel.spec .tmp*
+quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
+      cmd_rmdirs = rm -rf $(rm-dirs)
 
-# Files removed with 'make mrproper'
-MRPROPER_FILES += .version .config .config.old tags TAGS cscope*
+quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
+      cmd_rmfiles = rm -f $(rm-files)
+
+# Directories & files removed with 'make clean'
+CLEAN_DIRS  += $(MODVERDIR)
+CLEAN_FILES +=	vmlinux System.map kernel.spec \
+                .tmp_kallsyms* .tmp_version .tmp_vmlinux*
+
+# Directories & files removed with 'make mrproper'
+MRPROPER_DIRS  += include/config include2
+MRPROPER_FILES += .config .config.old include/asm .version \
+                  include/linux/autoconf.h include/linux/version.h \
+                  include/linux/modversions.h \
+                  tags TAGS cscope*
 
-# clean - Delete all intermediate files
+# clean - Delete most, but leave enough to build external modules
 #
-clean-dirs += $(addprefix _clean_,$(ALL_SUBDIRS) Documentation/DocBook scripts)
-.PHONY: $(clean-dirs) clean archclean mrproper archmrproper distclean
+clean: rm-dirs  := $(CLEAN_DIRS)
+clean: rm-files := $(CLEAN_FILES)
+clean-dirs      := $(addprefix _clean_,$(ALL_SUBDIRS))
+
+.PHONY: $(clean-dirs) clean archclean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
-clean:		rm-dirs  := $(wildcard $(CLEAN_DIRS))
-mrproper:	rm-dirs  := $(wildcard $(MRPROPER_DIRS))
-quiet_cmd_rmdirs = $(if $(rm-dirs),CLEAN   $(rm-dirs))
-      cmd_rmdirs = rm -rf $(rm-dirs)
-
-clean:		rm-files := $(wildcard $(CLEAN_FILES))
-mrproper:	rm-files := $(wildcard $(MRPROPER_FILES))
-quiet_cmd_rmfiles = $(if $(rm-files),CLEAN   $(rm-files))
-      cmd_rmfiles = rm -rf $(rm-files)
-
 clean: archclean $(clean-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
@@ -808,12 +808,25 @@ clean: archclean $(clean-dirs)
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
 		-type f -print | xargs rm -f
 
-# mrproper
+# mrproper - Delete all generated files, including .config
 #
-distclean: mrproper
-mrproper: clean archmrproper
+mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
+mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
+mrproper-dirs      := $(addprefix _mrproper_,Documentation/DocBook scripts)
+
+.PHONY: $(mrproper-dirs) mrproper archmrproper
+$(mrproper-dirs):
+	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
+
+mrproper: clean archmrproper $(mrproper-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
+
+# distclean
+#
+.PHONY: distclean
+
+distclean: mrproper
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
