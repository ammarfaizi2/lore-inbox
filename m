Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269891AbUIDLX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269891AbUIDLX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUIDLWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:22:07 -0400
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:16527 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S269887AbUIDLRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:17:45 -0400
Message-ID: <4139A443.4080704@quark.didntduck.org>
Date: Sat, 04 Sep 2004 07:17:23 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] use KERNELRELEASE
Content-Type: multipart/mixed;
 boundary="------------000703040400020203080308"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000703040400020203080308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes several places where the kernel version string is put 
together from it's components with $KERNELRELEASE.

--
				Brian Gerst

--------------000703040400020203080308
Content-Type: text/plain;
 name="use-KERNELRELEASE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use-KERNELRELEASE"

diff -urN linux-2.6.9-rc1-bk/arch/arm26/boot/Makefile linux/arch/arm26/boot/Makefile
--- linux-2.6.9-rc1-bk/arch/arm26/boot/Makefile	2003-12-17 22:00:00.000000000 -0500
+++ linux/arch/arm26/boot/Makefile	2004-09-03 18:34:51.348510718 -0400
@@ -67,12 +67,12 @@
 
 install: $(obj)/Image
 	$(CONFIG_SHELL) $(obj)/install.sh \
-	$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) \
+	$(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
 
 zinstall: $(obj)/zImage
 	$(CONFIG_SHELL) $(obj)/install.sh \
-	$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) \
+	$(KERNELRELEASE) \
 	$(obj)/zImage System.map "$(INSTALL_PATH)"
 
 subdir-	    := compressed
diff -urN linux-2.6.9-rc1-bk/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
--- linux-2.6.9-rc1-bk/scripts/kconfig/gconf.c	2004-06-23 18:06:06.000000000 -0400
+++ linux/scripts/kconfig/gconf.c	2004-09-03 18:36:17.629676122 -0400
@@ -275,9 +275,8 @@
 					  /*"style", PANGO_STYLE_OBLIQUE, */
 					  NULL);
 
-	sprintf(title, "Linux Kernel v%s.%s.%s%s Configuration",
-		getenv("VERSION"), getenv("PATCHLEVEL"),
-		getenv("SUBLEVEL"), getenv("EXTRAVERSION"));
+	sprintf(title, "Linux Kernel v%s Configuration",
+		getenv("KERNELRELEASE"));
 	gtk_window_set_title(GTK_WINDOW(main_wnd), title);
 
 	gtk_widget_show(main_wnd);
diff -urN linux-2.6.9-rc1-bk/scripts/package/builddeb linux/scripts/package/builddeb
--- linux-2.6.9-rc1-bk/scripts/package/builddeb	2004-08-24 08:43:18.000000000 -0400
+++ linux/scripts/package/builddeb	2004-09-03 18:30:52.238706773 -0400
@@ -12,7 +12,7 @@
 set -e
 
 # Some variables and settings used throughout the script
-version="$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+version=$KERNELRELEASE
 tmpdir="$objtree/debian/tmp"
 
 # Setup the directory structure
diff -urN linux-2.6.9-rc1-bk/scripts/package/mkspec linux/scripts/package/mkspec
--- linux-2.6.9-rc1-bk/scripts/package/mkspec	2004-08-24 08:43:18.000000000 -0400
+++ linux/scripts/package/mkspec	2004-09-03 18:25:40.386781942 -0400
@@ -21,11 +21,12 @@
 	PROVIDES=kernel-drm
 fi
 
-PROVIDES="$PROVIDES kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+PROVIDES="$PROVIDES kernel-$KERNELRELEASE"
+__KERNELRELEASE=`echo $KERNELRELEASE | sed -e "s/-//g"`
 
 echo "Name: kernel"
 echo "Summary: The Linux Kernel"
-echo "Version: "$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION | sed -e "s/-//g"
+echo "Version: $__KERNELRELEASE"
 # we need to determine the NEXT version number so that uname and
 # rpm -q will agree
 echo "Release: `. $srctree/scripts/mkversion`"
@@ -35,8 +36,7 @@
 echo "URL: http://www.kernel.org"
 
 if ! $PREBUILT; then
-echo -n "Source: kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL"
-echo "$EXTRAVERSION.tar.gz" | sed -e "s/-//g"
+echo "Source: kernel-$__KERNELRELEASE.tar.gz"
 fi
 
 echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
@@ -65,11 +65,11 @@
 echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
 
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
-echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$KERNELRELEASE"
 
-echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$KERNELRELEASE"
 
-echo 'cp .config $RPM_BUILD_ROOT'"/boot/config-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo 'cp .config $RPM_BUILD_ROOT'"/boot/config-$KERNELRELEASE"
 echo ""
 echo "%clean"
 echo '#echo -rf $RPM_BUILD_ROOT'
@@ -77,6 +77,6 @@
 echo "%files"
 echo '%defattr (-, root, root)'
 echo "%dir /lib/modules"
-echo "/lib/modules/$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo "/lib/modules/$KERNELRELEASE"
 echo "/boot/*"
 echo ""

--------------000703040400020203080308--
