Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTH2Uu0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbTH2Us1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:48:27 -0400
Received: from out8.mx.nwbl.wi.voyager.net ([169.207.3.117]:57539 "EHLO
	out8.mx.nwbl.wi.voyager.net") by vger.kernel.org with ESMTP
	id S262254AbTH2UqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:46:16 -0400
Message-ID: <3F4FBC3A.B011D3B3@megsinet.net>
Date: Fri, 29 Aug 2003 15:48:58 -0500
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.0-test4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: zaitcev@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ymf724 oops in 2.4.22, boot fails
References: <3F4FBB78.8DD75F69@megsinet.net>
Content-Type: multipart/mixed;
 boundary="------------A4B83D17D4B4A065D12D87D1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A4B83D17D4B4A065D12D87D1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

New patch attached w/o extra printk

Martin

"M.H.VanLeeuwen" wrote:
> 
> Pete,
> 
> The attached patch allows my system to boot 2.4.22 successfully.
> 
> a. if the read of AC97_EXTENDED_ID fails just leave eid NULL and continue
>    to fix??? no codec attached.  Here is my dmesg output for this device:
> 
>     ymfpci: YMF724 at 0xffed8000 IRQ 9
>     ac97_codec: AC97 Audio codec, id: 0x8384:0x7605 (SigmaTel STAC9704)
> 
> b. change references to codec to unit in function ymf_probe_one() based on
>    comments in ymfpci.h
> 
>   /*
>    * Throughout the code Yaroslav names YMF unit pointer "codec"
>    * even though it does not correspond to any codec. Must be historic.
>    * We replace it with "unit" over time.
>    * AC97 parts use "codec" to denote a codec, naturally.
>    */
> 
> c. fix oops, release memory "unit" not ac97 codec which we haven't
>    init'd yet.
> 
> Martin
> 
>
--------------A4B83D17D4B4A065D12D87D1
Content-Type: text/plain; charset=us-ascii;
 name="ymfpci.patch.2.4.22"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ymfpci.patch.2.4.22"

--- ymfpci.c	Thu Aug 28 08:29:55 2003
+++ /net/shadow/bld2/linux-2.4.22/drivers/sound/ymfpci.c	Fri Aug 29 15:46:58 2003
@@ -2472,12 +2472,8 @@
 	}
 
 	eid = ymfpci_codec_read(codec, AC97_EXTENDED_ID);
-	if (eid==0xFFFF) {
-		printk(KERN_WARNING "ymfpci: no codec attached ?\n");
-		goto out_kfree;
-	}
-
-	unit->ac97_features = eid;
+	if (eid!=0xFFFF)
+		unit->ac97_features = eid;
 
 	if ((codec->dev_mixer = register_sound_mixer(&ymf_mixer_fops, -1)) < 0) {
 		printk(KERN_ERR "ymfpci: couldn't register mixer!\n");
@@ -2509,7 +2505,7 @@
 {
 	u16 ctrl;
 	unsigned long base;
-	ymfpci_t *codec;
+	ymfpci_t *unit;
 
 	int err;
 
@@ -2519,27 +2515,27 @@
 	}
 	base = pci_resource_start(pcidev, 0);
 
-	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
+	if ((unit = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "ymfpci: no core\n");
 		return -ENOMEM;
 	}
-	memset(codec, 0, sizeof(*codec));
+	memset(unit, 0, sizeof(*unit));
 
-	spin_lock_init(&codec->reg_lock);
-	spin_lock_init(&codec->voice_lock);
-	spin_lock_init(&codec->ac97_lock);
-	init_MUTEX(&codec->open_sem);
-	INIT_LIST_HEAD(&codec->states);
-	codec->pci = pcidev;
+	spin_lock_init(&unit->reg_lock);
+	spin_lock_init(&unit->voice_lock);
+	spin_lock_init(&unit->ac97_lock);
+	init_MUTEX(&unit->open_sem);
+	INIT_LIST_HEAD(&unit->states);
+	unit->pci = pcidev;
 
-	pci_read_config_byte(pcidev, PCI_REVISION_ID, &codec->rev);
+	pci_read_config_byte(pcidev, PCI_REVISION_ID, &unit->rev);
 
 	if (request_mem_region(base, 0x8000, "ymfpci") == NULL) {
 		printk(KERN_ERR "ymfpci: unable to request mem region\n");
 		goto out_free;
 	}
 
-	if ((codec->reg_area_virt = ioremap(base, 0x8000)) == NULL) {
+	if ((unit->reg_area_virt = ioremap(base, 0x8000)) == NULL) {
 		printk(KERN_ERR "ymfpci: unable to map registers\n");
 		goto out_release_region;
 	}
@@ -2550,33 +2546,33 @@
 	    (char *)ent->driver_data, base, pcidev->irq);
 
 	ymfpci_aclink_reset(pcidev);
-	if (ymfpci_codec_ready(codec, 0, 1) < 0)
+	if (ymfpci_codec_ready(unit, 0, 1) < 0)
 		goto out_unmap;
 
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
 	if (assigned == 0) {
-		codec->iomidi = mpu_io;
-		codec->iosynth = synth_io;
-		if (ymfpci_setup_legacy(codec, pcidev) < 0)
+		unit->iomidi = mpu_io;
+		unit->iosynth = synth_io;
+		if (ymfpci_setup_legacy(unit, pcidev) < 0)
 			goto out_unmap;
 		assigned = 1;
 	}
 #endif
 
-	ymfpci_download_image(codec);
+	ymfpci_download_image(unit);
 
-	if (ymfpci_memalloc(codec) < 0)
+	if (ymfpci_memalloc(unit) < 0)
 		goto out_disable_dsp;
-	ymf_memload(codec);
+	ymf_memload(unit);
 
-	if (request_irq(pcidev->irq, ymf_interrupt, SA_SHIRQ, "ymfpci", codec) != 0) {
+	if (request_irq(pcidev->irq, ymf_interrupt, SA_SHIRQ, "ymfpci", unit) != 0) {
 		printk(KERN_ERR "ymfpci: unable to request IRQ %d\n",
 		    pcidev->irq);
 		goto out_memfree;
 	}
 
 	/* register /dev/dsp */
-	if ((codec->dev_audio = register_sound_dsp(&ymf_fops, -1)) < 0) {
+	if ((unit->dev_audio = register_sound_dsp(&ymf_fops, -1)) < 0) {
 		printk(KERN_ERR "ymfpci: unable to register dsp\n");
 		goto out_free_irq;
 	}
@@ -2584,49 +2580,49 @@
 	/*
 	 * Poke just the primary for the moment.
 	 */
-	if ((err = ymf_ac97_init(codec, 0)) != 0)
+	if ((err = ymf_ac97_init(unit, 0)) != 0)
 		goto out_unregister_sound_dsp;
 
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
-	codec->opl3_data.name = "ymfpci";
-	codec->mpu_data.name  = "ymfpci";
+	unit->opl3_data.name = "ymfpci";
+	unit->mpu_data.name  = "ymfpci";
 
-	codec->opl3_data.io_base = codec->iosynth;
-	codec->opl3_data.irq     = -1;
+	unit->opl3_data.io_base = unit->iosynth;
+	unit->opl3_data.irq     = -1;
 
-	codec->mpu_data.io_base  = codec->iomidi;
-	codec->mpu_data.irq      = -1;	/* May be different from our PCI IRQ. */
+	unit->mpu_data.io_base  = unit->iomidi;
+	unit->mpu_data.irq      = -1;	/* May be different from our PCI IRQ. */
 
-	if (codec->iomidi) {
-		if (!probe_uart401(&codec->mpu_data, THIS_MODULE)) {
-			codec->iomidi = 0;	/* XXX kludge */
+	if (unit->iomidi) {
+		if (!probe_uart401(&unit->mpu_data, THIS_MODULE)) {
+			unit->iomidi = 0;	/* XXX kludge */
 		}
 	}
 #endif /* CONFIG_SOUND_YMFPCI_LEGACY */
 
 	/* put it into driver list */
-	list_add_tail(&codec->ymf_devs, &ymf_devs);
-	pci_set_drvdata(pcidev, codec);
+	list_add_tail(&unit->ymf_devs, &ymf_devs);
+	pci_set_drvdata(pcidev, unit);
 
 	return 0;
 
  out_unregister_sound_dsp:
-	unregister_sound_dsp(codec->dev_audio);
+	unregister_sound_dsp(unit->dev_audio);
  out_free_irq:
-	free_irq(pcidev->irq, codec);
+	free_irq(pcidev->irq, unit);
  out_memfree:
-	ymfpci_memfree(codec);
+	ymfpci_memfree(unit);
  out_disable_dsp:
-	ymfpci_disable_dsp(codec);
-	ctrl = ymfpci_readw(codec, YDSXGR_GLOBALCTRL);
-	ymfpci_writew(codec, YDSXGR_GLOBALCTRL, ctrl & ~0x0007);
-	ymfpci_writel(codec, YDSXGR_STATUS, ~0);
+	ymfpci_disable_dsp(unit);
+	ctrl = ymfpci_readw(unit, YDSXGR_GLOBALCTRL);
+	ymfpci_writew(unit, YDSXGR_GLOBALCTRL, ctrl & ~0x0007);
+	ymfpci_writel(unit, YDSXGR_STATUS, ~0);
  out_unmap:
-	iounmap(codec->reg_area_virt);
+	iounmap(unit->reg_area_virt);
  out_release_region:
 	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
  out_free:
-	ac97_release_codec(codec->ac97_codec[0]);
+	kfree(unit);
 	return -ENODEV;
 }
 

--------------A4B83D17D4B4A065D12D87D1--

