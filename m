Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262537AbSJGTX5>; Mon, 7 Oct 2002 15:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbSJGTX4>; Mon, 7 Oct 2002 15:23:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4774 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262537AbSJGTXu>;
	Mon, 7 Oct 2002 15:23:50 -0400
Date: Mon, 7 Oct 2002 12:30:58 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: alan@lxorguk.ukuu.org.uk, <viro@math.psu.edu>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: [patch] IDE driver model update
Message-ID: <Pine.LNX.4.44.0210071220020.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey there.

This changeset and set of patches improves IDE support for the new driver
model. Instead of having each IDE driver declare and register a struct
device_driver, one is added to ide_driver_t. ide_register_driver() fills
in the necessary fields to the structure and registers it with the driver
model core.

A generic remove method is implemented, which forwards the call to the ide 
drivers. Doing this allows the drives to received the remove() call during 
device shutdown, which obviates the need for ide reboot notifier. 

The ide core also checks if the device is present before registering, so 
there should be no more "ghost drives" in the device tree. 

Diffstat and changelogs are appended. The patches will follow.

	-pat

Please pull from 

	bk://ldm.bkbits.net/linux-2.5-ide

This will update the following files:

 drivers/ide/ide-disk.c  |   16 ------------
 drivers/ide/ide-probe.c |   11 ++++++++
 drivers/ide/ide.c       |   64 +++++++++++-------------------------------------
 include/linux/ide.h     |    1 
 4 files changed, 27 insertions(+), 65 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/10/07 1.696.19.3)
   IDE: Add generic remove() method for drives; remove reboot notifier.
   
   The remove() method is generic for all drives, and set in ide_driver_t::gen_driver.
   The call simply forwards the call to ide_driver_t::standby(). 
   
   ide_drive_release() is also added, and set when the device is registered with
   the driver model core. This cleans up the drive once the last reference has gone
   away by calling ide_driver_t::cleanup().
   
   These two additions obviate the need for IDE reboot notifier, since they exploit
   the constructs of the driver model core. It has been removed.

<mochel@osdl.org> (02/10/07 1.696.19.2)
   IDE: register ide driver for all ide drives; not just for disk drives. 
   
   This adds
   	struct device_driver	gen_driver;
   
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

<mochel@osdl.org> (02/10/07 1.696.19.1)
   IDE: only register drives that are present with the driver core.



