Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWAANXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWAANXv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 08:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWAANXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 08:23:51 -0500
Received: from lug-owl.de ([195.71.106.12]:18363 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751108AbWAANXv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 08:23:51 -0500
Date: Sun, 1 Jan 2006 14:23:47 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Linda Walsh <lkml@tlinx.org>
Subject: tar-pkg with out-out-tree building
Message-ID: <20060101132347.GB1298@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linda Walsh <lkml@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix out-of-tree builds for the tar-pkg targets

When I wrote the buildtar script, I didn't even think about
out-of-tree builds because I didn't use these back then. This patch
throughoutly uses ${objtree} instead of `pwd`.

Also, the kernel version is no longer manually built. Instead, it will
properly use $KERNELRELEASE .  Installing modules is only done if
CONFIG_MODULES is set.

Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>

----

 Makefile |    2 +-
 buildtar |   31 +++++++++++++------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index f3e7e8e..c201ef0 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -84,7 +84,7 @@ clean-dirs += $(objtree)/debian/
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
@@ -1,9 +1,9 @@
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
@@ -15,9 +15,8 @@ set -e
 #
 # Some variables and settings used throughout the script
 #
-version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
 tmpdir="${objtree}/tar-install"
-tarball="${objtree}/linux-${version}.tar"
+tarball="${objtree}/linux-${KERNELRELEASE}.tar"
 
 
 #
@@ -53,21 +52,17 @@ mkdir -p -- "${tmpdir}/boot"
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
@@ -75,17 +70,17 @@ cp -v -- vmlinux "${tmpdir}/boot/vmlinux
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

-- 
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
 für einen Freien Staat voll Freier Bürger"  | im Internet! |   im Irak!   O O O
ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
