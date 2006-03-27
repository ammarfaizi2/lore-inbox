Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWC0Q31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWC0Q31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWC0Q31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:29:27 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:21203 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751005AbWC0Q30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:29:26 -0500
Message-ID: <442812E4.5060803@keyaccess.nl>
Date: Mon, 27 Mar 2006 18:29:24 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ALSA] AdLib FM card driver
References: <442710A1.5030207@keyaccess.nl> <s5hmzfc3stk.wl%tiwai@suse.de> <44281194.50800@keyaccess.nl>
In-Reply-To: <44281194.50800@keyaccess.nl>
Content-Type: multipart/mixed;
 boundary="------------050602040902090108010905"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050602040902090108010905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rene Herman wrote:

> Attached is a version that simply jumps to a return -EINVAL, which
> would also be the easiest way to fixup the others, at least for
> -stable. If you disagree though, in the next message I'll sent a
> version that does register the error, but for now just turns them
> into -EINVAL before returning.

As promised. As said, I prefer the previous one. With this one, it would 
only be a matter of deleting the "error = -EINVAL;" lines again to have 
it propagate the error up after a resolution of that -ENODEV | -ENXIO 
thing, but since the value isn't used anyway...

Rene.

--------------050602040902090108010905
Content-Type: text/plain;
 name="adlib-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adlib-3.diff"

Index: local/sound/isa/adlib.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ local/sound/isa/adlib.c	2006-03-27 16:47:21.000000000 +0200
@@ -0,0 +1,163 @@
+/*
+ * AdLib FM card driver.
+ */
+
+#include <sound/driver.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/opl3.h>
+
+#define CRD_NAME "AdLib FM"
+#define DRV_NAME "snd_adlib"
+
+MODULE_DESCRIPTION(CRD_NAME);
+MODULE_AUTHOR("Rene Herman");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
+static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
+module_param_array(port, long, NULL, 0444);
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
+
+static struct platform_device *devices[SNDRV_CARDS];
+
+static void snd_adlib_free(struct snd_card *card)
+{
+	release_and_free_resource(card->private_data);
+}
+
+static int __devinit snd_adlib_probe(struct platform_device *device)
+{
+	struct snd_card *card;
+	struct snd_opl3 *opl3;
+
+	int error;
+	int i = device->id;
+
+	if (port[i] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
+		error = -EINVAL;
+		goto out0;
+	}
+
+	card = snd_card_new(index[i], id[i], THIS_MODULE, 0);
+	if (!card) {
+		snd_printk(KERN_ERR DRV_NAME ": could not create card\n");
+		error = -EINVAL;
+		goto out0;
+	}
+
+	card->private_data = request_region(port[i], 4, CRD_NAME);
+	if (!card->private_data) {
+		snd_printk(KERN_ERR DRV_NAME ": could not grab ports\n");
+		error = -EBUSY;
+		goto out1;
+	}
+	card->private_free = snd_adlib_free;
+
+	error = snd_opl3_create(card, port[i], port[i] + 2, OPL3_HW_AUTO, 1, &opl3);
+	if (error < 0) {
+		snd_printk(KERN_ERR DRV_NAME ": could not create OPL\n");
+		error = -EINVAL;
+		goto out1;
+	}
+
+	error = snd_opl3_hwdep_new(opl3, 0, 0, NULL);
+	if (error < 0) {
+		snd_printk(KERN_ERR DRV_NAME ": could not create FM\n");
+		error = -EINVAL;
+		goto out1;
+	}
+
+	strcpy(card->driver, DRV_NAME);
+	strcpy(card->shortname, CRD_NAME);
+	sprintf(card->longname, CRD_NAME " at %#lx", port[i]);
+
+	snd_card_set_dev(card, &device->dev);
+
+	error = snd_card_register(card);
+	if (error < 0) {
+		snd_printk(KERN_ERR DRV_NAME ": could not register card\n");
+		error = -EINVAL;
+		goto out1;
+	}
+
+	platform_set_drvdata(device, card);
+	return 0;
+
+out1:	snd_card_free(card);
+out0:	return error;
+}
+
+static int __devexit snd_adlib_remove(struct platform_device *device)
+{
+	snd_card_free(platform_get_drvdata(device));
+	platform_set_drvdata(device, NULL);
+	return 0;
+}
+
+static struct platform_driver snd_adlib_driver = {
+	.probe		= snd_adlib_probe,
+	.remove		= __devexit_p(snd_adlib_remove),
+
+	.driver		= {
+		.name	= DRV_NAME
+	}
+};
+
+static int __init alsa_card_adlib_init(void)
+{
+	int i, cards;
+
+	if (platform_driver_register(&snd_adlib_driver) < 0) {
+		snd_printk(KERN_ERR DRV_NAME ": could not register driver\n");
+		return -ENODEV;
+	}
+
+	for (cards = 0, i = 0; i < SNDRV_CARDS; i++) {
+		struct platform_device *device;
+
+		if (!enable[i])
+			continue;
+
+		device = platform_device_register_simple(DRV_NAME, i, NULL, 0);
+		if (IS_ERR(device))
+			continue;
+
+		devices[i] = device;
+		cards++;
+	}
+
+	if (!cards) {
+#ifdef MODULE
+		printk(KERN_ERR CRD_NAME " soundcard not found or device busy\n");
+#endif
+		platform_driver_unregister(&snd_adlib_driver);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void __exit alsa_card_adlib_exit(void)
+{
+	int i;
+
+	for (i = 0; i < SNDRV_CARDS; i++)
+		platform_device_unregister(devices[i]);
+	platform_driver_unregister(&snd_adlib_driver);
+}
+
+module_init(alsa_card_adlib_init);
+module_exit(alsa_card_adlib_exit);
Index: local/sound/isa/Kconfig
===================================================================
--- local.orig/sound/isa/Kconfig	2006-03-26 14:58:00.000000000 +0200
+++ local/sound/isa/Kconfig	2006-03-26 14:58:24.000000000 +0200
@@ -11,6 +11,15 @@ config SND_CS4231_LIB
         tristate
         select SND_PCM
 
+config SND_ADLIB
+	tristate "AdLib FM card"
+	select SND_OPL3_LIB
+	help
+	  Say Y here to include support for AdLib FM cards.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-adlib.
+
 config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
 	depends on SND && PNP && ISA
Index: local/sound/isa/Makefile
===================================================================
--- local.orig/sound/isa/Makefile	2006-03-26 14:58:00.000000000 +0200
+++ local/sound/isa/Makefile	2006-03-26 14:58:24.000000000 +0200
@@ -3,6 +3,7 @@
 # Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
+snd-adlib-objs := adlib.o
 snd-als100-objs := als100.o
 snd-azt2320-objs := azt2320.o
 snd-cmi8330-objs := cmi8330.o
@@ -13,6 +14,7 @@ snd-sgalaxy-objs := sgalaxy.o
 snd-sscape-objs := sscape.o
 
 # Toplevel Module Dependency
+obj-$(CONFIG_SND_ADLIB) += snd-adlib.o
 obj-$(CONFIG_SND_ALS100) += snd-als100.o
 obj-$(CONFIG_SND_AZT2320) += snd-azt2320.o
 obj-$(CONFIG_SND_CMI8330) += snd-cmi8330.o
Index: local/Documentation/sound/alsa/ALSA-Configuration.txt
===================================================================
--- local.orig/Documentation/sound/alsa/ALSA-Configuration.txt	2006-02-27 19:22:00.000000000 +0100
+++ local/Documentation/sound/alsa/ALSA-Configuration.txt	2006-03-26 23:14:06.000000000 +0200
@@ -120,6 +120,34 @@ Prior to version 0.9.0rc4 options had a 
     enable  	- enable card
 		- Default: enabled, for PCI and ISA PnP cards
 
+  Module snd-adlib
+  ----------------
+
+    Module for AdLib FM cards.
+
+    port	- port # for OPL chip
+
+    This module supports multiple cards. It does not support autoprobe, so
+    the port must be specified. For actual AdLib FM cards it will be 0x388.
+    Note that this card does not have PCM support and no mixer; only FM
+    synthesis.
+
+    Make sure you have "sbiload" from the alsa-tools package available and,
+    after loading the module, find out the assigned ALSA sequencer port
+    number through "sbiload -l". Example output:
+
+      Port     Client name                       Port name
+      64:0     OPL2 FM synth                     OPL2 FM Port
+
+    Load the std.sb and drums.sb patches also supplied by sbiload:
+
+      sbiload -p 64:0 std.sb drums.sb
+
+    If you use this driver to drive an OPL3, you can use std.o3 and drums.o3
+    instead. To have the card produce sound, use aplaymidi from alsa-utils:
+
+      aplaymidi -p 64:0 foo.mid
+
   Module snd-ad1816a
   ------------------
 

--------------050602040902090108010905--
