Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbWF0QhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbWF0QhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWF0QhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:36586 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161174AbWF0QhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:09 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/17] [PATCH] 64bit resource: fix up printks for resources in sound drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:38 -0700
Message-Id: <11514260373971-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260331421-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 sound/arm/aaci.c              |    5 +++--
 sound/drivers/mpu401/mpu401.c |    5 +++--
 sound/isa/es18xx.c            |    3 ++-
 sound/isa/gus/interwave.c     |    8 ++++----
 sound/isa/sb/sb16.c           |    3 ++-
 sound/oss/forte.c             |    5 +++--
 sound/pci/bt87x.c             |    5 +++--
 sound/pci/sonicvibes.c        |    4 ++--
 sound/ppc/pmac.c              |   14 ++++++++------
 sound/sparc/cs4231.c          |    4 ++--
 sound/sparc/dbri.c            |    4 ++--
 11 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 5f22d70..6b18225 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -779,8 +779,9 @@ static struct aaci * __devinit aaci_init
 	strlcpy(card->driver, DRIVER_NAME, sizeof(card->driver));
 	strlcpy(card->shortname, "ARM AC'97 Interface", sizeof(card->shortname));
 	snprintf(card->longname, sizeof(card->longname),
-		 "%s at 0x%08lx, irq %d",
-		 card->shortname, dev->res.start, dev->irq[0]);
+		 "%s at 0x%016llx, irq %d",
+		 card->shortname, (unsigned long long)dev->res.start,
+		 dev->irq[0]);
 
 	aaci = card->private_data;
 	mutex_init(&aaci->ac97_sem);
diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index d3cbbb0..8b80024 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -160,8 +160,9 @@ static int __devinit snd_mpu401_pnp(int 
 		return -ENODEV;
 	}
 	if (pnp_port_len(device, 0) < IO_EXTENT) {
-		snd_printk(KERN_ERR "PnP port length is %ld, expected %d\n",
-			   pnp_port_len(device, 0), IO_EXTENT);
+		snd_printk(KERN_ERR "PnP port length is %llu, expected %d\n",
+			   (unsigned long long)pnp_port_len(device, 0),
+			   IO_EXTENT);
 		return -ENODEV;
 	}
 	port[dev] = pnp_port_start(device, 0);
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index e6945db..af60b0b 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -2088,7 +2088,8 @@ static int __devinit snd_audiodrive_pnp(
 		kfree(cfg);
 		return -EAGAIN;
 	}
-	snd_printdd("pnp: port=0x%lx\n", pnp_port_start(acard->devc, 0));
+	snd_printdd("pnp: port=0x%llx\n",
+			(unsigned long long)pnp_port_start(acard->devc, 0));
 	/* PnP initialization */
 	pdev = acard->dev;
 	pnp_init_resource_table(cfg);
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index 866300f..c1c86e0 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -611,10 +611,10 @@ #endif
 	if (dma2[dev] >= 0)
 		dma2[dev] = pnp_dma(pdev, 1);
 	irq[dev] = pnp_irq(pdev, 0);
-	snd_printdd("isapnp IW: sb port=0x%lx, gf1 port=0x%lx, codec port=0x%lx\n",
-				pnp_port_start(pdev, 0),
-				pnp_port_start(pdev, 1),
-				pnp_port_start(pdev, 2));
+	snd_printdd("isapnp IW: sb port=0x%llx, gf1 port=0x%llx, codec port=0x%llx\n",
+			(unsigned long long)pnp_port_start(pdev, 0),
+			(unsigned long long)pnp_port_start(pdev, 1),
+			(unsigned long long)pnp_port_start(pdev, 2));
 	snd_printdd("isapnp IW: dma1=%i, dma2=%i, irq=%i\n", dma1[dev], dma2[dev], irq[dev]);
 #ifdef SNDRV_STB
 	/* Tone Control initialization */
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index 7f7f05f..d64e67f 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -327,7 +327,8 @@ #ifdef SNDRV_SBAWE_EMU8000
 			goto __wt_error; 
 		} 
 		awe_port[dev] = pnp_port_start(pdev, 0);
-		snd_printdd("pnp SB16: wavetable port=0x%lx\n", pnp_port_start(pdev, 0));
+		snd_printdd("pnp SB16: wavetable port=0x%llx\n",
+				(unsigned long long)pnp_port_start(pdev, 0));
 	} else {
 __wt_error:
 		if (pdev) {
diff --git a/sound/oss/forte.c b/sound/oss/forte.c
index 0294eec..44e5780 100644
--- a/sound/oss/forte.c
+++ b/sound/oss/forte.c
@@ -2035,8 +2035,9 @@ forte_probe (struct pci_dev *pci_dev, co
 	
 	pci_set_drvdata (pci_dev, chip);
 
-	printk (KERN_INFO PFX "FM801 chip found at 0x%04lX-0x%04lX IRQ %u\n", 
-		chip->iobase, pci_resource_end (pci_dev, 0), chip->irq);
+	printk (KERN_INFO PFX "FM801 chip found at 0x%04lX-0x%16llX IRQ %u\n",
+		chip->iobase, (unsigned long long)pci_resource_end (pci_dev, 0),
+		chip->irq);
 
 	/* Power it up */
 	if ((ret = forte_chip_init (chip)) == 0)
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index c33642d..497ed6b 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -888,8 +888,9 @@ static int __devinit snd_bt87x_probe(str
 
 	strcpy(card->driver, "Bt87x");
 	sprintf(card->shortname, "Brooktree Bt%x", pci->device);
-	sprintf(card->longname, "%s at %#lx, irq %i",
-		card->shortname, pci_resource_start(pci, 0), chip->irq);
+	sprintf(card->longname, "%s at %#llx, irq %i",
+		card->shortname, (unsigned long long)pci_resource_start(pci, 0),
+		chip->irq);
 	strcpy(card->mixername, "Bt87x");
 
 	err = snd_card_register(card);
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index dcf4029..e551160 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1441,10 +1441,10 @@ static int __devinit snd_sonic_probe(str
 
 	strcpy(card->driver, "SonicVibes");
 	strcpy(card->shortname, "S3 SonicVibes");
-	sprintf(card->longname, "%s rev %i at 0x%lx, irq %i",
+	sprintf(card->longname, "%s rev %i at 0x%llx, irq %i",
 		card->shortname,
 		sonic->revision,
-		pci_resource_start(pci, 1),
+		(unsigned long long)pci_resource_start(pci, 1),
 		sonic->irq);
 
 	if ((err = snd_sonicvibes_pcm(sonic, 0, NULL)) < 0) {
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index b678814..be98f63 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -1170,9 +1170,10 @@ int __init snd_pmac_new(struct snd_card 
 					       chip->rsrc[i].start + 1,
 					       rnames[i]) == NULL) {
 				printk(KERN_ERR "snd: can't request rsrc "
-				       " %d (%s: 0x%08lx:%08lx)\n",
-				       i, rnames[i], chip->rsrc[i].start,
-				       chip->rsrc[i].end);
+				       " %d (%s: 0x%016lx:%016lx)\n",
+				       i, rnames[i],
+				       (unsigned long long)chip->rsrc[i].start,
+				       (unsigned long long)chip->rsrc[i].end);
 				err = -ENODEV;
 				goto __error;
 			}
@@ -1201,9 +1202,10 @@ int __init snd_pmac_new(struct snd_card 
 					       chip->rsrc[i].start + 1,
 					       rnames[i]) == NULL) {
 				printk(KERN_ERR "snd: can't request rsrc "
-				       " %d (%s: 0x%08lx:%08lx)\n",
-				       i, rnames[i], chip->rsrc[i].start,
-				       chip->rsrc[i].end);
+				       " %d (%s: 0x%016llx:%016llx)\n",
+				       i, rnames[i],
+				       (unsigned long long)chip->rsrc[i].start,
+				       (unsigned long long)chip->rsrc[i].end);
 				err = -ENODEV;
 				goto __error;
 			}
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index da54d04..d9d14c2 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2037,10 +2037,10 @@ static int __init cs4231_sbus_attach(str
 	if (err)
 		return err;
 
-	sprintf(card->longname, "%s at 0x%02lx:0x%08lx, irq %d",
+	sprintf(card->longname, "%s at 0x%02lx:0x%016lx, irq %d",
 		card->shortname,
 		rp->flags & 0xffL,
-		rp->start,
+		(unsigned long long)rp->start,
 		sdev->irqs[0]);
 
 	if ((err = snd_cs4231_sbus_create(card, sdev, dev, &cp)) < 0) {
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 5eecdd0..a7489a3 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2645,9 +2645,9 @@ static int __init dbri_attach(int prom_n
 	strcpy(card->driver, "DBRI");
 	strcpy(card->shortname, "Sun DBRI");
 	rp = &sdev->resource[0];
-	sprintf(card->longname, "%s at 0x%02lx:0x%08lx, irq %d",
+	sprintf(card->longname, "%s at 0x%02lx:0x%016lx, irq %d",
 		card->shortname,
-		rp->flags & 0xffL, rp->start, irq.pri);
+		rp->flags & 0xffL, (unsigned long long)rp->start, irq.pri);
 
 	if ((err = snd_dbri_create(card, sdev, &irq, dev)) < 0) {
 		snd_card_free(card);
-- 
1.4.0

