Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756231AbWKSFAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbWKSFAd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 00:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756351AbWKSFAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 00:00:32 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:51639 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1756231AbWKSFAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 00:00:32 -0500
Date: Sat, 18 Nov 2006 22:00:28 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: bos@serpentine.com, azarah@nosferatu.za.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Fix unprivileged user builds of initramfs 
Message-ID: <20061119050028.GF18567@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Kconfig help for INITRAMFS_SOURCE claims that you can specify multiple
space-separated sources in order to allow unprivileged users to build an
image.  There are two bugs in the current implementation that prevent
this from working.

First, we pass "file1 dir2" to the gen_initramfs_list.sh script, which
it obviously can't open.  I opted to fix this in the Makefile by doing
a $(shell echo ...).

Second, gen_initramfs_list.sh -l outputs multiple definitions for
deps_initramfs -- one for each argument.  This annoys make the second time
you run it.  I chose to fix this problem by introducing list_header_once()
and making list_header() be a nop.

Someone with more time might find a more elegant fix for either or both
of these problems.  But now my qlogic adapter can find its firmware without
being turned into a module.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 331c079..dcb5aff 100644
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -157,10 +157,14 @@ unknown_option() {
 	exit 1
 }
 
-list_header() {
+list_header_once() {
 	echo "deps_initramfs := \\"
 }
 
+list_header() {
+	:
+}
+
 header() {
 	printf "\n#####################\n# $1\n" >> ${output}
 }
@@ -227,6 +231,7 @@ arg="$1"
 case "$arg" in
 	"-l")	# files included in initramfs - used by kbuild
 		dep_list="list_"
+		list_header_once
 		shift
 		;;
 	"-o")	# generate gzipped cpio image named $1
diff --git a/usr/Makefile b/usr/Makefile
index e338e7b..3d59fb4 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -20,7 +20,7 @@ $(obj)/initramfs_data.o: $(obj)/initramf
 hostprogs-y := gen_init_cpio
 initramfs   := $(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh
 ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
-                    $(CONFIG_INITRAMFS_SOURCE),-d)
+                    $(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
 ramfs-args  := \
         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
         $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))
