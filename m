Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWCZWHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWCZWHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCZWHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:07:51 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:7339 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932098AbWCZWHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:07:50 -0500
Message-ID: <442710A1.5030207@keyaccess.nl>
Date: Mon, 27 Mar 2006 00:07:29 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA] AdLib FM card driver
Content-Type: multipart/mixed;
 boundary="------------040607040700010304040602"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040607040700010304040602
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi

Adrian: this was one of the cards you listed as having an OSS but not an 
ALSA driver a while ago.

Attached you'll find an ALSA driver for AdLib FM cards. An AdLib card is 
just an OPL2, which was already supported by sound/drivers/opl3, so only 
very minimal bus-glue is needed. The patch applies cleanly to both 
2.6.16 and 2.6.16-mm1.

The driver has been tested with an actual ancient 8-bit ISA AdLib card 
and works fine. It also works fine for an OPL3 {,emulation} as still 
found on many ISA soundcards but given that AdLib cards don't have their 
own mixer, upping the volume from 0 might be a problem without the card 
driver already loaded and driving the OPL3.

As far as I am concerned, this does not need additional testing and can 
go to alsa-kernel after a review. It's very unlikely that anyone still 
has this ancient card installed anyway. The one I have here was lent to 
me and will be returned shortly, but given the minimal nature of this 
driver, maintenance should not be a problem.

I also stuck a very tiny HOWTO in ALSA-Configuration.txt, assuming quite 
a few people would have no idea how to operate the thing, even if they 
do happen across a card. Is it okay there?

Takashi: As the card->shortname, I use "AdLib FM", which includes a 
space. sound/core/init.c:choose_default_id() goes to lengths to not 
allow this (it turns it into "FM") but when I manually give:

   modprobe snd-adlib id="AdLib FM" port=0x388

then the ID is used as is and everything seems fine. I assume that 
either the space check could go or that a passed in ID should be 
subjected to it as well? (that function also deletes all !isalnum's from 
the shortname such as <underscore> which, again, is fine when passed in 
manually).

Comments appreciated. I'll go listen to this AdLib render "Master of 
Puppets" again now. Heavens, what fun...

Rene.




--------------040607040700010304040602
Content-Type: text/plain;
 name="adlib.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adlib.diff"

Index: local/sound/isa/adlib.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ local/sound/isa/adlib.c	2006-03-26 21:38:02.000000000 +0200
@@ -0,0 +1,154 @@
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
+	int i = device->id;
+
+	if (port[i] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
+		return -EINVAL;
+	}
+
+	card = snd_card_new(index[i], id[i], THIS_MODULE, 0);
+	if (!card) {
+		snd_printk(KERN_ERR DRV_NAME ": could not create card\n");
+		return -EINVAL;
+	}
+
+	card->private_data = request_region(port[i], 4, CRD_NAME);
+	if (!card->private_data) {
+		snd_printk(KERN_ERR DRV_NAME ": could not grab ports\n");
+		snd_card_free(card);
+		return -EINVAL;
+	}
+	card->private_free = snd_adlib_free;
+
+	if (snd_opl3_create(card, port[i], port[i] + 2, OPL3_HW_AUTO, 1, &opl3) < 0) {
+		snd_printk(KERN_ERR DRV_NAME ": could not create OPL\n");
+		snd_card_free(card);
+		return -EINVAL;
+	}
+
+	if (snd_opl3_hwdep_new(opl3, 0, 0, NULL) < 0) {
+		snd_printk(KERN_ERR DRV_NAME ": could not create FM\n");
+		snd_card_free(card);
+		return -EINVAL;
+	}
+
+	strcpy(card->driver, DRV_NAME);
+	strcpy(card->shortname, CRD_NAME);
+	sprintf(card->longname, CRD_NAME " at %#lx", port[i]);
+
+	snd_card_set_dev(card, &device->dev);
+
+	if (snd_card_register(card) < 0) {
+		snd_printk(KERN_ERR DRV_NAME ": could not register card\n");
+		snd_card_free(card);
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(device, card);
+	return 0;
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
 

--------------040607040700010304040602--
