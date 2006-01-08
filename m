Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbWAHBit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWAHBit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 20:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWAHBit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 20:38:49 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35719 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161127AbWAHBit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 20:38:49 -0500
Message-ID: <43C06D1F.2020702@zytor.com>
Date: Sat, 07 Jan 2006 17:38:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop vmlinux dependency from "make install" (take 2)
References: <43C06420.1080300@zytor.com> <Pine.LNX.4.64.0601071707160.3169@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601071707160.3169@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060701030109050609070601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060701030109050609070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060701030109050609070601
Content-Type: text/plain;
 name="clean-install"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clean-install"

[i386, x86_64] Remove the dependency vmlinux -> install

This removes the dependency from vmlinux to install, thus avoiding the
current situation where "make install" has a nasty tendency to leave
root-turds in the working directory.

It also updates x86-64 to be in sync with i386.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index d121ea1..77bb67b 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -125,7 +125,6 @@ zdisk bzdisk: vmlinux
 fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
 
-install: vmlinux
 install kernel_install:
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
 
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
index f17b40d..7c88c9b 100644
--- a/arch/i386/boot/install.sh
+++ b/arch/i386/boot/install.sh
@@ -19,6 +19,18 @@
 #   $4 - default install path (blank if root directory)
 #
 
+verify () {
+	if [ ! -f "$1" ]; then
+		echo "Missing file: $1" 1>&2
+		echo 'You need to run "make" before "make install".' 1>&2
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
index a9cd42e..1d6e735 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -80,9 +80,12 @@ bzlilo: vmlinux
 bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
 
-install fdimage fdimage144 fdimage288: vmlinux
+fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
 
+install kernel_install:
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) install
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
deleted file mode 100644
index 198af15..9c99df6
--- a/arch/x86_64/boot/install.sh
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/sh
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
diff --git a/arch/x86_64/boot/install.sh b/arch/x86_64/boot/install.sh
new file mode 120000
index 198af15..9c99df6
--- /dev/null
+++ b/arch/x86_64/boot/install.sh
@@ -0,0 +1 @@
+../../i386/boot/install.sh
\ No newline at end of file

--------------060701030109050609070601--
