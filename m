Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbTCJExG>; Sun, 9 Mar 2003 23:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262725AbTCJExG>; Sun, 9 Mar 2003 23:53:06 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:8066 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262721AbTCJEv7>;
	Sun, 9 Mar 2003 23:51:59 -0500
Date: Mon, 10 Mar 2003 00:06:42 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.64
Message-ID: <20030310000642.GC2118@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030310000521.GA2118@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310000521.GA2118@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1080  -> 1.1081 
#	drivers/pnp/Makefile	1.12    -> 1.13   
#	 drivers/pnp/Kconfig	1.3     -> 1.4    
#	drivers/pnp/isapnp/core.c	1.31    -> 1.32   
#	drivers/pnp/driver.c	1.12    -> 1.13   
#	  drivers/pnp/card.c	1.8     -> 1.9    
#	 include/linux/pnp.h	1.14    -> 1.15   
#	drivers/pnp/system.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/09	ambx1@neo.rr.com	1.1081
# PnP Card Serivice Revisions
# 
# This set of changes addresses the following issues with the existing card 
# service implementation:
# 
# 1.) Only one driver can be bound to a card.
# 2.) repetive code is required for pnp_request_card_device and other 
# functions
# 
# This patch will make the card services usable by ALSA.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/Kconfig b/drivers/pnp/Kconfig
--- a/drivers/pnp/Kconfig	Sun Mar  9 23:47:56 2003
+++ b/drivers/pnp/Kconfig	Sun Mar  9 23:47:56 2003
@@ -30,15 +30,6 @@
 
 	  If unsure, say Y.
 
-config PNP_CARD
-	bool "Plug and Play card services"
-	depends on PNP
-	help
-	  Select Y if you want the PnP Layer to manage cards.  Cards are groups
-	  of PnP devices.  Some drivers, especially PnP sound card drivers, use
-	  these cards.  If you want to use the protocol ISAPNP you will need to
-	  say Y here.
-
 config PNP_DEBUG
 	bool "PnP Debug Messages"
 	depends on PNP
@@ -51,7 +42,7 @@
 
 config ISAPNP
 	bool "ISA Plug and Play support (EXPERIMENTAL)"
-	depends on PNP && EXPERIMENTAL && PNP_CARD
+	depends on PNP && EXPERIMENTAL
 	help
 	  Say Y here if you would like support for ISA Plug and Play devices.
 	  Some information is in <file:Documentation/isapnp.txt>.
diff -Nru a/drivers/pnp/Makefile b/drivers/pnp/Makefile
--- a/drivers/pnp/Makefile	Sun Mar  9 23:47:56 2003
+++ b/drivers/pnp/Makefile	Sun Mar  9 23:47:56 2003
@@ -2,9 +2,7 @@
 # Makefile for the Linux Plug-and-Play Support.
 #
 
-pnp-card-$(CONFIG_PNP_CARD) = card.o
-
-obj-y		:= core.o driver.o resource.o manager.o support.o interface.o quirks.o names.o system.o $(pnp-card-y)
+obj-y		:= core.o card.o driver.o resource.o manager.o support.o interface.o quirks.o names.o system.o
 
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Sun Mar  9 23:47:56 2003
+++ b/drivers/pnp/card.c	Sun Mar  9 23:47:56 2003
@@ -16,15 +16,14 @@
 #endif
 
 #include <linux/pnp.h>
-#include <linux/init.h>
 #include "base.h"
 
-
 LIST_HEAD(pnp_cards);
 
-static const struct pnp_card_id * match_card(struct pnpc_driver *drv, struct pnp_card *card)
+
+static const struct pnp_card_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
 {
-	const struct pnp_card_id *drv_id = drv->id_table;
+	const struct pnp_card_id * drv_id = drv->id_table;
 	while (*drv_id->id){
 		if (compare_pnp_id(card->id,drv_id->id))
 			return drv_id;
@@ -33,31 +32,26 @@
 	return NULL;
 }
 
-static int card_bus_match(struct device *dev, struct device_driver *drv)
+static void generic_card_remove_handler(struct pnp_dev * dev)
 {
-	struct pnp_card * card = to_pnp_card(dev);
-	struct pnpc_driver * pnp_drv = to_pnpc_driver(drv);
-	if (match_card(pnp_drv, card) == NULL)
-		return 0;
-	return 1;
+	struct pnp_card_driver * drv = to_pnp_card_driver(dev->driver);
+	if (!dev->card || !drv)
+		return;
+	if (drv->remove)
+		drv->remove(dev->card);
+	drv->link.remove = NULL;
 }
 
-struct bus_type pnpc_bus_type = {
-	.name	= "pnp_card",
-	.match	= card_bus_match,
-};
-
-
 /**
- * pnpc_add_id - adds an EISA id to the specified card
+ * pnp_add_card_id - adds an EISA id to the specified card
  * @id: pointer to a pnp_id structure
  * @card: pointer to the desired card
  *
  */
 
-int pnpc_add_id(struct pnp_id *id, struct pnp_card *card)
+int pnp_add_card_id(struct pnp_id *id, struct pnp_card * card)
 {
-	struct pnp_id *ptr;
+	struct pnp_id * ptr;
 	if (!id)
 		return -EINVAL;
 	if (!card)
@@ -73,7 +67,7 @@
 	return 0;
 }
 
-static void pnpc_free_ids(struct pnp_card *card)
+static void pnp_free_card_ids(struct pnp_card * card)
 {
 	struct pnp_id * id;
 	struct pnp_id *next;
@@ -87,50 +81,39 @@
 	}
 }
 
-static void pnp_release_card(struct device *dmdev)
-{
-	struct pnp_card * card = to_pnp_card(dmdev);
-	pnpc_free_ids(card);
-	kfree(card);
-}
-
 /**
- * pnpc_add_card - adds a PnP card to the PnP Layer
+ * pnp_add_card - adds a PnP card to the PnP Layer
  * @card: pointer to the card to add
  */
 
-int pnpc_add_card(struct pnp_card *card)
+int pnp_add_card(struct pnp_card * card)
 {
 	int error = 0;
+	struct list_head * pos;
 	if (!card || !card->protocol)
 		return -EINVAL;
-	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number, card->number);
-	INIT_LIST_HEAD(&card->rdevs);
-	card->dev.parent = &card->protocol->dev;
-	card->dev.bus = &pnpc_bus_type;
-	card->dev.release = &pnp_release_card;
-	card->status = PNP_READY;
-	error = device_register(&card->dev);
-	if (error == 0){
-		struct list_head *pos;
-		spin_lock(&pnp_lock);
-		list_add_tail(&card->global_list, &pnp_cards);
-		list_add_tail(&card->protocol_list, &card->protocol->cards);
-		spin_unlock(&pnp_lock);
-		list_for_each(pos,&card->devices){
-			struct pnp_dev *dev = card_to_pnp_dev(pos);
-			__pnp_add_device(dev);
-		}
+
+	spin_lock(&pnp_lock);
+	list_add_tail(&card->global_list, &pnp_cards);
+	list_add_tail(&card->protocol_list, &card->protocol->cards);
+	spin_unlock(&pnp_lock);
+
+	/* we wait until now to add devices in order to ensure the drivers
+	 * will be able to use all of the related devices on the card 
+	 * without waiting any unresonable length of time */
+	list_for_each(pos,&card->devices){
+		struct pnp_dev *dev = card_to_pnp_dev(pos);
+		__pnp_add_device(dev);
 	}
 	return error;
 }
 
 /**
- * pnpc_remove_card - removes a PnP card from the PnP Layer
+ * pnp_remove_card - removes a PnP card from the PnP Layer
  * @card: pointer to the card to remove
  */
 
-void pnpc_remove_card(struct pnp_card *card)
+void pnp_remove_card(struct pnp_card * card)
 {
 	struct list_head *pos, *temp;
 	if (!card)
@@ -142,22 +125,25 @@
 	spin_unlock(&pnp_lock);
 	list_for_each_safe(pos,temp,&card->devices){
 		struct pnp_dev *dev = card_to_pnp_dev(pos);
-		pnpc_remove_device(dev);
+		pnp_remove_card_device(dev);
 	}
+	pnp_free_card_ids(card);
+	kfree(card);
 }
 
 /**
- * pnpc_add_device - adds a device to the specified card
+ * pnp_add_card_device - adds a device to the specified card
  * @card: pointer to the card to add to
  * @dev: pointer to the device to add
  */
 
-int pnpc_add_device(struct pnp_card *card, struct pnp_dev *dev)
+int pnp_add_card_device(struct pnp_card * card, struct pnp_dev * dev)
 {
-	if (!dev || !dev->protocol || !card)
+	if (!card || !dev || !dev->protocol)
 		return -EINVAL;
-	dev->dev.parent = &card->dev;
-	sprintf(dev->dev.bus_id, "%02x:%02x.%02x", dev->protocol->number, card->number,dev->number);
+	dev->dev.parent = &dev->protocol->dev;
+	snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%02x:%02x.%02x", dev->protocol->number,
+		 card->number,dev->number);
 	spin_lock(&pnp_lock);
 	dev->card = card;
 	list_add_tail(&dev->card_list, &card->devices);
@@ -166,12 +152,12 @@
 }
 
 /**
- * pnpc_remove_device- removes a device from the specified card
+ * pnp_remove_card_device- removes a device from the specified card
  * @card: pointer to the card to remove from
  * @dev: pointer to the device to remove
  */
 
-void pnpc_remove_device(struct pnp_dev *dev)
+void pnp_remove_card_device(struct pnp_dev * dev)
 {
 	spin_lock(&pnp_lock);
 	dev->card = NULL;
@@ -182,19 +168,17 @@
 
 /**
  * pnp_request_card_device - Searches for a PnP device under the specified card
+ * @drv: pointer to the driver requesting the card
  * @card: pointer to the card to search under, cannot be NULL
  * @id: pointer to a PnP ID structure that explains the rules for finding the device
  * @from: Starting place to search from. If NULL it will start from the begining.
- *
- * Will activate the device
  */
 
-struct pnp_dev * pnp_request_card_device(struct pnp_card *card, const char *id, struct pnp_dev *from)
+struct pnp_dev * pnp_request_card_device(struct pnp_card_driver * drv, struct pnp_card *card, const char * id, struct pnp_dev * from)
 {
-	struct list_head *pos;
-	struct pnp_dev *dev;
-	struct pnpc_driver *cdrv;
-	if (!card || !id)
+	struct list_head * pos;
+	struct pnp_dev * dev;
+	if (!card || !id || !drv)
 		goto done;
 	if (!from) {
 		pos = card->devices.next;
@@ -214,168 +198,87 @@
 	return NULL;
 
 found:
-	if (pnp_device_attach(dev) < 0)
-		return NULL;
-	cdrv = to_pnpc_driver(card->dev.driver);
-	if (dev->active == 0) {
-		if (!(cdrv->flags & PNPC_DRIVER_DO_NOT_ACTIVATE)) {
-			if(pnp_activate_dev(dev)<0) {
-				pnp_device_detach(dev);
-				return NULL;
-			}
+	down_write(&dev->dev.bus->subsys.rwsem);
+	dev->dev.driver = &drv->link.driver;
+	if (drv->link.driver.probe) {
+		if (drv->link.driver.probe(&dev->dev)) {
+			dev->dev.driver = NULL;
+			return NULL;
 		}
-	} else {
-		if ((cdrv->flags & PNPC_DRIVER_DO_NOT_ACTIVATE))
-			pnp_disable_dev(dev);
 	}
-	spin_lock(&pnp_lock);
-	list_add_tail(&dev->rdev_list, &card->rdevs);
-	spin_unlock(&pnp_lock);
+	device_bind_driver(&dev->dev);
+	up_write(&dev->dev.bus->subsys.rwsem);
+
 	return dev;
 }
 
 /**
  * pnp_release_card_device - call this when the driver no longer needs the device
  * @dev: pointer to the PnP device stucture
- *
- * Will disable the device
  */
 
-void pnp_release_card_device(struct pnp_dev *dev)
-{
-	spin_lock(&pnp_lock);
-	list_del(&dev->rdev_list);
-	spin_unlock(&pnp_lock);
-	pnp_device_detach(dev);
-}
-
-static void pnpc_recover_devices(struct pnp_card *card)
-{
-	struct list_head *pos, *temp;
-	list_for_each_safe(pos,temp,&card->rdevs){
-		struct pnp_dev *dev = list_entry(pos, struct pnp_dev, rdev_list);
-		pnp_release_card_device(dev);
-	}
-}
-
-int pnpc_attach(struct pnp_card *pnp_card)
+void pnp_release_card_device(struct pnp_dev * dev)
 {
-	spin_lock(&pnp_lock);
-	if(pnp_card->status != PNP_READY){
-		spin_unlock(&pnp_lock);
-		return -EBUSY;
-	}
-	pnp_card->status = PNP_ATTACHED;
-	spin_unlock(&pnp_lock);
-	return 0;
-}
- 
-void pnpc_detach(struct pnp_card *pnp_card)
-{
-	spin_lock(&pnp_lock);
-	if (pnp_card->status == PNP_ATTACHED)
-		pnp_card->status = PNP_READY;
-	spin_unlock(&pnp_lock);
-	pnpc_recover_devices(pnp_card);
-}
-
-static int pnpc_card_probe(struct device *dev)
-{
-	int error = 0;
-	struct pnpc_driver *drv = to_pnpc_driver(dev->driver);
-	struct pnp_card *card = to_pnp_card(dev);
-	const struct pnp_card_id *card_id = NULL;
-
-	pnp_dbg("pnp: match found with the PnP card '%s' and the driver '%s'", dev->bus_id,drv->name);
-
-	error = pnpc_attach(card);
-	if (error < 0)
-		return error;
-	if (drv->probe) {
-		card_id = match_card(drv, card);
-		if (card_id != NULL)
-			error = drv->probe(card, card_id);
-		if (error >= 0){
-			card->driver = drv;
-			error = 0;
-		} else
-			pnpc_detach(card);
-	}
-	return error;
-}
-
-static int pnpc_card_remove(struct device *dev)
-{
-	struct pnp_card * card = to_pnp_card(dev);
-	struct pnpc_driver * drv = card->driver;
-
-	if (drv) {
-		if (drv->remove)
-			drv->remove(card);
-		card->driver = NULL;
-	}
-	pnpc_detach(card);
-	return 0;
+	struct pnp_card_driver * drv = to_pnp_card_driver(to_pnp_driver(dev->dev.driver));
+	if (!drv)
+		return;
+	down_write(&dev->dev.bus->subsys.rwsem);
+	drv->link.remove = NULL;
+	device_release_driver(&dev->dev);
+	drv->link.remove = &generic_card_remove_handler;
+	up_write(&dev->dev.bus->subsys.rwsem);
 }
 
 /**
- * pnpc_register_driver - registers a PnP card driver with the PnP Layer
- * @cdrv: pointer to the driver to register
+ * pnp_register_card_driver - registers a PnP card driver with the PnP Layer
+ * @drv: pointer to the driver to register
  */
 
-int pnpc_register_driver(struct pnpc_driver * drv)
+int pnp_register_card_driver(struct pnp_card_driver * drv)
 {
-	int count;
-	struct list_head *pos;
-
-	drv->driver.name = drv->name;
-	drv->driver.bus = &pnpc_bus_type;
-	drv->driver.probe = pnpc_card_probe;
-	drv->driver.remove = pnpc_card_remove;
-
-	pnp_dbg("the card driver '%s' has been registered", drv->name);
-
-	count = driver_register(&drv->driver);
+	int count = 0;
+	struct list_head *pos, *temp;
 
-	/* get the number of initial matches */
-	if (count >= 0){
-		count = 0;
-		list_for_each(pos,&drv->driver.devices){
-			count++;
+	drv->link.name = drv->name;
+	drv->link.id_table = NULL;	/* this will disable auto matching */
+	drv->link.flags = drv->flags;
+	drv->link.probe = NULL;
+	drv->link.remove = &generic_card_remove_handler;
+
+	pnp_register_driver(&drv->link);
+
+	list_for_each_safe(pos,temp,&pnp_cards){
+		struct pnp_card *card = list_entry(pos, struct pnp_card, global_list);
+		const struct pnp_card_id *id = match_card(drv,card);
+		if (id) {
+			if (drv->probe) {
+				if (drv->probe(card, id)>=0)
+					count++;
+			} else
+				count++;
 		}
 	}
 	return count;
 }
 
 /**
- * pnpc_unregister_driver - unregisters a PnP card driver from the PnP Layer
- * @cdrv: pointer to the driver to unregister
- *
- * Automatically disables requested devices
+ * pnp_unregister_card_driver - unregisters a PnP card driver from the PnP Layer
+ * @drv: pointer to the driver to unregister
  */
 
-void pnpc_unregister_driver(struct pnpc_driver *drv)
+void pnp_unregister_card_driver(struct pnp_card_driver * drv)
 {
-	driver_unregister(&drv->driver);
-	pnp_dbg("the card driver '%s' has been unregistered", drv->name);
-}
+	pnp_unregister_driver(&drv->link);
 
-static int __init pnp_card_init(void)
-{
-	printk(KERN_INFO "pnp: Enabling Plug and Play Card Services.\n");
-	return bus_register(&pnpc_bus_type);
+	pnp_dbg("the card driver '%s' has been unregistered", drv->name);
 }
 
-subsys_initcall(pnp_card_init);
-
-EXPORT_SYMBOL(pnpc_add_card);
-EXPORT_SYMBOL(pnpc_remove_card);
-EXPORT_SYMBOL(pnpc_add_device);
-EXPORT_SYMBOL(pnpc_remove_device);
+EXPORT_SYMBOL(pnp_add_card);
+EXPORT_SYMBOL(pnp_remove_card);
+EXPORT_SYMBOL(pnp_add_card_device);
+EXPORT_SYMBOL(pnp_remove_card_device);
+EXPORT_SYMBOL(pnp_add_card_id);
 EXPORT_SYMBOL(pnp_request_card_device);
 EXPORT_SYMBOL(pnp_release_card_device);
-EXPORT_SYMBOL(pnpc_register_driver);
-EXPORT_SYMBOL(pnpc_unregister_driver);
-EXPORT_SYMBOL(pnpc_add_id);
-EXPORT_SYMBOL(pnpc_attach);
-EXPORT_SYMBOL(pnpc_detach);
+EXPORT_SYMBOL(pnp_register_card_driver);
+EXPORT_SYMBOL(pnp_unregister_card_driver);
diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Sun Mar  9 23:47:56 2003
+++ b/drivers/pnp/driver.c	Sun Mar  9 23:47:56 2003
@@ -53,12 +53,11 @@
 static const struct pnp_device_id * match_device(struct pnp_driver *drv, struct pnp_dev *dev)
 {
 	const struct pnp_device_id *drv_id = drv->id_table;
-	if (!drv)
+	if (!drv_id)
 		return NULL;
-	if (!dev)
-		return NULL;
-	while (*drv_id->id){
-		if (compare_pnp_id(dev->id,drv_id->id))
+
+	while (*drv_id->id) {
+		if (compare_pnp_id(dev->id, drv_id->id))
 			return drv_id;
 		drv_id++;
 	}
@@ -102,14 +101,18 @@
 		return error;
 
 	if (pnp_dev->active == 0) {
-		if (!(pnp_drv->flags & PNP_DRIVER_DO_NOT_ACTIVATE)) {
+		if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
 			error = pnp_activate_dev(pnp_dev);
 			if (error < 0)
 				return error;
 		}
+	} else if (pnp_drv->flags & PNP_DRIVER_RES_DISABLE) {
+		error = pnp_disable_dev(pnp_dev);
+		if (error < 0)
+			return error;
 	}
 	error = 0;
-	if (pnp_drv->probe && pnp_dev->active) {
+	if (pnp_drv->probe) {
 		dev_id = match_device(pnp_drv, pnp_dev);
 		if (dev_id != NULL)
 			error = pnp_drv->probe(pnp_dev, dev_id);
@@ -117,9 +120,8 @@
 	if (error >= 0){
 		pnp_dev->driver = pnp_drv;
 		error = 0;
-	}
-	else
-	goto fail;
+	} else
+		goto fail;
 	return error;
 
 fail:
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sun Mar  9 23:47:56 2003
+++ b/drivers/pnp/isapnp/core.c	Sun Mar  9 23:47:56 2003
@@ -626,7 +626,7 @@
 		isapnp_peek(name, size1);
 		name[size1] = '\0';
 		*size -= size1;
-		
+
 		/* clean whitespace from end of string */
 		while (size1 > 0  &&  name[--size1] == ' ')
 			name[size1] = '\0';
@@ -647,7 +647,7 @@
 		return 1;
 	if (pnp_build_resource(dev, 0) == NULL)
 		return 1;
-	pnpc_add_device(card,dev);
+	pnp_add_card_device(card,dev);
 	while (1) {
 		if (isapnp_read_tag(&type, &size)<0)
 			return 1;
@@ -659,7 +659,7 @@
 				if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
 					return 1;
 				pnp_build_resource(dev,0);
-				pnpc_add_device(card,dev);
+				pnp_add_card_device(card,dev);
 				size = 0;
 				skip = 0;
 			} else {
@@ -852,7 +852,7 @@
 			device & 0x0f,
 			(device >> 12) & 0x0f,
 			(device >> 8) & 0x0f);
-	pnpc_add_id(id,card);
+	pnp_add_card_id(id,card);
 }
 
 
@@ -962,7 +962,7 @@
 			isapnp_parse_current_resources(dev, &dev->res);
 		}
 
-		pnpc_add_card(card);
+		pnp_add_card(card);
 	}
 	isapnp_wait();
 	return 0;
diff -Nru a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	Sun Mar  9 23:47:56 2003
+++ b/drivers/pnp/system.c	Sun Mar  9 23:47:56 2003
@@ -93,7 +93,7 @@
 
 static struct pnp_driver system_pnp_driver = {
 	.name		= "system",
-	.flags		= PNP_DRIVER_DO_NOT_ACTIVATE, 
+	.flags		= PNP_DRIVER_RES_DO_NOT_CHANGE, 
 	.id_table	= pnp_dev_table,
 	.probe		= system_pnp_probe,
 	.remove		= NULL,
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Sun Mar  9 23:47:56 2003
+++ b/include/linux/pnp.h	Sun Mar  9 23:47:56 2003
@@ -138,11 +138,9 @@
 	struct list_head global_list;	/* node in global list of cards */
 	struct list_head protocol_list;	/* node in protocol's list of cards */
 	struct list_head devices;	/* devices attached to the card */
-	struct list_head rdevs;		/* a list of devices requested by the card driver */
 	int status;
 
 	struct pnp_protocol * protocol;
-	struct pnpc_driver * driver;
 	struct pnp_id * id;		/* contains supported EISA IDs*/
 
 	void	      * protocol_data;	/* Used to store protocol specific data */
@@ -161,22 +159,22 @@
 	(card) != global_to_pnp_card(&pnp_cards); \
 	(card) = global_to_pnp_card((card)->global_list.next))
 
-static inline void *pnpc_get_drvdata (struct pnp_card *pcard)
+static inline void *pnp_get_card_drvdata (struct pnp_card *pcard)
 {
 	return dev_get_drvdata(&pcard->dev);
 }
 
-static inline void pnpc_set_drvdata (struct pnp_card *pcard, void *data)
+static inline void pnp_set_card_drvdata (struct pnp_card *pcard, void *data)
 {
 	dev_set_drvdata(&pcard->dev, data);
 }
 
-static inline void *pnpc_get_protodata (struct pnp_card *pcard)
+static inline void *pnp_get_card_protodata (struct pnp_card *pcard)
 {
 	return pcard->protocol_data;
 }
 
-static inline void pnpc_set_protodata (struct pnp_card *pcard, void *data)
+static inline void pnp_set_card_protodata (struct pnp_card *pcard, void *data)
 {
 	pcard->protocol_data = data;
 }
@@ -299,11 +297,8 @@
 	} devs[PNP_MAX_DEVICES];	/* logical devices */
 };
 
-#define PNP_DRIVER_DO_NOT_ACTIVATE	(1<<0)
-
 struct pnp_driver {
-	struct list_head node;
-	char *name;
+	char * name;
 	const struct pnp_device_id *id_table;
 	unsigned int flags;
 	int  (*probe)  (struct pnp_dev *dev, const struct pnp_device_id *dev_id);
@@ -311,21 +306,22 @@
 	struct device_driver driver;
 };
 
-#define	to_pnp_driver(drv) container_of(drv,struct pnp_driver, driver)
-
-#define PNPC_DRIVER_DO_NOT_ACTIVATE	(1<<0)
+#define	to_pnp_driver(drv) container_of(drv, struct pnp_driver, driver)
 
-struct pnpc_driver {
-	struct list_head node;
-	char *name;
+struct pnp_card_driver {
+	char * name;
 	const struct pnp_card_id *id_table;
 	unsigned int flags;
 	int  (*probe)  (struct pnp_card *card, const struct pnp_card_id *card_id);
 	void (*remove) (struct pnp_card *card);
-	struct device_driver driver;
+	struct pnp_driver link;
 };
 
-#define	to_pnpc_driver(drv) container_of(drv,struct pnpc_driver, driver)
+#define	to_pnp_card_driver(drv) container_of(drv, struct pnp_card_driver, link)
+
+/* pnp driver flags */
+#define PNP_DRIVER_RES_DO_NOT_CHANGE	0x0001	/* do not change the state of the device */
+#define PNP_DRIVER_RES_DISABLE		0x0003	/* ensure the device is disabled */
 
 
 /*
@@ -366,9 +362,21 @@
 void pnp_unregister_protocol(struct pnp_protocol *protocol);
 int pnp_add_device(struct pnp_dev *dev);
 void pnp_remove_device(struct pnp_dev *dev);
-extern struct list_head pnp_global;
 int pnp_device_attach(struct pnp_dev *pnp_dev);
 void pnp_device_detach(struct pnp_dev *pnp_dev);
+extern struct list_head pnp_global;
+
+/* card */
+int pnp_add_card(struct pnp_card *card);
+void pnp_remove_card(struct pnp_card *card);
+int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev);
+void pnp_remove_card_device(struct pnp_dev *dev);
+int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card);
+struct pnp_dev * pnp_request_card_device(struct pnp_card_driver * drv, struct pnp_card *card, const char * id, struct pnp_dev * from);
+void pnp_release_card_device(struct pnp_dev * dev);
+int pnp_register_card_driver(struct pnp_card_driver * drv);
+void pnp_unregister_card_driver(struct pnp_card_driver * drv);
+extern struct list_head pnp_cards;
 
 /* resource */
 struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent);
@@ -413,6 +421,17 @@
 static inline int pnp_device_attach(struct pnp_dev *pnp_dev) { return -ENODEV; }
 static inline void pnp_device_detach(struct pnp_dev *pnp_dev) { ; }
 
+/* card */
+static inline int pnp_add_card(struct pnp_card *card) { return -ENODEV; }
+static inline void pnp_remove_card(struct pnp_card *card) { ; }
+static inline int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev) { return -ENODEV; }
+static inline void pnp_remove_card_device(struct pnp_dev *dev) { ; }
+static inline int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card) { return -ENODEV; }
+static inline struct pnp_dev * pnp_request_card_device(struct pnp_card_driver * drv, struct pnp_card *card, const char * id, struct pnp_dev * from) { return -ENODEV; }
+static inline void pnp_release_card_device(struct pnp_dev * dev) { ; }
+static inline int pnp_register_card_driver(struct pnp_card_driver * drv) { return -ENODEV; }
+static inline void pnp_unregister_card_driver(struct pnp_card_driver * drv) { ; }
+
 /* resource */
 static inline struct pnp_resources * pnp_build_resource(struct pnp_dev *dev, int dependent) { return NULL; }
 static inline struct pnp_resources * pnp_find_resources(struct pnp_dev *dev, int depnum) { return NULL; }
@@ -445,37 +464,6 @@
 
 #endif /* CONFIG_PNP */
 
-
-#if defined(CONFIG_PNP_CARD)
-
-/* card */
-int pnpc_add_card(struct pnp_card *card);
-void pnpc_remove_card(struct pnp_card *card);
-int pnpc_add_device(struct pnp_card *card, struct pnp_dev *dev);
-void pnpc_remove_device(struct pnp_dev *dev);
-struct pnp_dev * pnp_request_card_device(struct pnp_card *card, const char *id, struct pnp_dev *from);
-void pnp_release_card_device(struct pnp_dev *dev);
-int pnpc_register_driver(struct pnpc_driver * drv);
-void pnpc_unregister_driver(struct pnpc_driver *drv);
-int pnpc_add_id(struct pnp_id *id, struct pnp_card *card);
-extern struct list_head pnp_cards;
-int pnpc_attach(struct pnp_card *card);
-void pnpc_detach(struct pnp_card *card);
-
-#else
-
-/* card */
-static inline int pnpc_add_card(struct pnp_card *card) { return -ENODEV; }
-static inline void pnpc_remove_card(struct pnp_card *card) { ; }
-static inline int pnpc_add_device(struct pnp_card *card, struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnpc_remove_device(struct pnp_dev *dev) { ; }
-static inline struct pnp_dev * pnp_request_card_device(struct pnp_card *card, const char *id, struct pnp_dev *from) { return NULL; }
-static inline void pnp_release_card_device(struct pnp_dev *dev) { ; }
-static inline int pnpc_register_driver(struct pnpc_driver *drv) { return -ENODEV; }
-static inline void pnpc_unregister_driver(struct pnpc_driver *drv) { ; }
-static inline int pnpc_add_id(struct pnp_id *id, struct pnp_card *card) { return -ENODEV; }
-
-#endif /* CONFIG_PNP_CARD */
 
 #define pnp_err(format, arg...) printk(KERN_ERR "pnp: " format "\n" , ## arg)
 #define pnp_info(format, arg...) printk(KERN_INFO "pnp: " format "\n" , ## arg)
