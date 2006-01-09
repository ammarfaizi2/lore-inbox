Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWAIVje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWAIVje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWAIVjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:39:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14608 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750746AbWAIVjB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:39:01 -0500
Subject: [PATCH 09/11] kbuild: drop vmlinux dependency from "make install"
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:44 +0100
Message-Id: <11368427243850@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Peter Anvin <hpa@zytor.com>
Date: 1136684319 -0800

This removes the dependency from vmlinux to install, thus avoiding the
current situation where "make install" has a nasty tendency to leave
root-turds in the working directory.

It also updates x86-64 to be in sync with i386.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/i386/Makefile          |    5 ++---
 arch/i386/boot/Makefile     |    2 +-
 arch/i386/boot/install.sh   |   14 ++++++++++++++
 arch/x86_64/Makefile        |    5 ++++-
 arch/x86_64/boot/Makefile   |    2 +-
 arch/x86_64/boot/install.sh |   40 +---------------------------------------
 6 files changed, 23 insertions(+), 45 deletions(-)

0d20babd86b40fa5ac55d9ebf31d05f6f7082161
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 8f6b90e..d3c0409 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -103,7 +103,7 @@ AFLAGS += $(mflags-y)
 boot := arch/i386/boot
 
 .PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install kernel_install
+	zdisk bzdisk fdimage fdimage144 fdimage288 install
 
 all: bzImage
 
@@ -125,8 +125,7 @@ zdisk bzdisk: vmlinux
 fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
 
-install: vmlinux
-install kernel_install:
+install:
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
 
 archclean:
diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
index 1e71382..0fea75d 100644
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -100,5 +100,5 @@ zlilo: $(BOOTIMAGE)
 	cp System.map $(INSTALL_PATH)/
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
-install: $(BOOTIMAGE)
+install:
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
diff --git a/arch/i386/boot/install.sh b/arch/i386/boot/install.sh
index f17b40d..5e44c73 100644
--- a/arch/i386/boot/install.sh
+++ b/arch/i386/boot/install.sh
@@ -19,6 +19,20 @@
 #   $4 - default install path (blank if root directory)
 #
 
+verify () {
+	if [ ! -f "$1" ]; then
+		echo ""                                                   1>&2
+		echo " *** Missing file: $1"                              1>&2
+		echo ' *** You need to run "make" before "make install".' 1>&2
+		echo ""                                                   1>&2
+		exit 1
+ 	fi
+}
+
+# Make sure the files actually exist
+verify "$2"
+verify "$3"
+
 # User may have a custom install script
 
 if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index a9cd42e..51d8328 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -80,9 +80,12 @@ bzlilo: vmlinux
 bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
 
-install fdimage fdimage144 fdimage288: vmlinux
+fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
 
+install:
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@ 
+
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
diff --git a/arch/x86_64/boot/Makefile b/arch/x86_64/boot/Makefile
index 18c6e91..29f8396 100644
--- a/arch/x86_64/boot/Makefile
+++ b/arch/x86_64/boot/Makefile
@@ -98,5 +98,5 @@ zlilo: $(BOOTIMAGE)
 	cp System.map $(INSTALL_PATH)/
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
-install: $(BOOTIMAGE)
+install:
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
diff --git a/arch/x86_64/boot/install.sh b/arch/x86_64/boot/install.sh
index 198af15..baaa236 100644
--- a/arch/x86_64/boot/install.sh
+++ b/arch/x86_64/boot/install.sh
@@ -1,40 +1,2 @@
 #!/bin/sh
-#
-# arch/x86_64/boot/install.sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for i386 architecture
-#
-# Arguments:
-#   $1 - kernel version
-#   $2 - kernel image file
-#   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
-#
-
-# User may have a custom install script
-
-if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
-if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
-
-# Default install - same as make zlilo
-
-if [ -f $4/vmlinuz ]; then
-	mv $4/vmlinuz $4/vmlinuz.old
-fi
-
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
-fi
-
-cat $2 > $4/vmlinuz
-cp $3 $4/System.map
-
-if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
+. $srctree/arch/i386/boot/install.sh
-- 
1.0.GIT

