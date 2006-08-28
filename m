Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWH1WLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWH1WLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWH1WLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:11:50 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:43676 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751569AbWH1WLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:11:49 -0400
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: debian-kernel@lists.debian.org, Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 17:11:42 -0500
Message-Id: <1156803102.3465.34.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reference implementation with the debian mkinitrd-tools
package.  It shows how to identify the firmware files necessary for
drivers in the initrd and also includes a primitive system for loading
them.

I've tested this with the aic94xx driver using the new MODULE_FIRMWARE()
tag.  Initramfs should be much easier because it already includes most
of the boot time loading; all it has to do is the piece identifying the
firmware for the selected modules.

James

---
Index: initrd-tools-0.1.84.1/mkinitrd
===================================================================
--- initrd-tools-0.1.84.1.orig/mkinitrd	2006-08-28 13:37:30.000000000 -0500
+++ initrd-tools-0.1.84.1/mkinitrd	2006-08-28 16:33:28.000000000 -0500
@@ -950,6 +950,7 @@ add_modules_dep() {
 		return
 	elif ! [ $oldstyle ]; then
 		add_modules_dep_2_5 $VERSION
+		add_firmware $VERSION
 		return
 	fi
 
@@ -1016,6 +1017,25 @@ add_modules_dep_2_5() {
 	fi
 }
 
+add_firmware() {
+	ver=$1
+	set -- $FSTYPES
+	unset IFS
+
+	cat modules.? |
+		while read junk mod junk; do
+			modpath=$(modprobe --set-version "$ver" --list $mod)
+			if [ -z "$modpath" ]; then
+				continue;
+			fi
+			p=$(modinfo -F firmware "$modpath" |sed 's/^/\/lib\/firmware\//')
+			if [ -n "$p" ]; then
+				echo $p
+				echo /usr/sbin/firmware_loader
+			fi
+		done
+}
+
 add_command() {
 	if [ -h initrd/"$1" ]; then
 		return
Index: initrd-tools-0.1.84.1/firmware_loader
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ initrd-tools-0.1.84.1/firmware_loader	2006-08-28 16:56:18.000000000 -0500
@@ -0,0 +1,29 @@
+#!/bin/sh -e
+#
+# firmware loader agent
+#
+FIRMWARE_DIRS="/lib/firmware"
+
+if [ "$SUBSYSTEM" != "firmware" ]; then
+    exit 0;
+fi
+
+if [ ! -e /sys/$DEVPATH/loading ]; then
+    echo "/sys/$DEVPATH/ does not exist"
+    exit 1
+fi
+
+for DIR in $FIRMWARE_DIRS; do
+    [ -e "$DIR/$FIRMWARE" ] || continue
+    echo 1 > /sys/$DEVPATH/loading
+    cat "$DIR/$FIRMWARE" > /sys/$DEVPATH/data
+    echo 0 > /sys/$DEVPATH/loading
+    exit 0
+done
+
+# the firmware was not found
+echo -1 > /sys/$DEVPATH/loading
+
+echo "Cannot find the $FIRMWARE firmware"
+exit 1
+
Index: initrd-tools-0.1.84.1/debian/rules
===================================================================
--- initrd-tools-0.1.84.1.orig/debian/rules	2006-08-28 16:07:52.000000000 -0500
+++ initrd-tools-0.1.84.1/debian/rules	2006-08-28 16:08:56.000000000 -0500
@@ -35,7 +35,7 @@ install: 
 	install -o root -g root -m 644 \
 		echo init linuxrc debian/initrd-tools/usr/share/initrd-tools/
 	install -o root -g root -m 755 \
-		mkinitrd debian/initrd-tools/usr/sbin/
+		mkinitrd firmware_loader debian/initrd-tools/usr/sbin/
 	install -o root -g root -m 644 \
 		mkinitrd.conf modules debian/initrd-tools/etc/mkinitrd/
 ifeq ($(DEB_HOST_ARCH),powerpc)
Index: initrd-tools-0.1.84.1/linuxrc
===================================================================
--- initrd-tools-0.1.84.1.orig/linuxrc	2006-08-28 16:30:30.000000000 -0500
+++ initrd-tools-0.1.84.1/linuxrc	2006-08-28 16:40:45.000000000 -0500
@@ -10,3 +10,7 @@ echo 256 > proc/sys/kernel/real-root-dev
 mount -nt tmpfs tmpfs bin ||
 	mount -nt ramfs ramfs bin
 echo $root > bin/root
+if [ -x /usr/sbin/firmware_loader ]; then
+	echo /usr/sbin/firmware_loader > /proc/sys/kernel/hotplug
+fi
+
Index: initrd-tools-0.1.84.1/init
===================================================================
--- initrd-tools-0.1.84.1.orig/init	2006-08-28 16:54:52.000000000 -0500
+++ initrd-tools-0.1.84.1/init	2006-08-28 16:55:01.000000000 -0500
@@ -366,6 +366,7 @@ get_cmdline
 [ -c /dev/.devfsd ] && DEVFS=yes
 
 mount -nt devfs devfs devfs
+mount -nt sysfs sysfs sys
 if [ $IDE_CORE != none ] && [ -n "$ide_options" ]; then
 	echo modprobe -k $IDE_CORE "options=\"$ide_options\""
 	modprobe -k $IDE_CORE options="$ide_options"


