Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVKZMES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVKZMES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 07:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVKZMES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 07:04:18 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:1225 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750843AbVKZMER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 07:04:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=SwQptB2WE7DXlXLfkxGGBq6OfJ2HZg8pDYhtE0QEEaHSaCdWGIOCcN7yrdD77q0V7opvlEJo/pNS6gO5QJtFtvIioxjRNrnM3D8Q3bIyTOyldxuq2PdyN5fZXCcYp+SXlAv2wR/tBewTGHfPxyGwsNlvF2efnbhgAO/bPzk9XCI=
Message-ID: <253818670511260404o1e3d00aaw3a08daf07cb9fc03@mail.gmail.com>
Date: Sat, 26 Nov 2005 07:04:16 -0500
From: Yani Ioannou <yani.ioannou@gmail.com>
To: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] IPMI: driver model and sysfs support
Cc: Martin Drab <drab@kepler.fjfi.cvut.cz>,
       openipmi-developer@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <25381867050830111345e27945@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43161_23344099.1133006656382"
References: <2538186705083003561f5f97e0@mail.gmail.com>
	 <43145D95.8060006@acm.org> <25381867050830111345e27945@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_43161_23344099.1133006656382
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Corey,

On 8/30/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> On 8/30/05, Corey Minyard <minyard@acm.org> wrote:
> > This is very good.  I believe the structure is correct, but I'm not a
> > sysfs expert.
> >
> > There are a few things we need to deal with, though.
<snip>

Sorry it has been quite a while .. anyway I finally got around to
updating the patch with the changes you proposed, and attached is a
patch against the latest git (2.6.15-rc2-git6).

Thanks,
Yani

------=_Part_43161_23344099.1133006656382
Content-Type: text/x-patch; name=patch-linux-2.6.15-rc2-git6-ipmisysfs.diff; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.15-rc2-git6-ipmisysfs.diff"


---

 drivers/char/ipmi/ipmi_bt_sm.c      |   13 +
 drivers/char/ipmi/ipmi_devintf.c    |   11 -
 drivers/char/ipmi/ipmi_kcs_sm.c     |   13 +
 drivers/char/ipmi/ipmi_msghandler.c |  374 +++++++++++++++++++++++++++++++++++
 drivers/char/ipmi/ipmi_si_intf.c    |  200 ++++++++++++++++---
 drivers/char/ipmi/ipmi_si_sm.h      |    9 +
 drivers/char/ipmi/ipmi_smic_sm.c    |   13 +
 include/linux/ipmi.h                |  127 ++++++++++++
 include/linux/ipmi_msgdefs.h        |    1 
 include/linux/ipmi_smi.h            |    1 
 10 files changed, 723 insertions(+), 39 deletions(-)

applies-to: 1f3b06d516dac26c976cedfc59cd48781b96f86d
93ace52e69e5cc5258abb14a8c6c8786ca7d209b
diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
index 58dcdee..648ab0b 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -28,6 +28,7 @@
 
 #include <linux/kernel.h> /* For printk. */
 #include <linux/string.h>
+#include <linux/ipmi.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
@@ -105,6 +106,17 @@ struct si_sm_data {
 #define BT_INTMASK_R	bt->io->inputb(bt->io, 2)
 #define BT_INTMASK_W(x)	bt->io->outputb(bt->io, 2, x)
 
+/** 
+ * The driver model view of the IPMI system interface state machine.
+ */
+static struct ipmi_si_driver bt_si_driver = {
+	.owner = THIS_MODULE,
+	.driver = {
+		.name = "ipmi_bt_sm",
+		.bus = &platform_bus_type
+	},
+};
+
 /* Convenience routines for debugging.  These are not multi-open safe!
    Note the macros have hardcoded variables in them. */
 
@@ -513,6 +525,7 @@ static int bt_size(void)
 
 struct si_sm_handlers bt_smi_handlers =
 {
+	.driver            = &bt_si_driver,
 	.init_data         = bt_init_data,
 	.start_transaction = bt_start_transaction,
 	.get_result        = bt_get_result,
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
index 7c0684d..c0e3cc5 100644
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -789,7 +789,7 @@ MODULE_PARM_DESC(ipmi_major, "Sets the m
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
-static struct class *ipmi_class;
+extern struct class *ipmi_class;
 
 static void ipmi_new_smi(int if_num)
 {
@@ -823,15 +823,8 @@ static __init int init_ipmi_devintf(void
 
 	printk(KERN_INFO "ipmi device interface\n");
 
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
@@ -845,7 +838,6 @@ static __init int init_ipmi_devintf(void
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
-		class_destroy(ipmi_class);
 		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
 		return rv;
 	}
@@ -856,7 +848,6 @@ module_init(init_ipmi_devintf);
 
 static __exit void cleanup_ipmi(void)
 {
-	class_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
 	devfs_remove(DEVICE_NAME);
 	unregister_chrdev(ipmi_major, DEVICE_NAME);
diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
index da15541..6e71315 100644
--- a/drivers/char/ipmi/ipmi_kcs_sm.c
+++ b/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
+#include <linux/ipmi.h>
 #include <linux/jiffies.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
@@ -120,6 +121,17 @@ struct si_sm_data
 	unsigned long  error0_timeout;
 };
 
+/** 
+ * The driver model view of the IPMI system interface state machine.
+ */
+static struct ipmi_si_driver kcs_si_driver = {
+	.owner = THIS_MODULE,
+	.driver = {
+		.name = "ipmi_kcs_sm",
+		.bus = &platform_bus_type
+	},
+};
+
 static unsigned int init_kcs_data(struct si_sm_data *kcs,
 				  struct si_sm_io *io)
 {
@@ -509,6 +521,7 @@ static void kcs_cleanup(struct si_sm_dat
 
 struct si_sm_handlers kcs_smi_handlers =
 {
+	.driver            = &kcs_si_driver,
 	.init_data         = init_kcs_data,
 	.start_transaction = start_kcs_transaction,
 	.get_result        = get_kcs_result,
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 6b302a9..1b4c9b8 100644
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
@@ -66,6 +70,13 @@ struct proc_dir_entry *proc_ipmi_root = 
 #define MAX_MSG_TIMEOUT		60000
 
 
+#define IPMI_DEVICE_MANUFACTURER_ID(man_id) \
+	((long unsigned int) (man_id[2] << 16 | man_id[1] << 8 | man_id[0]))
+
+#define IPMI_DEVICE_PRODUCT_ID(product_id) \
+	((long unsigned int) (product_id[1] << 8 | product_id[0]))
+
+
 /*
  * The main "user" data structure.
  */
@@ -319,6 +330,19 @@ struct ipmi_smi
 #define IPMI_INVALID_INTERFACE(i) (((i) == NULL) \
 				   || (i == IPMI_INVALID_INTERFACE_ENTRY))
 
+struct class *ipmi_class;
+
+/** 
+ * The driver model view of the IPMI messaging driver.
+ */
+static struct ipmi_driver ipmidriver = {
+	.owner = THIS_MODULE,
+	.driver = {
+		.name = "ipmi_msghandler",
+		.bus = &platform_bus_type
+	}
+};
+
 #define MAX_IPMI_INTERFACES 4
 static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
 
@@ -378,6 +402,330 @@ static void intf_free(struct kref *ref)
 	kfree(intf);
 }
 
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
+	return bmc->id.product_id[0] == id->product_id[0]
+		&& bmc->id.product_id[1] == id->product_id[1]
+		&& bmc->id.device_id == id->device_id;
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
+static void ipmi_bmc_release(struct device *dev)
+{
+	printk(KERN_DEBUG "ipmi_bmc release\n");
+}
+
+static ssize_t device_id_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "%u\n", bmc->id.device_id);
+}
+
+static ssize_t provides_dev_sdrs_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "%u\n", 
+			bmc->id.device_revision && 0x80 >> 7);
+}
+
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u\n", 
+			bmc->id.device_revision && 0x0F);
+}
+
+static ssize_t firmware_rev_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u.%x\n", bmc->id.firmware_rev_1, 
+			bmc->id.firmware_rev_2);
+}
+
+static ssize_t ipmi_version_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%u.%u\n", 
+			ipmi_version_major(&bmc->id),
+			ipmi_version_minor(&bmc->id));
+}
+
+static ssize_t add_dev_support_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "0x%02x\n",  bmc->id.additional_device_support);
+}
+
+static ssize_t manufacturer_id_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 20, "%lu\n",  
+			IPMI_DEVICE_MANUFACTURER_ID(bmc->id.manufacturer_id));
+}
+
+static ssize_t product_id_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 10, "%lu\n", 
+			IPMI_DEVICE_PRODUCT_ID(bmc->id.product_id));
+}
+
+static ssize_t aux_firmware_rev_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 21, "0x%02x 0x%02x 0x%02x 0x%02x\n", 
+			bmc->id.aux_firmware_revision[3], 
+			bmc->id.aux_firmware_revision[2], 
+			bmc->id.aux_firmware_revision[1], 
+			bmc->id.aux_firmware_revision[0]);
+}
+
+static ssize_t guid_show(struct device *dev, struct device_attribute *attr, 
+		char *buf)
+{
+	struct ipmi_bmc_device *bmc = to_ipmi_bmc_device(to_platform_device(dev));
+	return snprintf(buf, 100, "%Lx%Lx\n", 
+			(long long) bmc->guid[0],
+			(long long) bmc->guid[8]);
+}
+
+void ipmi_bmc_unregister(struct ipmi_si_device *si, 
+		struct ipmi_bmc_device *bmc)
+{
+	if(--bmc->interfaces == 0){
+		class_device_unregister(bmc->class_dev);
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
+		if(bmc->guid_present)
+			device_remove_file(&bmc->dev.dev,
+					&bmc->guid_attr);
+		platform_device_unregister(&bmc->dev);
+	}
+}
+
+int ipmi_bmc_register(struct ipmi_si_device *si, 
+		struct ipmi_bmc_device **bmcref)
+{
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
+				bmc->id.product_id, 
+				&bmc->id.device_id);
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
+			"ipmi_si: interfacing existing BMC (man_id: %lu, \
+prod_id: %lu, dev_id: %u)\n",
+			IPMI_DEVICE_MANUFACTURER_ID(bmc->id.manufacturer_id),
+			IPMI_DEVICE_PRODUCT_ID(bmc->id.product_id),
+			bmc->id.device_id);
+	}else{
+		bmc->dev.name = "ipmi_bmc";
+		bmc->dev.id = bmc->id.device_id;
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
+		bmc->add_dev_support_attr.attr.name = "additional_device_support";
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
+				&bmc->device_id_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->provides_dev_sdrs_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->revision_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->firmware_rev_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->version_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->add_dev_support_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->manufacturer_id_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->product_id_attr);
+		device_create_file(&bmc->dev.dev,
+				&bmc->aux_firmware_rev_attr);
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
+				bmc->id.device_id);
+		
+		class_device_register(bmc->class_dev);
+		
+		printk(KERN_INFO 
+			"ipmi_si: Found new BMC (man_id: %lu, prod_id: %lu, \
+dev_id: %u)\n",
+			IPMI_DEVICE_MANUFACTURER_ID(bmc->id.manufacturer_id),
+			IPMI_DEVICE_PRODUCT_ID(bmc->id.product_id),
+			bmc->id.device_id);
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
 	int           i;
@@ -3194,11 +3542,23 @@ static struct notifier_block panic_block
 
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
 	printk(KERN_INFO "ipmi message handler version "
 	       IPMI_DRIVER_VERSION "\n");
 
@@ -3255,6 +3615,10 @@ static __exit void cleanup_ipmi(void)
 	remove_proc_entry(proc_ipmi_root->name, &proc_root);
 #endif /* CONFIG_PROC_FS */
 
+	driver_unregister(&ipmidriver.driver);
+	
+	class_destroy(ipmi_class);
+	
 	initialized = 0;
 
 	/* Check for buffer leaks. */
@@ -3300,3 +3664,9 @@ EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
 EXPORT_SYMBOL(proc_ipmi_root);
 EXPORT_SYMBOL(ipmi_user_set_run_to_completion);
 EXPORT_SYMBOL(ipmi_free_recv_msg);
+EXPORT_SYMBOL(ipmidriver);
+EXPORT_SYMBOL(ipmi_find_bmc_guid);
+EXPORT_SYMBOL(ipmi_find_bmc_prod_dev_id);
+EXPORT_SYMBOL(ipmi_bmc_register);
+EXPORT_SYMBOL(ipmi_bmc_unregister);
+EXPORT_SYMBOL(ipmi_class);
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 01a1f6b..d824597 100644
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
@@ -110,25 +115,11 @@ enum si_type {
     SI_KCS, SI_SMIC, SI_BT
 };
 
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
-
-#define ipmi_version_major(v) ((v)->ipmi_version & 0xf)
-#define ipmi_version_minor(v) ((v)->ipmi_version >> 4)
-
 struct smi_info
 {
 	int                    intf_num;
 	ipmi_smi_t             intf;
+	struct ipmi_si_device  *dev;
 	struct si_sm_data      *si_sm;
 	struct si_sm_handlers  *handlers;
 	enum si_type           si_type;
@@ -203,8 +194,6 @@ struct smi_info
 	   interrupts. */
 	int interrupt_disabled;
 
-	struct ipmi_device_id device_id;
-
 	/* Slave address, could be reported from DMI. */
 	unsigned char slave_addr;
 
@@ -232,6 +221,13 @@ static int register_xaction_notifier(str
 	return notifier_chain_register(&xaction_notifier_list, nb);
 }
 
+extern struct ipmi_driver ipmidriver;
+extern struct class *ipmi_class;
+extern int ipmi_bmc_register(struct ipmi_si_device *si, 
+		struct ipmi_bmc_device **bmcref);
+extern void ipmi_bmc_unregister(struct ipmi_si_device *si, 
+		struct ipmi_bmc_device *bmc);
+
 static void si_restart_short_timer(struct smi_info *smi_info);
 
 static void deliver_recv_msg(struct smi_info *smi_info,
@@ -1934,6 +1930,75 @@ static int try_init_plug_and_play(int in
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
@@ -1993,8 +2058,8 @@ static int try_get_dev_id(struct smi_inf
 	}
 
 	/* Record info from the get device id, in case we need it. */
-	memcpy(&smi_info->device_id, &resp[3],
-	       min_t(unsigned long, resp_len-3, sizeof(smi_info->device_id)));
+	memcpy(&smi_info->dev->bmc->id, &resp[3],
+	       min_t(unsigned long, resp_len-3, sizeof(struct bmc_device_id)));
 
  out:
 	kfree(resp);
@@ -2100,7 +2165,7 @@ static int oem_data_avail_to_receive_msg
 #define DELL_IANA_MFR_ID {0xA2, 0x02, 0x00}
 static void setup_dell_poweredge_oem_data_handler(struct smi_info *smi_info)
 {
-	struct ipmi_device_id *id = &smi_info->device_id;
+	struct bmc_device_id *id = &smi_info->dev->bmc->id;
 	const char mfr[3]=DELL_IANA_MFR_ID;
 	if (! memcmp(mfr, id->manufacturer_id, sizeof(mfr))) {
 		if (id->device_id       == DELL_POWEREDGE_8G_BMC_DEVICE_ID  &&
@@ -2176,7 +2241,7 @@ static struct notifier_block dell_powere
 static void
 setup_dell_poweredge_bt_xaction_handler(struct smi_info *smi_info)
 {
-	struct ipmi_device_id *id = &smi_info->device_id;
+	struct bmc_device_id *id = &smi_info->dev->bmc->id;
 	const char mfr[3]=DELL_IANA_MFR_ID;
  	if (! memcmp(mfr, id->manufacturer_id, sizeof(mfr)) &&
 	    smi_info->si_type == SI_BT)
@@ -2208,6 +2273,13 @@ static inline void wait_for_timer_and_th
 	del_timer_sync(&smi_info->si_timer);
 }
 
+static void ipmi_si_release(struct device *dev)
+{
+	struct ipmi_si_device *si = to_ipmi_si_device(to_platform_device(dev)); 
+	ipmi_bmc_unregister(si, si->bmc);
+	printk(KERN_DEBUG "ipmi_si release\n");
+}
+
 /* Returns 0 if initialized, or negative on an error. */
 static int init_one_smi(int intf_num, struct smi_info **smi)
 {
@@ -2295,12 +2367,48 @@ static int init_one_smi(int intf_num, st
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
 
 	setup_oem_data_handler(new_smi);
 	setup_xaction_handlers(new_smi);
@@ -2342,8 +2450,8 @@ static int init_one_smi(int intf_num, st
 
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
-			       ipmi_version_major(&new_smi->device_id),
-			       ipmi_version_minor(&new_smi->device_id),
+			       ipmi_version_major(&new_smi->dev->bmc->id),
+			       ipmi_version_minor(&new_smi->dev->bmc->id),
 			       new_smi->slave_addr,
 			       &(new_smi->intf));
 	if (rv) {
@@ -2373,6 +2481,46 @@ static int init_one_smi(int intf_num, st
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
@@ -2482,6 +2630,10 @@ static void __exit cleanup_one_si(struct
 	if (! to_clean)
 		return;
 
+	class_device_unregister(to_clean->dev->class_dev);
+	platform_device_unregister(&to_clean->dev->dev);
+	driver_unregister(&to_clean->handlers->driver->driver);
+	
 	/* Tell the timer and interrupt handlers that we are shutting
 	   down. */
 	spin_lock_irqsave(&(to_clean->si_lock), flags);
diff --git a/drivers/char/ipmi/ipmi_si_sm.h b/drivers/char/ipmi/ipmi_si_sm.h
index bf3d496..c507c65 100644
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
@@ -73,9 +75,10 @@ enum si_sm_result
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
index 39d7e5e..cf7ccaf 100644
--- a/drivers/char/ipmi/ipmi_smic_sm.c
+++ b/drivers/char/ipmi/ipmi_smic_sm.c
@@ -43,6 +43,7 @@
 
 #include <linux/kernel.h> /* For printk. */
 #include <linux/string.h>
+#include <linux/ipmi.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
@@ -119,6 +120,17 @@ struct si_sm_data
         long		 smic_timeout;
 };
 
+/** 
+ * The driver model view of the IPMI system interface state machine.
+ */
+static struct ipmi_si_driver smic_si_driver = {
+	.owner = THIS_MODULE,
+	.driver = {
+		.name = "ipmi_smic_sm",
+		.bus = &platform_bus_type
+	},
+};
+
 static unsigned int init_smic_data (struct si_sm_data *smic,
 				    struct si_sm_io *io)
 {
@@ -595,6 +607,7 @@ static int smic_size(void)
 
 struct si_sm_handlers smic_smi_handlers =
 {
+	.driver            = &smic_si_driver,
 	.init_data         = init_smic_data,
 	.start_transaction = start_smic_transaction,
 	.get_result        = smic_get_result,
diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
index d6276e6..485a2c6 100644
--- a/include/linux/ipmi.h
+++ b/include/linux/ipmi.h
@@ -30,10 +30,17 @@
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
+#include <linux/platform_device.h>
+#include <linux/ipmi_smi.h>
 #include <linux/ipmi_msgdefs.h>
 #include <linux/compiler.h>
 
@@ -68,6 +75,126 @@
  * interface is defined later in the file.  */
 
 
+/**
+ * struct ipmi_si_driver - represents a ipmi system interface 
+ * 	driver in the kernel.
+ * @owner: Pointer to the module owner of this driver; initialize
+ *	it using THIS_MODULE.
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
+	struct device_driver driver;
+	/* driver attributes */
+};
+#define to_ipmi_si_driver(drv) container_of(drv, struct ipmi_si_driver, driver)
+
+/**
+ * struct ipmi_driver - represents the ipmi messaging interface 
+ * 	driver in the kernel.
+ * @owner: Pointer to the module owner of this driver; initialize
+ *	it using THIS_MODULE.
+ * @driver: the driver model core driver structure.
+ */
+struct ipmi_driver
+{
+	struct module *owner;
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
+ * struct bmc_device_id - represents an IPMI BMC's response to an 
+ *                        IPMI_GET_DEVICE_ID_CMD command.
+ * @device_id: OEM per product device id (product_id+device_id unique).
+ * @device_revision: the IPMI BMC revision number.
+ * @firmware_revision_1: the BMC's firmware major version number.
+ * @firmware_revision_2: the BMC's firmware minor version number.
+ * @ipmi_version: the ipmi version numbers of the BMC.
+ * @additional_device_support: additional device support.
+ * @manufacturer_id: the manufacturer ID of the BMC.
+ * @product_id: OEM product id.
+ * @aux_firmware_revision: auxilliarly firmware revision.
+ */
+struct bmc_device_id {
+	unsigned char device_id;
+	unsigned char device_revision;
+	unsigned char firmware_rev_1;
+	unsigned char firmware_rev_2;
+	unsigned char ipmi_version;
+	unsigned char additional_device_support;
+	unsigned char manufacturer_id[3];
+	unsigned char product_id[2];
+	unsigned char aux_firmware_revision[4];
+} __attribute__((packed));
+
+/* macros to extract major/minor version from IPMI version */
+#define ipmi_version_major(v) ((v)->ipmi_version & 0xf)
+#define ipmi_version_minor(v) ((v)->ipmi_version >> 4)
+
+/**
+ * struct ipmi_bmc_device - represents an IPMI baseboard management controller
+ * 	(BMC) attatched to one or more system interfaces.
+ * @dev: driver model's view of this device.
+ * @id: the BMC's device id response.
+ * @guid: BMC's globally unique identifier (optional).
+ * @guid_present: set iff a BMC GUID is available.
+ * @interfaces: the number of system interfaces currently interfacing 
+ * 		to this BMC.
+ */
+struct ipmi_bmc_device
+{
+	struct platform_device dev;
+	struct bmc_device_id id;
+	unsigned char guid[16];
+	int guid_present;
+	int interfaces;
+	/* bmc class device */
+	struct class_device *class_dev;
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
+#define to_ipmi_bmc_device(device) 			\
+	container_of(device, struct ipmi_bmc_device, dev)
 
 /*
  * This is an overlay for all the address types, so it's easy to
diff --git a/include/linux/ipmi_msgdefs.h b/include/linux/ipmi_msgdefs.h
index 03bc64d..f8572af 100644
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
index e36ee15..96c2182 100644
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -43,6 +43,7 @@
 
 /* Structure for the low-level drivers. */
 typedef struct ipmi_smi *ipmi_smi_t;
+typedef struct smi_info *smi_info_t;
 
 /*
  * Messages to/from the lower layer.  The smi interface will take one
---
0.99.9j



------=_Part_43161_23344099.1133006656382--
