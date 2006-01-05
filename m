Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWAEAuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWAEAuI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWAEAuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:5050 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750992AbWAEAt6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:58 -0500
Cc: kay.sievers@suse.de
Subject: [PATCH] driver core: replace "hotplug" by "uevent"
In-Reply-To: <11364221692333@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:29 -0800
Message-Id: <11364221692342@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: replace "hotplug" by "uevent"

Leave the overloaded "hotplug" word to susbsystems which are handling
real devices. The driver core does not "plug" anything, it just exports
the state to userspace and generates events.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 312c004d36ce6c739512bac83b452f4c20ab1f62
tree e61e8331680a0da29557fe21414d3b31e62c9293
parent 5f123fbd80f4f788554636f02bf73e40f914e0d6
author Kay Sievers <kay.sievers@suse.de> Wed, 16 Nov 2005 09:00:00 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:08 -0800

 Documentation/powerpc/eeh-pci-error-recovery.txt |   31 ++++----
 arch/powerpc/kernel/vio.c                        |    2 -
 block/genhd.c                                    |   48 ++++++------
 drivers/acpi/container.c                         |    8 +-
 drivers/acpi/processor_core.c                    |    8 +-
 drivers/acpi/scan.c                              |   14 ++--
 drivers/base/Kconfig                             |    4 +
 drivers/base/class.c                             |   68 +++++++++--------
 drivers/base/core.c                              |   42 +++++------
 drivers/base/cpu.c                               |    4 +
 drivers/base/firmware_class.c                    |   45 ++++++------
 drivers/base/memory.c                            |   12 ++-
 drivers/ieee1394/nodemgr.c                       |   20 +++--
 drivers/infiniband/core/sysfs.c                  |   16 ++--
 drivers/input/input.c                            |   14 ++--
 drivers/input/serio/serio.c                      |   22 +++---
 drivers/macintosh/macio_asic.c                   |    4 +
 drivers/mmc/mmc_sysfs.c                          |    4 +
 drivers/pci/hotplug.c                            |   44 ++++++-----
 drivers/pci/pci-driver.c                         |    6 +-
 drivers/pci/pci.h                                |    4 +
 drivers/pcmcia/cs.c                              |   10 +--
 drivers/pcmcia/ds.c                              |   50 ++++++-------
 drivers/scsi/ipr.c                               |    2 -
 drivers/usb/core/usb.c                           |   86 ++++++++++------------
 drivers/usb/host/hc_crisv10.c                    |    2 -
 drivers/w1/w1.c                                  |   14 ++--
 fs/partitions/check.c                            |    6 +-
 include/linux/device.h                           |   14 ++--
 include/linux/firmware.h                         |    2 -
 include/linux/kobject.h                          |   40 +++++-----
 include/linux/sysctl.h                           |    2 -
 include/linux/usb.h                              |    2 -
 kernel/ksysfs.c                                  |   14 ++--
 kernel/sysctl.c                                  |    4 +
 lib/kobject.c                                    |    4 +
 lib/kobject_uevent.c                             |   64 ++++++++--------
 net/bluetooth/hci_sysfs.c                        |    4 +
 net/bridge/br_sysfs_if.c                         |    4 +
 net/core/net-sysfs.c                             |    8 +-
 40 files changed, 373 insertions(+), 379 deletions(-)

diff --git a/Documentation/powerpc/eeh-pci-error-recovery.txt b/Documentation/powerpc/eeh-pci-error-recovery.txt
index e75d747..67a11a3 100644
--- a/Documentation/powerpc/eeh-pci-error-recovery.txt
+++ b/Documentation/powerpc/eeh-pci-error-recovery.txt
@@ -115,7 +115,7 @@ Current PPC64 Linux EEH Implementation
 At this time, a generic EEH recovery mechanism has been implemented,
 so that individual device drivers do not need to be modified to support
 EEH recovery.  This generic mechanism piggy-backs on the PCI hotplug
-infrastructure,  and percolates events up through the hotplug/udev
+infrastructure,  and percolates events up through the userspace/udev
 infrastructure.  Followiing is a detailed description of how this is
 accomplished.
 
@@ -172,7 +172,7 @@ A handler for the EEH notifier_block eve
 drivers/pci/hotplug/pSeries_pci.c, called handle_eeh_events().
 It saves the device BAR's and then calls rpaphp_unconfig_pci_adapter().
 This last call causes the device driver for the card to be stopped,
-which causes hotplug events to go out to user space. This triggers
+which causes uevents to go out to user space. This triggers
 user-space scripts that might issue commands such as "ifdown eth0"
 for ethernet cards, and so on.  This handler then sleeps for 5 seconds,
 hoping to give the user-space scripts enough time to complete.
@@ -258,29 +258,30 @@ rpa_php_unconfig_pci_adapter() {        
     calls
     pci_destroy_dev (struct pci_dev *) {
       calls
-      device_unregister (&dev->dev) {      // in /drivers/base/core.c
+      device_unregister (&dev->dev) {        // in /drivers/base/core.c
         calls
-        device_del(struct device * dev) {  // in /drivers/base/core.c
+        device_del(struct device * dev) {    // in /drivers/base/core.c
           calls
-          kobject_del() {                  //in /libs/kobject.c
+          kobject_del() {                    //in /libs/kobject.c
             calls
-            kobject_hotplug() {            // in /libs/kobject.c
+            kobject_uevent() {               // in /libs/kobject.c
               calls
-              kset_hotplug() {             // in /lib/kobject.c
+              kset_uevent() {                // in /lib/kobject.c
                 calls
-                kset->hotplug_ops->hotplug() which is really just
+                kset->uevent_ops->uevent()   // which is really just
                 a call to
-                dev_hotplug() {           // in /drivers/base/core.c
+                dev_uevent() {               // in /drivers/base/core.c
                   calls
-                  dev->bus->hotplug() which is really just a call to
-                  pci_hotplug () {      // in drivers/pci/hotplug.c
+                  dev->bus->uevent() which is really just a call to
+                  pci_uevent () {            // in drivers/pci/hotplug.c
                     which prints device name, etc....
                  }
                }
-               then kset_hotplug() calls
-                call_usermodehelper () with
-                   argv[0]=hotplug_path[] which is "/sbin/hotplug"
-             --> event to userspace,
+               then kobject_uevent() sends a netlink uevent to userspace
+               --> userspace uevent
+               (during early boot, nobody listens to netlink events and
+               kobject_uevent() executes uevent_helper[], which runs the
+               event process /sbin/hotplug)
            }
          }
          kobject_del() then calls sysfs_remove_dir(), which would
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 71a6add..13c4149 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -293,6 +293,6 @@ static int vio_hotplug(struct device *de
 
 struct bus_type vio_bus_type = {
 	.name = "vio",
-	.hotplug = vio_hotplug,
+	.uevent = vio_hotplug,
 	.match = vio_bus_match,
 };
diff --git a/block/genhd.c b/block/genhd.c
index f04609d..f1ed83f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -358,7 +358,7 @@ static struct sysfs_ops disk_sysfs_ops =
 static ssize_t disk_uevent_store(struct gendisk * disk,
 				 const char *buf, size_t count)
 {
-	kobject_hotplug(&disk->kobj, KOBJ_ADD);
+	kobject_uevent(&disk->kobj, KOBJ_ADD);
 	return count;
 }
 static ssize_t disk_dev_read(struct gendisk * disk, char *page)
@@ -455,14 +455,14 @@ static struct kobj_type ktype_block = {
 
 extern struct kobj_type ktype_part;
 
-static int block_hotplug_filter(struct kset *kset, struct kobject *kobj)
+static int block_uevent_filter(struct kset *kset, struct kobject *kobj)
 {
 	struct kobj_type *ktype = get_ktype(kobj);
 
 	return ((ktype == &ktype_block) || (ktype == &ktype_part));
 }
 
-static int block_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+static int block_uevent(struct kset *kset, struct kobject *kobj, char **envp,
 			 int num_envp, char *buffer, int buffer_size)
 {
 	struct kobj_type *ktype = get_ktype(kobj);
@@ -474,40 +474,40 @@ static int block_hotplug(struct kset *ks
 
 	if (ktype == &ktype_block) {
 		disk = container_of(kobj, struct gendisk, kobj);
-		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
-				    &length, "MINOR=%u", disk->first_minor);
+		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
+			       &length, "MINOR=%u", disk->first_minor);
 	} else if (ktype == &ktype_part) {
 		disk = container_of(kobj->parent, struct gendisk, kobj);
 		part = container_of(kobj, struct hd_struct, kobj);
-		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
-				    &length, "MINOR=%u",
-				    disk->first_minor + part->partno);
+		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
+			       &length, "MINOR=%u",
+			       disk->first_minor + part->partno);
 	} else
 		return 0;
 
-	add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &length,
-			    "MAJOR=%u", disk->major);
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "MAJOR=%u", disk->major);
 
 	/* add physical device, backing this device  */
 	physdev = disk->driverfs_dev;
 	if (physdev) {
 		char *path = kobject_get_path(&physdev->kobj, GFP_KERNEL);
 
-		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
-				    &length, "PHYSDEVPATH=%s", path);
+		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
+			       &length, "PHYSDEVPATH=%s", path);
 		kfree(path);
 
 		if (physdev->bus)
-			add_hotplug_env_var(envp, num_envp, &i,
-					    buffer, buffer_size, &length,
-					    "PHYSDEVBUS=%s",
-					    physdev->bus->name);
+			add_uevent_var(envp, num_envp, &i,
+				       buffer, buffer_size, &length,
+				       "PHYSDEVBUS=%s",
+				       physdev->bus->name);
 
 		if (physdev->driver)
-			add_hotplug_env_var(envp, num_envp, &i,
-					    buffer, buffer_size, &length,
-					    "PHYSDEVDRIVER=%s",
-					    physdev->driver->name);
+			add_uevent_var(envp, num_envp, &i,
+				       buffer, buffer_size, &length,
+				       "PHYSDEVDRIVER=%s",
+				       physdev->driver->name);
 	}
 
 	/* terminate, set to next free slot, shrink available space */
@@ -520,13 +520,13 @@ static int block_hotplug(struct kset *ks
 	return 0;
 }
 
-static struct kset_hotplug_ops block_hotplug_ops = {
-	.filter		= block_hotplug_filter,
-	.hotplug	= block_hotplug,
+static struct kset_uevent_ops block_uevent_ops = {
+	.filter		= block_uevent_filter,
+	.uevent		= block_uevent,
 };
 
 /* declare block_subsys. */
-static decl_subsys(block, &ktype_block, &block_hotplug_ops);
+static decl_subsys(block, &ktype_block, &block_uevent_ops);
 
 
 /*
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 27ec12c..b69a8ca 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -172,21 +172,21 @@ static void container_notify_cb(acpi_han
 			if (ACPI_FAILURE(status) || !device) {
 				result = container_device_add(&device, handle);
 				if (!result)
-					kobject_hotplug(&device->kobj,
-							KOBJ_ONLINE);
+					kobject_uevent(&device->kobj,
+						       KOBJ_ONLINE);
 				else
 					printk("Failed to add container\n");
 			}
 		} else {
 			if (ACPI_SUCCESS(status)) {
 				/* device exist and this is a remove request */
-				kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
+				kobject_uevent(&device->kobj, KOBJ_OFFLINE);
 			}
 		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		if (!acpi_bus_get_device(handle, &device) && device) {
-			kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
+			kobject_uevent(&device->kobj, KOBJ_OFFLINE);
 		}
 		break;
 	default:
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 0c561c5..1278aca 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -748,7 +748,7 @@ int acpi_processor_device_add(acpi_handl
 		return_VALUE(-ENODEV);
 
 	if ((pr->id >= 0) && (pr->id < NR_CPUS)) {
-		kobject_hotplug(&(*device)->kobj, KOBJ_ONLINE);
+		kobject_uevent(&(*device)->kobj, KOBJ_ONLINE);
 	}
 	return_VALUE(0);
 }
@@ -788,13 +788,13 @@ acpi_processor_hotplug_notify(acpi_handl
 		}
 
 		if (pr->id >= 0 && (pr->id < NR_CPUS)) {
-			kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
+			kobject_uevent(&device->kobj, KOBJ_OFFLINE);
 			break;
 		}
 
 		result = acpi_processor_start(device);
 		if ((!result) && ((pr->id >= 0) && (pr->id < NR_CPUS))) {
-			kobject_hotplug(&device->kobj, KOBJ_ONLINE);
+			kobject_uevent(&device->kobj, KOBJ_ONLINE);
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 					  "Device [%s] failed to start\n",
@@ -818,7 +818,7 @@ acpi_processor_hotplug_notify(acpi_handl
 		}
 
 		if ((pr->id < NR_CPUS) && (cpu_present(pr->id)))
-			kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
+			kobject_uevent(&device->kobj, KOBJ_OFFLINE);
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 31218e1..0745d20 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -78,7 +78,7 @@ static struct kobj_type ktype_acpi_ns = 
 	.release = acpi_device_release,
 };
 
-static int namespace_hotplug(struct kset *kset, struct kobject *kobj,
+static int namespace_uevent(struct kset *kset, struct kobject *kobj,
 			     char **envp, int num_envp, char *buffer,
 			     int buffer_size)
 {
@@ -89,8 +89,8 @@ static int namespace_hotplug(struct kset
 	if (!dev->driver)
 		return 0;
 
-	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
-				"PHYSDEVDRIVER=%s", dev->driver->name))
+	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &len,
+			   "PHYSDEVDRIVER=%s", dev->driver->name))
 		return -ENOMEM;
 
 	envp[i] = NULL;
@@ -98,8 +98,8 @@ static int namespace_hotplug(struct kset
 	return 0;
 }
 
-static struct kset_hotplug_ops namespace_hotplug_ops = {
-	.hotplug = &namespace_hotplug,
+static struct kset_uevent_ops namespace_uevent_ops = {
+	.uevent = &namespace_uevent,
 };
 
 static struct kset acpi_namespace_kset = {
@@ -108,7 +108,7 @@ static struct kset acpi_namespace_kset =
 		 },
 	.subsys = &acpi_subsys,
 	.ktype = &ktype_acpi_ns,
-	.hotplug_ops = &namespace_hotplug_ops,
+	.uevent_ops = &namespace_uevent_ops,
 };
 
 static void acpi_device_register(struct acpi_device *device,
@@ -347,7 +347,7 @@ static int acpi_bus_get_wakeup_device_fl
 }
 
 /* --------------------------------------------------------------------------
-		ACPI hotplug sysfs device file support
+		ACPI sysfs device file support
    -------------------------------------------------------------------------- */
 static ssize_t acpi_eject_store(struct acpi_device *device,
 				const char *buf, size_t count);
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 934149c..f0eff3d 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -19,11 +19,11 @@ config PREVENT_FIRMWARE_BUILD
 	  If unsure say Y here.
 
 config FW_LOADER
-	tristate "Hotplug firmware loading support"
+	tristate "Userspace firmware loading support"
 	select HOTPLUG
 	---help---
 	  This option is provided for the case where no in-kernel-tree modules
-	  require hotplug firmware loading support, but a module built outside
+	  require userspace firmware loading support, but a module built outside
 	  the kernel tree does.
 
 config DEBUG_DRIVER
diff --git a/drivers/base/class.c b/drivers/base/class.c
index db65fd0..df7fdab 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -178,7 +178,7 @@ static void class_device_create_release(
 }
 
 /* needed to allow these devices to have parent class devices */
-static int class_device_create_hotplug(struct class_device *class_dev,
+static int class_device_create_uevent(struct class_device *class_dev,
 				       char **envp, int num_envp,
 				       char *buffer, int buffer_size)
 {
@@ -331,7 +331,7 @@ static struct kobj_type ktype_class_devi
 	.release	= class_dev_release,
 };
 
-static int class_hotplug_filter(struct kset *kset, struct kobject *kobj)
+static int class_uevent_filter(struct kset *kset, struct kobject *kobj)
 {
 	struct kobj_type *ktype = get_ktype(kobj);
 
@@ -343,14 +343,14 @@ static int class_hotplug_filter(struct k
 	return 0;
 }
 
-static const char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *class_uevent_name(struct kset *kset, struct kobject *kobj)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 
 	return class_dev->class->name;
 }
 
-static int class_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+static int class_uevent(struct kset *kset, struct kobject *kobj, char **envp,
 			 int num_envp, char *buffer, int buffer_size)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
@@ -365,29 +365,29 @@ static int class_hotplug(struct kset *ks
 		struct device *dev = class_dev->dev;
 		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 
-		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
-				    &length, "PHYSDEVPATH=%s", path);
+		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
+			       &length, "PHYSDEVPATH=%s", path);
 		kfree(path);
 
 		if (dev->bus)
-			add_hotplug_env_var(envp, num_envp, &i,
-					    buffer, buffer_size, &length,
-					    "PHYSDEVBUS=%s", dev->bus->name);
+			add_uevent_var(envp, num_envp, &i,
+				       buffer, buffer_size, &length,
+				       "PHYSDEVBUS=%s", dev->bus->name);
 
 		if (dev->driver)
-			add_hotplug_env_var(envp, num_envp, &i,
-					    buffer, buffer_size, &length,
-					    "PHYSDEVDRIVER=%s", dev->driver->name);
+			add_uevent_var(envp, num_envp, &i,
+				       buffer, buffer_size, &length,
+				       "PHYSDEVDRIVER=%s", dev->driver->name);
 	}
 
 	if (MAJOR(class_dev->devt)) {
-		add_hotplug_env_var(envp, num_envp, &i,
-				    buffer, buffer_size, &length,
-				    "MAJOR=%u", MAJOR(class_dev->devt));
-
-		add_hotplug_env_var(envp, num_envp, &i,
-				    buffer, buffer_size, &length,
-				    "MINOR=%u", MINOR(class_dev->devt));
+		add_uevent_var(envp, num_envp, &i,
+			       buffer, buffer_size, &length,
+			       "MAJOR=%u", MAJOR(class_dev->devt));
+
+		add_uevent_var(envp, num_envp, &i,
+			       buffer, buffer_size, &length,
+			       "MINOR=%u", MINOR(class_dev->devt));
 	}
 
 	/* terminate, set to next free slot, shrink available space */
@@ -397,30 +397,30 @@ static int class_hotplug(struct kset *ks
 	buffer = &buffer[length];
 	buffer_size -= length;
 
-	if (class_dev->hotplug) {
+	if (class_dev->uevent) {
 		/* have the class device specific function add its stuff */
-		retval = class_dev->hotplug(class_dev, envp, num_envp,
+		retval = class_dev->uevent(class_dev, envp, num_envp,
 					    buffer, buffer_size);
 		if (retval)
-			pr_debug("class_dev->hotplug() returned %d\n", retval);
-	} else if (class_dev->class->hotplug) {
+			pr_debug("class_dev->uevent() returned %d\n", retval);
+	} else if (class_dev->class->uevent) {
 		/* have the class specific function add its stuff */
-		retval = class_dev->class->hotplug(class_dev, envp, num_envp,
+		retval = class_dev->class->uevent(class_dev, envp, num_envp,
 						   buffer, buffer_size);
 		if (retval)
-			pr_debug("class->hotplug() returned %d\n", retval);
+			pr_debug("class->uevent() returned %d\n", retval);
 	}
 
 	return retval;
 }
 
-static struct kset_hotplug_ops class_hotplug_ops = {
-	.filter =	class_hotplug_filter,
-	.name =		class_hotplug_name,
-	.hotplug =	class_hotplug,
+static struct kset_uevent_ops class_uevent_ops = {
+	.filter =	class_uevent_filter,
+	.name =		class_uevent_name,
+	.uevent =	class_uevent,
 };
 
-static decl_subsys(class_obj, &ktype_class_device, &class_hotplug_ops);
+static decl_subsys(class_obj, &ktype_class_device, &class_uevent_ops);
 
 
 static int class_device_add_attrs(struct class_device * cd)
@@ -464,7 +464,7 @@ static ssize_t show_dev(struct class_dev
 static ssize_t store_uevent(struct class_device *class_dev,
 			    const char *buf, size_t count)
 {
-	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 	return count;
 }
 
@@ -559,7 +559,7 @@ int class_device_add(struct class_device
 				  class_name);
 	}
 
-	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
 	/* notify any interfaces this device is now here */
 	if (parent_class) {
@@ -632,7 +632,7 @@ struct class_device *class_device_create
 	class_dev->class = cls;
 	class_dev->parent = parent;
 	class_dev->release = class_device_create_release;
-	class_dev->hotplug = class_device_create_hotplug;
+	class_dev->uevent = class_device_create_uevent;
 
 	va_start(args, fmt);
 	vsnprintf(class_dev->class_id, BUS_ID_SIZE, fmt, args);
@@ -674,7 +674,7 @@ void class_device_del(struct class_devic
 		class_device_remove_file(class_dev, class_dev->devt_attr);
 	class_device_remove_attrs(class_dev);
 
-	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
+	kobject_uevent(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
 
 	class_device_put(parent_device);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8615b42..fd80599 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -90,7 +90,7 @@ static struct kobj_type ktype_device = {
 };
 
 
-static int dev_hotplug_filter(struct kset *kset, struct kobject *kobj)
+static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
 {
 	struct kobj_type *ktype = get_ktype(kobj);
 
@@ -102,14 +102,14 @@ static int dev_hotplug_filter(struct kse
 	return 0;
 }
 
-static const char *dev_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *dev_uevent_name(struct kset *kset, struct kobject *kobj)
 {
 	struct device *dev = to_dev(kobj);
 
 	return dev->bus->name;
 }
 
-static int dev_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+static int dev_uevent(struct kset *kset, struct kobject *kobj, char **envp,
 			int num_envp, char *buffer, int buffer_size)
 {
 	struct device *dev = to_dev(kobj);
@@ -119,15 +119,15 @@ static int dev_hotplug(struct kset *kset
 
 	/* add bus name of physical device */
 	if (dev->bus)
-		add_hotplug_env_var(envp, num_envp, &i,
-				    buffer, buffer_size, &length,
-				    "PHYSDEVBUS=%s", dev->bus->name);
+		add_uevent_var(envp, num_envp, &i,
+			       buffer, buffer_size, &length,
+			       "PHYSDEVBUS=%s", dev->bus->name);
 
 	/* add driver name of physical device */
 	if (dev->driver)
-		add_hotplug_env_var(envp, num_envp, &i,
-				    buffer, buffer_size, &length,
-				    "PHYSDEVDRIVER=%s", dev->driver->name);
+		add_uevent_var(envp, num_envp, &i,
+			       buffer, buffer_size, &length,
+			       "PHYSDEVDRIVER=%s", dev->driver->name);
 
 	/* terminate, set to next free slot, shrink available space */
 	envp[i] = NULL;
@@ -136,11 +136,11 @@ static int dev_hotplug(struct kset *kset
 	buffer = &buffer[length];
 	buffer_size -= length;
 
-	if (dev->bus && dev->bus->hotplug) {
+	if (dev->bus && dev->bus->uevent) {
 		/* have the bus specific function add its stuff */
-		retval = dev->bus->hotplug (dev, envp, num_envp, buffer, buffer_size);
+		retval = dev->bus->uevent(dev, envp, num_envp, buffer, buffer_size);
 			if (retval) {
-			pr_debug ("%s - hotplug() returned %d\n",
+			pr_debug ("%s - uevent() returned %d\n",
 				  __FUNCTION__, retval);
 		}
 	}
@@ -148,16 +148,16 @@ static int dev_hotplug(struct kset *kset
 	return retval;
 }
 
-static struct kset_hotplug_ops device_hotplug_ops = {
-	.filter =	dev_hotplug_filter,
-	.name =		dev_hotplug_name,
-	.hotplug =	dev_hotplug,
+static struct kset_uevent_ops device_uevent_ops = {
+	.filter =	dev_uevent_filter,
+	.name =		dev_uevent_name,
+	.uevent =	dev_uevent,
 };
 
 static ssize_t store_uevent(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	kobject_hotplug(&dev->kobj, KOBJ_ADD);
+	kobject_uevent(&dev->kobj, KOBJ_ADD);
 	return count;
 }
 
@@ -165,7 +165,7 @@ static ssize_t store_uevent(struct devic
  *	device_subsys - structure to be registered with kobject core.
  */
 
-decl_subsys(devices, &ktype_device, &device_hotplug_ops);
+decl_subsys(devices, &ktype_device, &device_uevent_ops);
 
 
 /**
@@ -274,7 +274,7 @@ int device_add(struct device *dev)
 	dev->uevent_attr.store = store_uevent;
 	device_create_file(dev, &dev->uevent_attr);
 
-	kobject_hotplug(&dev->kobj, KOBJ_ADD);
+	kobject_uevent(&dev->kobj, KOBJ_ADD);
 	if ((error = device_pm_add(dev)))
 		goto PMError;
 	if ((error = bus_add_device(dev)))
@@ -291,7 +291,7 @@ int device_add(struct device *dev)
  BusError:
 	device_pm_remove(dev);
  PMError:
-	kobject_hotplug(&dev->kobj, KOBJ_REMOVE);
+	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
  Error:
 	if (parent)
@@ -374,7 +374,7 @@ void device_del(struct device * dev)
 		platform_notify_remove(dev);
 	bus_remove_device(dev);
 	device_pm_remove(dev);
-	kobject_hotplug(&dev->kobj, KOBJ_REMOVE);
+	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
 	if (parent)
 		put_device(parent);
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index a958447..281d267 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -41,14 +41,14 @@ static ssize_t store_online(struct sys_d
 	case '0':
 		ret = cpu_down(cpu->sysdev.id);
 		if (!ret)
-			kobject_hotplug(&dev->kobj, KOBJ_OFFLINE);
+			kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 		break;
 	case '1':
 		ret = smp_prepare_cpu(cpu->sysdev.id);
 		if (!ret)
 			ret = cpu_up(cpu->sysdev.id);
 		if (!ret)
-			kobject_hotplug(&dev->kobj, KOBJ_ONLINE);
+			kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 59dacb6..5b3d5e9 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -85,17 +85,17 @@ firmware_timeout_store(struct class *cla
 static CLASS_ATTR(timeout, 0644, firmware_timeout_show, firmware_timeout_store);
 
 static void  fw_class_dev_release(struct class_device *class_dev);
-int firmware_class_hotplug(struct class_device *dev, char **envp,
+int firmware_class_uevent(struct class_device *dev, char **envp,
 			   int num_envp, char *buffer, int buffer_size);
 
 static struct class firmware_class = {
 	.name		= "firmware",
-	.hotplug	= firmware_class_hotplug,
+	.uevent	= firmware_class_uevent,
 	.release	= fw_class_dev_release,
 };
 
 int
-firmware_class_hotplug(struct class_device *class_dev, char **envp,
+firmware_class_uevent(struct class_device *class_dev, char **envp,
 		       int num_envp, char *buffer, int buffer_size)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
@@ -104,13 +104,12 @@ firmware_class_hotplug(struct class_devi
 	if (!test_bit(FW_STATUS_READY, &fw_priv->status))
 		return -ENODEV;
 
-	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
-			"FIRMWARE=%s", fw_priv->fw_id))
+	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &len,
+			   "FIRMWARE=%s", fw_priv->fw_id))
 		return -ENOMEM;
-	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
-			"TIMEOUT=%i", loading_timeout))
+	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &len,
+			   "TIMEOUT=%i", loading_timeout))
 		return -ENOMEM;
-
 	envp[i] = NULL;
 
 	return 0;
@@ -352,7 +351,7 @@ error_kfree:
 
 static int
 fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
-		      const char *fw_name, struct device *device, int hotplug)
+		      const char *fw_name, struct device *device, int uevent)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
@@ -384,7 +383,7 @@ fw_setup_class_device(struct firmware *f
 		goto error_unreg;
 	}
 
-	if (hotplug)
+	if (uevent)
                 set_bit(FW_STATUS_READY, &fw_priv->status);
         else
                 set_bit(FW_STATUS_READY_NOHOTPLUG, &fw_priv->status);
@@ -399,7 +398,7 @@ out:
 
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
-		 struct device *device, int hotplug)
+		 struct device *device, int uevent)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
@@ -418,19 +417,19 @@ _request_firmware(const struct firmware 
 	}
 
 	retval = fw_setup_class_device(firmware, &class_dev, name, device,
-		hotplug);
+				       uevent);
 	if (retval)
 		goto error_kfree_fw;
 
 	fw_priv = class_get_devdata(class_dev);
 
-	if (hotplug) {
+	if (uevent) {
 		if (loading_timeout > 0) {
 			fw_priv->timeout.expires = jiffies + loading_timeout * HZ;
 			add_timer(&fw_priv->timeout);
 		}
 
-		kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+		kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 		wait_for_completion(&fw_priv->completion);
 		set_bit(FW_STATUS_DONE, &fw_priv->status);
 		del_timer_sync(&fw_priv->timeout);
@@ -456,7 +455,7 @@ out:
 }
 
 /**
- * request_firmware: - request firmware to hotplug and wait for it
+ * request_firmware: - send firmware request and wait for it
  * @firmware_p: pointer to firmware image
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
@@ -466,7 +465,7 @@ out:
  *
  *      Should be called from user context where sleeping is allowed.
  *
- *      @name will be used as $FIRMWARE in the hotplug environment and
+ *      @name will be used as $FIRMWARE in the uevent environment and
  *      should be distinctive enough not to be confused with any other
  *      firmware image for this or any other device.
  **/
@@ -474,8 +473,8 @@ int
 request_firmware(const struct firmware **firmware_p, const char *name,
                  struct device *device)
 {
-        int hotplug = 1;
-        return _request_firmware(firmware_p, name, device, hotplug);
+        int uevent = 1;
+        return _request_firmware(firmware_p, name, device, uevent);
 }
 
 /**
@@ -518,7 +517,7 @@ struct firmware_work {
 	struct device *device;
 	void *context;
 	void (*cont)(const struct firmware *fw, void *context);
-	int hotplug;
+	int uevent;
 };
 
 static int
@@ -533,7 +532,7 @@ request_firmware_work_func(void *arg)
 	}
 	daemonize("%s/%s", "firmware", fw_work->name);
 	ret = _request_firmware(&fw, fw_work->name, fw_work->device,
-		fw_work->hotplug);
+		fw_work->uevent);
 	if (ret < 0)
 		fw_work->cont(NULL, fw_work->context);
 	else {
@@ -548,7 +547,7 @@ request_firmware_work_func(void *arg)
 /**
  * request_firmware_nowait: asynchronous version of request_firmware
  * @module: module requesting the firmware
- * @hotplug: invokes hotplug event to copy the firmware image if this flag
+ * @uevent: sends uevent to copy the firmware image if this flag
  *	is non-zero else the firmware copy must be done manually.
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
@@ -562,7 +561,7 @@ request_firmware_work_func(void *arg)
  **/
 int
 request_firmware_nowait(
-	struct module *module, int hotplug,
+	struct module *module, int uevent,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
@@ -583,7 +582,7 @@ request_firmware_nowait(
 		.device = device,
 		.context = context,
 		.cont = cont,
-		.hotplug = hotplug,
+		.uevent = uevent,
 	};
 
 	ret = kernel_thread(request_firmware_work_func, fw_work,
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index bc3ca6a..7e1d077 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -29,12 +29,12 @@ static struct sysdev_class memory_sysdev
 	set_kset_name(MEMORY_CLASS_NAME),
 };
 
-static char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *memory_uevent_name(struct kset *kset, struct kobject *kobj)
 {
 	return MEMORY_CLASS_NAME;
 }
 
-static int memory_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+static int memory_uevent(struct kset *kset, struct kobject *kobj, char **envp,
 			int num_envp, char *buffer, int buffer_size)
 {
 	int retval = 0;
@@ -42,9 +42,9 @@ static int memory_hotplug(struct kset *k
 	return retval;
 }
 
-static struct kset_hotplug_ops memory_hotplug_ops = {
-	.name		= memory_hotplug_name,
-	.hotplug	= memory_hotplug,
+static struct kset_uevent_ops memory_uevent_ops = {
+	.name		= memory_uevent_name,
+	.uevent		= memory_uevent,
 };
 
 static struct notifier_block *memory_chain;
@@ -431,7 +431,7 @@ int __init memory_dev_init(void)
 	unsigned int i;
 	int ret;
 
-	memory_sysdev_class.kset.hotplug_ops = &memory_hotplug_ops;
+	memory_sysdev_class.kset.uevent_ops = &memory_uevent_ops;
 	ret = sysdev_class_register(&memory_sysdev_class);
 
 	/*
diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 0ea37b1..f245366 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -121,8 +121,8 @@ struct host_info {
 };
 
 static int nodemgr_bus_match(struct device * dev, struct device_driver * drv);
-static int nodemgr_hotplug(struct class_device *cdev, char **envp, int num_envp,
-			   char *buffer, int buffer_size);
+static int nodemgr_uevent(struct class_device *cdev, char **envp, int num_envp,
+			  char *buffer, int buffer_size);
 static void nodemgr_resume_ne(struct node_entry *ne);
 static void nodemgr_remove_ne(struct node_entry *ne);
 static struct node_entry *find_entry_by_guid(u64 guid);
@@ -162,7 +162,7 @@ static void ud_cls_release(struct class_
 static struct class nodemgr_ud_class = {
 	.name		= "ieee1394",
 	.release	= ud_cls_release,
-	.hotplug	= nodemgr_hotplug,
+	.uevent		= nodemgr_uevent,
 };
 
 static struct hpsb_highlevel nodemgr_highlevel;
@@ -966,7 +966,7 @@ static struct unit_directory *nodemgr_pr
 				if (ud_child == NULL)
 					break;
 				
-				/* inherit unspecified values so hotplug picks it up */
+				/* inherit unspecified values, the driver core picks it up */
 				if ((ud->flags & UNIT_DIRECTORY_MODEL_ID) &&
 				    !(ud_child->flags & UNIT_DIRECTORY_MODEL_ID))
 				{
@@ -1062,8 +1062,8 @@ static void nodemgr_process_root_directo
 
 #ifdef CONFIG_HOTPLUG
 
-static int nodemgr_hotplug(struct class_device *cdev, char **envp, int num_envp,
-			   char *buffer, int buffer_size)
+static int nodemgr_uevent(struct class_device *cdev, char **envp, int num_envp,
+			  char *buffer, int buffer_size)
 {
 	struct unit_directory *ud;
 	int i = 0;
@@ -1112,8 +1112,8 @@ do {								\
 
 #else
 
-static int nodemgr_hotplug(struct class_device *cdev, char **envp, int num_envp,
-			   char *buffer, int buffer_size)
+static int nodemgr_uevent(struct class_device *cdev, char **envp, int num_envp,
+			  char *buffer, int buffer_size)
 {
 	return -ENODEV;
 }
@@ -1618,8 +1618,8 @@ static int nodemgr_host_thread(void *__h
 
 		/* Scan our nodes to get the bus options and create node
 		 * entries. This does not do the sysfs stuff, since that
-		 * would trigger hotplug callbacks and such, which is a
-		 * bad idea at this point. */
+		 * would trigger uevents and such, which is a bad idea at
+		 * this point. */
 		nodemgr_node_scan(hi, generation);
 
 		/* This actually does the full probe, with sysfs
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 08648b1..1f1743c 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -434,24 +434,24 @@ static void ib_device_release(struct cla
 	kfree(dev);
 }
 
-static int ib_device_hotplug(struct class_device *cdev, char **envp,
-			     int num_envp, char *buf, int size)
+static int ib_device_uevent(struct class_device *cdev, char **envp,
+			    int num_envp, char *buf, int size)
 {
 	struct ib_device *dev = container_of(cdev, struct ib_device, class_dev);
 	int i = 0, len = 0;
 
-	if (add_hotplug_env_var(envp, num_envp, &i, buf, size, &len,
-				"NAME=%s", dev->name))
+	if (add_uevent_var(envp, num_envp, &i, buf, size, &len,
+			   "NAME=%s", dev->name))
 		return -ENOMEM;
 
 	/*
-	 * It might be nice to pass the node GUID to hotplug, but
+	 * It might be nice to pass the node GUID with the event, but
 	 * right now the only way to get it is to query the device
 	 * provider, and this can crash during device removal because
 	 * we are will be running after driver removal has started.
 	 * We could add a node_guid field to struct ib_device, or we
-	 * could just let the hotplug script read the node GUID from
-	 * sysfs when devices are added.
+	 * could just let userspace read the node GUID from sysfs when
+	 * devices are added.
 	 */
 
 	envp[i] = NULL;
@@ -653,7 +653,7 @@ static struct class_device_attribute *ib
 static struct class ib_class = {
 	.name    = "infiniband",
 	.release = ib_device_release,
-	.hotplug = ib_device_hotplug,
+	.uevent = ib_device_uevent,
 };
 
 int ib_device_register_sysfs(struct ib_device *device)
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 43b49cc..2d37b39 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -610,10 +610,10 @@ static void input_dev_release(struct cla
 }
 
 /*
- * Input hotplugging interface - loading event handlers based on
+ * Input uevent interface - loading event handlers based on
  * device bitfields.
  */
-static int input_add_hotplug_bm_var(char **envp, int num_envp, int *cur_index,
+static int input_add_uevent_bm_var(char **envp, int num_envp, int *cur_index,
 				    char *buffer, int buffer_size, int *cur_len,
 				    const char *name, unsigned long *bitmap, int max)
 {
@@ -638,7 +638,7 @@ static int input_add_hotplug_bm_var(char
 
 #define INPUT_ADD_HOTPLUG_VAR(fmt, val...)				\
 	do {								\
-		int err = add_hotplug_env_var(envp, num_envp, &i,	\
+		int err = add_uevent_var(envp, num_envp, &i,	\
 					buffer, buffer_size, &len,	\
 					fmt, val);			\
 		if (err)						\
@@ -647,15 +647,15 @@ static int input_add_hotplug_bm_var(char
 
 #define INPUT_ADD_HOTPLUG_BM_VAR(name, bm, max)				\
 	do {								\
-		int err = input_add_hotplug_bm_var(envp, num_envp, &i,	\
+		int err = input_add_uevent_bm_var(envp, num_envp, &i,	\
 					buffer, buffer_size, &len,	\
 					name, bm, max);			\
 		if (err)						\
 			return err;					\
 	} while (0)
 
-static int input_dev_hotplug(struct class_device *cdev, char **envp,
-			     int num_envp, char *buffer, int buffer_size)
+static int input_dev_uevent(struct class_device *cdev, char **envp,
+			    int num_envp, char *buffer, int buffer_size)
 {
 	struct input_dev *dev = to_input_dev(cdev);
 	int i = 0;
@@ -697,7 +697,7 @@ static int input_dev_hotplug(struct clas
 struct class input_class = {
 	.name			= "input",
 	.release		= input_dev_release,
-	.hotplug		= input_dev_hotplug,
+	.uevent			= input_dev_uevent,
 };
 
 struct input_dev *input_allocate_device(void)
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index fbb69ef..8e530cc 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -800,16 +800,16 @@ static int serio_bus_match(struct device
 
 #ifdef CONFIG_HOTPLUG
 
-#define SERIO_ADD_HOTPLUG_VAR(fmt, val...)				\
+#define SERIO_ADD_UEVENT_VAR(fmt, val...)				\
 	do {								\
-		int err = add_hotplug_env_var(envp, num_envp, &i,	\
+		int err = add_uevent_var(envp, num_envp, &i,	\
 					buffer, buffer_size, &len,	\
 					fmt, val);			\
 		if (err)						\
 			return err;					\
 	} while (0)
 
-static int serio_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
+static int serio_uevent(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
 {
 	struct serio *serio;
 	int i = 0;
@@ -820,21 +820,21 @@ static int serio_hotplug(struct device *
 
 	serio = to_serio_port(dev);
 
-	SERIO_ADD_HOTPLUG_VAR("SERIO_TYPE=%02x", serio->id.type);
-	SERIO_ADD_HOTPLUG_VAR("SERIO_PROTO=%02x", serio->id.proto);
-	SERIO_ADD_HOTPLUG_VAR("SERIO_ID=%02x", serio->id.id);
-	SERIO_ADD_HOTPLUG_VAR("SERIO_EXTRA=%02x", serio->id.extra);
-	SERIO_ADD_HOTPLUG_VAR("MODALIAS=serio:ty%02Xpr%02Xid%02Xex%02X",
+	SERIO_ADD_UEVENT_VAR("SERIO_TYPE=%02x", serio->id.type);
+	SERIO_ADD_UEVENT_VAR("SERIO_PROTO=%02x", serio->id.proto);
+	SERIO_ADD_UEVENT_VAR("SERIO_ID=%02x", serio->id.id);
+	SERIO_ADD_UEVENT_VAR("SERIO_EXTRA=%02x", serio->id.extra);
+	SERIO_ADD_UEVENT_VAR("MODALIAS=serio:ty%02Xpr%02Xid%02Xex%02X",
 				serio->id.type, serio->id.proto, serio->id.id, serio->id.extra);
 	envp[i] = NULL;
 
 	return 0;
 }
-#undef SERIO_ADD_HOTPLUG_VAR
+#undef SERIO_ADD_UEVENT_VAR
 
 #else
 
-static int serio_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
+static int serio_uevent(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
 {
 	return -ENODEV;
 }
@@ -908,7 +908,7 @@ static int __init serio_init(void)
 	serio_bus.dev_attrs = serio_device_attrs;
 	serio_bus.drv_attrs = serio_driver_attrs;
 	serio_bus.match = serio_bus_match;
-	serio_bus.hotplug = serio_hotplug;
+	serio_bus.uevent = serio_uevent;
 	serio_bus.resume = serio_resume;
 	bus_register(&serio_bus);
 
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index c34c96d..228e185 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -128,7 +128,7 @@ static int macio_device_resume(struct de
 	return 0;
 }
 
-static int macio_hotplug (struct device *dev, char **envp, int num_envp,
+static int macio_uevent(struct device *dev, char **envp, int num_envp,
                           char *buffer, int buffer_size)
 {
 	struct macio_dev * macio_dev;
@@ -203,7 +203,7 @@ extern struct device_attribute macio_dev
 struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
-       .hotplug = macio_hotplug,
+       .uevent = macio_uevent,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
        .dev_attrs = macio_dev_attrs,
diff --git a/drivers/mmc/mmc_sysfs.c b/drivers/mmc/mmc_sysfs.c
index 3f4a66c..ec70166 100644
--- a/drivers/mmc/mmc_sysfs.c
+++ b/drivers/mmc/mmc_sysfs.c
@@ -80,7 +80,7 @@ static int mmc_bus_match(struct device *
 }
 
 static int
-mmc_bus_hotplug(struct device *dev, char **envp, int num_envp, char *buf,
+mmc_bus_uevent(struct device *dev, char **envp, int num_envp, char *buf,
 		int buf_size)
 {
 	struct mmc_card *card = dev_to_mmc_card(dev);
@@ -140,7 +140,7 @@ static struct bus_type mmc_bus_type = {
 	.name		= "mmc",
 	.dev_attrs	= mmc_dev_attrs,
 	.match		= mmc_bus_match,
-	.hotplug	= mmc_bus_hotplug,
+	.uevent		= mmc_bus_uevent,
 	.suspend	= mmc_bus_suspend,
 	.resume		= mmc_bus_resume,
 };
diff --git a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
index e1743be..1c97e7d 100644
--- a/drivers/pci/hotplug.c
+++ b/drivers/pci/hotplug.c
@@ -3,8 +3,8 @@
 #include <linux/module.h>
 #include "pci.h"
 
-int pci_hotplug (struct device *dev, char **envp, int num_envp,
-		 char *buffer, int buffer_size)
+int pci_uevent(struct device *dev, char **envp, int num_envp,
+	       char *buffer, int buffer_size)
 {
 	struct pci_dev *pdev;
 	int i = 0;
@@ -17,34 +17,34 @@ int pci_hotplug (struct device *dev, cha
 	if (!pdev)
 		return -ENODEV;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"PCI_CLASS=%04X", pdev->class))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PCI_CLASS=%04X", pdev->class))
 		return -ENOMEM;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"PCI_ID=%04X:%04X", pdev->vendor, pdev->device))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PCI_ID=%04X:%04X", pdev->vendor, pdev->device))
 		return -ENOMEM;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor,
-				pdev->subsystem_device))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor,
+			   pdev->subsystem_device))
 		return -ENOMEM;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"PCI_SLOT_NAME=%s", pci_name(pdev)))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PCI_SLOT_NAME=%s", pci_name(pdev)))
 		return -ENOMEM;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x",
-				pdev->vendor, pdev->device,
-				pdev->subsystem_vendor, pdev->subsystem_device,
-				(u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
-				(u8)(pdev->class)))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x",
+			   pdev->vendor, pdev->device,
+			   pdev->subsystem_vendor, pdev->subsystem_device,
+			   (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
+			   (u8)(pdev->class)))
 		return -ENOMEM;
 
 	envp[i] = NULL;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a9046d4..7146b69 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -502,8 +502,8 @@ void pci_dev_put(struct pci_dev *dev)
 }
 
 #ifndef CONFIG_HOTPLUG
-int pci_hotplug (struct device *dev, char **envp, int num_envp,
-		 char *buffer, int buffer_size)
+int pci_uevent(struct device *dev, char **envp, int num_envp,
+	       char *buffer, int buffer_size)
 {
 	return -ENODEV;
 }
@@ -512,7 +512,7 @@ int pci_hotplug (struct device *dev, cha
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
-	.hotplug	= pci_hotplug,
+	.uevent		= pci_uevent,
 	.suspend	= pci_device_suspend,
 	.resume		= pci_device_resume,
 	.dev_attrs	= pci_dev_attrs,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6527b36..294849d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1,7 +1,7 @@
 /* Functions internal to the PCI core code */
 
-extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
-			 char *buffer, int buffer_size);
+extern int pci_uevent(struct device *dev, char **envp, int num_envp,
+		      char *buffer, int buffer_size);
 extern int pci_create_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_cleanup_rom(struct pci_dev *dev);
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index a30aa74..7cf0908 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -901,14 +901,14 @@ int pcmcia_insert_card(struct pcmcia_soc
 EXPORT_SYMBOL(pcmcia_insert_card);
 
 
-static int pcmcia_socket_hotplug(struct class_device *dev, char **envp,
-				int num_envp, char *buffer, int buffer_size)
+static int pcmcia_socket_uevent(struct class_device *dev, char **envp,
+			        int num_envp, char *buffer, int buffer_size)
 {
 	struct pcmcia_socket *s = container_of(dev, struct pcmcia_socket, dev);
 	int i = 0, length = 0;
 
-	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
-				&length, "SOCKET_NO=%u", s->sock))
+	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
+			   &length, "SOCKET_NO=%u", s->sock))
 		return -ENOMEM;
 
 	envp[i] = NULL;
@@ -927,7 +927,7 @@ static void pcmcia_release_socket_class(
 
 struct class pcmcia_socket_class = {
 	.name = "pcmcia_socket",
-        .hotplug = pcmcia_socket_hotplug,
+	.uevent = pcmcia_socket_uevent,
 	.release = pcmcia_release_socket,
 	.class_release = pcmcia_release_socket_class,
 };
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 7f8219f..6fb7639 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -779,8 +779,8 @@ static int pcmcia_bus_match(struct devic
 
 #ifdef CONFIG_HOTPLUG
 
-static int pcmcia_bus_hotplug(struct device *dev, char **envp, int num_envp,
-			      char *buffer, int buffer_size)
+static int pcmcia_bus_uevent(struct device *dev, char **envp, int num_envp,
+			     char *buffer, int buffer_size)
 {
 	struct pcmcia_device *p_dev;
 	int i, length = 0;
@@ -800,31 +800,31 @@ static int pcmcia_bus_hotplug(struct dev
 
 	i = 0;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"SOCKET_NO=%u",
-				p_dev->socket->sock))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "SOCKET_NO=%u",
+			   p_dev->socket->sock))
 		return -ENOMEM;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"DEVICE_NO=%02X",
-				p_dev->device_no))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "DEVICE_NO=%02X",
+			   p_dev->device_no))
 		return -ENOMEM;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"MODALIAS=pcmcia:m%04Xc%04Xf%02Xfn%02Xpfn%02X"
-				"pa%08Xpb%08Xpc%08Xpd%08X",
-				p_dev->has_manf_id ? p_dev->manf_id : 0,
-				p_dev->has_card_id ? p_dev->card_id : 0,
-				p_dev->has_func_id ? p_dev->func_id : 0,
-				p_dev->func,
-				p_dev->device_no,
-				hash[0],
-				hash[1],
-				hash[2],
-				hash[3]))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS=pcmcia:m%04Xc%04Xf%02Xfn%02Xpfn%02X"
+			   "pa%08Xpb%08Xpc%08Xpd%08X",
+			   p_dev->has_manf_id ? p_dev->manf_id : 0,
+			   p_dev->has_card_id ? p_dev->card_id : 0,
+			   p_dev->has_func_id ? p_dev->func_id : 0,
+			   p_dev->func,
+			   p_dev->device_no,
+			   hash[0],
+			   hash[1],
+			   hash[2],
+			   hash[3]))
 		return -ENOMEM;
 
 	envp[i] = NULL;
@@ -834,7 +834,7 @@ static int pcmcia_bus_hotplug(struct dev
 
 #else
 
-static int pcmcia_bus_hotplug(struct device *dev, char **envp, int num_envp,
+static int pcmcia_bus_uevent(struct device *dev, char **envp, int num_envp,
 			      char *buffer, int buffer_size)
 {
 	return -ENODEV;
@@ -1223,7 +1223,7 @@ static struct class_interface pcmcia_bus
 
 struct bus_type pcmcia_bus_type = {
 	.name = "pcmcia",
-	.hotplug = pcmcia_bus_hotplug,
+	.uevent = pcmcia_bus_uevent,
 	.match = pcmcia_bus_match,
 	.dev_attrs = pcmcia_dev_attrs,
 };
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index bf44a40..07ddf9a 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -2132,7 +2132,7 @@ restart:
 	}
 
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-	kobject_hotplug(&ioa_cfg->host->shost_classdev.kobj, KOBJ_CHANGE);
+	kobject_uevent(&ioa_cfg->host->shost_classdev.kobj, KOBJ_CHANGE);
 	LEAVE;
 }
 
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index e80ef94..af2f094 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -363,8 +363,7 @@ void usb_driver_release_interface(struct
  * Most USB device drivers will use this indirectly, through the usb core,
  * but some layered driver frameworks use it directly.
  * These device tables are exported with MODULE_DEVICE_TABLE, through
- * modutils and "modules.usbmap", to support the driver loading
- * functionality of USB hotplugging.
+ * modutils, to support the driver loading functionality of USB hotplugging.
  *
  * What Matches:
  *
@@ -545,10 +544,7 @@ static int usb_device_match (struct devi
 #ifdef	CONFIG_HOTPLUG
 
 /*
- * USB hotplugging invokes what /proc/sys/kernel/hotplug says
- * (normally /sbin/hotplug) when USB devices get added or removed.
- *
- * This invokes a user mode policy agent, typically helping to load driver
+ * This sends an uevent to userspace, typically helping to load driver
  * or other modules, configure the device, and more.  Drivers can provide
  * a MODULE_DEVICE_TABLE to help with module loading subtasks.
  *
@@ -557,8 +553,8 @@ static int usb_device_match (struct devi
  * delays in event delivery.  Use sysfs (and DEVPATH) to make sure the
  * device (and this configuration!) are still present.
  */
-static int usb_hotplug (struct device *dev, char **envp, int num_envp,
-			char *buffer, int buffer_size)
+static int usb_uevent(struct device *dev, char **envp, int num_envp,
+		      char *buffer, int buffer_size)
 {
 	struct usb_interface *intf;
 	struct usb_device *usb_dev;
@@ -570,7 +566,7 @@ static int usb_hotplug (struct device *d
 		return -ENODEV;
 
 	/* driver is often null here; dev_dbg() would oops */
-	pr_debug ("usb %s: hotplug\n", dev->bus_id);
+	pr_debug ("usb %s: uevent\n", dev->bus_id);
 
 	/* Must check driver_data here, as on remove driver is always NULL */
 	if ((dev->driver == &usb_generic_driver) || 
@@ -597,51 +593,51 @@ static int usb_hotplug (struct device *d
 	 *
 	 * FIXME reduce hardwired intelligence here
 	 */
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"DEVICE=/proc/bus/usb/%03d/%03d",
-				usb_dev->bus->busnum, usb_dev->devnum))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "DEVICE=/proc/bus/usb/%03d/%03d",
+			   usb_dev->bus->busnum, usb_dev->devnum))
 		return -ENOMEM;
 #endif
 
 	/* per-device configurations are common */
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"PRODUCT=%x/%x/%x",
-				le16_to_cpu(usb_dev->descriptor.idVendor),
-				le16_to_cpu(usb_dev->descriptor.idProduct),
-				le16_to_cpu(usb_dev->descriptor.bcdDevice)))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PRODUCT=%x/%x/%x",
+			   le16_to_cpu(usb_dev->descriptor.idVendor),
+			   le16_to_cpu(usb_dev->descriptor.idProduct),
+			   le16_to_cpu(usb_dev->descriptor.bcdDevice)))
 		return -ENOMEM;
 
 	/* class-based driver binding models */
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"TYPE=%d/%d/%d",
-				usb_dev->descriptor.bDeviceClass,
-				usb_dev->descriptor.bDeviceSubClass,
-				usb_dev->descriptor.bDeviceProtocol))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "TYPE=%d/%d/%d",
+			   usb_dev->descriptor.bDeviceClass,
+			   usb_dev->descriptor.bDeviceSubClass,
+			   usb_dev->descriptor.bDeviceProtocol))
 		return -ENOMEM;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"INTERFACE=%d/%d/%d",
-				alt->desc.bInterfaceClass,
-				alt->desc.bInterfaceSubClass,
-				alt->desc.bInterfaceProtocol))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "INTERFACE=%d/%d/%d",
+			   alt->desc.bInterfaceClass,
+			   alt->desc.bInterfaceSubClass,
+			   alt->desc.bInterfaceProtocol))
 		return -ENOMEM;
 
-	if (add_hotplug_env_var(envp, num_envp, &i,
-				buffer, buffer_size, &length,
-				"MODALIAS=usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic%02Xisc%02Xip%02X",
-				le16_to_cpu(usb_dev->descriptor.idVendor),
-				le16_to_cpu(usb_dev->descriptor.idProduct),
-				le16_to_cpu(usb_dev->descriptor.bcdDevice),
-				usb_dev->descriptor.bDeviceClass,
-				usb_dev->descriptor.bDeviceSubClass,
-				usb_dev->descriptor.bDeviceProtocol,
-				alt->desc.bInterfaceClass,
-				alt->desc.bInterfaceSubClass,
-				alt->desc.bInterfaceProtocol))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS=usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic%02Xisc%02Xip%02X",
+			   le16_to_cpu(usb_dev->descriptor.idVendor),
+			   le16_to_cpu(usb_dev->descriptor.idProduct),
+			   le16_to_cpu(usb_dev->descriptor.bcdDevice),
+			   usb_dev->descriptor.bDeviceClass,
+			   usb_dev->descriptor.bDeviceSubClass,
+			   usb_dev->descriptor.bDeviceProtocol,
+			   alt->desc.bInterfaceClass,
+			   alt->desc.bInterfaceSubClass,
+			   alt->desc.bInterfaceProtocol))
 		return -ENOMEM;
 
 	envp[i] = NULL;
@@ -651,7 +647,7 @@ static int usb_hotplug (struct device *d
 
 #else
 
-static int usb_hotplug (struct device *dev, char **envp,
+static int usb_uevent(struct device *dev, char **envp,
 			int num_envp, char *buffer, int buffer_size)
 {
 	return -ENODEV;
@@ -1491,7 +1487,7 @@ static int usb_generic_resume(struct dev
 struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
-	.hotplug =	usb_hotplug,
+	.uevent =	usb_uevent,
 	.suspend =	usb_generic_suspend,
 	.resume =	usb_generic_resume,
 };
diff --git a/drivers/usb/host/hc_crisv10.c b/drivers/usb/host/hc_crisv10.c
index 0eaabeb..641268d 100644
--- a/drivers/usb/host/hc_crisv10.c
+++ b/drivers/usb/host/hc_crisv10.c
@@ -4397,7 +4397,7 @@ static int __init etrax_usb_hc_init(void
         device_initialize(&fake_device);
         kobject_set_name(&fake_device.kobj, "etrax_usb");
         kobject_add(&fake_device.kobj);
-        kobject_hotplug(&fake_device.kobj, KOBJ_ADD);
+	kobject_uevent(&fake_device.kobj, KOBJ_ADD);
         hc->bus->controller = &fake_device;
 	usb_register_bus(hc->bus);
 
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 14016b1..024206c 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -142,12 +142,12 @@ static struct bin_attribute w1_slave_att
 /* Default family */
 static struct w1_family w1_default_family;
 
-static int w1_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size);
+static int w1_uevent(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size);
 
 static struct bus_type w1_bus_type = {
 	.name = "w1",
 	.match = w1_master_match,
-	.hotplug = w1_hotplug,
+	.uevent = w1_uevent,
 };
 
 struct device_driver w1_master_driver = {
@@ -361,7 +361,7 @@ void w1_destroy_master_attributes(struct
 }
 
 #ifdef CONFIG_HOTPLUG
-static int w1_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
+static int w1_uevent(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
 {
 	struct w1_master *md = NULL;
 	struct w1_slave *sl = NULL;
@@ -377,7 +377,7 @@ static int w1_hotplug(struct device *dev
 		event_owner = "slave";
 		name = sl->name;
 	} else {
-		dev_dbg(dev, "Unknown hotplug event.\n");
+		dev_dbg(dev, "Unknown event.\n");
 		return -EINVAL;
 	}
 
@@ -386,18 +386,18 @@ static int w1_hotplug(struct device *dev
 	if (dev->driver != &w1_slave_driver || !sl)
 		return 0;
 
-	err = add_hotplug_env_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_FID=%02X", sl->reg_num.family);
+	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_FID=%02X", sl->reg_num.family);
 	if (err)
 		return err;
 
-	err = add_hotplug_env_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_SLAVE_ID=%024LX", (u64)sl->reg_num.id);
+	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_SLAVE_ID=%024LX", (u64)sl->reg_num.id);
 	if (err)
 		return err;
 
 	return 0;
 };
 #else
-static int w1_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
+static int w1_uevent(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
 {
 	return 0;
 }
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 8dc1822..7187a57 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -226,7 +226,7 @@ static struct sysfs_ops part_sysfs_ops =
 static ssize_t part_uevent_store(struct hd_struct * p,
 				 const char *page, size_t count)
 {
-	kobject_hotplug(&p->kobj, KOBJ_ADD);
+	kobject_uevent(&p->kobj, KOBJ_ADD);
 	return count;
 }
 static ssize_t part_dev_read(struct hd_struct * p, char *page)
@@ -360,7 +360,7 @@ void register_disk(struct gendisk *disk)
 	if ((err = kobject_add(&disk->kobj)))
 		return;
 	disk_sysfs_symlinks(disk);
-	kobject_hotplug(&disk->kobj, KOBJ_ADD);
+	kobject_uevent(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
 	if (disk->minors == 1) {
@@ -465,6 +465,6 @@ void del_gendisk(struct gendisk *disk)
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}
-	kobject_hotplug(&disk->kobj, KOBJ_REMOVE);
+	kobject_uevent(&disk->kobj, KOBJ_REMOVE);
 	kobject_del(&disk->kobj);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 17cbc6d..0cdee78 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -47,8 +47,8 @@ struct bus_type {
 	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
-	int		(*hotplug) (struct device *dev, char **envp, 
-				    int num_envp, char *buffer, int buffer_size);
+	int		(*uevent)(struct device *dev, char **envp,
+				  int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, pm_message_t state);
 	int		(*resume)(struct device * dev);
 };
@@ -151,7 +151,7 @@ struct class {
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;
 
-	int	(*hotplug)(struct class_device *dev, char **envp, 
+	int	(*uevent)(struct class_device *dev, char **envp,
 			   int num_envp, char *buffer, int buffer_size);
 
 	void	(*release)(struct class_device *dev);
@@ -209,9 +209,9 @@ extern int class_device_create_file(stru
  * set, this will be called instead of the class specific release function.
  * Only use this if you want to override the default release function, like
  * when you are nesting class_device structures.
- * @hotplug: pointer to a hotplug function for this struct class_device.  If
- * set, this will be called instead of the class specific hotplug function.
- * Only use this if you want to override the default hotplug function, like
+ * @uevent: pointer to a uevent function for this struct class_device.  If
+ * set, this will be called instead of the class specific uevent function.
+ * Only use this if you want to override the default uevent function, like
  * when you are nesting class_device structures.
  */
 struct class_device {
@@ -227,7 +227,7 @@ struct class_device {
 	struct class_device	*parent;	/* parent of this child device, if there is one */
 
 	void	(*release)(struct class_device *dev);
-	int	(*hotplug)(struct class_device *dev, char **envp,
+	int	(*uevent)(struct class_device *dev, char **envp,
 			   int num_envp, char *buffer, int buffer_size);
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
 };
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 2063c08..2d71608 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -14,7 +14,7 @@ struct device;
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int request_firmware_nowait(
-	struct module *module, int hotplug,
+	struct module *module, int uevent,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
 
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 5b08248..8eb21f2 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -26,15 +26,14 @@
 #include <linux/kernel.h>
 #include <asm/atomic.h>
 
-#define KOBJ_NAME_LEN	20
-
-#define HOTPLUG_PATH_LEN	256
+#define KOBJ_NAME_LEN			20
+#define UEVENT_HELPER_PATH_LEN		256
 
 /* path to the userspace helper executed on an event */
-extern char hotplug_path[];
+extern char uevent_helper[];
 
-/* counter to tag the hotplug event, read only except for the kobject core */
-extern u64 hotplug_seqnum;
+/* counter to tag the uevent, read only except for the kobject core */
+extern u64 uevent_seqnum;
 
 /* the actions here must match the proper string in lib/kobject_uevent.c */
 typedef int __bitwise kobject_action_t;
@@ -101,15 +100,14 @@ struct kobj_type {
  *	of object; multiple ksets can belong to one subsystem. All 
  *	ksets of a subsystem share the subsystem's lock.
  *
- *      Each kset can support hotplugging; if it does, it will be given
- *      the opportunity to filter out specific kobjects from being
- *      reported, as well as to add its own "data" elements to the
- *      environment being passed to the hotplug helper.
+ *	Each kset can support specific event variables; it can
+ *	supress the event generation or add subsystem specific
+ *	variables carried with the event.
  */
-struct kset_hotplug_ops {
+struct kset_uevent_ops {
 	int (*filter)(struct kset *kset, struct kobject *kobj);
 	const char *(*name)(struct kset *kset, struct kobject *kobj);
-	int (*hotplug)(struct kset *kset, struct kobject *kobj, char **envp,
+	int (*uevent)(struct kset *kset, struct kobject *kobj, char **envp,
 			int num_envp, char *buffer, int buffer_size);
 };
 
@@ -119,7 +117,7 @@ struct kset {
 	struct list_head	list;
 	spinlock_t		list_lock;
 	struct kobject		kobj;
-	struct kset_hotplug_ops	* hotplug_ops;
+	struct kset_uevent_ops	* uevent_ops;
 };
 
 
@@ -167,20 +165,20 @@ struct subsystem {
 	struct rw_semaphore	rwsem;
 };
 
-#define decl_subsys(_name,_type,_hotplug_ops) \
+#define decl_subsys(_name,_type,_uevent_ops) \
 struct subsystem _name##_subsys = { \
 	.kset = { \
 		.kobj = { .name = __stringify(_name) }, \
 		.ktype = _type, \
-		.hotplug_ops =_hotplug_ops, \
+		.uevent_ops =_uevent_ops, \
 	} \
 }
-#define decl_subsys_name(_varname,_name,_type,_hotplug_ops) \
+#define decl_subsys_name(_varname,_name,_type,_uevent_ops) \
 struct subsystem _varname##_subsys = { \
 	.kset = { \
 		.kobj = { .name = __stringify(_name) }, \
 		.ktype = _type, \
-		.hotplug_ops =_hotplug_ops, \
+		.uevent_ops =_uevent_ops, \
 	} \
 }
 
@@ -256,16 +254,16 @@ extern int subsys_create_file(struct sub
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
 #ifdef CONFIG_HOTPLUG
-void kobject_hotplug(struct kobject *kobj, enum kobject_action action);
+void kobject_uevent(struct kobject *kobj, enum kobject_action action);
 
-int add_hotplug_env_var(char **envp, int num_envp, int *cur_index,
+int add_uevent_var(char **envp, int num_envp, int *cur_index,
 			char *buffer, int buffer_size, int *cur_len,
 			const char *format, ...)
 	__attribute__((format (printf, 7, 8)));
 #else
-static inline void kobject_hotplug(struct kobject *kobj, enum kobject_action action) { }
+static inline void kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
 
-static inline int add_hotplug_env_var(char **envp, int num_envp, int *cur_index, 
+static inline int add_uevent_var(char **envp, int num_envp, int *cur_index,
 				      char *buffer, int buffer_size, int *cur_len, 
 				      const char *format, ...)
 { return 0; }
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 4be34ef..5015642 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -124,7 +124,7 @@ enum
 	KERN_OVERFLOWUID=46,	/* int: overflow UID */
 	KERN_OVERFLOWGID=47,	/* int: overflow GID */
 	KERN_SHMPATH=48,	/* string: path to shm fs */
-	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
+	KERN_HOTPLUG=49,	/* string: path to uevent helper (deprecated) */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
 	KERN_S390_USER_DEBUG_LOGGING=51,  /* int: dumps of user faults */
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
diff --git a/include/linux/usb.h b/include/linux/usb.h
index d81b050..7a20997 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -225,7 +225,7 @@ struct usb_interface_cache {
  * Device drivers should not attempt to activate configurations.  The choice
  * of which configuration to install is a policy decision based on such
  * considerations as available power, functionality provided, and the user's
- * desires (expressed through hotplug scripts).  However, drivers can call
+ * desires (expressed through userspace tools).  However, drivers can call
  * usb_reset_configuration() to reinitialize the current configuration and
  * all its interfaces.
  */
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index e975a76..bfb4a7a 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -26,23 +26,23 @@ static struct subsys_attribute _name##_a
 /* current uevent sequence number */
 static ssize_t uevent_seqnum_show(struct subsystem *subsys, char *page)
 {
-	return sprintf(page, "%llu\n", (unsigned long long)hotplug_seqnum);
+	return sprintf(page, "%llu\n", (unsigned long long)uevent_seqnum);
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
 /* uevent helper program, used during early boo */
 static ssize_t uevent_helper_show(struct subsystem *subsys, char *page)
 {
-	return sprintf(page, "%s\n", hotplug_path);
+	return sprintf(page, "%s\n", uevent_helper);
 }
 static ssize_t uevent_helper_store(struct subsystem *subsys, const char *page, size_t count)
 {
-	if (count+1 > HOTPLUG_PATH_LEN)
+	if (count+1 > UEVENT_HELPER_PATH_LEN)
 		return -ENOENT;
-	memcpy(hotplug_path, page, count);
-	hotplug_path[count] = '\0';
-	if (count && hotplug_path[count-1] == '\n')
-		hotplug_path[count-1] = '\0';
+	memcpy(uevent_helper, page, count);
+	uevent_helper[count] = '\0';
+	if (count && uevent_helper[count-1] == '\n')
+		uevent_helper[count-1] = '\0';
 	return count;
 }
 KERNEL_ATTR_RW(uevent_helper);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6a51e25..345f4a1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -395,8 +395,8 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_HOTPLUG,
 		.procname	= "hotplug",
-		.data		= &hotplug_path,
-		.maxlen		= HOTPLUG_PATH_LEN,
+		.data		= &uevent_helper,
+		.maxlen		= UEVENT_HELPER_PATH_LEN,
 		.mode		= 0644,
 		.proc_handler	= &proc_dostring,
 		.strategy	= &sysctl_string,
diff --git a/lib/kobject.c b/lib/kobject.c
index a181abe..7a0e680 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -207,7 +207,7 @@ int kobject_register(struct kobject * ko
 			       kobject_name(kobj),error);
 			dump_stack();
 		} else
-			kobject_hotplug(kobj, KOBJ_ADD);
+			kobject_uevent(kobj, KOBJ_ADD);
 	} else
 		error = -EINVAL;
 	return error;
@@ -312,7 +312,7 @@ void kobject_del(struct kobject * kobj)
 void kobject_unregister(struct kobject * kobj)
 {
 	pr_debug("kobject %s: unregistering\n",kobject_name(kobj));
-	kobject_hotplug(kobj, KOBJ_REMOVE);
+	kobject_uevent(kobj, KOBJ_REMOVE);
 	kobject_del(kobj);
 	kobject_put(kobj);
 }
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index dd061da..01479e5 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -22,12 +22,12 @@
 #include <linux/kobject.h>
 #include <net/sock.h>
 
-#define BUFFER_SIZE	1024	/* buffer for the hotplug env */
+#define BUFFER_SIZE	1024	/* buffer for the variables */
 #define NUM_ENVP	32	/* number of env pointers */
 
 #if defined(CONFIG_HOTPLUG)
-char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
-u64 hotplug_seqnum;
+char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
+u64 uevent_seqnum;
 static DEFINE_SPINLOCK(sequence_lock);
 static struct sock *uevent_sock;
 
@@ -50,12 +50,12 @@ static char *action_to_string(enum kobje
 }
 
 /**
- * kobject_hotplug - notify userspace by executing /sbin/hotplug
+ * kobject_uevent - notify userspace by ending an uevent
  *
- * @action: action that is happening (usually "ADD" or "REMOVE")
+ * @action: action that is happening (usually KOBJ_ADD and KOBJ_REMOVE)
  * @kobj: struct kobject that the action is happening to
  */
-void kobject_hotplug(struct kobject *kobj, enum kobject_action action)
+void kobject_uevent(struct kobject *kobj, enum kobject_action action)
 {
 	char **envp;
 	char *buffer;
@@ -65,7 +65,7 @@ void kobject_hotplug(struct kobject *kob
 	const char *subsystem;
 	struct kobject *top_kobj;
 	struct kset *kset;
-	struct kset_hotplug_ops *hotplug_ops;
+	struct kset_uevent_ops *uevent_ops;
 	u64 seq;
 	char *seq_buff;
 	int i = 0;
@@ -88,11 +88,11 @@ void kobject_hotplug(struct kobject *kob
 		return;
 
 	kset = top_kobj->kset;
-	hotplug_ops = kset->hotplug_ops;
+	uevent_ops = kset->uevent_ops;
 
 	/*  skip the event, if the filter returns zero. */
-	if (hotplug_ops && hotplug_ops->filter)
-		if (!hotplug_ops->filter(kset, kobj))
+	if (uevent_ops && uevent_ops->filter)
+		if (!uevent_ops->filter(kset, kobj))
 			return;
 
 	/* environment index */
@@ -111,8 +111,8 @@ void kobject_hotplug(struct kobject *kob
 		goto exit;
 
 	/* originating subsystem */
-	if (hotplug_ops && hotplug_ops->name)
-		subsystem = hotplug_ops->name(kset, kobj);
+	if (uevent_ops && uevent_ops->name)
+		subsystem = uevent_ops->name(kset, kobj);
 	else
 		subsystem = kobject_name(&kset->kobj);
 
@@ -134,12 +134,12 @@ void kobject_hotplug(struct kobject *kob
 	scratch += strlen("SEQNUM=18446744073709551616") + 1;
 
 	/* let the kset specific function add its stuff */
-	if (hotplug_ops && hotplug_ops->hotplug) {
-		retval = hotplug_ops->hotplug (kset, kobj,
+	if (uevent_ops && uevent_ops->uevent) {
+		retval = uevent_ops->uevent(kset, kobj,
 				  &envp[i], NUM_ENVP - i, scratch,
 				  BUFFER_SIZE - (scratch - buffer));
 		if (retval) {
-			pr_debug ("%s - hotplug() returned %d\n",
+			pr_debug ("%s - uevent() returned %d\n",
 				  __FUNCTION__, retval);
 			goto exit;
 		}
@@ -147,7 +147,7 @@ void kobject_hotplug(struct kobject *kob
 
 	/* we will send an event, request a new sequence number */
 	spin_lock(&sequence_lock);
-	seq = ++hotplug_seqnum;
+	seq = ++uevent_seqnum;
 	spin_unlock(&sequence_lock);
 	sprintf(seq_buff, "SEQNUM=%llu", (unsigned long long)seq);
 
@@ -177,10 +177,10 @@ void kobject_hotplug(struct kobject *kob
 	}
 
 	/* call uevent_helper, usually only enabled during early boot */
-	if (hotplug_path[0]) {
+	if (uevent_helper[0]) {
 		char *argv [3];
 
-		argv [0] = hotplug_path;
+		argv [0] = uevent_helper;
 		argv [1] = (char *)subsystem;
 		argv [2] = NULL;
 		call_usermodehelper (argv[0], argv, envp, 0);
@@ -192,39 +192,39 @@ exit:
 	kfree(envp);
 	return;
 }
-EXPORT_SYMBOL(kobject_hotplug);
+EXPORT_SYMBOL_GPL(kobject_uevent);
 
 /**
- * add_hotplug_env_var - helper for creating hotplug environment variables
+ * add_uevent_var - helper for creating event variables
  * @envp: Pointer to table of environment variables, as passed into
- * hotplug() method.
+ * uevent() method.
  * @num_envp: Number of environment variable slots available, as
- * passed into hotplug() method.
+ * passed into uevent() method.
  * @cur_index: Pointer to current index into @envp.  It should be
- * initialized to 0 before the first call to add_hotplug_env_var(),
+ * initialized to 0 before the first call to add_uevent_var(),
  * and will be incremented on success.
  * @buffer: Pointer to buffer for environment variables, as passed
- * into hotplug() method.
- * @buffer_size: Length of @buffer, as passed into hotplug() method.
+ * into uevent() method.
+ * @buffer_size: Length of @buffer, as passed into uevent() method.
  * @cur_len: Pointer to current length of space used in @buffer.
  * Should be initialized to 0 before the first call to
- * add_hotplug_env_var(), and will be incremented on success.
+ * add_uevent_var(), and will be incremented on success.
  * @format: Format for creating environment variable (of the form
  * "XXX=%x") for snprintf().
  *
  * Returns 0 if environment variable was added successfully or -ENOMEM
  * if no space was available.
  */
-int add_hotplug_env_var(char **envp, int num_envp, int *cur_index,
-			char *buffer, int buffer_size, int *cur_len,
-			const char *format, ...)
+int add_uevent_var(char **envp, int num_envp, int *cur_index,
+		   char *buffer, int buffer_size, int *cur_len,
+		   const char *format, ...)
 {
 	va_list args;
 
 	/*
 	 * We check against num_envp - 1 to make sure there is at
-	 * least one slot left after we return, since the hotplug
-	 * method needs to set the last slot to NULL.
+	 * least one slot left after we return, since kobject_uevent()
+	 * needs to set the last slot to NULL.
 	 */
 	if (*cur_index >= num_envp - 1)
 		return -ENOMEM;
@@ -243,7 +243,7 @@ int add_hotplug_env_var(char **envp, int
 	(*cur_index)++;
 	return 0;
 }
-EXPORT_SYMBOL(add_hotplug_env_var);
+EXPORT_SYMBOL_GPL(add_uevent_var);
 
 static int __init kobject_uevent_init(void)
 {
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index bd7568a..0ed3874 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -78,7 +78,7 @@ static struct class_device_attribute *bt
 };
 
 #ifdef CONFIG_HOTPLUG
-static int bt_hotplug(struct class_device *cdev, char **envp, int num_envp, char *buf, int size)
+static int bt_uevent(struct class_device *cdev, char **envp, int num_envp, char *buf, int size)
 {
 	struct hci_dev *hdev = class_get_devdata(cdev);
 	int n, i = 0;
@@ -107,7 +107,7 @@ struct class bt_class = {
 	.name		= "bluetooth",
 	.release	= bt_release,
 #ifdef CONFIG_HOTPLUG
-	.hotplug	= bt_hotplug,
+	.uevent		= bt_uevent,
 #endif
 };
 
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index f6a19d5..2ebdc23 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -248,7 +248,7 @@ int br_sysfs_addif(struct net_bridge_por
 	if (err)
 		goto out2;
 
-	kobject_hotplug(&p->kobj, KOBJ_ADD);
+	kobject_uevent(&p->kobj, KOBJ_ADD);
 	return 0;
  out2:
 	kobject_del(&p->kobj);
@@ -260,7 +260,7 @@ void br_sysfs_removeif(struct net_bridge
 {
 	pr_debug("br_sysfs_removeif\n");
 	sysfs_remove_link(&p->br->ifobj, p->dev->name);
-	kobject_hotplug(&p->kobj, KOBJ_REMOVE);
+	kobject_uevent(&p->kobj, KOBJ_REMOVE);
 	kobject_del(&p->kobj);
 }
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e2137f3..198655d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -369,14 +369,14 @@ static struct attribute_group wireless_g
 #endif
 
 #ifdef CONFIG_HOTPLUG
-static int netdev_hotplug(struct class_device *cd, char **envp,
-			  int num_envp, char *buf, int size)
+static int netdev_uevent(struct class_device *cd, char **envp,
+			 int num_envp, char *buf, int size)
 {
 	struct net_device *dev = to_net_dev(cd);
 	int i = 0;
 	int n;
 
-	/* pass interface in env to hotplug. */
+	/* pass interface to uevent. */
 	envp[i++] = buf;
 	n = snprintf(buf, size, "INTERFACE=%s", dev->name) + 1;
 	buf += n;
@@ -408,7 +408,7 @@ static struct class net_class = {
 	.name = "net",
 	.release = netdev_release,
 #ifdef CONFIG_HOTPLUG
-	.hotplug = netdev_hotplug,
+	.uevent = netdev_uevent,
 #endif
 };
 

