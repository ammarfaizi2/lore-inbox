Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbQKAMAN>; Wed, 1 Nov 2000 07:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbQKAMAD>; Wed, 1 Nov 2000 07:00:03 -0500
Received: from ns.caldera.de ([212.34.180.1]:13071 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129118AbQKAL7t>;
	Wed, 1 Nov 2000 06:59:49 -0500
Date: Wed, 1 Nov 2000 12:58:37 +0100
From: Christoph Hellwig <hch@caldera.de>
To: torvalds@transmeta.com
Cc: linux-kbuild@torque.net, linux-kernel@vger.kernel.org
Subject: [PATCH] list-style makefile boilerplate without reordering
Message-ID: <20001101125837.A28861@caldera.de>
Mail-Followup-To: torvalds@transmeta.com, linux-kbuild@torque.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patch creates a Makefile.inc that implements the new-style make rules
in a simmilar manner to your recent change to drivers/usb/Makefile but
preserves compatiblity to all list-style Makefile.  A compat Rules.make
that supports old Makefiles but uses Makefile.inc is also included.
Makefile.inc contains some hooks and kludges to support this.
This patch does only update the usb makefile, but I will send you a private
mail to update the others (it's over the lkml flame limit).

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.


diff -uNr --exclude-from=dontdiff linux.orig/Makefile.inc linux/Makefile.inc
--- linux.orig/Makefile.inc	Thu Jan  1 01:00:00 1970
+++ linux/Makefile.inc	Wed Nov  1 12:21:34 2000
@@ -0,0 +1,304 @@
+#
+# Makefile.inc: common makefile for inclusion in subdirectory makefiles
+#
+# 31 October 2000, Christoph Hellwig <hch@caldera.de>
+# Created using Rule.make and subdirectory makefile fragments
+#
+
+
+# false targets.
+.PHONY: dummy
+
+
+# include a local makefile, if present
+-include Makefile.local
+
+
+ifndef rules-make-included
+
+# add directories in mod-subdirs to subdir-m
+both-m		:= $(filter $(mod-subdirs), $(subdir-y))
+subdir-m	:= $(sort $(subdir-m) $(both-m))
+
+# all-subdirs contains all subdirectories
+all-subdirs	:= $(sort $(subdir-y) $(subdir-m) $(subdir-n) $(subdir-))
+
+# extract lists of the multi-part drivers.
+# the 'int-*' lists are the intermediate files used to build the multi's.
+all-multi	:= $(filter $(list-multi), $(obj-y) $(obj-m))
+all-int		:= $(sort $(foreach m, $(all-multi), $($(basename $(m))-objs)))
+
+# Files that are both resident and modular: remove from modular.
+obj-m		:= $(filter-out $(obj-y), $(obj-m))
+
+# all-objs is a list of all selected objects
+all-objs	:= $(sort $(obj-y) $(obj-m) $(all-multi))
+
+# modules that export modules and are actually selected
+symtab-objs	:= $(filter $(export-objs), $(all-objs))
+
+endif # rules-make-included
+
+# get things started.
+first_rule: sub_dirs
+	$(MAKE) all_targets
+
+
+#
+# common rules
+#
+
+%.s: %.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -S $< -o $@
+
+%.i: %.c
+	$(CPP) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) $< > $@
+
+%.o: %.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -c -o $@ $<
+	@ ( \
+	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@))),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@))))' ; \
+	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
+	    echo 'endif' \
+	) > $(dir $@)/.$(notdir $@).flags
+
+%.o: %.s
+	$(AS) $(AFLAGS) $(EXTRA_CFLAGS) -o $@ $<
+
+# Old makefiles define their own rules for compiling .S files,
+# but these standard rules are available for any Makefile that
+# wants to use them.  Our plan is to incrementally convert all
+# the Makefiles to these standard rules.  -- rmk, mec
+ifdef USE_STANDARD_AS_RULE
+
+%.s: %.S
+	$(CPP) $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$@) $< > $@
+
+%.o: %.S
+	$(CC) $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$@) -c -o $@ $<
+
+endif
+
+%.lst: %.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -g -c -o $*.o $<
+	$(TOPDIR)/scripts/makelst $* $(TOPDIR) $(OBJDUMP)
+
+
+# L_TARGET is a hack for the compat Rules.make
+all_targets: $(O_TARGET) $(L_TARGET)
+
+
+# Rule to compile a set of .o files into one .o file
+$(O_TARGET): $(obj-y)
+	rm -f $@
+    ifneq "$(strip $(obj-y))" ""
+	$(LD) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(obj-y), $^)
+    else
+	$(AR) rcs $@ $(filter $(obj-y), $^)
+    endif
+	@ ( \
+	    echo 'ifeq ($(strip $(subst $(comma),:,$(EXTRA_LDFLAGS) $(obj-y))),$$(strip $$(subst $$(comma),:,$$(EXTRA_LDFLAGS) $$(obj-y))))' ; \
+	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
+	    echo 'endif' \
+	) > $(dir $@)/.$(notdir $@).flags
+
+
+# this make dependencies (not that ...) quickly
+fastdep: dummy
+	$(TOPDIR)/scripts/mkdep $(wildcard *.[chS] local.h.master) > .depend
+ifdef all-subdirs
+	$(MAKE) $(patsubst %,_sfdep_%,$(all-subdirs)) _FASTDEP_ALL_SUB_DIRS="$(all-subdirs)"
+endif
+
+ifdef _FASTDEP_ALL_SUB_DIRS
+$(patsubst %,_sfdep_%,$(_FASTDEP_ALL_SUB_DIRS)):
+	$(MAKE) -C $(patsubst _sfdep_%,%,$@) fastdep
+endif
+
+	
+# a rule to make subdirectories
+sub_dirs: dummy $(patsubst %,_subdir_%,$(subdir-y))
+
+ifdef subdir-y
+$(patsubst %,_subdir_%,$(subdir-y)) : dummy
+	$(MAKE) -C $(patsubst _subdir_%,%,$@)
+endif
+
+
+# a rule to make modules
+ifneq "$(strip $(obj-m))" ""
+PDWN=$(shell $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
+endif
+
+ifneq "$(strip $(subdir-m))" ""
+.PHONY: $(patsubst %,_modsubdir_%,$(subdir-m))
+$(patsubst %,_modsubdir_%,$(subdir-m)) : dummy
+	$(MAKE) -C $(patsubst _modsubdir_%,%,$@) modules
+
+.PHONY: $(patsubst %,_modinst_%,$(subdir-m))
+$(patsubst %,_modinst_%,$(subdir-m)) : dummy
+	$(MAKE) -C $(patsubst _modinst_%,%,$@) modules_install
+endif
+
+.PHONY: modules
+modules: $(obj-m) dummy \
+	$(patsubst %,_modsubdir_%,$(subdir-m))
+
+.PHONY: _modinst__
+_modinst__: dummy
+ifneq "$(strip $(obj-m))" ""
+	mkdir -p $(MODLIB)/kernel/$(PDWN)
+	cp $(obj-m) $(MODLIB)/kernel/$(PDWN)
+endif
+
+.PHONY: modules_install
+modules_install: _modinst__ \
+	 $(patsubst %,_modinst_%,$(subdir-m))
+
+
+# a rule to do nothing
+dummy:
+
+
+# this is useful for testing
+script:
+	$(SCRIPT)
+
+
+#
+# This sets version suffixes on exported symbols
+# Uses SYMTAB_OBJS
+# Separate the object into "normal" objects and "exporting" objects
+# Exporting objects are: all objects that define symbol tables
+#
+ifdef CONFIG_MODULES
+ifdef CONFIG_MODVERSIONS
+ifneq "$(strip $(symtab-objs))" ""
+
+MODINCL = $(TOPDIR)/include/linux/modules
+
+#
+# The -w option (enable warnings) for genksyms will return here in 2.1
+# So where has it gone?
+#
+# Added the SMP separator to stop module accidents between uniprocessor
+# and SMP Intel boxes - AC - from bits by Michael Chastain
+#
+ifdef CONFIG_SMP
+	genksyms_smp_prefix := -p smp_
+else
+	genksyms_smp_prefix := 
+endif
+
+$(MODINCL)/%.ver: %.c
+	@if [ ! -r $(MODINCL)/$*.stamp -o $(MODINCL)/$*.stamp -ot $< ]; then \
+		echo '$(CC) $(CFLAGS) -E -D__GENKSYMS__ $<'; \
+		echo '| $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp'; \
+		$(CC) $(CFLAGS) -E -D__GENKSYMS__ $< \
+		| $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp; \
+		if [ -r $@ ] && cmp -s $@ $@.tmp; then echo $@ is unchanged; rm -f $@.tmp; \
+		else echo mv $@.tmp $@; mv -f $@.tmp $@; fi; \
+	fi; touch $(MODINCL)/$*.stamp
+	
+$(addprefix $(MODINCL)/,$(symtab-objs:.o=.ver)): $(TOPDIR)/include/linux/autoconf.h
+
+# updates .ver files but not modversions.h
+fastdep: $(addprefix $(MODINCL)/,$(symtab-objs:.o=.ver))
+
+# updates .ver files and modversions.h like before (is this needed?)
+dep: fastdep update-modverfile
+
+endif # symtab-objs
+
+
+# update modversions.h, but only if it would change
+update-modverfile:
+	@(echo "#ifndef _LINUX_MODVERSIONS_H";\
+	  echo "#define _LINUX_MODVERSIONS_H"; \
+	  echo "#include <linux/modsetver.h>"; \
+	  cd $(TOPDIR)/include/linux/modules; \
+	  for f in *.ver; do \
+	    if [ -f $$f ]; then echo "#include <linux/modules/$${f}>"; fi; \
+	  done; \
+	  echo "#endif"; \
+	) > $(TOPDIR)/include/linux/modversions.h.tmp
+	@if [ -r $(TOPDIR)/include/linux/modversions.h ] && cmp -s $(TOPDIR)/include/linux/modversions.h $(TOPDIR)/include/linux/modversions.h.tmp; then \
+		echo $(TOPDIR)/include/linux/modversions.h was not updated; \
+		rm -f $(TOPDIR)/include/linux/modversions.h.tmp; \
+	else \
+		echo $(TOPDIR)/include/linux/modversions.h was updated; \
+		mv -f $(TOPDIR)/include/linux/modversions.h.tmp $(TOPDIR)/include/linux/modversions.h; \
+	fi
+
+# this was only M_OBJS before, but it shouldn't matter  -- hch
+$(obj-m): $(TOPDIR)/include/linux/modversions.h
+
+# kludge for compat Rules.make
+ifdef rule-make-included
+ifdef MAKING_MODULES
+$(O_OBJS) $(L_OBJS): $(TOPDIR)/include/linux/modversions.h
+endif
+endif
+
+else
+
+$(TOPDIR)/include/linux/modversions.h:
+	@echo "#include <linux/modsetver.h>" > $@
+
+endif # CONFIG_MODVERSIONS
+
+ifneq "$(strip $(symtab-objs))" ""
+$(symtab-objs): $(symtab-objs:.o=.c) $(TOPDIR)/include/linux/modversions.h
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB -c $(@:.o=.c)
+	@ ( \
+	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB)),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@) -DEXPORT_SYMTAB)))' ; \
+	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
+	    echo 'endif' \
+	) > $(dir $@)/.$(notdir $@).flags
+endif
+endif # CONFIG_MODULES
+
+
+# include dependency files if they exist
+ifneq ($(wildcard .depend),)
+include .depend
+endif
+
+ifneq ($(wildcard $(TOPDIR)/.hdepend),)
+include $(TOPDIR)/.hdepend
+endif
+
+#
+# Find files whose flags have changed and force recompilation.
+# For safety, this works in the converse direction:
+#   every file is forced, except those whose flags are positively up-to-date.
+#
+FILES_FLAGS_UP_TO_DATE :=
+
+# For use in expunging commas from flags, which mung our checking.
+comma = ,
+
+FILES_FLAGS_EXIST := $(wildcard .*.flags)
+ifneq ($(FILES_FLAGS_EXIST),)
+include $(FILES_FLAGS_EXIST)
+endif
+
+# the L_ veriables are kludges for compat Rules.make
+FILES_FLAGS_CHANGED := $(strip \
+    $(filter-out $(FILES_FLAGS_UP_TO_DATE), \
+	$(O_TARGET) $(obj-y) $(obj-m) $(all-int) \
+	$(L_TARGET) $(L_OBJS) $(LX_OBJS) \
+	))
+
+# A kludge: .S files don't get flag dependencies (yet),
+#   because that will involve changing a lot of Makefiles.  Also
+#   suppress object files explicitly listed in $(IGNORE_FLAGS_OBJS).
+#   This allows handling of assembly files that get translated into
+#   multiple object files (see arch/ia64/lib/idiv.S, for example).
+FILES_FLAGS_CHANGED := $(strip \
+    $(filter-out $(patsubst %.S, %.o, $(wildcard *.S) $(IGNORE_FLAGS_OBJS)), \
+    $(FILES_FLAGS_CHANGED)))
+
+ifneq ($(FILES_FLAGS_CHANGED),)
+$(FILES_FLAGS_CHANGED): dummy
+endif
diff -uNr --exclude-from=dontdiff linux.orig/Rules.make linux/Rules.make
--- linux.orig/Rules.make	Thu Oct 19 13:21:15 2000
+++ linux/Rules.make	Wed Nov  1 12:22:10 2000
@@ -1,108 +1,26 @@
 #
-# This file contains rules which are shared between multiple Makefiles.
+# Rules.make: compat wrapper for inclusion in old-style makefiles
 #
-
-#
-# False targets.
+# 31 October 2000, Christoph Hellwig <hch@caldera.de>
+# Created.
 #
-.PHONY: dummy
 
-#
-# Special variables which should not be exported
-#
-unexport EXTRA_AFLAGS
-unexport EXTRA_CFLAGS
-unexport EXTRA_LDFLAGS
-unexport EXTRA_ARFLAGS
-unexport SUBDIRS
-unexport SUB_DIRS
-unexport ALL_SUB_DIRS
-unexport MOD_SUB_DIRS
-unexport O_TARGET
-unexport O_OBJS
-unexport L_OBJS
-unexport M_OBJS
-# intermediate objects that form part of a module
-unexport MI_OBJS
-unexport ALL_MOBJS
-# objects that export symbol tables
-unexport OX_OBJS
-unexport LX_OBJS
-unexport MX_OBJS
-unexport MIX_OBJS
-unexport SYMTAB_OBJS
+export-objs	:= $(OX_OBJS) $(LX_OBJS) $(MX_OBJS)
 
-#
-# Get things started.
-#
-first_rule: sub_dirs
-	$(MAKE) all_targets
+obj-y		:= $(OX_OBJS) $(O_OBJS)
+obj-m		:= $(MX_OBJS) $(M_OBJS)
 
-#
-# Common rules
-#
+all-int		:= $(MIX_OBJ) $(MI_OBJS)
 
-%.s: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -S $< -o $@
+subdir-y	:= $(SUB_DIRS)
+subdir-m	:= $(MOD_SUB_DIRS) $(MOD_IN_SUB_DIRS)
+all-subdirs	:= $(ALL_SUB_DIRS)
 
-%.i: %.c
-	$(CPP) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) $< > $@
+rules-make-included := 1
 
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -c -o $@ $<
-	@ ( \
-	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@))),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@))))' ; \
-	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
-	    echo 'endif' \
-	) > $(dir $@)/.$(notdir $@).flags
-
-%.o: %.s
-	$(AS) $(AFLAGS) $(EXTRA_CFLAGS) -o $@ $<
-
-# Old makefiles define their own rules for compiling .S files,
-# but these standard rules are available for any Makefile that
-# wants to use them.  Our plan is to incrementally convert all
-# the Makefiles to these standard rules.  -- rmk, mec
-ifdef USE_STANDARD_AS_RULE
-
-%.s: %.S
-	$(CPP) $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$@) $< > $@
-
-%.o: %.S
-	$(CC) $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$@) -c -o $@ $<
-
-endif
-
-%.lst: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -g -c -o $*.o $<
-	$(TOPDIR)/scripts/makelst $* $(TOPDIR) $(OBJDUMP)
-#
-#
-#
-all_targets: $(O_TARGET) $(L_TARGET)
-
-#
-# Rule to compile a set of .o files into one .o file
-#
-ifdef O_TARGET
-ALL_O = $(OX_OBJS) $(O_OBJS)
-$(O_TARGET): $(ALL_O)
-	rm -f $@
-    ifneq "$(strip $(ALL_O))" ""
-	$(LD) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(ALL_O), $^)
-    else
-	$(AR) rcs $@ $(filter $(ALL_O), $^)
-    endif
-	@ ( \
-	    echo 'ifeq ($(strip $(subst $(comma),:,$(EXTRA_LDFLAGS) $(ALL_O))),$$(strip $$(subst $$(comma),:,$$(EXTRA_LDFLAGS) $$(ALL_O))))' ; \
-	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
-	    echo 'endif' \
-	) > $(dir $@)/.$(notdir $@).flags
-endif # O_TARGET
+include $(TOPDIR)/Makefile.inc
 
-#
-# Rule to compile a set of .o files into one .a file
-#
+# rule to compile a set of .o files into one .a file
 ifdef L_TARGET
 $(L_TARGET): $(LX_OBJS) $(L_OBJS)
 	rm -f $@
@@ -112,214 +30,4 @@
 	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
 	    echo 'endif' \
 	) > $(dir $@)/.$(notdir $@).flags
-endif
-
-#
-# This make dependencies quickly
-#
-fastdep: dummy
-	$(TOPDIR)/scripts/mkdep $(wildcard *.[chS] local.h.master) > .depend
-ifdef ALL_SUB_DIRS
-	$(MAKE) $(patsubst %,_sfdep_%,$(ALL_SUB_DIRS)) _FASTDEP_ALL_SUB_DIRS="$(ALL_SUB_DIRS)"
-endif
-
-ifdef _FASTDEP_ALL_SUB_DIRS
-$(patsubst %,_sfdep_%,$(_FASTDEP_ALL_SUB_DIRS)):
-	$(MAKE) -C $(patsubst _sfdep_%,%,$@) fastdep
-endif
-
-	
-#
-# A rule to make subdirectories
-#
-sub_dirs: dummy $(patsubst %,_subdir_%,$(SUB_DIRS))
-
-ifdef SUB_DIRS
-$(patsubst %,_subdir_%,$(SUB_DIRS)) : dummy
-	$(MAKE) -C $(patsubst _subdir_%,%,$@)
-endif
-
-#
-# A rule to make modules
-#
-ALL_MOBJS = $(MX_OBJS) $(M_OBJS)
-ifneq "$(strip $(ALL_MOBJS))" ""
-PDWN=$(shell $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
-endif
-
-unexport MOD_DIRS
-MOD_DIRS := $(MOD_SUB_DIRS) $(MOD_IN_SUB_DIRS)
-ifneq "$(strip $(MOD_DIRS))" ""
-.PHONY: $(patsubst %,_modsubdir_%,$(MOD_DIRS))
-$(patsubst %,_modsubdir_%,$(MOD_DIRS)) : dummy
-	$(MAKE) -C $(patsubst _modsubdir_%,%,$@) modules
-
-.PHONY: $(patsubst %,_modinst_%,$(MOD_DIRS))
-$(patsubst %,_modinst_%,$(MOD_DIRS)) : dummy
-	$(MAKE) -C $(patsubst _modinst_%,%,$@) modules_install
-endif
-
-.PHONY: modules
-modules: $(ALL_MOBJS) $(MIX_OBJS) $(MI_OBJS) dummy \
-	 $(patsubst %,_modsubdir_%,$(MOD_DIRS))
-
-.PHONY: _modinst__
-_modinst__: dummy
-ifneq "$(strip $(ALL_MOBJS))" ""
-	mkdir -p $(MODLIB)/kernel/$(PDWN)
-	cp $(ALL_MOBJS) $(MODLIB)/kernel/$(PDWN)
-endif
-
-.PHONY: modules_install
-modules_install: _modinst__ \
-	 $(patsubst %,_modinst_%,$(MOD_DIRS))
-
-#
-# A rule to do nothing
-#
-dummy:
-
-#
-# This is useful for testing
-#
-script:
-	$(SCRIPT)
-
-#
-# This sets version suffixes on exported symbols
-# Uses SYMTAB_OBJS
-# Separate the object into "normal" objects and "exporting" objects
-# Exporting objects are: all objects that define symbol tables
-#
-ifdef CONFIG_MODULES
-
-SYMTAB_OBJS = $(LX_OBJS) $(OX_OBJS) $(MX_OBJS) $(MIX_OBJS)
-
-ifdef CONFIG_MODVERSIONS
-ifneq "$(strip $(SYMTAB_OBJS))" ""
-
-MODINCL = $(TOPDIR)/include/linux/modules
-
-# The -w option (enable warnings) for genksyms will return here in 2.1
-# So where has it gone?
-#
-# Added the SMP separator to stop module accidents between uniprocessor
-# and SMP Intel boxes - AC - from bits by Michael Chastain
-#
-
-ifdef CONFIG_SMP
-	genksyms_smp_prefix := -p smp_
-else
-	genksyms_smp_prefix := 
-endif
-
-$(MODINCL)/%.ver: %.c
-	@if [ ! -r $(MODINCL)/$*.stamp -o $(MODINCL)/$*.stamp -ot $< ]; then \
-		echo '$(CC) $(CFLAGS) -E -D__GENKSYMS__ $<'; \
-		echo '| $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp'; \
-		$(CC) $(CFLAGS) -E -D__GENKSYMS__ $< \
-		| $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp; \
-		if [ -r $@ ] && cmp -s $@ $@.tmp; then echo $@ is unchanged; rm -f $@.tmp; \
-		else echo mv $@.tmp $@; mv -f $@.tmp $@; fi; \
-	fi; touch $(MODINCL)/$*.stamp
-	
-$(addprefix $(MODINCL)/,$(SYMTAB_OBJS:.o=.ver)): $(TOPDIR)/include/linux/autoconf.h
-
-# updates .ver files but not modversions.h
-fastdep: $(addprefix $(MODINCL)/,$(SYMTAB_OBJS:.o=.ver))
-
-# updates .ver files and modversions.h like before (is this needed?)
-dep: fastdep update-modverfile
-
-endif # SYMTAB_OBJS 
-
-# update modversions.h, but only if it would change
-update-modverfile:
-	@(echo "#ifndef _LINUX_MODVERSIONS_H";\
-	  echo "#define _LINUX_MODVERSIONS_H"; \
-	  echo "#include <linux/modsetver.h>"; \
-	  cd $(TOPDIR)/include/linux/modules; \
-	  for f in *.ver; do \
-	    if [ -f $$f ]; then echo "#include <linux/modules/$${f}>"; fi; \
-	  done; \
-	  echo "#endif"; \
-	) > $(TOPDIR)/include/linux/modversions.h.tmp
-	@if [ -r $(TOPDIR)/include/linux/modversions.h ] && cmp -s $(TOPDIR)/include/linux/modversions.h $(TOPDIR)/include/linux/modversions.h.tmp; then \
-		echo $(TOPDIR)/include/linux/modversions.h was not updated; \
-		rm -f $(TOPDIR)/include/linux/modversions.h.tmp; \
-	else \
-		echo $(TOPDIR)/include/linux/modversions.h was updated; \
-		mv -f $(TOPDIR)/include/linux/modversions.h.tmp $(TOPDIR)/include/linux/modversions.h; \
-	fi
-
-$(M_OBJS): $(TOPDIR)/include/linux/modversions.h
-ifdef MAKING_MODULES
-$(O_OBJS) $(L_OBJS): $(TOPDIR)/include/linux/modversions.h
-endif
-
-else
-
-$(TOPDIR)/include/linux/modversions.h:
-	@echo "#include <linux/modsetver.h>" > $@
-
-endif # CONFIG_MODVERSIONS
-
-ifneq "$(strip $(SYMTAB_OBJS))" ""
-$(SYMTAB_OBJS): $(SYMTAB_OBJS:.o=.c) $(TOPDIR)/include/linux/modversions.h
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB -c $(@:.o=.c)
-	@ ( \
-	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB)),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@) -DEXPORT_SYMTAB)))' ; \
-	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
-	    echo 'endif' \
-	) > $(dir $@)/.$(notdir $@).flags
-endif
-
-endif # CONFIG_MODULES
-
-
-#
-# include dependency files if they exist
-#
-ifneq ($(wildcard .depend),)
-include .depend
-endif
-
-ifneq ($(wildcard $(TOPDIR)/.hdepend),)
-include $(TOPDIR)/.hdepend
-endif
-
-#
-# Find files whose flags have changed and force recompilation.
-# For safety, this works in the converse direction:
-#   every file is forced, except those whose flags are positively up-to-date.
-#
-FILES_FLAGS_UP_TO_DATE :=
-
-# For use in expunging commas from flags, which mung our checking.
-comma = ,
-
-FILES_FLAGS_EXIST := $(wildcard .*.flags)
-ifneq ($(FILES_FLAGS_EXIST),)
-include $(FILES_FLAGS_EXIST)
-endif
-
-FILES_FLAGS_CHANGED := $(strip \
-    $(filter-out $(FILES_FLAGS_UP_TO_DATE), \
-	$(O_TARGET) $(O_OBJS) $(OX_OBJS) \
-	$(L_TARGET) $(L_OBJS) $(LX_OBJS) \
-	$(M_OBJS) $(MX_OBJS) \
-	$(MI_OBJS) $(MIX_OBJS) \
-	))
-
-# A kludge: .S files don't get flag dependencies (yet),
-#   because that will involve changing a lot of Makefiles.  Also
-#   suppress object files explicitly listed in $(IGNORE_FLAGS_OBJS).
-#   This allows handling of assembly files that get translated into
-#   multiple object files (see arch/ia64/lib/idiv.S, for example).
-FILES_FLAGS_CHANGED := $(strip \
-    $(filter-out $(patsubst %.S, %.o, $(wildcard *.S) $(IGNORE_FLAGS_OBJS)), \
-    $(FILES_FLAGS_CHANGED)))
-
-ifneq ($(FILES_FLAGS_CHANGED),)
-$(FILES_FLAGS_CHANGED): dummy
 endif
diff -uNr --exclude-from=dontdiff linux.orig/drivers/usb/Makefile linux/drivers/usb/Makefile
--- linux.orig/drivers/usb/Makefile	Wed Nov  1 11:34:30 2000
+++ linux/drivers/usb/Makefile	Wed Nov  1 11:40:08 2000
@@ -2,17 +2,9 @@
 # Makefile for the kernel USB device drivers.
 #
 
-# Subdirs.
-
-SUB_DIRS	:=
-MOD_SUB_DIRS	:= $(SUB_DIRS)
-ALL_SUB_DIRS	:= $(SUB_DIRS) serial storage
-
 # The target object and module list name.
 
-O_TARGET	:= usbdrv.o
-M_OBJS		:=
-O_OBJS		:=
+O_TARGET		:= usbdrv.o
 
 # Objects that export symbols.
 
@@ -68,36 +60,20 @@
 
 # Object files in subdirectories
 
+subdir-$(CONFIG_USB_SERIAL)	+= serial
+subdir-$(CONFIG_USB_STORAGE)	+= storage
+
 ifeq ($(CONFIG_USB_SERIAL),y)
-	SUB_DIRS += serial
 	obj-y += serial/usb-serial.o
-else
-	ifeq ($(CONFIG_USB_SERIAL),m)
-		MOD_SUB_DIRS += serial
-	endif
 endif
 
 ifeq ($(CONFIG_USB_STORAGE),y)
-	SUB_DIRS += storage
 	obj-y += storage/storage.o
-else
-	ifeq ($(CONFIG_USB_STORAGE),m)
-		MOD_SUB_DIRS += storage
-	endif
 endif
 
-# Translate to Rules.make lists.
-multi-used	:= $(filter $(list-multi), $(obj-y) $(obj-m))
-multi-objs	:= $(foreach m, $(multi-used), $($(basename $(m))-objs))
-active-objs	:= $(sort $(multi-objs) $(obj-y) $(obj-m))
-
-O_OBJS		:= $(obj-y)
-M_OBJS		:= $(obj-m)
-MIX_OBJS	:= $(filter $(export-objs), $(active-objs))
-
-# The global Rules.make.
+# The global Makefile.inc
 
-include $(TOPDIR)/Rules.make
+include $(TOPDIR)/Makefile.inc
 
 # Link rules for multi-part drivers.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
