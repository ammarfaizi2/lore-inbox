Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933595AbWKQNQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933595AbWKQNQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933596AbWKQNQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:16:00 -0500
Received: from mgw-ext14.nokia.com ([131.228.20.173]:34701 "EHLO
	mgw-ext14.nokia.com") by vger.kernel.org with ESMTP id S933595AbWKQNP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:15:59 -0500
Message-ID: <455DB2D2.5020502@indt.org.br>
Date: Fri, 17 Nov 2006 09:02:10 -0400
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
Subject: [patch 2/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Content-Type: multipart/mixed;
 boundary="------------030200060808070801050301"
X-OriginalArrivalTime: 17 Nov 2006 12:58:23.0297 (UTC) FILETIME=[106ED310:01C70A48]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030200060808070801050301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Implement key retention operations.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/Kconfig
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/Kconfig	2006-11-14 08:46:51.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/Kconfig	2006-11-14 09:06:43.000000000 -0400
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
Index: linux-omap-2.6.git/drivers/mmc/mmc.h
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.h	2006-11-14 08:46:51.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.h	2006-11-14 09:06:43.000000000 -0400
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
Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-14 09:06:39.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-14 09:06:43.000000000 -0400
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
@@ -366,15 +434,33 @@ static int __init mmc_init(void)
  	if (ret == 0) {
  		ret = class_register(&mmc_host_class);
  		if (ret)
-			bus_unregister(&mmc_bus_type);
+			goto error;
+	}
+#ifdef	CONFIG_MMC_PASSWORDS
+	else {
+		ret = register_key_type(&mmc_key_type);
+		if (ret)
+			goto error_mmc_pwd;
  	}
  	return ret;
+
+error_mmc_pwd:
+	class_unregister(&mmc_host_class);
+	bus_unregister(&mmc_bus_type);
+	return ret;
+#endif
+error:
+	bus_unregister(&mmc_bus_type);
+	return ret;
  }

  static void __exit mmc_exit(void)
  {
  	class_unregister(&mmc_host_class);
  	bus_unregister(&mmc_bus_type);
+#ifdef	CONFIG_MMC_PASSWORDS
+	unregister_key_type(&mmc_key_type);
+#endif
  	destroy_workqueue(workqueue);
  }

--------------030200060808070801050301
Content-Type: text/x-patch;
 name="mmc_key_retention.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_key_retention.diff"

Implement key retention operations.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/Kconfig
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/Kconfig	2006-11-14 08:46:51.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/Kconfig	2006-11-14 09:06:43.000000000 -0400
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
Index: linux-omap-2.6.git/drivers/mmc/mmc.h
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.h	2006-11-14 08:46:51.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.h	2006-11-14 09:06:43.000000000 -0400
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
Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-14 09:06:39.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-14 09:06:43.000000000 -0400
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
@@ -366,15 +434,33 @@ static int __init mmc_init(void)
 	if (ret == 0) {
 		ret = class_register(&mmc_host_class);
 		if (ret)
-			bus_unregister(&mmc_bus_type);
+			goto error;
+	}
+#ifdef	CONFIG_MMC_PASSWORDS
+	else {
+		ret = register_key_type(&mmc_key_type);
+		if (ret)
+			goto error_mmc_pwd;
 	}
 	return ret;
+
+error_mmc_pwd:
+	class_unregister(&mmc_host_class);
+	bus_unregister(&mmc_bus_type);
+	return ret;
+#endif
+error:
+	bus_unregister(&mmc_bus_type);
+	return ret;
 }
 
 static void __exit mmc_exit(void)
 {
 	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
+#ifdef	CONFIG_MMC_PASSWORDS
+	unregister_key_type(&mmc_key_type);
+#endif
 	destroy_workqueue(workqueue);
 }
 

--------------030200060808070801050301--
