Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTJRLuw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 07:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTJRLuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 07:50:52 -0400
Received: from home.wiggy.net ([213.84.101.140]:8418 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261580AbTJRLuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 07:50:44 -0400
Date: Sat, 18 Oct 2003 13:50:43 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC][PATCH] deb target
Message-ID: <20031018115042.GB1237@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
References: <20031011082253.GA565@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011082253.GA565@wiggy.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a new versino of my make deb patch. There are a few changes
since the previous version:

* no longer use make install, since that will call installkernel which
  should not happen on package creation. Instead manually install the
  kernel image, config and system.map using a trick taken from
  scripts/mkspec to guess the filename of the kernel image.

* no longer use Linus' name and email address but generate a name and
  email address based on the currently logged in user. This to prevent
  possible unwanted email to Linus.

* use /etc/kernel/ for install/removal handling scripts. This will also
  be supported by the next version of Debian's kernel-package.

* obligatory typo fixes.

As always, any comments, bugreports and other forms of feedback are
welcome.

Wichert.


diff -wurN linux-2.6.0-test8/Makefile linux-2.5/Makefile
--- linux-2.6.0-test8/Makefile	2003-10-17 23:43:20.000000000 +0200
+++ linux-2.5/Makefile	2003-10-18 13:30:37.000000000 +0200
@@ -780,7 +780,7 @@
 
 quiet_cmd_rmclean = RM  $$(CLEAN_FILES)
 cmd_rmclean	  = rm -f $(CLEAN_FILES)
-clean: archclean $(clean-dirs)
+clean: archclean debclean $(clean-dirs)
 	$(call cmd,rmclean)
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
@@ -843,6 +843,20 @@
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
+	-rmdir debian
+
+deb: boot
+	@echo '  Creating kernel deb package'
+	@$(srctree)/scripts/builddeb
+
 # RPM target
 # ---------------------------------------------------------------------------
 
diff -wurN linux-2.6.0-test8/scripts/builddeb linux-2.5/scripts/builddeb
--- linux-2.6.0-test8/scripts/builddeb	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5/scripts/builddeb	2003-10-18 13:15:39.000000000 +0200
@@ -0,0 +1,77 @@
+#!/bin/sh
+#
+# builddeb 1.0
+# Copyright 2003 Wichert Akkerman <wichert@wiggy.net>
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
+mkdir -p "$tmpdir/DEBIAN" "$tmpdir/lib" "$tmpdir/boot"
+
+# Build and install the kernel
+cp System.map "$tmpdir/boot/System.map-$version"
+cp .config "$tmpdir/boot/config-$version"
+if [ $(arch | grep -q i.86) 2>/dev/null ] ; then
+	cp arch/i386/boot/bzImage "$tmpdir/boot/vmlinuz-$version"
+else
+	cp vmlinux "$tmpdir/boot/vmlinuz-$version"
+fi
+INSTALL_MOD_PATH="$tmpdir" make modules_install
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

