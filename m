Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317014AbSFFRAZ>; Thu, 6 Jun 2002 13:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317016AbSFFRAZ>; Thu, 6 Jun 2002 13:00:25 -0400
Received: from air-2.osdl.org ([65.201.151.6]:13452 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317014AbSFFRAX>;
	Thu, 6 Jun 2002 13:00:23 -0400
Date: Thu, 6 Jun 2002 09:56:13 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: device model update 2/2
In-Reply-To: <ado3j5$304$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0206060949280.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Jun 2002, Linus Torvalds wrote:

> In article <Pine.LNX.4.33.0206060808050.654-100000@geena.pdx.osdl.net>,
> Patrick Mochel  <mochel@osdl.org> wrote:
> >-
> > 		/* detach from driver */
> > 		if (dev->driver->remove)
> > 			dev->driver->remove(dev);
> > 		put_driver(dev->driver);
> >+
> >+		lock_device(dev);
> >+		dev->driver = NULL;
> >+		unlock_device(dev);
> 
> Code like the above just basically can _never_ be correct.
> 
> The locking just doesn't make any sense like that. 
> 
> Real locking looks something like this:
> 
> 	lock_device(dev);
> 	driver = dev->driver;
> 	dev->driver = NULL;
> 	unlock_device(dev);
> 
> 	if (driver->remove)
> 		driver->remove(dev);
> 	put_driver(driver);
> 
> together with some promise that "dev" cannot go away from under us (ie a
> refcount on "dev" itself).

The device is already going away; the refcount has hit 0 and we're 
detaching it from the driver. 

Incremental patch below; also in bk://ldm.bkbits.net/linux-2.5

	-pat

ChangeSet@1.457, 2002-06-06 09:50:30-07:00, mochel@osdl.org
  device detach locking, one more time: get driver and reset it in struct device before calling remove()

 drivers/base/core.c |   21 ++++++++++++---------
 1 files changed, 12 insertions, 9 deletions


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Thu Jun  6 09:52:43 2002
+++ b/drivers/base/core.c	Thu Jun  6 09:52:43 2002
@@ -98,19 +98,22 @@
 
 static void device_detach(struct device * dev)
 {
-	if (dev->driver) {
-		write_lock(&dev->driver->lock);
-		list_del_init(&dev->driver_list);
-		write_unlock(&dev->driver->lock);
-
-		/* detach from driver */
-		if (dev->driver->remove)
-			dev->driver->remove(dev);
-		put_driver(dev->driver);
+	struct device_driver * drv; 
 
+	if (dev->driver) {
 		lock_device(dev);
+		drv = dev->driver;
 		dev->driver = NULL;
 		unlock_device(dev);
+
+		write_lock(&drv->lock);
+		list_del_init(&dev->driver_list);
+		write_unlock(&drv->lock);
+
+		/* detach from driver */
+		if (drv->remove)
+			drv->remove(dev);
+		put_driver(drv);
 	}
 }
 


