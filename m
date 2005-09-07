Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVIGBC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVIGBC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 21:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVIGBCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 21:02:55 -0400
Received: from mx1.suse.de ([195.135.220.2]:42405 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751183AbVIGBCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 21:02:55 -0400
From: Andreas Gruenbacher <agruen@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch] kbuild: building with a mostly-clean /usr/src/linux and O=
Date: Wed, 7 Sep 2005 03:03:44 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
References: <200509062213.52989.agruen@suse.de> <20050906202552.GA17931@mars.ravnborg.org>
In-Reply-To: <20050906202552.GA17931@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509070303.45009.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 22:25, Sam Ravnborg wrote:
> I've already included below patch from you.
> It was included in -linus last night.

That was close.

> Do we really need more?

So it seems I'm afraid: With the version of this patch that just went
in, Jan Beulich <jbeulich@novell.com> found a bug when building
vmlinux.lds on i386. He triggered it by by putting poisoned version.h and
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
+prepare0: prepare1 $(objtree)/include/linux/version.h $(objtree)/include/asm \
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
 	@scripts/basic/split-include include/linux/autoconf.h include/config
 	@touch $@
@@ -869,7 +870,7 @@ define filechk_version.h
 	)
 endef
 
-include/linux/version.h: $(srctree)/Makefile FORCE
+$(objtree)/include/linux/version.h: $(srctree)/Makefile FORCE
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------
Index: linux-2.6.13-git6/scripts/Makefile.lib
===================================================================
--- linux-2.6.13-git6.orig/scripts/Makefile.lib
+++ linux-2.6.13-git6/scripts/Makefile.lib
@@ -98,7 +98,7 @@ __cpp_flags     = $(_cpp_flags)
 else
 
 # Prefix -I with $(srctree) if it is not an absolute path
-addtree = $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1)
+addtree = $(1) $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1)))
 # Find all -I options and call addtree
 flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))
