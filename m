Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267995AbTAMSeG>; Mon, 13 Jan 2003 13:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTAMSeG>; Mon, 13 Jan 2003 13:34:06 -0500
Received: from gate.perex.cz ([194.212.165.105]:38925 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267995AbTAMSd7>;
	Mon, 13 Jan 2003 13:33:59 -0500
Date: Mon, 13 Jan 2003 19:41:01 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: LKML <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] more PnP fixes and cleanups
Message-ID: <Pine.LNX.4.33.0301131938480.501-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	this is next set of PnP cleanups.

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.945, 2003-01-13 19:30:25+01:00, perex@suse.cz
  PnP update
    - ISA PnP - removed isapnp_card_protocol reference
    - NE1000/2000 - fixed exit sequence and bugs in PnP code
    - aironet4500 - fixed exit sequence
    - ISDN - hisax_fcpcipnp - fixed compilation
    - OSS sound drivers - ad1848, cs4232 - updated to latest PnP code


 drivers/isdn/hisax/hisax_fcpcipnp.c |    6 +++---
 drivers/net/aironet4500_card.c      |    5 +----
 drivers/net/ne.c                    |   12 +++++++-----
 drivers/net/smc-ultra.c             |    4 ++--
 drivers/pnp/card.c                  |   21 ++++++++-------------
 drivers/pnp/isapnp/core.c           |    3 +--
 include/linux/pnp.h                 |    6 +++---
 sound/oss/ad1848.c                  |   22 ++++++++++------------
 sound/oss/cs4232.c                  |   23 ++++++++++++-----------
 9 files changed, 47 insertions(+), 55 deletions(-)


===================================================================


This patch contains changeset 1.945


diff -Nru a/drivers/isdn/hisax/hisax_fcpcipnp.c b/drivers/isdn/hisax/hisax_fcpcipnp.c
--- a/drivers/isdn/hisax/hisax_fcpcipnp.c	Mon Jan 13 19:36:17 2003
+++ b/drivers/isdn/hisax/hisax_fcpcipnp.c	Mon Jan 13 19:36:17 2003
@@ -55,11 +55,11 @@
 };
 MODULE_DEVICE_TABLE(pci, fcpci_ids);
 
-static const struct pnp_card_id fcpnp_ids[] __devinitdata = {
+static const struct pnp_card_device_id fcpnp_ids[] __devinitdata = {
 	{ .id = "AVM0900", .driver_data = (unsigned long) "Fritz!Card PnP",
 	  .devs = { { "AVM0900" } } }
 };
-MODULE_DEVICE_TABLE(pnpc, fcpnp_ids);
+MODULE_DEVICE_TABLE(pnp_card, fcpnp_ids);
 
 static int protocol = 2;       /* EURO-ISDN Default */
 MODULE_PARM(protocol, "i");
@@ -907,7 +907,7 @@
 #ifdef __ISAPNP__
 
 static int __devinit fcpnp_probe(struct pnp_card *card,
-				 const struct pnp_card_id *card_id)
+				 const struct pnp_card_device_id *card_id)
 {
 	struct fritz_adapter *adapter;
 	struct pnp_dev *pnp_dev;
diff -Nru a/drivers/net/aironet4500_card.c b/drivers/net/aironet4500_card.c
--- a/drivers/net/aironet4500_card.c	Mon Jan 13 19:36:17 2003
+++ b/drivers/net/aironet4500_card.c	Mon Jan 13 19:36:17 2003
@@ -455,10 +455,7 @@
 
 		if (awc_proc_unset_fun)
 			awc_proc_unset_fun(i);
-		if (isapnp_cfg_begin(logdev->PNP_BUS->PNP_BUS_NUMBER, logdev->PNP_DEV_NUMBER)<0)
-			printk("isapnp cfg failed at release \n");
-		isapnp_deactivate(logdev->PNP_DEV_NUMBER);
-		isapnp_cfg_end();
+		pnp_device_detach(logdev);
 
 		release_region(aironet4500_devices[i]->base_addr, AIRONET4X00_IO_SIZE);
 //		release_region(isa_cisaddr, AIRONET4X00_CIS_SIZE, "aironet4x00 cis");
diff -Nru a/drivers/net/ne.c b/drivers/net/ne.c
--- a/drivers/net/ne.c	Mon Jan 13 19:36:17 2003
+++ b/drivers/net/ne.c	Mon Jan 13 19:36:17 2003
@@ -206,12 +206,14 @@
 			if (pnp_device_attach(idev) < 0)
 				continue;
 			if (pnp_activate_dev(idev, NULL) < 0) {
-			      __again:
 			      	pnp_device_detach(idev);
+			      	continue;
 			}
 			/* if no io and irq, search for next */
-			if (!pnp_port_valid(idev, 0) || !pnp_irq_valid(idev, 0))
-				goto __again;
+			if (!pnp_port_valid(idev, 0) || !pnp_irq_valid(idev, 0)) {
+				pnp_device_detach(idev);
+				continue;
+			}
 			/* found it */
 			dev->base_addr = pnp_port_start(idev, 0);
 			dev->irq = pnp_irq(idev, 0);
@@ -785,9 +787,9 @@
 		struct net_device *dev = &dev_ne[this_dev];
 		if (dev->priv != NULL) {
 			void *priv = dev->priv;
-			struct pci_dev *idev = (struct pci_dev *)ei_status.priv;
+			struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
 			if (idev)
-				idev->deactivate(idev);
+				pnp_device_detach(idev);
 			free_irq(dev->irq, dev);
 			release_region(dev->base_addr, NE_IO_EXTENT);
 			unregister_netdev(dev);
diff -Nru a/drivers/net/smc-ultra.c b/drivers/net/smc-ultra.c
--- a/drivers/net/smc-ultra.c	Mon Jan 13 19:36:17 2003
+++ b/drivers/net/smc-ultra.c	Mon Jan 13 19:36:17 2003
@@ -550,9 +550,9 @@
 			int ioaddr = dev->base_addr - ULTRA_NIC_OFFSET;
 
 #ifdef __ISAPNP__
-			struct pci_dev *idev = (struct pci_dev *)ei_status.priv;
+			struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
 			if (idev)
-				idev->deactivate(idev);
+				pnp_device_detach(idev);
 #endif
 
 			unregister_netdev(dev);
diff -Nru a/drivers/pnp/card.c b/drivers/pnp/card.c
--- a/drivers/pnp/card.c	Mon Jan 13 19:36:17 2003
+++ b/drivers/pnp/card.c	Mon Jan 13 19:36:17 2003
@@ -22,9 +22,9 @@
 
 LIST_HEAD(pnp_cards);
 
-static const struct pnp_card_id * match_card(struct pnpc_driver *drv, struct pnp_card *card)
+static const struct pnp_card_device_id * match_card(struct pnpc_driver *drv, struct pnp_card *card)
 {
-	const struct pnp_card_id *drv_id = drv->id_table;
+	const struct pnp_card_device_id *drv_id = drv->id_table;
 	while (*drv_id->id){
 		if (compare_pnp_id(card->id,drv_id->id))
 			return drv_id;
@@ -216,18 +216,15 @@
 	return NULL;
 
 found:
-	spin_lock(&pnp_lock);
-	if(dev->status != PNP_READY){
-		spin_unlock(&pnp_lock);
+	if (pnp_device_attach(dev) < 0)
 		return NULL;
-	}
-	dev->status = PNP_ATTACHED;
-	spin_unlock(&pnp_lock);
 	cdrv = to_pnpc_driver(card->dev.driver);
 	if (dev->active == 0) {
 		if (!(cdrv->flags & PNPC_DRIVER_DO_NOT_ACTIVATE)) {
-			if(pnp_activate_dev(dev,NULL)<0)
+			if(pnp_activate_dev(dev,NULL)<0) {
+				pnp_device_detach(dev);
 				return NULL;
+			}
 		}
 	} else {
 		if ((cdrv->flags & PNPC_DRIVER_DO_NOT_ACTIVATE))
@@ -250,10 +247,8 @@
 {
 	spin_lock(&pnp_lock);
 	list_del(&dev->rdev_list);
-	if (dev->status == PNP_ATTACHED)
-		dev->status = PNP_READY;
 	spin_unlock(&pnp_lock);
-	pnp_disable_dev(dev);
+	pnp_device_detach(dev);
 }
 
 static void pnpc_recover_devices(struct pnp_card *card)
@@ -291,7 +286,7 @@
 	int error = 0;
 	struct pnpc_driver *drv = to_pnpc_driver(dev->driver);
 	struct pnp_card *card = to_pnp_card(dev);
-	const struct pnp_card_id *card_id = NULL;
+	const struct pnp_card_device_id *card_id = NULL;
 
 	pnp_dbg("pnp: match found with the PnP card '%s' and the driver '%s'", dev->bus_id,drv->name);
 
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Mon Jan 13 19:36:17 2003
+++ b/drivers/pnp/isapnp/core.c	Mon Jan 13 19:36:17 2003
@@ -102,7 +102,6 @@
 /* some prototypes */
 
 static int isapnp_config_prepare(struct pnp_dev *dev);
-extern struct pnp_protocol isapnp_card_protocol;
 extern struct pnp_protocol isapnp_protocol;
 
 static inline void write_data(unsigned char x)
@@ -1125,7 +1124,7 @@
 	isapnp_build_device_list();
 	cards = 0;
 
-	protocol_for_each_card(&isapnp_card_protocol,card) {
+	protocol_for_each_card(&isapnp_protocol,card) {
 		cards++;
 		if (isapnp_verbose) {
 			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Mon Jan 13 19:36:17 2003
+++ b/include/linux/pnp.h	Mon Jan 13 19:36:17 2003
@@ -189,7 +189,7 @@
 	unsigned long driver_data;	/* data private to the driver */
 };
 
-struct pnp_card_id {
+struct pnp_card_device_id {
 	char id[7];
 	unsigned long driver_data;	/* data private to the driver */
 	struct {
@@ -216,9 +216,9 @@
 struct pnpc_driver {
 	struct list_head node;
 	char *name;
-	const struct pnp_card_id *id_table;
+	const struct pnp_card_device_id *id_table;
 	unsigned int flags;
-	int  (*probe)  (struct pnp_card *card, const struct pnp_card_id *card_id);
+	int  (*probe)  (struct pnp_card *card, const struct pnp_card_device_id *card_id);
 	void (*remove) (struct pnp_card *card);
 	struct device_driver driver;
 };
diff -Nru a/sound/oss/ad1848.c b/sound/oss/ad1848.c
--- a/sound/oss/ad1848.c	Mon Jan 13 19:36:17 2003
+++ b/sound/oss/ad1848.c	Mon Jan 13 19:36:17 2003
@@ -2983,14 +2983,14 @@
 {
 	int err;
 
-	/* Device already active? Let's use it */
-	if(dev->active)
-		return(dev);
+	err = pnp_device_attach(dev);
+	if (err < 0)
+		return(NULL);
 
 	if((err = pnp_activate_dev(dev,NULL)) < 0) {
 		printk(KERN_ERR "ad1848: %s %s config failed (out of resources?)[%d]\n", devname, resname, err);
 
-		pnp_disable_dev(dev);
+		pnp_device_detach(dev);
 
 		return(NULL);
 	}
@@ -3006,12 +3006,11 @@
 	{
 		if((ad1848_dev = activate_dev(ad1848_isapnp_list[slot].name, "ad1848", ad1848_dev)))
 		{
-			get_device(&ad1848_dev->dev);
-			hw_config->io_base 	= ad1848_dev->resource[ad1848_isapnp_list[slot].mss_io].start;
-			hw_config->irq 		= ad1848_dev->irq_resource[ad1848_isapnp_list[slot].irq].start;
-			hw_config->dma 		= ad1848_dev->dma_resource[ad1848_isapnp_list[slot].dma].start;
+			hw_config->io_base 	= pnp_port_start(ad1848_dev, ad1848_isapnp_list[slot].mss_io);
+			hw_config->irq 		= pnp_irq(ad1848_dev, ad1848_isapnp_list[slot].irq);
+			hw_config->dma 		= pnp_dma(ad1848_dev, ad1848_isapnp_list[slot].dma);
 			if(ad1848_isapnp_list[slot].dma2 != -1)
-				hw_config->dma2 = ad1848_dev->dma_resource[ad1848_isapnp_list[slot].dma2].start;
+				hw_config->dma2 = pnp_dma(ad1848_dev, ad1848_isapnp_list[slot].dma2);
 			else
 				hw_config->dma2 = -1;
                         hw_config->card_subtype = ad1848_isapnp_list[slot].type;
@@ -3032,7 +3031,7 @@
 	if(ad1848_init_generic(bus, hw_config, slot)) {
 		/* We got it. */
 
-		printk(KERN_NOTICE "ad1848: ISAPnP reports '%s' at i/o %#x, irq %d, dma %d, %d\n",
+		printk(KERN_NOTICE "ad1848: PnP reports '%s' at i/o %#x, irq %d, dma %d, %d\n",
 		       busname,
 		       hw_config->io_base, hw_config->irq, hw_config->dma,
 		       hw_config->dma2);
@@ -3122,8 +3121,7 @@
 #ifdef CONFIG_PNP
 	if(ad1848_dev){
 		if(audio_activated)
-			pnp_disable_dev(ad1848_dev);
-		put_device(&ad1848_dev->dev);
+			pnp_device_detach(ad1848_dev);
 	}
 #endif
 }
diff -Nru a/sound/oss/cs4232.c b/sound/oss/cs4232.c
--- a/sound/oss/cs4232.c	Mon Jan 13 19:36:17 2003
+++ b/sound/oss/cs4232.c	Mon Jan 13 19:36:17 2003
@@ -357,7 +357,7 @@
 
 /* All cs4232 based cards have the main ad1848 card either as CSC0000 or
  * CSC0100. */
-static const struct pnp_id cs4232_pnp_table[] = {
+static const struct pnp_device_id cs4232_pnp_table[] = {
 	{ .id = "CSC0100", .driver_data = 0 },
 	{ .id = "CSC0000", .driver_data = 0 },
 	/* Guillemot Turtlebeach something appears to be cs4232 compatible
@@ -366,9 +366,9 @@
 	{ .id = ""}
 };
 
-/*MODULE_DEVICE_TABLE(isapnp, isapnp_cs4232_list);*/
+MODULE_DEVICE_TABLE(pnp, cs4232_pnp_table);
 
-static int cs4232_pnp_probe(struct pnp_dev *dev, const struct pnp_id *card_id, const struct pnp_id *dev_id)
+static int cs4232_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct address_info *isapnpcfg;
 
@@ -376,30 +376,31 @@
 	if (!isapnpcfg)
 		return -ENOMEM;
 
-	isapnpcfg->irq		= dev->irq_resource[0].start;
-	isapnpcfg->dma		= dev->dma_resource[0].start;
-	isapnpcfg->dma2		= dev->dma_resource[1].start;
-	isapnpcfg->io_base	= dev->resource[0].start;
+	isapnpcfg->irq		= pnp_irq(dev, 0);
+	isapnpcfg->dma		= pnp_dma(dev, 0);
+	isapnpcfg->dma2		= pnp_dma(dev, 1);
+	isapnpcfg->io_base	= pnp_port_start(dev, 0);
 	if (probe_cs4232(isapnpcfg,TRUE) == 0) {
 		printk(KERN_ERR "cs4232: ISA PnP card found, but not detected?\n");
 		kfree(isapnpcfg);
 		return -ENODEV;
 	}
 	attach_cs4232(isapnpcfg);
-	pci_set_drvdata(dev,isapnpcfg);
+	pnp_set_drvdata(dev,isapnpcfg);
 	return 0;
 }
 
 static void cs4232_pnp_remove(struct pnp_dev *dev)
 {
-	struct address_info *cfg = (struct address_info*) dev->driver_data;
-	if (cfg)
+	struct address_info *cfg = pnp_get_drvdata(dev);
+	if (cfg) {
 		unload_cs4232(cfg);
+		kfree(cfg);
+	}
 }
 
 static struct pnp_driver cs4232_driver = {
 	.name		= "cs4232",
-	.card_id_table	= NULL,
 	.id_table	= cs4232_pnp_table,
 	.probe		= cs4232_pnp_probe,
 	.remove		= cs4232_pnp_remove,

===================================================================


This BitKeeper patch contains the following changesets:
1.945
## Wrapped with gzip_uu ##


begin 664 bkpatch24698
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
2A^<AMD,NX2#[7^3P9]JB(@``
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

