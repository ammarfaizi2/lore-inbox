Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265946AbUFTVNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUFTVNu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUFTVNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:13:49 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:12412 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265951AbUFTVMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:12:36 -0400
Date: Sun, 20 Jun 2004 23:23:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: [PATCH 2/2] kbuild: Improved external module support
Message-ID: <20040620212353.GD10189@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruen@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>
References: <20040620211905.GA10189@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620211905.GA10189@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/20 22:59:03+02:00 sam@mars.ravnborg.org 
#   kbuild: External module support improved
#   
#   To improve support for external modules and to make usage
#   of separate output directory easier the following
#   changes has been implemented:
#   
#   1) When using a separate output directory create a small
#      Makefile that is a simple wrapper, calling the Makefile
#      in the kernel tree.
#      - This allows the user to shift to the output directory
#        and execute make.
#      - The Makefile is also useful to document the location
#        source used for the kernel
#   
#   2) When installing the kernel a new symlink is now created
#      pointing to the source of kernel.
#   
#   3) The build symlink now points to the output of the kernel
#      compile.
#      - When a kernel is compiled with output and source
#        mixed, the build and source symlinks will point
#        to the same directory. In this case there is
#        no change in behaviour.
#   
#   Adding the Makefile in step 1) allow the for a long
#   time recommended way to build an external module to
#   continue working even with separate output directory.
#   
#   The following command now works independent of the kernel
#   being build with separate output directory, or with
#   output and source mixed.
#   
#           make -C /lib/modules/`uname -r`/build M=`pwd`
#   
#   [Substituting M= with SUBDIRS= give same effect].
#   
#   It is recommended that distributions pick up this
#   method, and especially start shipping kernel output and
#   source separately.
#   
#   Please note that when the kernel is being build
#   using a separate output directory it may (will?) break
#   modules that has not yet picked up the recommended
#   way to build modules for 2.6.
#   See Documentation/kbuild/modules.txt for details.
#   
#   Patch includes contributions from:
#           Andreas Gruenbacher <agruen@suse.de> and
#           Geert Uytterhoeven <geert@linux-m68k.org>
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/mkmakefile
#   2004/06/20 22:58:48+02:00 sam@mars.ravnborg.org +25 -0
# 
# scripts/mkmakefile
#   2004/06/20 22:58:48+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/kbuild/scripts/mkmakefile
# 
# Makefile
#   2004/06/20 22:58:48+02:00 sam@mars.ravnborg.org +23 -4
#   External module support improved
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-06-20 23:06:03 +02:00
+++ b/Makefile	2004-06-20 23:06:03 +02:00
@@ -608,14 +608,23 @@
 # A multi level approach is used. prepare1 is updated first, then prepare0.
 # prepare-all is the collection point for the prepare targets.
 
-.PHONY: prepare-all prepare prepare0 prepare1
+.PHONY: prepare-all prepare prepare0 prepare1 prepare2
+
+# prepare 2 generate Makefile to be placed in output directory, if
+# using a seperate output directory. This allows convinient use
+# of make in output directory
+prepare2:
+	$(Q)if [ ! $(srctree) -ef $(objtree) ]; then \
+	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree) $(objtree) \
+	> $(objtree)/Makefile; \
+	fi 
 
 # prepare1 is used to check if we are building in a separate output directory,
 # and if so do:
 # 1) Check that make has not been executed in the kernel src $(srctree)
 # 2) Create the include2 directory, used for the second asm symlink
 
-prepare1:
+prepare1: prepare2
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
 	$(Q)if [ -h $(srctree)/include/asm -o -f $(srctree)/.config ]; then \
@@ -725,6 +734,12 @@
 modules_prepare: prepare-all scripts
 
 # Target to install modules
+# Modules are pr. default installed in /lib/modules/$(KERNELRELEASE)/...
+# Within this directory create two symlinks:
+# build => link to the directory containing the output files of the kernel build
+# source => link to the directory containing the source for the kernel
+# source and build are equal except for the case when the kernel is build using
+# a separate output directory
 .PHONY: modules_install
 modules_install: _modinst_ _modinst_post
 
@@ -736,9 +751,13 @@
 		sleep 1; \
 	fi
 	@rm -rf $(MODLIB)/kernel
-	@rm -f $(MODLIB)/build
+	@rm -f $(MODLIB)/source
 	@mkdir -p $(MODLIB)/kernel
-	@ln -s $(TOPDIR) $(MODLIB)/build
+	@ln -s $(srctree) $(MODLIB)/source
+	@if [ ! $(objtree) -ef  $(MODLIB)/build ]; then \
+		rm -f $(MODLIB)/build ; \
+		ln -s $(objtree) $(MODLIB)/build ; \
+	fi
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
 
 # If System.map exists, run depmod.  This deliberately does not have a
diff -Nru a/scripts/mkmakefile b/scripts/mkmakefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/mkmakefile	2004-06-20 23:06:03 +02:00
@@ -0,0 +1,25 @@
+#!/bin/sh
+# Generates a small Makefile used in the root of the output
+# directory, to allow make to be started from there.
+# The Makefile also allow for more convinient build of external modules
+
+# Usage
+# $1 - Kernel src directory
+# $2 - Output directory
+
+
+cat << EOF
+
+KERNELSRC    := $1
+KERNELOUTPUT := $2
+
+MAKEFLAGS += --no-print-directory
+
+all:
+	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
+
+%:
+	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT) \$@
+
+EOF
+
