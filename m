Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWAaUvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWAaUvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWAaUvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:51:46 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:4010 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751304AbWAaUvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:51:45 -0500
Message-Id: <20060131202545.380492000@localhost.localdomain>
References: <20060131201636.264543000@localhost.localdomain>
Date: Tue, 31 Jan 2006 16:16:40 -0400
From: Carlos Aguiar <carlos.aguiar@indt.org.br>
To: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
Cc: linux@arm.linux.org.uk, David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 4/6] Add MMC password protection (lock/unlock) support V4
Content-Disposition: inline; filename=mmc_sysfs.diff
X-OriginalArrivalTime: 31 Jan 2006 20:25:49.0786 (UTC) FILETIME=[866473A0:01C626A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement MMC password force erase, remove password, change password,
unlock card and assign password operations. It uses the sysfs mechanism
to send commands to the MMC subsystem. 

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-01-31 15:22:25.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-01-31 15:22:29.000000000 -0400
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/key.h>
+#include <linux/err.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -23,6 +24,12 @@
 
 #include "mmc.h"
 
+#ifdef CONFIG_MMC_DEBUG
+#define DBG(x...)	printk(KERN_DEBUG x)
+#else
+#define DBG(x...)	do { } while (0)
+#endif
+
 #define dev_to_mmc_card(d)	container_of(d, struct mmc_card, dev)
 #define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
@@ -64,6 +71,101 @@ static struct device_attribute mmc_dev_a
 
 static struct device_attribute mmc_dev_attr_scr = MMC_ATTR_RO(scr);
 
+#ifdef	CONFIG_MMC_PASSWORDS
+
+static ssize_t
+mmc_lockable_show(struct device *dev, struct device_attribute *att, char *buf)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	if (!mmc_card_lockable(card))
+		return sprintf(buf, "unsupported\n");
+	else
+		return sprintf(buf, "%slocked\n", mmc_card_locked(card) ?
+			"" : "un");
+}
+
+/*
+ * implement MMC password functions: force erase, remove password, change
+ * password, unlock card and assign password.
+ */
+static ssize_t
+mmc_lockable_store(struct device *dev, struct device_attribute *att,
+	const char *data, size_t len)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	if (!mmc_card_lockable(card))
+		return -EINVAL;
+
+	if (mmc_card_locked(card) && !strncmp(data, "erase", 5)) {
+		/* forced erase only works while card is locked */
+		mmc_lock_unlock(card, NULL, MMC_LOCK_MODE_ERASE);
+		return len;
+	} else if (!mmc_card_locked(card) && !strncmp(data, "remove", 6)) {
+		/* remove password only works while card is unlocked */
+		struct key *mmc_key = request_key(&mmc_key_type, "mmc:key",
+				"remove");
+
+		if (!IS_ERR(mmc_key)) {
+			int err = mmc_lock_unlock(card, mmc_key,
+					MMC_LOCK_MODE_CLR_PWD);
+			if (!err)
+				return len;
+		} else
+			DBG("request_key returned error %ld\n",
+					PTR_ERR(mmc_key));
+	} else if (!mmc_card_locked(card) && !strncmp(data, "change", 6)) {
+			/* change */
+			struct key *mmc_key = request_key(&mmc_key_type,
+					"mmc:key", "change");
+			if (!IS_ERR(mmc_key)) {
+				int err = mmc_lock_unlock(card, mmc_key,
+						MMC_LOCK_MODE_SET_PWD);
+				if (!err)
+					return len;
+			} else
+				DBG("request_key returned error %ld\n",
+						PTR_ERR(mmc_key));
+	} else if (mmc_card_locked(card) && !strncmp(data, "unlock", 6)) {
+			/* unlock */
+			struct key *mmc_key = request_key(&mmc_key_type,
+					"mmc:key", "unlock");
+			if (!IS_ERR(mmc_key)) {
+				int err = mmc_lock_unlock(card, mmc_key,
+						MMC_LOCK_MODE_UNLOCK);
+				if (err)
+					DBG("Wrong password\n");
+				device_release_driver(dev);
+				device_attach(dev);
+				if (!err)
+					return len;
+			} else
+				DBG("request_key returned error %ld\n",
+						PTR_ERR(mmc_key));
+	} else if (!mmc_card_locked(card) && !strncmp(data, "assign", 6)) {
+			/* assign */
+			struct key *mmc_key = request_key(&mmc_key_type,
+					"mmc:key", "assign");
+			if (!IS_ERR(mmc_key)) {
+			int err = mmc_lock_unlock(card, mmc_key,
+					MMC_LOCK_MODE_SET_PWD);
+			if (!err)
+				return len;
+			} else
+				DBG("request_key returned error %ld\n",
+						PTR_ERR(mmc_key));
+	}
+
+	return -EINVAL;
+}
+
+static struct device_attribute mmc_dev_attr_lockable =
+	__ATTR(lockable, S_IWUSR | S_IRUGO,
+		 mmc_lockable_show, mmc_lockable_store);
+
+#endif
+
 
 static void mmc_release_card(struct device *dev)
 {
@@ -233,6 +335,11 @@ int mmc_register_card(struct mmc_card *c
 			if (ret)
 				device_del(&card->dev);
 		}
+#ifdef CONFIG_MMC_PASSWORDS
+		ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
+		if (ret)
+			device_del(&card->dev);
+#endif
 	}
 	return ret;
 }
@@ -246,7 +353,9 @@ void mmc_remove_card(struct mmc_card *ca
 	if (mmc_card_present(card)) {
 		if (mmc_card_sd(card))
 			device_remove_file(&card->dev, &mmc_dev_attr_scr);
-
+#ifdef CONFIG_MMC_PASSWORDS
+		device_remove_file(&card->dev, &mmc_dev_attr_lockable);
+#endif
 		device_del(&card->dev);
 	}
 

--
