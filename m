Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTDDEws (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 23:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTDDEwr (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:52:47 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17285 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261376AbTDDEwR (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:52:17 -0500
Date: Fri, 4 Apr 2003 00:07:31 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030404000731.GB11574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Thu Apr  3 23:41:22 2003
+++ b/drivers/pnp/card.c	Thu Apr  3 23:41:22 2003
@@ -19,6 +19,7 @@
 #include "base.h"
 
 LIST_HEAD(pnp_cards);
+LIST_HEAD(pnp_card_drivers);
 
 
 static const struct pnp_card_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
@@ -32,21 +33,41 @@
 	return NULL;
 }
 
-static void generic_card_remove(struct pnp_dev * dev)
+static void card_remove(struct pnp_dev * dev)
 {
 	dev->card_link = NULL;
 }
-
-static void generic_card_remove_first(struct pnp_dev * dev)
+ 
+static void card_remove_first(struct pnp_dev * dev)
 {
 	struct pnp_card_driver * drv = to_pnp_card_driver(dev->driver);
 	if (!dev->card || !drv)
 		return;
 	if (drv->remove)
 		drv->remove(dev->card_link);
-	drv->link.remove = &generic_card_remove;
+	drv->link.remove = &card_remove;
 	kfree(dev->card_link);
-	generic_card_remove(dev);
+	card_remove(dev);
+}
+
+static int card_probe(struct pnp_card * card, struct pnp_card_driver * drv)
+{
+	const struct pnp_card_id *id = match_card(drv,card);
+	if (id) {
+		struct pnp_card_link * clink = pnp_alloc(sizeof(struct pnp_card_link));
+		if (!clink)
+			return 0;
+		clink->card = card;
+		clink->driver = drv;
+		if (drv->probe) {
+			if (drv->probe(clink, id)>=0)
+				return 1;
+			else
+				kfree(clink);
+		} else
+			return 1;
+	}
+	return 0;
 }
 
 /**
@@ -103,7 +124,7 @@
 int pnp_add_card(struct pnp_card * card)
 {
 	int error;
-	struct list_head * pos;
+	struct list_head * pos, * temp;
 	if (!card || !card->protocol)
 		return -EINVAL;
 
@@ -112,6 +133,7 @@
 	card->dev.bus = NULL;
 	card->dev.release = &pnp_release_card;
 	error = device_register(&card->dev);
+
 	if (error == 0) {
 		spin_lock(&pnp_lock);
 		list_add_tail(&card->global_list, &pnp_cards);
@@ -125,6 +147,12 @@
 			struct pnp_dev *dev = card_to_pnp_dev(pos);
 			__pnp_add_device(dev);
 		}
+
+		/* match with card drivers */
+		list_for_each_safe(pos,temp,&pnp_card_drivers){
+			struct pnp_card_driver * drv = list_entry(pos, struct pnp_card_driver, global_list);
+			card_probe(card,drv);
+		}
 	} else
 		pnp_err("sysfs failure, card '%s' will be unavailable", card->dev.bus_id);
 	return error;
@@ -248,9 +276,9 @@
 	if (!drv)
 		return;
 	down_write(&dev->dev.bus->subsys.rwsem);
-	drv->link.remove = &generic_card_remove;
+	drv->link.remove = &card_remove;
 	device_release_driver(&dev->dev);
-	drv->link.remove = &generic_card_remove_first;
+	drv->link.remove = &card_remove_first;
 	up_write(&dev->dev.bus->subsys.rwsem);
 }
 
@@ -268,25 +296,16 @@
 	drv->link.id_table = NULL;	/* this will disable auto matching */
 	drv->link.flags = drv->flags;
 	drv->link.probe = NULL;
-	drv->link.remove = &generic_card_remove_first;
+	drv->link.remove = &card_remove_first;
 
+	spin_lock(&pnp_lock);
+	list_add_tail(&drv->global_list, &pnp_card_drivers);
+	spin_unlock(&pnp_lock);
 	pnp_register_driver(&drv->link);
 
 	list_for_each_safe(pos,temp,&pnp_cards){
 		struct pnp_card *card = list_entry(pos, struct pnp_card, global_list);
-		const struct pnp_card_id *id = match_card(drv,card);
-		if (id) {
-			struct pnp_card_link * clink = pnp_alloc(sizeof(struct pnp_card_link));
-			if (!clink)
-				continue;
-			clink->card = card;
-			clink->driver = drv;
-			if (drv->probe) {
-				if (drv->probe(clink, id)>=0)
-					count++;
-			} else
-				count++;
-		}
+		count += card_probe(card,drv);
 	}
 	return count;
 }
@@ -298,9 +317,10 @@
 
 void pnp_unregister_card_driver(struct pnp_card_driver * drv)
 {
+	spin_lock(&pnp_lock);
+	list_del(&drv->global_list);
+	spin_unlock(&pnp_lock);
 	pnp_unregister_driver(&drv->link);
-
-	pnp_dbg("the card driver '%s' has been unregistered", drv->name);
 }
 
 EXPORT_SYMBOL(pnp_add_card);
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Thu Apr  3 23:41:22 2003
+++ b/include/linux/pnp.h	Thu Apr  3 23:41:22 2003
@@ -315,6 +315,7 @@
 #define	to_pnp_driver(drv) container_of(drv, struct pnp_driver, driver)
 
 struct pnp_card_driver {
+	struct list_head global_list;
 	char * name;
 	const struct pnp_card_id *id_table;
 	unsigned int flags;
