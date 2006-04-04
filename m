Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWDDTOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWDDTOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWDDTOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:14:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:28585 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750820AbWDDTOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:14:30 -0400
Subject: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
To: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, tiwai@suse.de
From: <gregkh@suse.de>
Date: Tue, 04 Apr 2006 12:10:20 -0700
In-Reply-To: <44238489.8090402@keyaccess.nl>
Message-ID: <1FQquz-2CO-00@press.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: bus_add_device() losing an error return from the probe() method

to my gregkh-2.6 tree.  Its filename is

     bus_add_device-losing-an-error-return-from-the-probe-method.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from rene.herman@keyaccess.nl are

driver/bus_add_device-losing-an-error-return-from-the-probe-method.patch


>From rene.herman@keyaccess.nl Thu Mar 23 21:32:00 2006
Message-ID: <44238489.8090402@keyaccess.nl>
Date: Fri, 24 Mar 2006 06:32:57 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: bus_add_device() losing an error return from the probe() method

ALSA moved all ISA drivers over to the platform_driver interface in
2.6.16, using this code structure in the module_inits:

    cards = 0;
    for (i = 0; i < SNDRV_CARDS; i++) {
	  struct platform_device *device;
	  device = platform_device_register_simple(
			SND_FOO_DRIVER, i, NULL, 0);
	  if (IS_ERR(device)) {
		  err = PTR_ERR(device);
		  goto errout;
	  }
	  devices[i] = device;
	  cards++;
    }
    if (!cards) {
	  printk(KERN_ERR "FOO soundcard not found or device busy\n");
	  err = -ENODEV;
	  goto errout;
    }
    return 0;
errout:
    snd_foo_unregister_all();
    return err;

Unfortunately, the snd_foo_unregister_all() part here is unreachable
under normal circumstances, since platform_device_register_simple()
returns !IS_ERR, regardless of what the driver probe method returned.
The driver then never fails to load, even when no cards were found.

An error return from the driver probe() method is carried up through
device_attach, but is then dropped on the floor in bus_add_device(). If
I apply the attached patch, things work as I (and ALSA it seems) expect.

From: Rene Herman <rene.herman@keyaccess.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/bus.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- gregkh-2.6.orig/drivers/base/bus.c
+++ gregkh-2.6/drivers/base/bus.c
@@ -372,14 +372,17 @@ int bus_add_device(struct device * dev)
 
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		device_attach(dev);
+		error = device_attach(dev);
+		if (error < 0)
+			goto exit;
 		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 		error = device_add_attrs(bus, dev);
-		if (!error) {
-			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
-			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
-		}
+		if (error)
+			goto exit;
+		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
 	}
+exit:
 	return error;
 }
 
