Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUFGPWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUFGPWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbUFGPWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:22:31 -0400
Received: from levante.wiggy.net ([195.85.225.139]:35518 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S263100AbUFGPUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:20:14 -0400
Date: Mon, 7 Jun 2004 17:20:13 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild make deb patch
Message-ID: <20040607152013.GR21794@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040607141353.GK21794@wiggy.net> <40C4860C.3070904@stanchina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C4860C.3070904@stanchina.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Flavio Stanchina wrote:
> I like the idea a lot, but your patch to the makefile touches quite a 
> few things in the clean target that AFAICT are not related to the deb 
> target in any way. Perhaps you are diffing from an older tree?

Ah, hmm, good catch. Looks like I dropped a bit of a patch at some point
due to a reject and forgot to clean that up. So lets try that again:

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
@@ -814,7 +814,7 @@
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
-clean: archclean $(clean-dirs)
+clean: archclean debclean $(clean-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
@@ -848,6 +848,20 @@
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
 		-type f -print | xargs rm -f
 
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
