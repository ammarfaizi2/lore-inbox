Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVL1SzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVL1SzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVL1SzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:55:18 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:19043 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S964872AbVL1SzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:55:14 -0500
Message-Id: <20051228185412.951490000@localhost.localdomain>
References: <20051228184014.571997000@localhost.localdomain>
Date: Wed, 28 Dec 2005 14:40:18 -0400
From: Anderson Lizardo <anderson.lizardo@indt.org.br>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Subject: [patch 4/5] Add MMC password protection (lock/unlock) support V2
Content-Disposition: inline; filename=mmc_sysfs.diff
X-OriginalArrivalTime: 28 Dec 2005 18:53:52.0407 (UTC) FILETIME=[0BBBBA70:01C60BE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement MMC password reset and forced erase support. It uses the sysfs
mechanism to send commands to the MMC subsystem. Usage:

Forced erase:

echo erase > /sys/bus/mmc/devices/mmc0\:0001/lockable

Remove password:

echo remove > /sys/bus/mmc/devices/mmc0\:0001/lockable

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.15-rc4-omap1/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.15-rc4-omap1.orig/drivers/mmc/mmc_sysfs.c	2005-12-15 15:47:40.000000000 -0400
+++ linux-2.6.15-rc4-omap1/drivers/mmc/mmc_sysfs.c	2005-12-15 15:47:40.000000000 -0400
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/key.h>
+#include <linux/err.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -64,6 +65,58 @@ static struct device_attribute mmc_dev_a
 
 static struct device_attribute mmc_dev_attr_scr = MMC_ATTR_RO(scr);
 
+#ifdef	CONFIG_MMC_PASSWORDS
+
+static ssize_t
+mmc_lockable_show(struct device *dev, struct device_attribute *att, char *buf)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	if (!mmc_card_lockable(card))
+		return sprintf(buf, "unlockable\n");
+	else
+		return sprintf(buf, "lockable, %slocked\n", mmc_card_locked(card) ?
+			"" : "un");
+}
+
+/*
+ * implement MMC password reset ("remove password") and forced erase ("forgot
+ * password").
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
+		struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", NULL);
+
+		if (!IS_ERR(mmc_key)) {
+			int err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_CLR_PWD);
+			if (!err)
+				return len;
+		} else
+			dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
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
@@ -235,6 +288,13 @@ int mmc_register_card(struct mmc_card *c
 			if (ret)
 				device_del(&card->dev);
 		}
+#ifdef CONFIG_MMC_PASSWORDS
+		if (mmc_card_lockable(card)) {
+			ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
+			if (ret)
+				device_del(&card->dev);
+		}
+#endif
 	}
 	return ret;
 }
@@ -248,7 +308,10 @@ void mmc_remove_card(struct mmc_card *ca
 	if (mmc_card_present(card)) {
 		if (mmc_card_sd(card))
 			device_remove_file(&card->dev, &mmc_dev_attr_scr);
-
+#ifdef CONFIG_MMC_PASSWORDS
+		if (mmc_card_lockable(card))
+			device_remove_file(&card->dev, &mmc_dev_attr_lockable);
+#endif
 		device_del(&card->dev);
 	}
 

--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
