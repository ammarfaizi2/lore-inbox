Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbSJCCxv>; Wed, 2 Oct 2002 22:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262720AbSJCCxv>; Wed, 2 Oct 2002 22:53:51 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:7568 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262719AbSJCCxf>; Wed, 2 Oct 2002 22:53:35 -0400
Date: Wed, 2 Oct 2002 21:59:00 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: kbuild-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: RfC: Don't cd into subdirs during kbuild
Message-ID: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'd appreciate to get comments on the appended patch. It's mostly cleanups 
and the like, but the interesting part is the last cset, which is actually
fairly small:

 14 files changed, 64 insertions(+), 47 deletions(-)

The build process remains recursive, but it changes the recursion
from 

	make -C subdir

to

	make -f subdir/Makefile

i.e. the current working directory remains the top dir for all times. So 
gcc/ld/.. are now called from the topdir, allowing to closer resemble 
a non-recursive build. Some Makefiles may need a little additional 
tweaking (in particular arch/*), but generally, the changes required are 
pretty small.

I'd appreciate comments and/or testing, if I hear no complaints, it'll go 
to Linus soon ;)

--Kai


Pull from http://linux-isdn.bkbits.net/linux-2.5.make

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.675, 2002-10-02 14:23:38-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Small cleanups
  
  o Use a function "descend" for descending into subdirectories
  o Remove unused (?) "boot" target
  o Remove unnecessary intermediate "sub_dirs" target from Rules.make
  o Use /bin/true instead of echo -n to suppress spurious
    "nothing to be done for ..." output from make

 ----------------------------------------------------------------------------
 Makefile   |   53 +++++++++++++++++++++++++----------------------------
 Rules.make |   27 +++++++++++++++------------
 2 files changed, 40 insertions(+), 40 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.676, 2002-10-02 14:42:00-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Remove xfs vpath hack
  
  xfs.o is built as one modules out of objects distributed into
  multiple subdirs. That is okay with the current kbuild, you just
  have to include the path for objects which reside in a subdir, then.
  
  xfs used vpath instead of explicitly adding the paths, which is
  inconsistent and conflicts e.g. with proper module version generation.

 ----------------------------------------------------------------------------
 Rules.make      |    3 +--
 fs/xfs/Makefile |   27 +++++++++++++--------------
 2 files changed, 14 insertions(+), 16 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.677, 2002-10-02 14:46:16-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Standardize ACPI Makefiles
  
  ACPI was a bit lazy and just said compile all .c files in this directory,
  which is different from all other Makefiles and will not work very
  well e.g. bk, where a .c file may not be checked out yet, or separate
  obj/src dirs. So just explicitly list the files we want to compile.

 ----------------------------------------------------------------------------
 dispatcher/Makefile |    3 ++-
 events/Makefile     |    3 ++-
 executer/Makefile   |    5 ++++-
 hardware/Makefile   |    2 +-
 namespace/Makefile  |    4 +++-
 parser/Makefile     |    3 ++-
 resources/Makefile  |    3 ++-
 tables/Makefile     |    3 ++-
 utilities/Makefile  |    3 ++-
 9 files changed, 20 insertions(+), 9 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.678, 2002-10-02 14:54:37-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Small quirks for separate obj / src trees
  
  Add a couple of missing $(obj) and the like.
  
  Also, remove the __chmod hack which made some files in the source tree
  executable - hopefully, everybody's copy is by now ;)

 ----------------------------------------------------------------------------
 drivers/isdn/hisax/Makefile |    2 +-
 drivers/pci/Makefile        |    2 +-
 drivers/zorro/Makefile      |    2 +-
 scripts/Makefile            |   11 +++--------
 scripts/lxdialog/Makefile   |    6 +++++-
 5 files changed, 11 insertions(+), 12 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.679, 2002-10-02 14:59:28-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Add some bug traps
  
  Makefiles which still use obsolete 2.4 constructs now give a warning.

 ----------------------------------------------------------------------------
 Rules.make |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.680, 2002-10-02 16:29:37-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Handle $(core-y) the same way as $(init-y), $(drivers-y) etc
  
  $(CORE_FILES) did not quite follow the way the other vmlinux parts where
  handled, due to potential init order dependencies. However, it seems
  everybody is putting arch specific stuff in front, so we keep doing
  this and nothing should break ;)

 ----------------------------------------------------------------------------
 Makefile |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.681, 2002-10-02 16:57:45-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Use $(core-y) and friends directly
  
  The capitalized aliases $(CORE_FILES) etc are basically superfluous now,
  move the remaining users to $(core-y) and the like.

 ----------------------------------------------------------------------------
 Makefile                    |   42 +++++++++++++++++++-----------------------
 arch/alpha/Makefile         |    2 ++
 arch/alpha/boot/Makefile    |    2 +-
 arch/sparc/Makefile         |    3 +--
 arch/sparc/boot/Makefile    |    5 ++---
 drivers/isdn/i4l/isdn_ppp.h |    2 +-
 6 files changed, 26 insertions(+), 30 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.682, 2002-10-02 17:52:22-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Always build helpers in script/
  
  As noticed by Sam Ravnborg, we need the targets in scripts (fixdep,
  in particular) considered always, i.e. also when compiling modules.

 ----------------------------------------------------------------------------
 Makefile |    5 +++++
 1 files changed, 5 insertions(+)

-----------------------------------------------------------------------------
ChangeSet@1.683, 2002-10-02 21:51:28-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Don't cd into subdirs during build
  
  Instead of using make -C <subdir>, just use make -f <subdir>/Makefile.
  This means we now call gcc/ld/... always from the topdir.
  
  Advantages are:
  o We don't need to use -I$(TOPDIR)/include and the like, just 
    -Iinclude works.
  o __FILE__ gives the correct relative path from the topdir instead
    of an absolute path, as it did before for included headers
  o gcc errors/warnings give the correct relative path from the topdir
  o takes us a step closer to a non-recursive build (though that's probably
    as close as it gets)
  
  The changes to Rules.make were done in a way which only uses the new way
  for the standard recursive build (which remains recursive, just without
  cd), all the archs do make -C arch/$(ARCH)/boot ..., which should keep
  working as before. However, of course this should be converted eventually,
  it's possible to do so piecemeal arch by arch.
  
  It seems to work fine for most of the standard kernel. Potential places
  which need changing are added -I flags to the command line, which now
  need to have the path relative to the topdir and explicit rules for
  generating files, which need to properly use $(obj) / $(src) to work
  correctly.

 ----------------------------------------------------------------------------
 Rules.make                        |   79 +++++++++++++++++++++++---------------
 arch/i386/Makefile                |    4 -
 arch/i386/boot/Makefile           |    2 
 drivers/acpi/Makefile             |    2 
 drivers/ide/arm/Makefile          |    2 
 drivers/ide/legacy/Makefile       |    2 
 drivers/ide/pci/Makefile          |    2 
 drivers/ide/ppc/Makefile          |    2 
 drivers/message/fusion/Makefile   |    2 
 drivers/net/sk98lin/Makefile      |    2 
 drivers/net/skfp/Makefile         |    2 
 drivers/scsi/sym53c8xx_2/Makefile |    2 
 drivers/usb/storage/Makefile      |    2 
 fs/xfs/Makefile                   |    6 +-
 14 files changed, 64 insertions(+), 47 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================

-----------------------------------------------------------------------------
ChangeSet@1.675, 2002-10-02 14:23:38-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Small cleanups
  
  o Use a function "descend" for descending into subdirectories
  o Remove unused (?) "boot" target
  o Remove unnecessary intermediate "sub_dirs" target from Rules.make
  o Use /bin/true instead of echo -n to suppress spurious
    "nothing to be done for ..." output from make

  ---------------------------------------------------------------------------

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Oct  2 21:51:56 2002
+++ b/Makefile	Wed Oct  2 21:51:56 2002
@@ -52,13 +52,6 @@
 
 all:	vmlinux
 
-#	Print entire command lines instead of short version
-#	For now, leave the default
-
-ifndef KBUILD_VERBOSE
-  KBUILD_VERBOSE = 1
-endif
-
 # 	Decide whether to build built-in, modular, or both.
 #	Normally, just do built-in.
 
@@ -105,6 +98,12 @@
 # If it is set to "silent_", nothing wil be printed at all, since
 # the variable $(silent_cmd_cc_o_c) doesn't exist.
 
+#	For now, leave verbose as default
+
+ifndef KBUILD_VERBOSE
+  KBUILD_VERBOSE = 1
+endif
+
 #	If the user wants quiet mode, echo short versions of the commands 
 #	only and suppress the 'Entering/Leaving directory' messages
 
@@ -120,7 +119,7 @@
   quiet=silent_
 endif
 
-export quiet
+export quiet KBUILD_VERBOSE
 
 #
 # Include the make variables (CC, etc...)
@@ -183,7 +182,7 @@
 
 .PHONY: scripts
 scripts:
-	@$(MAKE) -C scripts
+	@$(call descend,scripts,)
 
 ifeq ($(filter $(noconfig_targets),$(MAKECMDGOALS)),)
 
@@ -276,12 +275,6 @@
 
 export	NETWORKS DRIVERS LIBS HEAD LDFLAGS MAKEBOOT
 
-# boot target
-# ---------------------------------------------------------------------------
-
-boot: vmlinux
-	@$(MAKE) -C arch/$(ARCH)/boot
-
 # Build vmlinux
 # ---------------------------------------------------------------------------
 
@@ -314,7 +307,7 @@
 	echo '  Generating build number'
 	. scripts/mkversion > .tmp_version
 	mv -f .tmp_version .version
-	+$(MAKE) -C init
+	+$(call descend,init,)
 	$(call cmd,link_vmlinux)
 	echo 'cmd_$@ := $(cmd_link_vmlinux)' > $(@D)/.$(@F).cmd
 	$(NM) $@ | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
@@ -363,7 +356,7 @@
 
 .PHONY: $(SUBDIRS)
 $(SUBDIRS): .hdepend prepare
-	@$(MAKE) -C $@
+	@$(call descend,$@,)
 
 #	Things we need done before we descend to build or make
 #	module versions are listed in "prepare"
@@ -386,17 +379,17 @@
 # ---------------------------------------------------------------------------
 
 %.s: %.c FORCE
-	@$(MAKE) -C $(@D) $(@F)
+	@$(call descend,$(@D),$(@F))
 %.i: %.c FORCE
-	@$(MAKE) -C $(@D) $(@F)
+	@$(call descend,$(@D),$(@F))
 %.o: %.c FORCE
-	@$(MAKE) -C $(@D) $(@F)
+	@$(call descend,$(@D),$(@F))
 %.lst: %.c FORCE
-	@$(MAKE) -C $(@D) $(@F)
+	@$(call descend,$(@D),$(@F))
 %.s: %.S FORCE
-	@$(MAKE) -C $(@D) $(@F)
+	@$(call descend,$(@D),$(@F))
 %.o: %.S FORCE
-	@$(MAKE) -C $(@D) $(@F)
+	@$(call descend,$(@D),$(@F))
 
 # 	FIXME: The asm symlink changes when $(ARCH) changes. That's
 #	hard to detect, but I suppose "make mrproper" is a good idea
@@ -481,7 +474,7 @@
 	$(update-if-changed)
 
 $(patsubst %,_sfdep_%,$(SUBDIRS)): FORCE
-	@$(MAKE) -C $(patsubst _sfdep_%, %, $@) fastdep
+	@$(call descend,$(patsubst _sfdep_%,%,$@),fastdep)
 
 else # !CONFIG_MODVERSIONS
 
@@ -533,7 +526,7 @@
 
 .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
 $(patsubst %, _modinst_%, $(SUBDIRS)) :
-	@$(MAKE) -C $(patsubst _modinst_%, %, $@) modules_install
+	$(descend,$(patsubst _modinst_%,%,$@),modules_install)
 
 else # CONFIG_MODULES
 
@@ -631,11 +624,11 @@
 	make_with_config
 
 xconfig:
-	@$(MAKE) -C scripts kconfig.tk
+	@$(call descend,scripts,kconfig.tk)
 	wish -f scripts/kconfig.tk
 
 menuconfig:
-	@$(MAKE) -C scripts lxdialog
+	@$(call descend,scripts,lxdialog)
 	$(CONFIG_SHELL) $(src)/scripts/Menuconfig arch/$(ARCH)/config.in
 
 config:
@@ -734,7 +727,7 @@
 		-type f -print | xargs rm -f
 	@rm -rf $(MRPROPER_DIRS)
 	@rm -f $(MRPROPER_FILES)
-	@$(MAKE) -C scripts mrproper
+	@$(call descend,scripts,mrproper)
 	@$(MAKE) -f Documentation/DocBook/Makefile mrproper
 
 distclean: mrproper
@@ -909,5 +902,9 @@
 	fi
 endef
 
+#	$(call descend,<dir>,<target>)
+#	Recursively call a sub-make in <dir> with target <target> 
+
+descend = $(MAKE) -C $(1) $(2)
 
 FORCE:
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Wed Oct  2 21:51:56 2002
+++ b/Rules.make	Wed Oct  2 21:51:56 2002
@@ -136,8 +136,8 @@
 # If we don't export any symbols in this dir, just descend
 # ---------------------------------------------------------------------------
 
-fastdep: sub_dirs
-	@echo -n
+fastdep: $(subdir-ym)
+	@/bin/true
 
 else
 
@@ -206,7 +206,7 @@
 
 targets := $(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver))
 
-fastdep: $(targets) sub_dirs
+fastdep: $(targets) $(subdir-ym)
 	@mkdir -p $(TOPDIR)/.tmp_export-objs/modules/$(RELDIR)
 	@touch $(addprefix $(TOPDIR)/.tmp_export-objs/modules/$(RELDIR)/,$(export-objs:.o=.ver))
 
@@ -221,13 +221,13 @@
 
 .PHONY: modules_install
 
-modules_install: sub_dirs
+modules_install: $(subdir-ym)
 ifneq ($(obj-m),)
 	@echo Installing modules in $(MODLIB)/kernel/$(RELDIR)
 	@mkdir -p $(MODLIB)/kernel/$(RELDIR)
 	@cp $(obj-m) $(MODLIB)/kernel/$(RELDIR)
 else
-	@echo -n
+	@/bin/true
 endif
 
 else # ! modules_install
@@ -248,8 +248,8 @@
 #	The echo suppresses the "Nothing to be done for first_rule"
 first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
 	    $(if $(KBUILD_MODULES),$(obj-m)) \
-	    sub_dirs
-	@echo -n
+	    $(subdir-ym)
+	@/bin/true
 
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------
@@ -324,7 +324,7 @@
 # ---------------------------------------------------------------------------
 
 # To build objects in subdirs, we need to descend into the directories
-$(sort $(subdir-obj-y)): sub_dirs ;
+$(sort $(subdir-obj-y)): $(subdir-ym) ;
 
 #
 # Rule to compile a set of .o files into one .o file
@@ -454,12 +454,10 @@
 # Descending
 # ---------------------------------------------------------------------------
 
-.PHONY: sub_dirs $(subdir-ym)
-
-sub_dirs: $(subdir-ym)
+.PHONY: $(subdir-ym)
 
 $(subdir-ym):
-	@$(MAKE) -C $@ $(MAKECMDGOALS)
+	@$(call descend,$@,$(MAKECMDGOALS))
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
@@ -573,4 +571,9 @@
              echo "$(2)" &&)) \
         $(2)
 endef
+
+#	$(call descend,<dir>,<target>)
+#	Recursively call a sub-make in <dir> with target <target> 
+
+descend = $(MAKE) -C $(1) $(2)
 

-----------------------------------------------------------------------------
ChangeSet@1.676, 2002-10-02 14:42:00-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Remove xfs vpath hack
  
  xfs.o is built as one modules out of objects distributed into
  multiple subdirs. That is okay with the current kbuild, you just
  have to include the path for objects which reside in a subdir, then.
  
  xfs used vpath instead of explicitly adding the paths, which is
  inconsistent and conflicts e.g. with proper module version generation.

  ---------------------------------------------------------------------------

diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Wed Oct  2 21:51:58 2002
+++ b/Rules.make	Wed Oct  2 21:51:58 2002
@@ -207,7 +207,7 @@
 targets := $(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver))
 
 fastdep: $(targets) $(subdir-ym)
-	@mkdir -p $(TOPDIR)/.tmp_export-objs/modules/$(RELDIR)
+	@mkdir -p $(dir $(addprefix $(TOPDIR)/.tmp_export-objs/modules/$(RELDIR),$(export-objs:.o=.ver)))
 	@touch $(addprefix $(TOPDIR)/.tmp_export-objs/modules/$(RELDIR)/,$(export-objs:.o=.ver))
 
 endif # export-objs 
@@ -245,7 +245,6 @@
 endif
 endif
 
-#	The echo suppresses the "Nothing to be done for first_rule"
 first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
 	    $(if $(KBUILD_MODULES),$(obj-m)) \
 	    $(subdir-ym)
diff -Nru a/fs/xfs/Makefile b/fs/xfs/Makefile
--- a/fs/xfs/Makefile	Wed Oct  2 21:51:58 2002
+++ b/fs/xfs/Makefile	Wed Oct  2 21:51:58 2002
@@ -32,11 +32,6 @@
 # Makefile for XFS on Linux.
 #
 
-
-# we also have source in the subdirectories..
-vpath %.c =  . linux pagebuf support
-
-
 # This needs -I. because everything does #include <xfs.h> instead of "xfs.h".
 # The code is wrong, local files should be included using "xfs.h", not <xfs.h>
 # but I am not going to change every file at the moment.
@@ -49,7 +44,8 @@
 	EXTRA_CFLAGS += -DPAGEBUF_TRACE
 endif
 
-export-objs			:= page_buf.o ktrace.o xfs_globals.o
+export-objs			:= pagebuf/page_buf.o support/ktrace.o \
+				   linux/xfs_globals.o
 
 obj-$(CONFIG_XFS_FS)		+= xfs.o
 
@@ -65,8 +61,8 @@
 xfs-obj-$(CONFIG_FS_POSIX_ACL)	+= xfs_acl.o
 xfs-obj-$(CONFIG_FS_POSIX_CAP)	+= xfs_cap.o
 xfs-obj-$(CONFIG_FS_POSIX_MAC)	+= xfs_mac.o
-xfs-obj-$(CONFIG_PROC_FS)	+= xfs_stats.o
-xfs-obj-$(CONFIG_SYSCTL)	+= xfs_sysctl.o
+xfs-obj-$(CONFIG_PROC_FS)	+= linux/xfs_stats.o
+xfs-obj-$(CONFIG_SYSCTL)	+= linux/xfs_sysctl.o
 
 
 xfs-objs			+= $(xfs-obj-y) \
@@ -118,11 +114,13 @@
 				   xfs_rw.o
 
 # Objects in pagebuf/
-xfs-objs			+= page_buf.o \
-				   page_buf_locking.o
+xfs-objs			+= $(addprefix pagebuf/, \
+				   page_buf.o \
+				   page_buf_locking.o)
 
 # Objects in linux/
-xfs-objs			+= xfs_aops.o \
+xfs-objs			+= $(addprefix linux/, \
+				   xfs_aops.o \
 				   xfs_behavior.o \
 				   xfs_file.o \
 				   xfs_fs_subr.o \
@@ -131,16 +129,17 @@
 				   xfs_iops.o \
 				   xfs_lrw.o \
 				   xfs_super.o \
-				   xfs_vnode.o
+				   xfs_vnode.o)
 
 # Objects in support/
-xfs-objs			+= debug.o \
+xfs-objs			+= $(addprefix support/, \
+				   debug.o \
 				   kmem.o \
 				   ktrace.o \
 				   move.o \
 				   mrlock.o \
 				   qsort.o \
-				   uuid.o
+				   uuid.o)
 
 # If both xfs and kdb modules are built in then xfsidbg is built in.  If xfs is
 # a module and kdb modules are being compiled then xfsidbg must be a module, to

-----------------------------------------------------------------------------
ChangeSet@1.677, 2002-10-02 14:46:16-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Standardize ACPI Makefiles
  
  ACPI was a bit lazy and just said compile all .c files in this directory,
  which is different from all other Makefiles and will not work very
  well e.g. bk, where a .c file may not be checked out yet, or separate
  obj/src dirs. So just explicitly list the files we want to compile.

  ---------------------------------------------------------------------------

diff -Nru a/drivers/acpi/dispatcher/Makefile b/drivers/acpi/dispatcher/Makefile
--- a/drivers/acpi/dispatcher/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/dispatcher/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,8 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := dsfield.o   dsmthdat.o  dsopcode.o  dswexec.o  dswscope.o \
+	 dsmethod.o  dsobject.o  dsutils.o   dswload.o  dswstate.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
diff -Nru a/drivers/acpi/events/Makefile b/drivers/acpi/events/Makefile
--- a/drivers/acpi/events/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/events/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,8 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := evevent.o  evregion.o  evsci.o    evxfevnt.o \
+	 evmisc.o   evrgnini.o  evxface.o  evxfregn.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
diff -Nru a/drivers/acpi/executer/Makefile b/drivers/acpi/executer/Makefile
--- a/drivers/acpi/executer/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/executer/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,10 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
+	 exconvrt.o  exfldio.o  exoparg1.o  exprep.o    exresop.o   exsystem.o\
+	 excreate.o  exmisc.o   exoparg2.o  exregion.o  exstore.o   exutils.o \
+	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
diff -Nru a/drivers/acpi/hardware/Makefile b/drivers/acpi/hardware/Makefile
--- a/drivers/acpi/hardware/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/hardware/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,7 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o  hwtimer.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
diff -Nru a/drivers/acpi/namespace/Makefile b/drivers/acpi/namespace/Makefile
--- a/drivers/acpi/namespace/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/namespace/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,9 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := nsaccess.o  nsdumpdv.o  nsload.o    nssearch.o  nsxfeval.o \
+	 nsalloc.o   nseval.o    nsnames.o   nsutils.o   nsxfname.o \
+	 nsdump.o    nsinit.o    nsobject.o  nswalk.o    nsxfobj.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
diff -Nru a/drivers/acpi/parser/Makefile b/drivers/acpi/parser/Makefile
--- a/drivers/acpi/parser/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/parser/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,8 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := psargs.o    psparse.o  pstree.o   pswalk.o  \
+	 psopcode.o  psscope.o  psutils.o  psxface.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
diff -Nru a/drivers/acpi/resources/Makefile b/drivers/acpi/resources/Makefile
--- a/drivers/acpi/resources/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/resources/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,8 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := rsaddr.o  rscreate.o  rsio.o   rslist.o    rsmisc.o   rsxface.o \
+	 rscalc.o  rsdump.o    rsirq.o  rsmemory.o  rsutils.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
diff -Nru a/drivers/acpi/tables/Makefile b/drivers/acpi/tables/Makefile
--- a/drivers/acpi/tables/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/tables/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,8 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := tbconvrt.o  tbget.o     tbrsdt.o   tbxface.o  \
+	 tbgetall.o  tbinstal.o  tbutils.o  tbxfroot.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
diff -Nru a/drivers/acpi/utilities/Makefile b/drivers/acpi/utilities/Makefile
--- a/drivers/acpi/utilities/Makefile	Wed Oct  2 21:52:00 2002
+++ b/drivers/acpi/utilities/Makefile	Wed Oct  2 21:52:00 2002
@@ -2,7 +2,8 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-$(CONFIG_ACPI_INTERPRETER) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := utalloc.o  utdebug.o   uteval.o    utinit.o  utmisc.o    utxface.o \
+	 utcopy.o   utdelete.o  utglobal.o  utmath.o  utobject.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 

-----------------------------------------------------------------------------
ChangeSet@1.678, 2002-10-02 14:54:37-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Small quirks for separate obj / src trees
  
  Add a couple of missing $(obj) and the like.
  
  Also, remove the __chmod hack which made some files in the source tree
  executable - hopefully, everybody's copy is by now ;)

  ---------------------------------------------------------------------------

diff -Nru a/drivers/isdn/hisax/Makefile b/drivers/isdn/hisax/Makefile
--- a/drivers/isdn/hisax/Makefile	Wed Oct  2 21:52:01 2002
+++ b/drivers/isdn/hisax/Makefile	Wed Oct  2 21:52:01 2002
@@ -63,7 +63,7 @@
 
 hisax-objs += $(hisax-objs-y)
 
-CERT := $(shell md5sum -c md5sums.asc >> /dev/null;echo $$?)
+CERT := $(shell cd $(src); md5sum -c md5sums.asc > /dev/null 2> /dev/null ;echo $$?)
 CFLAGS_cert.o := -DCERTIFICATION=$(CERT)
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Wed Oct  2 21:52:01 2002
+++ b/drivers/pci/Makefile	Wed Oct  2 21:52:01 2002
@@ -40,6 +40,6 @@
 # And that's how to generate them
 
 $(obj)/devlist.h: $(src)/pci.ids $(obj)/gen-devlist
-	$(obj)/gen-devlist < $<
+	( cd $(obj); ./gen-devlist ) < $<
 
 $(obj)/classlist.h: $(obj)/devlist.h
diff -Nru a/drivers/zorro/Makefile b/drivers/zorro/Makefile
--- a/drivers/zorro/Makefile	Wed Oct  2 21:52:01 2002
+++ b/drivers/zorro/Makefile	Wed Oct  2 21:52:01 2002
@@ -18,4 +18,4 @@
 # And that's how to generate them
 
 $(obj)/devlist.h: $(src)/zorro.ids $(obj)/gen-devlist
-	$(obj)/gen-devlist < $<
+	( cd $(obj); ./gen-devlist ) < $<
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	Wed Oct  2 21:52:01 2002
+++ b/scripts/Makefile	Wed Oct  2 21:52:01 2002
@@ -9,18 +9,13 @@
 # conmakehash:	 Create arrays for initializing the kernel console tables
 # tkparse: 	 Used by xconfig
 
-all: fixdep split-include docproc conmakehash __chmod
+EXTRA_TARGETS := fixdep split-include docproc conmakehash
 
 # The following temporary rule will make sure that people's
 # trees get updated to the right permissions, since patch(1)
 # can't do it
 # ---------------------------------------------------------------------------
 
-.PHONY: __chmod
-
-__chmod: kernel-doc mkcompile_h makelst
-	@chmod a+x $^
-
 host-progs := fixdep split-include conmakehash docproc tkparse
 tkparse-objs := tkparse.o tkcond.o tkgen.o
 
@@ -30,7 +25,7 @@
 # but it is not worth the effort to generate the dependencies.
 # The alternative solution to always generate it is fairly fast.
 # FORCE it to remake
-$(obj)/kconfig.tk: $(srctree)/arch/$(ARCH)/config.in tkparse FORCE
+$(obj)/kconfig.tk: $(srctree)/arch/$(ARCH)/config.in $(obj)/tkparse FORCE
 	@echo '  Generating $@'
 	@(                                                      \
 	if [ -f /usr/local/bin/wish ];        then              \
@@ -51,7 +46,7 @@
 # Targets hardcoded and wellknow in top-level makefile
 .PHONY: lxdialog
 lxdialog:
-	$(MAKE) -C lxdialog all
+	$(call descend,lxdialog,)
 
 # fixdep is needed to compile other host programs
 $(obj)/split-include $(obj)/docproc $(addprefix $(obj)/,$(tkparse-objs)) \
diff -Nru a/scripts/lxdialog/Makefile b/scripts/lxdialog/Makefile
--- a/scripts/lxdialog/Makefile	Wed Oct  2 21:52:01 2002
+++ b/scripts/lxdialog/Makefile	Wed Oct  2 21:52:01 2002
@@ -20,9 +20,13 @@
 lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
 		 util.o lxdialog.o msgbox.o
 
-all: ncurses lxdialog
+EXTRA_TARGETS := lxdialog
+
+first_rule: ncurses
 
 include $(TOPDIR)/Rules.make
+
+.PHONY: ncurses
 
 ncurses:
 	@echo "main() {}" > lxtemp.c

-----------------------------------------------------------------------------
ChangeSet@1.679, 2002-10-02 14:59:28-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Add some bug traps
  
  Makefiles which still use obsolete 2.4 constructs now give a warning.

  ---------------------------------------------------------------------------

diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Wed Oct  2 21:52:03 2002
+++ b/Rules.make	Wed Oct  2 21:52:03 2002
@@ -8,6 +8,23 @@
 empty   :=
 space   := $(empty) $(empty)
 
+# Some bug traps
+# ---------------------------------------------------------------------------
+
+ifdef O_TARGET
+$(warning kbuild: Usage of O_TARGET is obsolete in 2.5. Please fix!
+endif
+
+ifdef L_TARGET
+ifneq ($(L_TARGET),lib.a)
+$(warning kbuild: L_TARGET ($(L_TARGET)) should be renamed to lib.a. Please fix!)
+endif
+endif
+
+ifdef list-multi
+$(warning kbuild: list-multi ($(list-multi)) is obsolete in 2.5. Please fix!)
+endif
+
 # Figure out paths
 # ---------------------------------------------------------------------------
 # Find the path relative to the toplevel dir, $(RELDIR), and express
@@ -84,16 +101,8 @@
 __obj-m = $(filter-out export.o,$(obj-m))
 
 # if $(foo-objs) exists, foo.o is a composite object 
-__multi-used-y := $(sort $(foreach m,$(__obj-y), $(if $($(m:.o=-objs)), $(m))))
-__multi-used-m := $(sort $(foreach m,$(__obj-m), $(if $($(m:.o=-objs)), $(m))))
-
-# FIXME: Rip this out later
-# Backwards compatibility: if a composite object is listed in
-# $(list-multi), skip it here, since the Makefile will have an explicit
-# link rule for it
-
-multi-used-y := $(filter-out $(list-multi),$(__multi-used-y))
-multi-used-m := $(filter-out $(list-multi),$(__multi-used-m))
+multi-used-y := $(sort $(foreach m,$(__obj-y), $(if $($(m:.o=-objs)), $(m))))
+multi-used-m := $(sort $(foreach m,$(__obj-m), $(if $($(m:.o=-objs)), $(m))))
 
 # Build list of the parts of our composite objects, our composite
 # objects depend on those (obviously)

-----------------------------------------------------------------------------
ChangeSet@1.680, 2002-10-02 16:29:37-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Handle $(core-y) the same way as $(init-y), $(drivers-y) etc
  
  $(CORE_FILES) did not quite follow the way the other vmlinux parts where
  handled, due to potential init order dependencies. However, it seems
  everybody is putting arch specific stuff in front, so we keep doing
  this and nothing should break ;)

  ---------------------------------------------------------------------------

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Oct  2 21:52:05 2002
+++ b/Makefile	Wed Oct  2 21:52:05 2002
@@ -252,17 +252,15 @@
 networks-y	:= net/
 libs-y		:= lib/
 
-CORE_FILES	:= kernel/built-in.o mm/built-in.o fs/built-in.o \
-		   ipc/built-in.o security/built-in.o
-SUBDIRS		+= kernel mm fs ipc security
-
 include arch/$(ARCH)/Makefile
 
+core-y		+= kernel/ mm/ fs/ ipc/ security/
+
 SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m)))
 INIT		+= $(patsubst %/, %/built-in.o, $(init-y))
 
 SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(core-y) $(core-m)))
-CORE_FILES	:= $(patsubst %/, %/built-in.o, $(core-y)) $(CORE_FILES)
+CORE_FILES	+= $(patsubst %/, %/built-in.o, $(core-y))
 
 SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(drivers-y) $(drivers-m)))
 DRIVERS		+= $(patsubst %/, %/built-in.o, $(drivers-y))

-----------------------------------------------------------------------------
ChangeSet@1.681, 2002-10-02 16:57:45-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Use $(core-y) and friends directly
  
  The capitalized aliases $(CORE_FILES) etc are basically superfluous now,
  move the remaining users to $(core-y) and the like.

  ---------------------------------------------------------------------------

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Oct  2 21:52:06 2002
+++ b/Makefile	Wed Oct  2 21:52:06 2002
@@ -151,7 +151,7 @@
 	CONFIG_SHELL TOPDIR HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE MAKEFILES GENKSYMS PERL
 
-export CPPFLAGS EXPORT_FLAGS NOSTDINC_FLAGS OBJCOPYFLAGS
+export CPPFLAGS EXPORT_FLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
 export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 
@@ -249,29 +249,25 @@
 
 init-y		:= init/
 drivers-y	:= drivers/ sound/
-networks-y	:= net/
+net-y		:= net/
 libs-y		:= lib/
+core-y		:=
+SUBDIRS		:=
 
 include arch/$(ARCH)/Makefile
 
 core-y		+= kernel/ mm/ fs/ ipc/ security/
 
-SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m)))
-INIT		+= $(patsubst %/, %/built-in.o, $(init-y))
+SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
+		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
+		     $(net-y) $(net-m) $(libs-y) $(libs-m)))
+init-y		:= $(patsubst %/, %/built-in.o, $(init-y))
+core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
+drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
+net-y		:= $(patsubst %/, %/built-in.o, $(net-y))
+libs-y		:= $(patsubst %/, %/lib.a, $(libs-y))
 
-SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(core-y) $(core-m)))
-CORE_FILES	+= $(patsubst %/, %/built-in.o, $(core-y))
-
-SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(drivers-y) $(drivers-m)))
-DRIVERS		+= $(patsubst %/, %/built-in.o, $(drivers-y))
-
-SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(networks-y) $(networks-m)))
-NETWORKS	+= $(patsubst %/, %/built-in.o, $(networks-y))
-
-SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(libs-y) $(libs-m)))
-LIBS		+= $(patsubst %/, %/lib.a, $(libs-y))
-
-export	NETWORKS DRIVERS LIBS HEAD LDFLAGS MAKEBOOT
+$(warning $(SUBDIRS))
 
 # Build vmlinux
 # ---------------------------------------------------------------------------
@@ -283,16 +279,16 @@
 #       we cannot yet know if we will need to relink vmlinux.
 #	So we descend into init/ inside the rule for vmlinux again.
 
-vmlinux-objs := $(HEAD) $(INIT) $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)
+vmlinux-objs := $(HEAD) $(init-y) $(core-y) $(libs-y) $(drivers-y) $(net-y)
 
 quiet_cmd_link_vmlinux = LD      $@
 define cmd_link_vmlinux
-	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) $(HEAD) $(INIT) \
+	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) $(HEAD) $(init-y) \
 	--start-group \
-	$(CORE_FILES) \
-	$(LIBS) \
-	$(DRIVERS) \
-	$(NETWORKS) \
+	$(core-y) \
+	$(libs-y) \
+	$(drivers-y) \
+	$(net-y) \
 	--end-group \
 	$(filter $(kallsyms.o),$^) \
 	-o $@
diff -Nru a/arch/alpha/Makefile b/arch/alpha/Makefile
--- a/arch/alpha/Makefile	Wed Oct  2 21:52:06 2002
+++ b/arch/alpha/Makefile	Wed Oct  2 21:52:06 2002
@@ -95,6 +95,8 @@
 core-$(CONFIG_MATHEMU)  += arch/alpha/math-emu/
 libs-y			+= arch/alpha/lib/
 
+export libs-y
+
 MAKEBOOT = $(MAKE) -C arch/alpha/boot
 
 rawboot:
diff -Nru a/arch/alpha/boot/Makefile b/arch/alpha/boot/Makefile
--- a/arch/alpha/boot/Makefile	Wed Oct  2 21:52:06 2002
+++ b/arch/alpha/boot/Makefile	Wed Oct  2 21:52:06 2002
@@ -20,7 +20,7 @@
 TARGETS = vmlinux.gz tools/objstrip # also needed by aboot & milo
 VMLINUX = $(TOPDIR)/vmlinux
 OBJSTRIP = tools/objstrip
-LIBS := $(patsubst lib/%,$(TOPDIR)/lib/%,$(LIBS))
+LIBS := $(addprefix $(TOPDIR)/,$(libs-y))
 
 all:	$(TARGETS)
 	@echo Ready to install kernel in $(shell pwd)/vmlinux.gz
diff -Nru a/arch/sparc/Makefile b/arch/sparc/Makefile
--- a/arch/sparc/Makefile	Wed Oct  2 21:52:06 2002
+++ b/arch/sparc/Makefile	Wed Oct  2 21:52:06 2002
@@ -41,8 +41,7 @@
 libs-y += arch/sparc/prom/ arch/sparc/lib/
 
 # Export what is needed by arch/sparc/boot/Makefile
-export CORE_FILES
-export INIT
+export init-y core-y drivers-y net-y libs-y HEAD
 
 image: vmlinux
 	$(MAKE) -C arch/sparc/boot image
diff -Nru a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
--- a/arch/sparc/boot/Makefile	Wed Oct  2 21:52:06 2002
+++ b/arch/sparc/boot/Makefile	Wed Oct  2 21:52:06 2002
@@ -22,9 +22,8 @@
 clean:
 	rm -f btfixupprep piggyback tftpboot.img btfix.o btfix.s image
 
-BTOBJS := $(HEAD) $(INIT)
-BTLIBS := $(CORE_FILES) $(LIBS) \
-	$(DRIVERS) $(NETWORKS)
+BTOBJS := $(HEAD) $(init-y)
+BTLIBS := $(core-y) $(LIBS) $(drivers-y) $(net-y)
 
 # Actual linking
 image: btfix.o
diff -Nru a/drivers/isdn/i4l/isdn_ppp.h b/drivers/isdn/i4l/isdn_ppp.h
--- a/drivers/isdn/i4l/isdn_ppp.h	Wed Oct  2 21:52:06 2002
+++ b/drivers/isdn/i4l/isdn_ppp.h	Wed Oct  2 21:52:06 2002
@@ -27,7 +27,7 @@
 #else
 
 static inline int
-isdn_ppp_xmit(struct sk_buff *, struct net_device *);
+isdn_ppp_xmit(struct sk_buff *, struct net_device *)
 {
 	return 0;
 }

-----------------------------------------------------------------------------
ChangeSet@1.682, 2002-10-02 17:52:22-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Always build helpers in script/
  
  As noticed by Sam Ravnborg, we need the targets in scripts (fixdep,
  in particular) considered always, i.e. also when compiling modules.

  ---------------------------------------------------------------------------

diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	Wed Oct  2 21:52:08 2002
+++ b/scripts/Makefile	Wed Oct  2 21:52:08 2002
@@ -11,6 +11,11 @@
 
 EXTRA_TARGETS := fixdep split-include docproc conmakehash
 
+# Yikes. We need to build this stuff here even if the user only wants
+# modules.
+
+KBUILD_BUILTIN := 1
+
 # The following temporary rule will make sure that people's
 # trees get updated to the right permissions, since patch(1)
 # can't do it

-----------------------------------------------------------------------------
ChangeSet@1.683, 2002-10-02 21:51:28-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Don't cd into subdirs during build
  
  Instead of using make -C <subdir>, just use make -f <subdir>/Makefile.
  This means we now call gcc/ld/... always from the topdir.
  
  Advantages are:
  o We don't need to use -I$(TOPDIR)/include and the like, just 
    -Iinclude works.
  o __FILE__ gives the correct relative path from the topdir instead
    of an absolute path, as it did before for included headers
  o gcc errors/warnings give the correct relative path from the topdir
  o takes us a step closer to a non-recursive build (though that's probably
    as close as it gets)
  
  The changes to Rules.make were done in a way which only uses the new way
  for the standard recursive build (which remains recursive, just without
  cd), all the archs do make -C arch/$(ARCH)/boot ..., which should keep
  working as before. However, of course this should be converted eventually,
  it's possible to do so piecemeal arch by arch.
  
  It seems to work fine for most of the standard kernel. Potential places
  which need changing are added -I flags to the command line, which now
  need to have the path relative to the topdir and explicit rules for
  generating files, which need to properly use $(obj) / $(src) to work
  correctly.

  ---------------------------------------------------------------------------

diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Wed Oct  2 21:52:10 2002
+++ b/Rules.make	Wed Oct  2 21:52:10 2002
@@ -25,22 +25,20 @@
 $(warning kbuild: list-multi ($(list-multi)) is obsolete in 2.5. Please fix!)
 endif
 
-# Figure out paths
+# Some paths for the Makefiles to use
 # ---------------------------------------------------------------------------
-# Find the path relative to the toplevel dir, $(RELDIR), and express
-# the toplevel dir as a relative path from this dir, $(TOPDIR_REL)
 
-ifeq ($(findstring $(TOPDIR),$(CURDIR)),)
-  # Can only happen when something is built out of tree
-  RELDIR := $(CURDIR)
-  TOPDIR_REL := $(TOPDIR)
-else
-  RELDIR := $(subst $(TOPDIR)/,,$(CURDIR))
-  TOPDIR_REL := $(subst $(space),,$(foreach d,$(subst /, ,$(RELDIR)),../))
+# FIXME. For now, we leave it possible to use make -C or make -f
+# to do work in subdirs.
+
+ifndef obj
+obj = .
+CFLAGS := $(patsubst -I%,-I$(TOPDIR)/%,$(patsubst -I$(TOPDIR)/%,-I%,$(CFLAGS)))
+AFLAGS := $(patsubst -I%,-I$(TOPDIR)/%,$(patsubst -I$(TOPDIR)/%,-I%,$(AFLAGS)))
 endif
 
-# Some paths for the Makefiles to use
-# ---------------------------------------------------------------------------
+# For use in the quiet output
+echo_target = $@
 
 # Usage:
 #
@@ -58,12 +56,7 @@
 # We don't support separate source / object yet, so these are just
 # placeholders for now
 
-obj := .
-src := .
-
-# For use in the quiet output
-
-echo_target = $(RELDIR)/$@
+src := $(obj)
 
 # Figure out what we need to build from the various variables
 # ===========================================================================
@@ -120,6 +113,21 @@
 # Only build module versions for files which are selected to be built
 export-objs := $(filter $(export-objs),$(real-objs-y) $(real-objs-m))
 
+# Add subdir path
+
+EXTRA_TARGETS	:= $(addprefix $(obj)/,$(EXTRA_TARGETS))
+obj-y		:= $(addprefix $(obj)/,$(obj-y))
+obj-m		:= $(addprefix $(obj)/,$(obj-m))
+export-objs	:= $(addprefix $(obj)/,$(export-objs))
+subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
+real-objs-y	:= $(addprefix $(obj)/,$(real-objs-y))
+real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
+multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
+multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
+multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
+multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
+subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
+
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
@@ -153,7 +161,7 @@
 # This sets version suffixes on exported symbols
 # ---------------------------------------------------------------------------
 
-MODVERDIR := $(TOPDIR)/include/linux/modules/$(RELDIR)
+MODVERDIR := include/linux/modules/$(obj)
 
 #
 # Added the SMP separator to stop module accidents between uniprocessor
@@ -183,7 +191,7 @@
 # files (fix-dep filters them), so touch modversions.h if any of the .ver
 # files changes
 
-quiet_cmd_cc_ver_c = MKVER   include/linux/modules/$(RELDIR)/$*.ver
+quiet_cmd_cc_ver_c = MKVER   include/linux/modules/$(obj)/$*.ver
 cmd_cc_ver_c = $(CPP) $(c_flags) $< | $(GENKSYMS) $(genksyms_smp_prefix) \
 		 -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp
 
@@ -216,8 +224,8 @@
 targets := $(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver))
 
 fastdep: $(targets) $(subdir-ym)
-	@mkdir -p $(dir $(addprefix $(TOPDIR)/.tmp_export-objs/modules/$(RELDIR),$(export-objs:.o=.ver)))
-	@touch $(addprefix $(TOPDIR)/.tmp_export-objs/modules/$(RELDIR)/,$(export-objs:.o=.ver))
+	@mkdir -p $(dir $(addprefix .tmp_export-objs/modules/,$(export-objs:.o=.ver)))
+	@touch $(addprefix .tmp_export-objs/modules/,$(export-objs:.o=.ver))
 
 endif # export-objs 
 
@@ -228,13 +236,15 @@
 # Installing modules
 # ==========================================================================
 
+quiet_cmd_modules_install = INSTALL $(obj-m)
+cmd_modules_install = mkdir -p $(MODLIB)/kernel/$(obj); \
+		      cp $(obj-m) $(MODLIB)/kernel/$(obj)
+
 .PHONY: modules_install
 
 modules_install: $(subdir-ym)
 ifneq ($(obj-m),)
-	@echo Installing modules in $(MODLIB)/kernel/$(RELDIR)
-	@mkdir -p $(MODLIB)/kernel/$(RELDIR)
-	@cp $(obj-m) $(MODLIB)/kernel/$(RELDIR)
+	$(call cmd,modules_install)
 else
 	@/bin/true
 endif
@@ -250,8 +260,12 @@
 
 ifndef O_TARGET
 ifndef L_TARGET
-O_TARGET := built-in.o
+O_TARGET := $(obj)/built-in.o
+endif
 endif
+
+ifdef L_TARGET
+L_TARGET := $(obj)/$(L_TARGET)
 endif
 
 first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
@@ -368,7 +382,7 @@
 #
 
 quiet_cmd_link_multi = LD      $(echo_target)
-cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $($(basename $@)-objs),$^)
+cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs)))),$^)
 
 # We would rather have a list of rules like
 # 	foo.o: $(foo-objs)
@@ -388,6 +402,9 @@
 host-progs-single     := $(foreach m,$(host-progs),$(if $($(m)-objs),,$(m)))
 host-progs-multi      := $(foreach m,$(host-progs),$(if $($(m)-objs),$(m)))
 host-progs-multi-objs := $(foreach m,$(host-progs-multi),$($(m)-objs))
+host-progs-single     := $(addprefix $(obj)/,$(host-progs-single))
+host-progs-multi      := $(addprefix $(obj)/,$(host-progs-multi))
+host-progs-multi-objs := $(addprefix $(obj)/,$(host-progs-multi-objs))
 
 quiet_cmd_host_cc__c  = HOSTCC  $(echo_target)
 cmd_host_cc__c        = $(HOSTCC) -Wp,-MD,$(depfile) \
@@ -405,7 +422,7 @@
 	$(call if_changed_dep,host_cc_o_c)
 
 quiet_cmd_host_cc__o  = HOSTLD  $(echo_target)
-cmd_host_cc__o        = $(HOSTCC) $(HOSTLDFLAGS) -o $@ $($@-objs) \
+cmd_host_cc__o        = $(HOSTCC) $(HOSTLDFLAGS) -o $@ $(addprefix $(obj)/,$($(subst $(obj)/,,$@)-objs)) \
 			$(HOST_LOADLIBES)
 
 $(host-progs-multi): %: $(host-progs-multi-objs) FORCE
@@ -583,5 +600,7 @@
 #	$(call descend,<dir>,<target>)
 #	Recursively call a sub-make in <dir> with target <target> 
 
-descend = $(MAKE) -C $(1) $(2)
-
+ifeq ($(KBUILD_VERBOSE),1)
+descend = echo '$(MAKE) -f $(1)/Makefile $(2)';
+endif
+descend += $(MAKE) -f $(1)/Makefile obj=$(1) $(2)
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Wed Oct  2 21:52:10 2002
+++ b/arch/i386/Makefile	Wed Oct  2 21:52:10 2002
@@ -98,8 +98,8 @@
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
 
-CFLAGS += -I$(TOPDIR)/arch/i386/$(MACHINE)
-AFLAGS += -I$(TOPDIR)/arch/i386/$(MACHINE)
+CFLAGS += -Iarch/i386/$(MACHINE)
+AFLAGS += -Iarch/i386/$(MACHINE)
 
 MAKEBOOT = +$(MAKE) -C arch/$(ARCH)/boot
 
diff -Nru a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
--- a/arch/i386/boot/Makefile	Wed Oct  2 21:52:10 2002
+++ b/arch/i386/boot/Makefile	Wed Oct  2 21:52:10 2002
@@ -44,7 +44,7 @@
 bzImage: EXTRA_AFLAGS := -traditional $(SVGA_MODE) $(RAMDISK) -D__BIG_KERNEL__
 bzImage: BUILDFLAGS   := -b
 
-quiet_cmd_image = BUILD  $(RELDIR)/$@
+quiet_cmd_image = BUILD   $(echo_target)
 cmd_image = tools/build $(BUILDFLAGS) bootsect setup vmlinux.bin \
 			$(ROOT_DEV) > $@
 
diff -Nru a/drivers/acpi/Makefile b/drivers/acpi/Makefile
--- a/drivers/acpi/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/acpi/Makefile	Wed Oct  2 21:52:10 2002
@@ -4,7 +4,7 @@
 
 export ACPI_CFLAGS
 
-ACPI_CFLAGS	:= -D_LINUX -I$(CURDIR)/include
+ACPI_CFLAGS	:= -D_LINUX -Idrivers/acpi/include
 
 ifdef CONFIG_ACPI_DEBUG
   ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
diff -Nru a/drivers/ide/arm/Makefile b/drivers/ide/arm/Makefile
--- a/drivers/ide/arm/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/ide/arm/Makefile	Wed Oct  2 21:52:10 2002
@@ -2,6 +2,6 @@
 obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
 
-EXTRA_CFLAGS	:= -I../
+EXTRA_CFLAGS	:= -Idrivers/ide
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/ide/legacy/Makefile b/drivers/ide/legacy/Makefile
--- a/drivers/ide/legacy/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/ide/legacy/Makefile	Wed Oct  2 21:52:10 2002
@@ -17,6 +17,6 @@
 # Last of all
 obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
 
-EXTRA_CFLAGS	:= -I../
+EXTRA_CFLAGS	:= -Idrivers/ide
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
--- a/drivers/ide/pci/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/ide/pci/Makefile	Wed Oct  2 21:52:10 2002
@@ -31,6 +31,6 @@
 # Must appear at the end of the block
 obj-$(CONFIG_BLK_DEV_GENERIC)          += generic.o
 
-EXTRA_CFLAGS	:= -I../
+EXTRA_CFLAGS	:= -Idrivers/ide
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/ide/ppc/Makefile b/drivers/ide/ppc/Makefile
--- a/drivers/ide/ppc/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/ide/ppc/Makefile	Wed Oct  2 21:52:10 2002
@@ -3,6 +3,6 @@
 obj-$(CONFIG_BLK_DEV_IDE_PMAC)		+= pmac.o
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
 
-EXTRA_CFLAGS	:= -I../
+EXTRA_CFLAGS	:= -Idrivers/ide
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/message/fusion/Makefile b/drivers/message/fusion/Makefile
--- a/drivers/message/fusion/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/message/fusion/Makefile	Wed Oct  2 21:52:10 2002
@@ -13,7 +13,7 @@
 #			# sparc64
 #EXTRA_CFLAGS += -gstabs+
 
-EXTRA_CFLAGS += -I. ${MPT_CFLAGS}
+EXTRA_CFLAGS += ${MPT_CFLAGS}
 
 # Fusion MPT drivers; recognized debug defines...
 #  MPT general:
diff -Nru a/drivers/net/sk98lin/Makefile b/drivers/net/sk98lin/Makefile
--- a/drivers/net/sk98lin/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/net/sk98lin/Makefile	Wed Oct  2 21:52:10 2002
@@ -55,7 +55,7 @@
 # SK_DBGCAT_DRV_INT_SRC         0x04000000      interrupts sources
 # SK_DBGCAT_DRV_EVENT           0x08000000      driver events
 
-EXTRA_CFLAGS += -I. -DSK_USE_CSUM $(DBGDEF)
+EXTRA_CFLAGS += -Idrivers/net/sk98lin -DSK_USE_CSUM $(DBGDEF)
 
 include $(TOPDIR)/Rules.make
 
diff -Nru a/drivers/net/skfp/Makefile b/drivers/net/skfp/Makefile
--- a/drivers/net/skfp/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/net/skfp/Makefile	Wed Oct  2 21:52:10 2002
@@ -17,7 +17,7 @@
 #   projects. To keep the source common for all those drivers (and
 #   thus simplify fixes to it), please do not clean it up!
 
-EXTRA_CFLAGS += -I. -DPCI -DMEM_MAPPED_IO -Wno-strict-prototypes 
+EXTRA_CFLAGS += -Idrivers/net/skfp -DPCI -DMEM_MAPPED_IO -Wno-strict-prototypes 
 
 include $(TOPDIR)/Rules.make
 
diff -Nru a/drivers/scsi/sym53c8xx_2/Makefile b/drivers/scsi/sym53c8xx_2/Makefile
--- a/drivers/scsi/sym53c8xx_2/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/scsi/sym53c8xx_2/Makefile	Wed Oct  2 21:52:10 2002
@@ -3,7 +3,5 @@
 sym53c8xx-objs := sym_fw.o sym_glue.o sym_hipd.o sym_malloc.o sym_misc.o sym_nvram.o
 obj-$(CONFIG_SCSI_SYM53C8XX_2) := sym53c8xx.o
 
-EXTRA_CFLAGS += -I.
-
 include $(TOPDIR)/Rules.make
 
diff -Nru a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
--- a/drivers/usb/storage/Makefile	Wed Oct  2 21:52:10 2002
+++ b/drivers/usb/storage/Makefile	Wed Oct  2 21:52:10 2002
@@ -5,7 +5,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-EXTRA_CFLAGS	:= -I../../scsi/
+EXTRA_CFLAGS	:= -Idrivers/scsi
 
 obj-$(CONFIG_USB_STORAGE)	+= usb-storage.o
 
diff -Nru a/fs/xfs/Makefile b/fs/xfs/Makefile
--- a/fs/xfs/Makefile	Wed Oct  2 21:52:10 2002
+++ b/fs/xfs/Makefile	Wed Oct  2 21:52:10 2002
@@ -32,10 +32,10 @@
 # Makefile for XFS on Linux.
 #
 
-# This needs -I. because everything does #include <xfs.h> instead of "xfs.h".
+# This needs -I because everything does #include <xfs.h> instead of "xfs.h".
 # The code is wrong, local files should be included using "xfs.h", not <xfs.h>
 # but I am not going to change every file at the moment.
-EXTRA_CFLAGS +=	 -I. -funsigned-char
+EXTRA_CFLAGS +=	 -Ifs/xfs -funsigned-char
 
 ifeq ($(CONFIG_XFS_DEBUG),y)
 	EXTRA_CFLAGS += -g -DSTATIC="" -DDEBUG -DXFSDEBUG
@@ -154,6 +154,6 @@
   endif
 endif
 
-CFLAGS_xfsidbg.o += -I $(TOPDIR)/arch/$(ARCH)/kdb
+CFLAGS_xfsidbg.o += -Iarch/$(ARCH)/kdb
 
 include $(TOPDIR)/Rules.make


