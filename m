Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUDMErX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUDMErX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:47:23 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:32886 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263325AbUDMErT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:47:19 -0400
Date: Tue, 13 Apr 2004 06:54:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Vasquez <praka@users.sourceforge.net>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org, Marcus Hartig <m.f.h@web.de>
Subject: Re: 2.6.5-mm4
Message-ID: <20040413045419.GA2199@mars.ravnborg.org>
Mail-Followup-To: Andrew Vasquez <praka@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, sam@ravnborg.org,
	Marcus Hartig <m.f.h@web.de>
References: <407AEBB0.1050305@web.de> <20040412195636.GB12665@mars.ravnborg.org> <20040412201524.GA31684@praka.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412201524.GA31684@praka.local.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 01:15:24PM -0700, Andrew Vasquez wrote:
> With 2.6.5-mm4 a similar command fails with:
> 
> 	-bash-2.05b# make -C /usr/src/linux-2.6.5-mm4 SUBDIRS=$PWD modules
> 	make: Entering directory `/usr/src/linux-2.6.5-mm4'
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/ql2300.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/ql2300_fw.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_os.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_init.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_mbx.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_iocb.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_isr.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_gs.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_dbg.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_sup.o
> 	  CC [M]  /root/Drivers/8.x/80000b12-pre14/qla_rscn.o
> 	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2xxx.o
> 	/bin/sh: line 1:
> 	/root/Drivers/8.x/80000b12-pre14/.tmp_versions/qla2xxx.mod: No such
> 	file or directory

The external module support failed to create the directory:
$PWD/.tmp_version

It was no deleted during make clean either - thats why it slipped through.
Here is a patch to fix it.

	Sam

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
