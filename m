Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVGOUVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVGOUVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVGOUVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:21:50 -0400
Received: from [85.8.12.41] ([85.8.12.41]:36996 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261206AbVGOUVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:21:46 -0400
Message-ID: <42D81AD7.3000407@drzeus.cx>
Date: Fri, 15 Jul 2005 22:21:43 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-1913-1121458905-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC host class
References: <42D538D4.7050803@drzeus.cx> <20050715093114.B25428@flint.arm.linux.org.uk>
In-Reply-To: <20050715093114.B25428@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-1913-1121458905-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Russell King wrote:

>The allocation function should initialise class_dev as much as possible.
>The registration function should add the class device with the class
>model.  The unregistration should remove the class device from the class
>model, but _not_ free it.  The free function should drop the last
>reference to the class device, which results in the remove function
>(eventually) being called.  Finally, the remove function can free the
>mmc_host.
>  
>

New patch according to above system. I've moved the naming a bit earlier
to avoid having a nameless kobj floating around.

>Also note that since we have a class_dev, the mmc_host 'dev' field can
>be removed.  However, we'll probably have to update the host drivers
>to do this, so it should be a separate patch.
>
>  
>

I believe there's a bit of abstraction to be gained from not poking
around inside the class_dev struct in too many places. It's not like
we're wasting any large amounts of memory.

Rgds
Pierre


--=_hermes.drzeus.cx-1913-1121458905-0001-2
Content-Type: text/x-patch; name="mmc-class.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-class.patch"

Index: linux-wbsd/drivers/mmc/mmc.h
===================================================================
--- linux-wbsd/drivers/mmc/mmc.h	(revision 134)
+++ linux-wbsd/drivers/mmc/mmc.h	(working copy)
@@ -13,4 +13,7 @@
 void mmc_init_card(struct mmc_card *card, struct mmc_host *host);
 int mmc_register_card(struct mmc_card *card);
 void mmc_remove_card(struct mmc_card *card);
+void mmc_init_host(struct mmc_host *host);
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
+#define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
 #define MMC_ATTR(name, fmt, args...)					\
 static ssize_t mmc_##name##_show (struct device *dev, char *buf)	\
@@ -224,14 +225,64 @@
 	put_device(&card->dev);
 }
 
+static void mmc_host_class_dev_release(struct class_device *dev)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	kfree(host);
+}
+
+static struct class mmc_host_class = {
+	.name =		"mmc_host",
+	.release =	&mmc_host_class_dev_release,
+};
+
+void mmc_init_host(struct mmc_host *host)
+{
+	static unsigned int host_num;
+
+	snprintf(host->host_name, sizeof(host->host_name),
+		 "mmc%d", host_num++);
+
+	host->class_dev.dev = host->dev;
+	host->class_dev.class = &mmc_host_class;
+	strlcpy(host->class_dev.class_id, host->host_name, BUS_ID_SIZE);
+	
+	class_device_initialize(&host->class_dev);
+	class_device_get(&host->class_dev);
+}
+
+/*
+ * Internal function. Register a new MMC host with the MMC class.
+ */
+int mmc_register_host(struct mmc_host *host)
+{
+	return class_device_add(&host->class_dev);
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
@@ -1178,6 +1178,8 @@
 		host->max_phys_segs = 1;
 		host->max_sectors = 1 << (PAGE_CACHE_SHIFT - 9);
 		host->max_seg_size = PAGE_CACHE_SIZE;
+		
+		mmc_init_host(host);
 	}
 
 	return host;
@@ -1191,10 +1193,7 @@
  */
 int mmc_add_host(struct mmc_host *host)
 {
-	static unsigned int host_num;
-
-	snprintf(host->host_name, sizeof(host->host_name),
-		 "mmc%d", host_num++);
+	mmc_register_host(host);
 
 	mmc_power_off(host);
 	mmc_detect_change(host);
@@ -1222,6 +1221,8 @@
 	}
 
 	mmc_power_off(host);
+	
+	mmc_unregister_host(host);
 }
 
 EXPORT_SYMBOL(mmc_remove_host);
@@ -1235,7 +1236,8 @@
 void mmc_free_host(struct mmc_host *host)
 {
 	flush_scheduled_work();
-	kfree(host);
+	
+	class_device_put(&host->class_dev);
 }
 
 EXPORT_SYMBOL(mmc_free_host);
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

--=_hermes.drzeus.cx-1913-1121458905-0001-2--
