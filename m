Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWANV1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWANV1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWANV1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:27:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:6548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751299AbWANV1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:27:02 -0500
Cc: david-b@pacbell.net
Subject: [PATCH] spi: ads7836 uses spi_driver
In-Reply-To: <1137199592832@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 16:46:32 -0800
Message-Id: <11371995921674@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] spi: ads7836 uses spi_driver

This updates the ads7864 driver to use the new "spi_driver" struct, and
includes some minor unrelated cleanup.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2e5a7bd978bf4118a0c8edf2e6ff81d0a72fee47
tree ee5b09d090c7a4a6cbf19ddf9f252d315b46eda1
parent 0c868461fcb8413cb9f691d68e5b99b0fd3c0737
author David Brownell <david-b@pacbell.net> Sun, 08 Jan 2006 13:34:25 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 16:29:55 -0800

 drivers/input/touchscreen/ads7846.c |   84 ++++++++++++++++++-----------------
 include/linux/spi/ads7846.h         |    2 -
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 24ff6c5..c741776 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -345,19 +345,15 @@ static irqreturn_t ads7846_irq(int irq, 
 
 /*--------------------------------------------------------------------------*/
 
-/* non-empty "extra" is needed before 2.6.14-git5 or so */
-#define	EXTRA	//	, u32 level
-#define	EXTRA2	//	, 0
-
 static int
-ads7846_suspend(struct device *dev, pm_message_t message EXTRA)
+ads7846_suspend(struct spi_device *spi, pm_message_t message)
 {
-	struct ads7846 *ts = dev_get_drvdata(dev);
+	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
 	unsigned long	flags;
 
 	spin_lock_irqsave(&ts->lock, flags);
 
-	ts->spi->dev.power.power_state = message;
+	spi->dev.power.power_state = message;
 
 	/* are we waiting for IRQ, or polling? */
 	if (!ts->pendown) {
@@ -387,36 +383,35 @@ ads7846_suspend(struct device *dev, pm_m
 	return 0;
 }
 
-static int ads7846_resume(struct device *dev EXTRA)
+static int ads7846_resume(struct spi_device *spi)
 {
-	struct ads7846 *ts = dev_get_drvdata(dev);
+	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
 
 	ts->irq_disabled = 0;
 	enable_irq(ts->spi->irq);
-	dev->power.power_state = PMSG_ON;
+	spi->dev.power.power_state = PMSG_ON;
 	return 0;
 }
 
-static int __init ads7846_probe(struct device *dev)
+static int __devinit ads7846_probe(struct spi_device *spi)
 {
-	struct spi_device		*spi = to_spi_device(dev);
 	struct ads7846			*ts;
-	struct ads7846_platform_data	*pdata = dev->platform_data;
+	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_transfer		*x;
 
 	if (!spi->irq) {
-		dev_dbg(dev, "no IRQ?\n");
+		dev_dbg(&spi->dev, "no IRQ?\n");
 		return -ENODEV;
 	}
 
 	if (!pdata) {
-		dev_dbg(dev, "no platform data?\n");
+		dev_dbg(&spi->dev, "no platform data?\n");
 		return -ENODEV;
 	}
 
 	/* don't exceed max specified sample rate */
 	if (spi->max_speed_hz > (125000 * 16)) {
-		dev_dbg(dev, "f(sample) %d KHz?\n",
+		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",
 				(spi->max_speed_hz/16)/1000);
 		return -EINVAL;
 	}
@@ -430,7 +425,7 @@ static int __init ads7846_probe(struct d
 	if (!(ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL)))
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, ts);
+	dev_set_drvdata(&spi->dev, ts);
 
 	ts->spi = spi;
 	spi->dev.power.power_state = PMSG_ON;
@@ -445,9 +440,9 @@ static int __init ads7846_probe(struct d
 
 	init_input_dev(&ts->input);
 
-	ts->input.dev = dev;
+	ts->input.dev = &spi->dev;
 	ts->input.name = "ADS784x Touchscreen";
-	snprintf(ts->phys, sizeof ts->phys, "%s/input0", dev->bus_id);
+	snprintf(ts->phys, sizeof ts->phys, "%s/input0", spi->dev.bus_id);
 	ts->input.phys = ts->phys;
 
 	ts->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
@@ -511,65 +506,68 @@ static int __init ads7846_probe(struct d
 	ts->msg.context = ts;
 
 	if (request_irq(spi->irq, ads7846_irq, SA_SAMPLE_RANDOM,
-				dev->bus_id, ts)) {
-		dev_dbg(dev, "irq %d busy?\n", spi->irq);
+				spi->dev.bus_id, ts)) {
+		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		input_unregister_device(&ts->input);
 		kfree(ts);
 		return -EBUSY;
 	}
 	set_irq_type(spi->irq, IRQT_FALLING);
 
-	dev_info(dev, "touchscreen, irq %d\n", spi->irq);
+	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
 
 	/* take a first sample, leaving nPENIRQ active; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
-	(void) ads7846_read12_ser(dev,
+	(void) ads7846_read12_ser(&spi->dev,
 			  READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
 
 	/* ads7843/7845 don't have temperature sensors, and
 	 * use the other sensors a bit differently too
 	 */
 	if (ts->model == 7846) {
-		device_create_file(dev, &dev_attr_temp0);
-		device_create_file(dev, &dev_attr_temp1);
+		device_create_file(&spi->dev, &dev_attr_temp0);
+		device_create_file(&spi->dev, &dev_attr_temp1);
 	}
 	if (ts->model != 7845)
-		device_create_file(dev, &dev_attr_vbatt);
-	device_create_file(dev, &dev_attr_vaux);
+		device_create_file(&spi->dev, &dev_attr_vbatt);
+	device_create_file(&spi->dev, &dev_attr_vaux);
 
 	return 0;
 }
 
-static int __exit ads7846_remove(struct device *dev)
+static int __devexit ads7846_remove(struct spi_device *spi)
 {
-	struct ads7846		*ts = dev_get_drvdata(dev);
+	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
 
-	ads7846_suspend(dev, PMSG_SUSPEND EXTRA2);
+	ads7846_suspend(spi, PMSG_SUSPEND);
 	free_irq(ts->spi->irq, ts);
 	if (ts->irq_disabled)
 		enable_irq(ts->spi->irq);
 
 	if (ts->model == 7846) {
-		device_remove_file(dev, &dev_attr_temp0);
-		device_remove_file(dev, &dev_attr_temp1);
+		device_remove_file(&spi->dev, &dev_attr_temp0);
+		device_remove_file(&spi->dev, &dev_attr_temp1);
 	}
 	if (ts->model != 7845)
-		device_remove_file(dev, &dev_attr_vbatt);
-	device_remove_file(dev, &dev_attr_vaux);
+		device_remove_file(&spi->dev, &dev_attr_vbatt);
+	device_remove_file(&spi->dev, &dev_attr_vaux);
 
 	input_unregister_device(&ts->input);
 	kfree(ts);
 
-	dev_dbg(dev, "unregistered touchscreen\n");
+	dev_dbg(&spi->dev, "unregistered touchscreen\n");
 	return 0;
 }
 
-static struct device_driver ads7846_driver = {
-	.name		= "ads7846",
-	.bus		= &spi_bus_type,
+static struct spi_driver ads7846_driver = {
+	.driver = {
+		.name	= "ads7846",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
 	.probe		= ads7846_probe,
-	.remove		= __exit_p(ads7846_remove),
+	.remove		= __devexit_p(ads7846_remove),
 	.suspend	= ads7846_suspend,
 	.resume		= ads7846_resume,
 };
@@ -594,18 +592,20 @@ static int __init ads7846_init(void)
 	// PXA:
 	// also Dell Axim X50
 	// also HP iPaq H191x/H192x/H415x/H435x
-	// also Intel Lubbock (alternate to UCB1400)
+	// also Intel Lubbock (additional to UCB1400; as temperature sensor)
 	// also Sharp Zaurus C7xx, C8xx (corgi/sheperd/husky)
 
+	// Atmel at91sam9261-EK uses ads7843
+
 	// also various AMD Au1x00 devel boards
 
-	return driver_register(&ads7846_driver);
+	return spi_register_driver(&ads7846_driver);
 }
 module_init(ads7846_init);
 
 static void __exit ads7846_exit(void)
 {
-	driver_unregister(&ads7846_driver);
+	spi_unregister_driver(&ads7846_driver);
 
 #ifdef	CONFIG_ARCH_OMAP
 	if (machine_is_omap_osk()) {
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 84a2701..72261e0 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -1,7 +1,7 @@
 /* linux/spi/ads7846.h */
 
 /* Touchscreen characteristics vary between boards and models.  The
- * platform_data for the device's "struct device" holts this information.
+ * platform_data for the device's "struct device" holds this information.
  *
  * It's OK if the min/max values are zero.
  */

