Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264545AbUDTWfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbUDTWfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUDTWcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:32:32 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39044 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S264566AbUDTViR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:38:17 -0400
Date: Tue, 20 Apr 2004 23:48:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kbuild: Improved external module support
Message-ID: <20040420214842.GA2098@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The external module support recently introduced caused a number of problems:
- To build an external module the Module.symvers file was needed
- To create the Module.symvers file a module was required
- If Module.symvers was missing kbuild boiled out with an error
- If vmlinux was missing also the stage 2 of module build failed (make -k)
- It was not documented what was needed to actually bauild a module

The following patch addresses this by adding the following functionality:
- Always generate the Module.symvers file
- Ignore a missing Module.symvers file
- Add a new target modules_prepare, it prepares the kernel for building
  external modules, and is also usefull with O=
- And it adds some more comments to Makefile.modpost, so others may follow
  it with some luck
- .modpost.cmd is no longer generated

This should close all reports on issues with respect to building
external modules with current kernel - which has been identified
as kernel problems.


	Sam

===== Makefile 1.480 vs edited =====
--- 1.480/Makefile	Thu Apr 15 03:31:15 2004
+++ edited/Makefile	Tue Apr 20 22:32:25 2004
@@ -715,8 +715,12 @@
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
-#	Install modules
 
+# Target to prepare building external modules
+.PHONY: modules_prepare
+modules_prepare: prepare-all scripts
+
+# Target to install modules
 .PHONY: modules_install
 modules_install: _modinst_ _modinst_post
 
===== scripts/Makefile.modpost 1.9 vs edited =====
--- 1.9/scripts/Makefile.modpost	Mon Apr 12 19:55:33 2004
+++ edited/scripts/Makefile.modpost	Tue Apr 20 22:25:35 2004
@@ -1,34 +1,71 @@
 # ===========================================================================
 # Module versions
 # ===========================================================================
+#
+# Stage one of module building created the following:
+# a) The individual .o files used for the module
+# b) A <module>.o file wich is the .o files above linked together
+# c) A <module>.mod file in $(MODVERDIR)/, listing the name of the
+#    the preliminary <module>.o file, plus all .o files
+
+# Stage 2 is handled by this file and does the following
+# 1) Find all modules from the files listed in $(MODVERDIR)/
+# 2) modpost is then used to
+# 3)  create one <module>.mod.c file pr. module
+# 4)  create one Module.symvers file with CRC for all exported symbols
+# 5) compile all <module>.mod.c files
+# 6) final link of the module to a <module.ko> file
+
+# Step 3 is used to place certain information in the module's ELF
+# section, including information such as:
+#   Version magic (see include/vermagic.h for full details)
+#     - Kernel release
+#     - SMP is CONFIG_SMP
+#     - PREEMPT is CONFIG_PREEMPT
+#     - GCC Version
+#   Module info
+#     - Module version (MODULE_VERSION)
+#     - Module alias'es (MODULE_ALIAS)
+#     - Module license (MODULE_LICENSE)
+#     - See include/linux/module.h for more details
+
+# Step 4 is solely used to allow module versioning in external modules,
+# where the CRC of each module is retreived from the Module.symers file.
 
-.PHONY: __modversions
-__modversions:
+.PHONY: _modpost
+_modpost: __modpost
 
 include .config
 include scripts/Makefile.lib
 
-#
+symverfile := $(objtree)/Module.symvers
 
+# Step 1), find all modules listed in $(MODVERDIR)/
 __modules := $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod))
-modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
+modules   := $(patsubst %.o,%.ko, $(wildcard $(__modules:.ko=.o)))
 
-__modversions: $(modules)
-	@:
+_modpost: $(modules)
 
-# The final module link
 
-quiet_cmd_ld_ko_o = LD [M]  $@
-      cmd_ld_ko_o = $(LD) $(LDFLAGS) $(LDFLAGS_MODULE) -o $@ 		\
-			  $(filter-out FORCE,$^)
+# Step 2), invoke modpost
+#  Includes step 3,4
+quiet_cmd_modpost = MODPOST
+      cmd_modpost = scripts/modpost \
+	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
+	$(filter-out FORCE,$^)
 
-$(modules): %.ko :%.o %.mod.o FORCE
-	$(call if_changed,ld_ko_o)
+.PHONY: __modpost
+__modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
+	$(call cmd,modpost)
+
+# Declare generated files as targets for modpost
+$(symverfile):         __modpost ;
+$(modules:.ko=.mod.c): __modpost ;
 
-targets += $(modules)
 
-# Compile version info for unresolved symbols
+# Step 5), compile all *.mod.c files
 
+# modname is set to make c_flags define KBUILD_MODNAME
 modname = $(*F)
 
 quiet_cmd_cc_o_c = CC      $@
@@ -40,23 +77,16 @@
 
 targets += $(modules:.ko=.mod.o)
 
-# All the .mod.c files are generated using the helper "modpost"
-
-.PHONY: __modpost
-
-$(modules:.ko=.mod.c): __modpost ;
-
-# Extract all checksums for all exported symbols
+# Step 6), final link of the modules
+quiet_cmd_ld_ko_o = LD [M]  $@
+      cmd_ld_ko_o = $(LD) $(LDFLAGS) $(LDFLAGS_MODULE) -o $@ 		\
+			  $(filter-out FORCE,$^)
 
-quiet_cmd_modpost = MODPOST
-      cmd_modpost = scripts/modpost \
-	$(if $(filter vmlinux,$^),-o,-i) $(objtree)/Module.symvers \
-	$(filter-out FORCE,$^)
+$(modules): %.ko :%.o %.mod.o FORCE
+	$(call if_changed,ld_ko_o)
 
-__modpost: $(if $(KBUILD_EXTMOD),,$(wildcard vmlinux)) $(modules:.ko=.o) FORCE
-	$(call if_changed,modpost)
+targets += $(modules)
 
-targets += __modpost
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
===== scripts/modpost.c 1.27 vs edited =====
--- 1.27/scripts/modpost.c	Sun Apr 18 18:13:09 2004
+++ edited/scripts/modpost.c	Tue Apr 20 22:28:29 2004
@@ -625,10 +625,9 @@
 	void *file = grab_file(fname, &size);
 	char *line;
 
-        if (!file) {
-                perror(fname);
-                abort();
-        }
+        if (!file)
+		/* No symbol versions, silently ignore */
+		return;
 
 	while ((line = get_next_line(&pos, file, size))) {
 		char *symname, *modname, *d;
