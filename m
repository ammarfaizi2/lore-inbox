Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312449AbSD2Oyy>; Mon, 29 Apr 2002 10:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312455AbSD2Oyy>; Mon, 29 Apr 2002 10:54:54 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:53646 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312449AbSD2Oyw>; Mon, 29 Apr 2002 10:54:52 -0400
Date: Mon, 29 Apr 2002 16:54:51 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] make rpmbin...
Message-ID: <20020429145450.GN2740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch implements a 'make rpmbin' rule which, as its
name implies, generates a binary-only RPM using the current
(already compiled) tree.

I find this rule to be much more useful when hacking a part of the
code, then doing 'make bzImage rpmbin' or 'make modules rpmbin', 
instead of compiling the whole tree again in a different place
like 'make rpm' does.

Do the audience find this useful ? Comments ?

Thanks,

Stelian.

--- 1.166/Makefile	Mon Apr 22 15:21:39 2002
+++ edited/Makefile	Mon Apr 29 16:02:47 2002
@@ -565,3 +565,17 @@
 	. scripts/mkversion > .version ; \
 	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
 	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
+
+specbin:
+	. scripts/mkspecbin >kernel.spec
+
+rpmbin: specbin
+	mkdir -p $(TOPDIR)/$(KERNELPATH)/boot $(TOPDIR)/$(KERNELPATH)/lib $(TOPDIR)/$(KERNELPATH)/lib/modules
+	INSTALL_MOD_PATH=$(TOPDIR)/$(KERNELPATH) make modules_install
+	cp arch/i386/boot/bzImage $(TOPDIR)/$(KERNELPATH)/boot/vmlinuz-$(KERNELRELEASE)
+	cp System.map $(TOPDIR)/$(KERNELPATH)/boot/System.map-$(KERNELRELEASE)
+	cp .config $(TOPDIR)/$(KERNELPATH)/boot/config-$(KERNELRELEASE)
+	mv kernel.spec $(TOPDIR)/$(KERNELPATH)
+	tar cvfz $(KERNELPATH).tar.gz $(KERNELPATH) 
+	rpm -tb $(TOPDIR)/$(KERNELPATH).tar.gz
+	rm -rf $(TOPDIR)/$(KERNELPATH) $(KERNELPATH).tar.gz
--- /dev/null	Mon Apr 29 16:46:42 2002
+++ linux-2.4/scripts/mkspecbin	Mon Apr 29 15:22:41 2002
@@ -0,0 +1,54 @@
+#!/bin/sh
+#
+#	Output a simple RPM spec file that uses no fancy features requring
+#	RPM v4. This is intended to work with any RPM distro.
+#
+#	The only gothic bit here is redefining install_post to avoid 
+#	stripping the symbols from files in the kernel which we want
+#
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
+echo "Release: `. scripts/mkversion`"
+echo "License: GPL"
+echo "Group: System Environment/Kernel"
+echo "Vendor: The Linux Community"
+echo "URL: http://www.kernel.org"
+echo -n "Source: kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL"
+echo "$EXTRAVERSION.tar.gz" | sed -e "s/-//g"
+echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
+echo "Provides: $PROVIDES"
+echo "%define __spec_install_post /usr/lib/rpm/brp-compress || :"
+echo ""
+echo "%description"
+echo "The Linux Kernel, the operating system core itself"
+echo ""
+echo "This package is a binary image of the Linux Kernel without the sources,"
+echo "which are available from http://www.kernel.org"
+echo ""
+echo "%prep"
+echo "%setup -q"
+echo ""
+echo "%build"
+echo ""
+echo "%install"
+echo 'mkdir -p $RPM_BUILD_ROOT'
+echo 'cp -rp boot lib $RPM_BUILD_ROOT'
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
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
