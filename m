Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266054AbUFVVMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbUFVVMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266035AbUFVVKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:10:09 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:48761 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266021AbUFVVJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:09:00 -0400
Date: Tue, 22 Jun 2004 23:21:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Improve Kernel build with separated output
Message-ID: <20040622212100.GA9346@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild: Improve Kernel build with separated output

Patch is improved based on input from lkml. The changelog
has seen most changes better describing impact of the change.

To improve support for kernel build using separate output
directories the following changes are implemented:
1) A Makefile is generated in the output directory allowing
   one to execute make in both the source and the output directory.
2) A new symlink 'source' is introduced. The symlink is set
   to point to the kernel source when installing modules.

When a kernel is built with source and output files mixed this
patch will not introduce any change in behaviour.

When the kernel is built with separate output directory
there were previously no way to locate the output files.
Two options was considered:
a) Adding a new symlink pointing to the output files "object"
b) Let the build symlink point to the output files and
   introduce a new symlink "source" pointing to the kernel source

Option b) were selected based on the follwoing rationale.
Option b) allowed ordinary external modules that did not need
direct access to the kernel source to continue to
build with no modifications.

In comparsion option a) required all external modules to
use O= syntax (or set KBUILD_OUTPUT) in the case where the 
kernel was build using separate output directories.
This situation was foreseen to result in a lot of reports like:
"Module compile with vendor-a but not vendor-b - so vendor-b
need to fix their tree".
This sort of reports was expected for _all_ external modules,
no matter how simple they were. Selecting option b) limit
this to external modules that require direct access 
to kernel soruce.

So to re-iterate. Before this patch external modules could
be built when using O= - and it was always required
when the kernel used separate output directories.
Now external modules that needs direct access to source needs to
follow the source symlink to find the kernel source -
when the kernel uses separate output directory.

With this change the following command works independent
of the kernel being build with separate output directory,
or with output and source mixed.

	make -C /lib/modules/`uname -r`/build M=`pwd`

[Substituting M=... with SUBDIRS=`pwd`modules give same effect].

When the kernel is built using separate output directory the
above invocation of make will invoke the generated Makefile
located in the output directory - that again will invoke the
Makefile located in the kernel source tree root.

Patch includes contributions from:
	Andreas Gruenbacher <agruen@suse.de> and
	Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>


diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-06-22 23:02:40 +02:00
+++ b/Makefile	2004-06-22 23:02:40 +02:00
@@ -608,14 +608,24 @@
 # A multi level approach is used. prepare1 is updated first, then prepare0.
 # prepare-all is the collection point for the prepare targets.
 
-.PHONY: prepare-all prepare prepare0 prepare1
+.PHONY: prepare-all prepare prepare0 prepare1 prepare2
+
+# prepare 2 generate Makefile to be placed in output directory, if
+# using a seperate output directory. This allows convinient use
+# of make in output directory
+prepare2:
+	$(Q)if [ ! $(srctree) -ef $(objtree) ]; then       \
+	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile      \
+	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL) \
+	    > $(objtree)/Makefile;                         \
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
@@ -725,6 +735,12 @@
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
 
@@ -736,9 +752,13 @@
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
+++ b/scripts/mkmakefile	2004-06-22 23:02:40 +02:00
@@ -0,0 +1,31 @@
+#!/bin/sh
+# Generates a small Makefile used in the root of the output
+# directory, to allow make to be started from there.
+# The Makefile also allow for more convinient build of external modules
+
+# Usage
+# $1 - Kernel src directory
+# $2 - Output directory
+# $3 - version
+# $4 - patchlevel
+
+
+cat << EOF
+# Automatically generated by $0: don't edit
+
+VERSION = $3
+PATCHLEVEL = $4
+
+KERNELSRC    := $1
+KERNELOUTPUT := $2
+
+MAKEFLAGS += --no-print-directory
+
+all:
+	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
+
+%::
+	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT) \$@
+
+EOF
+
