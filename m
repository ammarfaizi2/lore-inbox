Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUFNUh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUFNUh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUFNUh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:37:56 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:1119 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264012AbUFNUhP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:37:15 -0400
Date: Mon, 14 Jun 2004 22:46:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/5] kbuild: add deb-pkg target
Message-ID: <20040614204602.GD15243@mars.ravnborg.org>
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
#   2004/06/14 21:44:27+02:00 sam@mars.ravnborg.org 
#   kbuild: Added deb target
#   
#   Script originally from Wichert Akkerman <wichert@wiggy.net>
#   Modified to support multiple architectures.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/package/builddeb
#   2004/06/14 21:44:12+02:00 sam@mars.ravnborg.org +79 -0
# 
# scripts/package/builddeb
#   2004/06/14 21:44:12+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/kbuild/scripts/package/builddeb
# 
# scripts/package/Makefile
#   2004/06/14 21:44:12+02:00 sam@mars.ravnborg.org +13 -1
#   Added deb-pkg target
# 
diff -Nru a/scripts/package/Makefile b/scripts/package/Makefile
--- a/scripts/package/Makefile	2004-06-14 22:25:41 +02:00
+++ b/scripts/package/Makefile	2004-06-14 22:25:41 +02:00
@@ -46,10 +46,22 @@
 	$(RPM) --target $(UTS_MACHINE) -ta ../$(KERNELPATH).tar.gz
 	rm ../$(KERNELPATH).tar.gz
 
-clean-rule +=  rm $(objtree)/kernel.spec
+clean-rule +=  rm -f $(objtree)/kernel.spec
+
+# Deb target
+# ---------------------------------------------------------------------------
+# 
+.PHONY: rpm-pkg rpm
+deb-pkg:
+	@$(MAKE)
+	@$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
+
+clean-rule += && rm -rf debian/
+
 
 # Help text displayed when executing 'make help'
 # ---------------------------------------------------------------------------
 help:
 	@echo  '  rpm-pkg         - Build the kernel as an RPM package'
+	@echo  '  deb-pkg         - Build the kernel as an deb package'
 
diff -Nru a/scripts/package/builddeb b/scripts/package/builddeb
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/package/builddeb	2004-06-14 22:25:41 +02:00
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# builddeb 1.2
+# Copyright 2003 Wichert Akkerman <wichert@wiggy.net>
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
+cp $KERNEL_IMAGE "$tmpdir/boot/vmlinuz-$version"
+
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
