Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVH3K4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVH3K4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 06:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVH3K4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 06:56:45 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:48048 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751199AbVH3K4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 06:56:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=IhUocCH89dpg7SzmXQg1HZpUHHdX2Zod9+ldCcccDN/UAcv9zHFKWsnW/ZV6/sBP9v+eBJYNNbm6TlgPgRUCg0akk2Rmi19XOupX/c+CdnCUW/f46Jlyj5/X2BulMoyvBcgv9Cej3vWSdJE3GOsIyrKSe8D4Yz4lTos7IXxxjFk=
Message-ID: <2538186705083003561f5f97e0@mail.gmail.com>
Date: Tue, 30 Aug 2005 06:56:43 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
To: Corey Minyard <minyard@acm.org>
Subject: [PATCH] IPMI: driver model and sysfs support
Cc: Martin Drab <drab@kepler.fjfi.cvut.cz>,
       openipmi-developer@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_193_1482587.1125399403007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_193_1482587.1125399403007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Corey,

Here is a patch against 2.6.13 I've been working on (and mentioned to
you at OLS), that adds support for the 2.6 driver model, and sysfs to
the ipmi subsystem. It is loosely inspired by the USB driver model
system. There is a driver struct added for the ipmi_msghandler, and
one for each system interface 'driver' (for each state machine in
ipmi_si). A device struct is created for each system interface in the
system, and for each unique BMC on the system, with a symlink between
each system interface and the bmc it interfaces to. Each bmc has a set
of fundamental device attributes, and each of the drivers has a
version attribute reflecting the driver/state machine versions.
Furthermore each of these devices is registered as a class_device with
the ipmi class (moved to ipmi_msghandler) as bmcx and smix.

This in effect creates the following sysfs interface on a machine with
a single BMC and two interfaces:

/sys/
|-- block
|-- bus
|   |-- platform
|   |   |-- devices
|   |   |   |-- ipmi_bmc.0 -> ../../../devices/platform/ipmi_bmc.0
|   |   |   |-- ipmi_si.0 -> ../../../devices/platform/ipmi_si.0
|   |   |   |-- ipmi_si.1 -> ../../../devices/platform/ipmi_si.1
|   |   `-- drivers
|   |       |-- ipmi_bt_sm
|   |       |   |-- bind
|   |       |   |-- ipmi_si.1 -> ../../../../devices/platform/ipmi_si.1
|   |       |   |-- unbind
|   |       |   `-- version
|   |       |-- ipmi_kcs_sm
|   |       |   |-- bind
|   |       |   |-- ipmi_si.0 -> ../../../../devices/platform/ipmi_si.0
|   |       |   |-- unbind
|   |       |   `-- version
|   |       |-- ipmi_msghandler
|   |       |   |-- bind
|   |       |   |-- ipmi_bmc.0 -> ../../../../devices/platform/ipmi_bmc.0
|   |       |   |-- unbind
|   |       |   `-- version
|-- class
|   |-- ipmi
|   |   |-- bmc0
|   |   |   `-- device -> ../../../devices/platform/ipmi_bmc.0
|   |   |-- ipmi0
|   |   |   `-- dev
|   |   |-- ipmi1
|   |   |   `-- dev
|   |   |-- smi0
|   |   |   `-- device -> ../../../devices/platform/ipmi_si.0
|   |   `-- smi1
|   |       `-- device -> ../../../devices/platform/ipmi_si.1
|-- devices
|   |-- platform
|   |   |-- ipmi_bmc.0
|   |   |   |-- bus -> ../../../bus/platform
|   |   |   |-- device_id
|   |   |   |-- driver -> ../../../bus/platform/drivers/ipmi_msghandler
|   |   |   |-- firmware_revision
|   |   |   |-- ipmi_version
|   |   |   |-- power
|   |   |   |   `-- state
|   |   |   |-- product_id
|   |   |   `-- revision
|   |   |-- ipmi_si.0
|   |   |   |-- bmc -> ../../../devices/platform/ipmi_bmc.0
|   |   |   |-- bus -> ../../../bus/platform
|   |   |   |-- driver -> ../../../bus/platform/drivers/ipmi_kcs_sm
|   |   |   `-- power
|   |   |       `-- state
|   |   |-- ipmi_si.1
|   |   |   |-- bmc -> ../../../devices/platform/ipmi_bmc.0
|   |   |   |-- bus -> ../../../bus/platform
|   |   |   |-- driver -> ../../../bus/platform/drivers/ipmi_bt_sm
|   |   |   `-- power
|   |   |       `-- state
|-- kernel
|-- module
|   |-- ipmi_devintf
|   |   |-- refcnt
|   |   `-- sections
|   |       `-- __param
|   |-- ipmi_msghandler
|   |   |-- refcnt
|   |   `-- sections
|   |       |-- __ksymtab
|   |       `-- __ksymtab_strings
|   |-- ipmi_si
|   |   |-- refcnt
|   |   `-- sections
|   |       `-- __param
`-- power

My motiviation for the patch is to have a device struct (bmc) to
register with the new hwmon class for my in-progress hwmon driver
ipmi_sensors. With this patch the driver can create device attributes
under bmc devices representing sensor readings for the
hwmon/lm_sensors interface.

I have tested the patch on two systems of mine with a single bmc, it
should however also work for a machine with multiple bmcs using the
guid/product+device id to differentiate.

Thanks,
Yani

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

------=_Part_193_1482587.1125399403007
Content-Type: text/plain; name=patch-linux-2.6.13-ipmisys.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.13-ipmisys.diff"

 ---
 drivers/char/ipmi/ipmi_bt_sm.c      |   28 +++
 drivers/char/ipmi/ipmi_devintf.c    |   11 -
 drivers/char/ipmi/ipmi_kcs_sm.c     |   28 +++
 drivers/char/ipmi/ipmi_msghandler.c |  323 +++++++++++++++++++++++++++++++++++-
 drivers/char/ipmi/ipmi_si_intf.c    |  229 ++++++++++++++++++++++---
 drivers/char/ipmi/ipmi_si_sm.h      |    9 -
 drivers/char/ipmi/ipmi_smic_sm.c    |   29 +++
 include/linux/ipmi.h                |  108 ++++++++++++
 include/linux/ipmi_msgdefs.h        |    1 
 include/linux/ipmi_smi.h            |    1 
 10 files changed, 722 insertions(+), 45 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -28,6 +28,7 @@
 
 #include <linux/kernel.h> /* For printk. */
 #include <linux/string.h>
+#include <linux/ipmi.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
@@ -103,6 +104,31 @@ struct si_sm_data {
 #define BT_INTMASK_R	bt->io->inputb(bt->io, 2)
 #define BT_INTMASK_W(x)	bt->io->outputb(bt->io, 2, x)
 
+static ssize_t bt_driver_show_version(struct device_driver *drv, char *buf){
+	struct ipmi_si_driver *driver = to_ipmi_si_driver(drv);
+	return snprintf(buf, 10, "%s\n", driver->version);
+}
+
+/** 
+ * The driver model view of the IPMI system interface state machine.
+ */
+static struct ipmi_si_driver bt_si_driver = {
+	.owner = THIS_MODULE,
+	.version = IPMI_BT_VERSION,
+	.driver = {
+		.name = "ipmi_bt_sm",
+		.bus = &platform_bus_type
+	},
+	.version_attr = {
+		.attr = {
+			.name = "version",
+			.owner = THIS_MODULE,
+			.mode = S_IRUGO,
+		},
+		.show = bt_driver_show_version,
+	},
+};
+
 /* Convenience routines for debugging.  These are not multi-open safe!
    Note the macros have hardcoded variables in them. */
 
@@ -501,7 +527,7 @@ static int bt_size(void)
 
 struct si_sm_handlers bt_smi_handlers =
 {
-	.version           = IPMI_BT_VERSION,
+	.driver            = &bt_si_driver,
 	.init_data         = bt_init_data,
 	.start_transaction = bt_start_transaction,
 	.get_result        = bt_get_result,
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -716,7 +716,7 @@ MODULE_PARM_DESC(ipmi_major, "Sets the m
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
-static struct class *ipmi_class;
+extern struct class *ipmi_class;
 
 static void ipmi_new_smi(int if_num)
 {
@@ -751,15 +751,8 @@ static __init int init_ipmi_devintf(void
 	printk(KERN_INFO "ipmi device interface version "
 	       IPMI_DEVINTF_VERSION "\n");
 
-	ipmi_class = class_create(THIS_MODULE, "ipmi");
-	if (IS_ERR(ipmi_class)) {
-		printk(KERN_ERR "ipmi: can't register device class\n");
-		return PTR_ERR(ipmi_class);
-	}
-
 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
 	if (rv < 0) {
-		class_destroy(ipmi_class);
 		printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
 		return rv;
 	}
@@ -773,7 +766,6 @@ static __init int init_ipmi_devintf(void
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
-		class_destroy(ipmi_class);
 		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
 		return rv;
 	}
@@ -784,7 +776,6 @@ module_init(init_ipmi_devintf);
 
 static __exit void cleanup_ipmi(void)
 {
-	class_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
 	devfs_remove(DEVICE_NAME);
 	unregister_chrdev(ipmi_major, DEVICE_NAME);
diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
--- a/drivers/char/ipmi/ipmi_kcs_sm.c
+++ b/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -39,6 +39,7 @@
 
 #include <linux/kernel.h> /* For printk. */
 #include <linux/string.h>
+#include <linux/ipmi.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
@@ -111,6 +112,31 @@ struct si_sm_data
 	long          obf_timeout;
 };
 
+static ssize_t kcs_driver_show_version(struct device_driver *drv, char *buf){
+	struct ipmi_si_driver *driver = to_ipmi_si_driver(drv);
+	return snprintf(buf, 10, "%s\n", driver->version);
+}
+
+/** 
+ * The driver model view of the IPMI system interface state machine.
+ */
+static struct ipmi_si_driver kcs_si_driver = {
+	.owner = THIS_MODULE,
+	.version = IPMI_KCS_VERSION,
+	.driver = {
+		.name = "ipmi_kcs_sm",
+		.bus = &platform_bus_type
+	},
+	.version_attr = {
+		.attr = {
+			.name = "version",
+			.owner = THIS_MODULE,
+			.mode = S_IRUGO,
+		},
+		.show = kcs_driver_show_version,
+	},
+};
+
 static unsigned int init_kcs_data(struct si_sm_data *kcs,
 				  struct si_sm_io *io)
 {
@@ -489,7 +515,7 @@ static void kcs_cleanup(struct si_sm_dat
 
 struct si_sm_handlers kcs_smi_handlers =
 {
-	.version           = IPMI_KCS_VERSION,
+	.driver            = &kcs_si_driver,
 	.init_data         = init_kcs_data,
 	.start_transaction = start_kcs_transaction,
 	.get_result        = get_kcs_result,
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -30,6 +30,10 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+/* 
+ * IPMI driver model/sysfs support.
+ * Copyright (C) 2005 Yani Ioannou <yani.ioannou@gmail.com>
+ */
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -301,6 +305,27 @@ struct ipmi_smi
 	unsigned int events;
 };
 
+static struct class *ipmi_class;
+
+/** 
+ * The driver model view of the IPMI messaging driver.
+ */
+static struct ipmi_driver ipmidriver = {
+	.owner = THIS_MODULE,
+	.version = IPMI_MSGHANDLER_VERSION,
+	.driver = {
+		.name = "ipmi_msghandler",
+		.bus = &platform_bus_type
+	}
+};
+
+static ssize_t ipmi_driver_show_version(struct device_driver *drv, char *buf){
+	struct ipmi_driver *driver = to_ipmi_driver(drv);
+	return snprintf(buf, 10, "%s\n", driver->version);
+}
+
+DRIVER_ATTR(version, S_IRUGO, ipmi_driver_show_version, NULL);
+
 #define MAX_IPMI_INTERFACES 4
 static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
 
@@ -318,6 +343,271 @@ static DEFINE_SPINLOCK(interfaces_lock);
 static struct list_head smi_watchers = LIST_HEAD_INIT(smi_watchers);
 static DECLARE_RWSEM(smi_watchers_sem);
 
+static int __find_bmc_guid(struct device *dev, void *data)
+{
+	unsigned char *id = (unsigned char *) data;
+	struct ipmi_bmc_device *bmc = 
+		to_ipmi_bmc_device(to_platform_device(dev));
+	
+	return memcmp(bmc->guid, id, 16) == 0;
+}
+
+struct ipmi_bmc_device * ipmi_find_bmc_guid(struct ipmi_driver *drv, 
+		unsigned char* guid)
+{
+	struct device *dev = driver_find_device(&drv->driver, NULL, guid, 
+			__find_bmc_guid);
+	return (dev?to_ipmi_bmc_device(to_platform_device(dev)):NULL);
+}
+
+struct prod_dev_id{
+	unsigned char product_id[2];
+	unsigned char device_id;
+};
+
+static int __find_bmc_prod_dev_id(struct device *dev, void *data)
+{
+	struct prod_dev_id *id = (struct prod_dev_id *) data;
+	struct ipmi_bmc_device *bmc = 
+		to_ipmi_bmc_device(to_platform_device(dev));
+	
+	return memcmp(bmc->product_id, id->product_id, 2) == 0
+		&& memcmp(&bmc->device_id, &id->device_id, 1) == 0;
+}
+
+struct ipmi_bmc_device * ipmi_find_bmc_prod_dev_id(struct ipmi_driver *drv, 
+		unsigned char *product_id, unsigned char *device_id)
+{
+	struct prod_dev_id id = {
+		.product_id = {product_id[0], product_id[1]},
+		.device_id = *device_id,
+	};
+	
+	struct device *dev = driver_find_device(&drv->driver, NULL, &id, 
+			__find_bmc_prod_dev_id);
+	return (dev?to_ipmi_bmc_device(to_platform_device(dev)):NULL);
+}
+
+static void ipmi_bmc_release(struct device *dev){
+	printk(KERN_DEBUG "ipmi_bmc release\n");
+}
+
+static ssize_t device_id_show(struct device *dev, struct device_attribute *attr, 
+		char *buf){
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "%u\n", bmc->device_id);
+}
+
+static ssize_t product_id_show(struct device *dev, struct device_attribute *attr, 
+		char *buf){
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u%u\n", bmc->product_id[0],
+			bmc->product_id[1]);
+}
+
+static ssize_t guid_show(struct device *dev, struct device_attribute *attr, 
+		char *buf){
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 200, "%s\n", bmc->guid);
+}
+
+static ssize_t ipmi_version_show(struct device *dev, struct device_attribute *attr, 
+		char *buf){
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u.%u\n", bmc->version_major, bmc->version_minor);
+}
+
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr, 
+		char *buf){
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u\n",  bmc->revision);
+}
+
+static ssize_t firmware_rev_show(struct device *dev, struct device_attribute *attr, 
+		char *buf){
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u.%u\n", bmc->firmware_rev_major, 
+			bmc->firmware_rev_minor);
+}
+
+static void ipmi_bmc_unregister(struct ipmi_si_device *si, 
+		struct ipmi_bmc_device *bmc){
+	if(--bmc->interfaces == 0){
+		class_device_unregister(bmc->class_dev);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->device_id_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->product_id_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->version_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->revision_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->firmware_rev_attr);
+		platform_device_unregister(&bmc->dev);
+	}
+}
+
+static int ipmi_bmc_register(struct ipmi_si_device *si, 
+		struct ipmi_bmc_device **bmcref){
+	int rv = 0;
+	struct ipmi_bmc_device *bmc = *bmcref;
+	struct ipmi_bmc_device *new_bmc;
+
+	/* Try to find if there is an ipmi_bmc_device struct 
+	 * representing the interfaced BMC already
+	 */
+	if(bmc->guid_present){
+		new_bmc = ipmi_find_bmc_guid(&ipmidriver, bmc->guid);
+	}else{
+		new_bmc = ipmi_find_bmc_prod_dev_id(&ipmidriver, 
+				bmc->product_id, 
+				&bmc->device_id);
+	}
+	/* If there is already an ipmi_bmc_device, free the new one,
+	 * otherwise register the new BMC device
+	 */
+	if(new_bmc){
+		kfree(bmc); 
+		*bmcref = new_bmc; 
+		bmc = new_bmc;
+		
+		bmc->interfaces++;
+		
+		printk(KERN_INFO 
+		"ipmi_si: interfacing existing BMC (guid: %x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x, prod_id: %u%u, dev_id: %u)\n",
+				bmc->guid[0],
+				bmc->guid[1],
+				bmc->guid[2],
+				bmc->guid[3],
+				bmc->guid[4],
+				bmc->guid[5],
+				bmc->guid[6],
+				bmc->guid[7],
+				bmc->guid[8],
+				bmc->guid[9],
+				bmc->guid[10],
+				bmc->guid[11],
+				bmc->guid[12],
+				bmc->guid[13],
+				bmc->guid[14],
+				bmc->guid[15],
+				bmc->product_id[0],
+				bmc->product_id[1],
+				bmc->device_id);
+	}else{
+		bmc->dev.name = "ipmi_bmc";
+		bmc->dev.id = bmc->device_id;
+		bmc->dev.dev.driver = &ipmidriver.driver;
+		bmc->dev.dev.release = ipmi_bmc_release;
+		bmc->interfaces = 1;
+		
+		rv = platform_device_register(&bmc->dev);
+		if (rv) {
+			printk(KERN_ERR
+				"ipmi_si: Unable to register bmc device: %d\n", 
+				rv);
+			goto out_err;
+		}
+		
+		bmc->device_id_attr.attr.name = "device_id";
+		bmc->device_id_attr.attr.owner = THIS_MODULE;
+		bmc->device_id_attr.attr.mode = S_IRUGO;
+		bmc->device_id_attr.show = device_id_show;
+		
+		bmc->product_id_attr.attr.name = "product_id";
+		bmc->product_id_attr.attr.owner = THIS_MODULE;
+		bmc->product_id_attr.attr.mode = S_IRUGO;
+		bmc->product_id_attr.show = product_id_show;
+		
+		bmc->guid_attr.attr.name = "guid";
+		bmc->guid_attr.attr.owner = THIS_MODULE;
+		bmc->guid_attr.attr.mode = S_IRUGO;
+		bmc->guid_attr.show = guid_show;
+		
+		bmc->version_attr.attr.name = "ipmi_version";
+		bmc->version_attr.attr.owner = THIS_MODULE;
+		bmc->version_attr.attr.mode = S_IRUGO;
+		bmc->version_attr.show = ipmi_version_show;
+		
+		bmc->revision_attr.attr.name = "revision";
+		bmc->revision_attr.attr.owner = THIS_MODULE;
+		bmc->revision_attr.attr.mode = S_IRUGO;
+		bmc->revision_attr.show = revision_show;
+		
+		bmc->firmware_rev_attr.attr.name = "firmware_revision";
+		bmc->firmware_rev_attr.attr.owner = THIS_MODULE;
+		bmc->firmware_rev_attr.attr.mode = S_IRUGO;
+		bmc->firmware_rev_attr.show = firmware_rev_show;
+		
+		device_create_file(&bmc->dev.dev,
+				&bmc->device_id_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->product_id_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->version_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->revision_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->firmware_rev_attr);
+		
+		if(bmc->guid_present)
+			device_create_file(&bmc->dev.dev,
+					&bmc->guid_attr);
+		
+		bmc->class_dev = 
+		kmalloc(sizeof(struct class_device), GFP_KERNEL);
+		if (!bmc->class_dev) {
+			printk(KERN_ERR "ipmi_msghandler: Could not allocate class_device memory\n");
+			rv = -ENOMEM;
+			goto out_err;
+		}
+		memset(bmc->class_dev, 0, sizeof(struct class_device));
+	
+	
+		bmc->class_dev->class = ipmi_class;
+		bmc->class_dev->dev = &bmc->dev.dev;
+		snprintf(bmc->class_dev->class_id, BUS_ID_SIZE, "bmc%d", 
+				bmc->device_id);
+		
+		class_device_register(bmc->class_dev);
+		
+		printk(KERN_INFO 
+		"ipmi_si: Found new BMC (guid: guid: %x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x, prod_id: %u%u, dev_id: %u)\n",
+				bmc->guid[0],
+				bmc->guid[1],
+				bmc->guid[2],
+				bmc->guid[3],
+				bmc->guid[4],
+				bmc->guid[5],
+				bmc->guid[6],
+				bmc->guid[7],
+				bmc->guid[8],
+				bmc->guid[9],
+				bmc->guid[10],
+				bmc->guid[11],
+				bmc->guid[12],
+				bmc->guid[13],
+				bmc->guid[14],
+				bmc->guid[15],
+				bmc->product_id[0],
+				bmc->product_id[1],
+				bmc->device_id);
+	}
+
+	/* create symlink from system interface device to bmc device */
+	rv = sysfs_create_link(&si->dev.dev.kobj, 
+			&bmc->dev.dev.kobj, "bmc");
+	if (rv) {
+		printk(KERN_ERR
+			"ipmi_si: Unable to create bmc symlink: %d\n",
+		       rv);
+		goto out_err;
+	}
+out_err:
+	return rv;
+}
+
 int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
 {
 	int i;
@@ -3093,11 +3383,29 @@ static struct notifier_block panic_block
 
 static int ipmi_init_msghandler(void)
 {
-	int i;
+	int i, retval;
 
 	if (initialized)
 		return 0;
-
+	
+	ipmi_class = class_create(THIS_MODULE, "ipmi");
+	if (IS_ERR(ipmi_class)) {
+		printk(KERN_ERR "ipmi: can't register device class\n");
+		return PTR_ERR(ipmi_class);
+	}
+	
+	retval = driver_register(&ipmidriver.driver);
+	if (retval) {
+		printk(KERN_ERR PFX "Could'nt register IPMI driver\n");
+		return retval;
+	}
+	
+	retval = driver_create_file(&ipmidriver.driver, &driver_attr_version);
+	if (retval) {
+		printk(KERN_ERR PFX "Could'nt register IPMI driver version attribute\n");
+		return retval;
+	}
+	
 	printk(KERN_INFO "ipmi message handler version "
 	       IPMI_MSGHANDLER_VERSION "\n");
 
@@ -3155,6 +3463,10 @@ static __exit void cleanup_ipmi(void)
 	remove_proc_entry(proc_ipmi_root->name, &proc_root);
 #endif /* CONFIG_PROC_FS */
 
+	driver_unregister(&ipmidriver.driver);
+	
+	class_destroy(ipmi_class);
+	
 	initialized = 0;
 
 	/* Check for buffer leaks. */
@@ -3196,3 +3508,10 @@ EXPORT_SYMBOL(ipmi_get_my_LUN);
 EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
 EXPORT_SYMBOL(proc_ipmi_root);
 EXPORT_SYMBOL(ipmi_user_set_run_to_completion);
+EXPORT_SYMBOL(ipmidriver);
+EXPORT_SYMBOL(ipmi_find_bmc_guid);
+EXPORT_SYMBOL(ipmi_find_bmc_prod_dev_id);
+EXPORT_SYMBOL(ipmi_bmc_register);
+EXPORT_SYMBOL(ipmi_bmc_unregister);
+EXPORT_SYMBOL(ipmi_class);
+
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -38,6 +38,11 @@
  * and drives the real SMI state machine.
  */
 
+/* 
+ * IPMI driver model/sysfs support.
+ * Copyright (C) 2005 Yani Ioannou <yani.ioannou@gmail.com>
+ */
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -112,6 +117,7 @@ enum si_type {
 struct smi_info
 {
 	ipmi_smi_t             intf;
+	struct ipmi_si_device  *dev;
 	struct si_sm_data      *si_sm;
 	struct si_sm_handlers  *handlers;
 	enum si_type           si_type;
@@ -175,12 +181,6 @@ struct smi_info
 	   interrupts. */
 	int interrupt_disabled;
 
-	unsigned char ipmi_si_dev_rev;
-	unsigned char ipmi_si_fw_rev_major;
-	unsigned char ipmi_si_fw_rev_minor;
-	unsigned char ipmi_version_major;
-	unsigned char ipmi_version_minor;
-
 	/* Slave address, could be reported from DMI. */
 	unsigned char slave_addr;
 
@@ -200,6 +200,13 @@ struct smi_info
 	unsigned long incoming_messages;
 };
 
+extern struct ipmi_driver ipmidriver;
+extern struct class *ipmi_class;
+extern int ipmi_bmc_register(struct ipmi_si_device *si, 
+		struct ipmi_bmc_device **bmcref);
+extern void ipmi_bmc_unregister(struct ipmi_si_device *si, 
+		struct ipmi_bmc_device *bmc);
+
 static void si_restart_short_timer(struct smi_info *smi_info);
 
 static void deliver_recv_msg(struct smi_info *smi_info,
@@ -211,7 +218,6 @@ static void deliver_recv_msg(struct smi_
 	ipmi_smi_msg_received(smi_info->intf, msg);
 	spin_lock(&(smi_info->si_lock));
 }
-
 static void return_hosed_msg(struct smi_info *smi_info)
 {
 	struct ipmi_smi_msg *msg = smi_info->curr_msg;
@@ -890,7 +896,6 @@ static irqreturn_t si_bt_irq_handler(int
 	return si_irq_handler(irq, data, regs);
 }
 
-
 static struct ipmi_smi_handlers handlers =
 {
 	.owner                  = THIS_MODULE,
@@ -1351,8 +1356,9 @@ static int try_init_mem(int intf_num, st
 	info->io.regshift = regshifts[intf_num];
 	info->irq = 0;
 	info->irq_setup = NULL;
+	
 	*new_info = info;
-
+	
 	if (si_type[intf_num] == NULL)
 		si_type[intf_num] = "kcs";
 
@@ -1933,6 +1939,75 @@ static int try_init_plug_and_play(int in
 	return -ENODEV;
 }
 
+static int try_get_dev_guid(struct smi_info *smi_info)
+{
+	unsigned char      msg[2];
+	unsigned char      *resp;
+	unsigned long      resp_len;
+	enum si_sm_result smi_result;
+	int               rv = 0;
+
+	smi_info->dev->bmc->guid_present = 0;
+	
+	resp = kmalloc(IPMI_MAX_MSG_LENGTH, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	/* Do a Get Device GUID command, since it might come back with a 
+	 * useful globally unique BMC ID. */
+	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
+	msg[1] = IPMI_GET_DEVICE_GUID_CMD;
+	smi_info->handlers->start_transaction(smi_info->si_sm, msg, 2);
+
+	smi_result = smi_info->handlers->event(smi_info->si_sm, 0);
+	for (;;)
+	{
+		if (smi_result == SI_SM_CALL_WITH_DELAY) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
+			smi_result = smi_info->handlers->event(
+				smi_info->si_sm, 100);
+		}
+		else if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
+		{
+			smi_result = smi_info->handlers->event(
+				smi_info->si_sm, 0);
+		}
+		else
+			break;
+	}
+	if (smi_result == SI_SM_HOSED) {
+		/* We couldn't get the state machine to run, so whatever's at
+		   the port is probably not an IPMI SMI interface. */
+		rv = -ENODEV;
+		goto gout;
+	}
+
+	/* Otherwise, we got some data. */
+	resp_len = smi_info->handlers->get_result(smi_info->si_sm,
+						  resp, IPMI_MAX_MSG_LENGTH);
+	if (resp_len < 6) {
+		/* That's odd, it should be longer. */
+		rv = -EINVAL;
+		goto gout;
+	}
+
+	if ((resp[1] != IPMI_GET_DEVICE_GUID_CMD) || (resp[2] != 0)) {
+		/* That's odd, it shouldn't be able to fail. */
+		rv = -EINVAL;
+		goto gout;
+	}
+
+	/* Record info from the get device guid, if none returned, null 
+	 * terminate first char */
+	if(resp[2]){
+		memcpy(smi_info->dev->bmc->guid, &resp[3], 16);
+		smi_info->dev->bmc->guid_present = 1;
+	}
+ gout:
+	kfree(resp);
+	return rv;
+}
 
 static int try_get_dev_id(struct smi_info *smi_info)
 {
@@ -1992,11 +2067,14 @@ static int try_get_dev_id(struct smi_inf
 	}
 
 	/* Record info from the get device id, in case we need it. */
-	smi_info->ipmi_si_dev_rev = resp[4] & 0xf;
-	smi_info->ipmi_si_fw_rev_major = resp[5] & 0x7f;
-	smi_info->ipmi_si_fw_rev_minor = resp[6];
-	smi_info->ipmi_version_major = resp[7] & 0xf;
-	smi_info->ipmi_version_minor = resp[7] >> 4;
+	smi_info->dev->bmc->device_id = resp[3];
+	memcpy(smi_info->dev->bmc->product_id, &resp[12], 2);
+	memcpy(smi_info->dev->bmc->manufacturer_id, &resp[9], 3);
+	smi_info->dev->bmc->revision = resp[4] & 0xf;
+	smi_info->dev->bmc->firmware_rev_major = resp[5] & 0x7f;
+	smi_info->dev->bmc->firmware_rev_minor = resp[6];
+	smi_info->dev->bmc->version_major = resp[7] & 0xf;
+	smi_info->dev->bmc->version_minor = resp[7] >> 4;
 
  out:
 	kfree(resp);
@@ -2057,13 +2135,18 @@ static int stat_file_read_proc(char *pag
 	return (out - ((char *) page));
 }
 
+static void ipmi_si_release(struct device *dev){
+	struct ipmi_si_device *si = to_ipmi_si_device(to_platform_device(dev)); 
+	ipmi_bmc_unregister(si, si->bmc);
+	printk(KERN_DEBUG "ipmi_si release\n");
+}
+
 /* Returns 0 if initialized, or negative on an error. */
 static int init_one_smi(int intf_num, struct smi_info **smi)
 {
 	int		rv;
 	struct smi_info *new_smi;
 
-
 	rv = try_init_mem(intf_num, &new_smi);
 	if (rv)
 		rv = try_init_port(intf_num, &new_smi);
@@ -2081,7 +2164,6 @@ static int init_one_smi(int intf_num, st
 		rv = try_init_plug_and_play(intf_num, &new_smi);
 	}
 
-
 	if (rv)
 		return rv;
 
@@ -2148,12 +2230,48 @@ static int init_one_smi(int intf_num, st
 		rv = -ENODEV;
 		goto out_err;
 	}
+	
+	new_smi->dev = kmalloc(sizeof(struct ipmi_si_device), GFP_KERNEL);
+	if (!new_smi->dev) {
+		printk(KERN_ERR "ipmi_si: Could not allocate ipmi_si_device memory\n");
+		rv = -ENOMEM;
+		goto out_err;
+	}
+	memset(new_smi->dev, 0, sizeof(struct ipmi_si_device));
 
+	new_smi->dev->class_dev = 
+		kmalloc(sizeof(struct class_device), GFP_KERNEL);
+	if (!new_smi->dev->class_dev) {
+		printk(KERN_ERR "ipmi_si: Could not allocate class_device memory\n");
+		rv = -ENOMEM;
+		goto out_err;
+	}
+	memset(new_smi->dev->class_dev, 0, sizeof(struct class_device));
+
+
+	/* Allocate a bmc device struct */
+	new_smi->dev->bmc = kmalloc(sizeof(struct ipmi_bmc_device), GFP_KERNEL);
+	if (!new_smi->dev->bmc) {
+		printk(KERN_ERR "ipmi_si: Could not allocate ipmi_bmc_device memory\n");
+		rv = -ENOMEM;
+		goto out_err;
+	}
+	memset(new_smi->dev->bmc, 0, sizeof(struct ipmi_bmc_device));
+	
 	/* Attempt a get device id command.  If it fails, we probably
            don't have a SMI here. */
 	rv = try_get_dev_id(new_smi);
-	if (rv)
+	if (rv){
+		printk(KERN_ERR "ipmi_si: Error while trying to get device id.\n");
+		goto out_err;
+	}
+	
+	/* Attempt a get device guid command. */
+	rv = try_get_dev_guid(new_smi);
+	if (rv){
+		printk(KERN_ERR " Error while trying to get GUID.\n");
 		goto out_err;
+	}
 
 	/* Try to claim any interrupts. */
 	new_smi->irq_setup(new_smi);
@@ -2188,8 +2306,8 @@ static int init_one_smi(int intf_num, st
 
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
-			       new_smi->ipmi_version_major,
-			       new_smi->ipmi_version_minor,
+			       new_smi->dev->bmc->version_major,
+			       new_smi->dev->bmc->version_minor,
 			       new_smi->slave_addr,
 			       &(new_smi->intf));
 	if (rv) {
@@ -2219,6 +2337,55 @@ static int init_one_smi(int intf_num, st
 		goto out_err_stop_timer;
 	}
 
+	rv = driver_register(&new_smi->handlers->driver->driver);
+	if (rv) {
+		printk(KERN_ERR
+		       "ipmi_si: Unable to register driver: %d\n",
+		       rv);
+		goto out_err_stop_timer;
+	}
+
+	rv = driver_create_file(&new_smi->handlers->driver->driver,
+			&new_smi->handlers->driver->version_attr);
+	if (rv) {
+		printk(KERN_ERR
+		       "ipmi_si: Unable to register driver attribute: %d\n",
+		       rv);
+		goto out_err_stop_timer;
+	}
+	
+	new_smi->dev->smi = new_smi;
+	
+	new_smi->dev->driver = new_smi->handlers->driver;
+	new_smi->dev->dev.name = "ipmi_si";
+	new_smi->dev->dev.id = intf_num;
+	new_smi->dev->dev.dev.driver = &new_smi->handlers->driver->driver;
+	new_smi->dev->dev.dev.release = ipmi_si_release;
+	
+	rv = platform_device_register(&new_smi->dev->dev);
+	if (rv) {
+		printk(KERN_ERR
+			"ipmi_si: Unable to register system interface device: %d\n",
+		       rv);
+		goto out_err_stop_timer;
+	}
+
+	new_smi->dev->class_dev->class = ipmi_class;
+	new_smi->dev->class_dev->dev = &new_smi->dev->dev.dev;
+	snprintf(new_smi->dev->class_dev->class_id, BUS_ID_SIZE, "smi%d", 
+			intf_num);
+	class_device_register(new_smi->dev->class_dev);
+	
+	/* register the attatched IPMI BMC */
+	rv = ipmi_bmc_register(new_smi->dev, &new_smi->dev->bmc);
+	if (rv) {
+		printk(KERN_ERR
+			"ipmi_si: Unable to register bmc: %d\n",
+		       rv);
+		goto out_err_stop_timer;
+	}
+
+	
 	*smi = new_smi;
 
 	printk(" IPMI %s interface initialized\n", si_type[intf_num]);
@@ -2248,7 +2415,9 @@ static int init_one_smi(int intf_num, st
 
 	if (new_smi->si_sm) {
 		if (new_smi->handlers)
+		{
 			new_smi->handlers->cleanup(new_smi->si_sm);
+		}
 		kfree(new_smi->si_sm);
 	}
 	new_smi->io_cleanup(new_smi);
@@ -2266,7 +2435,7 @@ static __init int init_ipmi_si(void)
 	if (initialized)
 		return 0;
 	initialized = 1;
-
+	
 	/* Parse out the si_type string into its components. */
 	str = si_type_str;
 	if (*str != '\0') {
@@ -2284,12 +2453,12 @@ static __init int init_ipmi_si(void)
 
 	printk(KERN_INFO "IPMI System Interface driver version "
 	       IPMI_SI_VERSION);
-	if (kcs_smi_handlers.version)
-		printk(", KCS version %s", kcs_smi_handlers.version);
-	if (smic_smi_handlers.version)
-		printk(", SMIC version %s", smic_smi_handlers.version);
-	if (bt_smi_handlers.version)
-   	        printk(", BT version %s", bt_smi_handlers.version);
+	if (kcs_smi_handlers.driver->version)
+		printk(", KCS version %s", kcs_smi_handlers.driver->version);
+	if (smic_smi_handlers.driver->version)
+		printk(", SMIC version %s", smic_smi_handlers.driver->version);
+	if (bt_smi_handlers.driver->version)
+   	        printk(", BT version %s", bt_smi_handlers.driver->version);
 	printk("\n");
 
 #ifdef CONFIG_X86
@@ -2342,6 +2511,12 @@ static void __exit cleanup_one_si(struct
 	if (! to_clean)
 		return;
 
+	class_device_unregister(to_clean->dev->class_dev);
+	platform_device_unregister(&to_clean->dev->dev);
+	driver_remove_file(&to_clean->handlers->driver->driver,
+			&to_clean->handlers->driver->version_attr);
+	driver_unregister(&to_clean->handlers->driver->driver);
+	
 	/* Tell the timer and interrupt handlers that we are shutting
 	   down. */
 	spin_lock_irqsave(&(to_clean->si_lock), flags);
@@ -2382,7 +2557,7 @@ static void __exit cleanup_one_si(struct
 	}
 
 	to_clean->handlers->cleanup(to_clean->si_sm);
-
+	
 	kfree(to_clean->si_sm);
 
 	to_clean->io_cleanup(to_clean);
diff --git a/drivers/char/ipmi/ipmi_si_sm.h b/drivers/char/ipmi/ipmi_si_sm.h
--- a/drivers/char/ipmi/ipmi_si_sm.h
+++ b/drivers/char/ipmi/ipmi_si_sm.h
@@ -34,6 +34,8 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/ipmi.h>
+
 /* This is defined by the state machines themselves, it is an opaque
    data type for them to use. */
 struct si_sm_data;
@@ -72,9 +74,10 @@ enum si_sm_result
 /* Handlers for the SMI state machine. */
 struct si_sm_handlers
 {
-	/* Put the version number of the state machine here so the
-           upper layer can print it. */
-	char *version;
+	/* The driver model view of the system interface state machine so it can be
+	   registered/unregistered, also access to the version number so the upper
+	   layer can print it. */
+	struct ipmi_si_driver *driver;
 
 	/* Initialize the data and return the amount of I/O space to
            reserve for the space. */
diff --git a/drivers/char/ipmi/ipmi_smic_sm.c b/drivers/char/ipmi/ipmi_smic_sm.c
--- a/drivers/char/ipmi/ipmi_smic_sm.c
+++ b/drivers/char/ipmi/ipmi_smic_sm.c
@@ -43,6 +43,7 @@
 
 #include <linux/kernel.h> /* For printk. */
 #include <linux/string.h>
+#include <linux/ipmi.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
@@ -111,6 +112,32 @@ struct si_sm_data
         long		 smic_timeout;
 };
 
+static ssize_t smic_driver_show_version(struct device_driver *drv, char *buf){
+	struct ipmi_si_driver *driver = to_ipmi_si_driver(drv);
+	return snprintf(buf, 10, "%s\n", driver->version);
+}
+
+/** 
+ * The driver model view of the IPMI system interface state machine.
+ */
+static struct ipmi_si_driver smic_si_driver = {
+	.owner = THIS_MODULE,
+	.version = IPMI_SMIC_VERSION,
+	.driver = {
+		.name = "ipmi_smic_sm",
+		.bus = &platform_bus_type
+	},
+	.version_attr = {
+		.attr = {
+			.name = "version",
+			.owner = THIS_MODULE,
+			.mode = S_IRUGO,
+		},
+		.show = smic_driver_show_version,
+	},
+
+};
+
 static unsigned int init_smic_data (struct si_sm_data *smic,
 				    struct si_sm_io *io)
 {
@@ -588,7 +615,7 @@ static int smic_size(void)
 
 struct si_sm_handlers smic_smi_handlers =
 {
-	.version           = IPMI_SMIC_VERSION,
+	.driver            = &smic_si_driver,
 	.init_data         = init_smic_data,
 	.start_transaction = start_smic_transaction,
 	.get_result        = smic_get_result,
diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
--- a/include/linux/ipmi.h
+++ b/include/linux/ipmi.h
@@ -30,10 +30,16 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+/* 
+ * IPMI driver model/sysfs support.
+ * Copyright (C) 2005 Yani Ioannou <yani.ioannou@gmail.com> 
+ */
 
 #ifndef __LINUX_IPMI_H
 #define __LINUX_IPMI_H
 
+#include <linux/device.h>
+#include <linux/ipmi_smi.h>
 #include <linux/ipmi_msgdefs.h>
 
 /*
@@ -67,6 +73,108 @@
  * interface is defined later in the file.  */
 
 
+/**
+ * struct ipmi_si_driver - represents a ipmi system interface 
+ * 	driver in the kernel.
+ * @owner: Pointer to the module owner of this driver; initialize
+ *	it using THIS_MODULE.
+ * @version: The version of the system interface driver.
+ * @driver: the driver model core driver structure.
+ *
+ * An IPMI baseboard management controller (BMC) may be accessed directly by 
+ * the host computer via a system interface of which there are many different
+ * types. This driver provides the interface defined by the general low level
+ * system interface driver.
+ */
+struct ipmi_si_driver
+{
+	struct module *owner;
+	const char *version;
+	struct device_driver driver;
+	/* driver attributes */
+	struct driver_attribute version_attr;
+};
+#define to_ipmi_si_driver(drv) container_of(drv, struct ipmi_si_driver, driver)
+
+/**
+ * struct ipmi_driver - represents the ipmi messaging interface 
+ * 	driver in the kernel.
+ * @owner: Pointer to the module owner of this driver; initialize
+ *	it using THIS_MODULE.
+ * @name: The version of the ipmi messaging interface driver.
+ * @driver: the driver model core driver structure.
+ */
+struct ipmi_driver
+{
+	struct module *owner;
+	const char *version;
+	struct device_driver driver;
+};
+#define to_ipmi_driver(drv) container_of(drv, struct ipmi_driver, driver)
+
+/**
+ * struct ipmi_si_device - represents ipmi an IPMI system interface in 
+ * 	the kernel.
+ * @smi: the low level interface struct.
+ * @bmc: the IPMI BMC interfaced to.
+ * @driver: the IPMI system interface driver that is bound to this interface.
+ * @dev: driver model's view of this device.
+ * @class_dev: driver model's class view of this device.
+ * 
+ * An IPMI baseboard management controller (BMC) may be accessed directly by 
+ * the host computer via a system interface of which there are many different
+ * types. This device represents one such system interface.
+ */
+struct ipmi_si_device
+{
+	smi_info_t smi;
+	struct ipmi_bmc_device *bmc;
+	struct ipmi_si_driver *driver; 
+	struct platform_device dev;
+	struct class_device *class_dev;
+};
+#define to_ipmi_si_device(device) 			\
+	container_of(device, struct ipmi_si_device, dev)
+
+/**
+ * struct ipmi_bmc_device - represents an IPMI baseboard management controller
+ * 	(BMC) attatched to one or more system interfaces.
+ * @product_id: OEM product id.
+ * @device_id: OEM per product device id (product_id+device_id unique).
+ * @guid: BMC's globally unique identifier (optional).
+ * @dev: driver model's view of this device.
+ * @version_major: the ipmi major version number of the BMC.
+ * @version_minor: the ipmi minor version number of the BMC.
+ * @revision: the ipmi BMC revision number.
+ * @firmware_rev_major: the BMC's firmware major version number.
+ * @firmware_rev_minor: the BMC's firmware minor version number.
+ */
+struct ipmi_bmc_device
+{
+	struct platform_device dev;
+	unsigned char device_id;
+	unsigned char product_id[2];
+	unsigned char manufacturer_id[3];
+	unsigned char guid[16];
+	int guid_present;
+	unsigned char version_major;
+	unsigned char version_minor;
+	unsigned char revision;
+	unsigned char firmware_rev_major;
+	unsigned char firmware_rev_minor;
+	int interfaces;
+	struct class_device *class_dev;
+	/* device attributes */
+	struct device_attribute device_id_attr;
+	struct device_attribute product_id_attr;
+	struct device_attribute manufacturer_id_attr;
+	struct device_attribute guid_attr;
+	struct device_attribute version_attr;
+	struct device_attribute revision_attr;
+	struct device_attribute firmware_rev_attr;
+};
+#define to_ipmi_bmc_device(device) 			\
+	container_of(device, struct ipmi_bmc_device, dev)
 
 /*
  * This is an overlay for all the address types, so it's easy to
diff --git a/include/linux/ipmi_msgdefs.h b/include/linux/ipmi_msgdefs.h
--- a/include/linux/ipmi_msgdefs.h
+++ b/include/linux/ipmi_msgdefs.h
@@ -45,6 +45,7 @@
 
 #define IPMI_NETFN_APP_REQUEST			0x06
 #define IPMI_NETFN_APP_RESPONSE			0x07
+#define IPMI_GET_DEVICE_GUID_CMD           0x08
 #define IPMI_GET_DEVICE_ID_CMD		0x01
 #define IPMI_CLEAR_MSG_FLAGS_CMD	0x30
 #define IPMI_GET_MSG_FLAGS_CMD		0x31
diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -43,6 +43,7 @@
 
 /* Structure for the low-level drivers. */
 typedef struct ipmi_smi *ipmi_smi_t;
+typedef struct smi_info *smi_info_t;
 
 /*
  * Messages to/from the lower layer.  The smi interface will take one

------=_Part_193_1482587.1125399403007--
