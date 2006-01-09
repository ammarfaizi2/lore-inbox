Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWAIWPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWAIWPN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWAIWPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:15:13 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:12213 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751512AbWAIWPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:15:11 -0500
Message-ID: <43C2E0A2.3090701@indt.org.br>
Date: Mon, 09 Jan 2006 18:16:02 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: linux@arm.linux.org.uk, ext David Brownell <david-b@PACBELL.NET>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 3/5] Add MMC password protection (lock/unlock) support V3
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000702010702000302050503"
X-OriginalArrivalTime: 09 Jan 2006 22:14:22.0975 (UTC) FILETIME=[0B77B8F0:01C6156A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000702010702000302050503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit





--------------000702010702000302050503
Content-Type: text/x-patch;
 name="mmc_key_retention.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_key_retention.diff"

Implement key retention operations. mmc_key_instantiate() is used for unlocking
and password assignment (from no-password state). mmc_key_update() is used for
password change.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-2.6.15-rc4/drivers/mmc/Kconfig
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/Kconfig	2006-01-09 09:21:44.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/Kconfig	2006-01-09 09:40:57.000000000 -0400
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
Index: linux-2.6.15-rc4/drivers/mmc/mmc.h
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/mmc.h	2006-01-09 09:21:44.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/mmc.h	2006-01-09 09:40:57.000000000 -0400
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
Index: linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/mmc_sysfs.c	2006-01-09 09:40:57.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c	2006-01-09 10:28:59.000000000 -0400
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
@@ -20,6 +23,9 @@
 
 #include "mmc.h"
 
+#define KEY_OP_INSTANTIATE 1
+#define KEY_OP_UPDATE 2
+
 #define dev_to_mmc_card(d)	container_of(d, struct mmc_card, dev)
 #define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
@@ -267,6 +273,142 @@ static struct class mmc_host_class = {
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
+static int manage_key(struct key *key, const void *data, size_t datalen, int operation)
+{
+	struct mmc_key_payload *mpayload, *zap;
+	struct device *dev;
+	struct mmc_card *card;
+	int ret;
+
+	zap = NULL;
+	ret = -EINVAL;
+	if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data)
+		goto error;
+
+	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
+               ret = key_payload_reserve(key, datalen);
+               if (ret < 0)
+                       goto error;
+	}
+
+	ret = -ENOMEM;
+	mpayload = kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
+	if (!mpayload)
+		goto error;
+
+	mpayload->datalen = datalen;
+	memcpy(mpayload->data, data, datalen);
+
+	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */	
+		rcu_assign_pointer(key->payload.data, mpayload);
+	}
+	else { /* KEY_OP_UPDATE */
+               /* check the quota and attach the new data */
+               zap = mpayload;
+
+               ret = key_payload_reserve(key, datalen);
+
+               if (ret == 0) {
+                       /* attach the new data, displacing the old */
+                       zap = key->payload.data;
+                       rcu_assign_pointer(key->payload.data, mpayload);
+                       key->expiry = 0;
+               }
+	}
+	
+	ret = -EINVAL;
+	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
+	if (!dev)
+		goto error;
+	card = dev_to_mmc_card(dev);
+	
+	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
+               if (mmc_card_locked(card)) {
+                       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_UNLOCK);
+                       mmc_remove_card(card);
+                       mmc_register_card(card);
+               }
+	       else
+		       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
+	}
+	else { /* KEY_OP_UPDATE */
+               if (!mmc_card_locked(card))
+                       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
+       }
+       
+       if (ret)
+	       ret = -EKEYREJECTED;
+
+       if (operation == KEY_OP_UPDATE) /* KEY_OP_UPDATE */
+	       call_rcu(&zap->rcu, mmc_key_update_rcu_disposal);
+
+error:
+	return ret;
+}
+
+int mmc_key_instantiate(struct key *key, const void *data, size_t datalen)
+{
+       return manage_key(key, data, datalen, KEY_OP_INSTANTIATE);
+}
+
+/*
+ * update a mmc key
+ * - the key's semaphore is write-locked
+ */
+int mmc_key_update(struct key *key, const void *data, size_t datalen)
+{
+       return manage_key(key, data, datalen, KEY_OP_UPDATE);
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
@@ -337,6 +479,15 @@ static int __init mmc_init(void)
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
@@ -345,6 +496,9 @@ static void __exit mmc_exit(void)
 {
 	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
+#ifdef	CONFIG_MMC_PASSWORDS
+	unregister_key_type(&mmc_key_type);
+#endif
 }
 
 module_init(mmc_init);

--------------000702010702000302050503--
