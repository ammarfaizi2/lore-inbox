Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbTAOKoL>; Wed, 15 Jan 2003 05:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbTAOKoL>; Wed, 15 Jan 2003 05:44:11 -0500
Received: from h-64-105-35-14.SNVACAID.covad.net ([64.105.35.14]:42390 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266186AbTAOKoK>; Wed, 15 Jan 2003 05:44:10 -0500
Date: Wed, 15 Jan 2003 02:52:56 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mochel@osdl.org
Cc: tomlins@cam.org, felix-linuxkernel@fefe.de, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Patch: linux-2.5.58/drivers/base/bus.c ignored pre-existing devices
Message-ID: <20030115025256.A8250@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Patrick,

	device_attach() in linux-2.5.5[78]/drivers/base/bus.c has a
bug.  Any device that is detected before its driver is loaded is
forgotten.

	I noticed this bug when my keyboard and mouse stopped working
and thought that it might be an interrupt routing problem, but Ed
Tomlinson emailed me with a critical observation that I hadn't
noticed: if you unplug the USB devices and plug them back in, they
start to work.  Many thanks to Ed for saving me probably several hours
of bug tracking.  I suppose this is a pretty good example Eric Raymond's
mixed metaphor "given enough eyeballs, all bugs are shallow."

	It's also a good example of the benefits of parts of
drivers/base.  If this bug had only occured in the PCI hot plugging
code, it's unlikely it would have been noticed, but because the code
was common, the bug was noticed much more quickly (both my USB keyboard
and CardBus networking card were no longer binding to their devices).

	Anyhow, getting back to business, the problem arose due to a
botched change in drivers/base/bus.c that apprently was intended to
allow a driver->probe function to return an error other than -ENODEV
and thereby cause the whole binding process to abort.  At least that's
what I think the extra code was inteded to do.  If not, I could shrink
the code by making device_attach return void.

	Here is the patch.  Note that the line numbers will be off
because I have other changes in my bus.c (kmalloc and
dma_alloc_consistent preallocations for drivers that request them,
which I posted before).  Please integrate (or fix the bug some other
way) and forward to Linus.  It will avoid repititious bug reports
if we this bug is gone from Linus's last current release when he
leaves for vacaction.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bus.diff"

--- linux-2.5.58/drivers/base/bus.c	2003-01-13 21:58:25.000000000 -0800
+++ linux/drivers/base/bus.c	2003-01-15 02:09:48.000000000 -0800
@@ -283,28 +326,28 @@
  *	for each pair. If a compatible pair is found, break out and return.
  */
 static int device_attach(struct device * dev)
 {
  	struct bus_type * bus = dev->bus;
 	struct list_head * entry;
-	int error = 0;
 
 	if (dev->driver) {
 		device_bind_driver(dev);
 		return 0;
 	}
 
 	if (!bus->match)
 		return 0;
 
 	list_for_each(entry,&bus->drivers.list) {
 		struct device_driver * drv = to_drv(entry);
-		if (!(error = bus_match(dev,drv)))
-			break;
+		int error = bus_match(dev,drv);
+		if (error != 0 && error != -ENODEV)
+			return error;
 	}
-	return error;
+	return 0;
 }
 
 
 /**
  *	driver_attach - try to bind driver to devices.
  *	@drv:	driver.

--6TrnltStXW4iwmi0--
