Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262146AbSJJTpu>; Thu, 10 Oct 2002 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSJJTpu>; Thu, 10 Oct 2002 15:45:50 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:29453 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262146AbSJJTpq>;
	Thu, 10 Oct 2002 15:45:46 -0400
Date: Thu, 10 Oct 2002 21:51:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: Distributed clean infrastructure
Message-ID: <20021010215131.A577@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021010213440.A508@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021010213440.A508@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Oct 10, 2002 at 09:34:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.748   -> 1.748.1.1
#	            Makefile	1.318   -> 1.319  
#	          Rules.make	1.81    -> 1.82   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	sam@mars.ravnborg.org	1.748.1.1
# kbuild: Distributed clean infrastructure
#   
# Today there is a huge list of files in the top-level Makefile that is
# deleted during make clean and make mrproper.
# This patch add infrastructure to get rid of this centralised list.
# 
# Within a makefile simply use:
# clean-files := files-to-be-deleted
# or eventually
# clean-rule := command to be executed to delete files
#   
# Files specified by host-progs and EXTRA_TARGETS are deleted during cleaning,
# and the same is all *.[oas] .*.cmd .*.tmp .*.d in the visited directories.
#   
# Deleting core files is moved down to mrporper time
# 
# Patches utilising this and the centralised list will dismiss.
# 
# Based on a concept originally made by Kai Germaschewski
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Thu Oct 10 21:50:03 2002
+++ b/Makefile	Thu Oct 10 21:50:03 2002
@@ -661,10 +661,15 @@
 defconfig:
 	yes '' | $(CONFIG_SHELL) $(src)/scripts/Configure -d arch/$(ARCH)/config.in
 
-# Cleaning up
-# ---------------------------------------------------------------------------
+###
+# Cleaning is done on three levels.
+# make clean     Delete all automatically generated files, including
+#                tools and firmware.
+# make mrproper  Delete the current configuration, and related files
+#                Any core files spread around is deleted as well
+# make distclean Remove editor backup files, patch leftover files and the like
 
-#	files removed with 'make clean'
+# Files removed with 'make clean'
 CLEAN_FILES += \
 	include/linux/compile.h \
 	vmlinux System.map \
@@ -690,7 +695,7 @@
 	net/khttpd/make_times_h net/khttpd/times.h \
 	submenu*
 
-# 	files removed with 'make mrproper'
+# Files removed with 'make mrproper'
 MRPROPER_FILES += \
 	include/linux/autoconf.h include/linux/version.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
@@ -712,33 +717,43 @@
 	tags TAGS kernel.spec \
 	.tmp*
 
-# 	directories removed with 'make mrproper'
+# Directories removed with 'make mrproper'
 MRPROPER_DIRS += \
 	.tmp_export-objs \
 	include/config \
 	include/linux/modules
 
-clean:	archclean
-	@echo 'Cleaning up'
-	@find . $(RCS_FIND_IGNORE) \
-		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
-		| grep -v lxdialog/ | xargs rm -f
-	@rm -f $(CLEAN_FILES)
-	+@$(call descend,Documentation/DocBook,clean)
-
+# clean - Delete all intermidiate files
+#
+clean-dirs += $(ALL_SUBDIRS) Documentation/DocBook
+cleanprint:
+	@echo '  Cleaning the srctree'
+
+$(addprefix _clean_,$(clean-dirs)): cleanprint
+	+@$(call descend,$(patsubst _clean_%,%,$@), subdirclean)
+
+quiet_cmd_rmclean = RM  $$(CLEAN_FILES)
+cmd_rmclean	  = rm -f $(CLEAN_FILES)
+clean: archclean $(addprefix _clean_,$(clean-dirs))
+	$(call cmd,rmclean)
+
+# mrproper - delete configuration + modules + core files
+#
+quiet_cmd_mrproper = RM  $$(MRPROPER_DIRS) + $$(MRPROPER_FILES)
+cmd_mrproper = rm -rf $(MRPROPER_DIRS) && rm -f $(MRPROPER_FILES)
 mrproper: clean archmrproper
-	@echo 'Making mrproper'
+	@echo '  Making mrproper in the srctree'
 	@find . $(RCS_FIND_IGNORE) \
-		\( -name .depend -o -name .\*.cmd \) \
+		\( -name .depend -o -name .\*.cmd -o -name core \) \
 		-type f -print | xargs rm -f
-	@rm -rf $(MRPROPER_DIRS)
-	@rm -f $(MRPROPER_FILES)
+	$(call cmd,mrproper)
 	+@$(call descend,scripts,mrproper)
 	+@$(call descend,Documentation/DocBook,mrproper)
 
+# distclean - remove all temporaries left behind by patch, vi, emacs etc.
+#
 distclean: mrproper
-	@echo 'Making distclean'
+	@echo '  Making distclean in the srctree'
 	@find . $(RCS_FIND_IGNORE) \
 		\( -not -type d \) -and \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Thu Oct 10 21:50:03 2002
+++ b/Rules.make	Thu Oct 10 21:50:03 2002
@@ -87,6 +87,7 @@
 # Subdirectories we need to descend into
 
 subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
+subdir-ymn      := $(sort $(subdir-ym) $(subdir-n) $(subdir-))
 
 # export.o is never a composite object, since $(export-objs) has a
 # fixed meaning (== objects which EXPORT_SYMBOL())
@@ -113,6 +114,10 @@
 # Only build module versions for files which are selected to be built
 export-objs := $(filter $(export-objs),$(real-objs-y) $(real-objs-m))
 
+host-progs-single     := $(foreach m,$(host-progs),$(if $($(m)-objs),,$(m)))
+host-progs-multi      := $(foreach m,$(host-progs),$(if $($(m)-objs),$(m)))
+host-progs-multi-objs := $(foreach m,$(host-progs-multi),$($(m)-objs))
+
 # Add subdir path
 
 EXTRA_TARGETS	:= $(addprefix $(obj)/,$(EXTRA_TARGETS))
@@ -127,12 +132,19 @@
 multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
 multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
+subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
+clean-files	:= $(addprefix $(obj)/,$(clean-files))
+host-progs	:= $(addprefix $(obj)/,$(host-progs))
+host-progs-single     := $(addprefix $(obj)/,$(host-progs-single))
+host-progs-multi      := $(addprefix $(obj)/,$(host-progs-multi))
+host-progs-multi-objs := $(addprefix $(obj)/,$(host-progs-multi-objs))
 
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
-# We're called for one of three purposes:
+# We're called for one of four purposes:
+# o subdirclean: Delete intermidiate files in the current directory
 # o fastdep: build module version files (.ver) for $(export-objs) in
 #   the current directory
 # o modules_install: install the modules in the current directory
@@ -142,6 +154,13 @@
 #   When targets are given directly (like foo.o), we just build these
 #   targets (That happens when someone does make some/dir/foo.[ois])
 
+ifeq ($(MAKECMDGOALS),subdirclean)
+subdirclean: $(subdir-ymn)
+	@/bin/true
+	@rm -f $(EXTRA_TARGETS) $(host-progs) $(clean-files) \
+        $(addprefix $(obj)/,*.[oas] .*.cmd .*.tmp .*.d)
+	@$(clean-rule)
+else
 ifeq ($(MAKECMDGOALS),fastdep)
 
 # ===========================================================================
@@ -399,14 +418,6 @@
 # Compile programs on the host
 # ===========================================================================
 
-host-progs-single     := $(foreach m,$(host-progs),$(if $($(m)-objs),,$(m)))
-host-progs-multi      := $(foreach m,$(host-progs),$(if $($(m)-objs),$(m)))
-host-progs-multi-objs := $(foreach m,$(host-progs-multi),$($(m)-objs))
-host-progs	      := $(addprefix $(obj)/,$(host-progs))
-host-progs-single     := $(addprefix $(obj)/,$(host-progs-single))
-host-progs-multi      := $(addprefix $(obj)/,$(host-progs-multi))
-host-progs-multi-objs := $(addprefix $(obj)/,$(host-progs-multi-objs))
-
 quiet_cmd_host_cc__c  = HOSTCC  $(echo_target)
 cmd_host_cc__c        = $(HOSTCC) -Wp,-MD,$(depfile) \
 			$(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
@@ -431,6 +442,7 @@
 
 targets += $(host-progs-single) $(host-progs-multi-objs) $(host-progs-multi) 
 
+endif # ! subdirclean
 endif # ! modules_install
 endif # ! fastdep
 
@@ -480,9 +492,9 @@
 # Descending
 # ---------------------------------------------------------------------------
 
-.PHONY: $(subdir-ym)
+.PHONY: $(subdir-ymn)
 
-$(subdir-ym):
+$(subdir-ymn):
 	+@$(call descend,$@,$(MAKECMDGOALS))
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
