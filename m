Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbVIOG44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVIOG44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVIOG4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:56:54 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:41328 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030354AbVIOGvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:40 -0400
Message-Id: <20050915064945.251103000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:46:10 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 18/28] Input: convert sound/ppc/beep to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-sound-ppc-beep.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: convert sound/ppc/beep to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 sound/ppc/beep.c |   68 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 30 deletions(-)

Index: work/sound/ppc/beep.c
===================================================================
--- work.orig/sound/ppc/beep.c
+++ work/sound/ppc/beep.c
@@ -31,14 +31,14 @@
 #include "pmac.h"
 
 struct snd_pmac_beep {
-	int running;	/* boolean */
-	int volume;	/* mixer volume: 0-100 */
+	int running;		/* boolean */
+	int volume;		/* mixer volume: 0-100 */
 	int volume_play;	/* currently playing volume */
 	int hz;
 	int nsamples;
 	short *buf;		/* allocated wave buffer */
 	dma_addr_t addr;	/* physical address of buffer */
-	struct input_dev dev;
+	struct input_dev *dev;
 };
 
 /*
@@ -212,47 +212,55 @@ static snd_kcontrol_new_t snd_pmac_beep_
 int __init snd_pmac_attach_beep(pmac_t *chip)
 {
 	pmac_beep_t *beep;
-	int err;
-
-	beep = kmalloc(sizeof(*beep), GFP_KERNEL);
-	if (! beep)
-		return -ENOMEM;
-
-	memset(beep, 0, sizeof(*beep));
-	beep->buf = dma_alloc_coherent(&chip->pdev->dev, BEEP_BUFLEN * 4,
-					&beep->addr, GFP_KERNEL);
-
-	beep->dev.evbit[0] = BIT(EV_SND);
-	beep->dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
-	beep->dev.event = snd_pmac_beep_event;
-	beep->dev.private = chip;
+	struct input_dev *input_dev;
+	void *dmabuf;
+	int err = -ENOMEM;
+
+	beep = kzalloc(sizeof(*beep), GFP_KERNEL);
+	dmabuf = dma_alloc_coherent(&chip->pdev->dev, BEEP_BUFLEN * 4,
+				    &beep->addr, GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!beep || !dmabuf || !input_dev)
+		goto fail;
 
 	/* FIXME: set more better values */
-	beep->dev.name = "PowerMac Beep";
-	beep->dev.phys = "powermac/beep";
-	beep->dev.id.bustype = BUS_ADB;
-	beep->dev.id.vendor = 0x001f;
-	beep->dev.id.product = 0x0001;
-	beep->dev.id.version = 0x0100;
+	input_dev->name = "PowerMac Beep";
+	input_dev->phys = "powermac/beep";
+	input_dev->id.bustype = BUS_ADB;
+	input_dev->id.vendor = 0x001f;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+
+	input_dev->evbit[0] = BIT(EV_SND);
+	input_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	input_dev->event = snd_pmac_beep_event;
+	input_dev->private = chip;
+	input_dev->cdev.dev = &chip->pdev->dev;
 
+	beep->dev = input_dev;
+	beep->buf = dmabuf;
 	beep->volume = BEEP_VOLUME;
 	beep->running = 0;
-	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_pmac_beep_mixer, chip))) < 0) {
-		kfree(beep->buf);
-		kfree(beep);
-		return err;
-	}
+
+	err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_pmac_beep_mixer, chip));
+	if (err < 0)
+		goto fail;
 
 	chip->beep = beep;
-	input_register_device(&beep->dev);
+	input_register_device(beep->dev);
 
 	return 0;
+
+ fail:	input_free_device(input_dev);
+	kfree(dmabuf);
+	kfree(beep);
+	return err;
 }
 
 void snd_pmac_detach_beep(pmac_t *chip)
 {
 	if (chip->beep) {
-		input_unregister_device(&chip->beep->dev);
+		input_unregister_device(chip->beep->dev);
 		dma_free_coherent(&chip->pdev->dev, BEEP_BUFLEN * 4,
 				  chip->beep->buf, chip->beep->addr);
 		kfree(chip->beep);

