Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSJIAtG>; Tue, 8 Oct 2002 20:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJIAtG>; Tue, 8 Oct 2002 20:49:06 -0400
Received: from air-2.osdl.org ([65.172.181.6]:39340 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261721AbSJIAtE>;
	Tue, 8 Oct 2002 20:49:04 -0400
Date: Tue, 8 Oct 2002 17:57:11 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [bk/patch] driver model update: device_unregister()
Message-ID: <Pine.LNX.4.44.0210081747180.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Without further ado, here is device_unregister(), and a fixup of the IDE 
and USB code that use it.  Description below.

Please apply. (bkbits is taking a really long time, so it might take a few 
to actually show up).

	-pat

Please pull from 

	bk://ldm.bkbits.net/linux-2.5-core

This will update the following files:

 drivers/base/core.c      |   38 +++++++++++++++++++++++++++++++-------
 drivers/base/fs/device.c |    3 +--
 drivers/ide/ide-disk.c   |    2 +-
 drivers/usb/core/usb.c   |    4 ++--
 include/linux/device.h   |    3 ++-
 5 files changed, 37 insertions(+), 13 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/10/08 1.601)
   USB: call device_unregister() instead of put_device() when removing devices.

<mochel@osdl.org> (02/10/08 1.600)
   IDE: call device_unregister() instead of put_device() in ide-disk->cleanup().

<mochel@osdl.org> (02/10/08 1.599)
   driver model: check return of get_device() when creating a driverfs file.

<mochel@osdl.org> (02/10/08 1.598)
   driver model: and present field to struct device and implement device_unregister().
   
   device_unregister() is intended to be the complement of device_register(), and assumes
   most of the functionality of the current put_device(). It should be called by the bus 
   driver when a device is physically removed from the system. 
   
   It should _not_ be called from a driver's remove() method, as that remove() method is called
   via device_detach() in device_unregister(). 
   
   dev->present is used to flag the physical presence of the device. It is set when the device
   is registered, and cleared when unregistered. get_device() checks this flag, and returns
   a NULL pointer if cleared. This prevents anyone from obtaining a reference to a device
   that has been unregistered (removed), but not yet been freed (e.g. if someone else is 
   holding a reference to it).
   
   put_device() BUG()s if dev->present is set. A device should be unregistered before it is 
   freed. This will catch people doing it in the wrong order. 




