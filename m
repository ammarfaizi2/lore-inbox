Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317566AbSFMJiN>; Thu, 13 Jun 2002 05:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317568AbSFMJiM>; Thu, 13 Jun 2002 05:38:12 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:57059 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317566AbSFMJiL>; Thu, 13 Jun 2002 05:38:11 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 13 Jun 2002 02:37:55 -0700
Message-Id: <200206130937.CAA23202@adam.yggdrasil.com>
To: martin@dalecki.de
Subject: Patch: linux-2.5.21/drivers/ide-disk.c crashed at shutdown
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	There are two reasons why ide-disk crashes at system shutdown.

1. idedisk_devdrv.lock is not initialized (RW_LOCK_UNLOCKED is not all
    zeroes on x86).

2. The ide-disk module "manually" sets device->driver, but
   drivers/base/core.c assumes that if device->driver != NULL then
   a bunch of other fields also have valid data (driver->driver_list,
   for example).  In this patch, I just clear drive->device.driver
   before calling put_device as a first step.  Eventually, I would
   like to use {driver,device}_register than their generic
   matching facility, but that might take a day to get right and
   I would like to get this first step into the kernel tree and
   get your input on this idea.

	In my patch, I also reindented the fields for idedisk_devdrv.
It's just a suggestion.

	I'll cc this to linux-kernel since others have reported
this kernel BUG().

	By the way, with this patch I now get a crash at about
the same time in usbdevfs, but I believe that is not part of
this problem.


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.21/drivers/ide/ide-disk.c 2002-06-08 22:26:29.000000000 -0700
+++ linux/drivers/ide/ide-disk.c        2002-06-13 02:08:46.000000000 -0700
@@ -822,8 +822,9 @@
  */
 
 static struct device_driver idedisk_devdrv = {
-       suspend: idedisk_suspend,
-       resume: idedisk_resume,
+       suspend:        idedisk_suspend,
+       resume:         idedisk_resume,
+       lock:           RW_LOCK_UNLOCKED,
 };
 
 /*
@@ -1196,6 +1197,9 @@
        if (!drive)
            return 0;
 
+       /* Kludge: we never registered with device_attach, so prevent
+          put_device from trying to remove us from device->driver_list */
+       drive->device.driver = NULL;
        put_device(&drive->device);
        if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
                if (idedisk_flushcache(drive))

