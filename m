Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbRERKhN>; Fri, 18 May 2001 06:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261500AbRERKhE>; Fri, 18 May 2001 06:37:04 -0400
Received: from ns.caldera.de ([212.34.180.1]:35052 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261493AbRERKgz>;
	Fri, 18 May 2001 06:36:55 -0400
Date: Fri, 18 May 2001 12:36:11 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: sonicvibes / pci_enabled_device and error returns
Message-ID: <20010518123611.A7293@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this moves pci_enable_device() before any resource access in probe() and
cleans up the error return values. No functional changes.

Ciao, Marcus

Index: drivers/sound/sonicvibes.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/sonicvibes.c,v
retrieving revision 1.10
diff -u -r1.10 sonicvibes.c
--- drivers/sound/sonicvibes.c	2001/05/03 13:16:27	1.10
+++ drivers/sound/sonicvibes.c	2001/05/18 10:32:32
@@ -92,7 +92,9 @@
  *                       Tjeerd Mulder <tjeerd.mulder@fujitsu-siemens.com>
  *    31.01.2001   0.29  Register/Unregister gameport
  *                       Fix SETTRIGGER non OSS API conformity
+ *    18.05.2001   0.30  PCI probing and error values cleaned up by Marcus
+ *                       Meissner <mm@caldera.de>
  *
  */
 
 /*****************************************************************************/
@@ -2504,21 +2507,24 @@
 	static const char __initdata sv_ddma_name[] = "S3 Inc. SonicVibes DDMA Controller";
        	struct sv_state *s;
 	mm_segment_t fs;
-	int i, val;
+	int i, val, ret;
 	char *ddmaname;
 	unsigned ddmanamelen;
 
+	if ((ret=pci_enable_device(pcidev)))
+		return ret;
+
 	if (!RSRCISIOREGION(pcidev, RESOURCE_SB) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_ENH) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_SYNTH) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_MIDI) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_GAME))
-		return -1;
+		return -ENODEV;
 	if (pcidev->irq == 0)
-		return -1;
+		return -ENODEV;
 	if (pci_set_dma_mask(pcidev, 0x00ffffff)) {
 		printk(KERN_WARNING "sonicvibes: architecture does not support 24bit PCI busmaster DMA\n");
-		return -1;
+		return -ENODEV;
 	}
 	/* try to allocate a DDMA resource if not already available */
 	if (!RSRCISIOREGION(pcidev, RESOURCE_DDMA)) {
@@ -2534,12 +2540,12 @@
 			pcidev->resource[RESOURCE_DDMA].name = NULL;
 			kfree(ddmaname);
 			printk(KERN_ERR "sv: cannot allocate DDMA controller io ports\n");
-			return -1;
+			return -EBUSY;
 		}
 	}
 	if (!(s = kmalloc(sizeof(struct sv_state), GFP_KERNEL))) {
 		printk(KERN_WARNING "sv: out of memory\n");
-		return -1;
+		return -ENOMEM;
 	}
 	memset(s, 0, sizeof(struct sv_state));
 	init_waitqueue_head(&s->dma_adc.wait);
@@ -2567,7 +2573,8 @@
 	
 	/* hack */
 	pci_write_config_dword(pcidev, 0x60, wavetable_mem >> 12);  /* wavetable base address */
-	
+
+	ret = -EBUSY;
 	if (!request_region(s->ioenh, SV_EXTENT_ENH, "S3 SonicVibes PCM")) {
 		printk(KERN_ERR "sv: io ports %#lx-%#lx in use\n", s->ioenh, s->ioenh+SV_EXTENT_ENH-1);
 		goto err_region5;
@@ -2594,8 +2601,6 @@
 		printk(KERN_ERR "sv: gameport io ports in use\n");
 		s->gameport.io = s->gameport.size = 0;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	/* initialize codec registers */
 	outb(0x80, s->ioenh + SV_CODEC_CONTROL); /* assert reset */
 	udelay(50);
@@ -2619,21 +2624,29 @@
 	wrindir(s, SV_CIPCMSR1, ((8000 * 65536 / FULLRATE) >> 8) & 0xff);
 	wrindir(s, SV_CIADCOUTPUT, 0);
 	/* request irq */
-	if (request_irq(s->irq, sv_interrupt, SA_SHIRQ, "S3 SonicVibes", s)) {
+	if ((ret=request_irq(s->irq,sv_interrupt,SA_SHIRQ,"S3 SonicVibes",s))) {
 		printk(KERN_ERR "sv: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
 	printk(KERN_INFO "sv: found adapter at io %#lx irq %u dmaa %#06x dmac %#06x revision %u\n",
 	       s->ioenh, s->irq, s->iodmaa, s->iodmac, rdindir(s, SV_CIREVISION));
 	/* register devices */
-	if ((s->dev_audio = register_sound_dsp(&sv_audio_fops, -1)) < 0)
+	if ((s->dev_audio = register_sound_dsp(&sv_audio_fops, -1)) < 0) {
+		ret = s->dev_audio;
 		goto err_dev1;
-	if ((s->dev_mixer = register_sound_mixer(&sv_mixer_fops, -1)) < 0)
+	}
+	if ((s->dev_mixer = register_sound_mixer(&sv_mixer_fops, -1)) < 0) {
+		ret = s->dev_mixer;
 		goto err_dev2;
-	if ((s->dev_midi = register_sound_midi(&sv_midi_fops, -1)) < 0)
+	}
+	if ((s->dev_midi = register_sound_midi(&sv_midi_fops, -1)) < 0) {
+		ret = s->dev_midi;
 		goto err_dev3;
-	if ((s->dev_dmfm = register_sound_special(&sv_dmfm_fops, 15 /* ?? */)) < 0)
+	}
+	if ((s->dev_dmfm = register_sound_special(&sv_dmfm_fops, 15 /* ?? */)) < 0) {
+		ret = s->dev_dmfm;
 		goto err_dev4;
+	}
 	pci_set_master(pcidev);  /* enable bus mastering */
 	/* initialize the chips */
 	fs = get_fs();
@@ -2679,7 +2692,7 @@
 	release_region(s->ioenh, SV_EXTENT_ENH);
  err_region5:
 	kfree(s);
-	return -1;
+	return ret;
 }
 
 static void __devinit sv_remove(struct pci_dev *dev)
@@ -2731,7 +2744,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "sv: version v0.29 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "sv: version v0.30 time " __TIME__ " " __DATE__ "\n");
 #if 0
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
 		printk(KERN_INFO "sv: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
