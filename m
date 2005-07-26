Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVGZWDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVGZWDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVGZWDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:03:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:49374 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262165AbVGZWDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:03:11 -0400
Subject: patch i2c-ds1337-12-24-mode-fix.patch added to gregkh-2.6 tree
To: gregkh@suse.de, jchapman@katalix.com, ladis@linux-mips.org,
       linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Tue, 26 Jul 2005 15:03:39 -0700
In-Reply-To: <20050725082436.GA10186@orphique>
Message-ID: <1DxXWV-4si-00@press.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: ds1337 - fix 12/24 hour mode bug

to my gregkh-2.6 tree.  Its filename is

     i2c-ds1337-12-24-mode-fix.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from gregkh@suse.de are

devfs/devfs-remove-devfs-tape.patch
devfs/devfs-die-die-die.patch
devfs/devfs-remove-devfs_mk_symlink.patch
devfs/devfs-remove-devfs_mk_bdev.patch
devfs/devfs-remove-devfs_mk_dir.patch
devfs/devfs-scrub-partitions.patch
devfs/devfs-scrub-init.patch
devfs/devfs-remove-devfs_mk_cdev.patch
devfs/devfs-remove-devfs_remove.patch
devfs/devfs-remove-devfs_fs_kernel.h.patch
devfs/devfs-remove-misc-devfs_name.patch
devfs/devfs-remove-genhd-devfs_name.patch
devfs/devfs-remove-videodev-devfs_name.patch
devfs/devfs-remove-serial-devfs_name.patch
devfs/devfs-remove-ide-devfs_name.patch
devfs/devfs-remove-line-devfs_name.patch
devfs/devfs-remove-scsi-devfs_name.patch
devfs/devfs-remove-tty-devfs_name.patch
devfs/devfs-remove-usb-mode.patch
devfs/devfs-tty_driver_no_devfs.patch
devfs/devfs-minor-cleanups.patch
devfs/devfs-remove-documentation.patch
devfs/ndevfs.patch
driver/securityfs.patch
driver/driver-sample.sh.patch
gregkh/gregkh-debugfs_example.patch
gregkh/gregkh-kobject-warn.patch
gregkh/gregkh-laptop-sysrq.patch
gregkh/gregkh-usb-hacking.patch
gregkh/gregkh-usb-minors.patch
i2c/i2c-max6875-documentation-update.patch
i2c/i2c-max6875-simplify.patch
i2c/i2c-mpc-restore-code-removed.patch
i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch
i2c/i2c-missing-space.patch
i2c/i2c-ds1337-12-24-mode-fix.patch
i2c/i2c-nforce2-cleanup.patch
pci/pci-acpi-mcfg-04.patch


>From ladis@linux-mips.org Mon Jul 25 10:41:08 2005
Date: Mon, 25 Jul 2005 10:24:36 +0200
To: Greg KH <gregkh@suse.de>
Cc: James Chapman <jchapman@katalix.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: I2C: ds1337 - fix 12/24 hour mode bug
Message-ID: <20050725082436.GA10186@orphique>
From: Ladislav Michl <ladis@linux-mips.org>

DS1339 manual, page 6, chapter Date and time operation:
  The DS1339 can be run in either 12-hour or 24-hour mode. Bit 6 of the
  hours register is defined as the 12-hour or 24-hour mode-select bit.
  When high, the 12-hour mode is selected.
 
Patch below makes ds1337 driver work as documented in manual.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/chips/ds1337.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/chips/ds1337.c	2005-07-13 09:45:05.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/ds1337.c	2005-07-26 15:02:26.000000000 -0700
@@ -165,7 +165,7 @@
 	buf[0] = 0;		/* reg offset */
 	buf[1] = BIN2BCD(dt->tm_sec);
 	buf[2] = BIN2BCD(dt->tm_min);
-	buf[3] = BIN2BCD(dt->tm_hour) | (1 << 6);
+	buf[3] = BIN2BCD(dt->tm_hour);
 	buf[4] = BIN2BCD(dt->tm_wday) + 1;
 	buf[5] = BIN2BCD(dt->tm_mday);
 	buf[6] = BIN2BCD(dt->tm_mon) + 1;
@@ -344,9 +344,9 @@
 
 	/* Ensure that device is set in 24-hour mode */
 	val = i2c_smbus_read_byte_data(client, DS1337_REG_HOUR);
-	if ((val >= 0) && (val & (1 << 6)) == 0)
+	if ((val >= 0) && (val & (1 << 6)))
 		i2c_smbus_write_byte_data(client, DS1337_REG_HOUR,
-					  val | (1 << 6));
+					  val & 0x3f);
 }
 
 static int ds1337_detach_client(struct i2c_client *client)

