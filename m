Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbTCJEzd>; Sun, 9 Mar 2003 23:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262725AbTCJEy2>; Sun, 9 Mar 2003 23:54:28 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:10370 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262724AbTCJExD>;
	Sun, 9 Mar 2003 23:53:03 -0500
Date: Mon, 10 Mar 2003 00:07:48 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.64
Message-ID: <20030310000747.GF2118@neo.rr.com>
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
#	           ChangeSet	1.1083  -> 1.1084 
#	  sound/isa/als100.c	1.8     -> 1.9    
#	 sound/oss/sb_card.h	1.1     -> 1.2    
#	 sound/oss/sb_card.c	1.16    -> 1.17   
#	drivers/pnp/driver.c	1.13    -> 1.14   
#	  drivers/pnp/card.c	1.9     -> 1.10   
#	 include/linux/pnp.h	1.15    -> 1.16   
#	drivers/pnp/system.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/09	ambx1@neo.rr.com	1.1084
# Aditional Card Service Changes
# 
# Fixes many issues that were discovered after testing.  Also cleans up the
# card service code and fixes the card_drvdata bug in which only one driver
# at a time could have driver data.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Sun Mar  9 23:47:21 2003
+++ b/drivers/pnp/card.c	Sun Mar  9 23:47:21 2003
@@ -32,14 +32,21 @@
 	return NULL;
 }
 
-static void generic_card_remove_handler(struct pnp_dev * dev)
+static void generic_card_remove(struct pnp_dev * dev)
+{
+	dev->card_link = NULL;
+}
+
+static void generic_card_remove_first(struct pnp_dev * dev)
 {
 	struct pnp_card_driver * drv = to_pnp_card_driver(dev->driver);
 	if (!dev->card || !drv)
 		return;
 	if (drv->remove)
-		drv->remove(dev->card);
-	drv->link.remove = NULL;
+		drv->remove(dev->card_link);
+	drv->link.remove = &generic_card_remove;
+	kfree(dev->card_link);
+	generic_card_remove(dev);
 }
 
 /**
@@ -81,6 +88,13 @@
 	}
 }
 
+static void pnp_release_card(struct device *dmdev)
+{
+	struct pnp_card * card = to_pnp_card(dmdev);
+	pnp_free_card_ids(card);
+	kfree(card);
+}
+
 /**
  * pnp_add_card - adds a PnP card to the PnP Layer
  * @card: pointer to the card to add
@@ -88,23 +102,31 @@
 
 int pnp_add_card(struct pnp_card * card)
 {
-	int error = 0;
+	int error;
 	struct list_head * pos;
 	if (!card || !card->protocol)
 		return -EINVAL;
 
-	spin_lock(&pnp_lock);
-	list_add_tail(&card->global_list, &pnp_cards);
-	list_add_tail(&card->protocol_list, &card->protocol->cards);
-	spin_unlock(&pnp_lock);
-
-	/* we wait until now to add devices in order to ensure the drivers
-	 * will be able to use all of the related devices on the card 
-	 * without waiting any unresonable length of time */
-	list_for_each(pos,&card->devices){
-		struct pnp_dev *dev = card_to_pnp_dev(pos);
-		__pnp_add_device(dev);
-	}
+	sprintf(card->dev.bus_id, "%02x:%02x", card->protocol->number, card->number);
+	card->dev.parent = &card->protocol->dev;
+	card->dev.bus = NULL;
+	card->dev.release = &pnp_release_card;
+	error = device_register(&card->dev);
+	if (error == 0) {
+		spin_lock(&pnp_lock);
+		list_add_tail(&card->global_list, &pnp_cards);
+		list_add_tail(&card->protocol_list, &card->protocol->cards);
+		spin_unlock(&pnp_lock);
+
+		/* we wait until now to add devices in order to ensure the drivers
+		 * will be able to use all of the related devices on the card
+		 * without waiting any unresonable length of time */
+		list_for_each(pos,&card->devices){
+			struct pnp_dev *dev = card_to_pnp_dev(pos);
+			__pnp_add_device(dev);
+		}
+	} else
+		pnp_err("sysfs failure, card '%s' will be unavailable", card->dev.bus_id);
 	return error;
 }
 
@@ -127,8 +149,6 @@
 		struct pnp_dev *dev = card_to_pnp_dev(pos);
 		pnp_remove_card_device(dev);
 	}
-	pnp_free_card_ids(card);
-	kfree(card);
 }
 
 /**
@@ -141,7 +161,8 @@
 {
 	if (!card || !dev || !dev->protocol)
 		return -EINVAL;
-	dev->dev.parent = &dev->protocol->dev;
+	dev->dev.parent = &card->dev;
+	dev->card_link = NULL;
 	snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%02x:%02x.%02x", dev->protocol->number,
 		 card->number,dev->number);
 	spin_lock(&pnp_lock);
@@ -168,18 +189,21 @@
 
 /**
  * pnp_request_card_device - Searches for a PnP device under the specified card
- * @drv: pointer to the driver requesting the card
- * @card: pointer to the card to search under, cannot be NULL
+ * @lcard: pointer to the card link, cannot be NULL
  * @id: pointer to a PnP ID structure that explains the rules for finding the device
  * @from: Starting place to search from. If NULL it will start from the begining.
  */
 
-struct pnp_dev * pnp_request_card_device(struct pnp_card_driver * drv, struct pnp_card *card, const char * id, struct pnp_dev * from)
+struct pnp_dev * pnp_request_card_device(struct pnp_card_link *clink, const char * id, struct pnp_dev * from)
 {
 	struct list_head * pos;
 	struct pnp_dev * dev;
-	if (!card || !id || !drv)
+	struct pnp_card_driver * drv;
+	struct pnp_card * card;
+	if (!clink || !id)
 		goto done;
+	card = clink->card;
+	drv = clink->driver;
 	if (!from) {
 		pos = card->devices.next;
 	} else {
@@ -189,7 +213,7 @@
 	}
 	while (pos != &card->devices) {
 		dev = card_to_pnp_dev(pos);
-		if (compare_pnp_id(dev->id,id))
+		if ((!dev->card_link) && compare_pnp_id(dev->id,id))
 			goto found;
 		pos = pos->next;
 	}
@@ -199,6 +223,7 @@
 
 found:
 	down_write(&dev->dev.bus->subsys.rwsem);
+	dev->card_link = clink;
 	dev->dev.driver = &drv->link.driver;
 	if (drv->link.driver.probe) {
 		if (drv->link.driver.probe(&dev->dev)) {
@@ -219,13 +244,13 @@
 
 void pnp_release_card_device(struct pnp_dev * dev)
 {
-	struct pnp_card_driver * drv = to_pnp_card_driver(to_pnp_driver(dev->dev.driver));
+	struct pnp_card_driver * drv = dev->card_link->driver;
 	if (!drv)
 		return;
 	down_write(&dev->dev.bus->subsys.rwsem);
-	drv->link.remove = NULL;
+	drv->link.remove = &generic_card_remove;
 	device_release_driver(&dev->dev);
-	drv->link.remove = &generic_card_remove_handler;
+	drv->link.remove = &generic_card_remove_first;
 	up_write(&dev->dev.bus->subsys.rwsem);
 }
 
@@ -243,7 +268,7 @@
 	drv->link.id_table = NULL;	/* this will disable auto matching */
 	drv->link.flags = drv->flags;
 	drv->link.probe = NULL;
-	drv->link.remove = &generic_card_remove_handler;
+	drv->link.remove = &generic_card_remove_first;
 
 	pnp_register_driver(&drv->link);
 
@@ -251,8 +276,13 @@
 		struct pnp_card *card = list_entry(pos, struct pnp_card, global_list);
 		const struct pnp_card_id *id = match_card(drv,card);
 		if (id) {
+			struct pnp_card_link * clink = pnp_alloc(sizeof(struct pnp_card_link));
+			if (!clink)
+				continue;
+			clink->card = card;
+			clink->driver = drv;
 			if (drv->probe) {
-				if (drv->probe(card, id)>=0)
+				if (drv->probe(clink, id)>=0)
 					count++;
 			} else
 				count++;
diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Sun Mar  9 23:47:21 2003
+++ b/drivers/pnp/driver.c	Sun Mar  9 23:47:21 2003
@@ -106,7 +106,8 @@
 			if (error < 0)
 				return error;
 		}
-	} else if (pnp_drv->flags & PNP_DRIVER_RES_DISABLE) {
+	} else if ((pnp_drv->flags & PNP_DRIVER_RES_DISABLE)
+		    == PNP_DRIVER_RES_DISABLE) {
 		error = pnp_disable_dev(pnp_dev);
 		if (error < 0)
 			return error;
diff -Nru a/drivers/pnp/system.c b/drivers/pnp/system.c
--- a/drivers/pnp/system.c	Sun Mar  9 23:47:21 2003
+++ b/drivers/pnp/system.c	Sun Mar  9 23:47:21 2003
@@ -93,8 +93,8 @@
 
 static struct pnp_driver system_pnp_driver = {
 	.name		= "system",
-	.flags		= PNP_DRIVER_RES_DO_NOT_CHANGE, 
 	.id_table	= pnp_dev_table,
+	.flags		= PNP_DRIVER_RES_DO_NOT_CHANGE,
 	.probe		= system_pnp_probe,
 	.remove		= NULL,
 };
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Sun Mar  9 23:47:21 2003
+++ b/include/linux/pnp.h	Sun Mar  9 23:47:21 2003
@@ -138,7 +138,6 @@
 	struct list_head global_list;	/* node in global list of cards */
 	struct list_head protocol_list;	/* node in protocol's list of cards */
 	struct list_head devices;	/* devices attached to the card */
-	int status;
 
 	struct pnp_protocol * protocol;
 	struct pnp_id * id;		/* contains supported EISA IDs*/
@@ -159,24 +158,30 @@
 	(card) != global_to_pnp_card(&pnp_cards); \
 	(card) = global_to_pnp_card((card)->global_list.next))
 
-static inline void *pnp_get_card_drvdata (struct pnp_card *pcard)
+static inline void *pnp_get_card_protodata (struct pnp_card *pcard)
 {
-	return dev_get_drvdata(&pcard->dev);
+	return pcard->protocol_data;
 }
 
-static inline void pnp_set_card_drvdata (struct pnp_card *pcard, void *data)
+static inline void pnp_set_card_protodata (struct pnp_card *pcard, void *data)
 {
-	dev_set_drvdata(&pcard->dev, data);
+	pcard->protocol_data = data;
 }
 
-static inline void *pnp_get_card_protodata (struct pnp_card *pcard)
+struct pnp_card_link {
+	struct pnp_card * card;
+	struct pnp_card_driver * driver;
+	void * driver_data;
+};
+
+static inline void *pnp_get_card_drvdata (struct pnp_card_link *pcard)
 {
-	return pcard->protocol_data;
+	return pcard->driver_data;
 }
 
-static inline void pnp_set_card_protodata (struct pnp_card *pcard, void *data)
+static inline void pnp_set_card_drvdata (struct pnp_card_link *pcard, void *data)
 {
-	pcard->protocol_data = data;
+	pcard->driver_data = data;
 }
 
 struct pnp_dev {
@@ -194,6 +199,7 @@
 	struct pnp_protocol * protocol;
 	struct pnp_card * card;		/* card the device is attached to, none if NULL */
 	struct pnp_driver * driver;
+	struct pnp_card_link * card_link;
 
 	struct pnp_id		      * id;		/* supported EISA IDs*/
 	struct pnp_resource_table	res;		/* contains the currently chosen resources */
@@ -312,8 +318,8 @@
 	char * name;
 	const struct pnp_card_id *id_table;
 	unsigned int flags;
-	int  (*probe)  (struct pnp_card *card, const struct pnp_card_id *card_id);
-	void (*remove) (struct pnp_card *card);
+	int  (*probe)  (struct pnp_card_link *card, const struct pnp_card_id *card_id);
+	void (*remove) (struct pnp_card_link *card);
 	struct pnp_driver link;
 };
 
@@ -372,7 +378,7 @@
 int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev);
 void pnp_remove_card_device(struct pnp_dev *dev);
 int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card);
-struct pnp_dev * pnp_request_card_device(struct pnp_card_driver * drv, struct pnp_card *card, const char * id, struct pnp_dev * from);
+struct pnp_dev * pnp_request_card_device(struct pnp_card_link *clink, const char * id, struct pnp_dev * from);
 void pnp_release_card_device(struct pnp_dev * dev);
 int pnp_register_card_driver(struct pnp_card_driver * drv);
 void pnp_unregister_card_driver(struct pnp_card_driver * drv);
@@ -427,7 +433,7 @@
 static inline int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_remove_card_device(struct pnp_dev *dev) { ; }
 static inline int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card) { return -ENODEV; }
-static inline struct pnp_dev * pnp_request_card_device(struct pnp_card_driver * drv, struct pnp_card *card, const char * id, struct pnp_dev * from) { return -ENODEV; }
+static inline struct pnp_dev * pnp_request_card_device(struct pnp_card_link *clink, const char * id, struct pnp_dev * from) { return -ENODEV; }
 static inline void pnp_release_card_device(struct pnp_dev * dev) { ; }
 static inline int pnp_register_card_driver(struct pnp_card_driver * drv) { return -ENODEV; }
 static inline void pnp_unregister_card_driver(struct pnp_card_driver * drv) { ; }
diff -Nru a/sound/isa/als100.c b/sound/isa/als100.c
--- a/sound/isa/als100.c	Sun Mar  9 23:47:21 2003
+++ b/sound/isa/als100.c	Sun Mar  9 23:47:21 2003
@@ -116,10 +116,8 @@
 
 #define DRIVER_NAME	"snd-card-als100"
 
-static struct pnp_card_driver als100_pnpc_driver;
-
 static int __devinit snd_card_als100_isapnp(int dev, struct snd_card_als100 *acard,
-					    struct pnp_card *card,
+					    struct pnp_card_link *card,
 					    const struct pnp_card_id *id)
 {
 	struct pnp_dev *pdev;
@@ -127,13 +125,13 @@
 	int err;
 	if (!cfg)
 		return -ENOMEM;
-	acard->dev = pnp_request_card_device(&als100_pnpc_driver, card, id->devs[0].id, NULL);
+	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
 	if (acard->dev == NULL) {
 		kfree(cfg);
 		return -ENODEV;
 	}
-	acard->devmpu = pnp_request_card_device(&als100_pnpc_driver, card, id->devs[1].id, acard->dev);
-	acard->devopl = pnp_request_card_device(&als100_pnpc_driver, card, id->devs[2].id, acard->devmpu);
+	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, acard->dev);
+	acard->devopl = pnp_request_card_device(card, id->devs[2].id, acard->devmpu);
 
 	pdev = acard->dev;
 
@@ -210,7 +208,7 @@
 }
 
 static int __init snd_card_als100_probe(int dev,
-					struct pnp_card *pcard,
+					struct pnp_card_link *pcard,
 					const struct pnp_card_id *pid)
 {
 	int error;
@@ -288,7 +286,7 @@
 	return 0;
 }
 
-static int __devinit snd_als100_pnp_detect(struct pnp_card *card,
+static int __devinit snd_als100_pnp_detect(struct pnp_card_link *card,
 					   const struct pnp_card_id *id)
 {
 	static int dev;
@@ -306,7 +304,7 @@
 	return -ENODEV;
 }
 
-static void __devexit snd_als100_pnp_remove(struct pnp_card * pcard)
+static void __devexit snd_als100_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_t *card = (snd_card_t *) pnp_get_card_drvdata(pcard);
 
diff -Nru a/sound/oss/sb_card.c b/sound/oss/sb_card.c
--- a/sound/oss/sb_card.c	Sun Mar  9 23:47:21 2003
+++ b/sound/oss/sb_card.c	Sun Mar  9 23:47:21 2003
@@ -32,9 +32,9 @@
 #include "sound_config.h"
 #include "sb_mixer.h"
 #include "sb.h"
-#ifdef CONFIG_PNP_CARD
+#ifdef CONFIG_PNP
 #include <linux/pnp.h>
-#endif
+#endif /* CONFIG_PNP */
 #include "sb_card.h"
 
 MODULE_DESCRIPTION("OSS Soundblaster ISA PnP and legacy sound driver");
@@ -54,7 +54,7 @@
 
 struct sb_card_config *legacy = NULL;
 
-#ifdef CONFIG_PNP_CARD
+#ifdef CONFIG_PNP
 static int __initdata pnp       = 1;
 /*
 static int __initdata uart401	= 0;
@@ -85,7 +85,7 @@
 MODULE_PARM_DESC(acer,	   "Set this to detect cards in some ACER notebooks "\
 		 "(doesn't work with pnp)");
 
-#ifdef CONFIG_PNP_CARD
+#ifdef CONFIG_PNP
 module_param(pnp, int, 000);
 MODULE_PARM_DESC(pnp,     "Went set to 0 will disable detection using PnP. "\
 		  "Default is 1.\n");
@@ -95,7 +95,7 @@
 MODULE_PARM_DESC(uart401,  "When set to 1, will attempt to detect and enable"\
 		 "the mpu on some clones");
 */
-#endif /* CONFIG_PNP_CARD */
+#endif /* CONFIG_PNP */
 
 /* OSS subsystem card registration shared by PnP and legacy routines */
 static int sb_register_oss(struct sb_card_config *scc, struct sb_module_options *sbmo)
@@ -157,7 +157,7 @@
 	return sb_register_oss(legacy, &sbmo);
 }
 
-#ifdef CONFIG_PNP_CARD
+#ifdef CONFIG_PNP
 
 /* Populate the OSS subsystem structures with information from PnP */
 static void sb_dev2cfg(struct pnp_dev *dev, struct sb_card_config *scc)
@@ -224,7 +224,7 @@
 }
 
 /* Probe callback function for the PnP API */
-static int sb_pnp_probe(struct pnp_card *card, const struct pnp_card_id *card_id)
+static int sb_pnp_probe(struct pnp_card_link *card, const struct pnp_card_id *card_id)
 {
 	struct sb_card_config *scc;
 	struct sb_module_options sbmo = {0}; /* Default to 0 for PnP */
@@ -257,7 +257,7 @@
 	return sb_register_oss(scc, &sbmo);
 }
 
-static void sb_pnp_remove(struct pnp_card *card)
+static void sb_pnp_remove(struct pnp_card_link *card)
 {
 	struct sb_card_config *scc = pnp_get_card_drvdata(card);
 
@@ -275,7 +275,7 @@
 	.probe         = sb_pnp_probe,
 	.remove        = sb_pnp_remove,
 };
-#endif /* CONFIG_PNP_CARD */
+#endif /* CONFIG_PNP */
 
 static int __init sb_init(void)
 {
@@ -293,7 +293,7 @@
 		printk(KERN_ERR "sb: Error: At least io, irq, and dma "\
 		       "must be set for legacy cards.\n");
 
-#ifdef CONFIG_PNP_CARD
+#ifdef CONFIG_PNP
 	if(pnp) {
 		pres = pnp_register_card_driver(&sb_pnp_driver);
 	}
@@ -315,7 +315,7 @@
 		sb_unload(legacy);
 	}
 
-#ifdef CONFIG_PNP_CARD
+#ifdef CONFIG_PNP
 	pnp_unregister_card_driver(&sb_pnp_driver);
 #endif
 
diff -Nru a/sound/oss/sb_card.h b/sound/oss/sb_card.h
--- a/sound/oss/sb_card.h	Sun Mar  9 23:47:21 2003
+++ b/sound/oss/sb_card.h	Sun Mar  9 23:47:21 2003
@@ -16,7 +16,7 @@
 	int                 mpu;
 };
 
-#ifdef CONFIG_PNP_CARD
+#ifdef CONFIG_PNP
 
 /*
  * SoundBlaster PnP tables and structures.
