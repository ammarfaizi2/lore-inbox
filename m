Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTCEOMg>; Wed, 5 Mar 2003 09:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTCEOMg>; Wed, 5 Mar 2003 09:12:36 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:13581 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S266755AbTCEOMa>; Wed, 5 Mar 2003 09:12:30 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] EISA/sysfs update
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 05 Mar 2003 15:22:07 +0100
Message-ID: <wrp3cm1uc4w.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

LKML, Linus,

Here is the latest round of EISA/sysfs update.

>From the changelog :

# EISA/sysfs update :
# Add documentation,
# Add support for per EISA-id driver data,
# Move virtual_root device to a plateform device,
# Update CREDITS.

Thanks a lot,

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=eisa-sysfs-update.patch
Content-Description: EISA/sysfs update

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1037  -> 1.1038 
#	drivers/eisa/eisa-bus.c	1.5     -> 1.6    
#	             CREDITS	1.77    -> 1.78   
#	drivers/eisa/virtual_root.c	1.1     -> 1.2    
#	include/linux/eisa.h	1.3     -> 1.4    
#	               (new)	        -> 1.1     Documentation/eisa.txt
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/05	maz@hina.wild-wind.fr.eu.org	1.1038
# EISA/sysfs update :
# Add documentation,
# Add support for per EISA-id driver data,
# Move virtual_root device to a plateform device,
# Update CREDITS.
# --------------------------------------------
#
diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Wed Mar  5 15:11:17 2003
+++ b/CREDITS	Wed Mar  5 15:11:17 2003
@@ -3492,9 +3492,9 @@
 
 N: Marc Zyngier
 E: maz@wild-wind.fr.eu.org
+W: http://www.misterjones.org
 D: MD driver
-S: 11 rue Victor HUGO
-S: 95560 Montsoult
+D: EISA/sysfs subsystem
 S: France
 
 # Don't add your name here, unless you really _are_ after Marc
diff -Nru a/Documentation/eisa.txt b/Documentation/eisa.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/eisa.txt	Wed Mar  5 15:11:17 2003
@@ -0,0 +1,164 @@
+EISA bus support (Marc Zyngier <maz@wild-wind.fr.eu.org>)
+
+This document groups random notes about porting EISA drivers to the
+new EISA/sysfs API.
+
+Starting from version 2.5.59, the EISA bus is almost given the same
+status as other much more mainstream busses such as PCI or USB. This
+has been possible through sysfs, which defines a nice enough set of
+abstractions to manage busses, devices and drivers.
+
+Although the new API is quite simple to use, converting existing
+drivers to the new infrastructure is not an easy task (mostly because
+detection code is generally also used to probe ISA cards). Moreover,
+most EISA drivers are among the oldest Linux drivers so, as you can
+imagine, some dust has settled here over the years.
+
+The EISA infrastructure is made up of three parts :
+
+    - The bus code implements most of the generic code. It is shared
+    among all the architectures that the EISA code runs on. It
+    implements bus probing (detecting EISA cards avaible on the bus),
+    allocates I/O resources, allows fancy naming through sysfs, and
+    offers interfaces for driver to register.
+
+    - The bus root driver implements the glue between the bus hardware
+    and the generic bus code. It is responsible for discovering the
+    device implementing the bus, and setting it up to be latter probed
+    by the bus code. This can go from something as simple as reserving
+    an I/O region on x86, to the rather more complex, like the hppa
+    EISA code. This is the part to implement in order to have EISA
+    running on an "new" platform.
+
+    - The driver offers the bus a list of devices that it manages, and
+    implements the necessary callbacks to probe and release devices
+    whenever told to.
+
+Every function/structure below lives in <linux/eisa.h>, which depends
+heavily on <linux/device.h>.
+
+** Bus root driver :
+
+int eisa_root_register (struct eisa_root_device *root);
+
+The eisa_root_register function is used to declare a device as the
+root of an EISA bus. The eisa_root_device structure holds a reference
+to this device, as well as some parameters for probing purposes.
+
+struct eisa_root_device {
+        struct list_head node;
+        struct device   *dev;    /* Pointer to bridge device */
+        struct resource *res;
+        unsigned long    bus_base_addr;
+        int              slots;  /* Max slot number */
+        int              bus_nr; /* Set by eisa_root_register */
+};
+
+node          : used for eisa_root_register internal purpose
+dev           : pointer to the root device
+res           : root device I/O resource
+bus_base_addr : slot 0 address on this bus
+slots	      : max slot number to probe
+bus_nr	      : unique bus id, set by eisa_root_register
+
+** Driver :
+
+int eisa_driver_register (struct eisa_driver *edrv);
+void eisa_driver_unregister (struct eisa_driver *edrv);
+
+Clear enough ?
+
+struct eisa_device_id {
+        char sig[EISA_SIG_LEN];
+	unsigned long driver_data;
+};
+
+struct eisa_driver {
+        const struct eisa_device_id *id_table;
+        struct device_driver         driver;
+};
+
+id_table	: an array of NULL terminated EISA id strings,
+		  followed by an empty string. Each string can be
+		  paired with a driver-dependant value (driver_data).
+
+driver		: a generic driver, such as described in
+		  Documentation/driver-model/driver.txt. Only .name,
+		  .probe and .remove members are mandatory.
+
+An example is the 3c509 driver :
+
+struct eisa_device_id el3_eisa_ids[] = {
+        { "TCM5092" },
+        { "TCM5093" },
+        { "" }
+};
+
+struct eisa_driver el3_eisa_driver = {
+        .id_table = el3_eisa_ids,
+        .driver   = {
+                .name    = "3c509",
+                .probe   = el3_eisa_probe,
+                .remove  = __devexit_p (el3_device_remove)
+        }
+};
+
+** Device :
+
+The sysfs framework calls .probe and .remove functions upon device
+discovery and removal (note that the .remove function is only called
+when driver is built as a module).
+
+Both functions are passed a pointer to a 'struct device', which is
+encapsulated in a 'struct eisa_device' described as follows :
+
+struct eisa_device {
+        struct eisa_device_id id;
+        int                   slot;
+        unsigned long         base_addr;
+        struct resource       res;
+        struct device         dev; /* generic device */
+};
+
+id	: EISA id, as read from device. id.driver_data is set from the
+	  matching driver EISA id.
+slot	: slot number which the device was detected on
+res	: I/O resource allocated to this device
+dev	: generic device (see Documentation/driver-model/device.txt)
+
+You can get the 'struct eisa_device' from 'struct device' using the
+'to_eisa_device' macro.
+
+** Misc stuff :
+
+void eisa_set_drvdata (struct eisa_device *edev, void *data);
+
+Stores data into the device's driver_data area.
+
+void *eisa_get_drvdata (struct eisa_device *edev):
+
+Gets the pointer previously stored into the device's driver_data area.
+
+** Random notes :
+
+Converting an EISA driver to the new API mostly involves *deleting*
+code (since probing is now in the core EISA code). Unfortunately, most
+drivers share their probing routine between ISA, MCA and EISA. Special
+care must be taken when ripping out the EISA code, so other busses
+won't suffer from these surgical strikes...
+
+You *must not* expect any EISA device to be detected when returning
+from eisa_driver_register, since the chances are that the bus has not
+yet been probed. In fact, that's what happens most of the time (the
+bus root driver usually kicks in rather late in the boot process).
+Unfortunately, most drivers are doing the probing by themselves, and
+expect to have explored the whole machine when they exit their probe
+routine.
+
+** Thanks :
+
+I'd like to thank the following people for their help :
+- Xavier Benigni for lending me a wonderful Alpha Jensen,
+- James Bottomley, Jeff Garzik for getting this stuff into the kernel,
+- Andries Brouwer for contributing numerous EISA ids,
+- Catrin Jones for coping with too many machines at home
diff -Nru a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
--- a/drivers/eisa/eisa-bus.c	Wed Mar  5 15:11:17 2003
+++ b/drivers/eisa/eisa-bus.c	Wed Mar  5 15:11:17 2003
@@ -83,8 +83,10 @@
 		return 0;
 
 	while (strlen (eids->sig)) {
-		if (!strcmp (eids->sig, edev->id.sig))
+		if (!strcmp (eids->sig, edev->id.sig)) {
+			edev->id.driver_data = eids->driver_data;
 			return 1;
+		}
 
 		eids++;
 	}
diff -Nru a/drivers/eisa/virtual_root.c b/drivers/eisa/virtual_root.c
--- a/drivers/eisa/virtual_root.c	Wed Mar  5 15:11:17 2003
+++ b/drivers/eisa/virtual_root.c	Wed Mar  5 15:11:17 2003
@@ -13,14 +13,19 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-/* The default EISA device parent (virtual root device). */
-static struct device eisa_root_dev = {
-       .name        = "Virtual EISA Bridge",
-       .bus_id      = "eisa",
+/* The default EISA device parent (virtual root device).
+ * Now use a platform device, since that's the obvious choice. */
+
+static struct platform_device eisa_root_dev = {
+	.name = "eisa",
+	.id   = 0,
+	.dev  = {
+		.name = "Virtual EISA Bridge",
+	},
 };
 
 static struct eisa_root_device eisa_bus_root = {
-	.dev           = &eisa_root_dev,
+	.dev           = &eisa_root_dev.dev,
 	.bus_base_addr = 0,
 	.res	       = &ioport_resource,
 	.slots	       = EISA_MAX_SLOTS,
@@ -30,16 +35,16 @@
 {
 	int r;
 	
-        if ((r = device_register (&eisa_root_dev))) {
+        if ((r = platform_device_register (&eisa_root_dev))) {
                 return r;
         }
 
-	eisa_root_dev.driver_data = &eisa_bus_root;
+	eisa_root_dev.dev.driver_data = &eisa_bus_root;
 
 	if (eisa_root_register (&eisa_bus_root)) {
 		/* A real bridge may have been registered before
 		 * us. So quietly unregister. */
-		device_unregister (&eisa_root_dev);
+		platform_device_unregister (&eisa_root_dev);
 		return -1;
 	}
 
diff -Nru a/include/linux/eisa.h b/include/linux/eisa.h
--- a/include/linux/eisa.h	Wed Mar  5 15:11:17 2003
+++ b/include/linux/eisa.h	Wed Mar  5 15:11:17 2003
@@ -20,7 +20,8 @@
 
 /* The EISA signature, in ASCII form, null terminated */
 struct eisa_device_id {
-	char sig[EISA_SIG_LEN];
+	char          sig[EISA_SIG_LEN];
+	unsigned long driver_data;
 };
 
 /* There is not much we can say about an EISA device, apart from

--=-=-=

-- 
Places change, faces change. Life is so very strange.

--=-=-=--
