Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162413AbWKQNd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162413AbWKQNd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162420AbWKQNd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:33:58 -0500
Received: from mgw-ext12.nokia.com ([131.228.20.171]:51077 "EHLO
	mgw-ext12.nokia.com") by vger.kernel.org with ESMTP
	id S1162413AbWKQNd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:33:57 -0500
Message-ID: <455DB547.5060407@indt.org.br>
Date: Fri, 17 Nov 2006 09:12:39 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: [patch 5/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Content-Type: multipart/mixed;
 boundary="------------080709060301000906000607"
X-OriginalArrivalTime: 17 Nov 2006 13:08:52.0172 (UTC) FILETIME=[874588C0:01C70A49]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709060301000906000607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Implement MMC password force erase, remove password, change password,
unlock card and assign password operations. It uses the sysfs mechanism
to send commands to the MMC subsystem.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-16 15:45:20.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-16 15:54:44.000000000 -0400
@@ -17,6 +17,7 @@
  #include <linux/idr.h>
  #include <linux/workqueue.h>
  #include <linux/key.h>
+#include <linux/err.h>

  #include <linux/mmc/card.h>
  #include <linux/mmc/host.h>
@@ -65,6 +66,114 @@ static struct device_attribute mmc_dev_a

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
+	/* Lock to protect the mmc_lock_unlock data */
+	spinlock_t mmc_lock = SPIN_LOCK_UNLOCKED;
+
+	if (!mmc_card_lockable(card))
+		return -EINVAL;
+
+	if (mmc_card_locked(card) && !strncmp(data, "erase", 5)) {
+		/* forced erase only works while card is locked */
+		spin_lock(&mmc_lock);
+		mmc_lock_unlock(card, NULL, MMC_LOCK_MODE_ERASE);
+		spin_unlock(&mmc_lock);
+		return len;
+	} else if (!mmc_card_locked(card) && !strncmp(data, "remove", 6)) {
+		/* remove password only works while card is unlocked */
+		struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "remove");
+
+		if (!IS_ERR(mmc_key)) {
+			int err = 0;
+
+			spin_lock(&mmc_lock);
+			err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_CLR_PWD);
+			spin_unlock(&mmc_lock);
+			if (!err)
+				return len;
+		} else
+			dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	} else if (!mmc_card_locked(card) && !strncmp(data, "change", 6)) {
+			/* change */
+			struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "change");
+
+			if (!IS_ERR(mmc_key)) {
+				int err = 0;
+				
+				spin_lock(&mmc_lock);
+				err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_SET_PWD);
+				spin_unlock(&mmc_lock);
+				if (!err)
+					return len;
+			} else
+				dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	} else if (mmc_card_locked(card) && !strncmp(data, "unlock", 6)) {
+			/* unlock */
+			struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "unlock");
+
+			if (!IS_ERR(mmc_key)) {
+				int err = 0;
+				
+				spin_lock(&mmc_lock);
+				mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_UNLOCK);
+				spin_unlock(&mmc_lock);
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
+			int err = 0;
+			
+			spin_lock(&mmc_lock);
+			err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_SET_PWD);
+			spin_unlock(&mmc_lock);
+			if (!err)
+				return len;
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
@@ -234,6 +343,11 @@ int mmc_register_card(struct mmc_card *c
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
@@ -248,6 +362,9 @@ void mmc_remove_card(struct mmc_card *ca
  		if (mmc_card_sd(card))
  			device_remove_file(&card->dev, &mmc_dev_attr_scr);

+#ifdef CONFIG_MMC_PASSWORDS
+		device_remove_file(&card->dev, &mmc_dev_attr_lockable);
+#endif
  		device_del(&card->dev);
  	}



--------------080709060301000906000607
Content-Type: text/x-patch;
 name="mmc_sysfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_sysfs.diff"

Implement MMC password force erase, remove password, change password,
unlock card and assign password operations. It uses the sysfs mechanism
to send commands to the MMC subsystem. 

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-16 15:45:20.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-16 15:54:44.000000000 -0400
@@ -17,6 +17,7 @@
 #include <linux/idr.h>
 #include <linux/workqueue.h>
 #include <linux/key.h>
+#include <linux/err.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -65,6 +66,114 @@ static struct device_attribute mmc_dev_a
 
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
+	/* Lock to protect the mmc_lock_unlock data */
+	spinlock_t mmc_lock = SPIN_LOCK_UNLOCKED;
+
+	if (!mmc_card_lockable(card))
+		return -EINVAL;
+
+	if (mmc_card_locked(card) && !strncmp(data, "erase", 5)) {
+		/* forced erase only works while card is locked */
+		spin_lock(&mmc_lock);
+		mmc_lock_unlock(card, NULL, MMC_LOCK_MODE_ERASE);
+		spin_unlock(&mmc_lock);
+		return len;
+	} else if (!mmc_card_locked(card) && !strncmp(data, "remove", 6)) {
+		/* remove password only works while card is unlocked */
+		struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "remove");
+
+		if (!IS_ERR(mmc_key)) {
+			int err = 0;
+
+			spin_lock(&mmc_lock);
+			err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_CLR_PWD);
+			spin_unlock(&mmc_lock);
+			if (!err)
+				return len;
+		} else
+			dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	} else if (!mmc_card_locked(card) && !strncmp(data, "change", 6)) {
+			/* change */
+			struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "change");
+
+			if (!IS_ERR(mmc_key)) {
+				int err = 0;
+				
+				spin_lock(&mmc_lock);
+				err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_SET_PWD);
+				spin_unlock(&mmc_lock);
+				if (!err)
+					return len;
+			} else
+				dev_dbg(&card->dev, "request_key returned error %ld\n", PTR_ERR(mmc_key));
+	} else if (mmc_card_locked(card) && !strncmp(data, "unlock", 6)) {
+			/* unlock */
+			struct key *mmc_key = request_key(&mmc_key_type, "mmc:key", "unlock");
+
+			if (!IS_ERR(mmc_key)) {
+				int err = 0;
+				
+				spin_lock(&mmc_lock);
+				mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_UNLOCK);
+				spin_unlock(&mmc_lock);
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
+			int err = 0;
+			
+			spin_lock(&mmc_lock);
+			err = mmc_lock_unlock(card, mmc_key, MMC_LOCK_MODE_SET_PWD);
+			spin_unlock(&mmc_lock);
+			if (!err)
+				return len;
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
@@ -234,6 +343,11 @@ int mmc_register_card(struct mmc_card *c
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
@@ -248,6 +362,9 @@ void mmc_remove_card(struct mmc_card *ca
 		if (mmc_card_sd(card))
 			device_remove_file(&card->dev, &mmc_dev_attr_scr);
 
+#ifdef CONFIG_MMC_PASSWORDS
+		device_remove_file(&card->dev, &mmc_dev_attr_lockable);
+#endif
 		device_del(&card->dev);
 	}
 

--------------080709060301000906000607--
