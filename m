Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUDMEvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUDMEvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:51:35 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:50541 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263340AbUDMEv0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:51:26 -0400
Date: Tue, 13 Apr 2004 06:58:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Marcus Hartig <m.f.h@web.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm4
Message-ID: <20040413045826.GB2199@mars.ravnborg.org>
Mail-Followup-To: Marcus Hartig <m.f.h@web.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <407AEBB0.1050305@web.de> <20040412195636.GB12665@mars.ravnborg.org> <407B00AE.7010306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407B00AE.7010306@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 10:48:46PM +0200, Marcus Hartig wrote:
> 
> LD [M]  /usr/src/nv/nvidia.o
> /bin/sh: line 1: /usr/src/nv/.tmp_versions/nvidia.mod: No such file or 
> directory  Building modules, stage 2.
> make[1]: Leaving directory `/usr/src/linux-2.6.5-mm4'
> nvidia.ko failed to build!
> make: *** [module] Error 1

Thanks for the report.

kbuild fails to create the .tmp_version directory in the
directory where the module is being built.
The reason to create it there is to avoid trying to write in a RO
kernel src directory. And also to avoid cluttering up the .tmp_versions
directory for the kernel if you build more than one module.

	Sam

Patch to fix it:
--- linux-2.6.5/Makefile	2004-04-12 20:58:30.000000000 +0200
+++ extmod/Makefile	2004-04-12 20:46:24.000000000 +0200
@@ -787,12 +787,6 @@ endef
 # make mrproper  Delete the current configuration, and all generated files
 # make distclean Remove editor backup files, patch leftover files and the like
 
-quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
-      cmd_rmdirs = rm -rf $(rm-dirs)
-
-quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
-      cmd_rmfiles = rm -f $(rm-files)
-
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
 CLEAN_FILES +=	vmlinux System.map kernel.spec \
@@ -951,9 +945,12 @@ else # KBUILD_EXTMOD
 
 # We are always building modules
 KBUILD_MODULES := 1
+.PHONY: crmodverdir
+crmodverdir: FORCE
+	$(Q)mkdir -p $(MODVERDIR)
 
 .PHONY: $(KBUILD_EXTMOD)
-$(KBUILD_EXTMOD): FORCE
+$(KBUILD_EXTMOD): crmodverdir FORCE
 	$(Q)$(MAKE) $(build)=$@
 
 .PHONY: modules
@@ -971,7 +968,9 @@ clean-dirs := _clean_$(KBUILD_EXTMOD)
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
+clean:	rm-dirs := $(MODVERDIR)
 clean: $(clean-dirs)
+	$(call cmd,rmdirs)
 	@find $(KBUILD_EXTMOD) $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
@@ -1058,6 +1057,13 @@ endif #ifeq ($(mixed-targets),1)
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 
+quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
+      cmd_rmdirs = rm -rf $(rm-dirs)
+
+quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
+      cmd_rmfiles = rm -f $(rm-files)
+
+
 a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) \
 	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
