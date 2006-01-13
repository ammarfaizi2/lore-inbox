Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422941AbWAMUCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422941AbWAMUCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWAMTu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:50:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:37780 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422869AbWAMTu1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:27 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add bttv sub bus_type probe and remove methods
In-Reply-To: <11371818121359@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:12 -0800
Message-Id: <11371818122256@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add bttv sub bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 348290a4ae143a692124330942b464ccdb0d0365
tree 1fae9909d4d4519c9548b5940be2dca7e31935c2
parent d78967fb035aeb839a047ae69ce5f1ff39288a8d
author Russell King <rmk@arm.linux.org.uk> Fri, 06 Jan 2006 11:42:03 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:11 -0800

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |   23 +++++++++++------------
 drivers/media/video/bttv-gpio.c     |   24 ++++++++++++++++++++++--
 drivers/media/video/bttv.h          |    2 ++
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index f65f64b..44fcbe7 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -779,9 +779,8 @@ static int __init dvb_bt8xx_load_card(st
 	return 0;
 }
 
-static int dvb_bt8xx_probe(struct device *dev)
+static int dvb_bt8xx_probe(struct bttv_sub_device *sub)
 {
-	struct bttv_sub_device *sub = to_bttv_sub_dev(dev);
 	struct dvb_bt8xx_card *card;
 	struct pci_dev* bttv_pci_dev;
 	int ret;
@@ -890,13 +889,13 @@ static int dvb_bt8xx_probe(struct device
 		return ret;
 	}
 
-	dev_set_drvdata(dev, card);
+	dev_set_drvdata(&sub->dev, card);
 	return 0;
 }
 
-static int dvb_bt8xx_remove(struct device *dev)
+static int dvb_bt8xx_remove(struct bttv_sub_device *sub)
 {
-	struct dvb_bt8xx_card *card = dev_get_drvdata(dev);
+	struct dvb_bt8xx_card *card = dev_get_drvdata(&sub->dev);
 
 	dprintk("dvb_bt8xx: unloading card%d\n", card->bttv_nr);
 
@@ -919,14 +918,14 @@ static int dvb_bt8xx_remove(struct devic
 static struct bttv_sub_driver driver = {
 	.drv = {
 		.name		= "dvb-bt8xx",
-		.probe		= dvb_bt8xx_probe,
-		.remove		= dvb_bt8xx_remove,
-		/* FIXME:
-		 * .shutdown	= dvb_bt8xx_shutdown,
-		 * .suspend	= dvb_bt8xx_suspend,
-		 * .resume	= dvb_bt8xx_resume,
-		 */
 	},
+	.probe		= dvb_bt8xx_probe,
+	.remove		= dvb_bt8xx_remove,
+	/* FIXME:
+	 * .shutdown	= dvb_bt8xx_shutdown,
+	 * .suspend	= dvb_bt8xx_suspend,
+	 * .resume	= dvb_bt8xx_resume,
+	 */
 };
 
 static int __init dvb_bt8xx_init(void)
diff --git a/drivers/media/video/bttv-gpio.c b/drivers/media/video/bttv-gpio.c
index d64accc..c4d5e2b 100644
--- a/drivers/media/video/bttv-gpio.c
+++ b/drivers/media/video/bttv-gpio.c
@@ -47,9 +47,29 @@ static int bttv_sub_bus_match(struct dev
 	return 0;
 }
 
+static int bttv_sub_probe(struct device *dev)
+{
+	struct bttv_sub_device *sdev = to_bttv_sub_dev(dev);
+	struct bttv_sub_driver *sub = to_bttv_sub_drv(dev->driver);
+
+	return sub->probe ? sub->probe(sdev) : -ENODEV;
+}
+
+static int bttv_sub_remove(struct device *dev)
+{
+	struct bttv_sub_device *sdev = to_bttv_sub_dev(dev);
+	struct bttv_sub_driver *sub = to_bttv_sub_drv(dev->driver);
+
+	if (sub->remove)
+		sub->remove(sdev);
+	return 0;
+}
+
 struct bus_type bttv_sub_bus_type = {
-	.name  = "bttv-sub",
-	.match = &bttv_sub_bus_match,
+	.name   = "bttv-sub",
+	.match  = &bttv_sub_bus_match,
+	.probe  = bttv_sub_probe,
+	.remove = bttv_sub_remove,
 };
 EXPORT_SYMBOL(bttv_sub_bus_type);
 
diff --git a/drivers/media/video/bttv.h b/drivers/media/video/bttv.h
index e370d74..9908c8e 100644
--- a/drivers/media/video/bttv.h
+++ b/drivers/media/video/bttv.h
@@ -365,6 +365,8 @@ struct bttv_sub_device {
 struct bttv_sub_driver {
 	struct device_driver   drv;
 	char                   wanted[BUS_ID_SIZE];
+	int                    (*probe)(struct bttv_sub_device *sub);
+	void                   (*remove)(struct bttv_sub_device *sub);
 	void                   (*gpio_irq)(struct bttv_sub_device *sub);
 };
 #define to_bttv_sub_drv(x) container_of((x), struct bttv_sub_driver, drv)

