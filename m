Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTJKIW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 04:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTJKIW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 04:22:59 -0400
Received: from home.wiggy.net ([213.84.101.140]:63959 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S263052AbTJKIWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 04:22:55 -0400
Date: Sat, 11 Oct 2003 10:22:53 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] deb target
Message-ID: <20031011082253.GA565@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this to the listed contact for kbuild first, but Michael
Elizabeth Chastain tells me he is no longer active in kernel development
and the kbuild-devel list seems both inactive and defunct (my post
never made it to any of the list archives), so I'm reposting this
here.

For a while now I've been missing a deb target in kbuild, especially
since there is a simple rpm target. While Debian does have a tool
to create kernel packages (make-kpkg from the kernel-package package)
I felt there was a need for a simpler method build into kbuild.

The patch is imperfect and could use some changes from someone who is
more familiar with kbuild, but It Works For Me(tm). I would appreciate
any feedback people have on it.

Wichert.


diff -wurN linux-2.6.0-test7/Makefile linux-2.5/Makefile
--- linux-2.6.0-test7/Makefile	2003-10-08 21:24:17.000000000 +0200
+++ linux-2.5/Makefile	2003-10-09 18:08:17.000000000 +0200
@@ -780,7 +780,7 @@
 
 quiet_cmd_rmclean = RM  $$(CLEAN_FILES)
 cmd_rmclean	  = rm -f $(CLEAN_FILES)
-clean: archclean $(clean-dirs)
+clean: archclean debclean $(clean-dirs)
 	$(call cmd,rmclean)
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
@@ -843,6 +843,19 @@
 tags: FORCE
 	$(call cmd,tags)
 
+# DEB target
+# ---------------------------------------------------------------------------
+
+.PHONY: deb debclean
+
+debclean:
+	rm -rf debian/tmp
+	rm -f debian/changelog debian/control debian/files
+	rmdir debian
+
+deb:
+	$(srctree)/scripts/builddeb
+
 # RPM target
 # ---------------------------------------------------------------------------
 
diff -wurN linux-2.6.0-test7/scripts/builddeb linux-2.5/scripts/builddeb
--- linux-2.6.0-test7/scripts/builddeb	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5/scripts/builddeb	2003-10-09 18:13:44.000000000 +0200
@@ -0,0 +1,74 @@
+#!/bin/sh
+#
+# builddep 0.1
+# Copyright 2003 Wichert Akkerman <wichert@deephackmode.org>
+#
+# Simple script to generate a deb package for a Linux kernel. All the
+# complexity of what to do with a kernel after it is installer or removed
+# is left to other scripts and packages: they can install scripts in the
+# /etc/linux/postinst/ and /etc/linux/prerm/ directories that will be called
+# on package install and removal.
+
+set -e
+
+# Some variables and settings used throughout the script
+version="$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+tmpdir="$(pwd)/debian/tmp"
+
+# Setup the directory structure
+rm -rf "$tmpdir"
+mkdir -p "$tmpdir/DEBIAN" "$tmpdir/lib" "$tmpdir/boo"t
+
+# Build and install the kernel
+INSTALL_PATH="$tmpdir/boot" make install
+INSTALL_MOD_PATH="$tmpdir" make modules_install
+
+# Remove the generated symbolic links, those should not be in the package but
+# generated after installation
+rm $(find "$tmpdir/boot" -type l -print)
+
+# Install the maintainer scripts
+for script in postinst postrm preinst prerm ; do
+	mkdir -p "$tmpdir/etc/linux/$script.d"
+	cat <<EOF > "$tmpdir/DEBIAN/$script"
+#!/bin/sh
+
+set -e
+
+test -d /etc/linux/$script.d && run-parts --arg="$version" /etc/linux/$script.d
+exit 0
+EOF
+	chmod 755 "$tmpdir/DEBIAN/$script"
+done
+
+# Generate a simple changelog template
+cat <<EOF > debian/changelog
+linux ($version) unstable; urgency=low
+
+  * A standard release
+
+ -- Linus Torvalds <torvalds@osdl.org>  $(date -R)
+EOF
+
+# Generate a control file
+cat <<EOF > debian/control
+Source: linux
+Section: base
+Priority: optional
+Maintainer: Linus Torvalds <torvalds@osdl.org>
+Standards-Version: 3.6.1
+
+Package: linux
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

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.


----- End forwarded message -----

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

