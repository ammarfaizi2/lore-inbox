Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWF3WrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWF3WrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWF3WrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:47:13 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:2740 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750822AbWF3WrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:47:11 -0400
Date: Sat, 1 Jul 2006 00:47:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix kbuild module names (was: Re: oom-killer problem)
Message-ID: <20060630224706.GB29587@mars.ravnborg.org>
References: <200606281706.15514.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606281552190.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606281552190.12404@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 03:54:01PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 28 Jun 2006, Daniel Ritz wrote:
> >
> > had a look again. this one on top of "kbuild: fix make -rR breakage" (ie. revert
> > the revert) should fix the module nameing.
> > 
> > Sam if you agree, please add your signed-off-by and forward to Linus.
> 
> Btw, I suspect I was wrong on the use of basename.
> 
> Yeah, you can do it carefully with that $(patsubst %.mod,%,..) thing, but 
> boy is that ugly and hard to read. Since the whole point was to hopefully 
> be safer, being "ugly and hard to read" is not exactly good, and I suspect 
> the original $(basename ..) was simply better.

Following is my take on it. In most cases $(basename $(notdir $@)) do
the trick. Only in Makefile.modpost we do some special to get rid of
.mod.o. That part is not nice but local to Makefile.modpost.

I will push it as soon as I get a confirmation that ia64 is fixed with
this fix.

	Sam

diff --git a/Makefile b/Makefile
index e9560c6..c4ea9cd 100644
--- a/Makefile
+++ b/Makefile
@@ -1352,7 +1352,7 @@ quiet_cmd_rmfiles = $(if $(wildcard $(rm
 
 a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) \
 	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
-	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(notdir $@))
 
 quiet_cmd_as_o_S = AS      $@
 cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index 1347dc6..813077f 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -8,7 +8,7 @@ USER_OBJS += $(filter %_user.o,$(obj-y) 
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS:.o=.%): \
-	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(*F).o)
+	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(basetarget).o)
 $(USER_OBJS) : CHECKFLAGS := -D__linux__ -Dlinux -D__STDC__ \
 	-Dunix -D__unix__ -D__$(SUBARCH)__
 
@@ -17,7 +17,7 @@ # using it directly.
 UNPROFILE_OBJS := $(foreach file,$(UNPROFILE_OBJS),$(obj)/$(file))
 
 $(UNPROFILE_OBJS:.o=.%): \
-	c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS)) $(CFLAGS_$(*F).o)
+	c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS)) $(CFLAGS_$(basetarget).o)
 $(UNPROFILE_OBJS) : CHECKFLAGS := -D__linux__ -Dlinux -D__STDC__ \
 	-Dunix -D__unix__ -D__$(SUBARCH)__
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b0d067b..2180c88 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -13,6 +13,10 @@ # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
 ###
+# filename of target with directory and extension stripped
+basetarget = $(basename $(notdir $@))
+
+###
 # Escape single quote for use in echo statements
 escsq = $(subst $(squote),'\$(squote)',$1)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 02a7eea..3cb445c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -117,7 +117,7 @@ quiet_modtag := $(empty)   $(empty)
 $(obj-m)              : quiet_modtag := [M]
 
 # Default for not multi-part modules
-modname = $(*F)
+modname = $(basetarget)
 
 $(multi-objs-m)         : modname = $(modname-multi)
 $(multi-objs-m:.o=.i)   : modname = $(modname-multi)
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 2b066d1..18ecd4d 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -80,8 +80,10 @@ obj-dirs += $(host-objdirs)
 #####
 # Handle options to gcc. Support building with separate output directory
 
-_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
-_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
+_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
+                 $(HOSTCFLAGS_$(basetarget).o)
+_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
+                 $(HOSTCXXFLAGS_$(basetarget).o)
 
 ifeq ($(KBUILD_SRC),)
 __hostc_flags	= $(_hostc_flags)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 2cb4935..fc498fe 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -82,12 +82,12 @@ # Note: It's possible that one object ge
 #       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
 #       where foo and bar are the name of the modules.
 name-fix = $(subst $(comma),_,$(subst -,_,$1))
-basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(*F)))"
+basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(basetarget)))"
 modname_flags  = $(if $(filter 1,$(words $(modname))),\
                  -D"KBUILD_MODNAME=KBUILD_STR($(call name-fix,$(modname)))")
 
-_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
-_a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(basetarget).o)
+_a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
 _cpp_flags     = $(CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
 
 # If building the kernel in a separate objtree expand all occurrences
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 576cce5..a495502 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -72,7 +72,7 @@ # Declare generated files as targets for
 # Step 5), compile all *.mod.c files
 
 # modname is set to make c_flags define KBUILD_MODNAME
-modname = $(*F)
+modname = $(notdir $(@:.mod.o=))
 
 quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
