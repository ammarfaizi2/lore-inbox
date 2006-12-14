Return-Path: <linux-kernel-owner+w=401wt.eu-S932740AbWLNONJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbWLNONJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbWLNONI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:13:08 -0500
Received: from gw-eur4.philips.com ([161.85.125.10]:48807 "EHLO
	gw-eur4.philips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbWLNONH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:13:07 -0500
To: <hpa@zytor.com>, <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] disable init/initramfs.c (updated)
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OF05F1364A.E55256D9-ONC1257244.003C1687-C1257244.004D7E0F@philips.com>
From: Jean-Paul Saman <jean-paul.saman@nxp.com>
Date: Thu, 14 Dec 2006 15:06:23 +0100
X-MIMETrack: Serialize by Router on ehvrmh02/H/SERVER/PHILIPS(Release 6.5.5HF805 | August
 26, 2006) at 14/12/2006 15:06:24,
	Serialize complete at 14/12/2006 15:06:24
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file init/initramfs.c is always compiled and linked in the kernel 
vmlinux even when BLK_DEV_RAM and BLK_DEV_INITRD are disabled and the 
system isn't using any form of an initramfs or initrd. In this situation 
the code is only used to unpack a (static) default initial rootfilesystem. 
The current init/initramfs.c code. usr/initramfs_data.o compiles to a size 
of ~15 kbytes. Disabling BLK_DEV_RAM and BLK_DEV_INTRD shrinks the kernel 
code size with ~60 Kbytes.

This patch makes it doesn't compile in the code and data for initramfs 
support if CONFIG_BLK_DEV_INITRD is not defined. Instead of the initramfs 
code and data it uses a small routine in init/noinitramfs.c to setup an 
initial static default environment for mounting a rootfilesystem later on 
in the kernel initialisation process. The new code is: 164 bytes of size.

The patch is separated in two parts:
1) doesn't compile initramfs code when CONFIG_BLK_DEV_INITRD is not set
2) changing all plaforms vmlinux.lds.S files to not reserve an area of 
PAGE_SIZE when CONFIG_BLK_DEV_INITRD is not set.

The patchset is compiled (2.6.10, 2.6.15, 2.6.git) and tested on mips 
(PNX8535, kernel version 2.6.10) and arm (IntegratorAP/ARM1176 SoC, kernel 
version 2.6.15).

Signed-off-by: Jean-Paul Saman <jean-paul.saman@nxp.com>
----------------------

Index: linux-2.6.git/drivers/block/Kconfig
===================================================================
--- linux-2.6.git.orig/drivers/block/Kconfig    2006-12-14 
13:21:54.000000000 +0100
+++ linux-2.6.git/drivers/block/Kconfig 2006-12-14 14:59:38.000000000 
+0100
@@ -417,8 +417,10 @@ config BLK_DEV_INITRD
          etc. See <file:Documentation/initrd.txt> for details.
 
          If RAM disk support (BLK_DEV_RAM) is also included, this
-         also enables initial RAM disk (initrd) support.
+         also enables initial RAM disk (initrd) support and adds
+         15 Kbytes (more on some other architectures) to the kernel size.
 
+         If unsure say Y.
 
 config CDROM_PKTCDVD
        tristate "Packet writing on CD/DVD media"
Index: linux-2.6.git/init/Makefile
===================================================================
--- linux-2.6.git.orig/init/Makefile    2006-12-14 13:21:54.000000000 
+0100
+++ linux-2.6.git/init/Makefile 2006-12-14 14:00:49.000000000 +0100
@@ -2,7 +2,12 @@
 # Makefile for the linux kernel.
 #
 
-obj-y                          := main.o version.o mounts.o initramfs.o
+obj-y                          := main.o version.o mounts.o
+ifneq ($(CONFIG_BLK_DEV_INITRD),y)
+obj-y                          += noinitramfs.o
+else
+obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
+endif
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
 
 mounts-y                       := do_mounts.o
Index: linux-2.6.git/usr/Makefile
===================================================================
--- linux-2.6.git.orig/usr/Makefile     2006-12-14 13:21:54.000000000 
+0100
+++ linux-2.6.git/usr/Makefile  2006-12-14 13:31:29.000000000 +0100
@@ -7,7 +7,7 @@ PHONY += klibcdirs
 
 
 # Generate builtin.o based on initramfs_data.o
-obj-y := initramfs_data.o
+obj-$(CONFIG_BLK_DEV_INITRD) := initramfs_data.o
 
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
Index: linux-2.6.git/init/Kconfig
===================================================================
--- linux-2.6.git.orig/init/Kconfig     2006-12-14 13:21:54.000000000 
+0100
+++ linux-2.6.git/init/Kconfig  2006-12-14 13:38:44.000000000 +0100
@@ -280,8 +280,12 @@ config RELAY
 
          If unsure, say N.
 
+if BLK_DEV_INITRD
+
 source "usr/Kconfig"
 
+endif
+
 config CC_OPTIMIZE_FOR_SIZE
        bool "Optimize for size (Look out for broken compilers!)"
        default y
Index: linux-2.6.git/init/noinitramfs.c
===================================================================
--- /dev/null   1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.git/init/noinitramfs.c    2006-12-14 13:31:29.000000000 
+0100
@@ -0,0 +1,43 @@
+/*
+ * init/noinitramfs.c
+ *
+ * Copyright (C) 2006, NXP Semiconductors, All Rights Reserved
+ * Author: Jean-Paul Saman <jean-paul.saman@nxp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 
USA
+ */
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/syscalls.h>
+
+/*
+ * Create a simple rootfs that is similar to the default initramfs
+ */
+static void __init default_rootfs(void)
+{
+        int mkdir_err = sys_mkdir("/dev", 0755);
+        int err = sys_mknod((const char __user *) "/dev/console",
+                                S_IFCHR | S_IRUSR | S_IWUSR,
+                                new_encode_dev(MKDEV(5, 1)));
+        if (err == -EROFS )
+               printk( "Warning: Failed to create a rootfs\n" );
+        mkdir_err = sys_mkdir("/root", 0700);
+}
+rootfs_initcall(default_rootfs);
+

---------------------------------

Kind greetings,

Jean-Paul Saman

NXP Semiconductors CTO/RTG DesignIP
