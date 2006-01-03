Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWACPF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWACPF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWACPF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:05:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60677 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751416AbWACPF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:05:26 -0500
Date: Tue, 3 Jan 2006 16:05:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kbuild: tar-pkg with out-out-tree building
Message-ID: <20060103150517.GD18012@mars.ravnborg.org>
References: <20060103132035.GA17485@mars.ravnborg.org> <20060103150219.GC18012@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103150219.GC18012@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff-tree 6073aa643f52fd12b02f0532dc96287f4c3293b5 (from 752625cff3eba81cbc886988d5b420064c033948)
Author: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Date:   Sun Jan 1 14:23:47 2006 +0100

    kbuild: tar-pkg with out-out-tree building
    
    Fix out-of-tree builds for the tar-pkg targets
    
    When I wrote the buildtar script, I didn't even think about
    out-of-tree builds because I didn't use these back then. This patch
    throughoutly uses ${objtree} instead of `pwd`.
    
    Also, the kernel version is no longer manually built. Instead, it will
    properly use $KERNELRELEASE .  Installing modules is only done if
    CONFIG_MODULES is set.
    
    Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index f3e7e8e..c201ef0 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -82,11 +82,11 @@ clean-dirs += $(objtree)/debian/
 
 # tarball targets
 # ---------------------------------------------------------------------------
 .PHONY: tar%pkg
 tar%pkg:
-	$(MAKE)
+	$(MAKE) KBUILD_SRC=
 	$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
 clean-dirs += $(objtree)/tar-install/
 
 
diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index d8fffe6..88b5281 100644
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -1,11 +1,11 @@
 #!/bin/sh
 
 #
-# buildtar 0.0.3
+# buildtar 0.0.4
 #
-# (C) 2004-2005 by Jan-Benedict Glaw <jbglaw@lug-owl.de>
+# (C) 2004-2006 by Jan-Benedict Glaw <jbglaw@lug-owl.de>
 #
 # This script is used to compile a tarball from the currently
 # prepared kernel. Based upon the builddeb script from
 # Wichert Akkerman <wichert@wiggy.net>.
 #
@@ -13,13 +13,12 @@
 set -e
 
 #
 # Some variables and settings used throughout the script
 #
-version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
 tmpdir="${objtree}/tar-install"
-tarball="${objtree}/linux-${version}.tar"
+tarball="${objtree}/linux-${KERNELRELEASE}.tar"
 
 
 #
 # Figure out how to compress, if requested at all
 #
@@ -51,43 +50,39 @@ mkdir -p -- "${tmpdir}/boot"
 
 
 #
 # Try to install modules
 #
-if ! make INSTALL_MOD_PATH="${tmpdir}" modules_install; then
-	echo "" >&2
-	echo "Ignoring error at module_install time, since that could be" >&2
-	echo "a result of missing local modutils/module-init-tools," >&2
-	echo "or you just didn't compile in module support at all..." >&2
-	echo "" >&2
+if grep -q '^CONFIG_MODULES=y' "${objtree}/.config"; then
+	make ARCH="${ARCH}" O="${objtree}" KBUILD_SRC= INSTALL_MOD_PATH="${tmpdir}" modules_install
 fi
 
 
 #
 # Install basic kernel files
 #
-cp -v -- System.map "${tmpdir}/boot/System.map-${version}"
-cp -v -- .config "${tmpdir}/boot/config-${version}"
-cp -v -- vmlinux "${tmpdir}/boot/vmlinux-${version}"
+cp -v -- "${objtree}/System.map" "${tmpdir}/boot/System.map-${KERNELRELEASE}"
+cp -v -- "${objtree}/.config" "${tmpdir}/boot/config-${KERNELRELEASE}"
+cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 
 
 #
 # Install arch-specific kernel image(s)
 #
 case "${ARCH}" in
 	i386)
-		[ -f arch/i386/boot/bzImage ] && cp -v -- arch/i386/boot/bzImage "${tmpdir}/boot/vmlinuz-${version}"
+		[ -f "${objtree}/arch/i386/boot/bzImage" ] && cp -v -- "${objtree}/arch/i386/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
 	alpha)
-		[ -f arch/alpha/boot/vmlinux.gz ] && cp -v -- arch/alpha/boot/vmlinux.gz "${tmpdir}/boot/vmlinuz-${version}"
+		[ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
 	vax)
-		[ -f vmlinux.SYS ] && cp -v -- vmlinux.SYS "${tmpdir}/boot/vmlinux-${version}.SYS"
-		[ -f vmlinux.dsk ] && cp -v -- vmlinux.dsk "${tmpdir}/boot/vmlinux-${version}.dsk"
+		[ -f "${objtree}/vmlinux.SYS" ] && cp -v -- "${objtree}/vmlinux.SYS" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.SYS"
+		[ -f "${objtree}/vmlinux.dsk" ] && cp -v -- "${objtree}/vmlinux.dsk" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.dsk"
 		;;
 	*)
-		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${version}"
+		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
 		echo "" >&2
 		echo '** ** **  WARNING  ** ** **' >&2
 		echo "" >&2
 		echo "Your architecture did not define any architecture-dependant files" >&2
 		echo "to be placed into the tarball. Please add those to ${0} ..." >&2
