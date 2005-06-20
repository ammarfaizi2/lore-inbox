Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVFUC7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVFUC7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFUC6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:58:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:9700 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261662AbVFTW7g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:36 -0400
Cc: david-b@pacbell.net
Subject: [PATCH] Driver Core: driver model doc update
In-Reply-To: <11193083672789@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <11193083671865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: driver model doc update

This updates some driver data documentation:

 - removes references to some fields that haven't been there for a
   long time now, e.g. pre-kobject or even older;

 - giving more information about the probe() method;

 - adding an example of how platform_data is used

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4109aca06cb7b042ea791d0f9d3c9615bc3bf5cd
tree 36312d5fe016d507ec0682de914e1ac6b66c3246
parent 4b45099b75832434c5113b9aed1499f8a69d13d5
author David Brownell <david-b@pacbell.net> Mon, 16 May 2005 17:19:55 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:29 -0700

 Documentation/driver-model/device.txt |    8 +++++
 Documentation/driver-model/driver.txt |   51 ++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/Documentation/driver-model/device.txt b/Documentation/driver-model/device.txt
--- a/Documentation/driver-model/device.txt
+++ b/Documentation/driver-model/device.txt
@@ -76,6 +76,14 @@ driver_data:   Driver-specific data.
 
 platform_data: Platform data specific to the device.
 
+	       Example:  for devices on custom boards, as typical of embedded
+	       and SOC based hardware, Linux often uses platform_data to point
+	       to board-specific structures describing devices and how they
+	       are wired.  That can include what ports are available, chip
+	       variants, which GPIO pins act in what additional roles, and so
+	       on.  This shrinks the "Board Support Packages" (BSPs) and
+	       minimizes board-specific #ifdefs in drivers.
+
 current_state: Current power state of the device.
 
 saved_state:   Pointer to saved state of the device. This is usable by
diff --git a/Documentation/driver-model/driver.txt b/Documentation/driver-model/driver.txt
--- a/Documentation/driver-model/driver.txt
+++ b/Documentation/driver-model/driver.txt
@@ -5,21 +5,17 @@ struct device_driver {
         char                    * name;
         struct bus_type         * bus;
 
-        rwlock_t                lock;
-        atomic_t                refcount;
-
-        list_t                  bus_list;
+        struct completion	unloaded;
+        struct kobject		kobj;
         list_t                  devices;
 
-        struct driver_dir_entry dir;
+        struct module		*owner;
 
         int     (*probe)        (struct device * dev);
         int     (*remove)       (struct device * dev);
 
         int     (*suspend)      (struct device * dev, pm_message_t state, u32 level);
         int     (*resume)       (struct device * dev, u32 level);
-
-        void    (*release)      (struct device_driver * drv);
 };
 
 
@@ -51,7 +47,6 @@ being converted completely to the new mo
 static struct device_driver eepro100_driver = {
        .name		= "eepro100",
        .bus		= &pci_bus_type,
-       .devclass	= &ethernet_devclass,	/* when it's implemented */
        
        .probe		= eepro100_probe,
        .remove		= eepro100_remove,
@@ -85,7 +80,6 @@ static struct pci_driver eepro100_driver
        .driver	       = {
 		.name		= "eepro100",
 		.bus		= &pci_bus_type,
-		.devclass	= &ethernet_devclass,	/* when it's implemented */
 		.probe		= eepro100_probe,
 		.remove		= eepro100_remove,
 		.suspend	= eepro100_suspend,
@@ -166,27 +160,32 @@ Callbacks
 
 	int	(*probe)	(struct device * dev);
 
-probe is called to verify the existence of a certain type of
-hardware. This is called during the driver binding process, after the
-bus has verified that the device ID of a device matches one of the
-device IDs supported by the driver. 
-
-This callback only verifies that there actually is supported hardware
-present. It may allocate a driver-specific structure, but it should
-not do any initialization of the hardware itself. The device-specific
-structure may be stored in the device's driver_data field. 
-
-	int	(*init)		(struct device * dev);
-
-init is called during the binding stage. It is called after probe has
-successfully returned and the device has been registered with its
-class. It is responsible for initializing the hardware.
+The probe() entry is called in task context, with the bus's rwsem locked
+and the driver partially bound to the device.  Drivers commonly use
+container_of() to convert "dev" to a bus-specific type, both in probe()
+and other routines.  That type often provides device resource data, such
+as pci_dev.resource[] or platform_device.resources, which is used in
+addition to dev->platform_data to initialize the driver.
+
+This callback holds the driver-specific logic to bind the driver to a
+given device.  That includes verifying that the device is present, that
+it's a version the driver can handle, that driver data structures can
+be allocated and initialized, and that any hardware can be initialized.
+Drivers often store a pointer to their state with dev_set_drvdata().
+When the driver has successfully bound itself to that device, then probe()
+returns zero and the driver model code will finish its part of binding
+the driver to that device.
+
+A driver's probe() may return a negative errno value to indicate that
+the driver did not bind to this device, in which case it should have
+released all reasources it allocated.
 
 	int 	(*remove)	(struct device * dev);
 
-remove is called to dissociate a driver with a device. This may be
+remove is called to unbind a driver from a device. This may be
 called if a device is physically removed from the system, if the
-driver module is being unloaded, or during a reboot sequence. 
+driver module is being unloaded, during a reboot sequence, or
+in other cases.
 
 It is up to the driver to determine if the device is present or
 not. It should free any resources allocated specifically for the

