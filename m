Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUFHVao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUFHVao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbUFHV3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:29:07 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51938 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S265325AbUFHVZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:25:03 -0400
Date: Wed, 9 Jun 2004 00:25:02 +0300
From: Pekka J Enberg <penberg@cs.helsinki.fi>
Message-Id: <200406082125.i58LP2Vs016196@melkki.cs.helsinki.fi>
Subject: [PATCH] ALSA: Remove subsystem-specific malloc (4/8)
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic allocator in linux/sound/i2c/ with kcalloc() and kfree().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

 cs8427.c       |    4 ++--
 i2c.c          |    8 ++++----
 l3/uda1341.c   |    8 ++++----
 other/ak4117.c |    4 ++--
 tea6330t.c     |    6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff -X dontdiff -purN linux-2.6.6/sound/i2c/cs8427.c alsa-2.6.6/sound/i2c/cs8427.c
--- linux-2.6.6/sound/i2c/cs8427.c	2004-06-08 23:57:23.472877712 +0300
+++ alsa-2.6.6/sound/i2c/cs8427.c	2004-06-05 21:09:30.000000000 +0300
@@ -159,7 +159,7 @@ static int snd_cs8427_send_corudata(snd_
 static void snd_cs8427_free(snd_i2c_device_t *device)
 {
 	if (device->private_data)
-		snd_magic_kfree(device->private_data);
+		kfree(device->private_data);
 }
 
 int snd_cs8427_create(snd_i2c_bus_t *bus,
@@ -211,7 +211,7 @@ int snd_cs8427_create(snd_i2c_bus_t *bus
 
 	if ((err = snd_i2c_device_create(bus, "CS8427", CS8427_ADDR | (addr & 7), &device)) < 0)
 		return err;
-	chip = device->private_data = snd_magic_kcalloc(cs8427_t, 0, GFP_KERNEL);
+	chip = device->private_data = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 	      	snd_i2c_device_free(device);
 		return -ENOMEM;
diff -X dontdiff -purN linux-2.6.6/sound/i2c/i2c.c alsa-2.6.6/sound/i2c/i2c.c
--- linux-2.6.6/sound/i2c/i2c.c	2004-06-08 23:57:23.532868592 +0300
+++ alsa-2.6.6/sound/i2c/i2c.c	2004-06-05 21:08:42.000000000 +0300
@@ -62,7 +62,7 @@ static int snd_i2c_bus_free(snd_i2c_bus_
 	}
 	if (bus->private_free)
 		bus->private_free(bus);
-	snd_magic_kfree(bus);
+	kfree(bus);
 	return 0;
 }
 
@@ -81,7 +81,7 @@ int snd_i2c_bus_create(snd_card_t *card,
 	};
 
 	*ri2c = NULL;
-	bus = (snd_i2c_bus_t *)snd_magic_kcalloc(snd_i2c_bus_t, 0, GFP_KERNEL);
+	bus = kcalloc(sizeof(*bus), GFP_KERNEL);
 	if (bus == NULL)
 		return -ENOMEM;
 	init_MUTEX(&bus->lock_mutex);
@@ -108,7 +108,7 @@ int snd_i2c_device_create(snd_i2c_bus_t 
 
 	*rdevice = NULL;
 	snd_assert(bus != NULL, return -EINVAL);
-	device = (snd_i2c_device_t *)snd_magic_kcalloc(snd_i2c_device_t, 0, GFP_KERNEL);
+	device = kcalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL)
 		return -ENOMEM;
 	device->addr = addr;
@@ -125,7 +125,7 @@ int snd_i2c_device_free(snd_i2c_device_t
 		list_del(&device->list);
 	if (device->private_free)
 		device->private_free(device);
-	snd_magic_kfree(device);
+	kfree(device);
 	return 0;
 }
 
diff -X dontdiff -purN linux-2.6.6/sound/i2c/l3/uda1341.c alsa-2.6.6/sound/i2c/l3/uda1341.c
--- linux-2.6.6/sound/i2c/l3/uda1341.c	2004-06-08 23:57:23.584860688 +0300
+++ alsa-2.6.6/sound/i2c/l3/uda1341.c	2004-06-05 21:08:02.000000000 +0300
@@ -653,7 +653,7 @@ static snd_kcontrol_new_t snd_uda1341_co
 static void uda1341_free(struct l3_client *uda1341)
 {
 	l3_detach_client(uda1341); // calls kfree for driver_data (uda1341_t)
-	snd_magic_kfree(uda1341);
+	kfree(uda1341);
 }
 
 static int uda1341_dev_free(snd_device_t *device)
@@ -673,7 +673,7 @@ int __init snd_chip_uda1341_mixer_new(sn
 
 	snd_assert(card != NULL, return -EINVAL);
 
-	uda1341 = snd_magic_kcalloc(l3_client_t, 0, GFP_KERNEL);
+	uda1341 = kcalloc(sizeof(*uda1341), GFP_KERNEL);
 	if (uda1341 == NULL)
 		return -ENOMEM;
          
@@ -710,7 +710,7 @@ static int uda1341_attach(struct l3_clie
 {
 	struct uda1341 *uda;
 
-	uda = snd_magic_kcalloc(uda1341_t, 0, GFP_KERNEL);
+	uda = kcalloc(sizeof(*uda), 0, GFP_KERNEL);
 	if (!uda)
 		return -ENOMEM;
 
@@ -734,7 +734,7 @@ static int uda1341_attach(struct l3_clie
 static void uda1341_detach(struct l3_client *clnt)
 {
 	if (clnt->driver_data)
-		snd_magic_kfree(clnt->driver_data);
+		kfree(clnt->driver_data);
 }
 
 static int
diff -X dontdiff -purN linux-2.6.6/sound/i2c/other/ak4117.c alsa-2.6.6/sound/i2c/other/ak4117.c
--- linux-2.6.6/sound/i2c/other/ak4117.c	2004-06-08 23:57:23.526869504 +0300
+++ alsa-2.6.6/sound/i2c/other/ak4117.c	2004-06-05 21:08:59.000000000 +0300
@@ -65,7 +65,7 @@ static void reg_dump(ak4117_t *ak4117)
 static void snd_ak4117_free(ak4117_t *chip)
 {
 	del_timer(&chip->timer);
-	snd_magic_kfree(chip);
+	kfree(chip);
 }
 
 static int snd_ak4117_dev_free(snd_device_t *device)
@@ -85,7 +85,7 @@ int snd_ak4117_create(snd_card_t *card, 
 		.dev_free =     snd_ak4117_dev_free,
 	};
 
-	chip = (ak4117_t *)snd_magic_kcalloc(ak4117_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->lock);
diff -X dontdiff -purN linux-2.6.6/sound/i2c/tea6330t.c alsa-2.6.6/sound/i2c/tea6330t.c
--- linux-2.6.6/sound/i2c/tea6330t.c	2004-06-08 23:57:23.568863120 +0300
+++ alsa-2.6.6/sound/i2c/tea6330t.c	2004-06-05 21:08:16.000000000 +0300
@@ -271,7 +271,7 @@ TEA6330T_TREBLE("Tone Control - Treble",
 static void snd_tea6330_free(snd_i2c_device_t *device)
 {
 	tea6330t_t *tea = snd_magic_cast(tea6330t_t, device->private_data, return);
-	snd_magic_kfree(tea);
+	kfree(tea);
 }
                                         
 int snd_tea6330t_update_mixer(snd_card_t * card,
@@ -286,11 +286,11 @@ int snd_tea6330t_update_mixer(snd_card_t
 	u8 default_treble, default_bass;
 	unsigned char bytes[7];
 
-	tea = snd_magic_kcalloc(tea6330t_t, 0, GFP_KERNEL);
+	tea = kcalloc(sizeof(*tea), GFP_KERNEL);
 	if (tea == NULL)
 		return -ENOMEM;
 	if ((err = snd_i2c_device_create(bus, "TEA6330T", TEA6330T_ADDR, &device)) < 0) {
-		snd_magic_kfree(tea);
+		kfree(tea);
 		return err;
 	}
 	tea->device = device;
