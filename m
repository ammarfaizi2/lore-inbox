Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUCEVqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUCEVqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:46:47 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:36149 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261291AbUCEVqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:46:21 -0500
Date: Fri, 5 Mar 2004 22:48:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: clean on steroids
Message-ID: <20040305214842.GA14410@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew - please apply if you agree on the more effective version

Make the difference between 'make clean' and 'make distclean/mrproper'
more explicit.
make clean now removes all generated files except .config* and .version.
The result is much easier to understand now.

make clean deletes all generated files (except .config* and .version).
make mrproper deletes configuration and all temporary files left by
patch, editors and the like.

Example output:
> make mrproper
  CLEAN   init
  CLEAN   usr
  CLEAN   scripts/kconfig
  CLEAN   scripts
  CLEAN   .tmp_versions include/config
  CLEAN   include/asm-i386/asm_offsets.h include/linux/autoconf.h include/linux/version.h include/asm .tmp_versions
  CLEAN   .version .config

Form the list of files/directories deleted during make clean, removed all
references that is no longer relevant for the current kernel.

	Sam


kbuild-more-cleaning.patch
===== Makefile 1.461 vs edited =====
--- 1.461/Makefile	Thu Mar  4 07:08:06 2004
+++ edited/Makefile	Fri Mar  5 22:29:38 2004
@@ -757,26 +757,15 @@
 #                Any core files spread around are deleted as well
 # make distclean Remove editor backup files, patch leftover files and the like
 
-# Files removed with 'make clean'
-CLEAN_FILES += vmlinux System.map MC*
+# Directories & files removed with 'make clean'
+CLEAN_DIRS  += $(MODVERDIR) include/config include2
+CLEAN_FILES +=	vmlinux System.map \
+		include/linux/autoconf.h include/linux/version.h \
+		include/asm include/linux/modversions.h \
+		kernel.spec .tmp*
 
 # Files removed with 'make mrproper'
-MRPROPER_FILES += \
-	include/linux/autoconf.h include/linux/version.h \
-	.version .config .config.old config.in config.old \
-	.menuconfig.log \
-	include/asm \
-	.hdepend include/linux/modversions.h \
-	tags TAGS cscope* kernel.spec \
-	.tmp*
-
-# Directories removed with 'make mrproper'
-MRPROPER_DIRS += \
-	$(MODVERDIR) \
-	.tmp_export-objs \
-	include/config \
-	include/linux/modules \
-	include2
+MRPROPER_FILES += .version .config .config.old tags TAGS cscope*
 
 # clean - Delete all intermediate files
 #
@@ -785,28 +774,36 @@
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
-quiet_cmd_rmclean = RM  $$(CLEAN_FILES)
-cmd_rmclean	  = rm -f $(CLEAN_FILES)
+clean:		rm-dirs  := $(wildcard $(CLEAN_DIRS))
+mrproper:	rm-dirs  := $(wildcard $(MRPROPER_DIRS))
+quiet_cmd_rmdirs = $(if $(rm-dirs),CLEAN   $(rm-dirs))
+      cmd_rmdirs = rm -rf $(rm-dirs)
+
+clean:		rm-files := $(wildcard $(CLEAN_FILES))
+mrproper:	rm-files := $(wildcard $(MRPROPER_FILES))
+quiet_cmd_rmfiles = $(if $(rm-files),CLEAN   $(rm-files))
+      cmd_rmfiles = rm -rf $(rm-files)
+
 clean: archclean $(clean-dirs)
-	$(call cmd,rmclean)
+	$(call cmd,rmdirs)
+	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
 		-type f -print | xargs rm -f
 
-# mrproper - delete configuration + modules + core files
+# mrproper
 #
-quiet_cmd_mrproper = RM  $$(MRPROPER_DIRS) + $$(MRPROPER_FILES)
-cmd_mrproper = rm -rf $(MRPROPER_DIRS) && rm -f $(MRPROPER_FILES)
-mrproper distclean: clean archmrproper
-	@echo '  Making $@ in the srctree'
+distclean: mrproper
+mrproper: clean archmrproper
+	$(call cmd,rmdirs)
+	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
 	 	-o -name '.*.rej' -o -size 0 \
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
 		-type f -print | xargs rm -f
-	$(call cmd,mrproper)
 
 # Generate tags for editors
 # ---------------------------------------------------------------------------
