Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbSIYDfc>; Tue, 24 Sep 2002 23:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbSIYDXT>; Tue, 24 Sep 2002 23:23:19 -0400
Received: from dp.samba.org ([66.70.73.150]:45184 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261891AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] Module rewrite 1/20: KBUILD_MODNAME
Date: Wed, 25 Sep 2002 12:59:02 +1000
Message-Id: <20020925032201.B76B72C139@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	I leave in about 28 hours for my wedding + honeymoon, back 14
October.  So now is a good time to apply the module replacement
patches.  They survive stress testing here.

Trivial replacement module utils:
 http://www.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.5.tar.gz

After all these patches, the TODO list:
1) Merge other architectures (see my page for some of them).

2) Trivial module utils's modprobe should be taught to read
   modules.conf and device table.s

3) Convert the remaining __setup() calls (the core kernel and anything
   I needed is already converted).

4) Module versioning makefile work (discussed with Kai, he likes it).

5) Most modules won't remove without rmmod -f until they get looked
   over and changed to module_fini() (this marks them as "audited").

And if any problems occur while I'm away, you have the source 8)

The entire patch rolled into one can be found at:
 http://www.kernel.org/pub/linux/kernel/people/rusty/patches/module-x86-25-09-2002.2.5.38.diff.gz

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

===== Rules.make 1.68 vs edited =====
--- 1.68/Rules.make	Mon Jul 29 14:55:41 2002
+++ edited/Rules.make	Tue Jul 30 21:27:46 2002
@@ -95,11 +95,15 @@
 multi-used-y := $(filter-out $(list-multi),$(__multi-used-y))
 multi-used-m := $(filter-out $(list-multi),$(__multi-used-m))
 
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
@@ -115,6 +119,23 @@
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
@@ -164,11 +185,10 @@
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
@@ -259,6 +279,7 @@
 
 $(real-objs-m)        : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.i)  : modkern_cflags := $(CFLAGS_MODULE)
+$(real-objs-m:.o=.s)  : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.lst): modkern_cflags := $(CFLAGS_MODULE)
 
 $(export-objs)        : export_flags   := $(EXPORT_FLAGS)
@@ -266,10 +287,13 @@
 $(export-objs:.o=.s)  : export_flags   := $(EXPORT_FLAGS)
 $(export-objs:.o=.lst): export_flags   := $(EXPORT_FLAGS)
 
-c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
-	  $(export_flags) 
+# Default for not multi-part modules
+modname = $(*F)
+
+$(multi-objs)         : modname = $(modname-multi)
+$(multi-objs:.o=.i)   : modname = $(modname-multi)
+$(multi-objs:.o=.s)   : modname = $(modname-multi)
+$(multi-objs:.o=.lst) : modname = $(modname-multi)
 
 quiet_cmd_cc_s_c = CC     $(echo_target)
 cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1187-linux-2.5.34/net/unix/af_unix.c .1187-linux-2.5.34.updated/net/unix/af_unix.c
--- .1187-linux-2.5.34/net/unix/af_unix.c	2002-08-28 09:29:55.000000000 +1000
+++ .1187-linux-2.5.34.updated/net/unix/af_unix.c	2002-09-10 16:39:53.000000000 +1000
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
