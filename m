Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbTGKSgX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbTGKSdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:33:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25220
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265006AbTGKSEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:04:35 -0400
Date: Fri, 11 Jul 2003 19:18:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111818.h6BIIM9c017416@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update ymfpci for new ac97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/ymfpci.c linux-2.5.75-ac1/sound/oss/ymfpci.c
--- linux-2.5.75/sound/oss/ymfpci.c	2003-07-10 21:11:35.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/ymfpci.c	2003-07-11 16:59:04.000000000 +0100
@@ -177,15 +177,16 @@
 	ymfpci_t *codec = dev->private_data;
 	u32 cmd;
 
+	spin_lock(&codec->ac97_lock);
 	/* XXX Do make use of dev->id */
 	ymfpci_codec_ready(codec, 0, 0);
 	cmd = ((YDSXG_AC97WRITECMD | reg) << 16) | val;
 	ymfpci_writel(codec, YDSXGR_AC97CMDDATA, cmd);
+	spin_unlock(&codec->ac97_lock);
 }
 
-static u16 ymfpci_codec_read(struct ac97_codec *dev, u8 reg)
+static u16 _ymfpci_codec_read(ymfpci_t *unit, u8 reg)
 {
-	ymfpci_t *unit = dev->private_data;
 	int i;
 
 	if (ymfpci_codec_ready(unit, 0, 0))
@@ -200,6 +201,18 @@
 	return ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
 }
 
+static u16 ymfpci_codec_read(struct ac97_codec *dev, u8 reg)
+{
+	ymfpci_t *unit = dev->private_data;
+	u16 ret;
+	
+	spin_lock(&unit->ac97_lock);
+	ret = _ymfpci_codec_read(unit, reg);
+	spin_unlock(&unit->ac97_lock);
+	
+	return ret;
+}
+
 /*
  *  Misc routines
  */
@@ -2444,9 +2457,8 @@
 	struct ac97_codec *codec;
 	u16 eid;
 
-	if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)
+	if ((codec = ac97_alloc_codec()) == NULL)
 		return -ENOMEM;
-	memset(codec, 0, sizeof(struct ac97_codec));
 
 	/* initialize some basic codec information, other fields will be filled
 	   in ac97_probe_codec */
@@ -2462,7 +2474,7 @@
 	}
 
 	eid = ymfpci_codec_read(codec, AC97_EXTENDED_ID);
-	if (eid==0xFFFFFF) {
+	if (eid==0xFFFF) {
 		printk(KERN_WARNING "ymfpci: no codec attached ?\n");
 		goto out_kfree;
 	}
@@ -2478,7 +2490,7 @@
 
 	return 0;
  out_kfree:
-	kfree(codec);
+	ac97_release_codec(codec);
 	return -ENODEV;
 }
 
@@ -2517,6 +2529,7 @@
 
 	spin_lock_init(&codec->reg_lock);
 	spin_lock_init(&codec->voice_lock);
+	spin_lock_init(&codec->ac97_lock);
 	init_MUTEX(&codec->open_sem);
 	INIT_LIST_HEAD(&codec->states);
 	codec->pci = pcidev;
@@ -2615,7 +2628,7 @@
  out_release_region:
 	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
  out_free:
-	kfree(codec);
+	ac97_release_codec(codec->ac97_codec[0]);
 	return -ENODEV;
 }
 
@@ -2628,7 +2641,7 @@
 	list_del(&codec->ymf_devs);
 
 	unregister_sound_mixer(codec->ac97_codec[0]->dev_mixer);
-	kfree(codec->ac97_codec[0]);
+	ac97_release_codec(codec->ac97_codec[0]);
 	unregister_sound_dsp(codec->dev_audio);
 	free_irq(pcidev->irq, codec);
 	ymfpci_memfree(codec);
@@ -2643,7 +2656,6 @@
 		unload_uart401(&codec->mpu_data);
 	}
 #endif /* CONFIG_SOUND_YMFPCI_LEGACY */
-	kfree(codec);
 }
 
 MODULE_AUTHOR("Jaroslav Kysela");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/ymfpci.h linux-2.5.75-ac1/sound/oss/ymfpci.h
--- linux-2.5.75/sound/oss/ymfpci.h	2003-07-10 21:08:14.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/ymfpci.h	2003-07-11 16:59:13.000000000 +0100
@@ -275,6 +275,7 @@
 
 	spinlock_t reg_lock;
 	spinlock_t voice_lock;
+	spinlock_t ac97_lock;
 
 	/* soundcore stuff */
 	int dev_audio;
