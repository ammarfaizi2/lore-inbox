Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVIFUZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVIFUZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVIFUZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:25:20 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:32402 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750879AbVIFUZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:25:18 -0400
Date: Tue, 6 Sep 2005 22:25:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kbuild: building with a mostly-clean /usr/src/linux and O=
Message-ID: <20050906202552.GA17931@mars.ravnborg.org>
References: <200509062213.52989.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509062213.52989.agruen@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 10:13:52PM +0200, Andreas Gruenbacher wrote:
> When compiling a kernel with a separate output directory,
> 
>   /var/tmp/kernel-obj>  cp $CONFIG_FILE .config
>   /var/tmp/kernel-obj>  make -C /usr/src/linux O=`pwd`
> 
> the main kernel Makefile first tries to make sure that /usr/src/linux
> is a clean source tree by checking if /usr/src/linux contains .config
> or the include/asm symlink. This test is more restrictive than
> necessary, and can be relaxed with a few additional changes so that
> /usr/src/linux may contain a few additional critical files, and may
> still be used as the kernel compilation source.
> 
> The additional files I have in mind are include/asm,
> include/linux/version.h, include/linux/autoconf.h, and perhaps also
> include/asm/offset.h. With these files present, it's possible to use
> kernel headers from user-space. I know that's evil and frowned upon,
> but it's still done once in a while, and sometimes it's the least
> painful path compared to the alternatives. The kbuild changes required
> to allow this IMHO are harmless; please consider for inclusion.

I've already included below patch from you.
It was included in -linus last night.

Do we really need more?

	Sam

diff-tree d80e22460968ec7986c82fd7d207ebe3de59e03d (from c5f75eca120de6587e67a1951ce3e6912e2c6879)
Author: Sam Ravnborg <sam@mars.(none)>
Date:   Thu Jul 14 20:22:39 2005 +0000

    kbuild: Don't fail if include/asm symlink exists
    
    From: Andreas Gruenbacher <agruen@suse.de>
    
    We're having the following situation: There are user-space applications
    that include kernel headers directly. With a completely unconfigured
    /usr/src/linux tree, including most headers fails because essential
    files are not there:
    
    	include/asm
    	include/linux/autoconf.h
    	include/linux/version.h
    
    So we create these files. On the other hand, we want to use
    /usr/src/linux as read-only source for building kernels or additional
    modules. Now when building a kernel with a separate output directory
    (O=), there is a check in the main makefile for the include/asm symlink.
    There is no real need for this check: if we ensure that
    $(objdir)/include/asm is always created as the patch does,
    $(srctree)/include/asm becomes irrelevant.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -765,11 +765,11 @@ $(vmlinux-dirs): prepare-all scripts
 # 2) Create the include2 directory, used for the second asm symlink
 
 prepare2:
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
-	$(Q)if [ -h $(srctree)/include/asm -o -f $(srctree)/.config ]; then \
+	$(Q)if [ -f $(srctree)/.config ]; then \
 		echo "  $(srctree) is not clean, please run 'make mrproper'";\
 		echo "  in the '$(srctree)' directory.";\
 		/bin/false; \
 	fi;
 	$(Q)if [ ! -d include2 ]; then mkdir -p include2; fi;
@@ -777,11 +777,12 @@ ifneq ($(KBUILD_SRC),)
 endif
 
 # prepare1 creates a makefile if using a separate output directory
 prepare1: prepare2 outputmakefile
 
-prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
+prepare0: prepare1 include/linux/version.h $(objtree)/include/asm \
+                   include/config/MARKER
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
 endif
 
@@ -816,11 +817,11 @@ export CPPFLAGS_vmlinux.lds += -P -C -U$
 
 # 	FIXME: The asm symlink changes when $(ARCH) changes. That's
 #	hard to detect, but I suppose "make mrproper" is a good idea
 #	before switching between archs anyway.
 
-include/asm:
+$(objtree)/include/asm:
 	@echo '  SYMLINK $@ -> include/asm-$(ARCH)'
 	$(Q)if [ ! -d include ]; then mkdir -p include; fi;
 	@ln -fsn asm-$(ARCH) $@
 
 # 	Split autoconf.h into include/linux/config/*
