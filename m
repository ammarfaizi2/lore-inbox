Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSLaVjk>; Tue, 31 Dec 2002 16:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbSLaVjk>; Tue, 31 Dec 2002 16:39:40 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:6020 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264745AbSLaVjc>;
	Tue, 31 Dec 2002 16:39:32 -0500
Date: Tue, 31 Dec 2002 16:49:40 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>
Cc: Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proposed PnP layer changes/fixes and cleanups
Message-ID: <20021231164940.GA304@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Greg KH <greg@kroah.com>,
	Jaroslav Kysela <perex@perex.cz>,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0212201557270.824-100000@pnote.perex-int.cz> <20021230220911.GD32324@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230220911.GD32324@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 02:09:12PM -0800, Greg KH wrote:
> These changes look good, I'll send them on to Linus.
> 

Agreed, here are some aditional changes.

Linux PnP Support 0.94 - changelog

(Me)			-use list_del instead of list_del_init in some areas
			-introduce pnp capability and status flags
			-remove static resource setting, I did some research and found that only
			 PnPBIOS supports it, therefore it is better to implememt this in the
			 PnPBIOS protocol itself. (it appears ACPI doesn't use this)
			-Remove pnp_dev_has_driver and use PNP_ATTACHED instead, this is necessary
			 because a card driver only has rights over a device that it requests.
			-added card_for_each_dev macro
			-undo isapnp protocol changes, the pnp layer was designed to handle cards
			 and devices on the same protocol and I feel they should not be seperated.
(Pual Laufer)		-Fix remove driver bug in pnp card services
(Adam Richter)		-Fix a potential oops in id registration functions

Sorry for the delayed release, I've been out of town.

Thanks,
Adam



diff -ur ./a/drivers/pnp/card.c ./b/drivers/pnp/card.c
--- ./a/drivers/pnp/card.c	Tue Dec 31 16:27:53 2002
+++ ./b/drivers/pnp/card.c	Tue Dec 31 15:25:59 2002
@@ -62,6 +62,7 @@
 		return -EINVAL;
 	if (!card)
 		return -EINVAL;
+	id->next = NULL;
 	ptr = card->id;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
@@ -131,16 +132,17 @@
 
 void pnpc_remove_card(struct pnp_card *card)
 {
-	struct list_head *pos;
+	struct list_head *pos, *temp;
 	if (!card)
 		return;
 	device_unregister(&card->dev);
 	spin_lock(&pnp_lock);
-	list_del_init(&card->global_list);
-	list_del_init(&card->protocol_list);
+	list_del(&card->global_list);
+	list_del(&card->protocol_list);
 	spin_unlock(&pnp_lock);
-	list_for_each(pos,&card->devices){
+	list_for_each_safe(pos,temp,&card->devices){
 		struct pnp_dev *dev = card_to_pnp_dev(pos);
+		pnpc_remove_device(dev);
 		__pnp_remove_device(dev);
 	}
 }
@@ -174,7 +176,7 @@
 {
 	spin_lock(&pnp_lock);
 	dev->card = NULL;
-	list_del_init(&dev->card_list);
+	list_del(&dev->card_list);
 	spin_unlock(&pnp_lock);
 	__pnp_remove_device(dev);
 }
@@ -213,6 +215,13 @@
 	return NULL;
 
 found:
+	spin_lock(&pnp_lock);
+	if(dev->status != PNP_READY){
+		spin_unlock(&pnp_lock);
+		return NULL;
+	}
+	dev->status = PNP_ATTACHED;
+	spin_unlock(&pnp_lock);
 	cdrv = to_pnpc_driver(card->dev.driver);
 	if (dev->active == 0) {
 		if (!(cdrv->flags & PNPC_DRIVER_DO_NOT_ACTIVATE)) {
@@ -239,15 +248,17 @@
 void pnp_release_card_device(struct pnp_dev *dev)
 {
 	spin_lock(&pnp_lock);
-	list_del_init(&dev->rdev_list);
+	list_del(&dev->rdev_list);
+	if (dev->status == PNP_ATTACHED)
+		dev->status = PNP_READY;
 	spin_unlock(&pnp_lock);
 	pnp_disable_dev(dev);
 }
 
 static void pnpc_recover_devices(struct pnp_card *card)
 {
-	struct list_head *pos;
-	list_for_each(pos,&card->rdevs){
+	struct list_head *pos, *temp;
+	list_for_each_safe(pos,temp,&card->rdevs){
 		struct pnp_dev *dev = list_entry(pos, struct pnp_dev, rdev_list);
 		pnp_release_card_device(dev);
 	}
diff -ur ./a/drivers/pnp/core.c ./b/drivers/pnp/core.c
--- ./a/drivers/pnp/core.c	Tue Dec 31 16:27:53 2002
+++ ./b/drivers/pnp/core.c	Tue Dec 31 12:54:59 2002
@@ -81,7 +81,7 @@
 void pnp_unregister_protocol(struct pnp_protocol *protocol)
 {
 	spin_lock(&pnp_lock);
-	list_del_init(&protocol->protocol_list);
+	list_del(&protocol->protocol_list);
 	spin_unlock(&pnp_lock);
 	device_unregister(&protocol->dev);
 }
@@ -119,6 +119,7 @@
 	dev->dev.name[DEVICE_NAME_SIZE-1] = '\0';
 	dev->dev.bus = &pnp_bus_type;
 	dev->dev.release = &pnp_release_device;
+	dev->status = PNP_READY;
 	error = device_register(&dev->dev);
 	if (error == 0){
 		spin_lock(&pnp_lock);
@@ -149,8 +150,8 @@
 void __pnp_remove_device(struct pnp_dev *dev)
 {
 	spin_lock(&pnp_lock);
-	list_del_init(&dev->global_list);
-	list_del_init(&dev->protocol_list);
+	list_del(&dev->global_list);
+	list_del(&dev->protocol_list);
 	spin_unlock(&pnp_lock);
 	device_unregister(&dev->dev);
 }
@@ -171,7 +172,7 @@
 
 static int __init pnp_init(void)
 {
-	printk(KERN_INFO "Linux Plug and Play Support v0.93 (c) Adam Belay\n");
+	printk(KERN_INFO "Linux Plug and Play Support v0.94 (c) Adam Belay\n");
 	return bus_register(&pnp_bus_type);
 }
 
diff -ur ./a/drivers/pnp/driver.c ./b/drivers/pnp/driver.c
--- ./a/drivers/pnp/driver.c	Tue Dec 31 16:27:53 2002
+++ ./b/drivers/pnp/driver.c	Tue Dec 31 15:10:51 2002
@@ -19,6 +19,7 @@
 #endif
 
 #include <linux/pnp.h>
+#include "base.h"
 
 static int compare_func(const char *ida, const char *idb)
 {
@@ -75,6 +76,14 @@
 
 	pnp_dbg("pnp: match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
 
+	spin_lock(&pnp_lock);
+	if(pnp_dev->status != PNP_READY){
+		spin_unlock(&pnp_lock);
+		return -EBUSY;
+	}
+	pnp_dev->status = PNP_ATTACHED;
+	spin_unlock(&pnp_lock);
+
 	if (pnp_dev->active == 0) {
 		if (!(pnp_drv->flags & PNP_DRIVER_DO_NOT_ACTIVATE)) {
 			error = pnp_activate_dev(pnp_dev, NULL);
@@ -95,6 +104,13 @@
 		pnp_dev->driver = pnp_drv;
 		error = 0;
 	}
+	else
+	goto fail;
+	return error;
+
+fail:
+	pnp_dev->status = PNP_READY;
+	pnp_disable_dev(pnp_dev);
 	return error;
 }
 
@@ -108,6 +124,10 @@
 			drv->remove(pnp_dev);
 		pnp_dev->driver = NULL;
 	}
+	spin_lock(&pnp_lock);
+	if (pnp_dev->status == PNP_ATTACHED)
+		pnp_dev->status = PNP_READY;
+	spin_unlock(&pnp_lock);
 	pnp_disable_dev(pnp_dev);
 	return 0;
 }
@@ -172,6 +192,7 @@
 		return -EINVAL;
 	if (!dev)
 		return -EINVAL;
+	id->next = NULL;
 	ptr = dev->id;
 	while (ptr && ptr->next)
 		ptr = ptr->next;
diff -ur ./a/drivers/pnp/interface.c ./b/drivers/pnp/interface.c
--- ./a/drivers/pnp/interface.c	Tue Dec 31 16:27:53 2002
+++ ./b/drivers/pnp/interface.c	Tue Dec 31 15:25:25 2002
@@ -286,13 +286,12 @@
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	char	command[20];
-	char	type[20];
 	int	num_args;
 	int	error = 0;
-	int	depnum, mode = 0;
+	int	depnum;
 	if (off)
 		return 0;
-	num_args = sscanf(buf,"%10s %i %10s",command,&depnum,type);
+	num_args = sscanf(buf,"%10s %i",command,&depnum);
 	if (!num_args)
 		goto done;
 	if (!strnicmp(command,"lock",4)) {
@@ -320,11 +319,9 @@
 		goto done;
 	}
 	if (!strnicmp(command,"manual",6)) {
-		if (num_args != 3)
+		if (num_args != 2)
 			goto done;
-		if (!strnicmp(type,"static",6))
-			mode = PNP_STATIC;
-		error = pnp_raw_set_dev(dev,depnum,NULL,mode);
+		error = pnp_raw_set_dev(dev,depnum,NULL);
 		goto done;
 	}
  done:
diff -ur ./a/drivers/pnp/isapnp/core.c ./b/drivers/pnp/isapnp/core.c
--- ./a/drivers/pnp/isapnp/core.c	Tue Dec 31 16:27:57 2002
+++ ./b/drivers/pnp/isapnp/core.c	Tue Dec 31 16:20:58 2002
@@ -454,6 +454,10 @@
 	if (size > 5)
 		dev->regs |= tmp[5] << 8;
 	dev->protocol = &isapnp_protocol;
+	dev->capabilities |= PNP_CONFIGURABLE;
+	dev->capabilities |= PNP_READ;
+	dev->capabilities |= PNP_WRITE;
+	dev->capabilities |= PNP_DISABLE;
 	return dev;
 }
 
@@ -889,7 +893,7 @@
 		if (isapnp_checksum_value != 0x00)
 			printk(KERN_ERR "isapnp: checksum for device %i is not valid (0x%x)\n", csn, isapnp_checksum_value);
 		card->checksum = isapnp_checksum_value;
-		card->protocol = &isapnp_card_protocol;
+		card->protocol = &isapnp_protocol;
 		pnpc_add_card(card);
 	}
 	return 0;
@@ -903,7 +907,7 @@
 {
 	struct pnp_card *card;
 	pnp_for_each_card(card) {
-		if (card->protocol == &isapnp_card_protocol)
+		if (card->protocol == &isapnp_protocol)
 			return 1;
 	}
 	return 0;
@@ -1002,7 +1006,7 @@
 	return 0;
 }
 
-static int isapnp_set_resources(struct pnp_dev *dev, struct pnp_cfg *cfg, char flags)
+static int isapnp_set_resources(struct pnp_dev *dev, struct pnp_cfg *cfg)
 {
 	int tmp;
       	isapnp_cfg_begin(dev->card->number, dev->number);
@@ -1042,15 +1046,8 @@
 	return 0;
 }
 
-struct pnp_protocol isapnp_card_protocol = {
-	.name	= "ISA Plug and Play - card",
-	.get	= NULL,
-	.set	= NULL,
-	.disable = NULL,
-};
-
 struct pnp_protocol isapnp_protocol = {
-	.name	= "ISA Plug and Play - device",
+	.name	= "ISA Plug and Play",
 	.get	= isapnp_get_resources,
 	.set	= isapnp_set_resources,
 	.disable = isapnp_disable_resources,
@@ -1080,9 +1077,6 @@
 #endif
 		return -EBUSY;
 	}
-
-	if(pnp_register_protocol(&isapnp_card_protocol)<0)
-		return -EBUSY;
 
 	if(pnp_register_protocol(&isapnp_protocol)<0)
 		return -EBUSY;
diff -ur ./a/drivers/pnp/pnpbios/core.c ./b/drivers/pnp/pnpbios/core.c
--- ./a/drivers/pnp/pnpbios/core.c	Tue Dec 31 16:27:53 2002
+++ ./b/drivers/pnp/pnpbios/core.c	Tue Dec 31 15:31:11 2002
@@ -1261,9 +1261,7 @@
 	struct pnp_bios_node * node;
 		
 	/* just in case */
-	if(pnp_dev_has_driver(dev))
-		return -EBUSY;
-	if(!pnp_is_dynamic(dev))
+	if(!pnpbios_is_dynamic(dev))
 		return -EPERM;
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return -ENODEV;
@@ -1277,16 +1275,14 @@
 	return 0;
 }
 
-static int pnpbios_set_resources(struct pnp_dev *dev, struct pnp_cfg *config, char flags)
+static int pnpbios_set_resources(struct pnp_dev *dev, struct pnp_cfg *config)
 {
 	struct pnp_dev_node_info node_info;
 	u8 nodenum = dev->number;
 	struct pnp_bios_node * node;
 
 	/* just in case */
-	if(pnp_dev_has_driver(dev))
-		return -EBUSY;
-	if (flags == PNP_DYNAMIC && !pnp_is_dynamic(dev))
+	if (!pnpbios_is_dynamic(dev))
 		return -EPERM;
 	if (pnp_bios_dev_node_info(&node_info) != 0)
 		return -ENODEV;
@@ -1338,9 +1334,7 @@
 	if (!config)
 		return -1;
 	/* just in case */
-	if(pnp_dev_has_driver(dev))
-		return -EBUSY;
-	if(dev->flags & PNP_NO_DISABLE || !pnp_is_dynamic(dev))
+	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
 	memset(config, 0, sizeof(struct pnp_cfg));
 	if (!dev || !dev->active)
@@ -1449,6 +1443,15 @@
 		pos = node_possible_resource_data_to_dev(pos,node,dev);
 		node_id_data_to_dev(pos,node,dev);
 		dev->flags = node->flags;
+		if (!(dev->flags & PNPBIOS_NO_CONFIG))
+			dev->capabilities |= PNP_CONFIGURABLE;
+		if (!(dev->flags & PNPBIOS_NO_DISABLE))
+			dev->capabilities |= PNP_DISABLE;
+		dev->capabilities |= PNP_READ;
+		if (pnpbios_is_dynamic(dev))
+			dev->capabilities |= PNP_WRITE;
+		if (dev->flags & PNPBIOS_REMOVABLE)
+			dev->capabilities |= PNP_REMOVABLE;
 
 		dev->protocol = &pnpbios_protocol;
 
diff -ur ./a/drivers/pnp/resource.c ./b/drivers/pnp/resource.c
--- ./a/drivers/pnp/resource.c	Tue Dec 31 16:27:53 2002
+++ ./b/drivers/pnp/resource.c	Tue Dec 31 16:01:55 2002
@@ -750,7 +750,7 @@
 		dma = dma->next;
 	}
 	return config;
-	
+
 	fail:
 	kfree(config);
 	return NULL;
@@ -772,13 +772,13 @@
 	if (!dev)
 		return -EINVAL;
         max = pnp_get_max_depnum(dev);
-	if (dev->active)
+	if (!pnp_can_configure(dev))
 		return -EBUSY;
-	if (pnp_dev_has_driver(dev)){
+	if (dev->status != PNP_READY && dev->status != PNP_ATTACHED){
 		printk(KERN_INFO "pnp: Automatic configuration failed because the PnP device '%s' is busy\n", dev->dev.bus_id);
 		return -EINVAL;
 	}
-	if (!dev->protocol->get || !dev->protocol->set)
+	if (!pnp_can_write(dev))
 		return -EINVAL;
 	if (max == 0)
 		return 0;
@@ -796,8 +796,8 @@
 
 	done:
 	pnp_dbg("the device '%s' has been activated", dev->dev.bus_id);
-	dev->protocol->set(dev,config,0);
-	if (dev->protocol->get)
+	dev->protocol->set(dev,config);
+	if (pnp_can_read(dev))
 		dev->protocol->get(dev);
 	kfree(config);
 	return 0;
@@ -814,13 +814,13 @@
 {
         if (!dev)
                 return -EINVAL;
-	if (pnp_dev_has_driver(dev)){
+	if (dev->status != PNP_READY){
 		printk(KERN_INFO "pnp: Disable failed becuase the PnP device '%s' is busy\n", dev->dev.bus_id);
 		return -EINVAL;
 	}
 	if (dev->lock_resources)
 		return -EPERM;
-	if (!dev->protocol->disable || !dev->active)
+	if (!pnp_can_disable(dev) || !dev->active)
 		return -EINVAL;
 	pnp_dbg("the device '%s' has been disabled", dev->dev.bus_id);
 	return dev->protocol->disable(dev);
@@ -834,16 +834,16 @@
  *
  */
 
-int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template, int mode)
+int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template)
 {
 	struct pnp_cfg *config;
 	if (!dev)
 		return -EINVAL;
-	if (pnp_dev_has_driver(dev)){
+	if (dev->status != PNP_READY){
 		printk(KERN_INFO "pnp: Unable to set resources because the PnP device '%s' is busy\n", dev->dev.bus_id);
 		return -EINVAL;
 	}
-	if (!dev->protocol->get || !dev->protocol->set)
+	if (!pnp_can_write(dev) || !pnp_can_configure(dev))
 		return -EINVAL;
         config = pnp_generate_config(dev,depnum);
 	if (!config)
@@ -855,8 +855,8 @@
 	return -ENOENT;
 
 	done:
-	dev->protocol->set(dev,config,mode);
-	if (dev->protocol->get)
+	dev->protocol->set(dev,config);
+	if (pnp_can_read(dev))
 		dev->protocol->get(dev);
 	kfree(config);
 	return 0;
diff -ur ./a/include/linux/pnp.h ./b/include/linux/pnp.h
--- ./a/include/linux/pnp.h	Tue Dec 31 16:27:57 2002
+++ ./b/include/linux/pnp.h	Tue Dec 31 15:23:56 2002
@@ -84,6 +84,9 @@
 struct pnp_dev {
 	char name[80];			/* device name */
 	int active;			/* status of the device */
+	int capabilities;
+	int status;
+
 	struct list_head global_list;	/* node in global list of devices */
 	struct list_head protocol_list;	/* node in list of device's protocol */
 	struct list_head card_list;	/* node in card's list of devices */
@@ -116,13 +119,10 @@
 	for(dev = global_to_pnp_dev(pnp_global.next); \
 	dev != global_to_pnp_dev(&pnp_global); \
 	dev = global_to_pnp_dev(dev->global_list.next))
-
-static inline int pnp_dev_has_driver(struct pnp_dev *pdev)
-{
-	if (pdev->driver || (pdev->card && pdev->card->driver))
-		return 1;
-	return 0;
-} 
+#define card_for_each_dev(card,dev) \
+	for((dev) = card_to_pnp_dev((card)->devices.next); \
+	(dev) != card_to_pnp_dev(&(card)->devices); \
+	(dev) = card_to_pnp_dev((dev)->card_list.next))
 
 static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
 {
@@ -149,6 +149,28 @@
 	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
 };
 
+/* capabilities */
+#define PNP_READ		0x0001
+#define PNP_WRITE		0x0002
+#define PNP_DISABLE		0x0004
+#define PNP_CONFIGURABLE	0x0008
+#define PNP_REMOVABLE		0x0010
+
+#define pnp_can_read(dev)	(((dev)->protocol) && ((dev)->protocol->get) && \
+				 ((dev)->capabilities & PNP_READ))
+#define pnp_can_write(dev)	(((dev)->protocol) && ((dev)->protocol->set) && \
+				 ((dev)->capabilities & PNP_WRITE))
+#define pnp_can_disable(dev)	(((dev)->protocol) && ((dev)->protocol->disable) && \
+				 ((dev)->capabilities & PNP_DISABLE))
+#define pnp_can_configure(dev)	((!(dev)->active) && ((dev)->capabilities & PNP_CONFIGURABLE))
+
+/* status */
+#define PNP_INIT		0x0000
+#define PNP_READY		0x0001
+#define PNP_ATTACHED		0x0002
+#define PNP_BUSY		0x0004
+#define PNP_FAULTY		0x0008
+
 
 /*
  * Driver Management
@@ -303,9 +325,6 @@
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
 };
 
-#define PNP_DYNAMIC		0	/* get or set current resource */
-#define PNP_STATIC		1	/* get or set resource for next boot */
-
 struct pnp_cfg {
 	struct pnp_port *port[8];
 	struct pnp_irq *irq[2];
@@ -325,7 +344,7 @@
 
 	/* functions */
 	int (*get)(struct pnp_dev *dev);
-	int (*set)(struct pnp_dev *dev, struct pnp_cfg *config, char flags);
+	int (*set)(struct pnp_dev *dev, struct pnp_cfg *config);
 	int (*disable)(struct pnp_dev *dev);
 
 	/* used by pnp layer only (look but don't touch) */
@@ -367,7 +386,7 @@
 int pnp_init_res_cfg(struct pnp_res_cfg *template);
 int pnp_activate_dev(struct pnp_dev *dev, struct pnp_res_cfg *template);
 int pnp_disable_dev(struct pnp_dev *dev);
-int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template, int mode);
+int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template);
 void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
 
 /* driver */
@@ -395,7 +414,7 @@
 static inline int pnp_init_res_cfg(struct pnp_res_cfg *template) { return -ENODEV; }
 static inline int pnp_activate_dev(struct pnp_dev *dev, struct pnp_res_cfg *template) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
-static inline int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template, int mode) { return -ENODEV; }
+static inline int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, struct pnp_res_cfg *template) { return -ENODEV; }
 static inline int compare_pnp_id(struct list_head * id_list, const char * id) { return -ENODEV; }
 static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
diff -ur ./a/include/linux/pnpbios.h ./b/include/linux/pnpbios.h
--- ./a/include/linux/pnpbios.h	Tue Dec 10 02:45:54 2002
+++ ./b/include/linux/pnpbios.h	Tue Dec 31 14:33:09 2002
@@ -78,15 +78,15 @@
 /*
  * Plug and Play BIOS flags
  */
-#define PNP_NO_DISABLE		0x0001
-#define PNP_NO_CONFIG		0x0002
-#define PNP_OUTPUT		0x0004
-#define PNP_INPUT		0x0008
-#define PNP_BOOTABLE		0x0010
-#define PNP_DOCK		0x0020
-#define PNP_REMOVABLE		0x0040
-#define pnp_is_static(x) (x->flags & 0x0100) == 0x0000
-#define pnp_is_dynamic(x) x->flags & 0x0080
+#define PNPBIOS_NO_DISABLE		0x0001
+#define PNPBIOS_NO_CONFIG		0x0002
+#define PNPBIOS_OUTPUT			0x0004
+#define PNPBIOS_INPUT			0x0008
+#define PNPBIOS_BOOTABLE		0x0010
+#define PNPBIOS_DOCK			0x0020
+#define PNPBIOS_REMOVABLE		0x0040
+#define pnpbios_is_static(x) ((x)->flags & 0x0100) == 0x0000
+#define pnpbios_is_dynamic(x) (x)->flags & 0x0080
 
 /* 0x8000 through 0xffff are OEM defined */
 
diff -ur ./a/sound/oss/ad1848.c ./b/sound/oss/ad1848.c
--- ./a/sound/oss/ad1848.c	Tue Dec 10 02:46:11 2002
+++ ./b/sound/oss/ad1848.c	Tue Dec 31 15:39:23 2002
@@ -2987,7 +2987,7 @@
 	if(dev->active)
 		return(dev);
 
-	if((err = pnp_activate_dev(dev)) < 0) {
+	if((err = pnp_activate_dev(dev,NULL)) < 0) {
 		printk(KERN_ERR "ad1848: %s %s config failed (out of resources?)[%d]\n", devname, resname, err);
 
 		pnp_disable_dev(dev);
diff -ur ./a/sound/oss/opl3sa2.c ./b/sound/oss/opl3sa2.c
--- ./a/sound/oss/opl3sa2.c	Tue Dec 10 02:45:40 2002
+++ ./b/sound/oss/opl3sa2.c	Tue Dec 31 15:34:44 2002
@@ -836,14 +836,14 @@
 }
 
 #ifdef CONFIG_PNP
-struct pnp_id pnp_opl3sa2_list[] = {
+struct pnp_device_id pnp_opl3sa2_list[] = {
 	{.id = "YMH0021", .driver_data = 0},
 	{.id = ""}
 };
 
 MODULE_DEVICE_TABLE(pnp, pnp_opl3sa2_list);
 
-static int opl3sa2_pnp_probe(struct pnp_dev *dev, const struct pnp_id *dev_id)
+static int opl3sa2_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	int card = opl3sa2_cards_num;
 	if (opl3sa2_cards_num == OPL3SA2_CARDS_MAX)
