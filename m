Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbTIYR14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbTIYR1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:27:04 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:48793 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261407AbTIYRWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:22:22 -0400
Date: Thu, 25 Sep 2003 19:21:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (15/19): lcs driver.
Message-ID: <20030925172138.GP2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Add type and timeout attribute.
 - Create symlinks between netdev and groupdev.
 - Remove initialization of device.name.

diffstat:
 drivers/s390/net/lcs.c |   77 +++++++++++++++++++++++++++++++++++++++++++++----
 drivers/s390/net/lcs.h |    4 +-
 2 files changed, 74 insertions(+), 7 deletions(-)

diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Thu Sep 25 18:33:27 2003
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Thu Sep 25 18:33:32 2003
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.53 $	 $Date: 2003/06/17 11:36:45 $
+ *    $Revision: 1.58 $	 $Date: 2003/09/22 13:33:56 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.53 $"
+#define VERSION_LCS_C  "$Revision: 1.58 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 
@@ -159,6 +159,7 @@
 		return NULL;
 	memset(card, 0, sizeof(struct lcs_card));
 	card->lan_type = LCS_FRAME_TYPE_AUTO;
+	card->lancmd_timeout = LCS_LANCMD_TIMEOUT_DEFAULT;
 	return card;
 }
 
@@ -690,7 +691,7 @@
 	init_timer(&timer);
 	timer.function = lcs_lancmd_timeout;
 	timer.data = (unsigned long) &reply;
-	timer.expires = jiffies + HZ*5;
+	timer.expires = jiffies + HZ*card->lancmd_timeout;
 	add_timer(&timer);
 	wait_event(reply.wait_q, reply.received);
 	del_timer(&timer);
@@ -1675,8 +1676,55 @@
 
 static DEVICE_ATTR(portno, 0644, lcs_portno_show, lcs_portno_store);
 
+static ssize_t
+lcs_type_show(struct device *dev, char *buf)
+{
+	struct ccwgroup_device *cgdev;
+
+	cgdev = to_ccwgroupdev(dev);
+	if (!cgdev)
+		return -ENODEV;
+
+	return sprintf(buf, "%s\n", cu3088_type[cgdev->cdev[0]->id.driver_info]);
+}
+
+static DEVICE_ATTR(type, 0444, lcs_type_show, NULL);
+
+static ssize_t
+lcs_timeout_show(struct device *dev, char *buf)
+{
+	struct lcs_card *card;
+
+	card = (struct lcs_card *)dev->driver_data;
+
+	return card ? sprintf(buf, "%u\n", card->lancmd_timeout) : 0;
+}
+
+static ssize_t
+lcs_timeout_store (struct device *dev, const char *buf, size_t count)
+{
+        struct lcs_card *card;
+        int value;
+
+	card = (struct lcs_card *)dev->driver_data;
+
+        if (!card)
+                return 0;
+
+        sscanf(buf, "%u", &value);
+        /* TODO: sanity checks */
+        card->lancmd_timeout = value;
+
+        return count;
+
+}
+
+DEVICE_ATTR(lancmd_timeout, 0644, lcs_timeout_show, lcs_timeout_store);
+
 static struct attribute * lcs_attrs[] = {
 	&dev_attr_portno.attr,
+	&dev_attr_type.attr,
+	&dev_attr_lancmd_timeout.attr,
 	NULL,
 };
 
@@ -1711,8 +1759,6 @@
 		return ret;
         }
 	ccwgdev->dev.driver_data = card;
-	snprintf(ccwgdev->dev.name, DEVICE_NAME_SIZE, "%s",
-		 cu3088_type[ccwgdev->cdev[0]->id.driver_info]);
 	ccwgdev->cdev[0]->dev.driver_data = card;
 	ccwgdev->cdev[0]->handler = lcs_irq;
 	ccwgdev->cdev[1]->dev.driver_data = card;
@@ -1797,6 +1843,18 @@
 	SET_MODULE_OWNER(dev);
 	if (register_netdev(dev) != 0)
 		goto out;
+	/* Create symlinks. */
+	if (sysfs_create_link(&ccwgdev->dev.kobj, &dev->class_dev.kobj,
+			      dev->name)) {
+		unregister_netdev(dev);
+		goto out;
+	}
+	if (sysfs_create_link(&dev->class_dev.kobj, &ccwgdev->dev.kobj,
+			      ccwgdev->dev.bus_id)) {
+		sysfs_remove_link(&ccwgdev->dev.kobj, dev->name);
+		unregister_netdev(dev);
+		goto out;
+	}
 	netif_stop_queue(dev);
 	lcs_stopcard(card);
 	return 0;
@@ -1814,13 +1872,20 @@
 lcs_shutdown_device(struct ccwgroup_device *ccwgdev)
 {
 	struct lcs_card *card;
+	int ret;
 
 	LCS_DBF_TEXT(3, setup, "shtdndev");
 	card = (struct lcs_card *)ccwgdev->dev.driver_data;
 	if (!card)
 		return -ENODEV;
 
-	return lcs_stop_device(card->dev);
+	ret = lcs_stop_device(card->dev);
+	if (ret)
+		return ret;
+	sysfs_remove_link(&card->dev->class_dev.kobj, ccwgdev->dev.bus_id);
+	sysfs_remove_link(&ccwgdev->dev.kobj, card->dev->name);
+	unregister_netdev(card->dev);
+	return 0;
 }
 
 /**
diff -urN linux-2.6/drivers/s390/net/lcs.h linux-2.6-s390/drivers/s390/net/lcs.h
--- linux-2.6/drivers/s390/net/lcs.h	Mon Sep  8 21:50:18 2003
+++ linux-2.6-s390/drivers/s390/net/lcs.h	Thu Sep 25 18:33:32 2003
@@ -6,7 +6,7 @@
 #include <linux/workqueue.h>
 #include <asm/ccwdev.h>
 
-#define VERSION_LCS_H "$Revision: 1.12 $"
+#define VERSION_LCS_H "$Revision: 1.13 $"
 
 #define LCS_DBF_TEXT(level, name, text) \
 	do { \
@@ -83,6 +83,7 @@
 #define LCS_NUM_BUFFS			8	/* needs to be power of 2 */
 #define LCS_MAC_LENGTH			6
 #define LCS_INVALID_PORT_NO		-1
+#define LCS_LANCMD_TIMEOUT_DEFAULT      5
 
 /**
  * Multicast state
@@ -263,6 +264,7 @@
 	struct lcs_buffer *tx_buffer;
 	int tx_emitted;
 	struct list_head lancmd_waiters;
+	int lancmd_timeout;
 
 	struct work_struct kernel_thread_starter;
 	unsigned long thread_mask;
