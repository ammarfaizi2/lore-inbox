Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbTCXJ5i>; Mon, 24 Mar 2003 04:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264148AbTCXJ5i>; Mon, 24 Mar 2003 04:57:38 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:31878 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264146AbTCXJ5g>; Mon, 24 Mar 2003 04:57:36 -0500
Date: Mon, 24 Mar 2003 11:08:24 +0000
From: norbert_wolff@t-online.de (Norbert Wolff)
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: PROBLEM: linux-2.5.65-ac3 does not boot whith IDE-drivers
Message-Id: <20030324110824.1b419814.norbert_wolff@t-online.de>
In-Reply-To: <3E7E3248.7070307@portrix.net>
References: <20030322140337.GA1193@brodo.de>
	<1048350905.9219.1.camel@irongate.swansea.linux.org.uk>
	<20030322162502.GA870@brodo.de>
	<1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
	<20030323010338.GA886@brodo.de>
	<1048434472.10729.28.camel@irongate.swansea.linux.org.uk>
	<20030323145915.GA865@brodo.de>
	<1048444868.10729.54.camel@irongate.swansea.linux.org.uk>
	<20030323181532.GA6819@brodo.de>
	<20030323182554.GA1270@brodo.de>
	<3E7E3248.7070307@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I tried linux-2.5.65-ac3 with ide-disk and ide-scsi drivers both built in
the Kernel.
Two ide-disks attached to ide0, two CDROMS attached to ide1.
Im using the sis5513-PCI-IDE-Driver, but configuring it out makes no difference.

The System hangs while booting with last messages
	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
	ide1 at 0x170-0x177,0x376 on irq 15

It seems that all Drives went twice in the driver-list, so ata_attach
gets called twice for them, which leads to the hang.

Dirty Hack that works for me below.

Regards,

	Norbert


--- drivers/ide/ide.c.orig	2003-03-24 10:52:40.000000000 +0000
+++ drivers/ide/ide.c	2003-03-24 10:57:52.000000000 +0000
@@ -1423,6 +1423,14 @@
 {
 	struct list_head *p;
 	spin_lock(&drivers_lock);
+#define _DEBUG 1
+#ifdef _DEBUG
+	printk("ata_attach called for %s\n", drive->name);
+#endif
+	if (drive->already_attached) {
+		printk ("ata_attach: already attached for %s !\n", drive->name);
+		return 0;
+	}
 	list_for_each(p, &drivers) {
 		ide_driver_t *driver = list_entry(p, ide_driver_t, drivers);
 		if (!try_module_get(driver->owner))
@@ -1431,12 +1439,14 @@
 		if (driver->attach(drive) == 0) {
 			module_put(driver->owner);
 			drive->gendev.driver = &driver->gen_driver;
+			drive->already_attached = 1;
 			return 0;
 		}
 		spin_lock(&drivers_lock);
 		module_put(driver->owner);
 	}
 	drive->gendev.driver = &idedefault_driver.gen_driver;
+	drive->already_attached = 1;
 	spin_unlock(&drivers_lock);
 	if(idedefault_driver.attach(drive) != 0)
 		panic("ide: default attach failed");
--- include/linux/ide.h.orig	2003-03-24 11:01:41.000000000 +0000
+++ include/linux/ide.h	2003-03-24 11:02:33.000000000 +0000
@@ -791,6 +791,7 @@
 	int		forced_lun;	/* if hdxlun was given at boot */
 	int		lun;		/* logical unit */
 	int		crc_count;	/* crc counter to reduce drive speed */
+	int     already_attached;  /* Dirty Hack ... */
 	struct list_head list;
 	struct device	gendev;
 	struct gendisk *disk;
