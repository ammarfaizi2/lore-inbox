Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbSJISgH>; Wed, 9 Oct 2002 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262423AbSJISgC>; Wed, 9 Oct 2002 14:36:02 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5040 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262421AbSJISfL>;
	Wed, 9 Oct 2002 14:35:11 -0400
Date: Wed, 9 Oct 2002 11:43:18 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [bk/patch] IDE driver model update
Message-ID: <Pine.LNX.4.44.0210091131360.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this basically a resend of the IDE driver model update from two days, 
with two changes:

- Add and use a struct device in ide_drive_t.
- Remove ->release() method() and move call to driver's cleanup() into
  ->remove() (mimicking previous behavior of reboot notifier).

Please apply.

Thanks,

	-pat

Please pull from 

	bk://ldm.bkbits.net/linux-2.5-ide

This will update the following files:

 drivers/ide/ide-disk.c  |   18 -----------
 drivers/ide/ide-probe.c |   23 +++++++++------
 drivers/ide/ide.c       |   73 ++++++++++++++----------------------------------
 include/linux/ide.h     |    2 +
 4 files changed, 39 insertions(+), 77 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/10/09 1.730)
   IDE: make ide_drive_remove() call driver's ->cleanup().
   
   This was accidentally dropped before, but re-added now to completely mimic
   behavior of the reboot notifier IDE used to have. 

<mochel@osdl.org> (02/10/09 1.729)
   IDE: Add generic remove() method for drives; remove reboot notifier.
     
   The remove() method is generic for all drives, and set in ide_driver_t::gen_driver.
   The call simply forwards the call to ide_driver_t::standby(). 
   
   This obviates the need for IDE reboot notifier. The core iterates over all present
   devices in device_shutdown() and unregisters each one. 

<mochel@osdl.org> (02/10/09 1.728)
   IDE: register ide driver for all ide drives; not just for disk drives. 
     
   This adds
         struct device_driver    gen_driver;
     
   to ide_driver_t, which is filled in with necessary fields when an ide
   driver calls ide_register_driver(). That then registers the driver with
   the driver model core. 
     
   As a result, this gives us the following output in driverfs:
     
   # tree -d /sys/bus/ide/drivers/
   /sys/bus/ide/drivers/
   |-- ide-cdrom
   `-- ide-disk
     
   The suspend/resume callbacks in ide-disk.c have been temporarily
   disabled until the ide core implements generic methods which forward
   the calls to the drive drivers. 

<mochel@osdl.org> (02/10/09 1.727)
   IDE: add struct device to ide_drive_t and use that for IDE drives
   
   ... instead of the one in struct gendisk.


