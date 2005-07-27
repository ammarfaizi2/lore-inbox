Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVG0TSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVG0TSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVG0TQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:16:54 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:51790 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261910AbVG0TQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:16:23 -0400
Date: Wed, 27 Jul 2005 21:16:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2 (kbuild broken for external modules)
Message-ID: <20050727191645.GA30081@mars.ravnborg.org>
References: <20050727024330.78ee32c2.akpm@osdl.org> <E1DxkiX-0001FB-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DxkiX-0001FB-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 02:08:57PM +0200, Miklos Szeredi wrote:
> >  git-kbuild.patch
> 
> This breaks building of external modules:
> 
>    make -C /usr/src/linux-2.6.13-rc3-mm2 M=/home/miko/fuse/kernel modules
>    make[1]: Entering directory `/usr/src/linux-2.6.13-rc3-mm2'
>    
>      WARNING: Symbol version dump /usr/src/linux-2.6.13-rc3-mm2/Module.symvers
>               is missing; modules will have no dependencies and modversions.
>    
>    scripts/Makefile.build:14: /usr/src/linux-2.6.13-rc3-mm2//home/miko/fuse/kernel/Makefile: No such file or directory
>    make[2]: *** No rule to make target `/usr/src/linux-2.6.13-rc3-mm2//home/miko/fuse/kernel/Makefile'.  Stop.
>    make[1]: *** [_module_/home/miko/fuse/kernel] Error 2
>    make[1]: Leaving directory `/usr/src/linux-2.6.13-rc3-mm2'
>    make: *** [all-spec] Error 2

Thanks for the report. I had overlooked this usage when modifying this
part of kbuild.
The following fix it - and work in the following test setups:
make
make O=
make M=
make O= M=

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -11,8 +11,8 @@ __build:
 -include .config
 
 # The filename Kbuild has precedence over Makefile
-include $(if $(wildcard $(srctree)/$(src)/Kbuild), \
-                        $(srctree)/$(src)/Kbuild, $(srctree)/$(src)/Makefile)
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
 
 include scripts/Kbuild.include
 include scripts/Makefile.lib
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -13,8 +13,8 @@ __clean:
 clean := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.clean obj
 
 # The filename Kbuild has precedence over Makefile
-include $(if $(wildcard $(srctree)/$(src)/Kbuild), \
-                        $(srctree)/$(src)/Kbuild, $(srctree)/$(src)/Makefile)
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
 
 # Figure out what we need to build from the various variables
 # ==========================================================================
