Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWEBRif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWEBRif (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWEBRif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:38:35 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:34243 "EHLO
	localhost") by vger.kernel.org with ESMTP id S964949AbWEBRie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:38:34 -0400
Message-ID: <445798F6.3050102@free.fr>
Date: Tue, 02 May 2006 19:37:58 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <pan.2006.04.29.21.00.09.180837@free.fr> <200604301050.22984.ak@suse.de>
In-Reply-To: <200604301050.22984.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------090704040006000202000309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090704040006000202000309
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Andi Kleen wrote:
> On Saturday 29 April 2006 23:00, Matthieu CASTET wrote:
> 
>>Hi,
>>
>>Le Sat, 29 Apr 2006 20:30:10 +0200, Mikael Pettersson a écrit :
>>
>>
>>
>>>Is there a better way to do this? ACPI?
>>>
>>
>>Yes, I believe using PNP layer (that use ACPI with pnpacpi) with PNP0800
>>will be cleaner.
> 
> 
> Please do a patch then.
> 
Is something like that is acceptable ?

Matthieu

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------090704040006000202000309
Content-Type: text/plain;
 name="pcspkr_pnp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcspkr_pnp.diff"

--- linux.old/drivers/input/misc/pcspkr.c	2006-04-30 18:16:09.000000000 +0200
+++ linux/drivers/input/misc/pcspkr.c	2006-05-02 19:35:09.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
+#include <linux/pnp.h>
 #include <asm/8253pit.h>
 #include <asm/io.h>
 
@@ -26,6 +27,7 @@
 
 static struct platform_device *pcspkr_platform_device;
 static DEFINE_SPINLOCK(i8253_beep_lock);
+static int pnp_registered;
 
 static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -64,7 +66,7 @@
 	return 0;
 }
 
-static int __devinit pcspkr_probe(struct platform_device *dev)
+static int __devinit pcspkr_probe(struct device *dev, struct input_dev **pcspkr_dev_pointer)
 {
 	struct input_dev *pcspkr_dev;
 	int err;
@@ -79,7 +81,7 @@
 	pcspkr_dev->id.vendor = 0x001f;
 	pcspkr_dev->id.product = 0x0001;
 	pcspkr_dev->id.version = 0x0100;
-	pcspkr_dev->cdev.dev = &dev->dev;
+	pcspkr_dev->cdev.dev = dev;
 
 	pcspkr_dev->evbit[0] = BIT(EV_SND);
 	pcspkr_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
@@ -90,32 +92,48 @@
 		input_free_device(pcspkr_dev);
 		return err;
 	}
+	*pcspkr_dev_pointer = pcspkr_dev;
 
-	platform_set_drvdata(dev, pcspkr_dev);
+	return 0;
+}
+
+static int __devexit pcspkr_remove(struct input_dev *pcspkr_dev)
+{
+	input_unregister_device(pcspkr_dev);
+	/* turn off the speaker */
+	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
 
 	return 0;
 }
 
-static int __devexit pcspkr_remove(struct platform_device *dev)
+static int __devinit pcspkr_probe_platform(struct platform_device *dev)
+{
+	struct input_dev *pcspkr_dev;
+	int err;
+	err = pcspkr_probe(&dev->dev, &pcspkr_dev);
+	if (err == 0)
+		platform_set_drvdata(dev, pcspkr_dev);
+	return err;
+}
+
+static int __devexit pcspkr_remove_platform(struct platform_device *dev)
 {
 	struct input_dev *pcspkr_dev = platform_get_drvdata(dev);
 
-	input_unregister_device(pcspkr_dev);
+	pcspkr_remove(pcspkr_dev);
 	platform_set_drvdata(dev, NULL);
-	/* turn off the speaker */
-	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
 
 	return 0;
 }
 
-static int pcspkr_suspend(struct platform_device *dev, pm_message_t state)
+static int pcspkr_suspend_platform(struct platform_device *dev, pm_message_t state)
 {
 	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
 
 	return 0;
 }
 
-static void pcspkr_shutdown(struct platform_device *dev)
+static void pcspkr_shutdown_platform(struct platform_device *dev)
 {
 	/* turn off the speaker */
 	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
@@ -126,17 +144,80 @@
 		.name	= "pcspkr",
 		.owner	= THIS_MODULE,
 	},
-	.probe		= pcspkr_probe,
-	.remove		= __devexit_p(pcspkr_remove),
-	.suspend	= pcspkr_suspend,
-	.shutdown	= pcspkr_shutdown,
+	.probe		= pcspkr_probe_platform,
+	.remove		= __devexit_p(pcspkr_remove_platform),
+	.suspend	= pcspkr_suspend_platform,
+	.shutdown	= pcspkr_shutdown_platform,
+};
+
+#ifdef CONFIG_PNP
+static struct pnp_device_id pcspkr_pnpids[] = {
+	{ .id = "PNP0800" },
+	{ .id = "" }
+};
+
+MODULE_DEVICE_TABLE(pnp, pcspkr_pnpids);
+
+static int __devinit pcspkr_pnp_probe(struct pnp_dev *pnp_dev,
+					  const struct pnp_device_id *id)
+{
+	struct input_dev *pcspkr_dev;
+	int err;
+	err = pcspkr_probe(&pnp_dev->dev, &pcspkr_dev);
+	if (err == 0) {
+		pnp_set_drvdata(pnp_dev, pcspkr_dev);
+		pnp_registered++;
+	}
+	return err;
+}
+
+static void __devexit pcspkr_pnp_remove(struct pnp_dev *dev)
+{
+	struct input_dev *pcspkr_dev = (struct input_dev *)pnp_get_drvdata(dev);
+
+	pcspkr_remove(pcspkr_dev);
+	pnp_set_drvdata(dev, NULL);
+
+	return;
+}
+
+#ifdef CONFIG_PM
+static int pcspkr_suspend_pnp(struct pnp_dev *pdev, pm_message_t state)
+{
+	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
+
+	return 0;
+}
+#endif
+
+static struct pnp_driver pcspkr_pnp_driver = {
+	.name = "pcspkr",
+	.id_table = pcspkr_pnpids,
+	.probe = pcspkr_pnp_probe,
+	.remove = __devexit_p(pcspkr_pnp_remove),
+#ifdef CONFIG_PM
+	.suspend = pcspkr_suspend_pnp,
+#endif
 };
+#else
+static struct pnp_driver pcspkr_pnp_driver;
+#endif
 
 
 static int __init pcspkr_init(void)
 {
 	int err;
 
+	err = pnp_register_driver(&pcspkr_pnp_driver);
+	if (err < 0)
+		pnp_registered = 0;
+	if (err == 0 && pnp_registered == 0)
+		pnp_unregister_driver(&pcspkr_pnp_driver);
+
+	if (pnp_registered)
+		return 0;
+
+	/* Try platform driver if pnp failed or found nothing */
 	err = platform_driver_register(&pcspkr_platform_driver);
 	if (err)
 		return err;
@@ -163,6 +244,10 @@
 
 static void __exit pcspkr_exit(void)
 {
+	if (pnp_registered) {
+		pnp_unregister_driver(&pcspkr_pnp_driver);
+		return;
+	}
 	platform_device_unregister(pcspkr_platform_device);
 	platform_driver_unregister(&pcspkr_platform_driver);
 }

--------------090704040006000202000309--
