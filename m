Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWCWUJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWCWUJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWCWUJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:09:20 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:38551 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964919AbWCWUJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:09:19 -0500
Date: Thu, 23 Mar 2006 15:09:02 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 8/10] 64 bit resources sound changes
Message-ID: <20060323200902.GL7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com> <20060323200227.GG7175@in.ibm.com> <20060323200342.GH7175@in.ibm.com> <20060323200451.GI7175@in.ibm.com> <20060323200610.GJ7175@in.ibm.com> <20060323200744.GK7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323200744.GK7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required in sound/* to support 64bit resources.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 sound/arm/aaci.c              |    5 +++--
 sound/drivers/mpu401/mpu401.c |    5 +++--
 sound/isa/es18xx.c            |    3 ++-
 sound/isa/gus/interwave.c     |    8 ++++----
 sound/isa/sb/sb16.c           |    3 ++-
 sound/oss/forte.c             |    5 +++--
 sound/pci/bt87x.c             |    5 +++--
 sound/pci/sonicvibes.c        |    4 ++--
 sound/sparc/cs4231.c          |    4 ++--
 sound/sparc/dbri.c            |    5 +++--
 10 files changed, 27 insertions(+), 20 deletions(-)

diff -puN sound/arm/aaci.c~64bit-resources-sound-changes sound/arm/aaci.c
--- linux-2.6.16-mm1/sound/arm/aaci.c~64bit-resources-sound-changes	2006-03-23 11:39:17.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/arm/aaci.c	2006-03-23 11:39:18.000000000 -0500
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
diff -puN sound/drivers/mpu401/mpu401.c~64bit-resources-sound-changes sound/drivers/mpu401/mpu401.c
--- linux-2.6.16-mm1/sound/drivers/mpu401/mpu401.c~64bit-resources-sound-changes	2006-03-23 11:39:17.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/drivers/mpu401/mpu401.c	2006-03-23 11:39:18.000000000 -0500
@@ -160,8 +160,9 @@ static int __init snd_mpu401_pnp(int dev
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
diff -puN sound/isa/es18xx.c~64bit-resources-sound-changes sound/isa/es18xx.c
--- linux-2.6.16-mm1/sound/isa/es18xx.c~64bit-resources-sound-changes	2006-03-23 11:39:17.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/isa/es18xx.c	2006-03-23 11:39:18.000000000 -0500
@@ -2086,7 +2086,8 @@ static int __devinit snd_audiodrive_pnp(
 		kfree(cfg);
 		return -EAGAIN;
 	}
-	snd_printdd("pnp: port=0x%lx\n", pnp_port_start(acard->devc, 0));
+	snd_printdd("pnp: port=0x%llx\n",
+			(unsigned long long)pnp_port_start(acard->devc, 0));
 	/* PnP initialization */
 	pdev = acard->dev;
 	pnp_init_resource_table(cfg);
diff -puN sound/isa/gus/interwave.c~64bit-resources-sound-changes sound/isa/gus/interwave.c
--- linux-2.6.16-mm1/sound/isa/gus/interwave.c~64bit-resources-sound-changes	2006-03-23 11:39:17.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/isa/gus/interwave.c	2006-03-23 11:39:18.000000000 -0500
@@ -611,10 +611,10 @@ static int __devinit snd_interwave_pnp(i
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
diff -puN sound/isa/sb/sb16.c~64bit-resources-sound-changes sound/isa/sb/sb16.c
--- linux-2.6.16-mm1/sound/isa/sb/sb16.c~64bit-resources-sound-changes	2006-03-23 11:39:17.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/isa/sb/sb16.c	2006-03-23 11:39:18.000000000 -0500
@@ -327,7 +327,8 @@ static int __devinit snd_card_sb16_pnp(i
 			goto __wt_error; 
 		} 
 		awe_port[dev] = pnp_port_start(pdev, 0);
-		snd_printdd("pnp SB16: wavetable port=0x%lx\n", pnp_port_start(pdev, 0));
+		snd_printdd("pnp SB16: wavetable port=0x%llx\n",
+				(unsigned long long)pnp_port_start(pdev, 0));
 	} else {
 __wt_error:
 		if (pdev) {
diff -puN sound/oss/forte.c~64bit-resources-sound-changes sound/oss/forte.c
--- linux-2.6.16-mm1/sound/oss/forte.c~64bit-resources-sound-changes	2006-03-23 11:39:17.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/oss/forte.c	2006-03-23 11:39:18.000000000 -0500
@@ -2035,8 +2035,9 @@ forte_probe (struct pci_dev *pci_dev, co
 	
 	pci_set_drvdata (pci_dev, chip);
 
-	printk (KERN_INFO PFX "FM801 chip found at 0x%04lX-0x%04lX IRQ %u\n", 
-		chip->iobase, pci_resource_end (pci_dev, 0), chip->irq);
+	printk (KERN_INFO PFX "FM801 chip found at 0x%04lX-0x%16llX IRQ %u\n",
+		chip->iobase, (unsigned long long)pci_resource_end (pci_dev, 0),
+		chip->irq);
 
 	/* Power it up */
 	if ((ret = forte_chip_init (chip)) == 0)
diff -puN sound/pci/bt87x.c~64bit-resources-sound-changes sound/pci/bt87x.c
--- linux-2.6.16-mm1/sound/pci/bt87x.c~64bit-resources-sound-changes	2006-03-23 11:39:17.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/pci/bt87x.c	2006-03-23 11:39:18.000000000 -0500
@@ -886,8 +886,9 @@ static int __devinit snd_bt87x_probe(str
 
 	strcpy(card->driver, "Bt87x");
 	sprintf(card->shortname, "Brooktree Bt%x", pci->device);
-	sprintf(card->longname, "%s at %#lx, irq %i",
-		card->shortname, pci_resource_start(pci, 0), chip->irq);
+	sprintf(card->longname, "%s at %#llx, irq %i",
+		card->shortname, (unsigned long long)pci_resource_start(pci, 0),
+		chip->irq);
 	strcpy(card->mixername, "Bt87x");
 
 	err = snd_card_register(card);
diff -puN sound/pci/sonicvibes.c~64bit-resources-sound-changes sound/pci/sonicvibes.c
--- linux-2.6.16-mm1/sound/pci/sonicvibes.c~64bit-resources-sound-changes	2006-03-23 11:39:18.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/pci/sonicvibes.c	2006-03-23 11:39:18.000000000 -0500
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
diff -puN sound/sparc/cs4231.c~64bit-resources-sound-changes sound/sparc/cs4231.c
--- linux-2.6.16-mm1/sound/sparc/cs4231.c~64bit-resources-sound-changes	2006-03-23 11:39:18.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/sparc/cs4231.c	2006-03-23 11:39:18.000000000 -0500
@@ -2040,10 +2040,10 @@ static int __init cs4231_sbus_attach(str
 	if (err)
 		return err;
 
-	sprintf(card->longname, "%s at 0x%02lx:0x%08lx, irq %s",
+	sprintf(card->longname, "%s at 0x%02lx:0x%016llx, irq %s",
 		card->shortname,
 		rp->flags & 0xffL,
-		rp->start,
+		(unsigned long long)rp->start,
 		__irq_itoa(sdev->irqs[0]));
 
 	if ((err = snd_cs4231_sbus_create(card, sdev, dev, &cp)) < 0) {
diff -puN sound/sparc/dbri.c~64bit-resources-sound-changes sound/sparc/dbri.c
--- linux-2.6.16-mm1/sound/sparc/dbri.c~64bit-resources-sound-changes	2006-03-23 11:39:18.000000000 -0500
+++ linux-2.6.16-mm1-root/sound/sparc/dbri.c	2006-03-23 11:39:18.000000000 -0500
@@ -2645,9 +2645,10 @@ static int __init dbri_attach(int prom_n
 	strcpy(card->driver, "DBRI");
 	strcpy(card->shortname, "Sun DBRI");
 	rp = &sdev->resource[0];
-	sprintf(card->longname, "%s at 0x%02lx:0x%08lx, irq %s",
+	sprintf(card->longname, "%s at 0x%02lx:0x%016llx, irq %s",
 		card->shortname,
-		rp->flags & 0xffL, rp->start, __irq_itoa(irq.pri));
+		rp->flags & 0xffL, (unsigned long long)rp->start,
+		__irq_itoa(irq.pri));
 
 	if ((err = snd_dbri_create(card, sdev, &irq, dev)) < 0) {
 		snd_card_free(card);
_
