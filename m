Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVG3IrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVG3IrS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 04:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVG3IpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 04:45:18 -0400
Received: from mail1.nwe.de ([195.226.126.83]:41441 "EHLO mail1.nwe.de")
	by vger.kernel.org with ESMTP id S261796AbVG3IoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 04:44:12 -0400
Date: Sat, 30 Jul 2005 10:43:43 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6-mm] tms380tr: new MCA API for madgemc.
Message-ID: <Pine.LNX.4.58.0507301041210.5597@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jochen Friedrich <jochen@scram.de>

Convert madgemc to new MCA API. Now that all tms380 devices have a valid
struct device with dma_mask, remove dmalimit from tmsdev_init().

Kconfig: depend tms380tr and madgemc on MCA.
abyss.c, proteon.c, skisa.c, tmspci.c, tms380tr.h:
  remove dmalimit parameter from tmsdev_init().
tms380tr.c: use device->dma_mask instead of dmalimit.
madgemc.c: move to new MCA API using struct device.

---
commit 1f4dc1d28361058afd86f95c6e38ff97fac0037e
tree 034adb66d17b76b171c9aeff62a5b87574cb0560
parent 12dd61e649920ddc5164971e36ed2a6aeb300708
author Jochen Friedrich <jochen@scram.de> Sat, 30 Jul 2005 10:32:52 +0200
committer Jochen Friedrich <jochen@scram.de> Sat, 30 Jul 2005 10:32:52 +0200

 drivers/net/tokenring/Kconfig    |    4
 drivers/net/tokenring/abyss.c    |    2
 drivers/net/tokenring/madgemc.c  |  515 +++++++++++++++++++-------------------
 drivers/net/tokenring/proteon.c  |    2
 drivers/net/tokenring/skisa.c    |    2
 drivers/net/tokenring/tms380tr.c |   11 +
 drivers/net/tokenring/tms380tr.h |    3
 drivers/net/tokenring/tmspci.c   |    2
 8 files changed, 270 insertions(+), 271 deletions(-)

diff --git a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig
+++ b/drivers/net/tokenring/Kconfig
@@ -84,7 +84,7 @@ config 3C359

 config TMS380TR
 	tristate "Generic TMS380 Token Ring ISA/PCI adapter support"
-	depends on TR && (PCI || ISA)
+	depends on TR && (PCI || ISA || MCA)
 	select FW_LOADER
 	---help---
 	  This driver provides generic support for token ring adapters
@@ -158,7 +158,7 @@ config ABYSS

 config MADGEMC
 	tristate "Madge Smart 16/4 Ringnode MicroChannel"
-	depends on TR && TMS380TR && MCA_LEGACY
+	depends on TR && TMS380TR && MCA
 	help
 	  This tms380 module supports the Madge Smart 16/4 MC16 and MC32
 	  MicroChannel adapters.
diff --git a/drivers/net/tokenring/abyss.c b/drivers/net/tokenring/abyss.c
--- a/drivers/net/tokenring/abyss.c
+++ b/drivers/net/tokenring/abyss.c
@@ -139,7 +139,7 @@ static int __devinit abyss_attach(struct
 	 */
 	dev->base_addr += 0x10;

-	ret = tmsdev_init(dev, PCI_MAX_ADDRESS, &pdev->dev);
+	ret = tmsdev_init(dev, &pdev->dev);
 	if (ret) {
 		printk("%s: unable to get memory for dev->priv.\n",
 		       dev->name);
diff --git a/drivers/net/tokenring/madgemc.c b/drivers/net/tokenring/madgemc.c
--- a/drivers/net/tokenring/madgemc.c
+++ b/drivers/net/tokenring/madgemc.c
@@ -20,7 +20,7 @@
 static const char version[] = "madgemc.c: v0.91 23/01/2000 by Adam Fritzler\n";

 #include <linux/module.h>
-#include <linux/mca-legacy.h>
+#include <linux/mca.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
@@ -38,9 +38,7 @@ static const char version[] = "madgemc.c
 #define MADGEMC_IO_EXTENT 32
 #define MADGEMC_SIF_OFFSET 0x08

-struct madgemc_card {
-	struct net_device *dev;
-
+struct card_info {
 	/*
 	 * These are read from the BIA ROM.
 	 */
@@ -57,16 +55,12 @@ struct madgemc_card {
 	unsigned int arblevel:4;
 	unsigned int ringspeed:2; /* 0 = 4mb, 1 = 16, 2 = Auto/none */
 	unsigned int cabletype:1; /* 0 = RJ45, 1 = DB9 */
-
-	struct madgemc_card *next;
 };
-static struct madgemc_card *madgemc_card_list;
-

 static int madgemc_open(struct net_device *dev);
 static int madgemc_close(struct net_device *dev);
 static int madgemc_chipset_init(struct net_device *dev);
-static void madgemc_read_rom(struct madgemc_card *card);
+static void madgemc_read_rom(struct net_device *dev, struct card_info *card);
 static unsigned short madgemc_setnselout_pins(struct net_device *dev);
 static void madgemc_setcabletype(struct net_device *dev, int type);

@@ -151,261 +145,237 @@ static void madgemc_sifwritew(struct net



-static int __init madgemc_probe(void)
+static int __devinit madgemc_probe(struct device *device)
 {
 	static int versionprinted;
 	struct net_device *dev;
 	struct net_local *tp;
-	struct madgemc_card *card;
-	int i,slot = 0;
-	__u8 posreg[4];
-
-	if (!MCA_bus)
-		return -1;
-
-	while (slot != MCA_NOTFOUND) {
-		/*
-		 * Currently we only support the MC16/32 (MCA ID 002d)
-		 */
-		slot = mca_find_unused_adapter(0x002d, slot);
-		if (slot == MCA_NOTFOUND)
-			break;
-
-		/*
-		 * If we get here, we have an adapter.
-		 */
-		if (versionprinted++ == 0)
-			printk("%s", version);
-
-		dev = alloc_trdev(sizeof(struct net_local));
-		if (dev == NULL) {
-			printk("madgemc: unable to allocate dev space\n");
-			if (madgemc_card_list)
-				return 0;
-			return -1;
-		}
+	struct card_info *card;
+	struct mca_device *mdev = to_mca_device(device);
+	int ret = 0, i = 0;
+
+	if (versionprinted++ == 0)
+		printk("%s", version);
+
+	if(mca_device_claimed(mdev))
+		return -EBUSY;
+	mca_device_set_claim(mdev, 1);
+
+	dev = alloc_trdev(sizeof(struct net_local));
+	if (!dev) {
+		printk("madgemc: unable to allocate dev space\n");
+		mca_device_set_claim(mdev, 0);
+		ret = -ENOMEM;
+		goto getout;
+	}
+
+	SET_MODULE_OWNER(dev);
+	dev->dma = 0;
+
+	card = kmalloc(sizeof(struct card_info), GFP_KERNEL);
+	if (card==NULL) {
+		printk("madgemc: unable to allocate card struct\n");
+		ret = -ENOMEM;
+		goto getout1;
+	}

-		SET_MODULE_OWNER(dev);
-		dev->dma = 0;
+	/*
+	 * Parse configuration information.  This all comes
+	 * directly from the publicly available @002d.ADF.
+	 * Get it from Madge or your local ADF library.
+	 */

-		/*
-		 * Fetch MCA config registers
-		 */
-		for(i=0;i<4;i++)
-			posreg[i] = mca_read_stored_pos(slot, i+2);
-
-		card = kmalloc(sizeof(struct madgemc_card), GFP_KERNEL);
-		if (card==NULL) {
-			printk("madgemc: unable to allocate card struct\n");
-			free_netdev(dev);
-			if (madgemc_card_list)
-				return 0;
-			return -1;
-		}
-		card->dev = dev;
+	/*
+	 * Base address
+	 */
+	dev->base_addr = 0x0a20 +
+		((mdev->pos[2] & MC16_POS2_ADDR2)?0x0400:0) +
+		((mdev->pos[0] & MC16_POS0_ADDR1)?0x1000:0) +
+		((mdev->pos[3] & MC16_POS3_ADDR3)?0x2000:0);

-		/*
-		 * Parse configuration information.  This all comes
-		 * directly from the publicly available @002d.ADF.
-		 * Get it from Madge or your local ADF library.
-		 */
-
-		/*
-		 * Base address
-		 */
-		dev->base_addr = 0x0a20 +
-			((posreg[2] & MC16_POS2_ADDR2)?0x0400:0) +
-			((posreg[0] & MC16_POS0_ADDR1)?0x1000:0) +
-			((posreg[3] & MC16_POS3_ADDR3)?0x2000:0);
-
-		/*
-		 * Interrupt line
-		 */
-		switch(posreg[0] >> 6) { /* upper two bits */
+	/*
+	 * Interrupt line
+	 */
+	switch(mdev->pos[0] >> 6) { /* upper two bits */
 		case 0x1: dev->irq = 3; break;
 		case 0x2: dev->irq = 9; break; /* IRQ 2 = IRQ 9 */
 		case 0x3: dev->irq = 10; break;
 		default: dev->irq = 0; break;
-		}
+	}

-		if (dev->irq == 0) {
-			printk("%s: invalid IRQ\n", dev->name);
-			goto getout1;
-		}
+	if (dev->irq == 0) {
+		printk("%s: invalid IRQ\n", dev->name);
+		ret = -EBUSY;
+		goto getout2;
+	}

-		if (!request_region(dev->base_addr, MADGEMC_IO_EXTENT,
-				   "madgemc")) {
-			printk(KERN_INFO "madgemc: unable to setup Smart MC in slot %d because of I/O base conflict at 0x%04lx\n", slot, dev->base_addr);
-			dev->base_addr += MADGEMC_SIF_OFFSET;
-			goto getout1;
-		}
+	if (!request_region(dev->base_addr, MADGEMC_IO_EXTENT,
+			   "madgemc")) {
+		printk(KERN_INFO "madgemc: unable to setup Smart MC in slot %d because of I/O base conflict at 0x%04lx\n", mdev->slot, dev->base_addr);
 		dev->base_addr += MADGEMC_SIF_OFFSET;
+		ret = -EBUSY;
+		goto getout2;
+	}
+	dev->base_addr += MADGEMC_SIF_OFFSET;
+
+	/*
+	 * Arbitration Level
+	 */
+	card->arblevel = ((mdev->pos[0] >> 1) & 0x7) + 8;
+
+	/*
+	 * Burst mode and Fairness
+	 */
+	card->burstmode = ((mdev->pos[2] >> 6) & 0x3);
+	card->fairness = ((mdev->pos[2] >> 4) & 0x1);
+
+	/*
+	 * Ring Speed
+	 */
+	if ((mdev->pos[1] >> 2)&0x1)
+		card->ringspeed = 2; /* not selected */
+	else if ((mdev->pos[2] >> 5) & 0x1)
+		card->ringspeed = 1; /* 16Mb */
+	else
+		card->ringspeed = 0; /* 4Mb */
+
+	/*
+	 * Cable type
+	 */
+	if ((mdev->pos[1] >> 6)&0x1)
+		card->cabletype = 1; /* STP/DB9 */
+	else
+		card->cabletype = 0; /* UTP/RJ-45 */
+
+
+	/*
+	 * ROM Info. This requires us to actually twiddle
+	 * bits on the card, so we must ensure above that
+	 * the base address is free of conflict (request_region above).
+	 */
+	madgemc_read_rom(dev, card);

-		/*
-		 * Arbitration Level
-		 */
-		card->arblevel = ((posreg[0] >> 1) & 0x7) + 8;
-
-		/*
-		 * Burst mode and Fairness
-		 */
-		card->burstmode = ((posreg[2] >> 6) & 0x3);
-		card->fairness = ((posreg[2] >> 4) & 0x1);
-
-		/*
-		 * Ring Speed
-		 */
-		if ((posreg[1] >> 2)&0x1)
-			card->ringspeed = 2; /* not selected */
-		else if ((posreg[2] >> 5) & 0x1)
-			card->ringspeed = 1; /* 16Mb */
-		else
-			card->ringspeed = 0; /* 4Mb */
-
-		/*
-		 * Cable type
-		 */
-		if ((posreg[1] >> 6)&0x1)
-			card->cabletype = 1; /* STP/DB9 */
-		else
-			card->cabletype = 0; /* UTP/RJ-45 */
-
-
-		/*
-		 * ROM Info. This requires us to actually twiddle
-		 * bits on the card, so we must ensure above that
-		 * the base address is free of conflict (request_region above).
-		 */
-		madgemc_read_rom(card);
-
-		if (card->manid != 0x4d) { /* something went wrong */
-			printk(KERN_INFO "%s: Madge MC ROM read failed (unknown manufacturer ID %02x)\n", dev->name, card->manid);
-			goto getout;
-		}
+	if (card->manid != 0x4d) { /* something went wrong */
+		printk(KERN_INFO "%s: Madge MC ROM read failed (unknown manufacturer ID %02x)\n", dev->name, card->manid);
+		goto getout3;
+	}

-		if ((card->cardtype != 0x08) && (card->cardtype != 0x0d)) {
-			printk(KERN_INFO "%s: Madge MC ROM read failed (unknown card ID %02x)\n", dev->name, card->cardtype);
-			goto getout;
-		}
+	if ((card->cardtype != 0x08) && (card->cardtype != 0x0d)) {
+		printk(KERN_INFO "%s: Madge MC ROM read failed (unknown card ID %02x)\n", dev->name, card->cardtype);
+		ret = -EIO;
+		goto getout3;
+	}

-		/* All cards except Rev 0 and 1 MC16's have 256kb of RAM */
-		if ((card->cardtype == 0x08) && (card->cardrev <= 0x01))
-			card->ramsize = 128;
-		else
-			card->ramsize = 256;
-
-		printk("%s: %s Rev %d at 0x%04lx IRQ %d\n",
-		       dev->name,
-		       (card->cardtype == 0x08)?MADGEMC16_CARDNAME:
-		       MADGEMC32_CARDNAME, card->cardrev,
-		       dev->base_addr, dev->irq);
+	/* All cards except Rev 0 and 1 MC16's have 256kb of RAM */
+	if ((card->cardtype == 0x08) && (card->cardrev <= 0x01))
+		card->ramsize = 128;
+	else
+		card->ramsize = 256;
+
+	printk("%s: %s Rev %d at 0x%04lx IRQ %d\n",
+	       dev->name,
+	       (card->cardtype == 0x08)?MADGEMC16_CARDNAME:
+	       MADGEMC32_CARDNAME, card->cardrev,
+	       dev->base_addr, dev->irq);

-		if (card->cardtype == 0x0d)
-			printk("%s:     Warning: MC32 support is experimental and highly untested\n", dev->name);
-
-		if (card->ringspeed==2) { /* Unknown */
-			printk("%s:     Warning: Ring speed not set in POS -- Please run the reference disk and set it!\n", dev->name);
-			card->ringspeed = 1; /* default to 16mb */
-		}
+	if (card->cardtype == 0x0d)
+		printk("%s:     Warning: MC32 support is experimental and highly untested\n", dev->name);
+
+	if (card->ringspeed==2) { /* Unknown */
+		printk("%s:     Warning: Ring speed not set in POS -- Please run the reference disk and set it!\n", dev->name);
+		card->ringspeed = 1; /* default to 16mb */
+	}

-		printk("%s:     RAM Size: %dKB\n", dev->name, card->ramsize);
+	printk("%s:     RAM Size: %dKB\n", dev->name, card->ramsize);

-		printk("%s:     Ring Speed: %dMb/sec on %s\n", dev->name,
-		       (card->ringspeed)?16:4,
-		       card->cabletype?"STP/DB9":"UTP/RJ-45");
-		printk("%s:     Arbitration Level: %d\n", dev->name,
-		       card->arblevel);
+	printk("%s:     Ring Speed: %dMb/sec on %s\n", dev->name,
+	       (card->ringspeed)?16:4,
+	       card->cabletype?"STP/DB9":"UTP/RJ-45");
+	printk("%s:     Arbitration Level: %d\n", dev->name,
+	       card->arblevel);

-		printk("%s:     Burst Mode: ", dev->name);
-		switch(card->burstmode) {
+	printk("%s:     Burst Mode: ", dev->name);
+	switch(card->burstmode) {
 		case 0: printk("Cycle steal"); break;
 		case 1: printk("Limited burst"); break;
 		case 2: printk("Delayed release"); break;
 		case 3: printk("Immediate release"); break;
-		}
-		printk(" (%s)\n", (card->fairness)?"Unfair":"Fair");
-
-
-		/*
-		 * Enable SIF before we assign the interrupt handler,
-		 * just in case we get spurious interrupts that need
-		 * handling.
-		 */
-		outb(0, dev->base_addr + MC_CONTROL_REG0); /* sanity */
-		madgemc_setsifsel(dev, 1);
-		if (request_irq(dev->irq, madgemc_interrupt, SA_SHIRQ,
-			       "madgemc", dev))
-			goto getout;
-
-		madgemc_chipset_init(dev); /* enables interrupts! */
-		madgemc_setcabletype(dev, card->cabletype);
+	}
+	printk(" (%s)\n", (card->fairness)?"Unfair":"Fair");

-		/* Setup MCA structures */
-		mca_set_adapter_name(slot, (card->cardtype == 0x08)?MADGEMC16_CARDNAME:MADGEMC32_CARDNAME);
-		mca_set_adapter_procfn(slot, madgemc_mcaproc, dev);
-		mca_mark_as_used(slot);

-		printk("%s:     Ring Station Address: ", dev->name);
-		printk("%2.2x", dev->dev_addr[0]);
-		for (i = 1; i < 6; i++)
-			printk(":%2.2x", dev->dev_addr[i]);
-		printk("\n");
+	/*
+	 * Enable SIF before we assign the interrupt handler,
+	 * just in case we get spurious interrupts that need
+	 * handling.
+	 */
+	outb(0, dev->base_addr + MC_CONTROL_REG0); /* sanity */
+	madgemc_setsifsel(dev, 1);
+	if (request_irq(dev->irq, madgemc_interrupt, SA_SHIRQ,
+		       "madgemc", dev)) {
+		ret = -EBUSY;
+		goto getout3;
+	}
+
+	madgemc_chipset_init(dev); /* enables interrupts! */
+	madgemc_setcabletype(dev, card->cabletype);
+
+	/* Setup MCA structures */
+	mca_device_set_name(mdev, (card->cardtype == 0x08)?MADGEMC16_CARDNAME:MADGEMC32_CARDNAME);
+	mca_set_adapter_procfn(mdev->slot, madgemc_mcaproc, dev);
+
+	printk("%s:     Ring Station Address: ", dev->name);
+	printk("%2.2x", dev->dev_addr[0]);
+	for (i = 1; i < 6; i++)
+		printk(":%2.2x", dev->dev_addr[i]);
+	printk("\n");
+
+	if (tmsdev_init(dev, device)) {
+		printk("%s: unable to get memory for dev->priv.\n",
+		       dev->name);
+		ret = -ENOMEM;
+		goto getout4;
+	}
+	tp = netdev_priv(dev);
+
+	/*
+	 * The MC16 is physically a 32bit card.  However, Madge
+	 * insists on calling it 16bit, so I'll assume here that
+	 * they know what they're talking about.  Cut off DMA
+	 * at 16mb.
+	 */
+	tp->setnselout = madgemc_setnselout_pins;
+	tp->sifwriteb = madgemc_sifwriteb;
+	tp->sifreadb = madgemc_sifreadb;
+	tp->sifwritew = madgemc_sifwritew;
+	tp->sifreadw = madgemc_sifreadw;
+	tp->DataRate = (card->ringspeed)?SPEED_16:SPEED_4;
+
+	memcpy(tp->ProductID, "Madge MCA 16/4    ", PROD_ID_SIZE + 1);

-		/* XXX is ISA_MAX_ADDRESS correct here? */
-		if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL)) {
-			printk("%s: unable to get memory for dev->priv.\n",
-			       dev->name);
-			release_region(dev->base_addr-MADGEMC_SIF_OFFSET,
-			       MADGEMC_IO_EXTENT);
-
-			kfree(card);
-			tmsdev_term(dev);
-			free_netdev(dev);
-			if (madgemc_card_list)
-				return 0;
-			return -1;
-		}
-		tp = netdev_priv(dev);
+	dev->open = madgemc_open;
+	dev->stop = madgemc_close;

-		/*
-		 * The MC16 is physically a 32bit card.  However, Madge
-		 * insists on calling it 16bit, so I'll assume here that
-		 * they know what they're talking about.  Cut off DMA
-		 * at 16mb.
-		 */
-		tp->setnselout = madgemc_setnselout_pins;
-		tp->sifwriteb = madgemc_sifwriteb;
-		tp->sifreadb = madgemc_sifreadb;
-		tp->sifwritew = madgemc_sifwritew;
-		tp->sifreadw = madgemc_sifreadw;
-		tp->DataRate = (card->ringspeed)?SPEED_16:SPEED_4;
-
-		memcpy(tp->ProductID, "Madge MCA 16/4    ", PROD_ID_SIZE + 1);
-
-		dev->open = madgemc_open;
-		dev->stop = madgemc_close;
-
-		if (register_netdev(dev) == 0) {
-			/* Enlist in the card list */
-			card->next = madgemc_card_list;
-			madgemc_card_list = card;
-			slot++;
-			continue; /* successful, try to find another */
-		}
-
-		free_irq(dev->irq, dev);
-	getout:
-		release_region(dev->base_addr-MADGEMC_SIF_OFFSET,
-			       MADGEMC_IO_EXTENT);
-	getout1:
-		kfree(card);
-		free_netdev(dev);
-		slot++;
-	}
+	tp->tmspriv = card;
+	dev_set_drvdata(device, dev);

-	if (madgemc_card_list)
+	if (register_netdev(dev) == 0)
 		return 0;
-	return -1;
+
+	dev_set_drvdata(device, NULL);
+	ret = -ENOMEM;
+getout4:
+	free_irq(dev->irq, dev);
+getout3:
+	release_region(dev->base_addr-MADGEMC_SIF_OFFSET,
+		       MADGEMC_IO_EXTENT);
+getout2:
+	kfree(card);
+getout1:
+	free_netdev(dev);
+getout:
+	mca_device_set_claim(mdev, 0);
+	return ret;
 }

 /*
@@ -664,12 +634,12 @@ static void madgemc_chipset_close(struct
  * is complete.
  *
  */
-static void madgemc_read_rom(struct madgemc_card *card)
+static void madgemc_read_rom(struct net_device *dev, struct card_info *card)
 {
 	unsigned long ioaddr;
 	unsigned char reg0, reg1, tmpreg0, i;

-	ioaddr = card->dev->base_addr;
+	ioaddr = dev->base_addr;

 	reg0 = inb(ioaddr + MC_CONTROL_REG0);
 	reg1 = inb(ioaddr + MC_CONTROL_REG1);
@@ -686,9 +656,9 @@ static void madgemc_read_rom(struct madg
 	outb(tmpreg0 | MC_CONTROL_REG0_PAGE, ioaddr + MC_CONTROL_REG0);

 	/* Read BIA */
-	card->dev->addr_len = 6;
+	dev->addr_len = 6;
 	for (i = 0; i < 6; i++)
-		card->dev->dev_addr[i] = inb(ioaddr + MC_ROM_BIA_START + i);
+		dev->dev_addr[i] = inb(ioaddr + MC_ROM_BIA_START + i);

 	/* Restore original register values */
 	outb(reg0, ioaddr + MC_CONTROL_REG0);
@@ -721,14 +691,10 @@ static int madgemc_close(struct net_devi
 static int madgemc_mcaproc(char *buf, int slot, void *d)
 {
 	struct net_device *dev = (struct net_device *)d;
-	struct madgemc_card *curcard = madgemc_card_list;
+	struct net_local *tp = dev->priv;
+	struct card_info *curcard = tp->tmspriv;
 	int len = 0;

-	while (curcard) { /* search for card struct */
-		if (curcard->dev == dev)
-			break;
-		curcard = curcard->next;
-	}
 	len += sprintf(buf+len, "-------\n");
 	if (curcard) {
 		struct net_local *tp = netdev_priv(dev);
@@ -763,25 +729,56 @@ static int madgemc_mcaproc(char *buf, in
 	return len;
 }

-static void __exit madgemc_exit(void)
+static int __devexit madgemc_remove(struct device *device)
 {
-	struct net_device *dev;
-	struct madgemc_card *this_card;
-
-	while (madgemc_card_list) {
-		dev = madgemc_card_list->dev;
-		unregister_netdev(dev);
-		release_region(dev->base_addr-MADGEMC_SIF_OFFSET, MADGEMC_IO_EXTENT);
-		free_irq(dev->irq, dev);
-		tmsdev_term(dev);
-		free_netdev(dev);
-		this_card = madgemc_card_list;
-		madgemc_card_list = this_card->next;
-		kfree(this_card);
-	}
+	struct net_device *dev = dev_get_drvdata(device);
+	struct net_local *tp;
+        struct card_info *card;
+
+	if (!dev)
+		BUG();
+
+	tp = dev->priv;
+	card = tp->tmspriv;
+	kfree(card);
+	tp->tmspriv = NULL;
+
+	unregister_netdev(dev);
+	release_region(dev->base_addr-MADGEMC_SIF_OFFSET, MADGEMC_IO_EXTENT);
+	free_irq(dev->irq, dev);
+	tmsdev_term(dev);
+	free_netdev(dev);
+	dev_set_drvdata(device, NULL);
+
+	return 0;
+}
+
+static short madgemc_adapter_ids[] __initdata = {
+	0x002d,
+	0x0000
+};
+
+static struct mca_driver madgemc_driver = {
+	.id_table = madgemc_adapter_ids,
+	.driver = {
+		.name = "madgemc",
+		.bus = &mca_bus_type,
+		.probe = madgemc_probe,
+		.remove = __devexit_p(madgemc_remove),
+	},
+};
+
+static int __init madgemc_init (void)
+{
+	return mca_register_driver (&madgemc_driver);
+}
+
+static void __exit madgemc_exit (void)
+{
+	mca_unregister_driver (&madgemc_driver);
 }

-module_init(madgemc_probe);
+module_init(madgemc_init);
 module_exit(madgemc_exit);

 MODULE_LICENSE("GPL");
diff --git a/drivers/net/tokenring/proteon.c b/drivers/net/tokenring/proteon.c
--- a/drivers/net/tokenring/proteon.c
+++ b/drivers/net/tokenring/proteon.c
@@ -145,7 +145,7 @@ static int __init setup_card(struct net_

 	err = -EIO;
 	pdev->dma_mask = &dma_mask;
-	if (tmsdev_init(dev, ISA_MAX_ADDRESS, pdev))
+	if (tmsdev_init(dev, pdev))
 		goto out4;

 	dev->base_addr &= ~3;
diff --git a/drivers/net/tokenring/skisa.c b/drivers/net/tokenring/skisa.c
--- a/drivers/net/tokenring/skisa.c
+++ b/drivers/net/tokenring/skisa.c
@@ -162,7 +162,7 @@ static int __init setup_card(struct net_

 	err = -EIO;
 	pdev->dma_mask = &dma_mask;
-	if (tmsdev_init(dev, ISA_MAX_ADDRESS, pdev))
+	if (tmsdev_init(dev, pdev))
 		goto out4;

 	dev->base_addr &= ~3;
diff --git a/drivers/net/tokenring/tms380tr.c b/drivers/net/tokenring/tms380tr.c
--- a/drivers/net/tokenring/tms380tr.c
+++ b/drivers/net/tokenring/tms380tr.c
@@ -2333,19 +2333,22 @@ void tmsdev_term(struct net_device *dev)
 		DMA_BIDIRECTIONAL);
 }

-int tmsdev_init(struct net_device *dev, unsigned long dmalimit,
-		struct device *pdev)
+int tmsdev_init(struct net_device *dev, struct device *pdev)
 {
 	struct net_local *tms_local;

 	memset(dev->priv, 0, sizeof(struct net_local));
 	tms_local = netdev_priv(dev);
 	init_waitqueue_head(&tms_local->wait_for_tok_int);
-	tms_local->dmalimit = dmalimit;
+	if (pdev->dma_mask)
+		tms_local->dmalimit = *pdev->dma_mask;
+	else
+		return -ENOMEM;
 	tms_local->pdev = pdev;
 	tms_local->dmabuffer = dma_map_single(pdev, (void *)tms_local,
 	    sizeof(struct net_local), DMA_BIDIRECTIONAL);
-	if (tms_local->dmabuffer + sizeof(struct net_local) > dmalimit)
+	if (tms_local->dmabuffer + sizeof(struct net_local) >
+			tms_local->dmalimit)
 	{
 		printk(KERN_INFO "%s: Memory not accessible for DMA\n",
 			dev->name);
diff --git a/drivers/net/tokenring/tms380tr.h b/drivers/net/tokenring/tms380tr.h
--- a/drivers/net/tokenring/tms380tr.h
+++ b/drivers/net/tokenring/tms380tr.h
@@ -17,8 +17,7 @@
 int tms380tr_open(struct net_device *dev);
 int tms380tr_close(struct net_device *dev);
 irqreturn_t tms380tr_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-int tmsdev_init(struct net_device *dev, unsigned long dmalimit,
-		struct device *pdev);
+int tmsdev_init(struct net_device *dev, struct device *pdev);
 void tmsdev_term(struct net_device *dev);
 void tms380tr_wait(unsigned long time);

diff --git a/drivers/net/tokenring/tmspci.c b/drivers/net/tokenring/tmspci.c
--- a/drivers/net/tokenring/tmspci.c
+++ b/drivers/net/tokenring/tmspci.c
@@ -143,7 +143,7 @@ static int __devinit tms_pci_attach(stru
 		printk(":%2.2x", dev->dev_addr[i]);
 	printk("\n");

-	ret = tmsdev_init(dev, PCI_MAX_ADDRESS, &pdev->dev);
+	ret = tmsdev_init(dev, &pdev->dev);
 	if (ret) {
 		printk("%s: unable to get memory for dev->priv.\n", dev->name);
 		goto err_out_irq;

