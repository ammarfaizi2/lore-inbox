Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUGOXOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUGOXOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 19:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUGOXOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 19:14:24 -0400
Received: from [192.48.179.6] ([192.48.179.6]:36730 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266212AbUGOXOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 19:14:20 -0400
Date: Thu, 15 Jul 2004 18:14:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] build binary rpm from pre-built tree
Message-ID: <20040715231401.GK12258@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: edwardsg@sgi.com (Greg Edwards)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many times it would be nice to quickly package up a kernel tree you're
working on, without having to rebuild the whole thing again from a clean
source tree (like the current rpm-pkg target does).  The patch below
adds an "rpmbin-pkg" target which uses your existing (already built)
tree.

Signed-off-by: Greg Edwards <edwardsg@sgi.com>

Greg


===== scripts/package/Makefile 1.1 vs edited =====
--- 1.1/scripts/package/Makefile	2004-06-20 22:46:25 -05:00
+++ edited/scripts/package/Makefile	2004-07-15 17:55:24 -05:00
@@ -31,7 +31,7 @@
 MKSPEC     := $(srctree)/scripts/package/mkspec
 PREV       := set -e; cd ..;
 
-.PHONY: rpm-pkg rpm
+.PHONY: rpm-pkg rpm rpmbin-pkg
 
 $(objtree)/kernel.spec: $(MKSPEC)
 	$(CONFIG_SHELL) $(MKSPEC) > $@
@@ -49,6 +49,16 @@
 
 	$(RPM) --target $(UTS_MACHINE) -ta ../$(KERNELPATH).tar.gz
 	rm ../$(KERNELPATH).tar.gz
+
+rpmbin-pkg: $(MKSPEC)
+	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/kernel.spec
+
+	set -e; \
+	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version
+	set -e; \
+	mv -f $(objtree)/.tmp_version $(objtree)/.version
+
+	$(RPM) --define "_builddir $(srctree)" --target $(UTS_MACHINE) -bb $(objtree)/kernel.spec
 
 clean-rule +=  rm -f $(objtree)/kernel.spec
 
===== scripts/package/mkspec 1.9 vs edited =====
--- 1.9/scripts/package/mkspec	2004-06-20 20:23:45 -05:00
+++ edited/scripts/package/mkspec	2004-07-15 17:55:02 -05:00
@@ -9,6 +9,13 @@
 #	Patched for non-x86 by Opencon (L) 2002 <opencon@rio.skydome.net>
 #
 
+# how we were called determines which rpms we build and how we build them
+if [ "$1" = "prebuilt" ]; then
+	PREBUILT=true
+else
+	PREBUILT=false
+fi
+
 # starting to output the spec
 if [ "`grep CONFIG_DRM=y .config | cut -f2 -d\=`" = "y" ]; then
 	PROVIDES=kernel-drm
@@ -26,8 +33,12 @@
 echo "Group: System Environment/Kernel"
 echo "Vendor: The Linux Community"
 echo "URL: http://www.kernel.org"
+
+if ! $PREBUILT; then
 echo -n "Source: kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL"
 echo "$EXTRAVERSION.tar.gz" | sed -e "s/-//g"
+fi
+
 echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
 echo "Provides: $PROVIDES"
 echo "%define __spec_install_post /usr/lib/rpm/brp-compress || :"
@@ -36,12 +47,20 @@
 echo "%description"
 echo "The Linux Kernel, the operating system core itself"
 echo ""
+
+if ! $PREBUILT; then
 echo "%prep"
 echo "%setup -q"
 echo ""
+fi
+
 echo "%build"
+
+if ! $PREBUILT; then
 echo "make clean && make"
 echo ""
+fi
+
 echo "%install"
 echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
 
