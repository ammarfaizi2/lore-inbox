Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSJPXCH>; Wed, 16 Oct 2002 19:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbSJPXCH>; Wed, 16 Oct 2002 19:02:07 -0400
Received: from dp.samba.org ([66.70.73.150]:35244 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261454AbSJPXBP>;
	Wed, 16 Oct 2002 19:01:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] KBUILD_MODNAME
Date: Thu, 17 Oct 2002 09:06:52 +1000
Message-Id: <20021016230712.7717C2C07B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus (or Kai) please apply (Kai's patch, updated for 2.5.43).

It works beautifully.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: KBUILD_MODNAME define for build system
Author: Kai Germaschewski
Status: Tested on 2.5.38

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

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19753-linux-2.5.43/Rules.make .19753-linux-2.5.43.updated/Rules.make
--- .19753-linux-2.5.43/Rules.make	2002-10-15 15:30:50.000000000 +1000
+++ .19753-linux-2.5.43.updated/Rules.make	2002-10-16 19:48:25.000000000 +1000
@@ -97,11 +97,15 @@ __obj-m = $(filter-out export.o,$(obj-m)
 multi-used-y := $(sort $(foreach m,$(__obj-y), $(if $($(m:.o=-objs)), $(m))))
 multi-used-m := $(sort $(foreach m,$(__obj-m), $(if $($(m:.o=-objs)), $(m))))
 
+multi-used   := $(multi-used-y) $(multi-used-m)
+
 # Build list of the parts of our composite objects, our composite
 # objects depend on those (obviously)
 multi-objs-y := $(foreach m, $(multi-used-y), $($(m:.o=-objs)))
 multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)))
 
+multi-objs   := $(multi-objs-y) $(multi-objs-m)
+
 # $(subdir-obj-y) is the list of objects in $(obj-y) which do not live
 # in the local directory
 subdir-obj-y := $(foreach o,$(obj-y),$(if $(filter-out $(o),$(notdir $(o))),$(o)))
@@ -132,6 +136,23 @@ subdir-ym	:= $(addprefix $(obj)/,$(subdi
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
 # We're called for one of three purposes:
 # o fastdep: build module version files (.ver) for $(export-objs) in
 #   the current directory
@@ -181,11 +202,10 @@ CFLAGS_MODULE := $(filter-out -include l
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
@@ -281,6 +301,7 @@ modkern_cflags := $(CFLAGS_KERNEL)
 
 $(real-objs-m)        : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.i)  : modkern_cflags := $(CFLAGS_MODULE)
+$(real-objs-m:.o=.s)  : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.lst): modkern_cflags := $(CFLAGS_MODULE)
 
 $(export-objs)        : export_flags   := $(EXPORT_FLAGS)
@@ -288,10 +309,17 @@ $(export-objs:.o=.i)  : export_flags   :
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
 
 quiet_cmd_cc_s_c = CC      $(echo_target)
 cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19753-linux-2.5.43/net/unix/af_unix.c .19753-linux-2.5.43.updated/net/unix/af_unix.c
--- .19753-linux-2.5.43/net/unix/af_unix.c	2002-10-16 15:01:28.000000000 +1000
+++ .19753-linux-2.5.43.updated/net/unix/af_unix.c	2002-10-16 19:48:25.000000000 +1000
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
