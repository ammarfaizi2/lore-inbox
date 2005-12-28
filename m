Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVL1Syv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVL1Syv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVL1Syv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:54:51 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:8802 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S964872AbVL1Syu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:54:50 -0500
Message-Id: <20051228185412.736374000@localhost.localdomain>
References: <20051228184014.571997000@localhost.localdomain>
Date: Wed, 28 Dec 2005 14:40:17 -0400
From: Anderson Lizardo <anderson.lizardo@indt.org.br>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Subject: [patch 3/5] Add MMC password protection (lock/unlock) support V2
Content-Disposition: inline; filename=mmc_key_retention.diff
X-OriginalArrivalTime: 28 Dec 2005 18:53:52.0235 (UTC) FILETIME=[0BA17BB0:01C60BE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement key retention operations. mmc_key_instantiate() is used for unlocking
and password assignment (from no-password state). mmc_key_update() is used for
password change.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.15-rc4-omap1/drivers/mmc/Kconfig
===================================================================
--- linux-2.6.15-rc4-omap1.orig/drivers/mmc/Kconfig	2005-12-27 17:19:47.000000000 -0400
+++ linux-2.6.15-rc4-omap1/drivers/mmc/Kconfig	2005-12-27 17:20:18.000000000 -0400
@@ -19,6 +19,19 @@ config MMC_DEBUG
 	  This is an option for use by developers; most people should
 	  say N here.  This enables MMC core and driver debugging.
 
+config MMC_PASSWORDS
+	boolean "MMC card lock/unlock passwords (EXPERIMENTAL)"
+	depends on MMC && EXPERIMENTAL
+	select KEYS
+	help
+	  Say Y here to enable the use of passwords to lock and unlock
+	  MMC cards.  This uses the access key retention support, using
+	  request_key to look up the key associated with each card.
+
+	  For example, if you have an MMC card that was locked using
+	  Symbian OS on your cell phone, you won't be able to read it
+	  on Linux without this support.
+
 config MMC_BLOCK
 	tristate "MMC block device driver"
 	depends on MMC
Index: linux-2.6.15-rc4-omap1/drivers/mmc/mmc.h
===================================================================
--- linux-2.6.15-rc4-omap1.orig/drivers/mmc/mmc.h	2005-12-27 17:19:47.000000000 -0400
+++ linux-2.6.15-rc4-omap1/drivers/mmc/mmc.h	2005-12-27 17:20:18.000000000 -0400
@@ -18,4 +18,12 @@ struct mmc_host *mmc_alloc_host_sysfs(in
 int mmc_add_host_sysfs(struct mmc_host *host);
 void mmc_remove_host_sysfs(struct mmc_host *host);
 void mmc_free_host_sysfs(struct mmc_host *host);
+
+/* core-internal data */
+extern struct key_type mmc_key_type;
+struct mmc_key_payload {
+	struct rcu_head	rcu;		/* RCU destructor */
+	unsigned short	datalen;	/* length of this data */
+	char		data[0];	/* actual data */
+};
 #endif
Index: linux-2.6.15-rc4-omap1/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.15-rc4-omap1.orig/drivers/mmc/mmc_sysfs.c	2005-12-27 17:19:47.000000000 -0400
+++ linux-2.6.15-rc4-omap1/drivers/mmc/mmc_sysfs.c	2005-12-27 17:21:35.000000000 -0400
@@ -2,6 +2,8 @@
  *  linux/drivers/mmc/mmc_sysfs.c
  *
  *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *  MMC password protection (C) 2005 Instituto Nokia de Tecnologia (INdT),
+ *     All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/key.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -267,6 +270,150 @@ static struct class mmc_host_class = {
 static DEFINE_IDR(mmc_host_idr);
 static DEFINE_SPINLOCK(mmc_host_lock);
 
+#ifdef  CONFIG_MMC_PASSWORDS
+
+#define MMC_KEYLEN_MAXBYTES 32
+
+static int mmc_match_lockable(struct device *dev, void *data)
+{
+        struct mmc_card *card = dev_to_mmc_card(dev);
+
+        return mmc_card_lockable(card);
+}
+
+int mmc_key_instantiate(struct key *key, const void *data, size_t datalen)
+{
+	struct mmc_key_payload *mpayload;
+	struct device *dev;
+	struct mmc_card *card;
+	int ret;
+
+	ret = -EINVAL;
+	if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data)
+		goto error;
+
+	ret = key_payload_reserve(key, datalen);
+	if (ret < 0)
+		goto error;
+
+	ret = -ENOMEM;
+	mpayload = kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
+	if (!mpayload)
+		goto error;
+
+	/* attach the data */
+	mpayload->datalen = datalen;
+	memcpy(mpayload->data, data, datalen);
+	rcu_assign_pointer(key->payload.data, mpayload);
+
+	ret = -EINVAL;
+	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
+	if (!dev)
+		goto error;
+	card = dev_to_mmc_card(dev);
+	if (mmc_card_locked(card)) {
+		ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_UNLOCK);
+		mmc_remove_card(card);
+		mmc_register_card(card);
+	} else
+		ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
+	if (ret)
+		ret = -EKEYREJECTED;
+
+error:
+	return ret;
+}
+
+/*
+ * dispose of the old data from an updated mmc key
+ */
+static void mmc_key_update_rcu_disposal(struct rcu_head *rcu)
+{
+	struct mmc_key_key_payload *mpayload;
+
+	mpayload = (struct mmc_key_key_payload *)container_of(rcu, struct mmc_key_payload, rcu);
+
+	kfree(mpayload);
+}
+
+/*
+ * update a mmc key
+ * - the key's semaphore is write-locked
+ */
+int mmc_key_update(struct key *key, const void *data, size_t datalen)
+{
+	struct mmc_key_payload *mpayload, *zap;
+	struct device *dev;
+	struct mmc_card *card;
+	int ret;
+
+	ret = -EINVAL;
+	if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data)
+		goto error;
+
+	/* construct a replacement payload */
+	ret = -ENOMEM;
+	mpayload = kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
+	if (!mpayload)
+		goto error;
+
+	mpayload->datalen = datalen;
+	memcpy(mpayload->data, data, datalen);
+
+	/* check the quota and attach the new data */
+	zap = mpayload;
+
+	ret = key_payload_reserve(key, datalen);
+
+	if (ret == 0) {
+		/* attach the new data, displacing the old */
+		zap = key->payload.data;
+		rcu_assign_pointer(key->payload.data, mpayload);
+		key->expiry = 0;
+	}
+
+	ret = -EINVAL;
+	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
+	if (!dev)
+		goto error;
+	card = dev_to_mmc_card(dev);
+	if (!mmc_card_locked(card))
+		ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
+	if (ret)
+		ret = -EKEYREJECTED;
+
+	call_rcu(&zap->rcu, mmc_key_update_rcu_disposal);
+
+error:
+	return ret;
+}
+
+int mmc_key_match(const struct key *key, const void *description)
+{
+	return strcmp(key->description, description) == 0;
+}
+
+/*
+ * dispose of the data dangling from the corpse of a mmc key
+ */
+void mmc_key_destroy(struct key *key)
+{
+	struct mmc_key_payload *mpayload = key->payload.data;
+
+	kfree(mpayload);
+}
+
+struct key_type mmc_key_type = {
+	.name		= "mmc",
+	.def_datalen	= MMC_KEYLEN_MAXBYTES,
+	.instantiate	= mmc_key_instantiate,
+	.update		= mmc_key_update,
+	.match		= mmc_key_match,
+	.destroy	= mmc_key_destroy,
+};
+
+#endif
+
 /*
  * Internal function. Allocate a new MMC host.
  */
@@ -337,6 +484,15 @@ static int __init mmc_init(void)
 		ret = class_register(&mmc_host_class);
 		if (ret)
 			bus_unregister(&mmc_bus_type);
+#ifdef	CONFIG_MMC_PASSWORDS
+		else {
+			ret = register_key_type(&mmc_key_type);
+			if (ret) {
+				class_unregister(&mmc_host_class);
+				bus_unregister(&mmc_bus_type);
+			}
+		}
+#endif
 	}
 	return ret;
 }
@@ -345,6 +501,9 @@ static void __exit mmc_exit(void)
 {
 	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
+#ifdef	CONFIG_MMC_PASSWORDS
+	unregister_key_type(&mmc_key_type);
+#endif
 }
 
 module_init(mmc_init);

--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
