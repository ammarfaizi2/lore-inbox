Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbVJ1GgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVJ1GgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbVJ1Gbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:47338 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965149AbVJ1Gb0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:26 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Input: convert sound/ppc/beep to dynamic input_dev allocation
In-Reply-To: <11304810253624@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:25 -0700
Message-Id: <11304810253703@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: convert sound/ppc/beep to dynamic input_dev allocation

Input: convert sound/ppc/beep to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5555c7bc942fff098f65b233d1a47b611a81e7bc
tree ff723bc8e6f4b9d54ac19d1b7bebd9274dc5d15c
parent 08303093569fb58889c06a5920947fafc22b66ff
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:49 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:05 -0700

 sound/ppc/beep.c |   68 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/sound/ppc/beep.c b/sound/ppc/beep.c
index 31ea7a4..1681ee1 100644
--- a/sound/ppc/beep.c
+++ b/sound/ppc/beep.c
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

