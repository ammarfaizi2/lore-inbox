Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265104AbSJaGgw>; Thu, 31 Oct 2002 01:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265184AbSJaGgw>; Thu, 31 Oct 2002 01:36:52 -0500
Received: from dp.samba.org ([66.70.73.150]:34459 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265104AbSJaGgu>;
	Thu, 31 Oct 2002 01:36:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] Module rewrite series 1/5: KBUILD_MODNAME.
Date: Thu, 31 Oct 2002 17:39:57 +1100
Message-Id: <20021031064316.D9F5D2C0E1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, this includes the "fix intermodule" stuff as patch 5.  I compiled
a couple of drivers MTD and DRM drivers, but I have no way of testing
that they actually work (PPC doesn't build, and no x86 boxes with
DRM-compatible cards).

This has been stresstesting here in my 2-way x86 bot for 3 hours now
(3 loopback mount/unmount, 3 ext2 insmod/rmmod, 3 random
modprobe/rmmod).  While compiling and working as usual.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: KBUILD_MODNAME define for build system
Author: Kai Germaschewski
Status: Tested on 2.5.45

D: This patch adds a -DKBUILD_MODNAME to the kernel compile, which
D: contains the base of the module name which is being built.
D: 
D: - Some sreorganization of the c_flags since they're needed for
D:   generating modversions (.ver) and compiling
D: - Use the right KBUILD_MODNAME also when the user just wants a .i/.s/.lst 
D:   file for debugging and also when generating modversions
D: - It looks like with your current approach you can't have a ',' or '-' in
D:   KBUILD_MODNAME - however, that means that KBUILD_MODNAME is not quite
D:   right for passing module parameters for built-in modules on the command
D:   line, it would be confusing to pass parameters for ide-cd as 
D:   ide_cd.foo=whatever. So that part could use a little more thought.
D: - If you think your module_names trick makes a noticable difference, feel
D:   free to re-add it.
D: - It's possible that objects are linked into more than one module - I 
D:   suppose this shouldn't be a problem, since these objects hopefully
D:   don't have a module_init() nor do they export symbols. Not sure if your
D:   patch did handle this.
D: 
D: --Kai

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31872-linux-2.5.45/net/unix/af_unix.c .31872-linux-2.5.45.updated/net/unix/af_unix.c
--- .31872-linux-2.5.45/net/unix/af_unix.c	2002-10-16 15:01:28.000000000 +1000
+++ .31872-linux-2.5.45.updated/net/unix/af_unix.c	2002-10-30 13:51:12.000000000 +1100
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31872-linux-2.5.45/scripts/Makefile.build .31872-linux-2.5.45.updated/scripts/Makefile.build
--- .31872-linux-2.5.45/scripts/Makefile.build	2002-10-30 12:53:10.000000000 +1100
+++ .31872-linux-2.5.45.updated/scripts/Makefile.build	2002-10-30 13:54:32.000000000 +1100
@@ -54,6 +54,7 @@ modkern_cflags := $(CFLAGS_KERNEL)
 
 $(real-objs-m)        : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.i)  : modkern_cflags := $(CFLAGS_MODULE)
+$(real-objs-m:.o=.s)  : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.lst): modkern_cflags := $(CFLAGS_MODULE)
 
 $(export-objs)        : export_flags   := $(EXPORT_FLAGS)
@@ -61,10 +62,17 @@ $(export-objs:.o=.i)  : export_flags   :
 $(export-objs:.o=.s)  : export_flags   := $(EXPORT_FLAGS)
 $(export-objs:.o=.lst): export_flags   := $(EXPORT_FLAGS)
 
-c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
-	  $(export_flags) 
+# Default for not multi-part modules
+modname = $(*F)
+
+$(multi-objs-m)         : modname = $(modname-multi)
+$(multi-objs-m:.o=.i)   : modname = $(modname-multi)
+$(multi-objs-m:.o=.s)   : modname = $(modname-multi)
+$(multi-objs-m:.o=.lst) : modname = $(modname-multi)
+$(multi-objs-y)         : modname = $(modname-multi)
+$(multi-objs-y:.o=.i)   : modname = $(modname-multi)
+$(multi-objs-y:.o=.s)   : modname = $(modname-multi)
+$(multi-objs-y:.o=.lst) : modname = $(modname-multi)
 
 quiet_cmd_cc_s_c = CC      $@
 cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31872-linux-2.5.45/scripts/Makefile.lib .31872-linux-2.5.45.updated/scripts/Makefile.lib
--- .31872-linux-2.5.45/scripts/Makefile.lib	2002-10-30 12:53:10.000000000 +1100
+++ .31872-linux-2.5.45.updated/scripts/Makefile.lib	2002-10-30 13:52:07.000000000 +1100
@@ -5,6 +5,8 @@
 # Standard vars
 
 comma   := ,
+empty   :=
+space   := $(empty) $(empty)
 
 # Figure out what we need to build from the various variables
 # ===========================================================================
@@ -40,11 +40,13 @@ __obj-m = $(filter-out export.o,$(obj-m)
 # if $(foo-objs) exists, foo.o is a composite object 
 multi-used-y := $(sort $(foreach m,$(__obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
 multi-used-m := $(sort $(foreach m,$(__obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
+multi-used   := $(multi-used-y) $(multi-used-m)
 
 # Build list of the parts of our composite objects, our composite
 # objects depend on those (obviously)
 multi-objs-y := $(foreach m, $(multi-used-y), $($(m:.o=-objs)) $($(m:.o=-y)))
 multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)) $($(m:.o=-y)))
+multi-objs   := $(multi-objs-y) $(multi-objs-m)
 
 # $(subdir-obj-y) is the list of objects in $(obj-y) which do not live
 # in the local directory
@@ -84,6 +86,23 @@ host-progs-multi-objs := $(addprefix $(o
 # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
+# These flags are needed for modversions and compiling, so we define them here
+# already
+# $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will 
+# end up in (or would, if it gets compiled in)
+# Note: It's possible that one object gets potentially linked into more
+#       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
+#       where foo and bar are the name of the modules.
+basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
+modname_flags  = -DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname)))
+c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
+	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
+	         $(basename_flags) $(modname_flags) $(export_flags) 
+
+# Finds the multi-part object the current object will be linked into
+modname-multi = $(subst $(space),_,$(strip $(foreach m,$(multi-used),\
+		$(if $(filter $(*F).o,$($(m:.o=-objs))),$(m:.o=)))))
+
 # Shipped files
 # ===========================================================================
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31872-linux-2.5.45/scripts/Makefile.modver .31872-linux-2.5.45.updated/scripts/Makefile.modver
--- .31872-linux-2.5.45/scripts/Makefile.modver	2002-10-30 12:53:10.000000000 +1100
+++ .31872-linux-2.5.45.updated/scripts/Makefile.modver	2002-10-30 13:53:37.000000000 +1100
@@ -48,11 +48,10 @@ CFLAGS_MODULE := $(filter-out -include i
 $(addprefix $(MODVERDIR)/,$(real-objs-y:.o=.ver)): modkern_cflags := $(CFLAGS_KERNEL)
 $(addprefix $(MODVERDIR)/,$(real-objs-m:.o=.ver)): modkern_cflags := $(CFLAGS_MODULE)
 $(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver)): export_flags   := -D__GENKSYMS__
+# Default for not multi-part modules
+modname = $(*F)
 
-c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
-	  $(export_flags) 
+$(addprefix $(MODVERDIR)/,$(multi-objs:.o=.ver)) : modname = $(modname-multi)
 
 # Our objects only depend on modversions.h, not on the individual .ver
 # files (fix-dep filters them), so touch modversions.h if any of the .ver
