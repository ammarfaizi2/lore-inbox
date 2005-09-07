Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVIGHSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVIGHSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 03:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVIGHSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 03:18:48 -0400
Received: from [195.33.99.132] ([195.33.99.132]:57125 "EHLO
	emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750994AbVIGHSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 03:18:47 -0400
Message-Id: <431EB0AF02000078000241C0@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 07 Sep 2005 09:19:43 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, "Andreas Gruenbacher" <agruen@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kbuild: building with a mostly-clean
	/usr/src/linux and O=
References: <200509062213.52989.agruen@suse.de>  <20050906202552.GA17931@mars.ravnborg.org> <200509070303.45009.agruen@suse.de>
In-Reply-To: <200509070303.45009.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately this isn't sufficient, yet. In the architecture-specific
makefiles asm-offsets.s (or however the specific architectures call
this) now need their dependencies on include/linux/version.h changed (I
wonder whether it wouldn't be more efficient to centralize these
dependencies into an architecture-independent file, perhaps at once
applying consistent naming across all architectures), and
arch/um/Makefile additionally has a dangling dependency on
include/linux/autoconf.h now.

greping all Make* across the tree easily shows all locations needing
additional changes.

Jan

>>> Andreas Gruenbacher <agruen@suse.de> 07.09.05 03:03:44 >>>
On Tuesday 06 September 2005 22:25, Sam Ravnborg wrote:
> I've already included below patch from you.
> It was included in -linus last night.

That was close.

> Do we really need more?

So it seems I'm afraid: With the version of this patch that just went
in, Jan Beulich <jbeulich@novell.com> found a bug when building
vmlinux.lds on i386. He triggered it by by putting poisoned version.h
and
autoconf.h files in /usr/src/linux.

With the additional changes (rediff against linux-2.6.13-git6
below), things work as expected. There may be a slightly
more minimalistic solution that also works --- I didn't want to risk
strange failures.

(To not confuse people, let me add that this all doesn't matter if the
source tree is distclean.)

Cheers,
Andreas.


Additional fixes for building with O= against a non-distclean tree

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.13-git6/Makefile
===================================================================
--- linux-2.6.13-git6.orig/Makefile
+++ linux-2.6.13-git6/Makefile
@@ -462,7 +462,7 @@ ifeq ($(KBUILD_EXTMOD),)
 scripts: scripts_basic include/config/MARKER
 	$(Q)$(MAKE) $(build)=$(@)
 
-scripts_basic: include/linux/autoconf.h
+scripts_basic: $(objtree)/include/linux/autoconf.h
 
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
@@ -488,11 +488,11 @@ include .config
 
 # If .config is newer than include/linux/autoconf.h, someone tinkered
 # with it and forgot to run make oldconfig
-include/linux/autoconf.h: .config
+$(objtree)/include/linux/autoconf.h: .config
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
 # Dummy target needed, because used as prerequisite
-include/linux/autoconf.h: ;
+$(objtree)/include/linux/autoconf.h: ;
 endif
 
 # The all: target is the default when no target is given on the
@@ -798,7 +798,7 @@ endif
 # prepare1 creates a makefile if using a separate output directory
 prepare1: prepare2 outputmakefile
 
-prepare0: prepare1 include/linux/version.h include/asm \
+prepare0: prepare1 $(objtree)/include/linux/version.h
$(objtree)/include/asm \
                    include/config/MARKER
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
@@ -838,14 +838,15 @@ export CPPFLAGS_vmlinux.lds += -P -C -U$
 #	hard to detect, but I suppose "make mrproper" is a good idea
 #	before switching between archs anyway.
 
-include/asm:
+include/asm: $(objtree)/include/asm
+$(objtree)/include/asm:
 	@echo '  SYMLINK $@ -> include/asm-$(ARCH)'
 	$(Q)if [ ! -d include ]; then mkdir -p include; fi;
 	@ln -fsn asm-$(ARCH) $@
 
 # 	Split autoconf.h into include/linux/config/*
 
-include/config/MARKER: include/linux/autoconf.h
+include/config/MARKER: $(objtree)/include/linux/autoconf.h
 	@echo '  SPLIT   include/linux/autoconf.h -> include/config/*'
 	@scripts/basic/split-include include/linux/autoconf.h
include/config
 	@touch $@
@@ -869,7 +870,7 @@ define filechk_version.h
 	)
 endef
 
-include/linux/version.h: $(srctree)/Makefile FORCE
+$(objtree)/include/linux/version.h: $(srctree)/Makefile FORCE
 	$(call filechk,version.h)
 
 #
---------------------------------------------------------------------------
Index: linux-2.6.13-git6/scripts/Makefile.lib
===================================================================
--- linux-2.6.13-git6.orig/scripts/Makefile.lib
+++ linux-2.6.13-git6/scripts/Makefile.lib
@@ -98,7 +98,7 @@ __cpp_flags     = $(_cpp_flags)
 else
 
 # Prefix -I with $(srctree) if it is not an absolute path
-addtree = $(if $(filter-out -I/%,$(1)),$(patsubst
-I%,-I$(srctree)/%,$(1))) $(1)
+addtree = $(1) $(if $(filter-out -I/%,$(1)),$(patsubst
-I%,-I$(srctree)/%,$(1)))
 # Find all -I options and call addtree
 flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call
addtree,$(o)),$(o)))
