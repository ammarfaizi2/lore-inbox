Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265089AbSJWQzP>; Wed, 23 Oct 2002 12:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSJWQzK>; Wed, 23 Oct 2002 12:55:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16259 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265089AbSJWQy0>;
	Wed, 23 Oct 2002 12:54:26 -0400
Date: Wed, 23 Oct 2002 10:03:51 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: jbradford@dial.pipex.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <tmolina@cox.net>, <erik@debill.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Problem Report Status
In-Reply-To: <200210231414.g9NEELVr004557@darkstar.example.net>
Message-ID: <Pine.LNX.4.44.0210230952311.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Oct 2002 jbradford@dial.pipex.com wrote:

> > > >                                2.5 Kernel Problem Reports as of 22 Oct
> > > >    Status                 Discussion  Problem Title
> > > >
> > > > --------------------------------------------------------------------------
> > > >    open                   17 Oct 2002 IDE not powered down on shutdown
> > > >   55. http://marc.theaimsgroup.com/?l=linux-kernel&m=103476420012508&w=2
> > > > 
> > > > --------------------------------------------------------------------------
> > > >
> > > > --------------------------------------------------------------------------
> > > >    open                   22 Oct 2002 2.5.44 fs corruption
> > > >   77. http://marc.theaimsgroup.com/?l=linux-kernel&m=103532467828806&w=2
> > > > 
> > > > --------------------------------------------------------------------------
> > > 
> > > Any possibility that the above two problems are related - I.E. disks
> > > are not being flushed properly on shutdown?
> > 
> > Possibly. I would be suprised however
> 
> Alan - have there been any changes to the flush/spindown code between
> 2.5.42 and 2.5.44?  I remember a discussion about a month ago where
> you said that it's necessary to do both, but that the order could be
> wrong.  I am seriously begining to suspect that something is
> definitely wrong, because I can actually hear the disk spindown for a
> fraction of a second, then spin up again, (at least with 2.5.43, so
> far not with 2.5.44).

It's my fault. At least the the problem about the disk not spinning down. 
The driver core code was changed in 2.5.44 to call ->shutdown() instead of 
->remove() during system power transitions, and none of the drivers got 
converted over before 2.5.44 went out. I'm really sorry about this, and I 
sincerely hope that it hasn't bitten any too bad.. 

Concerning the actual shutdown, I'm simply calling the ide driver's 
->standby() method. At least in the case of ide disks, there is a call in 
the driver's ->cleanup() method to flush the cache. Should this be 
moved to ->standby()? Or, should we call ->flushcache() for all drives 
from ->shutdown()? 

Initial patch appended.

Thanks,

	-pat

===== drivers/ide/ide.c 1.33 vs edited =====
--- 1.33/drivers/ide/ide.c	Fri Oct 18 12:44:11 2002
+++ edited/drivers/ide/ide.c	Wed Oct 23 09:42:27 2002
@@ -3351,6 +3351,14 @@
 	return 0;
 }
 
+static void ide_drive_shutdown(struct device * dev)
+{
+	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
+	ide_driver_t * drive = drive->driver;
+	if (driver && driver->standby)
+		driver->standby(drive);
+}
+
 int ide_register_driver(ide_driver_t *driver)
 {
 	struct list_head list;
@@ -3372,6 +3380,7 @@
 	driver->gen_driver.name = driver->name;
 	driver->gen_driver.bus = &ide_bus_type;
 	driver->gen_driver.remove = ide_drive_remove;
+	driver->gen_driver.shutdown = ide_drive_shutdown;
 	return driver_register(&driver->gen_driver);
 }
 


