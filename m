Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSDNIPG>; Sun, 14 Apr 2002 04:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311756AbSDNIPF>; Sun, 14 Apr 2002 04:15:05 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:59831 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311752AbSDNIPD>; Sun, 14 Apr 2002 04:15:03 -0400
Date: Sun, 14 Apr 2002 09:59:46 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Fix ad1848 PnP scanning
Message-ID: <Pine.LNX.4.44.0204140958560.6690-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets ad1848 to actually search for pnp cards, this is 
previously with my Yamaha OPL3-SA3

ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
ad1848: No ISAPnP cards found, trying standard ones... <==
opl3sa2: Activated ISA PnP card 0 (active=1)
opl3sa2: chipset version = 0x3
opl3sa2: Found OPL3-SA3 (YMF715B or YMF719B)
<OPL3-SA3> at 0x100 irq 5 dma 1,3
<MS Sound System (CS4231)> at 0xe84 irq 5 dma 1,3
<MPU-401 0.0  Midi interface #1> at 0x300 irq 5
opl3sa2: 1 PnP card(s) found.

And this is after....

ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
ad1848: OPL3-SA2 WSS mode detected
ad1848: ISAPnP reports 'OPL3-SA2 WSS mode' at i/o 0xe80, irq 5, dma 1, 3
opl3sa2: chipset version = 0x3
opl3sa2: Found OPL3-SA3 (YMF715B or YMF719B)
<OPL3-SA3> at 0x100 irq 5 dma 1,3
<MS Sound System (CS4231)> at 0xe84 irq 5 dma 1,3
<MPU-401 0.0  Midi interface #1> at 0x300 irq 5
opl3sa2: 1 PnP card(s) found.

Cheers,
Zwane

--- linux-2.4.19-pre-ac/drivers/sound/ad1848.c.orig	Sat Apr 13 10:45:20 2002
+++ linux-2.4.19-pre-ac/drivers/sound/ad1848.c	Sat Apr 13 12:57:31 2002
@@ -33,6 +33,7 @@
  * Alan Cox		: Added CS4236->4239 identification
  * Daniel T. Cobra	: Alernate config/mixer for later chips
  * Alan Cox		: Merged chip idents and config code
+ * Zwane Mwaikambo	: Fix ISA PnP scan
  *
  * TODO
  *		APM save restore assist code on IBM thinkpad
@@ -3003,11 +3004,10 @@
 	return(dev);
 }
 
-static struct pci_dev *ad1848_init_generic(struct pci_bus *bus, struct address_info *hw_config, int slot)
+static struct pci_dev *ad1848_init_generic(struct pci_dev *dev, struct address_info *hw_config, int slot)
 {
-
-	/* Configure Audio device */
-	if((ad1848_dev = isapnp_find_dev(bus, ad1848_isapnp_list[slot].vendor, ad1848_isapnp_list[slot].function, NULL)))
+	/* Configure Audio device, point ad1848_dev to device found */
+	if((ad1848_dev = dev))
 	{
 		int ret;
 		ret = ad1848_dev->prepare(ad1848_dev);
@@ -3038,25 +3038,25 @@
 	return(ad1848_dev);
 }
 
-static int __init ad1848_isapnp_init(struct address_info *hw_config, struct pci_bus *bus, int slot)
+static int __init ad1848_isapnp_init(struct address_info *hw_config, struct pci_dev *dev, int slot)
 {
-	char *busname = bus->name[0] ? bus->name : ad1848_isapnp_list[slot].name;
+	char *devname = dev->name[0] ? dev->name : ad1848_isapnp_list[slot].name;
 
-	printk(KERN_INFO "ad1848: %s detected\n", busname);
+	printk(KERN_INFO "ad1848: %s detected\n", devname);
 
 	/* Initialize this baby. */
 
-	if(ad1848_init_generic(bus, hw_config, slot)) {
+	if(ad1848_init_generic(dev, hw_config, slot)) {
 		/* We got it. */
 
 		printk(KERN_NOTICE "ad1848: ISAPnP reports '%s' at i/o %#x, irq %d, dma %d, %d\n",
-		       busname,
+		       devname,
 		       hw_config->io_base, hw_config->irq, hw_config->dma,
 		       hw_config->dma2);
 		return 1;
 	}
 	else
-		printk(KERN_INFO "ad1848: Failed to initialize %s\n", busname);
+		printk(KERN_INFO "ad1848: Failed to initialize %s\n", devname);
 
 	return 0;
 }
@@ -3080,14 +3080,14 @@
 		i = isapnpjump;
 	first = 0;
 	while(ad1848_isapnp_list[i].card_vendor != 0) {
-		static struct pci_bus *bus = NULL;
-
-		while ((bus = isapnp_find_card(
-				ad1848_isapnp_list[i].card_vendor,
-				ad1848_isapnp_list[i].card_device,
-				bus))) {
+		static struct pci_dev *dev = NULL;
 
-			if(ad1848_isapnp_init(hw_config, bus, i)) {
+		while ((dev = isapnp_find_dev(NULL,
+				ad1848_isapnp_list[i].vendor,
+				ad1848_isapnp_list[i].function,
+				NULL))) {
+			
+			if(ad1848_isapnp_init(hw_config, dev, i)) {
 				isapnpjump = i; /* start next search from here */
 				return 0;
 			}
-- 
http://function.linuxpower.ca
		

