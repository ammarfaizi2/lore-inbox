Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWAVV2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWAVV2P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWAVV2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:28:15 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:16140 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751368AbWAVV2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:28:14 -0500
Date: Sun, 22 Jan 2006 22:28:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH] kbuild: support building individual files for external modules
Message-ID: <20060122212814.GA14113@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch implement support for building individual files when
dealing with separate modules.
So say you have a module named "foo" wich consist of two .o files bar.o
and fun.o.

You can then do
make -C $KERNELSRC M=`pwd` bar.o
make -C $KERNELSRC M=`pwd` bar.lst
make -C $KERNELSRC M=`pwd` bar.i
make -C $KERNELSRC M=`pwd` /            <= will build all .o files
make -C $KERNELSRC M=`pwd` foo.ko       <= will build the module
                                           and do the modpost step

The above will also work if the external module is placed in a
subdirectory using a hirachy of kbuild files.
Thanks to Andreas Gruenbacher <agruen@suse.de> for initial feature
request / bug report.

	Sam
	
diff --git a/Makefile b/Makefile
index da3c528..f387164 100644
--- a/Makefile
+++ b/Makefile
@@ -138,7 +138,7 @@ objtree		:= $(CURDIR)
 src		:= $(srctree)
 obj		:= $(objtree)
 
-VPATH		:= $(srctree)
+VPATH		:= $(srctree):$(KBUILD_EXTMOD)
 
 export srctree objtree VPATH TOPDIR
 
@@ -818,27 +818,6 @@ prepare prepare-all: prepare0
 
 export CPPFLAGS_vmlinux.lds += -P -C -U$(ARCH)
 
-# Single targets
-# ---------------------------------------------------------------------------
-
-%.s: %.c scripts FORCE
-	$(Q)$(MAKE) $(build)=$(@D) $@
-%.i: %.c scripts FORCE
-	$(Q)$(MAKE) $(build)=$(@D) $@
-%.o: %.c scripts FORCE
-	$(Q)$(MAKE) $(build)=$(@D) $@
-%.ko: scripts FORCE
-	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) $(build)=$(@D) $(@:.ko=.o)
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
-%/:      scripts prepare FORCE
-	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) $(build)=$(@D)
-%.lst: %.c scripts FORCE
-	$(Q)$(MAKE) $(build)=$(@D) $@
-%.s: %.S scripts FORCE
-	$(Q)$(MAKE) $(build)=$(@D) $@
-%.o: %.S scripts FORCE
-	$(Q)$(MAKE) $(build)=$(@D) $@
-
 # 	FIXME: The asm symlink changes when $(ARCH) changes. That's
 #	hard to detect, but I suppose "make mrproper" is a good idea
 #	before switching between archs anyway.
@@ -1161,6 +1140,11 @@ help:
 	@echo  '  modules_install - install the module'
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
+
+# Dummies...
+.PHONY: prepare scripts
+prepare: ;
+scripts: ;
 endif # KBUILD_EXTMOD
 
 # Generate tags for editors
@@ -1282,6 +1266,44 @@ kernelrelease:
 kernelversion:
 	@echo $(KERNELVERSION)
 
+# Single targets
+# ---------------------------------------------------------------------------
+# The directory part is taken from first prerequisite, so this
+# works even with external modules
+%.s: %.c scripts FORCE
+	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+%.i: %.c scripts FORCE
+	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+%.o: %.c scripts FORCE
+	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+%.lst: %.c scripts FORCE
+	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+%.s: %.S scripts FORCE
+	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+%.o: %.S scripts FORCE
+	$(Q)$(MAKE) $(build)=$(dir $<) $(dir $<)$(notdir $@)
+
+# For external modules we shall include any directory of the target,
+# but usual case there is no directory part.
+# make M=`pwd` module.o     => $(dir $@)=./
+# make M=`pwd` foo/module.o => $(dir $@)=foo/
+# make M=`pwd` /            => $(dir $@)=/
+ 
+ifeq ($(KBUILD_EXTMOD),)
+        target-dir = $(@D)
+else
+        zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
+        target-dir = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
+endif
+
+/ %/:      scripts prepare FORCE
+	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
+	$(build)=$(target-dir)
+%.ko: scripts FORCE
+	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
+	$(build)=$(target-dir) $(@:.ko=.o)
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
+
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 
@@ -1316,4 +1338,5 @@ clean := -f $(if $(KBUILD_SRC),$(srctree
 
 endif	# skip-makefile
 
+.PHONY: FORCE
 FORCE:


