Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUFNUho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUFNUho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUFNUhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:37:43 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:17535 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263995AbUFNUgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:36:38 -0400
Date: Mon, 14 Jun 2004 22:45:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/5] kbuild: move rpm to scripts/package
Message-ID: <20040614204521.GC15243@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614204029.GA15243@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/14 21:22:52+02:00 sam@mars.ravnborg.org 
#   kbuild: Move rpm target o scripts/package
#   
#   To prepare for support of more packages types move suport for rpm to
#   a new directory: scripts/package.
#   Use the generic target "%-pkg" so the new target for rpm is now: rpm-pkg.
#   Kept the old rpm target for backward compatibility.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/package/Makefile
#   2004/06/14 21:22:37+02:00 sam@mars.ravnborg.org +55 -0
# 
# scripts/package/mkspec
#   2004/06/14 21:22:37+02:00 sam@mars.ravnborg.org +6 -15
#   Use $KERNEL_IMAGE to locate compiled image, hereby no hardcoding to
#   different architectures.
#   Separate make clean && make steps
# 
# scripts/package/Makefile
#   2004/06/14 21:22:37+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/kbuild/scripts/package/Makefile
# 
# scripts/Makefile
#   2004/06/14 21:22:37+02:00 sam@mars.ravnborg.org +1 -1
#   Clean in package/ as well
# 
# Makefile
#   2004/06/14 21:22:37+02:00 sam@mars.ravnborg.org +14 -32
#   Moved rpm target to scripts/package/Makefile
#   Exported KERNEL_IMAGE to give access to it outside this Makefile
#   Add support for the scripts/package/* stuff
# 
# scripts/packages/mkspec
#   2004/06/07 23:03:27+02:00 sam@mars.ravnborg.org +0 -0
#   Rename: scripts/mkspec -> scripts/packages/mkspec
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-06-14 22:25:51 +02:00
+++ b/Makefile	2004-06-14 22:25:51 +02:00
@@ -290,8 +290,6 @@
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
 AWK		= awk
-RPM 		:= $(shell if [ -x "/usr/bin/rpmbuild" ]; then echo rpmbuild; \
-		    	else echo rpm; fi)
 GENKSYMS	= scripts/genksyms/genksyms
 DEPMOD		= /sbin/depmod
 KALLSYMS	= scripts/kallsyms
@@ -444,8 +442,8 @@
 
 # Selected kernel image to build in .config, assuming vmlinux
 # if CONFIG_KERNEL_IMAGE is empty (not defined)
-KERNEL_IMAGE := $(if $(CONFIG_KERNEL_IMAGE), \
-                     $(subst ",,$(CONFIG_KERNEL_IMAGE)), vmlinux)
+export KERNEL_IMAGE := $(if $(CONFIG_KERNEL_IMAGE), \
+                            $(subst ",,$(CONFIG_KERNEL_IMAGE)), vmlinux)
 
 # The all: target has the kernel selected in .config as prerequisite.
 # Hereby user only have to issue 'make' to build the kernel, including
@@ -798,7 +796,7 @@
 
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
-CLEAN_FILES +=	vmlinux System.map kernel.spec \
+CLEAN_FILES +=	vmlinux System.map \
                 .tmp_kallsyms* .tmp_version .tmp_vmlinux*
 
 # Directories & files removed with 'make mrproper'
@@ -851,37 +849,19 @@
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
 		-type f -print | xargs rm -f
 
-# RPM target
-# ---------------------------------------------------------------------------
-
-.PHONY: rpm
 
-# Remove hyphens since they have special meaning in RPM filenames
-KERNELPATH=kernel-$(subst -,,$(KERNELRELEASE))
+# Packaging of the kernel to various formats
+# ---------------------------------------------------------------------------
+# rpm target kept for backward compatibility
+package-dir	:= $(srctree)/scripts/package
 
-#	If you do a make spec before packing the tarball you can rpm -ta it
+.PHONY: %-pkg rpm
 
-spec:
-	$(CONFIG_SHELL) $(srctree)/scripts/mkspec > $(objtree)/kernel.spec
-
-#	a) Build a tar ball
-#	b) generate an rpm from it
-#	c) and pack the result
-#	- Use /. to avoid tar packing just the symlink
-
-rpm:	clean spec
-	set -e; \
-	cd .. ; \
-	ln -sf $(srctree) $(KERNELPATH) ; \
-	tar -cvz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
-	rm $(KERNELPATH)
-
-	set -e; \
-	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version;\
-	mv -f $(objtree)/.tmp_version $(objtree)/.version;
+%pkg: FORCE
+	$(Q)$(MAKE) -f $(package-dir)/Makefile $@
+rpm: FORCE
+	$(Q)$(MAKE) -f $(package-dir)/Makefile $@
 
-	$(RPM) --target $(UTS_MACHINE) -ta ../$(KERNELPATH).tar.gz
-	rm ../$(KERNELPATH).tar.gz
 
 # Brief documentation of the typical targets used
 # ---------------------------------------------------------------------------
@@ -908,6 +888,8 @@
 	@echo  '  tags/TAGS	  - Generate tags file for editors'
 	@echo  '  cscope	  - Generate cscope index'
 	@echo  '  checkstack      - Generate a list of stack hogs'
+	@echo  'Kernel packaging:'
+	@$(MAKE) -f $(package-dir)/Makefile help
 	@echo  ''
 	@echo  'Documentation targets:'
 	@$(MAKE) -f $(srctree)/Documentation/DocBook/Makefile dochelp
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	2004-06-14 22:25:51 +02:00
+++ b/scripts/Makefile	2004-06-14 22:25:51 +02:00
@@ -13,7 +13,7 @@
 subdir-$(CONFIG_MODVERSIONS)	+= genksyms
 
 # Let clean descend into subdirs
-subdir-	+= basic lxdialog kconfig
+subdir-	+= basic lxdialog kconfig package
 
 # dependencies on generated files need to be listed explicitly
 
diff -Nru a/scripts/mkspec b/scripts/mkspec
--- a/scripts/mkspec	2004-06-14 22:25:51 +02:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,72 +0,0 @@
-#!/bin/sh
-#
-#	Output a simple RPM spec file that uses no fancy features requring
-#	RPM v4. This is intended to work with any RPM distro.
-#
-#	The only gothic bit here is redefining install_post to avoid 
-#	stripping the symbols from files in the kernel which we want
-#
-#	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
-#
-# That's the voodoo to see if it's a x86.
-ISX86=`echo ${ARCH:=\`arch\`} | grep -ie i.86`
-if [ ! -z $ISX86 ]; then
-	PC=1
-else
-	PC=0
-fi
-# starting to output the spec
-if [ "`grep CONFIG_DRM=y .config | cut -f2 -d\=`" = "y" ]; then
-	PROVIDES=kernel-drm
-fi
-
-PROVIDES="$PROVIDES kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
-
-echo "Name: kernel"
-echo "Summary: The Linux Kernel"
-echo "Version: "$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION | sed -e "s/-//g"
-# we need to determine the NEXT version number so that uname and
-# rpm -q will agree
-echo "Release: `. $srctree/scripts/mkversion`"
-echo "License: GPL"
-echo "Group: System Environment/Kernel"
-echo "Vendor: The Linux Community"
-echo "URL: http://www.kernel.org"
-echo -n "Source: kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL"
-echo "$EXTRAVERSION.tar.gz" | sed -e "s/-//g"
-echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
-echo "Provides: $PROVIDES"
-echo "%define __spec_install_post /usr/lib/rpm/brp-compress || :"
-echo "%define debug_package %{nil}"
-echo ""
-echo "%description"
-echo "The Linux Kernel, the operating system core itself"
-echo ""
-echo "%prep"
-echo "%setup -q"
-echo ""
-echo "%build"
-echo "make clean all"
-echo ""
-echo "%install"
-echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
-echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
-# This is the first disagreement between i386 and most others
-if [ $PC = 1 ]; then
-	echo 'cp arch/i386/boot/bzImage $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
-else
-	echo 'cp vmlinux $RPM_BUILD_ROOT'"/boot/vmlinux-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
-fi
-# Back on track
-echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
-echo 'cp .config $RPM_BUILD_ROOT'"/boot/config-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
-echo ""
-echo "%clean"
-echo '#echo -rf $RPM_BUILD_ROOT'
-echo ""
-echo "%files"
-echo '%defattr (-, root, root)'
-echo "%dir /lib/modules"
-echo "/lib/modules/$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
-echo "/boot/*"
-echo ""
diff -Nru a/scripts/package/Makefile b/scripts/package/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/package/Makefile	2004-06-14 22:25:51 +02:00
@@ -0,0 +1,55 @@
+# Makefile for the different targets used to generate full packages of a kernel
+# It uses the generic clean infrastructure of kbuild
+
+# Ignore the following files/directories during tar operation
+TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS
+
+
+# RPM target
+# ---------------------------------------------------------------------------
+# The rpm target generates two rpm files:
+# /usr/src/packages/SRPMS/kernel-2.6.7rc2-1.src.rpm
+# /usr/src/packages/RPMS/i386/kernel-2.6.7rc2-1.<arch>.rpm
+# The src.rpm files includes all source for the kernel being built
+# The <arch>.rpm includes kernel configuration, modules etc.
+#
+# Process to create the rpm files
+# a) clean the kernel
+# b) Generate .spec file
+# c) Build a tar ball, using some symlink magic to make sure the kernel version
+#    is first entry in the path
+# d) and pack the result
+# e) generate the rpm files
+# - Use /. to avoid tar packing just the symlink
+
+# Do we have rpmbuild, otherwise fall back to the older rpm
+RPM := $(shell if [ -x "/usr/bin/rpmbuild" ]; then echo rpmbuild; \
+	           else echo rpm; fi)
+
+# Remove hyphens since they have special meaning in RPM filenames
+KERNELPATH := kernel-$(subst -,,$(KERNELRELEASE))
+
+.PHONY: rpm-pkg rpm
+rpm-pkg rpm:
+	$(MAKE) clean
+	$(CONFIG_SHELL) $(srctree)/scripts/package/mkspec > $(objtree)/kernel.spec
+	set -e; \
+	cd .. ; \
+	ln -sf $(srctree) $(KERNELPATH) ; \
+	tar -cz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
+	rm $(KERNELPATH)
+
+	set -e; \
+	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version;\
+	mv -f $(objtree)/.tmp_version $(objtree)/.version;
+
+	$(RPM) --target $(UTS_MACHINE) -ta ../$(KERNELPATH).tar.gz
+	rm ../$(KERNELPATH).tar.gz
+
+clean-rule +=  rm $(objtree)/kernel.spec
+
+# Help text displayed when executing 'make help'
+# ---------------------------------------------------------------------------
+help:
+	@echo  '  rpm-pkg         - Build the kernel as an RPM package'
+
diff -Nru a/scripts/package/mkspec b/scripts/package/mkspec
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/package/mkspec	2004-06-14 22:25:51 +02:00
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+#	Output a simple RPM spec file that uses no fancy features requring
+#	RPM v4. This is intended to work with any RPM distro.
+#
+#	The only gothic bit here is redefining install_post to avoid 
+#	stripping the symbols from files in the kernel which we want
+#
+#	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
+#
+
+# starting to output the spec
+if [ "`grep CONFIG_DRM=y .config | cut -f2 -d\=`" = "y" ]; then
+	PROVIDES=kernel-drm
+fi
+
+PROVIDES="$PROVIDES kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+
+echo "Name: kernel"
+echo "Summary: The Linux Kernel"
+echo "Version: "$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION | sed -e "s/-//g"
+# we need to determine the NEXT version number so that uname and
+# rpm -q will agree
+echo "Release: `. $srctree/scripts/mkversion`"
+echo "License: GPL"
+echo "Group: System Environment/Kernel"
+echo "Vendor: The Linux Community"
+echo "URL: http://www.kernel.org"
+echo -n "Source: kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL"
+echo "$EXTRAVERSION.tar.gz" | sed -e "s/-//g"
+echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
+echo "Provides: $PROVIDES"
+echo "%define __spec_install_post /usr/lib/rpm/brp-compress || :"
+echo "%define debug_package %{nil}"
+echo ""
+echo "%description"
+echo "The Linux Kernel, the operating system core itself"
+echo ""
+echo "%prep"
+echo "%setup -q"
+echo ""
+echo "%build"
+echo "make clean && make"
+echo ""
+echo "%install"
+echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+
+echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
+echo 'cp $KERNEL_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+
+echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+
+echo 'cp .config $RPM_BUILD_ROOT'"/boot/config-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo ""
+echo "%clean"
+echo '#echo -rf $RPM_BUILD_ROOT'
+echo ""
+echo "%files"
+echo '%defattr (-, root, root)'
+echo "%dir /lib/modules"
+echo "/lib/modules/$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo "/boot/*"
+echo ""
