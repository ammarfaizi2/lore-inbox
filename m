Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbTAUUAc>; Tue, 21 Jan 2003 15:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTAUUAc>; Tue, 21 Jan 2003 15:00:32 -0500
Received: from gate.perex.cz ([194.212.165.105]:517 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267191AbTAUUA0>;
	Tue, 21 Jan 2003 15:00:26 -0500
Date: Tue, 21 Jan 2003 21:09:14 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2
In-Reply-To: <200301212006.01107.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.44.0301212101130.6355-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Daniel Ritz wrote:

> ok, found that one...very simple:
> against 2.5.59 + jaroslav's driver patch...
> 
> 
> --- linux-2.5/sound/isa/opl3sa2.c~	2003-01-21 20:01:10.000000000 +0100
> +++ linux-2.5/sound/isa/opl3sa2.c	2003-01-21 19:58:06.000000000 +0100
> @@ -830,7 +830,8 @@
>  	if ((err = snd_card_register(card)) < 0)
>  		goto __error;
>  
> -	pnpc_set_drvdata(pcard, card);
> +	if (pcard)
> +		pnpc_set_drvdata(pcard, card);
>  	snd_opl3sa2_cards[dev] = card;
>  	return 0;
>  
> 
> the card is not detected by pnp, that problem stays. is that a problem of the pnp layer or is
> my toshiba laptop just so damn stupid??

Nope. It's fault of the driver. It scans for a card. Actually, the 
structure card -> devices is created only by the ISA PnP driver.

I don't see any reason to not group the PnP BIOS devices into one "card", 
too. Adam, do you have any comments?

Here is the patch for PnP BIOS and opl3sa2 - note that the only difference 
for opl3sa2 driver is line:

+       /* Yamaha OPL3-SA3 (PnP BIOS) */
+       {.id = "PnPbios", .driver_data = 0, .devs = { {.id="YMH0021"}, } 

						Jaroslav

===== core.c 1.21 vs edited =====
--- 1.21/drivers/pnp/pnpbios/core.c	Sun Jan 12 21:14:10 2003
+++ edited/core.c	Tue Jan 21 21:05:39 2003
@@ -1387,7 +1387,11 @@
 	.disable = pnpbios_disable_resources,
 };
 
+#ifdef CONFIG_PNP_CARD
+static inline int insert_device(struct pnp_card *card, struct pnp_dev *dev)
+#else
 static inline int insert_device(struct pnp_dev *dev)
+#endif
 {
 	struct list_head * pos;
 	struct pnp_dev * pnp_dev;
@@ -1396,7 +1400,11 @@
 		if (dev->number == pnp_dev->number)
 			return -1;
 	}
+#ifdef CONFIG_PNP_CARD
+	pnpc_add_device(card, dev);
+#else
 	pnp_add_device(dev);
+#endif
 	return 0;
 }
 
@@ -1411,6 +1419,7 @@
 	struct pnp_dev_node_info node_info;
 	struct pnp_dev *dev;
 	struct pnp_id *dev_id;
+	struct pnp_card *card;
 
 	if (!pnp_bios_present())
 		return;
@@ -1421,6 +1430,28 @@
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return;
+		
+#ifdef CONFIG_PNP_CARD
+	card = pnpbios_kmalloc(sizeof(struct pnp_card), GFP_KERNEL);
+	if (!card) {
+		kfree(node);
+		return;
+	}
+	memset(card, 0, sizeof(struct pnp_card));
+	
+	dev_id = pnpbios_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	if (!dev_id) {
+		kfree(node);
+		kfree(card);
+		return;
+	}
+	memset(dev_id, 0, sizeof(struct pnp_id));
+
+	strcpy(dev_id->id, "PnPbios");
+	INIT_LIST_HEAD(&card->devices);
+	pnpc_add_id(dev_id, card);
+	card->protocol = &pnpbios_protocol;
+#endif
 
 	for(nodenum=0; nodenum<0xff; ) {
 		u8 thisnodenum = nodenum;
@@ -1444,10 +1475,11 @@
 			break;
 		}
 		memset(dev_id,0,sizeof(struct pnp_id));
+		dev->card = card;
 		dev->number = thisnodenum;
 		strcpy(dev->name,"Unknown Device");
 		pnpid32_to_pnpid(node->eisa_id,id);
-		memcpy(dev_id->id,id,7);
+		memcpy(dev_id->id,id,sizeof(dev_id->id));
 		pnp_add_id(dev_id, dev);
 		pos = node_current_resource_data_to_dev(node,dev);
 		pos = node_possible_resource_data_to_dev(pos,node,dev);
@@ -1465,7 +1497,11 @@
 
 		dev->protocol = &pnpbios_protocol;
 
+#ifdef CONFIG_PNP_CARD
+		if(insert_device(card, dev)<0) {
+#else
 		if(insert_device(dev)<0) {
+#endif
 			kfree(dev_id);
 			kfree(dev);
 		} else
@@ -1476,6 +1512,9 @@
 		}
 	}
 	kfree(node);
+#ifdef CONFIG_PNP_CARD
+	pnpc_add_card(card);
+#endif
 
 	printk(KERN_INFO "PnPBIOS: %i node%s reported by PnP BIOS; %i recorded by driver\n",
 		nodes_got, nodes_got != 1 ? "s" : "", devs);
===== opl3sa2.c 1.14 vs edited =====
--- 1.14/sound/isa/opl3sa2.c	Sat Dec  7 17:11:30 2002
+++ edited/opl3sa2.c	Tue Jan 21 20:37:54 2003
@@ -134,6 +134,7 @@
 
 struct snd_opl3sa2 {
 	snd_card_t *card;
+	int dev_no;		/* device / slot index */
 	int version;		/* 2 or 3 */
 	unsigned long port;	/* control port */
 	struct resource *res_port; /* control port resource */
@@ -161,23 +162,22 @@
 
 #ifdef CONFIG_PNP
 
-static struct pnp_card *snd_opl3sa2_isapnp_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-static const struct pnp_card_id *snd_opl3sa2_isapnp_id[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-static struct pnp_card_id snd_opl3sa2_pnpids[] = {
+static struct pnp_card_device_id snd_opl3sa2_pnpids[] = {
 	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
-	{.id = "YMH0020", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0020", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
-	{.id = "YMH0030", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0030", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA2 */
-	{.id = "YMH0800", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0800", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* NeoMagic MagicWave 3DX */
-	{.id = "NMX2200", .driver_data = 0, devs : { {.id="NMX2210"}, } },
+	{.id = "NMX2200", .driver_data = 0, .devs = { {.id="NMX2210"}, } },
+	/* Yamaha OPL3-SA3 (PnP BIOS) */
+	{.id = "PnPbios", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* --- */
 	{.id = "", } /* end */
 };
 
-/*PNP_CARD_TABLE(snd_opl3sa2_pnpids);*/
+MODULE_DEVICE_TABLE(pnp_card, snd_opl3sa2_pnpids);
 
 #endif /* CONFIG_PNP */
 
@@ -625,40 +625,69 @@
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PNP
-static int __init snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip)
+static int __devinit snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip,
+					struct pnp_card *card,
+					const struct pnp_card_device_id *id)
 {
-        const struct pnp_card_id *id = snd_opl3sa2_isapnp_id[dev];
-        struct pnp_card *card = snd_opl3sa2_isapnp_cards[dev];
 	struct pnp_dev *pdev;
+	struct pnp_res_cfg cfg;
+	int err;
 
-	chip->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	pdev = chip->dev;
+	pdev = chip->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
 	if (!pdev){
 		snd_printdd("isapnp OPL3-SA: a card was found but it did not contain the needed devices\n");
 		return -ENODEV;
 	}
-	sb_port[dev] = pdev->resource[0].start;
-	wss_port[dev] = pdev->resource[1].start;
-	fm_port[dev] = pdev->resource[2].start;
-	midi_port[dev] = pdev->resource[3].start;
-	port[dev] = pdev->resource[4].start;
-	dma1[dev] = pdev->dma_resource[0].start;
-	dma2[dev] = pdev->dma_resource[1].start;
-	irq[dev] = pdev->irq_resource[0].start;
+	if (pnp_init_res_cfg(&cfg) < 0)
+		return -ENOMEM;
+	/* override resources */
+	if (sb_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[0], sb_port[dev], 16);
+	if (wss_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[1], wss_port[dev], 8);
+	if (fm_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[2], fm_port[dev], 4);
+	if (midi_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[3], midi_port[dev], 2);
+	if (port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg.io_resource[4], port[dev], 2);
+	if (dma1[dev] != SNDRV_AUTO_DMA)
+		pnp_resource_change(&cfg.dma_resource[0], dma1[dev], 1);
+	if (dma2[dev] != SNDRV_AUTO_DMA)
+		pnp_resource_change(&cfg.dma_resource[1], dma2[dev], 1);
+	if (irq[dev] != SNDRV_AUTO_IRQ)
+		pnp_resource_change(&cfg.irq_resource[0], irq[dev], 1);
+	err = pnp_activate_dev(pdev, &cfg);
+	if (err < 0) {
+		snd_printk(KERN_ERR "cannot activate pnp device (out of resources?)\n");
+		return err;
+	}
+	sb_port[dev] = pnp_port_start(pdev, 0);
+	wss_port[dev] = pnp_port_start(pdev, 1);
+	fm_port[dev] = pnp_port_start(pdev, 2);
+	midi_port[dev] = pnp_port_start(pdev, 3);
+	port[dev] = pnp_port_start(pdev, 4);
+	dma1[dev] = pnp_dma(pdev, 0);
+	dma2[dev] = pnp_dma(pdev, 1);
+	irq[dev] = pnp_irq(pdev, 0);
 	snd_printdd("isapnp OPL3-SA: sb port=0x%lx, wss port=0x%lx, fm port=0x%lx, midi port=0x%lx\n",
 		sb_port[dev], wss_port[dev], fm_port[dev], midi_port[dev]);
 	snd_printdd("isapnp OPL3-SA: control port=0x%lx, dma1=%i, dma2=%i, irq=%i\n",
 		port[dev], dma1[dev], dma2[dev], irq[dev]);
 	return 0;
 }
-
+#else
+static int __devinit snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip,
+					struct pnp_card *card,
+					const struct pnp_card_device_id *id)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_PNP */
 
 static int snd_opl3sa2_free(opl3sa2_t *chip)
 {
-#ifdef CONFIG_PNP
-	chip->dev = NULL;
-#endif
+	snd_opl3sa2_cards[chip->dev_no] = NULL;
 #ifdef CONFIG_PM
 	if (chip->pm_dev)
 		pm_unregister(chip->pm_dev);
@@ -679,7 +708,9 @@
 	return snd_opl3sa2_free(chip);
 }
 
-static int __init snd_opl3sa2_probe(int dev)
+static int __devinit snd_opl3sa2_probe(int dev, int _isapnp,
+				       struct pnp_card *pcard,
+				       const struct pnp_card_device_id *pid)
 {
 	int xirq, xdma1, xdma2;
 	snd_card_t *card;
@@ -691,9 +722,7 @@
 	};
 	int err;
 
-#ifdef CONFIG_PNP
-	if (!isapnp[dev]) {
-#endif
+	if (!_isapnp) {
 		if (port[dev] == SNDRV_AUTO_PORT) {
 			snd_printk("specify port\n");
 			return -EINVAL;
@@ -710,9 +739,7 @@
 			snd_printk("specify midi_port\n");
 			return -EINVAL;
 		}
-#ifdef CONFIG_PNP
 	}
-#endif
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card == NULL)
 		return -ENOMEM;
@@ -723,13 +750,12 @@
 		err = -ENOMEM;
 		goto __error;
 	}
+	chip->dev_no = dev;
 	chip->irq = -1;
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
 		goto __error;
-#ifdef CONFIG_PNP
-	if (isapnp[dev] && (err = snd_opl3sa2_isapnp(dev, chip)) < 0)
+	if (_isapnp && (err = snd_opl3sa2_isapnp(dev, chip, pcard, pid)) < 0)
 		goto __error;
-#endif
 	chip->ymode = opl3sa3_ymode[dev] & 0x03 ; /* initialise this card from supplied (or default) parameter*/ 
 	chip->card = card;
 	chip->port = port[dev];
@@ -806,6 +832,8 @@
 	if ((err = snd_card_register(card)) < 0)
 		goto __error;
 
+	if (pcard)
+		pnpc_set_drvdata(pcard, card);
 	snd_opl3sa2_cards[dev] = card;
 	return 0;
 
@@ -815,18 +843,16 @@
 }
 
 #ifdef CONFIG_PNP
-static int __init snd_opl3sa2_isapnp_detect(struct pnp_card *card,
-					    const struct pnp_card_id *id)
+static int __devinit snd_opl3sa2_isapnp_detect(struct pnp_card *card,
+					    const struct pnp_card_device_id *id)
 {
         static int dev;
         int res;
 
         for ( ; dev < SNDRV_CARDS; dev++) {
-                if (!enable[dev])
+                if (!enable[dev] || !isapnp[dev])
                         continue;
-                snd_opl3sa2_isapnp_cards[dev] = card;
-                snd_opl3sa2_isapnp_id[dev] = id;
-                res = snd_opl3sa2_probe(dev);
+                res = snd_opl3sa2_probe(dev, 1, card, id);
                 if (res < 0)
                         return res;
                 dev++;
@@ -835,18 +861,21 @@
         return -ENODEV;
 }
 
-static void snd_opl3sa2_isapnp_remove(struct pnp_card * card)
+static void __devexit snd_opl3sa2_isapnp_remove(struct pnp_card * pcard)
 {
-/* FIXME */
+	snd_card_t * card = (snd_card_t *) pnpc_get_drvdata(pcard);
+	
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
 }
 
 static struct pnpc_driver opl3sa2_pnpc_driver = {
+	.flags		= PNPC_DRIVER_DO_NOT_ACTIVATE,
 	.name		= "opl3sa2",
 	.id_table	= snd_opl3sa2_pnpids,
 	.probe		= snd_opl3sa2_isapnp_detect,
-	.remove		= snd_opl3sa2_isapnp_remove,
+	.remove		= __devexit_p(snd_opl3sa2_isapnp_remove),
 };
-
 #endif /* CONFIG_PNP */
 
 static int __init alsa_card_opl3sa2_init(void)
@@ -860,7 +889,7 @@
 		if (isapnp[dev])
 			continue;
 #endif
-		if (snd_opl3sa2_probe(dev) >= 0)
+		if (snd_opl3sa2_probe(dev, 0, NULL, NULL) >= 0)
 			cards++;
 	}
 #ifdef CONFIG_PNP
@@ -870,6 +899,9 @@
 #ifdef MODULE
 		printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
 #endif
+#ifdef CONFIG_PNP
+		pnpc_unregister_driver(&opl3sa2_pnpc_driver);
+#endif
 		return -ENODEV;
 	}
 	return 0;
@@ -877,10 +909,13 @@
 
 static void __exit alsa_card_opl3sa2_exit(void)
 {
-	int idx;
+        int dev;
 
-	for (idx = 0; idx < SNDRV_CARDS; idx++)
-		snd_card_free(snd_opl3sa2_cards[idx]);
+#ifdef CONFIG_PNP
+	pnpc_unregister_driver(&opl3sa2_pnpc_driver);
+#endif
+	for (dev = 0; dev < SNDRV_CARDS; dev++)
+		snd_card_free(snd_opl3sa2_cards[dev]);
 }
 
 module_init(alsa_card_opl3sa2_init)

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

