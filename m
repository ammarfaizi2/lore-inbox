Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbTBIQ7H>; Sun, 9 Feb 2003 11:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbTBIQ4Z>; Sun, 9 Feb 2003 11:56:25 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:43148 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267308AbTBIQyR>;
	Sun, 9 Feb 2003 11:54:17 -0500
Date: Sun, 9 Feb 2003 12:04:12 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>
Cc: perex@perex.cz, "Grover, Andrew" <andrew.grover@intel.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] pnp - ISAPnP Updates (5/12) 2.5.59-bk3
Message-ID: <20030209120412.GA20011@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	perex@perex.cz, "Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Contains many isapnp improvements including true get resource support which is 
necessary to get active configs on boot and to ensure a resource set was 
accepted.  It also adds some initial MEM32 support, more work in that area will 
come in the near future.

Please apply,
Adam


--- linux-2.5.58/drivers/pnp/isapnp/core.c	Tue Jan 14 05:58:55 2003
+++ a/drivers/pnp/isapnp/core.c	Sun Feb  9 10:42:49 2003
@@ -101,7 +101,6 @@
 
 /* some prototypes */
 
-static int isapnp_config_prepare(struct pnp_dev *dev);
 extern struct pnp_protocol isapnp_protocol;
 
 static inline void write_data(unsigned char x)
@@ -260,7 +259,7 @@
 		 *	We cannot use NE2000 probe spaces for ISAPnP or we
 		 *	will lock up machines.
 		 */
-		if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1)) 
+		if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1))
 		{
 			isapnp_rdp = rdp;
 			return 0;
@@ -580,14 +579,18 @@
 						 int depnum, int size)
 {
 	unsigned char tmp[17];
-	struct pnp_mem32 *mem32;
+	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem32 = isapnp_alloc(sizeof(struct pnp_mem32));
-	if (!mem32)
+	mem = isapnp_alloc(sizeof(struct pnp_mem));
+	if (!mem)
 		return;
-	memcpy(mem32->data, tmp, 17);
-	pnp_add_mem32_resource(dev,depnum,mem32);
+	mem->min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
+	mem->max = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
+	mem->align = (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
+	mem->size = (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
+	mem->flags = tmp[0];
+	pnp_add_mem_resource(dev,depnum,mem);
 }
 
 /*
@@ -597,15 +600,18 @@
 static void __init isapnp_add_fixed_mem32_resource(struct pnp_dev *dev,
 						       int depnum, int size)
 {
-	unsigned char tmp[17];
-	struct pnp_mem32 *mem32;
+	unsigned char tmp[9];
+	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem32 = isapnp_alloc(sizeof(struct pnp_mem32));
-	if (!mem32)
+	mem = isapnp_alloc(sizeof(struct pnp_mem));
+	if (!mem)
 		return;
-	memcpy(mem32->data, tmp, 17);
-	pnp_add_mem32_resource(dev,depnum,mem32);
+	mem->min = mem->max = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
+	mem->size = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
+	mem->align = 0;
+	mem->flags = tmp[0];
+	pnp_add_mem_resource(dev,depnum,mem);
 }
 
 /*
@@ -650,7 +656,6 @@
 		switch (type) {
 		case _STAG_LOGDEVID:
 			if (size >= 5 && size <= 6) {
-				isapnp_config_prepare(dev);
 				if ((dev = isapnp_parse_device(card, size, number++)) == NULL)
 					return 1;
 				pnp_build_resource(dev,0);
@@ -723,7 +728,7 @@
 			size = 0;
 			break;
 		case _LTAG_ANSISTR:
-			isapnp_parse_name(dev->name, sizeof(dev->name), &size);
+			isapnp_parse_name(dev->dev.name, sizeof(dev->dev.name), &size);
 			break;
 		case _LTAG_UNICODESTR:
 			/* silently ignore */
@@ -738,7 +743,7 @@
 			size = 0;
 			break;
 		case _LTAG_FIXEDMEM32RANGE:
-			if (size != 17)
+			if (size != 9)
 				goto __skip;
 			isapnp_add_fixed_mem32_resource(dev, depnum, size);
 			size = 0;
@@ -746,7 +751,6 @@
 		case _STAG_END:
 			if (size > 0)
 				isapnp_skip_bytes(size);
-			isapnp_config_prepare(dev);
 			return 1;
 		default:
 			printk(KERN_ERR "isapnp: unexpected or unknown tag type 0x%x for logical device %i (device %i), ignored\n", type, dev->number, card->number);
@@ -755,7 +759,6 @@
 	      	if (size > 0)
 		      	isapnp_skip_bytes(size);
 	}
-	isapnp_config_prepare(dev);
 	return 0;
 }
 
@@ -790,7 +793,7 @@
 		case _STAG_VENDOR:
 			break;
 		case _LTAG_ANSISTR:
-			isapnp_parse_name(card->name, sizeof(card->name), &size);
+			isapnp_parse_name(card->dev.name, sizeof(card->dev.name), &size);
 			break;
 		case _LTAG_UNICODESTR:
 			/* silently ignore */
@@ -852,6 +855,64 @@
 	pnpc_add_id(id,card);
 }
 
+
+static int isapnp_parse_current_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
+{
+	int tmp, ret;
+	struct pnp_rule_table rule;
+	if (dev->rule)
+		rule = *dev->rule;
+	else {
+		if (!pnp_generate_rule(dev,1,&rule))
+			return -EINVAL;
+	}
+
+	dev->active = isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
+	if (dev->active) {
+		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
+			ret = isapnp_read_word(ISAPNP_CFG_PORT + (tmp << 1));
+			if (!ret)
+				continue;
+			res->port_resource[tmp].start = ret;
+			if (rule.port[tmp])
+				res->port_resource[tmp].end = ret + rule.port[tmp]->size - 1;
+			else
+				res->port_resource[tmp].end = ret + 1; /* all we can do is assume 1 :-( */
+			res->port_resource[tmp].flags = IORESOURCE_IO;
+		}
+		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
+			ret = isapnp_read_dword(ISAPNP_CFG_MEM + (tmp << 3));
+			if (!ret)
+				continue;
+			res->mem_resource[tmp].start = ret;
+			if (rule.mem[tmp])
+				res->mem_resource[tmp].end = ret + rule.mem[tmp]->size - 1;
+			else
+				res->mem_resource[tmp].end = ret + 1; /* all we can do is assume 1 :-( */
+			res->mem_resource[tmp].flags = IORESOURCE_MEM;
+		}
+		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
+			ret = (isapnp_read_word(ISAPNP_CFG_IRQ + (tmp << 1)) >> 8);
+			if (!ret)
+				continue;
+			res->irq_resource[tmp].start = res->irq_resource[tmp].end = ret;
+			res->irq_resource[tmp].flags = IORESOURCE_IRQ;
+		}
+		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
+			ret = isapnp_read_byte(ISAPNP_CFG_DMA + tmp);
+			pnp_info("dma %d", tmp);
+			if (ret == 4)
+				continue;
+			if (rule.dma[tmp]) { /* some isapnp systems forget to set this to 4 so we have to check */
+				res->dma_resource[tmp].start = res->dma_resource[tmp].end = ret;
+				res->dma_resource[tmp].flags = IORESOURCE_DMA;
+			}
+		}
+	}
+	return 0;
+}
+
+
 /*
  *  Build device list for all present ISA PnP devices.
  */
@@ -861,6 +922,7 @@
 	int csn;
 	unsigned char header[9], checksum;
 	struct pnp_card *card;
+	struct pnp_dev *dev;
 
 	isapnp_wait();
 	isapnp_key();
@@ -893,8 +955,17 @@
 			printk(KERN_ERR "isapnp: checksum for device %i is not valid (0x%x)\n", csn, isapnp_checksum_value);
 		card->checksum = isapnp_checksum_value;
 		card->protocol = &isapnp_protocol;
+
+		/* read the current resource data */
+		card_for_each_dev(card,dev) {
+			isapnp_device(dev->number);
+		pnp_init_resource_table(&dev->res);
+			isapnp_parse_current_resources(dev, &dev->res);
+		}
+
 		pnpc_add_card(card);
 	}
+	isapnp_wait();
 	return 0;
 }
 
@@ -948,39 +1019,6 @@
 	return 0;
 }
 
-static int isapnp_config_prepare(struct pnp_dev *dev)
-{
-	int idx;
-	if (dev == NULL)
-		return -EINVAL;
-	if (dev->active || dev->lock_resources)
-		return -EBUSY;
-	for (idx = 0; idx < DEVICE_COUNT_IRQ; idx++) {
-		dev->irq_resource[idx].name = NULL;
-		dev->irq_resource[idx].start = -1;
-		dev->irq_resource[idx].end = -1;
-		dev->irq_resource[idx].flags = IORESOURCE_IRQ|IORESOURCE_UNSET;
-	}
-	for (idx = 0; idx < DEVICE_COUNT_DMA; idx++) {
-		dev->dma_resource[idx].name = NULL;
-		dev->dma_resource[idx].start = -1;
-		dev->dma_resource[idx].end = -1;
-		dev->dma_resource[idx].flags = IORESOURCE_DMA|IORESOURCE_UNSET;
-	}
-	for (idx = 0; idx < DEVICE_COUNT_IO; idx++) {
-		dev->io_resource[idx].name = NULL;
-		dev->io_resource[idx].start = 0;
-		dev->io_resource[idx].end = 0;
-		dev->io_resource[idx].flags = IORESOURCE_IO|IORESOURCE_UNSET;
-	}
-	for (idx = 0; idx < DEVICE_COUNT_MEM; idx++) {
-		dev->mem_resource[idx].name = NULL;
-		dev->mem_resource[idx].start = 0;
-		dev->mem_resource[idx].end = 0;
-		dev->mem_resource[idx].flags = IORESOURCE_MEM|IORESOURCE_UNSET;
-	}
-	return 0;
-}
 
 /*
  *  Inititialization.
@@ -999,44 +1037,35 @@
 EXPORT_SYMBOL(isapnp_wake);
 EXPORT_SYMBOL(isapnp_device);
 
-static int isapnp_get_resources(struct pnp_dev *dev)
+static int isapnp_get_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
 {
-	/* We don't need to do anything but this, the rest is taken care of */
-	if (pnp_port_valid(dev, 0) == 0 &&
-	    pnp_mem_valid(dev, 0) == 0 &&
-	    pnp_irq_valid(dev, 0) == 0 &&
-	    pnp_dma_valid(dev, 0) == 0)
-		dev->active = 0;
-	else
-		dev->active = 1;
-	return 0;
+	int ret;
+	pnp_init_resource_table(res);
+	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_parse_current_resources(dev, res);
+	isapnp_cfg_end();
+	return ret;
 }
 
-static int isapnp_set_resources(struct pnp_dev *dev, struct pnp_cfg *cfg)
+static int isapnp_set_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
 {
 	int tmp;
-      	isapnp_cfg_begin(dev->card->number, dev->number);
+
+	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
-	dev->irq_resource[0] = cfg->request.irq_resource[0];
-	dev->irq_resource[1] = cfg->request.irq_resource[1];
-	dev->dma_resource[0] = cfg->request.dma_resource[0];
-	dev->dma_resource[1] = cfg->request.dma_resource[1];
-	for (tmp = 0; tmp < DEVICE_COUNT_IO; tmp++)
-		dev->io_resource[tmp] = cfg->request.io_resource[tmp];
-	for (tmp = 0; tmp < DEVICE_COUNT_MEM; tmp++)
-		dev->mem_resource[tmp] = cfg->request.mem_resource[tmp];
-	for (tmp = 0; tmp < 8 && pnp_port_valid(dev, tmp); tmp++)
-		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), pnp_port_start(dev, tmp));
-	for (tmp = 0; tmp < 2 && pnp_irq_valid(dev, tmp); tmp++) {
-		int irq = pnp_irq(dev, tmp);
+	for (tmp = 0; tmp < PNP_MAX_PORT && res->port_resource[tmp].flags & IORESOURCE_IO; tmp++)
+		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), res->port_resource[tmp].start);
+	for (tmp = 0; tmp < PNP_MAX_IRQ && res->irq_resource[tmp].flags & IORESOURCE_IRQ; tmp++) {
+		int irq = res->irq_resource[tmp].start;
 		if (irq == 2)
 			irq = 9;
 		isapnp_write_byte(ISAPNP_CFG_IRQ+(tmp<<1), irq);
 	}
-	for (tmp = 0; tmp < 2 && pnp_dma_valid(dev, tmp); tmp++)
-		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, pnp_dma(dev, tmp));
-	for (tmp = 0; tmp < 4 && pnp_mem_valid(dev, tmp); tmp++)
-		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (pnp_mem_start(dev, tmp) >> 8) & 0xffff);
+	for (tmp = 0; tmp < PNP_MAX_DMA && res->dma_resource[tmp].flags & IORESOURCE_DMA; tmp++)
+		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, res->dma_resource[tmp].start);
+	for (tmp = 0; tmp < PNP_MAX_MEM && res->mem_resource[tmp].flags & IORESOURCE_MEM; tmp++)
+		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (res->mem_resource[tmp].start >> 8) & 0xffff);
+	/* FIXME: We aren't handling 32bit mems properly here */
 	isapnp_activate(dev->number);
 	isapnp_cfg_end();
 	return 0;
@@ -1046,7 +1075,7 @@
 {
 	if (!dev || !dev->active)
 		return -EINVAL;
-      	isapnp_cfg_begin(dev->card->number, dev->number);
+	isapnp_cfg_begin(dev->card->number, dev->number);
 	isapnp_deactivate(dev->number);
 	dev->active = 0;
 	isapnp_cfg_end();
@@ -1127,11 +1156,11 @@
 	protocol_for_each_card(&isapnp_protocol,card) {
 		cards++;
 		if (isapnp_verbose) {
-			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
+			printk(KERN_INFO "isapnp: Card '%s'\n", card->dev.name[0]?card->dev.name:"Unknown");
 			if (isapnp_verbose < 2)
 				continue;
-			pnp_card_for_each_dev(card,dev) {
-				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->name[0]?dev->name:"Unknown");
+			card_for_each_dev(card,dev) {
+				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->dev.name[0]?dev->dev.name:"Unknown");
 			}
 		}
 	}
