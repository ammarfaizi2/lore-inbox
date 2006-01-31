Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWAaUpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWAaUpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWAaUpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:45:46 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:36516 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP
	id S1751470AbWAaUpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:45:45 -0500
Message-Id: <20060131202543.501914000@localhost.localdomain>
References: <20060131201636.264543000@localhost.localdomain>
Date: Tue, 31 Jan 2006 16:16:39 -0400
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
Subject: [patch 3/6] Add MMC password protection (lock/unlock) support V4
Content-Disposition: inline; filename=mmc_key_retention.diff
X-OriginalArrivalTime: 31 Jan 2006 20:25:47.0849 (UTC) FILETIME=[853CE390:01C626A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement key retention operations.

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/Kconfig
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/Kconfig	2006-01-31 15:17:45.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/Kconfig	2006-01-31 15:22:25.000000000 -0400
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
Index: linux-omap-2.6.git/drivers/mmc/mmc.h
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.h	2006-01-31 15:17:45.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.h	2006-01-31 15:22:25.000000000 -0400
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
Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-01-31 15:22:07.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-01-31 15:22:25.000000000 -0400
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
@@ -265,6 +268,71 @@ static struct class mmc_host_class = {
 static DEFINE_IDR(mmc_host_idr);
 static DEFINE_SPINLOCK(mmc_host_lock);
 
+#ifdef  CONFIG_MMC_PASSWORDS
+
+#define MMC_KEYLEN_MAXBYTES 32
+
+int mmc_key_instantiate(struct key *key, const void *data, size_t datalen)
+{
+	struct mmc_key_payload *mpayload, *zap;
+	int ret;
+
+	zap = NULL;
+	ret = -EINVAL;
+	if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data) {
+		DBG("Invalid data\n");
+		goto error;
+	}
+
+	ret = key_payload_reserve(key, datalen);
+	if (ret < 0) {
+		DBG("ret = %d\n", ret);
+		goto error;
+	}
+
+	ret = -ENOMEM;
+	mpayload = kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
+	if (!mpayload) {
+		DBG("Unable to allocate mpayload structure\n");
+		goto error;
+	}
+	mpayload->datalen = datalen;
+	memcpy(mpayload->data, data, datalen);
+
+	rcu_assign_pointer(key->payload.data, mpayload);
+
+	/* ret = 0 if there is no error */
+	ret = 0;
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
+	.match		= mmc_key_match,
+	.destroy	= mmc_key_destroy,
+};
+
+#endif
+
 /*
  * Internal function. Allocate a new MMC host.
  */
@@ -335,6 +403,15 @@ static int __init mmc_init(void)
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
@@ -343,6 +420,9 @@ static void __exit mmc_exit(void)
 {
 	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
+#ifdef	CONFIG_MMC_PASSWORDS
+	unregister_key_type(&mmc_key_type);
+#endif
 }
 
 module_init(mmc_init);

--
