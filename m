Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267432AbTALTgV>; Sun, 12 Jan 2003 14:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbTALTfc>; Sun, 12 Jan 2003 14:35:32 -0500
Received: from gate.perex.cz ([194.212.165.105]:57863 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267432AbTALTek>;
	Sun, 12 Jan 2003 14:34:40 -0500
Date: Sun, 12 Jan 2003 20:24:53 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: LKML <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] Linux PnP Support 0.94 by Adam Belay
Message-ID: <Pine.LNX.4.33.0301122016510.611-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	this is just repost of Adam's PnP patch 0.94. Linus, please, 
apply. I'll post a next patch ASAP which contains rewritten ISA PnP 
drivers (almost all - except sound drivers) to new PnP subsystem.

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.838.161.1, 2003-01-11 10:57:09+01:00, perex@suse.cz
  Linux PnP Support 0.94
  
  (Adam Belay)            -use list_del instead of list_del_init in some areas
                          -introduce pnp capability and status flags
                          -remove static resource setting, I did some research and found that only
                           PnPBIOS supports it, therefore it is better to implememt this in the
                           PnPBIOS protocol itself. (it appears ACPI doesn't use this)
                          -Remove pnp_dev_has_driver and use PNP_ATTACHED instead, this is necessary
                           because a card driver only has rights over a device that it requests.
                          -added card_for_each_dev macro
                          -undo isapnp protocol changes, the pnp layer was designed to handle cards
                           and devices on the same protocol and I feel they should not be seperated.
  (Pual Laufer)           -Fix remove driver bug in pnp card services
  (Adam Richter)          -Fix a potential oops in id registration functions


 drivers/pnp/card.c         |   27 +++++++++++++++++++--------
 drivers/pnp/core.c         |    9 +++++----
 drivers/pnp/driver.c       |   21 +++++++++++++++++++++
 drivers/pnp/interface.c    |   11 ++++-------
 drivers/pnp/isapnp/core.c  |   22 ++++++++--------------
 drivers/pnp/pnpbios/core.c |   23 +++++++++++++----------
 drivers/pnp/resource.c     |   26 +++++++++++++-------------
 include/linux/pnp.h        |   45 ++++++++++++++++++++++++++++++++-------------
 include/linux/pnpbios.h    |   18 +++++++++---------
 sound/oss/ad1848.c         |    2 +-
 sound/oss/opl3sa2.c        |    4 ++--
 11 files changed, 127 insertions(+), 81 deletions(-)


diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Sun Jan 12 20:13:43 2003
+++ b/drivers/pnp/card.c	Sun Jan 12 20:13:43 2003
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
diff -Nru a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Sun Jan 12 20:13:43 2003
+++ b/drivers/pnp/core.c	Sun Jan 12 20:13:43 2003
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
 
diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Sun Jan 12 20:13:43 2003
+++ b/drivers/pnp/driver.c	Sun Jan 12 20:13:43 2003
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
diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Sun Jan 12 20:13:43 2003
+++ b/drivers/pnp/interface.c	Sun Jan 12 20:13:43 2003
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
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sun Jan 12 20:13:43 2003
+++ b/drivers/pnp/isapnp/core.c	Sun Jan 12 20:13:43 2003
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
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sun Jan 12 20:13:43 2003
+++ b/drivers/pnp/pnpbios/core.c	Sun Jan 12 20:13:43 2003
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
 
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Sun Jan 12 20:13:43 2003
+++ b/drivers/pnp/resource.c	Sun Jan 12 20:13:43 2003
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
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Sun Jan 12 20:13:43 2003
+++ b/include/linux/pnp.h	Sun Jan 12 20:13:43 2003
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
diff -Nru a/include/linux/pnpbios.h b/include/linux/pnpbios.h
--- a/include/linux/pnpbios.h	Sun Jan 12 20:13:43 2003
+++ b/include/linux/pnpbios.h	Sun Jan 12 20:13:43 2003
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
 
diff -Nru a/sound/oss/ad1848.c b/sound/oss/ad1848.c
--- a/sound/oss/ad1848.c	Sun Jan 12 20:13:43 2003
+++ b/sound/oss/ad1848.c	Sun Jan 12 20:13:43 2003
@@ -2987,7 +2987,7 @@
 	if(dev->active)
 		return(dev);
 
-	if((err = pnp_activate_dev(dev)) < 0) {
+	if((err = pnp_activate_dev(dev,NULL)) < 0) {
 		printk(KERN_ERR "ad1848: %s %s config failed (out of resources?)[%d]\n", devname, resname, err);
 
 		pnp_disable_dev(dev);
diff -Nru a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
--- a/sound/oss/opl3sa2.c	Sun Jan 12 20:13:43 2003
+++ b/sound/oss/opl3sa2.c	Sun Jan 12 20:13:43 2003
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

===================================================================


This BitKeeper patch contains the following changesets:
1.838.161.1
## Wrapped with gzip_uu ##


begin 664 bkpatch17311
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
AJ41.`&UK]9]OW#%S[^+Y],08L('IVJ[R/_2/YB7>,P``
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


