Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVGPFvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVGPFvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 01:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbVGPFvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 01:51:54 -0400
Received: from mail.autoweb.net ([198.172.237.26]:50409 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262242AbVGPFvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 01:51:53 -0400
Date: Sat, 16 Jul 2005 01:51:51 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Support UML and make O= when building Debian packages
Message-ID: <20050716055151.GH20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support UML builds and make O= when building Debian packages.

Sam, I'm pretty sure I've sent this before, but it seems to have been
dropped. I've been using this for a while to build my personal kernels,
and haven't had any problems.  This is a combination of old patches.

Signed-Off-By: Ryan Anderson <ryan@michonline.com>


Index: linux-git/scripts/package/builddeb
===================================================================
--- linux-git.orig/scripts/package/builddeb	2005-07-16 01:35:52.000000000 -0400
+++ linux-git/scripts/package/builddeb	2005-07-16 01:38:22.000000000 -0400
@@ -14,18 +14,37 @@ set -e
 # Some variables and settings used throughout the script
 version=$KERNELRELEASE
 tmpdir="$objtree/debian/tmp"
+packagename=linux-$version
+
+if [ "$ARCH" == "um" ] ; then
+	packagename=user-mode-linux-$version
+fi
 
 # Setup the directory structure
 rm -rf "$tmpdir"
 mkdir -p "$tmpdir/DEBIAN" "$tmpdir/lib" "$tmpdir/boot"
+if [ "$ARCH" == "um" ] ; then
+	mkdir -p "$tmpdir/usr/lib/uml/modules/$version" "$tmpdir/usr/share/doc/$packagename" "$tmpdir/usr/bin"
+fi
 
 # Build and install the kernel
-cp System.map "$tmpdir/boot/System.map-$version"
-cp .config "$tmpdir/boot/config-$version"
-cp $KBUILD_IMAGE "$tmpdir/boot/vmlinuz-$version"
+if [ "$ARCH" == "um" ] ; then
+	cp System.map "$tmpdir/usr/lib/uml/modules/$version/System.map"
+	cp .config "$tmpdir/usr/share/doc/$packagename/config"
+	gzip "$tmpdir/usr/share/doc/$packagename/config"
+	cp $KBUILD_IMAGE "$tmpdir/usr/bin/linux-$version"
+else
+	cp System.map "$tmpdir/boot/System.map-$version"
+	cp .config "$tmpdir/boot/config-$version"
+	cp $KBUILD_IMAGE "$tmpdir/boot/vmlinuz-$version"
+fi
 
 if grep -q '^CONFIG_MODULES=y' .config ; then
-	INSTALL_MOD_PATH="$tmpdir" make modules_install
+	INSTALL_MOD_PATH="$tmpdir" make KBUILD_SRC= modules_install
+	if [ "$ARCH" == "um" ] ; then
+		mv "$tmpdir/lib/modules/$version"/* "$tmpdir/usr/lib/uml/modules/$version/"
+		rmdir "$tmpdir/lib/modules/$version"
+	fi
 fi
 
 # Install the maintainer scripts
@@ -53,6 +72,8 @@ linux ($version) unstable; urgency=low
 EOF
 
 # Generate a control file
+if [ "$ARCH" == "um" ]; then
+
 cat <<EOF > debian/control
 Source: linux
 Section: base
@@ -60,12 +81,34 @@ Priority: optional
 Maintainer: $name
 Standards-Version: 3.6.1
 
-Package: linux-$version
+Package: $packagename
+Architecture: any
+Description: User Mode Linux kernel, version $version
+ User-mode Linux is a port of the Linux kernel to its own system call
+ interface.  It provides a kind of virtual machine, which runs Linux
+ as a user process under another Linux kernel.  This is useful for
+ kernel development, sandboxes, jails, experimentation, and
+ many other things.
+ .
+ This package contains the Linux kernel, modules and corresponding other
+ files version $version
+EOF
+
+else
+cat <<EOF > debian/control
+Source: linux
+Section: base
+Priority: optional
+Maintainer: $name
+Standards-Version: 3.6.1
+
+Package: $packagename
 Architecture: any
 Description: Linux kernel, version $version
  This package contains the Linux kernel, modules and corresponding other
- files version $version.
+ files version $version
 EOF
+fi
 
 # Fix some ownership and permissions
 chown -R root:root "$tmpdir"
Index: linux-git/scripts/package/Makefile
===================================================================
--- linux-git.orig/scripts/package/Makefile	2005-07-16 01:35:52.000000000 -0400
+++ linux-git/scripts/package/Makefile	2005-07-16 01:38:22.000000000 -0400
@@ -59,7 +59,7 @@ $(objtree)/binkernel.spec: $(MKSPEC) $(s
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $@
 	
 binrpm-pkg: $(objtree)/binkernel.spec
-	$(MAKE)
+	$(MAKE) KBUILD_SRC=
 	set -e; \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version
 	set -e; \
@@ -74,7 +74,7 @@ clean-files += $(objtree)/binkernel.spec
 #
 .PHONY: deb-pkg
 deb-pkg:
-	$(MAKE)
+	$(MAKE) KBUILD_SRC=
 	$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
 
 clean-dirs += $(objtree)/debian/


-- 

Ryan Anderson
  sometimes Pug Majere
