Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937054AbWLDUJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937054AbWLDUJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937351AbWLDUJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:09:00 -0500
Received: from smtp.nokia.com ([131.228.20.173]:56643 "EHLO
	mgw-ext14.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966602AbWLDUI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:08:59 -0500
Message-ID: <45748122.9030509@indt.org.br>
Date: Mon, 04 Dec 2006 16:12:18 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: [PATCH 2/4] Add MMC Password Protection (lock/unlock) support V8:
 mmc_key_retention.diff
Content-Type: multipart/mixed;
 boundary="------------020406020903060408080408"
X-OriginalArrivalTime: 04 Dec 2006 20:08:03.0293 (UTC) FILETIME=[E787C8D0:01C717DF]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020406020903060408080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------020406020903060408080408
Content-Type: text/plain;
 name="mmc_key_retention.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_key_retention.diff"

Implement key retention operations.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-linus-2.6/drivers/mmc/Kconfig
===================================================================
--- linux-linus-2.6.orig/drivers/mmc/Kconfig	2006-12-04 14:57:42.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/Kconfig	2006-12-04 15:26:05.000000000 -0400
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
 	depends on MMC && BLOCK
Index: linux-linus-2.6/drivers/mmc/mmc.h
===================================================================
--- linux-linus-2.6.orig/drivers/mmc/mmc.h	2006-11-22 10:44:30.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/mmc.h	2006-12-04 15:34:07.000000000 -0400
@@ -19,6 +19,14 @@ int mmc_add_host_sysfs(struct mmc_host *
 void mmc_remove_host_sysfs(struct mmc_host *host);
 void mmc_free_host_sysfs(struct mmc_host *host);
 
+/* core-internal data */
+extern struct key_type mmc_key_type;
+struct mmc_key_payload {
+	struct rcu_head	rcu;		/* RCU destructor */
+	unsigned short	datalen;	/* length of this data */
+	char		data[0];	/* actual data */
+};
+
 int mmc_schedule_work(struct work_struct *work);
 int mmc_schedule_delayed_work(struct work_struct *work, unsigned long delay);
 void mmc_flush_scheduled_work(void);
Index: linux-linus-2.6/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-linus-2.6.orig/drivers/mmc/mmc_sysfs.c	2006-12-04 15:16:57.000000000 -0400
+++ linux-linus-2.6/drivers/mmc/mmc_sysfs.c	2006-12-04 15:34:03.000000000 -0400
@@ -2,6 +2,8 @@
  *  linux/drivers/mmc/mmc_sysfs.c
  *
  *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *  MMC password protection (C) 2006 Instituto Nokia de Tecnologia (INdT),
+ *     All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/workqueue.h>
+#include <linux/key.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -266,6 +269,71 @@ static struct class mmc_host_class = {
 static DEFINE_IDR(mmc_host_idr);
 static DEFINE_SPINLOCK(mmc_host_lock);
 
+#ifdef  CONFIG_MMC_PASSWORDS
+
+#define MMC_KEYLEN_MAXBYTES 32
+
+static int mmc_key_instantiate(struct key *key, const void *data, size_t datalen)
+{
+	struct mmc_key_payload *mpayload, *zap;
+	int ret;
+
+	zap = NULL;
+	ret = -EINVAL;
+	if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data) {
+		pr_debug("Invalid data\n");
+		goto error;
+	}
+
+	ret = key_payload_reserve(key, datalen);
+	if (ret < 0) {
+		pr_debug("ret = %d\n", ret);
+		goto error;
+	}
+
+	ret = -ENOMEM;
+	mpayload = kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
+	if (!mpayload) {
+		pr_debug("Unable to allocate mpayload structure\n");
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
+static int mmc_key_match(const struct key *key, const void *description)
+{
+	return strcmp(key->description, description) == 0;
+}
+
+/*
+ * dispose of the data dangling from the corpse of a mmc key
+ */
+static void mmc_key_destroy(struct key *key)
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
@@ -363,16 +431,31 @@ static int __init mmc_init(void)
 		return -ENOMEM;
 
 	ret = bus_register(&mmc_bus_type);
-	if (ret == 0) {
-		ret = class_register(&mmc_host_class);
-		if (ret)
-			bus_unregister(&mmc_bus_type);
+	if (ret)
+		goto error_bus;
+	ret = class_register(&mmc_host_class);
+	if (ret)
+		goto error_class;
+#ifdef	CONFIG_MMC_PASSWORDS
+	ret = register_key_type(&mmc_key_type);
+	if (ret) {
+		class_unregister(&mmc_host_class);
+		goto error_class;
 	}
+#endif
+	return 0;
+
+error_class:
+	bus_unregister(&mmc_bus_type);
+error_bus:
 	return ret;
 }
 
 static void __exit mmc_exit(void)
 {
+#ifdef	CONFIG_MMC_PASSWORDS
+	unregister_key_type(&mmc_key_type);
+#endif
 	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
 	destroy_workqueue(workqueue);

--------------020406020903060408080408--
