Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318794AbSG0RH4>; Sat, 27 Jul 2002 13:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318795AbSG0RH4>; Sat, 27 Jul 2002 13:07:56 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:65187 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S318794AbSG0RHz>; Sat, 27 Jul 2002 13:07:55 -0400
Date: Sat, 27 Jul 2002 12:11:10 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] new module interface 
In-Reply-To: <20020727070410.B44A0418B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207271210160.8263-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002, Rusty Russell wrote:

> You can just send me the patch though, and I'll throw it on my page
> and make the module replacement patch Depend: on it.  I'll also give
> it some good testing.

Here we go.

--Kai


===== Rules.make 1.67 vs edited =====
--- 1.67/Rules.make	Thu Jun 20 12:50:27 2002
+++ edited/Rules.make	Sat Jul 27 12:08:31 2002
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
+# $(modname_flags) #defines KBUILD_OBJECT as the name of the module it will 
+# end up in (or would, if it gets compiled in)
+# Note: It's possible that one object gets potentially linked into more
+#       than one module. In that case KBUILD_OBJECT will be set to foo_bar,
+#       where foo and bar are the name of the modules.
+basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
+modname_flags  = -DKBUILD_OBJECT=$(subst $(space),_,$(strip $(if $(filter $(*F).o,$(multi-objs)),\
+	         $(foreach m,$(multi-used),\
+                   $(if $(filter $(*F).o,$($(m:.o=-objs))),$(m:.o=))),\
+	         $(*F))))
+c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
+	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
+	         $(basename_flags) $(modname_flags) $(export_flags) 
+
+
 # We're called for one of three purposes:
 # o fastdep: build module version files (.ver) for $(export-objs) in
 #   the current directory
@@ -165,11 +186,6 @@
 $(addprefix $(MODVERDIR)/,$(real-objs-m:.o=.ver)): modkern_cflags := $(CFLAGS_MODULE)
 $(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver)): export_flags   := -D__GENKSYMS__
 
-c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
-	  $(export_flags) 
-
 # Our objects only depend on modversions.h, not on the individual .ver
 # files (fix-dep filters them), so touch modversions.h if any of the .ver
 # files changes
@@ -265,11 +281,6 @@
 $(export-objs:.o=.i)  : export_flags   := $(EXPORT_FLAGS)
 $(export-objs:.o=.s)  : export_flags   := $(EXPORT_FLAGS)
 $(export-objs:.o=.lst): export_flags   := $(EXPORT_FLAGS)
-
-c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
-	  $(export_flags) 
 
 quiet_cmd_cc_s_c = CC     $(echo_target)
 cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 

