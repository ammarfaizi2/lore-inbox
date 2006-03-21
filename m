Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWCUWNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWCUWNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbWCUWNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:13:33 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:32194 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965131AbWCUWNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:13:31 -0500
Date: Tue, 21 Mar 2006 16:13:28 -0600
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>
Subject: [PATCH 2/2] Add full sysfs support to the IPMI driver
Message-ID: <20060321221328.GB27436@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds full driver model support for the IPMI driver.  It
links in the proper bus and device support.

It adds an "ipmi" driver interface that has each BMC discovered by the
driver (as a device).  These BMCs appear in the devices/platform
directory.  If there are multiple interfaces to the same BMC, the
driver should discover this and will only have one BMC entry.  The BMC
entry will have pointers to each interface device that connects to it.

The device information (statistics and config information) has not yet
been ported over to the driver model from proc, that will come later.

This work was based on work by Yani Ioannou.  I basically rewrote it
using that code as a guide, but he still deserves credit :).

Signed-off-by: Corey Minyard

 drivers/char/ipmi/ipmi_devintf.c    |   46 ++-
 drivers/char/ipmi/ipmi_msghandler.c |  547 +++++++++++++++++++++++++++++++++++-
 drivers/char/ipmi/ipmi_poweroff.c   |    2 
 drivers/char/ipmi/ipmi_si_intf.c    |  108 ++++---
 drivers/char/ipmi/ipmi_watchdog.c   |    2 
 include/linux/ipmi.h                |    3 
 include/linux/ipmi_msgdefs.h        |    1 
 include/linux/ipmi_smi.h            |   47 ++-
 8 files changed, 701 insertions(+), 55 deletions(-)

Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -162,6 +162,28 @@ struct ipmi_proc_entry
 };
 #endif
 
+struct bmc_device
+{
+	struct platform_device dev;
+	struct ipmi_device_id  id;
+	unsigned char          guid[16];
+	int                    guid_set;
+	int                    interfaces;
+
+	/* bmc device attributes */
+	struct device_attribute device_id_attr;
+	struct device_attribute provides_dev_sdrs_attr;
+	struct device_attribute revision_attr;
+	struct device_attribute firmware_rev_attr;
+	struct device_attribute version_attr;
+	struct device_attribute add_dev_support_attr;
+	struct device_attribute manufacturer_id_attr;
+	struct device_attribute product_id_attr;
+	struct device_attribute guid_attr;
+	struct device_attribute aux_firmware_rev_attr;
+};
+#define to_bmc_device(device) container_of(device, struct bmc_device, dev)
+
 #define IPMI_IPMB_NUM_SEQ	64
 #define IPMI_MAX_CHANNELS       16
 struct ipmi_smi
@@ -178,9 +200,8 @@ struct ipmi_smi
 	/* Used for wake ups at startup. */
 	wait_queue_head_t waitq;
 
-	/* The IPMI version of the BMC on the other end. */
-	unsigned char       version_major;
-	unsigned char       version_minor;
+	struct bmc_device *bmc;
+	char *my_dev_name;
 
 	/* This is the lower-layer's sender routine. */
 	struct ipmi_smi_handlers *handlers;
@@ -194,6 +215,9 @@ struct ipmi_smi
 	struct ipmi_proc_entry *proc_entries;
 #endif
 
+	/* Driver-model device for the system interface. */
+	struct device          *si_dev;
+
 	/* A table of sequence numbers for this interface.  We use the
            sequence numbers for IPMB messages that go out of the
            interface to match them up with their responses.  A routine
@@ -312,6 +336,7 @@ struct ipmi_smi
 	/* Events that were received with the proper format. */
 	unsigned int events;
 };
+#define to_si_intf_from_dev(device) container_of(device, struct ipmi_smi, dev)
 
 /* Used to mark an interface entry that cannot be used but is not a
  * free entry, either, primarily used at creation and deletion time so
@@ -320,6 +345,14 @@ struct ipmi_smi
 #define IPMI_INVALID_INTERFACE(i) (((i) == NULL) \
 				   || (i == IPMI_INVALID_INTERFACE_ENTRY))
 
+/**
+ * The driver model view of the IPMI messaging driver.
+ */
+static struct device_driver ipmidriver = {
+	.name = "ipmi",
+	.bus = &platform_bus_type
+};
+
 #define MAX_IPMI_INTERFACES 4
 static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
 
@@ -393,7 +426,7 @@ int ipmi_smi_watcher_register(struct ipm
 		if (IPMI_INVALID_INTERFACE(intf))
 			continue;
 		spin_unlock_irqrestore(&interfaces_lock, flags);
-		watcher->new_smi(i);
+		watcher->new_smi(i, intf->si_dev);
 		spin_lock_irqsave(&interfaces_lock, flags);
 	}
 	spin_unlock_irqrestore(&interfaces_lock, flags);
@@ -409,14 +442,14 @@ int ipmi_smi_watcher_unregister(struct i
 }
 
 static void
-call_smi_watchers(int i)
+call_smi_watchers(int i, struct device *dev)
 {
 	struct ipmi_smi_watcher *w;
 
 	down_read(&smi_watchers_sem);
 	list_for_each_entry(w, &smi_watchers, link) {
 		if (try_module_get(w->owner)) {
-			w->new_smi(i);
+			w->new_smi(i, dev);
 			module_put(w->owner);
 		}
 	}
@@ -842,8 +875,8 @@ void ipmi_get_version(ipmi_user_t   user
 		      unsigned char *major,
 		      unsigned char *minor)
 {
-	*major = user->intf->version_major;
-	*minor = user->intf->version_minor;
+	*major = ipmi_version_major(&user->intf->bmc->id);
+	*minor = ipmi_version_minor(&user->intf->bmc->id);
 }
 
 int ipmi_set_my_address(ipmi_user_t   user,
@@ -1551,7 +1584,8 @@ static int version_file_read_proc(char *
 	ipmi_smi_t intf = data;
 
 	return sprintf(out, "%d.%d\n",
-		       intf->version_major, intf->version_minor);
+		       ipmi_version_major(&intf->bmc->id),
+		       ipmi_version_minor(&intf->bmc->id));
 }
 
 static int stat_file_read_proc(char *page, char **start, off_t off,
@@ -1710,6 +1744,465 @@ static void remove_proc_entries(ipmi_smi
 #endif /* CONFIG_PROC_FS */
 }
 
+static int __find_bmc_guid(struct device *dev, void *data)
+{
+	unsigned char *id = (unsigned char *) data;
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return memcmp(bmc->guid, id, 16) == 0;
+}
+
+struct bmc_device * ipmi_find_bmc_guid(struct device_driver *drv,
+				       unsigned char *guid)
+{
+	struct device *dev;
+
+	dev = driver_find_device(drv, NULL, guid, __find_bmc_guid);
+	if (dev)
+		return to_bmc_device(to_platform_device(dev));
+	else
+		return NULL;
+}
+
+struct prod_dev_id {
+	unsigned int  product_id;
+	unsigned char device_id;
+};
+
+static int __find_bmc_prod_dev_id(struct device *dev, void *data)
+{
+	struct prod_dev_id *id = (struct prod_dev_id *) data;
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return (bmc->id.product_id == id->product_id
+		&& bmc->id.product_id == id->product_id
+		&& bmc->id.device_id == id->device_id);
+}
+
+static struct bmc_device *ipmi_find_bmc_prod_dev_id(
+	struct device_driver *drv,
+	unsigned char product_id, unsigned char device_id)
+{
+	struct prod_dev_id id = {
+		.product_id = product_id,
+		.device_id = device_id,
+	};
+	struct device *dev;
+
+	dev = driver_find_device(drv, NULL, &id, __find_bmc_prod_dev_id);
+	if (dev)
+		return to_bmc_device(to_platform_device(dev));
+	else
+		return NULL;
+}
+
+static void ipmi_bmc_release(struct device *dev)
+{
+	printk(KERN_DEBUG "ipmi_bmc release\n");
+}
+
+static ssize_t device_id_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "%u\n", bmc->id.device_id);
+}
+
+static ssize_t provides_dev_sdrs_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "%u\n",
+			bmc->id.device_revision && 0x80 >> 7);
+}
+
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u\n",
+			bmc->id.device_revision && 0x0F);
+}
+
+static ssize_t firmware_rev_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u.%x\n", bmc->id.firmware_revision_1,
+			bmc->id.firmware_revision_2);
+}
+
+static ssize_t ipmi_version_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u.%u\n",
+			ipmi_version_major(&bmc->id),
+			ipmi_version_minor(&bmc->id));
+}
+
+static ssize_t add_dev_support_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "0x%02x\n",
+			bmc->id.additional_device_support);
+}
+
+static ssize_t manufacturer_id_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "0x%6.6x\n", bmc->id.manufacturer_id);
+}
+
+static ssize_t product_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "0x%4.4x\n", bmc->id.product_id);
+}
+
+static ssize_t aux_firmware_rev_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 21, "0x%02x 0x%02x 0x%02x 0x%02x\n",
+			bmc->id.aux_firmware_revision[3],
+			bmc->id.aux_firmware_revision[2],
+			bmc->id.aux_firmware_revision[1],
+			bmc->id.aux_firmware_revision[0]);
+}
+
+static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct bmc_device *bmc;
+
+	bmc = to_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 100, "%Lx%Lx\n",
+			(long long) bmc->guid[0],
+			(long long) bmc->guid[8]);
+}
+
+static void ipmi_bmc_unregister(ipmi_smi_t intf)
+{
+	struct bmc_device *bmc = intf->bmc;
+
+	sysfs_remove_link(&intf->si_dev->kobj, "bmc");
+	if (intf->my_dev_name) {
+		sysfs_remove_link(&bmc->dev.dev.kobj, intf->my_dev_name);
+		kfree(intf->my_dev_name);
+		intf->my_dev_name = NULL;
+	}
+
+	bmc->interfaces--;
+	if (bmc->interfaces == 0) {
+		device_remove_file(&bmc->dev.dev,
+				&bmc->device_id_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->provides_dev_sdrs_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->revision_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->firmware_rev_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->version_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->add_dev_support_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->manufacturer_id_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->product_id_attr);
+		device_remove_file(&bmc->dev.dev,
+				&bmc->aux_firmware_rev_attr);
+		if (bmc->guid_set)
+			device_remove_file(&bmc->dev.dev,
+					   &bmc->guid_attr);
+		platform_device_unregister(&bmc->dev);
+	}
+}
+
+static int ipmi_bmc_register(ipmi_smi_t intf)
+{
+	int               rv;
+	struct bmc_device *bmc = intf->bmc;
+	struct bmc_device *old_bmc;
+	int               size;
+	char              dummy[1];
+
+	/*
+	 * Try to find if there is an bmc_device struct
+	 * representing the interfaced BMC already
+	 */
+	if (bmc->guid_set)
+		old_bmc = ipmi_find_bmc_guid(&ipmidriver, bmc->guid);
+	else
+		old_bmc = ipmi_find_bmc_prod_dev_id(&ipmidriver,
+						    bmc->id.product_id,
+						    bmc->id.device_id);
+
+	/*
+	 * If there is already an bmc_device, free the new one,
+	 * otherwise register the new BMC device
+	 */
+	if (old_bmc) {
+		kfree(bmc);
+		intf->bmc = old_bmc;
+		bmc = old_bmc;
+
+		bmc->interfaces++;
+
+		printk(KERN_INFO
+		       "ipmi: interfacing existing BMC (man_id: 0x%6.6x,"
+		       " prod_id: 0x%4.4x, dev_id: 0x%2.2x)\n",
+		       bmc->id.manufacturer_id,
+		       bmc->id.product_id,
+		       bmc->id.device_id);
+	} else {
+		bmc->dev.name = "ipmi_bmc";
+		bmc->dev.id = bmc->id.device_id;
+		bmc->dev.dev.driver = &ipmidriver;
+		bmc->dev.dev.release = ipmi_bmc_release;
+		bmc->interfaces = 1;
+
+		rv = platform_device_register(&bmc->dev);
+		if (rv) {
+			printk(KERN_ERR
+			       "ipmi_msghandler:"
+			       " Unable to register bmc device: %d\n",
+			       rv);
+			return rv;
+		}
+
+		bmc->device_id_attr.attr.name = "device_id";
+		bmc->device_id_attr.attr.owner = THIS_MODULE;
+		bmc->device_id_attr.attr.mode = S_IRUGO;
+		bmc->device_id_attr.show = device_id_show;
+
+		bmc->provides_dev_sdrs_attr.attr.name = "provides_device_sdrs";
+		bmc->provides_dev_sdrs_attr.attr.owner = THIS_MODULE;
+		bmc->provides_dev_sdrs_attr.attr.mode = S_IRUGO;
+		bmc->provides_dev_sdrs_attr.show = provides_dev_sdrs_show;
+
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
+		bmc->version_attr.attr.name = "ipmi_version";
+		bmc->version_attr.attr.owner = THIS_MODULE;
+		bmc->version_attr.attr.mode = S_IRUGO;
+		bmc->version_attr.show = ipmi_version_show;
+
+		bmc->add_dev_support_attr.attr.name
+			= "additional_device_support";
+		bmc->add_dev_support_attr.attr.owner = THIS_MODULE;
+		bmc->add_dev_support_attr.attr.mode = S_IRUGO;
+		bmc->add_dev_support_attr.show = add_dev_support_show;
+
+		bmc->manufacturer_id_attr.attr.name = "manufacturer_id";
+		bmc->manufacturer_id_attr.attr.owner = THIS_MODULE;
+		bmc->manufacturer_id_attr.attr.mode = S_IRUGO;
+		bmc->manufacturer_id_attr.show = manufacturer_id_show;
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
+		bmc->aux_firmware_rev_attr.attr.name = "aux_firmware_revision";
+		bmc->aux_firmware_rev_attr.attr.owner = THIS_MODULE;
+		bmc->aux_firmware_rev_attr.attr.mode = S_IRUGO;
+		bmc->aux_firmware_rev_attr.show = aux_firmware_rev_show;
+
+		device_create_file(&bmc->dev.dev,
+				   &bmc->device_id_attr);
+		device_create_file(&bmc->dev.dev,
+				   &bmc->provides_dev_sdrs_attr);
+		device_create_file(&bmc->dev.dev,
+				   &bmc->revision_attr);
+		device_create_file(&bmc->dev.dev,
+				   &bmc->firmware_rev_attr);
+		device_create_file(&bmc->dev.dev,
+				   &bmc->version_attr);
+		device_create_file(&bmc->dev.dev,
+				   &bmc->add_dev_support_attr);
+		device_create_file(&bmc->dev.dev,
+				   &bmc->manufacturer_id_attr);
+		device_create_file(&bmc->dev.dev,
+				   &bmc->product_id_attr);
+		if (bmc->id.aux_firmware_revision_set)
+			device_create_file(&bmc->dev.dev,
+					   &bmc->aux_firmware_rev_attr);
+		if (bmc->guid_set)
+			device_create_file(&bmc->dev.dev,
+					   &bmc->guid_attr);
+
+		printk(KERN_INFO
+		       "ipmi: Found new BMC (man_id: 0x%6.6x, "
+		       " prod_id: 0x%4.4x, dev_id: 0x%2.2x)\n",
+		       bmc->id.manufacturer_id,
+		       bmc->id.product_id,
+		       bmc->id.device_id);
+	}
+
+	/*
+	 * create symlink from system interface device to bmc device
+	 * and back.
+	 */
+	rv = sysfs_create_link(&intf->si_dev->kobj,
+			       &bmc->dev.dev.kobj, "bmc");
+	if (rv) {
+		printk(KERN_ERR
+		       "ipmi_msghandler: Unable to create bmc symlink: %d\n",
+		       rv);
+		goto out_err;
+	}
+
+	size = snprintf(dummy, 0, "ipmi%d", intf->intf_num);
+	intf->my_dev_name = kmalloc(size+1, GFP_KERNEL);
+	if (!intf->my_dev_name) {
+		rv = -ENOMEM;
+		printk(KERN_ERR
+		       "ipmi_msghandler: allocate link from BMC: %d\n",
+		       rv);
+		goto out_err;
+	}
+	snprintf(intf->my_dev_name, size+1, "ipmi%d", intf->intf_num);
+
+	rv = sysfs_create_link(&bmc->dev.dev.kobj, &intf->si_dev->kobj,
+			       intf->my_dev_name);
+	if (rv) {
+		kfree(intf->my_dev_name);
+		intf->my_dev_name = NULL;
+		printk(KERN_ERR
+		       "ipmi_msghandler:"
+		       " Unable to create symlink to bmc: %d\n",
+		       rv);
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	ipmi_bmc_unregister(intf);
+	return rv;
+}
+
+static int
+send_guid_cmd(ipmi_smi_t intf, int chan)
+{
+	struct kernel_ipmi_msg            msg;
+	struct ipmi_system_interface_addr si;
+
+	si.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	si.channel = IPMI_BMC_CHANNEL;
+	si.lun = 0;
+
+	msg.netfn = IPMI_NETFN_APP_REQUEST;
+	msg.cmd = IPMI_GET_DEVICE_GUID_CMD;
+	msg.data = NULL;
+	msg.data_len = 0;
+	return i_ipmi_request(NULL,
+			      intf,
+			      (struct ipmi_addr *) &si,
+			      0,
+			      &msg,
+			      intf,
+			      NULL,
+			      NULL,
+			      0,
+			      intf->channels[0].address,
+			      intf->channels[0].lun,
+			      -1, 0);
+}
+
+static void
+guid_handler(ipmi_smi_t intf, struct ipmi_recv_msg *msg)
+{
+	if ((msg->addr.addr_type != IPMI_SYSTEM_INTERFACE_ADDR_TYPE)
+	    || (msg->msg.netfn != IPMI_NETFN_APP_RESPONSE)
+	    || (msg->msg.cmd != IPMI_GET_DEVICE_GUID_CMD))
+		/* Not for me */
+		return;
+
+	if (msg->msg.data[0] != 0) {
+		/* Error from getting the GUID, the BMC doesn't have one. */
+		intf->bmc->guid_set = 0;
+		goto out;
+	}
+
+	if (msg->msg.data_len < 17) {
+		intf->bmc->guid_set = 0;
+		printk(KERN_WARNING PFX
+		       "guid_handler: The GUID response from the BMC was too"
+		       " short, it was %d but should have been 17.  Assuming"
+		       " GUID is not available.\n",
+		       msg->msg.data_len);
+		goto out;
+	}
+
+	memcpy(intf->bmc->guid, msg->msg.data, 16);
+	intf->bmc->guid_set = 1;
+ out:
+	wake_up(&intf->waitq);
+}
+
+static void
+get_guid(ipmi_smi_t intf)
+{
+	int rv;
+
+	intf->bmc->guid_set = 0x2;
+	intf->null_user_handler = guid_handler;
+	rv = send_guid_cmd(intf, 0);
+	if (rv)
+		/* Send failed, no GUID available. */
+		intf->bmc->guid_set = 0;
+	wait_event(intf->waitq, intf->bmc->guid_set != 2);
+	intf->null_user_handler = NULL;
+}
+
 static int
 send_channel_info_cmd(ipmi_smi_t intf, int chan)
 {
@@ -1802,8 +2295,8 @@ channel_handler(ipmi_smi_t intf, struct 
 
 int ipmi_register_smi(struct ipmi_smi_handlers *handlers,
 		      void		       *send_info,
-		      unsigned char            version_major,
-		      unsigned char            version_minor,
+		      struct ipmi_device_id    *device_id,
+		      struct device            *si_dev,
 		      unsigned char            slave_addr,
 		      ipmi_smi_t               *new_intf)
 {
@@ -1811,7 +2304,11 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	int              rv;
 	ipmi_smi_t       intf;
 	unsigned long    flags;
+	int              version_major;
+	int              version_minor;
 
+	version_major = ipmi_version_major(device_id);
+	version_minor = ipmi_version_minor(device_id);
 
 	/* Make sure the driver is actually initialized, this handles
 	   problems with initialization order. */
@@ -1829,10 +2326,16 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	if (!intf)
 		return -ENOMEM;
 	memset(intf, 0, sizeof(*intf));
+	intf->bmc = kmalloc(sizeof(*intf->bmc), GFP_KERNEL);
+	if (!intf->bmc) {
+		kfree(intf);
+		return -ENOMEM;
+	}
+	memset(intf->bmc, 0, sizeof(*intf->bmc));
 	intf->intf_num = -1;
 	kref_init(&intf->refcount);
-	intf->version_major = version_major;
-	intf->version_minor = version_minor;
+	intf->bmc->id = *device_id;
+	intf->si_dev = si_dev;
 	for (j = 0; j < IPMI_MAX_CHANNELS; j++) {
 		intf->channels[j].address = IPMI_BMC_SLAVE_ADDR;
 		intf->channels[j].lun = 2;
@@ -1882,6 +2385,8 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	   caller before sending any messages with it. */
 	*new_intf = intf;
 
+	get_guid(intf);
+
 	if ((version_major > 1)
 	    || ((version_major == 1) && (version_minor >= 5)))
 	{
@@ -1896,6 +2401,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		/* Wait for the channel info to be read. */
 		wait_event(intf->waitq,
 			   intf->curr_channel >= IPMI_MAX_CHANNELS);
+		intf->null_user_handler = NULL;
 	} else {
 		/* Assume a single IPMB channel at zero. */
 		intf->channels[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
@@ -1905,6 +2411,8 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	if (rv == 0)
 		rv = add_proc_entries(intf, i);
 
+	rv = ipmi_bmc_register(intf);
+
  out:
 	if (rv) {
 		if (intf->proc_dir)
@@ -1919,7 +2427,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		spin_lock_irqsave(&interfaces_lock, flags);
 		ipmi_interfaces[i] = intf;
 		spin_unlock_irqrestore(&interfaces_lock, flags);
-		call_smi_watchers(i);
+		call_smi_watchers(i, intf->si_dev);
 	}
 
 	return rv;
@@ -1931,6 +2439,8 @@ int ipmi_unregister_smi(ipmi_smi_t intf)
 	struct ipmi_smi_watcher *w;
 	unsigned long           flags;
 
+	ipmi_bmc_unregister(intf);
+
 	spin_lock_irqsave(&interfaces_lock, flags);
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		if (ipmi_interfaces[i] == intf) {
@@ -3194,10 +3704,17 @@ static struct notifier_block panic_block
 static int ipmi_init_msghandler(void)
 {
 	int i;
+	int rv;
 
 	if (initialized)
 		return 0;
 
+	rv = driver_register(&ipmidriver);
+	if (rv) {
+		printk(KERN_ERR PFX "Could not register IPMI driver\n");
+		return rv;
+	}
+
 	printk(KERN_INFO "ipmi message handler version "
 	       IPMI_DRIVER_VERSION "\n");
 
@@ -3254,6 +3771,8 @@ static __exit void cleanup_ipmi(void)
 	remove_proc_entry(proc_ipmi_root->name, &proc_root);
 #endif /* CONFIG_PROC_FS */
 
+	driver_unregister(&ipmidriver);
+
 	initialized = 0;
 
 	/* Check for buffer leaks. */
Index: linux-2.6.16/include/linux/ipmi_msgdefs.h
===================================================================
--- linux-2.6.16.orig/include/linux/ipmi_msgdefs.h
+++ linux-2.6.16/include/linux/ipmi_msgdefs.h
@@ -47,6 +47,7 @@
 #define IPMI_NETFN_APP_RESPONSE			0x07
 #define IPMI_GET_DEVICE_ID_CMD		0x01
 #define IPMI_CLEAR_MSG_FLAGS_CMD	0x30
+#define IPMI_GET_DEVICE_GUID_CMD	0x08
 #define IPMI_GET_MSG_FLAGS_CMD		0x31
 #define IPMI_SEND_MSG_CMD		0x34
 #define IPMI_GET_MSG_CMD		0x33
Index: linux-2.6.16/include/linux/ipmi_smi.h
===================================================================
--- linux-2.6.16.orig/include/linux/ipmi_smi.h
+++ linux-2.6.16/include/linux/ipmi_smi.h
@@ -37,6 +37,9 @@
 #include <linux/ipmi_msgdefs.h>
 #include <linux/proc_fs.h>
 #include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/ipmi_smi.h>
 
 /* This files describes the interface for IPMI system management interface
    drivers to bind into the IPMI message handler. */
@@ -113,12 +116,52 @@ struct ipmi_smi_handlers
 	void (*dec_usecount)(void *send_info);
 };
 
+struct ipmi_device_id {
+	unsigned char device_id;
+	unsigned char device_revision;
+	unsigned char firmware_revision_1;
+	unsigned char firmware_revision_2;
+	unsigned char ipmi_version;
+	unsigned char additional_device_support;
+	unsigned int  manufacturer_id;
+	unsigned int  product_id;
+	unsigned char aux_firmware_revision[4];
+	unsigned int  aux_firmware_revision_set : 1;
+};
+
+#define ipmi_version_major(v) ((v)->ipmi_version & 0xf)
+#define ipmi_version_minor(v) ((v)->ipmi_version >> 4)
+
+/* Take a pointer to a raw data buffer and a length and extract device
+   id information from it.  The first byte of data must point to the
+   byte from the get device id response after the completion code.
+   The caller is responsible for making sure the length is at least
+   11 and the command completed without error. */
+static inline void ipmi_demangle_device_id(unsigned char *data,
+					   unsigned int  data_len,
+					   struct ipmi_device_id *id)
+{
+	id->device_id = data[0];
+	id->device_revision = data[1];
+	id->firmware_revision_1 = data[2];
+	id->firmware_revision_2 = data[3];
+	id->ipmi_version = data[4];
+	id->additional_device_support = data[5];
+	id->manufacturer_id = data[6] | (data[7] << 8) | (data[8] << 16);
+	id->product_id = data[9] | (data[10] << 8);
+	if (data_len >= 15) {
+		memcpy(id->aux_firmware_revision, data+11, 4);
+		id->aux_firmware_revision_set = 1;
+	} else
+		id->aux_firmware_revision_set = 0;
+}
+
 /* Add a low-level interface to the IPMI driver.  Note that if the
    interface doesn't know its slave address, it should pass in zero. */
 int ipmi_register_smi(struct ipmi_smi_handlers *handlers,
 		      void                     *send_info,
-		      unsigned char            version_major,
-		      unsigned char            version_minor,
+		      struct ipmi_device_id    *device_id,
+		      struct device            *dev,
 		      unsigned char            slave_addr,
 		      ipmi_smi_t               *intf);
 
Index: linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
@@ -112,20 +112,13 @@ enum si_type {
 };
 static char *si_to_str[] = { "KCS", "SMIC", "BT" };
 
-struct ipmi_device_id {
-	unsigned char device_id;
-	unsigned char device_revision;
-	unsigned char firmware_revision_1;
-	unsigned char firmware_revision_2;
-	unsigned char ipmi_version;
-	unsigned char additional_device_support;
-	unsigned char manufacturer_id[3];
-	unsigned char product_id[2];
-	unsigned char aux_firmware_revision[4];
-} __attribute__((packed));
+#define DEVICE_NAME "ipmi_si"
 
-#define ipmi_version_major(v) ((v)->ipmi_version & 0xf)
-#define ipmi_version_minor(v) ((v)->ipmi_version >> 4)
+static struct device_driver ipmi_driver =
+{
+	.name = DEVICE_NAME,
+	.bus = &platform_bus_type
+};
 
 struct smi_info
 {
@@ -208,8 +201,14 @@ struct smi_info
 	   interrupts. */
 	int interrupt_disabled;
 
+	/* From the get device id response... */
 	struct ipmi_device_id device_id;
 
+	/* Driver model stuff. */
+	struct device *dev;
+	struct platform_device idev;
+	int dev_registered;
+
 	/* Slave address, could be reported from DMI. */
 	unsigned char slave_addr;
 
@@ -987,8 +986,6 @@ static LIST_HEAD(smi_infos);
 static DECLARE_MUTEX(smi_infos_lock);
 static int smi_num; /* Used to sequence the SMIs */
 
-#define DEVICE_NAME "ipmi_si"
-
 #define DEFAULT_REGSPACING	1
 
 static int           si_trydefaults = 1;
@@ -1862,6 +1859,8 @@ static int __devinit ipmi_pci_probe(stru
 	if (info->irq)
 		info->irq_setup = std_irq_setup;
 
+	info->dev = &pdev->dev;
+
 	return try_smi_init(info);
 }
 
@@ -1902,11 +1901,11 @@ static struct pci_driver ipmi_pci_driver
 
 static int try_get_dev_id(struct smi_info *smi_info)
 {
-	unsigned char      msg[2];
-	unsigned char      *resp;
-	unsigned long      resp_len;
-	enum si_sm_result smi_result;
-	int               rv = 0;
+	unsigned char         msg[2];
+	unsigned char         *resp;
+	unsigned long         resp_len;
+	enum si_sm_result     smi_result;
+	int                   rv = 0;
 
 	resp = kmalloc(IPMI_MAX_MSG_LENGTH, GFP_KERNEL);
 	if (! resp)
@@ -1945,7 +1944,7 @@ static int try_get_dev_id(struct smi_inf
 	/* Otherwise, we got some data. */
 	resp_len = smi_info->handlers->get_result(smi_info->si_sm,
 						  resp, IPMI_MAX_MSG_LENGTH);
-	if (resp_len < 6) {
+	if (resp_len < 14) {
 		/* That's odd, it should be longer. */
 		rv = -EINVAL;
 		goto out;
@@ -1958,8 +1957,7 @@ static int try_get_dev_id(struct smi_inf
 	}
 
 	/* Record info from the get device id, in case we need it. */
-	memcpy(&smi_info->device_id, &resp[3],
-	       min_t(unsigned long, resp_len-3, sizeof(smi_info->device_id)));
+	ipmi_demangle_device_id(resp+3, resp_len-3, &smi_info->device_id);
 
  out:
 	kfree(resp);
@@ -2062,12 +2060,11 @@ static int oem_data_avail_to_receive_msg
 #define DELL_POWEREDGE_8G_BMC_DEVICE_ID  0x20
 #define DELL_POWEREDGE_8G_BMC_DEVICE_REV 0x80
 #define DELL_POWEREDGE_8G_BMC_IPMI_VERSION 0x51
-#define DELL_IANA_MFR_ID {0xA2, 0x02, 0x00}
+#define DELL_IANA_MFR_ID 0x0002a2
 static void setup_dell_poweredge_oem_data_handler(struct smi_info *smi_info)
 {
 	struct ipmi_device_id *id = &smi_info->device_id;
-	const char mfr[3]=DELL_IANA_MFR_ID;
-	if (! memcmp(mfr, id->manufacturer_id, sizeof(mfr))) {
+	if (id->manufacturer_id == DELL_IANA_MFR_ID) {
 		if (id->device_id       == DELL_POWEREDGE_8G_BMC_DEVICE_ID  &&
 		    id->device_revision == DELL_POWEREDGE_8G_BMC_DEVICE_REV &&
 		    id->ipmi_version    == DELL_POWEREDGE_8G_BMC_IPMI_VERSION) {
@@ -2142,8 +2139,7 @@ static void
 setup_dell_poweredge_bt_xaction_handler(struct smi_info *smi_info)
 {
 	struct ipmi_device_id *id = &smi_info->device_id;
-	const char mfr[3]=DELL_IANA_MFR_ID;
- 	if (! memcmp(mfr, id->manufacturer_id, sizeof(mfr)) &&
+	if (id->manufacturer_id == DELL_IANA_MFR_ID &&
 	    smi_info->si_type == SI_BT)
 		register_xaction_notifier(&dell_poweredge_bt_xaction_notifier);
 }
@@ -2237,6 +2233,11 @@ static int is_new_interface(struct smi_i
 	return 1;
 }
 
+static void si_release(struct device *dev)
+{
+	printk(KERN_DEBUG "ipmi_si release\n");
+}
+
 static int try_smi_init(struct smi_info *new_smi)
 {
 	int rv;
@@ -2363,17 +2364,38 @@ static int try_smi_init(struct smi_info 
 		new_smi->thread = kthread_run(ipmi_thread, new_smi,
 					      "kipmi%d", new_smi->intf_num);
 
+	if (!new_smi->dev) {
+		/* If we don't already have a device from something
+		 * else (like PCI), then register a new one. */
+		new_smi->idev.name = "ipmi_si";
+		new_smi->idev.id = new_smi->intf_num;
+		new_smi->idev.dev.driver = &ipmi_driver;
+		new_smi->idev.dev.release = si_release;
+
+		rv = platform_device_register(&new_smi->idev);
+		if (rv) {
+			printk(KERN_ERR
+			       "ipmi_si_intf:"
+			       " Unable to register system interface device:"
+			       " %d\n",
+			       rv);
+			goto out_err_stop_timer;
+		}
+		new_smi->dev = &new_smi->idev.dev;
+		new_smi->dev_registered = 1;
+	}
+
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
-			       ipmi_version_major(&new_smi->device_id),
-			       ipmi_version_minor(&new_smi->device_id),
+			       &new_smi->device_id,
+			       new_smi->dev,
 			       new_smi->slave_addr,
 			       &(new_smi->intf));
 	if (rv) {
 		printk(KERN_ERR
 		       "ipmi_si: Unable to register device: error %d\n",
 		       rv);
-		goto out_err_stop_timer;
+		goto out_err_unreg_dev;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "type",
@@ -2383,7 +2405,7 @@ static int try_smi_init(struct smi_info 
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err_stop_timer;
+		goto out_err_unreg_dev;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "si_stats",
@@ -2393,7 +2415,7 @@ static int try_smi_init(struct smi_info 
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err_stop_timer;
+		goto out_err_unreg_dev;
 	}
 
 	list_add_tail(&new_smi->link, &smi_infos);
@@ -2404,6 +2426,10 @@ static int try_smi_init(struct smi_info 
 
 	return 0;
 
+ out_err_unreg_dev:
+	if (new_smi->dev_registered)
+		platform_device_unregister(&new_smi->idev);
+
  out_err_stop_timer:
 	atomic_inc(&new_smi->stop_operation);
 	wait_for_timer_and_thread(new_smi);
@@ -2439,11 +2465,22 @@ static __devinit int init_ipmi_si(void)
 {
 	int  i;
 	char *str;
+	int  rv;
 
 	if (initialized)
 		return 0;
 	initialized = 1;
 
+	/* Register the device drivers. */
+	rv = driver_register(&ipmi_driver);
+	if (rv) {
+		printk(KERN_ERR
+		       "init_ipmi_si: Unable to register driver: %d\n",
+		       rv);
+		return rv;
+	}
+
+
 	/* Parse out the si_type string into its components. */
 	str = si_type_str;
 	if (*str != '\0') {
@@ -2546,6 +2583,9 @@ static void __devexit cleanup_one_si(str
 		       rv);
 	}
 
+	if (to_clean->dev_registered)
+		platform_device_unregister(&to_clean->idev);
+
 	to_clean->handlers->cleanup(to_clean->si_sm);
 
 	kfree(to_clean->si_sm);
@@ -2571,6 +2611,8 @@ static __exit void cleanup_ipmi_si(void)
 	list_for_each_entry_safe(e, tmp_e, &smi_infos, link)
 		cleanup_one_si(e);
 	up(&smi_infos_lock);
+
+	driver_unregister(&ipmi_driver);
 }
 module_exit(cleanup_ipmi_si);
 
Index: linux-2.6.16/include/linux/ipmi.h
===================================================================
--- linux-2.6.16.orig/include/linux/ipmi.h
+++ linux-2.6.16/include/linux/ipmi.h
@@ -36,6 +36,7 @@
 
 #include <linux/ipmi_msgdefs.h>
 #include <linux/compiler.h>
+#include <linux/device.h>
 
 /*
  * This file describes an interface to an IPMI driver.  You have to
@@ -397,7 +398,7 @@ struct ipmi_smi_watcher
 	   the watcher list.  So you can add and remove users from the
 	   IPMI interface, send messages, etc., but you cannot add
 	   or remove SMI watchers or SMI interfaces. */
-	void (*new_smi)(int if_num);
+	void (*new_smi)(int if_num, struct device *dev);
 	void (*smi_gone)(int if_num);
 };
 
Index: linux-2.6.16/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_devintf.c
@@ -789,21 +789,53 @@ MODULE_PARM_DESC(ipmi_major, "Sets the m
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
+/* Keep track of the devices that are registered. */
+struct ipmi_reg_list {
+	dev_t            dev;
+	struct list_head link;
+};
+static LIST_HEAD(reg_list);
+static DECLARE_MUTEX(reg_list_sem);
+
 static struct class *ipmi_class;
 
-static void ipmi_new_smi(int if_num)
+static void ipmi_new_smi(int if_num, struct device *device)
 {
 	dev_t dev = MKDEV(ipmi_major, if_num);
+	struct ipmi_reg_list *entry;
 
 	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
 		      "ipmidev/%d", if_num);
 
-	class_device_create(ipmi_class, NULL, dev, NULL, "ipmi%d", if_num);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (! entry) {
+		printk(KERN_ERR "ipmi_devintf: Unable to create the"
+		       " ipmi class device link\n");
+		return;
+	}
+	entry->dev = dev;
+
+	down(&reg_list_sem);
+	class_device_create(ipmi_class, NULL, dev, device, "ipmi%d", if_num);
+	list_add(&entry->link, &reg_list);
+	up(&reg_list_sem);
 }
 
 static void ipmi_smi_gone(int if_num)
 {
-	class_device_destroy(ipmi_class, MKDEV(ipmi_major, if_num));
+	dev_t dev = MKDEV(ipmi_major, if_num);
+	struct ipmi_reg_list *entry;
+
+	down(&reg_list_sem);
+	list_for_each_entry(entry, &reg_list, link) {
+		if (entry->dev == dev) {
+			list_del(&entry->link);
+			kfree(entry);
+			break;
+		}
+	}
+	class_device_destroy(ipmi_class, dev);
+	up(&reg_list_sem);
 	devfs_remove("ipmidev/%d", if_num);
 }
 
@@ -856,6 +888,14 @@ module_init(init_ipmi_devintf);
 
 static __exit void cleanup_ipmi(void)
 {
+	struct ipmi_reg_list *entry, *entry2;
+	down(&reg_list_sem);
+	list_for_each_entry_safe(entry, entry2, &reg_list, link) {
+		list_del(&entry->link);
+		class_device_destroy(ipmi_class, entry->dev);
+		kfree(entry);
+	}
+	up(&reg_list_sem);
 	class_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
 	devfs_remove(DEVICE_NAME);
Index: linux-2.6.16/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_poweroff.c
@@ -466,7 +466,7 @@ static void ipmi_poweroff_function (void
 
 /* Wait for an IPMI interface to be installed, the first one installed
    will be grabbed by this code and used to perform the powerdown. */
-static void ipmi_po_new_smi(int if_num)
+static void ipmi_po_new_smi(int if_num, struct device *device)
 {
 	struct ipmi_system_interface_addr smi_addr;
 	struct kernel_ipmi_msg            send_msg;
Index: linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
@@ -992,7 +992,7 @@ static struct notifier_block wdog_panic_
 };
 
 
-static void ipmi_new_smi(int if_num)
+static void ipmi_new_smi(int if_num, struct device *device)
 {
 	ipmi_register_watchdog(if_num);
 }
