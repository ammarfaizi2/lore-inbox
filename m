Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUHMTxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUHMTxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUHMTwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:52:30 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:7468 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267381AbUHMTrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:47:06 -0400
Date: Fri, 13 Aug 2004 21:49:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [7/12] kbuild: Separate out host-progs handling 
Message-ID: <20040813194928.GG10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/10 20:09:55+02:00 sam@mars.ravnborg.org 
#   kbuild: Separate out host-progs handling
#   
#   Concentrating all host-progs functionality in one file made a more
#   readable Makefile.lib - and allow for potential reuse of host-progs
#   functionality.
#   Processing of host-progs related stuff are avoided when no host-progs are specified. 
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.host
#   2004/08/10 20:09:38+02:00 sam@mars.ravnborg.org +152 -0
# 
# scripts/Makefile.lib
#   2004/08/10 20:09:38+02:00 sam@mars.ravnborg.org +0 -49
#   Move host-progs functionality to scripts/Makefile.host
# 
# scripts/Makefile.host
#   2004/08/10 20:09:38+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/kbuild/scripts/Makefile.host
# 
# scripts/Makefile.build
#   2004/08/10 20:09:38+02:00 sam@mars.ravnborg.org +5 -84
#   Move host-progs functionality to scripts/Makefile.host
# 
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-08-13 21:08:23 +02:00
+++ b/scripts/Makefile.build	2004-08-13 21:08:23 +02:00
@@ -14,6 +14,11 @@
 
 include scripts/Makefile.lib
 
+# Do not include host-progs rules unles needed
+ifdef host-progs
+include scripts/Makefile.host
+endif
+
 ifneq ($(KBUILD_SRC),)
 # Create output directory if not already present
 _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
@@ -275,90 +280,6 @@
 
 targets += $(multi-used-y) $(multi-used-m)
 
-# Compile programs on the host
-# ===========================================================================
-# host-progs := bin2hex
-# Will compile bin2hex.c and create an executable named bin2hex
-#
-# host-progs    := lxdialog
-# lxdialog-objs := checklist.o lxdialog.o
-# Will compile lxdialog.c and checklist.c, and then link the executable
-# lxdialog, based on checklist.o and lxdialog.o
-#
-# host-progs      := qconf
-# qconf-cxxobjs   := qconf.o
-# qconf-objs      := menu.o
-# Will compile qconf as a C++ program, and menu as a C program.
-# They are linked as C++ code to the executable qconf
-
-# host-progs := conf
-# conf-objs  := conf.o libkconfig.so
-# libkconfig-objs := expr.o type.o
-# Will create a shared library named libkconfig.so that consist of
-# expr.o and type.o (they are both compiled as C code and the object file
-# are made as position independent code).
-# conf.c is compiled as a c program, and conf.o is linked together with
-# libkconfig.so as the executable conf.
-# Note: Shared libraries consisting of C++ files are not supported  
-#
-
-# Create executable from a single .c file
-# host-csingle -> Executable
-quiet_cmd_host-csingle 	= HOSTCC  $@
-      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(HOST_LOADLIBES) -o $@ $<
-$(host-csingle): %: %.c FORCE
-	$(call if_changed_dep,host-csingle)
-
-# Link an executable based on list of .o files, all plain c
-# host-cmulti -> executable
-quiet_cmd_host-cmulti	= HOSTLD  $@
-      cmd_host-cmulti	= $(HOSTCC) $(HOSTLDFLAGS) -o $@ \
-			  $(addprefix $(obj)/,$($(@F)-objs)) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
-$(host-cmulti): %: $(host-cobjs) $(host-cshlib) FORCE
-	$(call if_changed,host-cmulti)
-
-# Create .o file from a single .c file
-# host-cobjs -> .o
-quiet_cmd_host-cobjs	= HOSTCC  $@
-      cmd_host-cobjs	= $(HOSTCC) $(hostc_flags) -c -o $@ $<
-$(host-cobjs): %.o: %.c FORCE
-	$(call if_changed_dep,host-cobjs)
-
-# Link an executable based on list of .o files, a mixture of .c and .cc
-# host-cxxmulti -> executable
-quiet_cmd_host-cxxmulti	= HOSTLD  $@
-      cmd_host-cxxmulti	= $(HOSTCXX) $(HOSTLDFLAGS) -o $@ \
-			  $(foreach o,objs cxxobjs,\
-			  $(addprefix $(obj)/,$($(@F)-$(o)))) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
-$(host-cxxmulti): %: $(host-cobjs) $(host-cxxobjs) $(host-cshlib) FORCE
-	$(call if_changed,host-cxxmulti)
-
-# Create .o file from a single .cc (C++) file
-quiet_cmd_host-cxxobjs	= HOSTCXX $@
-      cmd_host-cxxobjs	= $(HOSTCXX) $(hostcxx_flags) -c -o $@ $<
-$(host-cxxobjs): %.o: %.cc FORCE
-	$(call if_changed_dep,host-cxxobjs)
-
-# Compile .c file, create position independent .o file
-# host-cshobjs -> .o
-quiet_cmd_host-cshobjs	= HOSTCC  -fPIC $@
-      cmd_host-cshobjs	= $(HOSTCC) $(hostc_flags) -fPIC -c -o $@ $<
-$(host-cshobjs): %.o: %.c FORCE
-	$(call if_changed_dep,host-cshobjs)
-
-# Link a shared library, based on position independent .o files
-# *.o -> .so shared library (host-cshlib)
-quiet_cmd_host-cshlib	= HOSTLLD -shared $@
-      cmd_host-cshlib	= $(HOSTCC) $(HOSTLDFLAGS) -shared -o $@ \
-			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
-$(host-cshlib): %: $(host-cshobjs) FORCE
-	$(call if_changed,host-cshlib)
-
-targets += $(host-csingle)  $(host-cmulti) $(host-cobjs)\
-	   $(host-cxxmulti) $(host-cxxobjs) $(host-cshlib) $(host-cshobjs) 
 
 # Descending
 # ---------------------------------------------------------------------------
diff -Nru a/scripts/Makefile.host b/scripts/Makefile.host
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/Makefile.host	2004-08-13 21:08:23 +02:00
@@ -0,0 +1,152 @@
+# ==========================================================================
+# Building binaries on the host system
+# Binaries are used during the compilation of the kernel, for example
+# to preprocess a data file.
+#
+# Both C and C++ is supported, but preferred language is C for such utilities.
+#
+# Samle syntax (see Documentation/kbuild/makefile.txt for reference)
+# host-progs := bin2hex
+# Will compile bin2hex.c and create an executable named bin2hex
+#
+# host-progs    := lxdialog
+# lxdialog-objs := checklist.o lxdialog.o
+# Will compile lxdialog.c and checklist.c, and then link the executable
+# lxdialog, based on checklist.o and lxdialog.o
+#
+# host-progs      := qconf
+# qconf-cxxobjs   := qconf.o
+# qconf-objs      := menu.o
+# Will compile qconf as a C++ program, and menu as a C program.
+# They are linked as C++ code to the executable qconf
+
+# host-progs := conf
+# conf-objs  := conf.o libkconfig.so
+# libkconfig-objs := expr.o type.o
+# Will create a shared library named libkconfig.so that consist of
+# expr.o and type.o (they are both compiled as C code and the object file
+# are made as position independent code).
+# conf.c is compiled as a c program, and conf.o is linked together with
+# libkconfig.so as the executable conf.
+# Note: Shared libraries consisting of C++ files are not supported  
+
+# host-progs := tools/build may have been specified. Retreive directory
+obj-dirs += $(foreach f,$(host-progs), $(if $(dir $(f)),$(dir $(f))))
+obj-dirs := $(strip $(sort $(filter-out ./,$(obj-dirs))))
+
+
+# C code
+# Executables compiled from a single .c file
+host-csingle	:= $(foreach m,$(host-progs),$(if $($(m)-objs),,$(m)))
+
+# C executables linked based on several .o files
+host-cmulti	:= $(foreach m,$(host-progs),\
+		   $(if $($(m)-cxxobjs),,$(if $($(m)-objs),$(m))))
+
+# Object (.o) files compiled from .c files
+host-cobjs	:= $(sort $(foreach m,$(host-progs),$($(m)-objs)))
+
+# C++ code
+# C++ executables compiled from at least on .cc file
+# and zero or more .c files
+host-cxxmulti	:= $(foreach m,$(host-progs),$(if $($(m)-cxxobjs),$(m)))
+
+# C++ Object (.o) files compiled from .cc files
+host-cxxobjs	:= $(sort $(foreach m,$(host-cxxmulti),$($(m)-cxxobjs)))
+
+# Shared libaries (only .c supported)
+# Shared libraries (.so) - all .so files referenced in "xxx-objs"
+host-cshlib	:= $(sort $(filter %.so, $(host-cobjs)))
+# Remove .so files from "xxx-objs"
+host-cobjs	:= $(filter-out %.so,$(host-cobjs))
+
+#Object (.o) files used by the shared libaries
+host-cshobjs	:= $(sort $(foreach m,$(host-cshlib),$($(m:.so=-objs))))
+
+host-progs      := $(addprefix $(obj)/,$(host-progs))
+host-csingle	:= $(addprefix $(obj)/,$(host-csingle))
+host-cmulti	:= $(addprefix $(obj)/,$(host-cmulti))
+host-cobjs	:= $(addprefix $(obj)/,$(host-cobjs))
+host-cxxmulti	:= $(addprefix $(obj)/,$(host-cxxmulti))
+host-cxxobjs	:= $(addprefix $(obj)/,$(host-cxxobjs))
+host-cshlib	:= $(addprefix $(obj)/,$(host-cshlib))
+host-cshobjs	:= $(addprefix $(obj)/,$(host-cshobjs))
+
+#####
+# Handle options to gcc. Support building with separate output directory
+
+_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
+_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
+
+ifeq ($(KBUILD_SRC),)
+__hostc_flags	= $(_hostc_flags)
+__hostcxx_flags	= $(_hostcxx_flags)
+else
+__hostc_flags	= -I$(obj) $(call flags,_hostc_flags)
+__hostcxx_flags	= -I$(obj) $(call flags,_hostcxx_flags)
+endif
+
+hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
+hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
+
+#####
+# Compile programs on the host
+
+# Create executable from a single .c file
+# host-csingle -> Executable
+quiet_cmd_host-csingle 	= HOSTCC  $@
+      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(HOST_LOADLIBES) -o $@ $<
+$(host-csingle): %: %.c FORCE
+	$(call if_changed_dep,host-csingle)
+
+# Link an executable based on list of .o files, all plain c
+# host-cmulti -> executable
+quiet_cmd_host-cmulti	= HOSTLD  $@
+      cmd_host-cmulti	= $(HOSTCC) $(HOSTLDFLAGS) -o $@ \
+			  $(addprefix $(obj)/,$($(@F)-objs)) \
+			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+$(host-cmulti): %: $(host-cobjs) $(host-cshlib) FORCE
+	$(call if_changed,host-cmulti)
+
+# Create .o file from a single .c file
+# host-cobjs -> .o
+quiet_cmd_host-cobjs	= HOSTCC  $@
+      cmd_host-cobjs	= $(HOSTCC) $(hostc_flags) -c -o $@ $<
+$(host-cobjs): %.o: %.c FORCE
+	$(call if_changed_dep,host-cobjs)
+
+# Link an executable based on list of .o files, a mixture of .c and .cc
+# host-cxxmulti -> executable
+quiet_cmd_host-cxxmulti	= HOSTLD  $@
+      cmd_host-cxxmulti	= $(HOSTCXX) $(HOSTLDFLAGS) -o $@ \
+			  $(foreach o,objs cxxobjs,\
+			  $(addprefix $(obj)/,$($(@F)-$(o)))) \
+			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+$(host-cxxmulti): %: $(host-cobjs) $(host-cxxobjs) $(host-cshlib) FORCE
+	$(call if_changed,host-cxxmulti)
+
+# Create .o file from a single .cc (C++) file
+quiet_cmd_host-cxxobjs	= HOSTCXX $@
+      cmd_host-cxxobjs	= $(HOSTCXX) $(hostcxx_flags) -c -o $@ $<
+$(host-cxxobjs): %.o: %.cc FORCE
+	$(call if_changed_dep,host-cxxobjs)
+
+# Compile .c file, create position independent .o file
+# host-cshobjs -> .o
+quiet_cmd_host-cshobjs	= HOSTCC  -fPIC $@
+      cmd_host-cshobjs	= $(HOSTCC) $(hostc_flags) -fPIC -c -o $@ $<
+$(host-cshobjs): %.o: %.c FORCE
+	$(call if_changed_dep,host-cshobjs)
+
+# Link a shared library, based on position independent .o files
+# *.o -> .so shared library (host-cshlib)
+quiet_cmd_host-cshlib	= HOSTLLD -shared $@
+      cmd_host-cshlib	= $(HOSTCC) $(HOSTLDFLAGS) -shared -o $@ \
+			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
+			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+$(host-cshlib): %: $(host-cshobjs) FORCE
+	$(call if_changed,host-cshlib)
+
+targets += $(host-csingle)  $(host-cmulti) $(host-cobjs)\
+	   $(host-cxxmulti) $(host-cxxobjs) $(host-cshlib) $(host-cshobjs) 
+
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	2004-08-13 21:08:23 +02:00
+++ b/scripts/Makefile.lib	2004-08-13 21:08:23 +02:00
@@ -60,41 +60,11 @@
 
 # $(obj-dirs) is a list of directories that contain object files
 obj-dirs := $(dir $(multi-objs) $(subdir-obj-y))
-obj-dirs += $(foreach f,$(host-progs), $(if $(dir $(f)),$(dir $(f))))
-obj-dirs := $(strip $(sort $(filter-out ./,$(obj-dirs))))
 
 # Replace multi-part objects by their individual parts, look at local dir only
 real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m))) $(extra-y)
 real-objs-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
 
-# C code
-# Executables compiled from a single .c file
-host-csingle	:= $(foreach m,$(host-progs),$(if $($(m)-objs),,$(m)))
-
-# C executables linked based on several .o files
-host-cmulti	:= $(foreach m,$(host-progs),\
-		   $(if $($(m)-cxxobjs),,$(if $($(m)-objs),$(m))))
-
-# Object (.o) files compiled from .c files
-host-cobjs	:= $(sort $(foreach m,$(host-progs),$($(m)-objs)))
-
-# C++ code
-# C++ executables compiled from at least on .cc file
-# and zero or more .c files
-host-cxxmulti	:= $(foreach m,$(host-progs),$(if $($(m)-cxxobjs),$(m)))
-
-# C++ Object (.o) files compiled from .cc files
-host-cxxobjs	:= $(sort $(foreach m,$(host-cxxmulti),$($(m)-cxxobjs)))
-
-# Shared libaries (only .c supported)
-# Shared libraries (.so) - all .so files referenced in "xxx-objs"
-host-cshlib	:= $(sort $(filter %.so, $(host-cobjs)))
-# Remove .so files from "xxx-objs"
-host-cobjs	:= $(filter-out %.so,$(host-cobjs))
-
-#Object (.o) files used by the shared libaries
-host-cshobjs	:= $(sort $(foreach m,$(host-cshlib),$($(m:.so=-objs))))
-
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
@@ -113,14 +83,6 @@
 multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
 obj-dirs	:= $(addprefix $(obj)/,$(obj-dirs))
-host-progs      := $(addprefix $(obj)/,$(host-progs))
-host-csingle	:= $(addprefix $(obj)/,$(host-csingle))
-host-cmulti	:= $(addprefix $(obj)/,$(host-cmulti))
-host-cobjs	:= $(addprefix $(obj)/,$(host-cobjs))
-host-cxxmulti	:= $(addprefix $(obj)/,$(host-cxxmulti))
-host-cxxobjs	:= $(addprefix $(obj)/,$(host-cxxobjs))
-host-cshlib	:= $(addprefix $(obj)/,$(host-cshlib))
-host-cshobjs	:= $(addprefix $(obj)/,$(host-cshobjs))
 
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
@@ -136,12 +98,8 @@
 basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
 modname_flags  = $(if $(filter 1,$(words $(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
 
-
 _c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
-_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
-_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
-
 
 # If building the kernel in a separate objtree expand all occurrences
 # of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
@@ -149,8 +107,6 @@
 ifeq ($(KBUILD_SRC),)
 __c_flags	= $(_c_flags)
 __a_flags	= $(_a_flags)
-__hostc_flags	= $(_hostc_flags)
-__hostcxx_flags	= $(_hostcxx_flags)
 else
 
 # Prefix -I with $(srctree) if it is not an absolute path
@@ -164,8 +120,6 @@
 # FIXME: Replace both with specific CFLAGS* statements in the makefiles
 __c_flags	= $(call addtree,-I$(obj)) $(call flags,_c_flags)
 __a_flags	=                          $(call flags,_a_flags)
-__hostc_flags	= -I$(obj)                 $(call flags,_hostc_flags)
-__hostcxx_flags	= -I$(obj)                 $(call flags,_hostcxx_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
@@ -174,9 +128,6 @@
 
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__a_flags) $(modkern_aflags)
-
-hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
-hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
 
 ld_flags       = $(LDFLAGS) $(EXTRA_LDFLAGS)
 
