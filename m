Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWCUQVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWCUQVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWCUQVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:24844 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932334AbWCUQVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:10 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 01/46] kbuild: support building individual files for external modules
In-Reply-To: <20060321161709.GA8475@mars.ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:54 +0100
Message-Id: <1142958054202-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support building individual files when dealing with separate modules.
So say you have a module named "foo" which consist of two .o files bar.o
and fun.o.

You can then do:
make -C $KERNELSRC M=`pwd` bar.o
make -C $KERNELSRC M=`pwd` bar.lst
make -C $KERNELSRC M=`pwd` bar.i
make -C $KERNELSRC M=`pwd` /            <= will build all .o files
                                           and link foo.o
make -C $KERNELSRC M=`pwd` foo.ko       <= will build the module
                                           and do the modpost step
					   to create foo.ko

The above will also work if the external module is placed in a
subdirectory using a hirachy of kbuild files.
Thanks to Andreas Gruenbacher <agruen@suse.de> for initial feature
request / bug report.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Documentation/kbuild/modules.txt |   11 ++++++
 Makefile                         |   66 +++++++++++++++++++++++++-------------
 2 files changed, 55 insertions(+), 22 deletions(-)

06300b21f4c79fd1578f4b7ca4b314fbab61a383
diff --git a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
index 7e77f93..87d858d 100644
--- a/Documentation/kbuild/modules.txt
+++ b/Documentation/kbuild/modules.txt
@@ -13,6 +13,7 @@ In this document you will find informati
 	   --- 2.2 Available targets
 	   --- 2.3 Available options
 	   --- 2.4 Preparing the kernel tree for module build
+	   --- 2.5 Building separate files for a module
 	=== 3. Example commands
 	=== 4. Creating a kbuild file for an external module
 	=== 5. Include files
@@ -131,6 +132,16 @@ when building an external module.
 	      Therefore a full kernel build needs to be executed to make
 	      module versioning work.
 
+--- 2.5 Building separate files for a module
+	It is possible to build single files which is part of a module.
+	This works equal for the kernel, a module and even for external
+	modules.
+	Examples (module foo.ko, consist of bar.o, baz.o):
+		make -C $KDIR M=`pwd` bar.lst
+		make -C $KDIR M=`pwd` bar.o
+		make -C $KDIR M=`pwd` foo.ko
+		make -C $KDIR M=`pwd` /
+	
 
 === 3. Example commands
 
diff --git a/Makefile b/Makefile
index 77a448c..639d8a4 100644
--- a/Makefile
+++ b/Makefile
@@ -137,7 +137,7 @@ objtree		:= $(CURDIR)
 src		:= $(srctree)
 obj		:= $(objtree)
 
-VPATH		:= $(srctree)
+VPATH		:= $(srctree):$(KBUILD_EXTMOD)
 
 export srctree objtree VPATH TOPDIR
 
@@ -849,27 +849,6 @@ prepare prepare-all: prepare0
 
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
@@ -1192,6 +1171,11 @@ help:
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
@@ -1313,6 +1297,44 @@ kernelrelease:
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
 
-- 
1.0.GIT


