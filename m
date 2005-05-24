Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVEXKuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVEXKuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVEXKsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:48:43 -0400
Received: from lug-owl.de ([195.71.106.12]:17814 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262032AbVEXJ1n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:27:43 -0400
Date: Tue, 24 May 2005 11:27:37 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kbuild-Packaging: Create tarballs
Message-ID: <20050524092737.GQ2417@lug-owl.de>
Mail-Followup-To: sam@ravnborg.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Operating-System: Linux mail 2.6.11.10lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam!

I propose this patch for ./scripts/packag/ .  It adds tarball packaging,
which I prefer for distribution. Also one of the two blanks after @echo
is removed. One seems to be enough :)

Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>

---

 scripts/package/Makefile  |   19 ++++++-
 scripts/package/buildtar  |  111 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc4-git7/scripts/package/Makefile	Wed Mar  2 08:38:11 2005
+++ linux-tarball/scripts/package/Makefile	Tue May 24 11:04:41 2005
@@ -80,10 +80,23 @@ deb-pkg:
 clean-dirs += $(objtree)/debian/
 
 
+# tarball targets
+# ---------------------------------------------------------------------------
+.PHONY: tar%pkg
+tar%pkg:
+	$(MAKE)
+	$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
+
+clean-dirs += $(objtree)/tar-install/
+
+
 # Help text displayed when executing 'make help'
 # ---------------------------------------------------------------------------
 help:
-	@echo  '  rpm-pkg         - Build the kernel as an RPM package'
-	@echo  '  binrpm-pkg      - Build an rpm package containing the compiled kernel & modules'
-	@echo  '  deb-pkg         - Build the kernel as an deb package'
+	@echo '  rpm-pkg         - Build the kernel as an RPM package'
+	@echo '  binrpm-pkg      - Build an rpm package containing the compiled kernel & modules'
+	@echo '  deb-pkg         - Build the kernel as an deb package'
+	@echo '  tar-pkg         - Build the kernel as an uncompressed tarball'
+	@echo '  targz-pkg       - Build the kernel as a gzip compressed tarball'
+	@echo '  tarbz2-pkg      - Build the kernel as a bzip2 compressed tarball'
 
--- linux-2.6.12-rc4-git7/scripts/package/buildtar	Thu Jan  1 01:00:00 1970
+++ linux-tarball/scripts/package/buildtar	Tue May 24 10:58:51 2005
@@ -0,0 +1,111 @@
+#!/bin/sh
+
+#
+# buildtar 0.0.3
+#
+# (C) 2004-2005 by Jan-Benedict Glaw <jbglaw@lug-owl.de>
+#
+# This script is used to compile a tarball from the currently
+# prepared kernel. Based upon the builddeb script from
+# Wichert Akkerman <wichert@wiggy.net>.
+#
+
+set -e
+
+#
+# Some variables and settings used throughout the script
+#
+version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
+tmpdir="${objtree}/tar-install"
+tarball="${objtree}/linux-${version}.tar"
+
+
+#
+# Figure out how to compress, if requested at all
+#
+case "${1}" in
+	tar-pkg)
+		compress="cat"
+		file_ext=""
+		;;
+	targz-pkg)
+		compress="gzip -c9"
+		file_ext=".gz"
+		;;
+	tarbz2-pkg)
+		compress="bzip2 -c9"
+		file_ext=".bz2"
+		;;
+	*)
+		echo "Unknown tarball target \"${1}\" requested, please add it to ${0}." >&2
+		exit 1
+		;;
+esac
+
+
+#
+# Clean-up and re-create the temporary directory
+#
+rm -rf -- "${tmpdir}"
+mkdir -p -- "${tmpdir}/boot"
+
+
+#
+# Try to install modules
+#
+if ! make INSTALL_MOD_PATH="${tmpdir}" modules_install; then
+	echo "" >&2
+	echo "Ignoring error at module_install time, since that could be" >&2
+	echo "a result of missing local modutils/module-init-tools," >&2
+	echo "or you just didn't compile in module support at all..." >&2
+	echo "" >&2
+fi
+
+
+#
+# Install basic kernel files
+#
+cp -v -- System.map "${tmpdir}/boot/System.map-${version}"
+cp -v -- .config "${tmpdir}/boot/config-${version}"
+cp -v -- vmlinux "${tmpdir}/boot/vmlinux-${version}"
+
+
+#
+# Install arch-specific kernel image(s)
+#
+case "${ARCH}" in
+	i386)
+		[ -f arch/i386/boot/bzImage ] && cp -v -- arch/i386/boot/bzImage "${tmpdir}/boot/vmlinuz-${version}"
+		;;
+	alpha)
+		[ -f arch/alpha/boot/vmlinux.gz ] && cp -v -- arch/alpha/boot/vmlinux.gz "${tmpdir}/boot/vmlinuz-${version}"
+		;;
+	vax)
+		[ -f vmlinux.SYS ] && cp -v -- vmlinux.SYS "${tmpdir}/boot/vmlinux-${version}.SYS"
+		[ -f vmlinux.dsk ] && cp -v -- vmlinux.dsk "${tmpdir}/boot/vmlinux-${version}.dsk"
+		;;
+	*)
+		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${version}"
+		echo "" >&2
+		echo '** ** **  WARNING  ** ** **' >&2
+		echo "" >&2
+		echo "Your architecture did not define any architecture-dependant files" >&2
+		echo "to be placed into the tarball. Please add those to ${0} ..." >&2
+		echo "" >&2
+		sleep 5
+		;;
+esac
+
+
+#
+# Create the tarball
+#
+(
+	cd "${tmpdir}"
+	tar cf - . | ${compress} > "${tarball}${file_ext}"
+)
+
+echo "Tarball successfully created in ${tarball}${file_ext}"
+
+exit 0
+


-- 
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
 fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!   O O O
ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
