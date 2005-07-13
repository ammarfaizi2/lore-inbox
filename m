Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVGMPw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVGMPw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVGMPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:52:59 -0400
Received: from [85.8.12.41] ([85.8.12.41]:56449 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262671AbVGMPww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:52:52 -0400
Message-ID: <42D538D4.7050803@drzeus.cx>
Date: Wed, 13 Jul 2005 17:52:52 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-20268-1121269971-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] MMC host class
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-20268-1121269971-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Create a mmc_host class to allow enumeration of MMC host controllers
even though they have no card(s) inserted.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

(This will also allow cards to be enumerated by being able to find the
hosts.)

--=_hermes.drzeus.cx-20268-1121269971-0001-2
Content-Type: text/x-patch; name="mmc-class.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-class.patch"

Index: linux-wbsd/drivers/mmc/mmc.h
===================================================================
--- linux-wbsd/drivers/mmc/mmc.h	(revision 134)
+++ linux-wbsd/drivers/mmc/mmc.h	(working copy)
@@ -13,4 +13,6 @@
 void mmc_init_card(struct mmc_card *card, struct mmc_host *host);
 int mmc_register_card(struct mmc_card *card);
 void mmc_remove_card(struct mmc_card *card);
+int mmc_register_host(struct mmc_host *host);
+void mmc_unregister_host(struct mmc_host *host);
 #endif
Index: linux-wbsd/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc_sysfs.c	(revision 153)
+++ linux-wbsd/drivers/mmc/mmc_sysfs.c	(working copy)
@@ -20,6 +20,7 @@
 
 #define dev_to_mmc_card(d)	container_of(d, struct mmc_card, dev)
 #define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
+#define cls_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
 #define MMC_ATTR(name, fmt, args...)					\
 static ssize_t mmc_##name##_show (struct device *dev, char *buf)	\
@@ -224,14 +225,51 @@
 	put_device(&card->dev);
 }
 
+static void mmc_host_class_dev_release(struct class_device *dev)
+{
+}
+
+static struct class mmc_host_class = {
+	.name =		"mmc_host",
+	.release =	&mmc_host_class_dev_release,
+};
+
+/*
+ * Internal function. Register a new MMC host with the MMC class.
+ */
+int mmc_register_host(struct mmc_host *host)
+{
+	host->class_dev.dev = host->dev;
+	host->class_dev.class = &mmc_host_class;
+	strlcpy(host->class_dev.class_id, host->host_name, BUS_ID_SIZE);
+
+	return class_device_register(&host->class_dev);
+}
+
+/*
+ * Internal function. Unregister a MMC host with the MMC class.
+ */
+void mmc_unregister_host(struct mmc_host *host)
+{
+	class_device_unregister(&host->class_dev);
+}
 
 static int __init mmc_init(void)
 {
-	return bus_register(&mmc_bus_type);
+	int retval;
+	
+	retval = bus_register(&mmc_bus_type);
+	if (retval)
+		return retval;
+	retval = class_register(&mmc_host_class);
+	if (retval)
+		return retval;
+	return 0;
 }
 
 static void __exit mmc_exit(void)
 {
+	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
 }
 
Index: linux-wbsd/drivers/mmc/mmc.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc.c	(revision 153)
+++ linux-wbsd/drivers/mmc/mmc.c	(working copy)
@@ -1196,6 +1196,8 @@
 	snprintf(host->host_name, sizeof(host->host_name),
 		 "mmc%d", host_num++);
 
+	mmc_register_host(host);
+	
 	mmc_power_off(host);
 	mmc_detect_change(host);
 
@@ -1220,6 +1222,8 @@
 
 		mmc_remove_card(card);
 	}
+	
+	mmc_unregister_host(host);
 
 	mmc_power_off(host);
 }
Index: linux-wbsd/include/linux/mmc/host.h
===================================================================
--- linux-wbsd/include/linux/mmc/host.h	(revision 153)
+++ linux-wbsd/include/linux/mmc/host.h	(working copy)
@@ -69,6 +69,7 @@
 
 struct mmc_host {
 	struct device		*dev;
+	struct class_device	class_dev;
 	struct mmc_host_ops	*ops;
 	unsigned int		f_min;
 	unsigned int		f_max;

--=_hermes.drzeus.cx-20268-1121269971-0001-2--
