Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWJEVD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWJEVD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWJEVD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:03:26 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:10250 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750724AbWJEVDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:03:25 -0400
Date: Thu, 5 Oct 2006 17:03:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <gregkh@suse.de>
cc: Jaroslav Kysela <perex@suse.cz>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>, Takashi Iwai <tiwai@suse.de>,
       LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Driver core: Don't ignore error returns from probing
In-Reply-To: <20061005175852.GC15180@suse.de>
Message-ID: <Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as797) fixes device_add() in the driver core.  It needs to
pay attention when the driver for a new device reports an error.

At the same time, since bus_remove_device() undoes the effects of both
bus_add_device() and bus_attach_device(), it needs to check whether
the bus_attach_device step failed.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Thu, 5 Oct 2006, Greg KH wrote:

> Great, Alan, care to resend with a better description and the proper
> signed-off-by lines?

Here it is.  Mind you, I still haven't tested it.  And the way the code
was written originally makes me wonder if the probe error wasn't
deliberately ignored.  Although if it was deliberate, there ought to have
been a comment explaining things.

Anyway, the change to bus.c is exactly the same as Jaroslav's patch, and
it is obviously correct.


Index: 18g20/drivers/base/bus.c
===================================================================
--- 18g20.orig/drivers/base/bus.c
+++ 18g20/drivers/base/bus.c
@@ -453,8 +453,10 @@ void bus_remove_device(struct device * d
 		remove_deprecated_bus_links(dev);
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
-		dev->is_registered = 0;
-		klist_del(&dev->knode_bus);
+		if (dev->is_registered) {
+			dev->is_registered = 0;
+			klist_del(&dev->knode_bus);
+		}
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		put_bus(dev->bus);
Index: 18g20/drivers/base/core.c
===================================================================
--- 18g20.orig/drivers/base/core.c
+++ 18g20/drivers/base/core.c
@@ -485,7 +485,8 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	bus_attach_device(dev);
+	if ((error = bus_attach_device(dev)))
+		goto AttachError;
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -504,6 +505,8 @@ int device_add(struct device *dev)
  	kfree(class_name);
 	put_device(dev);
 	return error;
+ AttachError:
+	bus_remove_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:


