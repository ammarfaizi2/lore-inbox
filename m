Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWCVUpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWCVUpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWCVUpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:45:06 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:53899 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932430AbWCVUpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:45:04 -0500
Date: Wed, 22 Mar 2006 14:45:01 -0600
From: Corey Minyard <minyard@acm.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>,
       greg@kroah.com
Subject: [PATCH] Try 2, Fix release function in IPMI device model
Message-ID: <20060322204501.GA21213@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, one more try.  Russell, I assume you mean to use
platform_device_alloc(), which seems to do what you suggested.
And I assume the driver_data is the way to store whatever you
need, instead of using the container_of() macro.

Arjun, Russell, thanks for the info.

Now the patch...

Arjun van de Ven pointed out that the changeover to the driver model
in the IPMI driver had some bugs in it dealing with the release
function and cleanup.  Then Russell King pointed out that you can't
put release functions in the same module as the unregistering code.

This patch fixes those problems and also adds a semaphore around the
BMC functions and converts the BMC counter to a kref, which I meant to
do earlier, but didn't write down :(.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -163,11 +163,12 @@ struct ipmi_proc_entry
 
 struct bmc_device
 {
-	struct platform_device dev;
+	struct platform_device *dev;
 	struct ipmi_device_id  id;
 	unsigned char          guid[16];
 	int                    guid_set;
-	int                    interfaces;
+
+	struct kref	       refcount;
 
 	/* bmc device attributes */
 	struct device_attribute device_id_attr;
@@ -181,7 +182,6 @@ struct bmc_device
 	struct device_attribute guid_attr;
 	struct device_attribute aux_firmware_rev_attr;
 };
-#define to_bmc_device(device) container_of(device, struct bmc_device, dev)
 
 #define IPMI_IPMB_NUM_SEQ	64
 #define IPMI_MAX_CHANNELS       16
@@ -357,6 +357,7 @@ static struct device_driver ipmidriver =
 	.name = "ipmi",
 	.bus = &platform_bus_type
 };
+static DECLARE_MUTEX(ipmidriver_sem);
 
 #define MAX_IPMI_INTERFACES 4
 static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
@@ -1758,9 +1759,7 @@ static void remove_proc_entries(ipmi_smi
 static int __find_bmc_guid(struct device *dev, void *data)
 {
 	unsigned char *id = (unsigned char *) data;
-	struct bmc_device *bmc;
-
-	bmc = to_bmc_device(to_platform_device(dev));
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 	return memcmp(bmc->guid, id, 16) == 0;
 }
 
@@ -1771,7 +1770,7 @@ struct bmc_device * ipmi_find_bmc_guid(s
 
 	dev = driver_find_device(drv, NULL, guid, __find_bmc_guid);
 	if (dev)
-		return to_bmc_device(to_platform_device(dev));
+		return dev_get_drvdata(dev);
 	else
 		return NULL;
 }
@@ -1784,9 +1783,8 @@ struct prod_dev_id {
 static int __find_bmc_prod_dev_id(struct device *dev, void *data)
 {
 	struct prod_dev_id *id = (struct prod_dev_id *) data;
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return (bmc->id.product_id == id->product_id
 		&& bmc->id.product_id == id->product_id
 		&& bmc->id.device_id == id->device_id);
@@ -1804,23 +1802,17 @@ static struct bmc_device *ipmi_find_bmc_
 
 	dev = driver_find_device(drv, NULL, &id, __find_bmc_prod_dev_id);
 	if (dev)
-		return to_bmc_device(to_platform_device(dev));
+		return dev_get_drvdata(dev);
 	else
 		return NULL;
 }
 
-static void ipmi_bmc_release(struct device *dev)
-{
-	printk(KERN_DEBUG "ipmi_bmc release\n");
-}
-
 static ssize_t device_id_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 10, "%u\n", bmc->id.device_id);
 }
 
@@ -1828,9 +1820,8 @@ static ssize_t provides_dev_sdrs_show(st
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 10, "%u\n",
 			bmc->id.device_revision && 0x80 >> 7);
 }
@@ -1838,9 +1829,8 @@ static ssize_t provides_dev_sdrs_show(st
 static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 20, "%u\n",
 			bmc->id.device_revision && 0x0F);
 }
@@ -1849,9 +1839,8 @@ static ssize_t firmware_rev_show(struct 
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 20, "%u.%x\n", bmc->id.firmware_revision_1,
 			bmc->id.firmware_revision_2);
 }
@@ -1860,9 +1849,8 @@ static ssize_t ipmi_version_show(struct 
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 20, "%u.%u\n",
 			ipmi_version_major(&bmc->id),
 			ipmi_version_minor(&bmc->id));
@@ -1872,9 +1860,8 @@ static ssize_t add_dev_support_show(stru
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 10, "0x%02x\n",
 			bmc->id.additional_device_support);
 }
@@ -1883,9 +1870,8 @@ static ssize_t manufacturer_id_show(stru
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 20, "0x%6.6x\n", bmc->id.manufacturer_id);
 }
 
@@ -1893,9 +1879,8 @@ static ssize_t product_id_show(struct de
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 10, "0x%4.4x\n", bmc->id.product_id);
 }
 
@@ -1903,9 +1888,8 @@ static ssize_t aux_firmware_rev_show(str
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 21, "0x%02x 0x%02x 0x%02x 0x%02x\n",
 			bmc->id.aux_firmware_revision[3],
 			bmc->id.aux_firmware_revision[2],
@@ -1916,50 +1900,60 @@ static ssize_t aux_firmware_rev_show(str
 static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct bmc_device *bmc;
+	struct bmc_device *bmc = dev_get_drvdata(dev);
 
-	bmc = to_bmc_device(to_platform_device(dev));
 	return snprintf(buf, 100, "%Lx%Lx\n",
 			(long long) bmc->guid[0],
 			(long long) bmc->guid[8]);
 }
 
+static void
+cleanup_bmc_device(struct kref *ref)
+{
+	struct bmc_device *bmc;
+
+	bmc = container_of(ref, struct bmc_device, refcount);
+
+	device_remove_file(&bmc->dev->dev,
+			   &bmc->device_id_attr);
+	device_remove_file(&bmc->dev->dev,
+			   &bmc->provides_dev_sdrs_attr);
+	device_remove_file(&bmc->dev->dev,
+			   &bmc->revision_attr);
+	device_remove_file(&bmc->dev->dev,
+			   &bmc->firmware_rev_attr);
+	device_remove_file(&bmc->dev->dev,
+			   &bmc->version_attr);
+	device_remove_file(&bmc->dev->dev,
+			   &bmc->add_dev_support_attr);
+	device_remove_file(&bmc->dev->dev,
+			   &bmc->manufacturer_id_attr);
+	device_remove_file(&bmc->dev->dev,
+			   &bmc->product_id_attr);
+	if (bmc->id.aux_firmware_revision_set)
+		device_remove_file(&bmc->dev->dev,
+				   &bmc->aux_firmware_rev_attr);
+	if (bmc->guid_set)
+		device_remove_file(&bmc->dev->dev,
+				   &bmc->guid_attr);
+	platform_device_unregister(bmc->dev);
+	kfree(bmc);
+}
+
 static void ipmi_bmc_unregister(ipmi_smi_t intf)
 {
 	struct bmc_device *bmc = intf->bmc;
 
 	sysfs_remove_link(&intf->si_dev->kobj, "bmc");
 	if (intf->my_dev_name) {
-		sysfs_remove_link(&bmc->dev.dev.kobj, intf->my_dev_name);
+		sysfs_remove_link(&bmc->dev->dev.kobj, intf->my_dev_name);
 		kfree(intf->my_dev_name);
 		intf->my_dev_name = NULL;
 	}
 
-	bmc->interfaces--;
-	if (bmc->interfaces == 0) {
-		device_remove_file(&bmc->dev.dev,
-				&bmc->device_id_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->provides_dev_sdrs_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->revision_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->firmware_rev_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->version_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->add_dev_support_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->manufacturer_id_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->product_id_attr);
-		device_remove_file(&bmc->dev.dev,
-				&bmc->aux_firmware_rev_attr);
-		if (bmc->guid_set)
-			device_remove_file(&bmc->dev.dev,
-					   &bmc->guid_attr);
-		platform_device_unregister(&bmc->dev);
-	}
+	down(&ipmidriver_sem);
+	kref_put(&bmc->refcount, cleanup_bmc_device);
+	up(&ipmidriver_sem);
 }
 
 static int ipmi_bmc_register(ipmi_smi_t intf)
@@ -1970,6 +1964,8 @@ static int ipmi_bmc_register(ipmi_smi_t 
 	int               size;
 	char              dummy[1];
 
+	down(&ipmidriver_sem);
+
 	/*
 	 * Try to find if there is an bmc_device struct
 	 * representing the interfaced BMC already
@@ -1990,7 +1986,8 @@ static int ipmi_bmc_register(ipmi_smi_t 
 		intf->bmc = old_bmc;
 		bmc = old_bmc;
 
-		bmc->interfaces++;
+		kref_get(&bmc->refcount);
+		up(&ipmidriver_sem);
 
 		printk(KERN_INFO
 		       "ipmi: interfacing existing BMC (man_id: 0x%6.6x,"
@@ -1999,18 +1996,27 @@ static int ipmi_bmc_register(ipmi_smi_t 
 		       bmc->id.product_id,
 		       bmc->id.device_id);
 	} else {
-		bmc->dev.name = "ipmi_bmc";
-		bmc->dev.id = bmc->id.device_id;
-		bmc->dev.dev.driver = &ipmidriver;
-		bmc->dev.dev.release = ipmi_bmc_release;
-		bmc->interfaces = 1;
+		bmc->dev = platform_device_alloc("ipmi_bmc",
+						 bmc->id.device_id);
+		if (! bmc->dev) {
+			printk(KERN_ERR
+			       "ipmi_msghandler:"
+			       " Unable to allocate platform device\n");
+			return -ENOMEM;
+		}
+		bmc->dev->dev.driver = &ipmidriver;
+		dev_set_drvdata(&bmc->dev->dev, bmc);
+		kref_init(&bmc->refcount);
 
-		rv = platform_device_register(&bmc->dev);
+		rv = platform_device_register(bmc->dev);
+		up(&ipmidriver_sem);
 		if (rv) {
 			printk(KERN_ERR
 			       "ipmi_msghandler:"
 			       " Unable to register bmc device: %d\n",
 			       rv);
+			/* Don't go to out_err, you can only do that if
+			   the device is registered already. */
 			return rv;
 		}
 
@@ -2066,27 +2072,27 @@ static int ipmi_bmc_register(ipmi_smi_t 
 		bmc->aux_firmware_rev_attr.attr.mode = S_IRUGO;
 		bmc->aux_firmware_rev_attr.show = aux_firmware_rev_show;
 
-		device_create_file(&bmc->dev.dev,
+		device_create_file(&bmc->dev->dev,
 				   &bmc->device_id_attr);
-		device_create_file(&bmc->dev.dev,
+		device_create_file(&bmc->dev->dev,
 				   &bmc->provides_dev_sdrs_attr);
-		device_create_file(&bmc->dev.dev,
+		device_create_file(&bmc->dev->dev,
 				   &bmc->revision_attr);
-		device_create_file(&bmc->dev.dev,
+		device_create_file(&bmc->dev->dev,
 				   &bmc->firmware_rev_attr);
-		device_create_file(&bmc->dev.dev,
+		device_create_file(&bmc->dev->dev,
 				   &bmc->version_attr);
-		device_create_file(&bmc->dev.dev,
+		device_create_file(&bmc->dev->dev,
 				   &bmc->add_dev_support_attr);
-		device_create_file(&bmc->dev.dev,
+		device_create_file(&bmc->dev->dev,
 				   &bmc->manufacturer_id_attr);
-		device_create_file(&bmc->dev.dev,
+		device_create_file(&bmc->dev->dev,
 				   &bmc->product_id_attr);
 		if (bmc->id.aux_firmware_revision_set)
-			device_create_file(&bmc->dev.dev,
+			device_create_file(&bmc->dev->dev,
 					   &bmc->aux_firmware_rev_attr);
 		if (bmc->guid_set)
-			device_create_file(&bmc->dev.dev,
+			device_create_file(&bmc->dev->dev,
 					   &bmc->guid_attr);
 
 		printk(KERN_INFO
@@ -2102,7 +2108,7 @@ static int ipmi_bmc_register(ipmi_smi_t 
 	 * and back.
 	 */
 	rv = sysfs_create_link(&intf->si_dev->kobj,
-			       &bmc->dev.dev.kobj, "bmc");
+			       &bmc->dev->dev.kobj, "bmc");
 	if (rv) {
 		printk(KERN_ERR
 		       "ipmi_msghandler: Unable to create bmc symlink: %d\n",
@@ -2121,7 +2127,7 @@ static int ipmi_bmc_register(ipmi_smi_t 
 	}
 	snprintf(intf->my_dev_name, size+1, "ipmi%d", intf->intf_num);
 
-	rv = sysfs_create_link(&bmc->dev.dev.kobj, &intf->si_dev->kobj,
+	rv = sysfs_create_link(&bmc->dev->dev.kobj, &intf->si_dev->kobj,
 			       intf->my_dev_name);
 	if (rv) {
 		kfree(intf->my_dev_name);
Index: linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
@@ -206,7 +206,10 @@ struct smi_info
 
 	/* Driver model stuff. */
 	struct device *dev;
-	struct platform_device idev;
+	struct platform_device *pdev;
+
+	 /* True if we allocated the device, false if it came from
+	  * someplace else (like PCI). */
 	int dev_registered;
 
 	/* Slave address, could be reported from DMI. */
@@ -1161,7 +1164,6 @@ static void port_cleanup(struct smi_info
 
 		release_region (addr, mapsize);
 	}
-	kfree(info);
 }
 
 static int port_setup(struct smi_info *info)
@@ -1270,7 +1272,6 @@ static void mem_cleanup(struct smi_info 
 
 		release_mem_region(addr, mapsize);
 	}
-	kfree(info);
 }
 
 static int mem_setup(struct smi_info *info)
@@ -2233,11 +2234,6 @@ static int is_new_interface(struct smi_i
 	return 1;
 }
 
-static void si_release(struct device *dev)
-{
-	printk(KERN_DEBUG "ipmi_si release\n");
-}
-
 static int try_smi_init(struct smi_info *new_smi)
 {
 	int rv;
@@ -2367,12 +2363,18 @@ static int try_smi_init(struct smi_info 
 	if (!new_smi->dev) {
 		/* If we don't already have a device from something
 		 * else (like PCI), then register a new one. */
-		new_smi->idev.name = "ipmi_si";
-		new_smi->idev.id = new_smi->intf_num;
-		new_smi->idev.dev.driver = &ipmi_driver;
-		new_smi->idev.dev.release = si_release;
+		new_smi->pdev = platform_device_alloc("ipmi_si",
+						      new_smi->intf_num);
+		if (rv) {
+			printk(KERN_ERR
+			       "ipmi_si_intf:"
+			       " Unable to allocate platform device\n");
+			goto out_err_stop_timer;
+		}
+		new_smi->dev = &new_smi->pdev->dev;
+		new_smi->dev->driver = &ipmi_driver;
 
-		rv = platform_device_register(&new_smi->idev);
+		rv = platform_device_register(new_smi->pdev);
 		if (rv) {
 			printk(KERN_ERR
 			       "ipmi_si_intf:"
@@ -2381,7 +2383,6 @@ static int try_smi_init(struct smi_info 
 			       rv);
 			goto out_err_stop_timer;
 		}
-		new_smi->dev = &new_smi->idev.dev;
 		new_smi->dev_registered = 1;
 	}
 
@@ -2395,7 +2396,7 @@ static int try_smi_init(struct smi_info 
 		printk(KERN_ERR
 		       "ipmi_si: Unable to register device: error %d\n",
 		       rv);
-		goto out_err_unreg_dev;
+		goto out_err_stop_timer;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "type",
@@ -2405,7 +2406,7 @@ static int try_smi_init(struct smi_info 
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err_unreg_dev;
+		goto out_err_stop_timer;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "si_stats",
@@ -2415,7 +2416,7 @@ static int try_smi_init(struct smi_info 
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err_unreg_dev;
+		goto out_err_stop_timer;
 	}
 
 	list_add_tail(&new_smi->link, &smi_infos);
@@ -2426,10 +2427,6 @@ static int try_smi_init(struct smi_info 
 
 	return 0;
 
- out_err_unreg_dev:
-	if (new_smi->dev_registered)
-		platform_device_unregister(&new_smi->idev);
-
  out_err_stop_timer:
 	atomic_inc(&new_smi->stop_operation);
 	wait_for_timer_and_thread(new_smi);
@@ -2456,6 +2453,11 @@ static int try_smi_init(struct smi_info 
 	if (new_smi->io_cleanup)
 		new_smi->io_cleanup(new_smi);
 
+	if (new_smi->dev_registered)
+		platform_device_unregister(new_smi->pdev);
+
+	kfree(new_smi);
+
 	up(&smi_infos_lock);
 
 	return rv;
@@ -2583,9 +2585,6 @@ static void __devexit cleanup_one_si(str
 		       rv);
 	}
 
-	if (to_clean->dev_registered)
-		platform_device_unregister(&to_clean->idev);
-
 	to_clean->handlers->cleanup(to_clean->si_sm);
 
 	kfree(to_clean->si_sm);
@@ -2594,6 +2593,11 @@ static void __devexit cleanup_one_si(str
 		to_clean->addr_source_cleanup(to_clean);
 	if (to_clean->io_cleanup)
 		to_clean->io_cleanup(to_clean);
+
+	if (to_clean->dev_registered)
+		platform_device_unregister(to_clean->pdev);
+
+	kfree(to_clean);
 }
 
 static __exit void cleanup_ipmi_si(void)
