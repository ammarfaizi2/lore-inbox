Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264689AbUFGOQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbUFGOQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUFGOQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:16:31 -0400
Received: from levante.wiggy.net ([195.85.225.139]:2492 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S264655AbUFGONy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:13:54 -0400
Date: Mon, 7 Jun 2004 16:13:53 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: kbuild make deb patch
Message-ID: <20040607141353.GK21794@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I originally posted this before 2.6.0 was out and was told to wait until 
things have stabilized a bit. At least from my point of view that has
happened by now so I'm bringing this one up again.

kbuild has had a rpm make target for some time now. Since the concept of
kernel packages is quite convenient I added a deb target as well, using
the patch below.

Since I'm (still) not familiar with kbuild Makefile bits are quite
rough, but they Work For Me(Tm).

Wichert.

--- linux-2.6.6/scripts/builddeb	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6/scripts/builddeb	2004-05-21 12:23:31.000000000 +0200
@@ -0,0 +1,82 @@
+#!/bin/sh
+#
+# builddeb 1.2
+# Copyright 2003,2004 Wichert Akkerman <wichert@wiggy.net>
+#
+# Simple script to generate a deb package for a Linux kernel. All the
+# complexity of what to do with a kernel after it is installer or removed
+# is left to other scripts and packages: they can install scripts in the
+# /etc/kernel/{pre,post}{inst,rm}.d/ directories that will be called on 
+# package install and removal.
+
+set -e
+
+# Some variables and settings used throughout the script
+version="$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+tmpdir="$(pwd)/debian/tmp"
+
+# Setup the directory structure
+rm -rf "$tmpdir"
+mkdir -p "$tmpdir/DEBIAN" "$tmpdir/lib" "$tmpdir/boot"
+
+# Build and install the kernel
+cp System.map "$tmpdir/boot/System.map-$version"
+cp .config "$tmpdir/boot/config-$version"
+if $(arch | grep -q i.86) ; then
+	cp arch/i386/boot/bzImage "$tmpdir/boot/vmlinuz-$version"
+else
+	cp vmlinux "$tmpdir/boot/vmlinuz-$version"
+fi
+if grep -q '^CONFIG_MODULES=y' .config ; then
+	INSTALL_MOD_PATH="$tmpdir" make modules_install
+fi
+
+# Install the maintainer scripts
+for script in postinst postrm preinst prerm ; do
+	mkdir -p "$tmpdir/etc/kernel/$script.d"
+	cat <<EOF > "$tmpdir/DEBIAN/$script"
+#!/bin/sh
+
+set -e
+
+test -d /etc/kernel/$script.d && run-parts --arg="$version" /etc/kernel/$script.d
+exit 0
+EOF
+	chmod 755 "$tmpdir/DEBIAN/$script"
+done
+
+name="Kernel Compiler <$(id -nu)@$(hostname -f)>"
+# Generate a simple changelog template
+cat <<EOF > debian/changelog
+linux ($version) unstable; urgency=low
+
+  * A standard release
+
+ -- $name  $(date -R)
+EOF
+
+# Generate a control file
+cat <<EOF > debian/control
+Source: linux
+Section: base
+Priority: optional
+Maintainer: $name
+Standards-Version: 3.6.1
+
+Package: linux-$version
+Architecture: any
+Description: Linux kernel, version $version
+ This package contains the Linux kernel, modules and corresponding other
+ files version $version.
+EOF
+
+# Fix some ownership and permissions
+chown -R root:root "$tmpdir"
+chmod -R go-w "$tmpdir"
+
+# Perform the final magic
+dpkg-gencontrol -isp
+dpkg --build "$tmpdir" ..
+
+exit 0
+
--- linux-2.6.6/Makefile	2004-05-10 04:32:53.000000000 +0200
+++ linux-2.6/Makefile	2004-05-10 10:37:44.000000000 +0200
@@ -788,33 +788,40 @@
 
 ###
 # Cleaning is done on three levels.
-# make clean     Delete most generated files
-#                Leave enough to build external modules
-# make mrproper  Delete the current configuration, and all generated files
+# make clean     Delete all automatically generated files, including
+#                tools and firmware.
+# make mrproper  Delete the current configuration, and related files
+#                Any core files spread around are deleted as well
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_DIRS  += $(MODVERDIR)
-CLEAN_FILES +=	vmlinux System.map kernel.spec \
-                .tmp_kallsyms* .tmp_version .tmp_vmlinux*
-
-# Directories & files removed with 'make mrproper'
-MRPROPER_DIRS  += include/config include2
-MRPROPER_FILES += .config .config.old include/asm .version \
+CLEAN_DIRS  += $(MODVERDIR) include/config include2
+CLEAN_FILES +=	vmlinux System.map \
                   include/linux/autoconf.h include/linux/version.h \
-                  Module.symvers tags TAGS cscope*
+		include/asm include/linux/modversions.h \
+		kernel.spec .tmp*
 
-# clean - Delete most, but leave enough to build external modules
-#
-clean: rm-dirs  := $(CLEAN_DIRS)
-clean: rm-files := $(CLEAN_FILES)
-clean-dirs      := $(addprefix _clean_,$(vmlinux-alldirs))
+# Files removed with 'make mrproper'
+MRPROPER_FILES += .version .config .config.old tags TAGS cscope*
 
-.PHONY: $(clean-dirs) clean archclean
+# clean - Delete all intermediate files
+#
+clean-dirs += $(addprefix _clean_,$(ALL_SUBDIRS) Documentation/DocBook scripts)
+.PHONY: $(clean-dirs) clean archclean mrproper archmrproper distclean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
-clean: archclean $(clean-dirs)
+clean:		rm-dirs  := $(wildcard $(CLEAN_DIRS))
+mrproper:	rm-dirs  := $(wildcard $(MRPROPER_DIRS))
+quiet_cmd_rmdirs = $(if $(rm-dirs),CLEAN   $(rm-dirs))
+      cmd_rmdirs = rm -rf $(rm-dirs)
+
+clean:		rm-files := $(wildcard $(CLEAN_FILES))
+mrproper:	rm-files := $(wildcard $(MRPROPER_FILES))
+quiet_cmd_rmfiles = $(if $(rm-files),CLEAN   $(rm-files))
+      cmd_rmfiles = rm -rf $(rm-files)
+
+clean: archclean debclean $(clean-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
@@ -848,6 +855,66 @@
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
 		-type f -print | xargs rm -f
 
+# Generate tags for editors
+# ---------------------------------------------------------------------------
+
+define all-sources
+	( find . $(RCS_FIND_IGNORE) \
+	       \( -name include -o -name arch \) -prune -o \
+	       -name '*.[chS]' -print; \
+	  find arch/$(ARCH) $(RCS_FIND_IGNORE) \
+	       -name '*.[chS]' -print; \
+	  find include $(RCS_FIND_IGNORE) \
+	       \( -name config -o -name 'asm-*' \) -prune \
+	       -o -name '*.[chS]' -print; \
+	  find include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
+	       -name '*.[chS]' -print; \
+	  find include/asm-generic $(RCS_FIND_IGNORE) \
+	       -name '*.[chS]' -print )
+endef
+
+quiet_cmd_cscope-file = FILELST cscope.files
+      cmd_cscope-file = $(all-sources) > cscope.files
+
+quiet_cmd_cscope = MAKE    cscope.out
+      cmd_cscope = cscope -k -b -q
+
+cscope: FORCE
+	$(call cmd,cscope-file)
+	$(call cmd,cscope)
+
+quiet_cmd_TAGS = MAKE   $@
+cmd_TAGS = $(all-sources) | etags -
+
+# 	Exuberant ctags works better with -I
+
+quiet_cmd_tags = MAKE   $@
+define cmd_tags
+	rm -f $@; \
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
+	$(all-sources) | xargs ctags $$CTAGSF -a
+endef
+
+TAGS: FORCE
+	$(call cmd,TAGS)
+
+tags: FORCE
+	$(call cmd,tags)
+
+# DEB target
+# ---------------------------------------------------------------------------
+
+.PHONY: deb debclean
+
+debclean:
+	rm -rf debian/tmp
+	rm -f debian/changelog debian/control debian/files
+	-rmdir debian
+
+deb: all
+	@echo '  Creating kernel deb package'
+	@$(srctree)/scripts/builddeb
+
 # RPM target
 # ---------------------------------------------------------------------------
 
-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
