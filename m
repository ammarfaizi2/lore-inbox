Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423145AbWCXFcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423145AbWCXFcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423144AbWCXFcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:32:10 -0500
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:27837 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1423145AbWCXFcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:32:05 -0500
Message-ID: <44238489.8090402@keyaccess.nl>
Date: Fri, 24 Mar 2006 06:32:57 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: bus_add_device() losing an error return from the probe() method
Content-Type: multipart/mixed;
 boundary="------------030805010100000402090303"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030805010100000402090303
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg, Takashi.

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
Is it correct?

(the printk still isn't reached, but see next message for that).

Rene.



--------------030805010100000402090303
Content-Type: text/plain;
 name="bus_add_device.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bus_add_device.diff"

Index: local/drivers/base/bus.c
===================================================================
--- local.orig/drivers/base/bus.c	2006-02-27 19:22:08.000000000 +0100
+++ local/drivers/base/bus.c	2006-03-24 04:27:02.000000000 +0100
@@ -363,19 +363,21 @@ static void device_remove_attrs(struct b
 int bus_add_device(struct device * dev)
 {
 	struct bus_type * bus = get_bus(dev->bus);
-	int error = 0;
+	int error;
 
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		device_attach(dev);
+		error = device_attach(dev);
+		if (error < 0)
+			return error;
 		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 		error = device_add_attrs(bus, dev);
-		if (!error) {
-			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
-			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
-		}
+		if (error)
+			return error;
+		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
 	}
-	return error;
+	return 0;
 }
 
 /**


--------------030805010100000402090303--
