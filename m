Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUIEUJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUIEUJq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 16:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUIEUJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 16:09:46 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:11602 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267184AbUIEUJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 16:09:32 -0400
Date: Sun, 5 Sep 2004 22:12:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: kbuild: Simplify vmlinux generation
Message-ID: <20040905201235.GC16901@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several new changes pushed out to:
bk://linux-sam.bkbits.net/kbuild

Already posted to lkml:
o Remove last sign of LDFALGS_BLOB (raisorblade)
o Set cflags before including arch Makefile (raisorblade)
o use KERNELREALSE consistently (Brian Gerst)
o Support LOCALVERSION (ianw)

Included as patch in this mail:
o Simplified vmlinux generation

Generating vmlinux in top-level Makefile were getting a bit messy after kallsyms
support were added. Also the full link of all the .o files were duplicaed a number of times.
This patch does the following:
- Introduce built-in.o which is a prelink of most .o files
- Make the build process a bit more verbose telling when linking .tmpvmlinux*
- Use less magic when determing when to generate a new version
- Allow architectures to override the defineition of cmd_vmlinux__
- Add more comments to the MAkefile and clean up soem other comments
- Display more commends during V=1 builds

The resulting kernel boots and run here.


This clear the queue of kbuild modifications to support um.
I expect to see wiedespread use of LOCALVERSION :-)

In my in-queue is mainly pkg patches now.
Current slew of kconfig related patches will go in via Andrew.

	Sam
	
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-09-05 22:06:47 +02:00
+++ b/Makefile	2004-09-05 22:06:47 +02:00
@@ -545,67 +545,91 @@
 
 # Build vmlinux
 # ---------------------------------------------------------------------------
+# vmlinux is build from the objects seleted by $(vmlinux-init) and
+# $(vmlinux-main). Most are built-in.o files from top-level directories
+# in the kernel tree, others are specified in arch/$(ARCH)Makefile.
+# Ordering when linking is important, and $(vmlinux-init) must be first.
+#
+# vmlinux
+#   ^
+#   |
+#   +-< $(vmlinux-init)
+#   |   +--< init/version.o + more
+#   |
+#   +-< built-in.o
+#   |   +--< $(vmlinux-main)
+#   |        +--< driver/built-in.o mm/built-in.o + more
+#   |
+#   +-< kallsyms.o (see description in CONFIG_KALLSYMS section)
+#
+# vmlinux version cannot be updated during normal descending-into-subdirs
+# phase since we do not yet know if we need to update vmlinux.
+# Therefore this step is delayed until just before final link of vmlinux -
+# except in kallsyms case where it is done just before adding the
+# symbols to the kernel.
+#
+# System.map is generated to document addresses of all kernel symbols
 
-#	This is a bit tricky: If we need to relink vmlinux, we want
-#	the version number incremented, which means recompile init/version.o
-#	and relink init/init.o. However, we cannot do this during the
-#       normal descending-into-subdirs phase, since at that time
-#       we cannot yet know if we will need to relink vmlinux.
-#	So we descend into init/ inside the rule for vmlinux again.
-vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) $(net-y)
-
-quiet_cmd_vmlinux__ = LD      $@
-define cmd_vmlinux__
-	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) $(head-y) $(init-y) \
-	--start-group \
-	$(core-y) \
-	$(libs-y) \
-	$(drivers-y) \
-	$(net-y) \
-	--end-group \
-	$(filter .tmp_kallsyms%,$^) \
-	-o $@
-endef
+vmlinux-init := $(head-y) $(init-y)
+vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+vmlinux-all  := $(vmlinux-init) built-in.o
+vmlinux-lds  := arch/$(ARCH)/kernel/vmlinux.lds
+
+# Rule to link vmlinux - also used during CONFIG_KALLSYMS
+# May be overridden by arch/$(ARCH)/Makefile
+quiet_cmd_vmlinux__  = LD      $@
+      cmd_vmlinux__  = $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) \
+                           -T $(filter-out FORCE, $^) -o $@
+
+# Generate new vmlinux version
+quiet_cmd_vmlinux_version = GEN     .version
+      cmd_vmlinux_version = set -e;                     \
+	. $(srctree)/scripts/mkversion > .tmp_version;	\
+	mv -f .tmp_version .version;			\
+	$(MAKE) $(build)=init
+	
+# Generate System.map
+quiet_cmd_sysmap = SYSMAP 
+      cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
 
-#	set -e makes the rule exit immediately on error
+# Link of vmlinux
+# If CONFIG_KALLSYMS is set .version is already updated
+# Generate System.map and verify that the content is consistent
 
 define rule_vmlinux__
-	+set -e;							\
-	$(if $(filter .tmp_kallsyms%,$^),,				\
-	  echo '  GEN     .version';					\
-	  . $(srctree)/scripts/mkversion > .tmp_version;		\
-	  mv -f .tmp_version .version;					\
-	  $(MAKE) $(build)=init;					\
-	)								\
-	$(if $($(quiet)cmd_vmlinux__),					\
-	  echo '  $($(quiet)cmd_vmlinux__)' &&) 			\
-	$(cmd_vmlinux__);						\
-	echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
+	$(if $(CONFIG_KALLSYMS),,$(call cmd,vmlinux_version))
+	
+	$(call cmd,vmlinux__)
+	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
+	
+	$(Q)$(if $($(quiet)cmd_sysmap),                 \
+	  echo '  $($(quiet)cmd_sysmap) System.map' &&) \
+	$(cmd_sysmap) $@ System.map;                    \
+	if [ $$? -ne 0 ]; then                          \
+		rm -f $@;                               \
+		/bin/false;                             \
+	fi;
+	$(verify_kallsyms)
 endef
 
-quiet_cmd_sysmap = SYSMAP 
-      cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
-		   
-LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds
-
-#	Generate section listing all symbols and add it into vmlinux
-#	It's a three stage process:
-#	o .tmp_vmlinux1 has all symbols and sections, but __kallsyms is
-#	  empty
-#	  Running kallsyms on that gives us .tmp_kallsyms1.o with
-#	  the right size
-#	o .tmp_vmlinux2 now has a __kallsyms section of the right size,
-#	  but due to the added section, some addresses have shifted
-#	  From here, we generate a correct .tmp_kallsyms2.o
-#	o The correct .tmp_kallsyms2.o is linked into the final vmlinux.
-#	o Verify that the System.map from vmlinux matches the map from
-#	  .tmp_vmlinux2, just in case we did not generate kallsyms correctly.
-#	o If CONFIG_KALLSYMS_EXTRA_PASS is set, do an extra pass using
-#	  .tmp_vmlinux3 and .tmp_kallsyms3.o.  This is only meant as a
-#	  temporary bypass to allow the kernel to be built while the
-#	  maintainers work out what went wrong with kallsyms.
 
 ifdef CONFIG_KALLSYMS
+# Generate section listing all symbols and add it into vmlinux $(kallsyms.o)
+# It's a three stage process:
+# o .tmp_vmlinux1 has all symbols and sections, but __kallsyms is
+#   empty
+#   Running kallsyms on that gives us .tmp_kallsyms1.o with
+#   the right size - vmlinux version updated during this step
+# o .tmp_vmlinux2 now has a __kallsyms section of the right size,
+#   but due to the added section, some addresses have shifted.
+#   From here, we generate a correct .tmp_kallsyms2.o
+# o The correct .tmp_kallsyms2.o is linked into the final vmlinux.
+# o Verify that the System.map from vmlinux matches the map from
+#   .tmp_vmlinux2, just in case we did not generate kallsyms correctly.
+# o If CONFIG_KALLSYMS_EXTRA_PASS is set, do an extra pass using
+#   .tmp_vmlinux3 and .tmp_kallsyms3.o.  This is only meant as a
+#   temporary bypass to allow the kernel to be built while the
+#   maintainers work out what went wrong with kallsyms.
 
 ifdef CONFIG_KALLSYMS_EXTRA_PASS
 last_kallsyms := 3
@@ -615,16 +639,28 @@
 
 kallsyms.o := .tmp_kallsyms$(last_kallsyms).o
 
-define rule_verify_kallsyms
+define verify_kallsyms
 	$(Q)$(if $($(quiet)cmd_sysmap),                       \
 	  echo '  $($(quiet)cmd_sysmap) .tmp_System.map' &&)  \
 	  $(cmd_sysmap) .tmp_vmlinux$(last_kallsyms) .tmp_System.map
-	$(Q)cmp -s System.map .tmp_System.map || \
-		(echo Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS ; rm .tmp_kallsyms* ; false)
+	$(Q)cmp -s System.map .tmp_System.map ||              \
+		(echo Inconsistent kallsyms data;             \
+		 echo Try setting CONFIG_KALLSYMS_EXTRA_PASS; \
+		 rm .tmp_kallsyms* ; /bin/false )
+endef
+
+# Update vmlinux version before link
+cmd_ksym_ld = $(cmd_vmlinux__)
+define rule_ksym_ld
+	$(call cmd,vmlinux_version)
+	$(call cmd,vmlinux__)
+	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 endef
 
+# Generate .S file with all kernel symbols
 quiet_cmd_kallsyms = KSYM    $@
-cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) $(foreach x,$(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
+      cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) \
+                     $(if $(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
 
 .tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
@@ -632,43 +668,39 @@
 .tmp_kallsyms%.S: .tmp_vmlinux% $(KALLSYMS)
 	$(call cmd,kallsyms)
 
-.tmp_vmlinux1: $(vmlinux-objs) arch/$(ARCH)/kernel/vmlinux.lds FORCE
-	$(call if_changed_rule,vmlinux__)
+# .tmp_vmlinux1 must be complete except kallsyms, so update vmlinux version
+.tmp_vmlinux1: $(vmlinux-lds) $(vmlinux-all) FORCE
+	$(call if_changed_rule,ksym_ld)
 
-.tmp_vmlinux2: $(vmlinux-objs) .tmp_kallsyms1.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
-	$(call if_changed_rule,vmlinux__)
+.tmp_vmlinux2: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms1.o FORCE
+	$(call if_changed,vmlinux__)
 
-.tmp_vmlinux3: $(vmlinux-objs) .tmp_kallsyms2.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
-	$(call if_changed_rule,vmlinux__)
+.tmp_vmlinux3: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms2.o FORCE
+	$(call if_changed,vmlinux__)
 
 # Needs to visit scripts/ before $(KALLSYMS) can be used.
 $(KALLSYMS): scripts ;
 
-endif
-
-# Finally the vmlinux rule
-# This rule is also used to generate System.map
-# and to verify that the content of kallsyms are consistent
-
-define rule_vmlinux
-	$(rule_vmlinux__);
-	$(Q)$(if $($(quiet)cmd_sysmap),                  \
-	  echo '  $($(quiet)cmd_sysmap) System.map' &&)  \
-	$(cmd_sysmap) $@ System.map;                     \
-	if [ $$? -ne 0 ]; then                           \
-		rm -f $@;                                \
-		/bin/false;                              \
-	fi;
-	$(rule_verify_kallsyms)
-endef
+endif # ifdef CONFIG_KALLSYMS
 
-vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/kernel/vmlinux.lds FORCE
-	$(call if_changed_rule,vmlinux)
-
-#	The actual objects are generated when descending, 
-#	make sure no implicit rule kicks in
+# vmlinux image - including updated kernel symbols
+vmlinux: $(vmlinux-lds) $(vmlinux-init) built-in.o $(kallsyms.o) FORCE
+	$(call if_changed_rule,vmlinux__)
 
-$(sort $(vmlinux-objs)) arch/$(ARCH)/kernel/vmlinux.lds: $(vmlinux-dirs) ;
+# Link $(vmlinux-main) to speed up rest of build phase. No need to
+# relink this part too many times.
+# Use start/end-group to make sure to resolve all possible symbols
+quiet_rule_vmlinux_partial = LD      $@
+       cmd_vmlinux_partial = $(LD) $(LDFLAGS) $(LDFLAGS_$(*F)) -r \
+                                   --start-group $(filter-out FORCE, $^) \
+				   --end-group -o $@
+				   
+built-in.o: $(vmlinux-main) FORCE
+	$(call if_changed,vmlinux_partial)
+
+# The actual objects are generated when descending, 
+# make sure no implicit rule kicks in
+$(sort $(vmlinux-init) $(vmlinux-main)) $(vmlinux-lds): $(vmlinux-dirs) ;
 
 # Handle descending into subdirectories listed in $(vmlinux-dirs)
 # Preset locale variables to speed up the build process. Limit locale
@@ -1188,13 +1220,22 @@
   include $(cmd_files)
 endif
 
+# Execute command and generate cmd file
+if_changed = $(if $(strip $? \
+		          $(filter-out $(cmd_$(1)),$(cmd_$@))\
+			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
+	@set -e; \
+	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
+	$(cmd_$(1)); \
+	echo 'cmd_$@ := $(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).cmd)
+
+
 # execute the command and also postprocess generated .d dependencies
 # file
-
 if_changed_dep = $(if $(strip $? $(filter-out FORCE $(wildcard $^),$^)\
 		          $(filter-out $(cmd_$(1)),$(cmd_$@))\
 			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
-	@set -e; \
+	$(Q)set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
 	$(cmd_$(1)); \
 	scripts/basic/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
@@ -1208,7 +1249,7 @@
 if_changed_rule = $(if $(strip $? \
 		               $(filter-out $(cmd_$(1)),$(cmd_$(@F)))\
 			       $(filter-out $(cmd_$(@F)),$(cmd_$(1)))),\
-	               @$(rule_$(1)))
+	               $(Q)$(rule_$(1)))
 
 # If quiet is set, only print short version of command
 

