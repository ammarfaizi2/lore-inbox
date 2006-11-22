Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756305AbWKVSWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbWKVSWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbWKVSWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:22:43 -0500
Received: from mgw-ext12.nokia.com ([131.228.20.171]:30285 "EHLO
	mgw-ext12.nokia.com") by vger.kernel.org with ESMTP
	id S1756298AbWKVSWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:22:42 -0500
Message-ID: <45646457.1060203@indt.org.br>
Date: Wed, 22 Nov 2006 10:53:11 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Pierre Ossman <drzeus-list@drzeus.cx>, Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: [patch 4/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_sysfs.diff
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2006 14:49:20.0021 (UTC) FILETIME=[64370C50:01C70E45]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement MMC password force erase, remove password, change password,
unlock card and assign password operations. It uses the sysfs mechanism
to send commands to the MMC subsystem.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-22 09:07:23.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-22 09:18:58.000000000 -0400
@@ -17,6 +17,7 @@
  #include <linux/idr.h>
  #include <linux/workqueue.h>
  #include <linux/key.h>
+#include <linux/err.h>

  #include <linux/mmc/card.h>
  #include <linux/mmc/host.h>
@@ -65,6 +66,94 @@ static struct device_attribute mmc_dev_a

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
+		struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "remove");
+
+		if (!IS_ERR(mmc_key)) {
+			int err =  mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_CLR_PWD);
+			if (!err)
+				return len;
+		} else
+			dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	} else if (!mmc_card_locked(card) && !strncmp(data, "change", 6)) {
+			/* change */
+			struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "change");
+
+			if (!IS_ERR(mmc_key)) {
+				int err =  mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_SET_PWD);
+				if (!err)
+					return len;
+			} else
+				dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	} else if (mmc_card_locked(card) && !strncmp(data, "unlock", 6)) {
+			/* unlock */
+			struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "unlock");
+
+			if (!IS_ERR(mmc_key)) {
+				int err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_UNLOCK);
+				if (err) {
+					dev_dbg(&card->dev, "Wrong password\n");
+				}
+				else {
+					device_release_driver(dev);
+					device_attach(dev);
+					return len;
+				}
+			} else
+				dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	} else if (!mmc_card_locked(card) && !strncmp(data, "assign", 6)) {
+			/* assign */
+			struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "assign");
+
+			if (!IS_ERR(mmc_key)) {
+				int err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_SET_PWD);
+				if (!err)
+					return len;
+			} else
+				dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
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
@@ -234,6 +323,11 @@ int mmc_register_card(struct mmc_card *c
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
@@ -248,6 +342,9 @@ void mmc_remove_card(struct mmc_card *ca
  		if (mmc_card_sd(card))
  			device_remove_file(&card->dev, &mmc_dev_attr_scr);

+#ifdef CONFIG_MMC_PASSWORDS
+		device_remove_file(&card->dev, &mmc_dev_attr_lockable);
+#endif
  		device_del(&card->dev);
  	}
