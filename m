Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbTAYSfu>; Sat, 25 Jan 2003 13:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTAYSfu>; Sat, 25 Jan 2003 13:35:50 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:63939 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261686AbTAYSf1>; Sat, 25 Jan 2003 13:35:27 -0500
Date: Sat, 25 Jan 2003 12:44:39 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: linux-kernel@vger.kernel.org
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC] [PATCH] new modversions implementation
Message-ID: <Pine.LNX.4.44.0301251229120.6749-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch which adds module symbol versioning to 2.5. The old 
implementation had been broken with rusty's module rewrite and been
disabled in the kernel config.

The idea behind the patch is the same as in the old implementation, i.e.  
add checksums to exported symbols which change as the ABI changes. Modules
also record the version checksums of the ABI they are built against. When
loading a module into the kernel, those two checksums (per symbol) are
checked against each other to make sure that the ABIs are compatible.

The implementation is basically completely different from the old code 
(which was well-known for "do make mrproper when something goes wrong"), 
the idea used partially dates back to discussions on linux-kbuild/Keith 
Owens/Rusty Russell, and the current code is based in part on a patch by 
rusty.

A kernel built with CONFIG_MODVERSIONING will continue to work fine with
unpatched module-init-tools, however, forcing the load of a module
with mismatched symbol versions will need a small patch to 
module-init-tools.

Comments, testing or other feedback are much appreciated ;)

--Kai


Against 2.5.59

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.957, 2003-01-17 10:26:43-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Fix __start_SECTION, __stop_SECTION
  
  In a discussion with Sam Ravnborg, the following problem became apparent:
  Most vmlinux.lds.S (but the ARM ones) used the following construct:
    
         __start___ksymtab = .;                                          
         __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         
                 *(__ksymtab)                                            
         }                                                               
         __stop___ksymtab = .;                                           
    
  However, the link will align the beginning of the section __ksymtab
  according to the requirements for the input sections. If '.' (current
  location counter) wasn't sufficiently aligned before, it's possible
  that __ksymtab actually starts at an address after the one
  __start___ksymtab points to, which will confuse the users of
  __start___ksymtab badly. The fix is to follow what the ARM Makefiles
  did for this case, ie
    
         __ksymtab : AT(ADDR(__ksymtab) - LOAD_OFFSET) {                 
                 __start___ksymtab = .;                                  
                 *(__ksymtab)                                            
                 __stop___ksymtab = .;                                   
         }                                                               

 ----------------------------------------------------------------------------
 vmlinux.lds.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.958, 2003-01-24 13:26:21-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Remove -DEXPORT_SYMTAB switch
  
  rusty's module rewrite removed the reference to EXPORT_SYMTAB 
  from linux/module.h, and it's not used anywhere else, either.

 ----------------------------------------------------------------------------
 Makefile               |    4 ----
 scripts/Makefile.build |    5 -----
 scripts/Makefile.lib   |    2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.959, 2003-01-24 13:42:18-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Remove obsolete CONFIG_MODVERSIONS cruft
  
  Though the CONFIG_MODVERSIONS option was removed with rusty's module
  rewrite and the associated code broken, a lot of that code was still
  living on here and there. Now it's gone for good.

 ----------------------------------------------------------------------------
 Makefile                |   65 ++------------------------
 scripts/Makefile.lib    |   14 -----
 scripts/Makefile.modver |  118 ------------------------------------------------
 3 files changed, 8 insertions(+), 189 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.960, 2003-01-24 14:27:06-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Add CONFIG_MODVERSIONING and __kcrctab
  
  This patch adds the new config option CONFIG_MODVERSIONING which will
  be the new way of checking for ABI changes between kernel and module
  code.
  
  This and the following patches are in part based on an initial
  implementation by Rusty Russell and I believe some of the ideas go back
  to discussions on linux-kbuild, Keith Owens and Rusty.
  
  though I'm not sure I think credit for the basic idea of
  storing version info in sections goes to Keith Owens and Rusty.
  
  o Rename __gpl_ksymtab to __ksymtab_gpl since that looks more consistent
    and appending _gpl instead of putting it into the middle simplifies
    sharing code for EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
  o Add CONFIG_MODVERSIONING
  o If CONFIG_MODVERSIONING is set, add a section __kcrctab{,_gpl}, which
    contains the ABI checksums for the exported symbols listed in 
    __ksymtab{,_crc} Since we don't know the checksums yet at compilation
    time, just make them an unresolved symbol which gets filled in by the
    linker later.

 ----------------------------------------------------------------------------
 include/asm-generic/vmlinux.lds.h |   22 ++++++++++++++++++----
 include/linux/module.h            |   31 +++++++++++++++++++++----------
 init/Kconfig                      |   13 +++++++++++++
 kernel/module.c                   |   21 +++++++++++----------
 scripts/per-cpu-check.awk         |    2 +-
 5 files changed, 64 insertions(+), 25 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.961, 2003-01-24 21:45:27-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Generate versions for exported symbols
  
  Up to now, we had a way to store the checksums associated with the
  exported symbols, but they were not filled in yet. This is done
  with this patch, using the linker to actually do that for us.
    
  The comment added with this patch explains what magic exactly is going
  on.

 ----------------------------------------------------------------------------
 include/linux/module.h |   16 ++++++++++++--
 scripts/Makefile.build |   53 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.962, 2003-01-24 21:47:14-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Check __vermagic for validity
  
  modprobe --force allows to load modules without a matching version
  magic string. This invalidation is done by clearing the SHF_ALLOC
  flag, so check it in the kernel. Also, clear the SHF_ALLOC flag
  unconditionally, since we don't need to store the __vermagic section
  in the kernel, it's only checked once at load time. 

 ----------------------------------------------------------------------------
 module.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.963, 2003-01-24 21:48:27-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Don't save the license string
  
  Again, the license string is only used at load time, so no need
  to store it permanently in kernel memory.

 ----------------------------------------------------------------------------
 module.c |    1 +
 1 files changed, 1 insertion(+)

-----------------------------------------------------------------------------
ChangeSet@1.964, 2003-01-24 21:49:33-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Track versions of exported symbols
  
  Store the information on the checksum alongside the rest of the 
  information on exported symbols. To actually use them, we need
  something to check them against first, though ;)
  
  Also, fix some conditional debug code to actually compile.

 ----------------------------------------------------------------------------
 include/linux/module.h |    1 +
 kernel/module.c        |   28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.965, 2003-01-24 21:51:36-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Always link module (.ko) from associated (.o)
  
  For extracting the versions and finding the unresolved symbols, we
  need multi-part modules to be linked together already, so this
  patch separates the building of the modules as a .o file from generating
  the .ko in the next step.

 ----------------------------------------------------------------------------
 Makefile.build |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.966, 2003-01-24 21:52:47-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Don't build final .ko yet when descending with CONFIG_MODVERSIONING
  
  With CONFIG_MODVERSIONING, we need to record the versions of the unresolved
  symbols in the final <module>.ko, which we only know after we finished
  the descending build. So we only build <module>.o in that case.
    
  Also, keep track of the modules we built, the post-processing step needs
  a list of all modules. Keeping track is done by touching
  .tmp_versions/path/to/module.ko

 ----------------------------------------------------------------------------
 Makefile               |   24 ++++++++++++++++++++++++
 scripts/Makefile.build |   25 ++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

-----------------------------------------------------------------------------
ChangeSet@1.967, 2003-01-24 21:54:04-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Record versions for unresolved symbols
  
  In the case of CONFIG_MODVERSIONING, the build step will only
  generate preliminary <module>.o objects, and an additional
  postprocessing step is necessary to record the versions of the unresolved
  symbols and add them into the final <module>.ko
    
  The version information for unresolved symbols is again recorded into
  a special section, "__versions", which contains an array of symbol
  name strings and checksum (struct modversion_info). Size is here not
  an issue, since this section will not be stored permanently in kernel
  memory.
    
  Makefile.modver takes care of the following steps:
  o Collect the version information for all exported symbols from vmlinux
    and all modules which export symbols.
  o For each module, generate a C file which contains the modversion
    information for all unresolved symbols in that module.
  o For each module, compile that C file to an object file
  o Finally, link the <module>.ko using the preliminary <module.o> + the
    version information above.
    
  The first two steps are currently done by not very efficient scripting,
  so there's room for performance improvement using some helper C code.

 ----------------------------------------------------------------------------
 Makefile                |   15 ++++++--
 include/linux/module.h  |    7 +++
 scripts/Makefile.modver |   89 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 3 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.968, 2003-01-24 21:54:53-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Return the index of the symbol from __find_symbol()
  
  We'll need that index to find the version checksum for the symbol in
  a bit.

 ----------------------------------------------------------------------------
 module.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.969, 2003-01-24 21:55:37-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Check module symbol versions on insmod
  
  Yeah, the final step!
    
  Now that we've got the checksums for the exported symbols and the
  checksums of the unresolved symbols for the module we're loading,
  let's compare and see.
    
  Again, we allow to load a module which has the version info stripped,
  but taint the kernel in that case.

 ----------------------------------------------------------------------------
 module.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 73 insertions(+), 8 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================

-----------------------------------------------------------------------------
ChangeSet@1.957, 2003-01-17 10:26:43-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Fix __start_SECTION, __stop_SECTION
  
  In a discussion with Sam Ravnborg, the following problem became apparent:
  Most vmlinux.lds.S (but the ARM ones) used the following construct:
    
         __start___ksymtab = .;                                          
         __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         
                 *(__ksymtab)                                            
         }                                                               
         __stop___ksymtab = .;                                           
    
  However, the link will align the beginning of the section __ksymtab
  according to the requirements for the input sections. If '.' (current
  location counter) wasn't sufficiently aligned before, it's possible
  that __ksymtab actually starts at an address after the one
  __start___ksymtab points to, which will confuse the users of
  __start___ksymtab badly. The fix is to follow what the ARM Makefiles
  did for this case, ie
    
         __ksymtab : AT(ADDR(__ksymtab) - LOAD_OFFSET) {                 
                 __start___ksymtab = .;                                  
                 *(__ksymtab)                                            
                 __stop___ksymtab = .;                                   
         }                                                               

  ---------------------------------------------------------------------------

diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Sat Jan 25 12:24:59 2003
+++ b/include/asm-generic/vmlinux.lds.h	Sat Jan 25 12:24:59 2003
@@ -13,18 +13,18 @@
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-	__start___ksymtab = .;						\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
+		__start___ksymtab = .;					\
 		*(__ksymtab)						\
+		__stop___ksymtab = .;					\
 	}								\
-	__stop___ksymtab = .;						\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
-	__start___gpl_ksymtab = .;					\
 	__gpl_ksymtab     : AT(ADDR(__gpl_ksymtab) - LOAD_OFFSET) {	\
+		__start___gpl_ksymtab = .;				\
 		*(__gpl_ksymtab)					\
+		__stop___gpl_ksymtab = .;				\
 	}								\
-	__stop___gpl_ksymtab = .;					\
 									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\

-----------------------------------------------------------------------------
ChangeSet@1.958, 2003-01-24 13:26:21-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Remove -DEXPORT_SYMTAB switch
  
  rusty's module rewrite removed the reference to EXPORT_SYMTAB 
  from linux/module.h, and it's not used anywhere else, either.

  ---------------------------------------------------------------------------

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Jan 25 12:25:02 2003
+++ b/Makefile	Sat Jan 25 12:25:02 2003
@@ -256,10 +256,6 @@
 
 -include .config.cmd
 
-ifdef CONFIG_MODULES
-export EXPORT_FLAGS := -DEXPORT_SYMTAB
-endif
-
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
 endif
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Sat Jan 25 12:25:02 2003
+++ b/scripts/Makefile.build	Sat Jan 25 12:25:02 2003
@@ -69,11 +69,6 @@
 
 $(obj-m)              : quiet_modtag := [M]
 
-$(export-objs)        : export_flags   := $(EXPORT_FLAGS)
-$(export-objs:.o=.i)  : export_flags   := $(EXPORT_FLAGS)
-$(export-objs:.o=.s)  : export_flags   := $(EXPORT_FLAGS)
-$(export-objs:.o=.lst): export_flags   := $(EXPORT_FLAGS)
-
 # Default for not multi-part modules
 modname = $(*F)
 
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Sat Jan 25 12:25:02 2003
+++ b/scripts/Makefile.lib	Sat Jan 25 12:25:02 2003
@@ -130,7 +130,7 @@
 modname_flags  = $(if $(filter 1,$(words $(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
 c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	         $(basename_flags) $(modname_flags) $(export_flags) 
+	         $(basename_flags) $(modname_flags)
 a_flags        = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS)\
 		 $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
 hostc_flags    = -Wp,-MD,$(depfile) $(HOSTCFLAGS) $(HOST_EXTRACFLAGS)\

-----------------------------------------------------------------------------
ChangeSet@1.959, 2003-01-24 13:42:18-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Remove obsolete CONFIG_MODVERSIONS cruft
  
  Though the CONFIG_MODVERSIONS option was removed with rusty's module
  rewrite and the associated code broken, a lot of that code was still
  living on here and there. Now it's gone for good.

  ---------------------------------------------------------------------------

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Jan 25 12:25:04 2003
+++ b/Makefile	Sat Jan 25 12:25:04 2003
@@ -380,7 +380,7 @@
 # 	Handle descending into subdirectories listed in $(SUBDIRS)
 
 .PHONY: $(SUBDIRS)
-$(SUBDIRS): .hdepend prepare
+$(SUBDIRS): prepare
 	$(Q)$(MAKE) $(build)=$@
 
 #	Things we need done before we descend to build or make
@@ -471,61 +471,11 @@
 	) > $@.tmp
 	@$(update-if-changed)
 
-# Generate module versions
 # ---------------------------------------------------------------------------
 
-# 	The targets are still named depend / dep for traditional
-#	reasons, but the only thing we do here is generating
-#	the module version checksums.
-
-.PHONY: depend dep $(patsubst %,_sfdep_%,$(SUBDIRS))
-
-depend dep: .hdepend
-
-#	.hdepend is our (misnomed) marker for whether we've
-#	generated module versions
-
-make-versions := $(strip $(if $(filter dep depend,$(MAKECMDGOALS)),1) \
-			 $(if $(wildcard .hdepend),,1))
-
-.hdepend: prepare FORCE
-ifneq ($(make-versions),)
-	@$(MAKE) include/linux/modversions.h
-	@touch $@
-endif
-
-ifdef CONFIG_MODVERSIONS
-
-# 	Update modversions.h, but only if it would change.
-
-.PHONY: __rm_tmp_export-objs
-__rm_tmp_export-objs: 
-	@rm -rf .tmp_export-objs
-
-include/linux/modversions.h: $(patsubst %,_modver_%,$(SUBDIRS))
-	@echo -n '  Generating $@'
-	@( echo "#ifndef _LINUX_MODVERSIONS_H";\
-	   echo "#define _LINUX_MODVERSIONS_H"; \
-	   echo "#include <linux/modsetver.h>"; \
-	   cd .tmp_export-objs >/dev/null; \
-	   for f in `find modules -name \*.ver -print | sort`; do \
-	     echo "#include <linux/$${f}>"; \
-	   done; \
-	   echo "#endif"; \
-	) > $@.tmp; \
-	$(update-if-changed)
-
-.PHONY: $(patsubst %, _modver_%, $(SUBDIRS))
-$(patsubst %, _modver_%, $(SUBDIRS)): __rm_tmp_export-objs
-	$(Q)$(MAKE) -f scripts/Makefile.modver obj=$(patsubst _modver_%,%,$@)
-
-else # !CONFIG_MODVERSIONS
-
-.PHONY: include/linux/modversions.h
-
-include/linux/modversions.h:
-
-endif # CONFIG_MODVERSIONS
+.PHONY: depend dep
+depend dep:
+	@echo'*** Warning: make $@ is unnecessary now.'
 
 # ---------------------------------------------------------------------------
 # Modules
@@ -534,10 +484,6 @@
 
 #	Build modules
 
-ifdef CONFIG_MODVERSIONS
-MODFLAGS += -include include/linux/modversions.h
-endif
-
 .PHONY: modules
 modules: $(SUBDIRS)
 
@@ -570,6 +516,7 @@
 .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
 $(patsubst %, _modinst_%, $(SUBDIRS)) :
 	$(Q)$(MAKE) -rR -f scripts/Makefile.modinst obj=$(patsubst _modinst_%,%,$@)
+
 else # CONFIG_MODULES
 
 # Modules not configured
@@ -620,7 +567,7 @@
 
 rpm:	clean spec
 	find . $(RCS_FIND_IGNORE) \
-		\( -size 0 -o -name .depend -o -name .hdepend \) \
+		\( -size 0 -o -name .depend -o -name .hdepend\) \
 		-type f -print | xargs rm -f
 	set -e; \
 	cd $(TOPDIR)/.. ; \
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Sat Jan 25 12:25:04 2003
+++ b/scripts/Makefile.lib	Sat Jan 25 12:25:04 2003
@@ -34,14 +34,9 @@
 
 subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
 
-# export.o is never a composite object, since $(export-objs) has a
-# fixed meaning (== objects which EXPORT_SYMBOL())
-__obj-y = $(filter-out export.o,$(obj-y))
-__obj-m = $(filter-out export.o,$(obj-m))
-
 # if $(foo-objs) exists, foo.o is a composite object 
-multi-used-y := $(sort $(foreach m,$(__obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
-multi-used-m := $(sort $(foreach m,$(__obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
+multi-used-y := $(sort $(foreach m,$(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
+multi-used-m := $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
 multi-used   := $(multi-used-y) $(multi-used-m)
 single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))
 
@@ -59,9 +54,6 @@
 real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m))) $(EXTRA_TARGETS)
 real-objs-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
 
-# Only build module versions for files which are selected to be built
-export-objs := $(filter $(export-objs),$(real-objs-y) $(real-objs-m))
-
 # C code
 # Executables compiled from a single .c file
 host-csingle	:= $(foreach m,$(host-progs),$(if $($(m)-objs),,$(m)))
@@ -96,7 +88,6 @@
 build-targets	:= $(addprefix $(obj)/,$(build-targets))
 obj-y		:= $(addprefix $(obj)/,$(obj-y))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
-export-objs	:= $(addprefix $(obj)/,$(export-objs))
 subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
 real-objs-y	:= $(addprefix $(obj)/,$(real-objs-y))
 real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
@@ -217,7 +208,6 @@
 		               $(filter-out $(cmd_$(1)),$(cmd_$@))\
 			       $(filter-out $(cmd_$@),$(cmd_$(1)))),\
 			@set -e; \
-			mkdir -p $(dir $@); \
 			$(rule_$(1)))
 
 # If quiet is set, only print short version of command
diff -Nru a/scripts/Makefile.modver b/scripts/Makefile.modver
--- a/scripts/Makefile.modver	Sat Jan 25 12:25:04 2003
+++ b/scripts/Makefile.modver	Sat Jan 25 12:25:04 2003
@@ -2,121 +2,3 @@
 # Module versions
 # ===========================================================================
 
-src := $(obj)
-
-MODVERDIR := include/linux/modules
-
-.PHONY: modver
-modver:
-
-include .config
-
-include $(obj)/Makefile
-
-include scripts/Makefile.lib
-
-# ===========================================================================
-
-ifeq ($(strip $(export-objs)),)
-
-# If we don't export any symbols in this dir, just descend
-# ---------------------------------------------------------------------------
-
-modver: $(subdir-ym)
-	@:
-
-else
-
-# This sets version suffixes on exported symbols
-# ---------------------------------------------------------------------------
-
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
-#	Don't include modversions.h, we're just about to generate it here.
-
-CFLAGS_MODULE := $(filter-out -include include/linux/modversions.h,$(CFLAGS_MODULE))
-
-$(addprefix $(MODVERDIR)/,$(real-objs-y:.o=.ver)): modkern_cflags := $(CFLAGS_KERNEL)
-$(addprefix $(MODVERDIR)/,$(real-objs-m:.o=.ver)): modkern_cflags := $(CFLAGS_MODULE)
-$(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver)): export_flags   := -D__GENKSYMS__
-# Default for not multi-part modules
-modname = $(*F)
-
-$(addprefix $(MODVERDIR)/,$(multi-objs:.o=.ver)) : modname = $(modname-multi)
-
-# Our objects only depend on modversions.h, not on the individual .ver
-# files (fix-dep filters them), so touch modversions.h if any of the .ver
-# files changes
-
-quiet_cmd_cc_ver_c = MKVER   include/linux/modules/$*.ver
-cmd_cc_ver_c = $(CPP) $(c_flags) $< | $(GENKSYMS) $(genksyms_smp_prefix) \
-		 -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp
-
-# Okay, let's explain what's happening in rule_make_cc_ver_c:
-# o echo the command
-# o execute the command
-# o If the $(CPP) fails, we won't notice because it's output is piped
-#   to $(GENKSYMS) which does not fail. We recognize this case by
-#   looking if the generated $(depfile) exists, though.
-# o If the .ver file changed, touch modversions.h, which is our marker
-#   of any changed .ver files.
-# o Move command line and deps into their normal .*.cmd place.  
-
-define rule_cc_ver_c
-	$(if $($(quiet)cmd_cc_ver_c),echo '  $($(quiet)cmd_cc_ver_c)';) \
-	$(cmd_cc_ver_c); \
-	if [ ! -r $(depfile) ]; then exit 1; fi; \
-	scripts/fixdep $(depfile) $@ '$(cmd_cc_ver_c)' > $(@D)/.$(@F).tmp; \
-	rm -f $(depfile); \
-	if [ ! -r $@ ] || cmp -s $@ $@.tmp; then \
-	  touch include/linux/modversions.h; \
-	fi; \
-	mv -f $@.tmp $@
-	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
-endef
-
-targets := $(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver))
-
-$(MODVERDIR)/%.ver: %.c FORCE
-	@$(call if_changed_rule,cc_ver_c)
-
-modver: $(targets) $(subdir-ym)
-	@mkdir -p $(dir $(addprefix .tmp_export-objs/modules/,$(export-objs:.o=.ver)))
-	@touch $(addprefix .tmp_export-objs/modules/,$(export-objs:.o=.ver))
-
-endif # export-objs 
-
-# Descending
-# ---------------------------------------------------------------------------
-
-.PHONY: $(subdir-ym)
-$(subdir-ym):
-	$(Q)$(MAKE) -f scripts/Makefile.modver obj=$@
-
-# Add FORCE to the prequisites of a target to force it to be always rebuilt.
-# ---------------------------------------------------------------------------
-
-.PHONY: FORCE
-
-FORCE:
-
-# Read all saved command lines and dependencies for the $(targets) we
-# may be building above, using $(if_changed{,_dep}). As an
-# optimization, we don't need to read them if the target does not
-# exist, we will rebuild anyway in that case.
-
-targets := $(wildcard $(sort $(targets)))
-cmd_files := $(wildcard $(foreach f,$(targets),$(dir $(f)).$(notdir $(f)).cmd))
-
-ifneq ($(cmd_files),)
-  include $(cmd_files)
-endif

-----------------------------------------------------------------------------
ChangeSet@1.960, 2003-01-24 14:27:06-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Add CONFIG_MODVERSIONING and __kcrctab
  
  This patch adds the new config option CONFIG_MODVERSIONING which will
  be the new way of checking for ABI changes between kernel and module
  code.
  
  This and the following patches are in part based on an initial
  implementation by Rusty Russell and I believe some of the ideas go back
  to discussions on linux-kbuild, Keith Owens and Rusty.
  
  though I'm not sure I think credit for the basic idea of
  storing version info in sections goes to Keith Owens and Rusty.
  
  o Rename __gpl_ksymtab to __ksymtab_gpl since that looks more consistent
    and appending _gpl instead of putting it into the middle simplifies
    sharing code for EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
  o Add CONFIG_MODVERSIONING
  o If CONFIG_MODVERSIONING is set, add a section __kcrctab{,_gpl}, which
    contains the ABI checksums for the exported symbols listed in 
    __ksymtab{,_crc} Since we don't know the checksums yet at compilation
    time, just make them an unresolved symbol which gets filled in by the
    linker later.

  ---------------------------------------------------------------------------

diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	Sat Jan 25 12:25:07 2003
+++ b/include/asm-generic/vmlinux.lds.h	Sat Jan 25 12:25:07 2003
@@ -20,10 +20,24 @@
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
-	__gpl_ksymtab     : AT(ADDR(__gpl_ksymtab) - LOAD_OFFSET) {	\
-		__start___gpl_ksymtab = .;				\
-		*(__gpl_ksymtab)					\
-		__stop___gpl_ksymtab = .;				\
+	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
+		__start___ksymtab_gpl = .;				\
+		*(__ksymtab_gpl)					\
+		__stop___ksymtab_gpl = .;				\
+	}								\
+									\
+	/* Kernel symbol table: Normal symbols */			\
+	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
+		__start___kcrctab = .;					\
+		*(__kcrctab)						\
+		__stop___kcrctab = .;					\
+	}								\
+									\
+	/* Kernel symbol table: GPL-only symbols */			\
+	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
+		__start___kcrctab_gpl = .;				\
+		*(__kcrctab_gpl)					\
+		__stop___kcrctab_gpl = .;				\
 	}								\
 									\
 	/* Kernel symbol table: strings */				\
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Sat Jan 25 12:25:07 2003
+++ b/include/linux/module.h	Sat Jan 25 12:25:07 2003
@@ -134,29 +134,40 @@
 
 
 #ifdef CONFIG_MODULES
+
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
 #define symbol_get(x) ((typeof(&x))(__symbol_get(MODULE_SYMBOL_PREFIX #x)))
 
+#ifdef CONFIG_MODVERSIONING
+/* Mark the CRC weak since genksyms apparently decides not to
+ * generate a checksums for some symbols */
+#define __CRC_SYMBOL(sym, sec)					\
+	extern void *__crc_##sym __attribute__((weak));		\
+	static const unsigned long __kcrctab_##sym		\
+	__attribute__((section("__kcrctab" sec)))		\
+	= (unsigned long) &__crc_##sym;
+#else
+#define __CRC_SYMBOL(sym, sec)
+#endif
+
 /* For every exported symbol, place a struct in the __ksymtab section */
-#define EXPORT_SYMBOL(sym)					\
+#define __EXPORT_SYMBOL(sym, sec)				\
+	__CRC_SYMBOL(sym, sec)					\
 	static const char __kstrtab_##sym[]			\
 	__attribute__((section("__ksymtab_strings")))		\
 	= MODULE_SYMBOL_PREFIX #sym;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__ksymtab")))			\
+	__attribute__((section("__ksymtab" sec)))		\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
-#define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL(sym)	__EXPORT_SYMBOL(sym, "")
+#define EXPORT_SYMBOL_GPL(sym)	__EXPORT_SYMBOL(sym, "_gpl")
 
-#define EXPORT_SYMBOL_GPL(sym)					\
-	static const char __kstrtab_##sym[]			\
-	__attribute__((section("__ksymtab_strings")))		\
-	= MODULE_SYMBOL_PREFIX #sym;                    	\
-	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__gpl_ksymtab")))		\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+/* We don't mangle the actual symbol anymore, so no need for
+ * special casing EXPORT_SYMBOL_NOVERS */
+#define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
 
 struct module_ref
 {
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	Sat Jan 25 12:25:07 2003
+++ b/init/Kconfig	Sat Jan 25 12:25:07 2003
@@ -144,6 +144,19 @@
 	  have not been converted to the new module parameter system yet.
 	  If unsure, say Y.
 
+config MODVERSIONING
+	bool "Module versioning support (EXPERIMENTAL)"
+	depends on MODULES && EXPERIMENTAL
+	help
+	---help---
+	  Usually, you have to use modules compiled with your kernel.
+	  Saying Y here makes it sometimes possible to use modules
+	  compiled for different kernels, by adding enough information
+	  to the modules to (hopefully) spot any changes which would
+	  make them incompatible with the kernel you are running.  If
+	  you say Y here, you will need a copy of genksyms.  If
+	  unsure, say N.
+
 config KMOD
 	bool "Kernel module loader"
 	depends on MODULES
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Sat Jan 25 12:25:07 2003
+++ b/kernel/module.c	Sat Jan 25 12:25:07 2003
@@ -1040,6 +1040,11 @@
 			/* Exported symbols. */
 			DEBUGP("EXPORT table in section %u\n", i);
 			exportindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,
+				  "__ksymtab_gpl") == 0) {
+			/* Exported symbols. (GPL) */
+			DEBUGP("GPL symbols found in section %u\n", i);
+			gplindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__param")
 			   == 0) {
 			/* Setup parameter info */
@@ -1061,11 +1066,6 @@
 			DEBUGP("Licence found in section %u\n", i);
 			licenseindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  "__gpl_ksymtab") == 0) {
-			/* EXPORT_SYMBOL_GPL() */
-			DEBUGP("GPL symbols found in section %u\n", i);
-			gplindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name,
 				  "__vermagic") == 0) {
 			/* Version magic. */
 			DEBUGP("Version magic found in section %u\n", i);
@@ -1492,8 +1492,8 @@
 /* Provided by the linker */
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
-extern const struct kernel_symbol __start___gpl_ksymtab[];
-extern const struct kernel_symbol __stop___gpl_ksymtab[];
+extern const struct kernel_symbol __start___ksymtab_gpl[];
+extern const struct kernel_symbol __stop___ksymtab_gpl[];
 
 static struct kernel_symbol_group kernel_symbols, kernel_gpl_symbols;
 
@@ -1504,9 +1504,10 @@
 	kernel_symbols.syms = __start___ksymtab;
 	kernel_symbols.gplonly = 0;
 	list_add(&kernel_symbols.list, &symbols);
-	kernel_gpl_symbols.num_syms = (__stop___gpl_ksymtab
-				       - __start___gpl_ksymtab);
-	kernel_gpl_symbols.syms = __start___gpl_ksymtab;
+
+	kernel_gpl_symbols.num_syms = (__stop___ksymtab_gpl
+				       - __start___ksymtab_gpl);
+	kernel_gpl_symbols.syms = __start___ksymtab_gpl;
 	kernel_gpl_symbols.gplonly = 1;
 	list_add(&kernel_gpl_symbols.list, &symbols);
 
diff -Nru a/scripts/per-cpu-check.awk b/scripts/per-cpu-check.awk
--- a/scripts/per-cpu-check.awk	Sat Jan 25 12:25:07 2003
+++ b/scripts/per-cpu-check.awk	Sat Jan 25 12:25:07 2003
@@ -6,7 +6,7 @@
 	IN_PER_CPU=0
 }
 
-/__per_cpu$$/ && ! ( / __ksymtab_/ || / __kstrtab_/ ) {
+/__per_cpu$$/ && ! ( / __ksymtab_/ || / __kstrtab_/ || / __kcrctab_/ ) {
 	if (!IN_PER_CPU) {
 		print $$3 " not in per-cpu section" > "/dev/stderr";
 		FOUND=1;

-----------------------------------------------------------------------------
ChangeSet@1.961, 2003-01-24 21:45:27-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Generate versions for exported symbols
  
  Up to now, we had a way to store the checksums associated with the
  exported symbols, but they were not filled in yet. This is done
  with this patch, using the linker to actually do that for us.
    
  The comment added with this patch explains what magic exactly is going
  on.

  ---------------------------------------------------------------------------

diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Sat Jan 25 12:25:10 2003
+++ b/include/linux/module.h	Sat Jan 25 12:25:10 2003
@@ -140,6 +140,13 @@
 void *__symbol_get_gpl(const char *symbol);
 #define symbol_get(x) ((typeof(&x))(__symbol_get(MODULE_SYMBOL_PREFIX #x)))
 
+#ifdef __GENKSYMS__
+
+/* genksyms doesn't handle GPL-only symbols yet */
+#define EXPORT_SYMBOL_GPL EXPORT_SYMBOL
+	
+#else
+
 #ifdef CONFIG_MODVERSIONING
 /* Mark the CRC weak since genksyms apparently decides not to
  * generate a checksums for some symbols */
@@ -162,8 +169,13 @@
 	__attribute__((section("__ksymtab" sec)))		\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
-#define EXPORT_SYMBOL(sym)	__EXPORT_SYMBOL(sym, "")
-#define EXPORT_SYMBOL_GPL(sym)	__EXPORT_SYMBOL(sym, "_gpl")
+#define EXPORT_SYMBOL(sym)					\
+	__EXPORT_SYMBOL(sym, "")
+
+#define EXPORT_SYMBOL_GPL(sym)					\
+	__EXPORT_SYMBOL(sym, "_gpl")
+
+#endif
 
 /* We don't mangle the actual symbol anymore, so no need for
  * special casing EXPORT_SYMBOL_NOVERS */
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Sat Jan 25 12:25:10 2003
+++ b/scripts/Makefile.build	Sat Jan 25 12:25:10 2003
@@ -50,6 +50,55 @@
 	 $(subdir-ym) $(build-targets)
 	@:
 
+# Module versioning
+# ---------------------------------------------------------------------------
+
+ifdef CONFIG_MODVERSIONING
+
+# $(call if_changed_rule,vcc_o_c) does essentially the same as the
+# normal $(call if_changed_dep,cc_o_c), i.e. compile an object file
+# from a C file, keeping track of the command line and dependencies.
+#
+# However, actually it does:
+# o compile a .tmp_<file>.o from <file>.c
+# o if .tmp_<file>.o doesn't contain a __ksymtab version, i.e. does
+#   not export symbols, we just rename .tmp_<file>.o to <file>.o and
+#   are done.
+# o otherwise, we calculate symbol versions using the good old
+#   genksyms on the preprocessed source and postprocess them in a way
+#   that they are usable as a linker script
+# o generate <file>.o from .tmp_<file>.o using the linker to
+#   replace the unresolved symbols __crc_exported_symbol with
+#   the actual value of the checksum generated by genksyms
+
+quiet_cmd_vcc_o_c = CC $(quiet_modtag)  $@
+cmd_vcc_o_c       = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
+
+define rule_vcc_o_c
+	$(if $($(quiet)cmd_vcc_o_c),echo '  $($(quiet)cmd_vcc_o_c)';)	      \
+	$(cmd_vcc_o_c);							      \
+									      \
+	if ! $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	      \
+		mv $(@D)/.tmp_$(@F) $@;					      \
+	else								      \
+		$(CPP) -D__GENKSYMS__ $(c_flags) $<			      \
+		| $(GENKSYMS) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)	      \
+		| grep __ver						      \
+		| sed 's/\#define __ver_\([^ 	]*\)[ 	]*\([^ 	]*\)/__crc_\1 = 0x\2 ;/g' \
+		> $(@D)/.tmp_$(@F:.o=.ver);				      \
+									      \
+		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		      \
+			-T $(@D)/.tmp_$(@F:.o=.ver);			      \
+		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);	      \
+	fi;			
+					      \
+	scripts/fixdep $(depfile) $@ '$(cmd_vcc_o_c)' > $(@D)/.$(@F).tmp;     \
+	rm -f $(depfile);						      \
+	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
+endef
+
+endif
+
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------
 
@@ -97,7 +146,11 @@
 cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
 
 %.o: %.c FORCE
+ifdef CONFIG_MODVERSIONING
+	$(call if_changed_rule,vcc_o_c)
+else
 	$(call if_changed_dep,cc_o_c)
+endif
 
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \

-----------------------------------------------------------------------------
ChangeSet@1.962, 2003-01-24 21:47:14-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Check __vermagic for validity
  
  modprobe --force allows to load modules without a matching version
  magic string. This invalidation is done by clearing the SHF_ALLOC
  flag, so check it in the kernel. Also, clear the SHF_ALLOC flag
  unconditionally, since we don't need to store the __vermagic section
  in the kernel, it's only checked once at load time. 

  ---------------------------------------------------------------------------

diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Sat Jan 25 12:25:12 2003
+++ b/kernel/module.c	Sat Jan 25 12:25:12 2003
@@ -1066,10 +1066,12 @@
 			DEBUGP("Licence found in section %u\n", i);
 			licenseindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  "__vermagic") == 0) {
+				  "__vermagic") == 0 &&
+			   (sechdrs[i].sh_flags & SHF_ALLOC)) {
 			/* Version magic. */
 			DEBUGP("Version magic found in section %u\n", i);
 			vmagindex = i;
+			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
 		}
 #ifdef CONFIG_KALLSYMS
 		/* symbol and string tables for decoding later. */
@@ -1090,7 +1092,7 @@
 	}
 	mod = (void *)sechdrs[modindex].sh_addr;
 
-	/* This is allowed: modprobe --force will strip it. */
+	/* This is allowed: modprobe --force will invalidate it. */
 	if (!vmagindex) {
 		tainted |= TAINT_FORCED_MODULE;
 		printk(KERN_WARNING "%s: no version magic, tainting kernel.\n",

-----------------------------------------------------------------------------
ChangeSet@1.963, 2003-01-24 21:48:27-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Don't save the license string
  
  Again, the license string is only used at load time, so no need
  to store it permanently in kernel memory.

  ---------------------------------------------------------------------------

diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Sat Jan 25 12:25:15 2003
+++ b/kernel/module.c	Sat Jan 25 12:25:15 2003
@@ -1065,6 +1065,7 @@
 			/* MODULE_LICENSE() */
 			DEBUGP("Licence found in section %u\n", i);
 			licenseindex = i;
+			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
 				  "__vermagic") == 0 &&
 			   (sechdrs[i].sh_flags & SHF_ALLOC)) {

-----------------------------------------------------------------------------
ChangeSet@1.964, 2003-01-24 21:49:33-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Track versions of exported symbols
  
  Store the information on the checksum alongside the rest of the 
  information on exported symbols. To actually use them, we need
  something to check them against first, though ;)
  
  Also, fix some conditional debug code to actually compile.

  ---------------------------------------------------------------------------

diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Sat Jan 25 12:25:18 2003
+++ b/include/linux/module.h	Sat Jan 25 12:25:18 2003
@@ -119,6 +119,7 @@
 
 	unsigned int num_syms;
 	const struct kernel_symbol *syms;
+	const unsigned long *crcs;
 };
 
 /* Given an address, look for it in the exception tables */
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Sat Jan 25 12:25:18 2003
+++ b/kernel/module.c	Sat Jan 25 12:25:18 2003
@@ -916,7 +916,7 @@
 			    || strstr(secstrings + s->sh_name, ".init"))
 				continue;
 			s->sh_entsize = get_offset(&mod->core_size, s);
-			DEBUGP("\t%s\n", name);
+			DEBUGP("\t%s\n", secstrings + s->sh_name);
 		}
 	}
 
@@ -932,7 +932,7 @@
 				continue;
 			s->sh_entsize = (get_offset(&mod->init_size, s)
 					 | INIT_OFFSET_MASK);
-			DEBUGP("\t%s\n", name);
+			DEBUGP("\t%s\n", secstrings + s->sh_name);
 		}
 	}
 }
@@ -976,7 +976,8 @@
 	Elf_Shdr *sechdrs;
 	char *secstrings, *args;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modindex, obsparmindex, licenseindex, gplindex, vmagindex;
+		modindex, obsparmindex, licenseindex, gplindex, vmagindex,
+		crcindex, gplcrcindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1012,7 +1013,8 @@
 
 	/* May not export symbols, or have setup params, so these may
            not exist */
-	exportindex = setupindex = obsparmindex = gplindex = licenseindex = 0;
+	exportindex = setupindex = obsparmindex = gplindex = licenseindex 
+		= crcindex = gplcrcindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = exindex = modindex = vmagindex = 0;
@@ -1045,6 +1047,16 @@
 			/* Exported symbols. (GPL) */
 			DEBUGP("GPL symbols found in section %u\n", i);
 			gplindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__kcrctab")
+			   == 0) {
+			/* Exported symbols CRCs. */
+			DEBUGP("CRC table in section %u\n", i);
+			crcindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__kcrctab_gpl")
+			   == 0) {
+			/* Exported symbols CRCs. (GPL)*/
+			DEBUGP("CRC table in section %u\n", i);
+			gplcrcindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__param")
 			   == 0) {
 			/* Setup parameter info */
@@ -1192,9 +1204,11 @@
 	mod->symbols.num_syms = (sechdrs[exportindex].sh_size
 				 / sizeof(*mod->symbols.syms));
 	mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
+	mod->symbols.crcs = (void *)sechdrs[crcindex].sh_addr;
 	mod->gpl_symbols.num_syms = (sechdrs[gplindex].sh_size
 				 / sizeof(*mod->symbols.syms));
 	mod->gpl_symbols.syms = (void *)sechdrs[gplindex].sh_addr;
+	mod->gpl_symbols.crcs = (void *)sechdrs[gplcrcindex].sh_addr;
 
 	/* Set up exception table */
 	if (exindex) {
@@ -1497,6 +1511,10 @@
 extern const struct kernel_symbol __stop___ksymtab[];
 extern const struct kernel_symbol __start___ksymtab_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
+extern const unsigned long __start___kcrctab[];
+extern const unsigned long __stop___kcrctab[];
+extern const unsigned long __start___kcrctab_gpl[];
+extern const unsigned long __stop___kcrctab_gpl[];
 
 static struct kernel_symbol_group kernel_symbols, kernel_gpl_symbols;
 
@@ -1505,12 +1523,14 @@
 	/* Add kernel symbols to symbol table */
 	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
 	kernel_symbols.syms = __start___ksymtab;
+	kernel_symbols.crcs = __start___kcrctab;
 	kernel_symbols.gplonly = 0;
 	list_add(&kernel_symbols.list, &symbols);
 
 	kernel_gpl_symbols.num_syms = (__stop___ksymtab_gpl
 				       - __start___ksymtab_gpl);
 	kernel_gpl_symbols.syms = __start___ksymtab_gpl;
+	kernel_gpl_symbols.crcs = __start___kcrctab_gpl;
 	kernel_gpl_symbols.gplonly = 1;
 	list_add(&kernel_gpl_symbols.list, &symbols);
 

-----------------------------------------------------------------------------
ChangeSet@1.965, 2003-01-24 21:51:36-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Always link module (.ko) from associated (.o)
  
  For extracting the versions and finding the unresolved symbols, we
  need multi-part modules to be linked together already, so this
  patch separates the building of the modules as a .o file from generating
  the .ko in the next step.

  ---------------------------------------------------------------------------

diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Sat Jan 25 12:25:20 2003
+++ b/scripts/Makefile.build	Sat Jan 25 12:25:20 2003
@@ -224,15 +224,7 @@
 cmd_link_multi-y = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs))) $($(subst $(obj)/,,$(@:.o=-y)))),$^)
 
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.ko=-objs))) $($(subst $(obj)/,,$(@:.ko=-y)))),$^) init/vermagic.o
-
-quiet_cmd_link_single-m = LD [M]  $@
-cmd_link_single-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $< init/vermagic.o
-
-# Don't rebuilt vermagic.o unless we actually are in the init/ dir
-ifneq ($(obj),init)
-init/vermagic.o: ;
-endif
+cmd_link_multi-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs))) $($(subst $(obj)/,,$(@:.o=-y)))),$^)
 
 # We would rather have a list of rules like
 # 	foo.o: $(foo-objs)
@@ -241,13 +233,27 @@
 $(multi-used-y) : %.o: $(multi-objs-y) FORCE
 	$(call if_changed,link_multi-y)
 
-$(multi-used-m:.o=.ko) : %.ko: $(multi-objs-m) init/vermagic.o FORCE
+$(multi-used-m) : %.o: $(multi-objs-m) FORCE
+	$(touch-module)
 	$(call if_changed,link_multi-m)
 
-$(single-used-m:.o=.ko) : %.ko: %.o init/vermagic.o FORCE
-	$(call if_changed,link_single-m)
+targets += $(multi-used-y) $(multi-used-m)
+
+#
+# Rule to link modules ( .o -> .ko )
+#
+quiet_cmd_link_module = LD [M]  $@
+cmd_link_module = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $< init/vermagic.o
+
+# Don't rebuilt vermagic.o unless we actually are in the init/ dir
+ifneq ($(obj),init)
+init/vermagic.o: ;
+endif
+
+$(single-used-m:.o=.ko) $(multi-used-m:.o=.ko): %.ko: %.o init/vermagic.o FORCE
+	$(call if_changed,link_module)
 
-targets += $(multi-used-y) $(multi-used-m:.o=.ko) $(single-used-m:.o=.ko)
+targets += $(single-used-m:.o=.ko) $(multi-used-m:.o=.ko)
 
 # Compile programs on the host
 # ===========================================================================

-----------------------------------------------------------------------------
ChangeSet@1.966, 2003-01-24 21:52:47-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Don't build final .ko yet when descending with CONFIG_MODVERSIONING
  
  With CONFIG_MODVERSIONING, we need to record the versions of the unresolved
  symbols in the final <module>.ko, which we only know after we finished
  the descending build. So we only build <module>.o in that case.
    
  Also, keep track of the modules we built, the post-processing step needs
  a list of all modules. Keeping track is done by touching
  .tmp_versions/path/to/module.ko

  ---------------------------------------------------------------------------

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Jan 25 12:25:23 2003
+++ b/Makefile	Sat Jan 25 12:25:23 2003
@@ -260,6 +260,20 @@
 CFLAGS		+= -fomit-frame-pointer
 endif
 
+#	When we're building modules with modversions, we need to consider
+#	the built-in objects during the descend as well, in order to
+#	make sure the checksums are uptodate before we use them.
+
+ifdef CONFIG_MODVERSIONING
+ifeq ($(KBUILD_MODULES),1)
+ifneq ($(KBUILD_BUILTIN),1)
+  KBUILD_BUILTIN := 1
+endif
+endif
+endif
+
+export MODVERDIR := .tmp_versions
+
 #
 # INSTALL_PATH specifies where to place the updated kernel and system map
 # images.  Uncomment if you want to place them anywhere other than root.
@@ -388,6 +402,16 @@
 
 .PHONY: prepare
 prepare: include/linux/version.h include/asm include/config/MARKER
+ifdef CONFIG_MODVERSIONING
+ifdef KBUILD_MODULES
+ifeq ($(origin SUBDIRS),file)
+	$(Q)rm -rf $(MODVERDIR)
+else
+	@echo '*** Warning: Overriding SUBDIRS on the command line can cause'
+	@echo '***          inconsistencies with module symbol versions'
+endif
+endif
+endif
 	@echo '  Starting the build. KBUILD_BUILTIN=$(KBUILD_BUILTIN) KBUILD_MODULES=$(KBUILD_MODULES)'
 
 #	We need to build init/vermagic.o before descending since all modules
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Sat Jan 25 12:25:23 2003
+++ b/scripts/Makefile.build	Sat Jan 25 12:25:23 2003
@@ -45,8 +45,15 @@
 endif
 endif
 
+ifdef CONFIG_MODVERSIONING
+modules := $(obj-m)
+touch-module = @mkdir -p $(MODVERDIR)/$(@D); touch $(MODVERDIR)/$(@:.o=.ko)
+else
+modules := $(obj-m:.o=.ko)
+endif
+
 __build: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
-	 $(if $(KBUILD_MODULES),$(obj-m:.o=.ko)) \
+	 $(if $(KBUILD_MODULES),$(modules)) \
 	 $(subdir-ym) $(build-targets)
 	@:
 
@@ -152,6 +159,15 @@
 	$(call if_changed_dep,cc_o_c)
 endif
 
+# For modversioning, we need to special case single-part modules
+# to mark them in $(MODVERDIR)
+
+ifdef CONFIG_MODVERSIONING
+$(single-used-m): %.o: %.c FORCE
+	$(touch-module)
+	$(call if_changed_rule,vcc_o_c)
+endif
+
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
 		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
@@ -242,6 +258,11 @@
 #
 # Rule to link modules ( .o -> .ko )
 #
+
+# With CONFIG_MODVERSIONING, generation of the final .ko is handled
+# by scripts/Makefile.modver
+ifndef CONFIG_MODVERSIONING
+
 quiet_cmd_link_module = LD [M]  $@
 cmd_link_module = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $< init/vermagic.o
 
@@ -254,6 +275,8 @@
 	$(call if_changed,link_module)
 
 targets += $(single-used-m:.o=.ko) $(multi-used-m:.o=.ko)
+
+endif
 
 # Compile programs on the host
 # ===========================================================================

-----------------------------------------------------------------------------
ChangeSet@1.967, 2003-01-24 21:54:04-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Record versions for unresolved symbols
  
  In the case of CONFIG_MODVERSIONING, the build step will only
  generate preliminary <module>.o objects, and an additional
  postprocessing step is necessary to record the versions of the unresolved
  symbols and add them into the final <module>.ko
    
  The version information for unresolved symbols is again recorded into
  a special section, "__versions", which contains an array of symbol
  name strings and checksum (struct modversion_info). Size is here not
  an issue, since this section will not be stored permanently in kernel
  memory.
    
  Makefile.modver takes care of the following steps:
  o Collect the version information for all exported symbols from vmlinux
    and all modules which export symbols.
  o For each module, generate a C file which contains the modversion
    information for all unresolved symbols in that module.
  o For each module, compile that C file to an object file
  o Finally, link the <module>.ko using the preliminary <module.o> + the
    version information above.
    
  The first two steps are currently done by not very efficient scripting,
  so there's room for performance improvement using some helper C code.

  ---------------------------------------------------------------------------

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Jan 25 12:25:26 2003
+++ b/Makefile	Sat Jan 25 12:25:26 2003
@@ -262,7 +262,7 @@
 
 #	When we're building modules with modversions, we need to consider
 #	the built-in objects during the descend as well, in order to
-#	make sure the checksums are uptodate before we use them.
+#	make sure the checksums are uptodate before we record them.
 
 ifdef CONFIG_MODVERSIONING
 ifeq ($(KBUILD_MODULES),1)
@@ -508,8 +508,16 @@
 
 #	Build modules
 
-.PHONY: modules
-modules: $(SUBDIRS)
+.PHONY: modules __modversions
+modules: $(SUBDIRS) __modversions
+
+ifdef CONFIG_MODVERSIONING
+
+__modversions: vmlinux $(SUBDIRS)
+	@echo '  Recording module symbol versions.';
+	$(Q)$(MAKE) -rR -f scripts/Makefile.modver
+
+endif
 
 #	Install modules
 
@@ -690,6 +698,7 @@
 
 # Directories removed with 'make mrproper'
 MRPROPER_DIRS += \
+	$(MODVERDIR) \
 	.tmp_export-objs \
 	include/config \
 	include/linux/modules
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Sat Jan 25 12:25:26 2003
+++ b/include/linux/module.h	Sat Jan 25 12:25:26 2003
@@ -33,10 +33,17 @@
 #endif
 
 #define MODULE_NAME_LEN (64 - sizeof(unsigned long))
+
 struct kernel_symbol
 {
 	unsigned long value;
 	const char *name;
+};
+
+struct modversion_info
+{
+	unsigned long crc;
+	char name[MODULE_NAME_LEN];
 };
 
 /* These are either module local, or the kernel's dummy ones. */
diff -Nru a/scripts/Makefile.modver b/scripts/Makefile.modver
--- a/scripts/Makefile.modver	Sat Jan 25 12:25:26 2003
+++ b/scripts/Makefile.modver	Sat Jan 25 12:25:26 2003
@@ -2,3 +2,92 @@
 # Module versions
 # ===========================================================================
 
+.PHONY: __modversions
+__modversions:
+
+include scripts/Makefile.lib
+
+#
+
+modules := $(patsubst ./%,%,$(shell cd $(MODVERDIR); find . -name \*.ko))
+
+__modversions: $(modules)
+	@:
+
+quiet_cmd_ld_ko_o = LD [M]  $@
+      cmd_ld_ko_o = $(LD) $(LDFLAGS) $(LDFLAGS_MODULE) -o $@ 		\
+			  $(filter-out FORCE,$^)
+
+init/vermagic.o: ;
+
+$(modules): %.ko :%.o $(MODVERDIR)/%.o init/vermagic.o FORCE
+	$(call if_changed,ld_ko_o)
+
+targets += $(modules)
+
+
+quiet_cmd_cc_o_c = CC      $@
+      cmd_cc_o_c = $(CC) $(CFLAGS) -c -o $@ $<
+
+$(addprefix $(MODVERDIR)/,$(modules:.ko=.o)): %.o: %.c FORCE
+	$(call if_changed,cc_o_c)
+
+targets += $(addprefix $(MODVERDIR)/,$(modules:.ko=.o))
+
+define rule_mkver_o_c
+	echo '  MKVER   $@';						\
+	( echo "#include <linux/module.h>";				\
+	  echo "";							\
+	  echo "static const struct modversion_info ____versions[]";	\
+	  echo "__attribute__((section(\"__versions\"))) = {"; 	\
+	  for sym in `nm -u $<`; do					\
+		grep "\"$$sym\"" .tmp_all-versions			\
+		|| echo "*** Warning: $(<:.o=.ko): \"$$sym\" unresolved!" >&2;\
+	  done;								\
+	  echo "};";							\
+	) > $@
+endef
+
+$(addprefix $(MODVERDIR)/,$(modules:.ko=.c)):				\
+$(MODVERDIR)/%.c: %.o .tmp_all-versions FORCE
+	$(call if_changed_rule,mkver_o_c)
+
+targets += $(addprefix $(MODVERDIR)/,$(modules:.ko=.o.c))
+
+export-objs := $(shell for m in vmlinux $(modules:.ko=.o); do objdump -h $$m | grep -q __ksymtab && echo $$m; done)
+
+cmd_gen-all-versions = mksyms $(export-objs)
+define rule_gen-all-versions
+	echo '  MKSYMS  $@';						\
+	for mod in $(export-objs); do					\
+		modname=`basename $$mod`;				\
+		nm $$mod 						\
+		| grep ' __crc_'					\
+		| sed "s/\([^ ]*\) A __crc_\(.*\)/{ 0x\1, \"\2\" }, \/* $$modname *\//g;s/.* w __crc_\(.*\)/{ 0x0       , \"\1\" }, \/* $$modname *\//g"; \
+	done > $@;							\
+	echo 'cmd_$@ := $(cmd_$(1))' > $(@D)/.$(@F).cmd
+endef
+
+.tmp_all-versions: $(export-objs) FORCE
+	$(call if_changed_rule,gen-all-versions)
+
+targets += .tmp_all-versions
+
+# Add FORCE to the prequisites of a target to force it to be always rebuilt.
+# ---------------------------------------------------------------------------
+
+.PHONY: FORCE
+
+FORCE:
+
+# Read all saved command lines and dependencies for the $(targets) we
+# may be building above, using $(if_changed{,_dep}). As an
+# optimization, we don't need to read them if the target does not
+# exist, we will rebuild anyway in that case.
+
+targets := $(wildcard $(sort $(targets)))
+cmd_files := $(wildcard $(foreach f,$(targets),$(dir $(f)).$(notdir $(f)).cmd))
+
+ifneq ($(cmd_files),)
+  include $(cmd_files)
+endif

-----------------------------------------------------------------------------
ChangeSet@1.968, 2003-01-24 21:54:53-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Return the index of the symbol from __find_symbol()
  
  We'll need that index to find the version checksum for the symbol in
  a bit.

  ---------------------------------------------------------------------------

diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Sat Jan 25 12:25:28 2003
+++ b/kernel/module.c	Sat Jan 25 12:25:28 2003
@@ -78,6 +78,7 @@
 /* Find a symbol, return value and the symbol group */
 static unsigned long __find_symbol(const char *name,
 				   struct kernel_symbol_group **group,
+				   unsigned int *symidx,
 				   int gplok)
 {
 	struct kernel_symbol_group *ks;
@@ -90,6 +91,8 @@
 		for (i = 0; i < ks->num_syms; i++) {
 			if (strcmp(ks->syms[i].name, name) == 0) {
 				*group = ks;
+				if (symidx)
+					*symidx = i;
 				return ks->syms[i].value;
 			}
 		}
@@ -520,7 +523,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &ksg, 1))
+	if (!__find_symbol(symbol, &ksg, NULL, 1))
 		BUG();
 	module_put(ksg->owner);
 	spin_unlock_irqrestore(&modlist_lock, flags);
@@ -732,9 +735,10 @@
 {
 	struct kernel_symbol_group *ksg;
 	unsigned long ret;
+	unsigned int symidx;
 
 	spin_lock_irq(&modlist_lock);
-	ret = __find_symbol(name, &ksg, mod->license_gplok);
+	ret = __find_symbol(name, &ksg, &symidx, mod->license_gplok);
 	if (ret) {
 		/* This can fail due to OOM, or module unloading */
 		if (!use_module(mod, ksg->owner))
@@ -772,7 +776,7 @@
 	unsigned long value, flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	value = __find_symbol(symbol, &ksg, 1);
+	value = __find_symbol(symbol, &ksg, NULL, 1);
 	if (value && !strong_try_module_get(ksg->owner))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);

-----------------------------------------------------------------------------
ChangeSet@1.969, 2003-01-24 21:55:37-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/modules: Check module symbol versions on insmod
  
  Yeah, the final step!
    
  Now that we've got the checksums for the exported symbols and the
  checksums of the unresolved symbols for the module we're loading,
  let's compare and see.
    
  Again, we allow to load a module which has the version info stripped,
  but taint the kernel in that case.

  ---------------------------------------------------------------------------

diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Sat Jan 25 12:25:31 2003
+++ b/kernel/module.c	Sat Jan 25 12:25:31 2003
@@ -725,11 +725,66 @@
 }
 #endif /* CONFIG_OBSOLETE_MODPARM */
 
+#ifdef CONFIG_MODVERSIONING
+static int check_version(Elf_Shdr *sechdrs,
+			 unsigned int versindex,
+			 const char *symname,
+			 struct module *mod, 
+			 struct kernel_symbol_group *ksg,
+			 unsigned int symidx)
+{
+	unsigned long crc;
+	unsigned int i, num_versions;
+	struct modversion_info *versions;
+
+	if (!ksg->crcs) { 
+		printk("%s: no CRC for \"%s\" [%s] found: kernel tainted.\n",
+		       mod->name, symname, 
+		       ksg->owner ? ksg->owner->name : "kernel");
+		goto taint;
+	}
+
+	crc = ksg->crcs[symidx];
+
+	versions = (void *) sechdrs[versindex].sh_addr;
+	num_versions = sechdrs[versindex].sh_size
+		/ sizeof(struct modversion_info);
+
+	for (i = 0; i < num_versions; i++) {
+		if (strcmp(versions[i].name, symname) != 0)
+			continue;
+
+		if (versions[i].crc == crc)
+			return 1;
+		printk("%s: disagrees about version of symbol %s\n",
+		       mod->name, symname);
+		DEBUGP("Found checksum %lX vs module %lX\n",
+		       crc, versions[i].crc);
+		return 0;
+	}
+	/* Not in module's version table.  OK, but that taints the kernel. */
+	printk("%s: no version for \"%s\" found: kernel tainted.\n",
+	       mod->name, symname);
+ taint:
+	tainted |= TAINT_FORCED_MODULE;
+	return 1;
+}
+#else
+static inline int check_version(Elf_Shdr *sechdrs,
+				unsigned int versindex,
+				const char *symname,
+				struct module *mod, 
+				struct kernel_symbol_group *ksg,
+				unsigned int symidx)
+{
+	return 1;
+}
+#endif /* CONFIG_MODVERSIONING */
+
 /* Resolve a symbol for this module.  I.e. if we find one, record usage.
    Must be holding module_mutex. */
 static unsigned long resolve_symbol(Elf_Shdr *sechdrs,
-				    unsigned int symindex,
-				    const char *strtab,
+				    unsigned int versindex,
 				    const char *name,
 				    struct module *mod)
 {
@@ -740,8 +795,10 @@
 	spin_lock_irq(&modlist_lock);
 	ret = __find_symbol(name, &ksg, &symidx, mod->license_gplok);
 	if (ret) {
-		/* This can fail due to OOM, or module unloading */
-		if (!use_module(mod, ksg->owner))
+		/* use_module can fail due to OOM, or module unloading */
+		if (!check_version(sechdrs, versindex, name, mod,
+				   ksg, symidx) ||
+		    !use_module(mod, ksg->owner))
 			ret = 0;
 	}
 	spin_unlock_irq(&modlist_lock);
@@ -828,6 +885,7 @@
 static int simplify_symbols(Elf_Shdr *sechdrs,
 			    unsigned int symindex,
 			    unsigned int strindex,
+			    unsigned int versindex,
 			    struct module *mod)
 {
 	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
@@ -852,7 +910,7 @@
 
 		case SHN_UNDEF:
 			sym[i].st_value
-			  = resolve_symbol(sechdrs, symindex, strtab,
+			  = resolve_symbol(sechdrs, versindex,
 					   strtab + sym[i].st_name, mod);
 
 			/* Ok if resolved.  */
@@ -981,7 +1039,7 @@
 	char *secstrings, *args;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
 		modindex, obsparmindex, licenseindex, gplindex, vmagindex,
-		crcindex, gplcrcindex;
+		crcindex, gplcrcindex, versindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1018,7 +1076,7 @@
 	/* May not export symbols, or have setup params, so these may
            not exist */
 	exportindex = setupindex = obsparmindex = gplindex = licenseindex 
-		= crcindex = gplcrcindex = 0;
+		= crcindex = gplcrcindex = versindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = exindex = modindex = vmagindex = 0;
@@ -1089,6 +1147,13 @@
 			DEBUGP("Version magic found in section %u\n", i);
 			vmagindex = i;
 			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,
+				  "__versions") == 0 &&
+			   (sechdrs[i].sh_flags & SHF_ALLOC)) {
+			/* Module version info (both exported and needed) */
+			DEBUGP("Versions found in section %u\n", i);
+			versindex = i;
+			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
 		}
 #ifdef CONFIG_KALLSYMS
 		/* symbol and string tables for decoding later. */
@@ -1200,7 +1265,7 @@
 	set_license(mod, sechdrs, licenseindex);
 
 	/* Fix up syms, so that st_value is a pointer to location. */
-	err = simplify_symbols(sechdrs, symindex, strindex, mod);
+	err = simplify_symbols(sechdrs, symindex, strindex, versindex, mod);
 	if (err < 0)
 		goto cleanup;
 


