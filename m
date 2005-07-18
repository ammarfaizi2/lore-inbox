Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVGRRqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVGRRqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 13:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVGRRqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 13:46:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22029 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261293AbVGRRqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 13:46:01 -0400
Date: Mon, 18 Jul 2005 18:45:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC host class
Message-ID: <20050718184554.A31022@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <42D538D4.7050803@drzeus.cx> <20050715093114.B25428@flint.arm.linux.org.uk> <42D81AD7.3000407@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42D81AD7.3000407@drzeus.cx>; from drzeus-list@drzeus.cx on Fri, Jul 15, 2005 at 10:21:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 15, 2005 at 10:21:43PM +0200, Pierre Ossman wrote:
> Russell King wrote:
> >Also note that since we have a class_dev, the mmc_host 'dev' field can
> >be removed.  However, we'll probably have to update the host drivers
> >to do this, so it should be a separate patch.
> 
> I believe there's a bit of abstraction to be gained from not poking
> around inside the class_dev struct in too many places. It's not like
> we're wasting any large amounts of memory.

I still don't like the needless duplication.  How about doing it this
way (see the attached patch.)

Note: I also intend to move MMC over to using an IDR for the host
numbers, which is why we need to setup the name at registration
time, not allocation time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01-mmc_hostname.diff"

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git orig/drivers/mmc/mmc.c linux/drivers/mmc/mmc.c
--- orig/drivers/mmc/mmc.c	Sun Apr 24 21:02:15 2005
+++ linux/drivers/mmc/mmc.c	Mon Jul 18 15:24:52 2005
@@ -361,7 +361,7 @@ static void mmc_decode_cid(struct mmc_ca
 
 	default:
 		printk("%s: card has unknown MMCA version %d\n",
-			card->host->host_name, card->csd.mmca_vsn);
+			mmc_hostname(card->host), card->csd.mmca_vsn);
 		mmc_card_set_bad(card);
 		break;
 	}
@@ -383,7 +383,7 @@ static void mmc_decode_csd(struct mmc_ca
 	csd_struct = UNSTUFF_BITS(resp, 126, 2);
 	if (csd_struct != 1 && csd_struct != 2) {
 		printk("%s: unrecognised CSD structure version %d\n",
-			card->host->host_name, csd_struct);
+			mmc_hostname(card->host), csd_struct);
 		mmc_card_set_bad(card);
 		return;
 	}
@@ -551,7 +551,7 @@ static void mmc_discover_cards(struct mm
 		}
 		if (err != MMC_ERR_NONE) {
 			printk(KERN_ERR "%s: error requesting CID: %d\n",
-				host->host_name, err);
+				mmc_hostname(host), err);
 			break;
 		}
 
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git orig/drivers/mmc/mmc_sysfs.c linux/drivers/mmc/mmc_sysfs.c
--- orig/drivers/mmc/mmc_sysfs.c	Tue Jun 21 07:04:35 2005
+++ linux/drivers/mmc/mmc_sysfs.c	Mon Jul 18 15:25:07 2005
@@ -206,7 +206,7 @@ void mmc_init_card(struct mmc_card *card
 int mmc_register_card(struct mmc_card *card)
 {
 	snprintf(card->dev.bus_id, sizeof(card->dev.bus_id),
-		 "%s:%04x", card->host->host_name, card->rca);
+		 "%s:%04x", mmc_hostname(card->host), card->rca);
 
 	return device_add(&card->dev);
 }
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git orig/drivers/mmc/mmci.c linux/drivers/mmc/mmci.c
--- orig/drivers/mmc/mmci.c	Sat Jul  2 22:27:45 2005
+++ linux/drivers/mmc/mmci.c	Mon Jul 18 15:25:32 2005
@@ -34,7 +34,7 @@
 
 #ifdef CONFIG_MMC_DEBUG
 #define DBG(host,fmt,args...)	\
-	pr_debug("%s: %s: " fmt, host->mmc->host_name, __func__ , args)
+	pr_debug("%s: %s: " fmt, mmc_hostname(host->mmc), __func__ , args)
 #else
 #define DBG(host,fmt,args...)	do { } while (0)
 #endif
@@ -541,7 +541,7 @@ static int mmci_probe(struct amba_device
 	mmc_add_host(mmc);
 
 	printk(KERN_INFO "%s: MMCI rev %x cfg %02x at 0x%08lx irq %d,%d\n",
-		mmc->host_name, amba_rev(dev), amba_config(dev),
+		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
 		dev->res.start, dev->irq[0], dev->irq[1]);
 
 	init_timer(&host->timer);
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git orig/drivers/mmc/wbsd.c linux/drivers/mmc/wbsd.c
--- orig/drivers/mmc/wbsd.c	Sat Jul  2 22:27:45 2005
+++ linux/drivers/mmc/wbsd.c	Mon Jul 18 15:25:48 2005
@@ -1796,7 +1796,7 @@ static int __devinit wbsd_init(struct de
 	
 	mmc_add_host(mmc);
 
-	printk(KERN_INFO "%s: W83L51xD", mmc->host_name);
+	printk(KERN_INFO "%s: W83L51xD", mmc_hostname(mmc));
 	if (host->chip_id != 0)
 		printk(" id %x", (int)host->chip_id);
 	printk(" at 0x%x irq %d", (int)host->base, (int)host->irq);
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git orig/include/linux/mmc/host.h linux/include/linux/mmc/host.h
--- orig/include/linux/mmc/host.h	Sun Apr 24 21:06:29 2005
+++ linux/include/linux/mmc/host.h	Mon Jul 18 15:26:55 2005
@@ -97,6 +97,7 @@ extern void mmc_free_host(struct mmc_hos
 
 #define mmc_priv(x)	((void *)((x) + 1))
 #define mmc_dev(x)	((x)->dev)
+#define mmc_hostname(x)	((x)->host_name)
 
 extern int mmc_suspend_host(struct mmc_host *, pm_message_t);
 extern int mmc_resume_host(struct mmc_host *);

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02-classdev.diff"

diff -u linux/drivers/mmc/mmc.c linux/drivers/mmc/mmc.c
--- linux/drivers/mmc/mmc.c	Mon Jul 18 15:24:52 2005
+++ linux/drivers/mmc/mmc.c	Mon Jul 18 15:51:37 2005
@@ -828,15 +828,15 @@
  */
 int mmc_add_host(struct mmc_host *host)
 {
-	static unsigned int host_num;
+	int ret;
 
-	snprintf(host->host_name, sizeof(host->host_name),
-		 "mmc%d", host_num++);
-
-	mmc_power_off(host);
-	mmc_detect_change(host);
+	ret = mmc_register_host_sysfs(host);
+	if (ret == 0) {
+		mmc_power_off(host);
+		mmc_detect_change(host);
+	}
 
-	return 0;
+	return ret;
 }
 
 EXPORT_SYMBOL(mmc_add_host);
@@ -859,6 +859,8 @@
 	}
 
 	mmc_power_off(host);
+
+	mmc_unregister_host_sysfs(host);
 }
 
 EXPORT_SYMBOL(mmc_remove_host);
@@ -872,7 +874,7 @@
 void mmc_free_host(struct mmc_host *host)
 {
 	flush_scheduled_work();
-	kfree(host);
+	mmc_free_host_sysfs(host);
 }
 
 EXPORT_SYMBOL(mmc_free_host);
diff -u linux/drivers/mmc/mmc_sysfs.c linux/drivers/mmc/mmc_sysfs.c
--- linux/drivers/mmc/mmc_sysfs.c	Mon Jul 18 15:25:07 2005
+++ linux/drivers/mmc/mmc_sysfs.c	Mon Jul 18 16:33:46 2005
@@ -20,6 +20,7 @@
 
 #define dev_to_mmc_card(d)	container_of(d, struct mmc_card, dev)
 #define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
+#define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
 #define MMC_ATTR(name, fmt, args...)					\
 static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *attr, char *buf)	\
@@ -224,13 +225,64 @@
 }
 
 
+static void mmc_host_classdev_release(struct class_device *dev)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	kfree(host);
+}
+
+static struct class mmc_host_class = {
+	.name		= "mmc_host",
+	.release	= mmc_host_classdev_release,
+};
+
+/*
+ * Internal function. Register a new MMC host with the MMC class.
+ */
+int mmc_register_host_sysfs(struct mmc_host *host)
+{
+	static unsigned int host_num;
+
+	snprintf(host->host_name, sizeof(host->host_name),
+		 "mmc%d", host_num++);
+
+	host->class_dev.dev = host->dev;
+	host->class_dev.class = &mmc_host_class;
+	strlcpy(host->class_dev.class_id, host->host_name, BUS_ID_SIZE);
+	return class_device_register(&host->class_dev);
+}
+
+/*
+ * Internal function. Unregister a MMC host with the MMC class.
+ */
+void mmc_unregister_host_sysfs(struct mmc_host *host)
+{
+	class_device_del(&host->class_dev);
+}
+
+/*
+ * Internal function. Free a MMC host.
+ */
+void mmc_free_host_sysfs(struct mmc_host *host)
+{
+	class_device_put(&host->class_dev);
+}
+
+
 static int __init mmc_init(void)
 {
-	return bus_register(&mmc_bus_type);
+	int ret = bus_register(&mmc_bus_type);
+	if (ret == 0) {
+		ret = class_register(&mmc_host_class);
+		if (ret)
+			bus_unregister(&mmc_bus_type);
+	}
+	return ret;
 }
 
 static void __exit mmc_exit(void)
 {
+	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
 }
 
diff -u linux/include/linux/mmc/host.h linux/include/linux/mmc/host.h
--- linux/include/linux/mmc/host.h	Mon Jul 18 15:26:55 2005
+++ linux/include/linux/mmc/host.h	Mon Jul 18 15:44:56 2005
@@ -63,6 +63,7 @@
 
 struct mmc_host {
 	struct device		*dev;
+	struct class_device	class_dev;
 	struct mmc_host_ops	*ops;
 	unsigned int		f_min;
 	unsigned int		f_max;
only in patch2:
--- orig/drivers/mmc/mmc.h	Sun Apr 24 21:02:15 2005
+++ linux/drivers/mmc/mmc.h	Mon Jul 18 18:25:31 2005
@@ -13,4 +13,8 @@
 void mmc_init_card(struct mmc_card *card, struct mmc_host *host);
 int mmc_register_card(struct mmc_card *card);
 void mmc_remove_card(struct mmc_card *card);
+
+int mmc_register_host_sysfs(struct mmc_host *host);
+void mmc_unregister_host_sysfs(struct mmc_host *host);
+void mmc_free_host_sysfs(struct mmc_host *host);
 #endif

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="03-classdev_hostname.diff"

diff -u linux/drivers/mmc/mmc_sysfs.c linux/drivers/mmc/mmc_sysfs.c
--- linux/drivers/mmc/mmc_sysfs.c	Mon Jul 18 16:33:46 2005
+++ linux/drivers/mmc/mmc_sysfs.c	Mon Jul 18 18:27:04 2005
@@ -243,12 +243,11 @@
 {
 	static unsigned int host_num;
 
-	snprintf(host->host_name, sizeof(host->host_name),
-		 "mmc%d", host_num++);
-
 	host->class_dev.dev = host->dev;
 	host->class_dev.class = &mmc_host_class;
-	strlcpy(host->class_dev.class_id, host->host_name, BUS_ID_SIZE);
+	snprintf(host->class_dev.class_id, BUS_ID_SIZE,
+		 "mmc%d", host_num++);
+
 	return class_device_register(&host->class_dev);
 }
 
diff -u linux/include/linux/mmc/host.h linux/include/linux/mmc/host.h
--- linux/include/linux/mmc/host.h	Mon Jul 18 15:44:56 2005
+++ linux/include/linux/mmc/host.h	Mon Jul 18 18:28:51 2005
@@ -68,7 +68,6 @@
 	unsigned int		f_min;
 	unsigned int		f_max;
 	u32			ocr_avail;
-	char			host_name[8];
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
@@ -98,7 +97,7 @@
 
 #define mmc_priv(x)	((void *)((x) + 1))
 #define mmc_dev(x)	((x)->dev)
-#define mmc_hostname(x)	((x)->host_name)
+#define mmc_hostname(x)	((x)->class_dev.class_id)
 
 extern int mmc_suspend_host(struct mmc_host *, pm_message_t);
 extern int mmc_resume_host(struct mmc_host *);

--nFreZHaLTZJo0R7j--
