Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSGaCaZ>; Tue, 30 Jul 2002 22:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317658AbSGaCaZ>; Tue, 30 Jul 2002 22:30:25 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:22965 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317653AbSGaCaY>; Tue, 30 Jul 2002 22:30:24 -0400
Date: Tue, 30 Jul 2002 21:33:32 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automatic module_init ordering
In-Reply-To: <3D471B9B.5801FD6C@linux-m68k.org>
Message-ID: <Pine.LNX.4.44.0207302110570.19799-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002, Roman Zippel wrote:

> Hi,
> 
> Rusty Russell wrote:
> 
> > Yes, I think we should do this: merge the two together.  You seem to
> > be in a coding frenzy: want to do the first cut?
> 
> I attached a new version, that only orders module_init(). I did some
> small compile performance tests and I could only see a few seconds
> difference, so the overhead should be negligible.

Okay, here's a suggestion to slightly reorganize the KBUILD_MODNAME
part in Rules.make.

- Some sreorganization of the c_flags since they're needed for
  generating modversions (.ver) and compiling
- Use the right KBUILD_MODNAME also when the user just wants a .i/.s/.lst 
  file for debugging and also when generating modversions
- It looks like with your current approach you can't have a ',' or '-' in
  KBUILD_MODNAME - however, that means that KBUILD_MODNAME is not quite
  right for passing module parameters for built-in modules on the command
  line, it would be confusing to pass parameters for ide-cd as 
  ide_cd.foo=whatever. So that part could use a little more thought.
- If you think your module_names trick makes a noticable difference, feel
  free to re-add it.
- It's possible that objects are linked into more than one module - I 
  suppose this shouldn't be a problem, since these objects hopefully
  don't have a module_init() nor do they export symbols. Not sure if your
  patch did handle this.

--Kai


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

