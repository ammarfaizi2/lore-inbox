Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTLWXfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTLWXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:35:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:33686 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262868AbTLWXfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:35:25 -0500
Subject: Re: aacraid issues
From: Mark Haverkamp <markh@osdl.org>
To: Yaroslav Klyukin <skintwin@mail.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FE8CD8D.6090303@mail.ru>
References: <3FE8CD8D.6090303@mail.ru>
Content-Type: text/plain
Message-Id: <1072222521.25288.3.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 23 Dec 2003 15:35:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 15:19, Yaroslav Klyukin wrote:
> I have very strange aacraid behavior:
> First of all, I know, that aacraid support is experimental, but maybe 
> the issue is related to something else in the kernel.
> 
> I have AMD Opteron system with 10 scsi disks, connected to Adaptec 2200S 
> controller, constituting about 1.2TB in total.
> 
> I can boot with 2.4.22 kernel, compiled for Xeon, into RedHat 9
> (32 bit mode). aacraid version 1.1.2. The raid works great.
> 
> Then I boot into SuSE Linux 9 for the Opterons, with 2.4.23 kernel.
> aacraid version 1.1-3.
> 
> Seems to work, but when I try to access blocks close to the end of the 
> RAID, I am getting I/O errors.
> 
> Any ideas?
> Where can I get the latest patches for the aacraid driver?
> 
> Just tried 2.6.0 kernel with patches for Opteron, but as soon as it 
> starts working with Adaptec controller, it crashes miserably... :-(
> 

Try this, someone else with a 2200 had a similar problem that this patch
fixed. It will apply to 2.6.0.




===== drivers/scsi/aacraid/aachba.c 1.20 vs edited =====
--- 1.20/drivers/scsi/aacraid/aachba.c	Fri May  2 12:30:49 2003
+++ edited/drivers/scsi/aacraid/aachba.c	Wed Dec  3 15:10:22 2003
@@ -525,6 +525,14 @@
 	if(dev->pae_support != 0) {
 		printk(KERN_INFO"%s%d: 64 Bit PAE enabled\n", dev->name, dev->id);
 		pci_set_dma_mask(dev->pdev, (dma_addr_t)0xFFFFFFFFFFFFFFFFULL);
+	} else {
+		/* 
+		 * Reset if Quirk 31 was used, since data 
+		 * transfers are ok.
+		 */
+		if (pci_set_dma_mask(dev->pdev, 0xFFFFFFFFULL)) {
+			printk(KERN_INFO"aacraid: Can't reset DMA mask.\n");
+		}
 	}
 
 	fib_complete(fibptr);
===== drivers/scsi/aacraid/aacraid.h 1.9 vs edited =====
--- 1.9/drivers/scsi/aacraid/aacraid.h	Wed Oct 22 02:52:43 2003
+++ edited/drivers/scsi/aacraid/aacraid.h	Wed Dec  3 15:21:48 2003
@@ -529,6 +529,8 @@
 	char *	vname;
 	char *	model;
 	u16	channels;
+	int	quirks;
+#define AAC_QUIRK_31BIT         1
 };
 
 /*
===== drivers/scsi/aacraid/linit.c 1.22 vs edited =====
--- 1.22/drivers/scsi/aacraid/linit.c	Tue Aug 26 09:25:41 2003
+++ edited/drivers/scsi/aacraid/linit.c	Wed Dec  3 15:22:42 2003
@@ -86,36 +86,47 @@
  * for the card.  At that time we can remove the channels from here
  */
 static struct aac_driver_ident aac_drivers[] = {
-	{ 0x1028, 0x0001, 0x1028, 0x0001, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 2/Si */
-	{ 0x1028, 0x0002, 0x1028, 0x0002, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 3/Di */
-	{ 0x1028, 0x0003, 0x1028, 0x0003, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 3/Si */
-	{ 0x1028, 0x0004, 0x1028, 0x00d0, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 3/Si */
-	{ 0x1028, 0x0002, 0x1028, 0x00d1, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 3/Di */
-	{ 0x1028, 0x0002, 0x1028, 0x00d9, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 3/Di */
-	{ 0x1028, 0x000a, 0x1028, 0x0106, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 3/Di */
-	{ 0x1028, 0x000a, 0x1028, 0x011b, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 3/Di */
-	{ 0x1028, 0x000a, 0x1028, 0x0121, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2 }, /* PERC 3/Di */
-	{ 0x9005, 0x0283, 0x9005, 0x0283, aac_rx_init, "aacraid",  "ADAPTEC ", "catapult        ", 2 }, /* catapult*/
-	{ 0x9005, 0x0284, 0x9005, 0x0284, aac_rx_init, "aacraid",  "ADAPTEC ", "tomcat          ", 2 }, /* tomcat*/
-	{ 0x9005, 0x0285, 0x9005, 0x0286, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 2120S   ", 1 }, /* Adaptec 2120S (Crusader)*/
-	{ 0x9005, 0x0285, 0x9005, 0x0285, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 2200S   ", 2 }, /* Adaptec 2200S (Vulcan)*/
-	{ 0x9005, 0x0285, 0x9005, 0x0287, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 2200S   ", 2 }, /* Adaptec 2200S (Vulcan-2m)*/
-	{ 0x9005, 0x0285, 0x17aa, 0x0286, aac_rx_init, "aacraid",  "Legend  ", "Legend S220     ", 1 }, /* Legend S220*/
-	{ 0x9005, 0x0285, 0x17aa, 0x0287, aac_rx_init, "aacraid",  "Legend  ", "Legend S230     ", 2 }, /* Legend S230*/
-
-	{ 0x9005, 0x0285, 0x9005, 0x0288, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 3230S   ", 2 }, /* Adaptec 3230S (Harrier)*/
-	{ 0x9005, 0x0285, 0x9005, 0x0289, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 3240S   ", 2 }, /* Adaptec 3240S (Tornado)*/
-	{ 0x9005, 0x0285, 0x9005, 0x028a, aac_rx_init, "aacraid",  "ADAPTEC ", "ASR-2020S PCI-X ", 2 }, /* ASR-2020S PCI-X ZCR (Skyhawk)*/
-	{ 0x9005, 0x0285, 0x9005, 0x028b, aac_rx_init, "aacraid",  "ADAPTEC ", "ASR-2020S PCI-X ", 2 }, /* ASR-2020S SO-DIMM PCI-X ZCR(Terminator)*/
-	{ 0x9005, 0x0285, 0x9005, 0x0290, aac_rx_init, "aacraid",  "ADAPTEC ", "AAR-2410SA SATA ", 2 }, /* AAR-2410SA PCI SATA 4ch (Jaguar II)*/
-	{ 0x9005, 0x0250, 0x1014, 0x0279, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec         ", 2 }, /* (Marco)*/
-	{ 0x9005, 0x0250, 0x1014, 0x028c, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec         ", 2 }, /* (Sebring)*/
+	{ 0x1028, 0x0001, 0x1028, 0x0001, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2, AAC_QUIRK_31BIT }, /* PERC 2/Si (Iguana/PERC2Si) */
+	{ 0x1028, 0x0002, 0x1028, 0x0002, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2, AAC_QUIRK_31BIT }, /* PERC 3/Di (Opal/PERC3Di) */
+	{ 0x1028, 0x0003, 0x1028, 0x0003, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2, AAC_QUIRK_31BIT }, /* PERC 3/Si (SlimFast/PERC3Si */
+	{ 0x1028, 0x0004, 0x1028, 0x00d0, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2, AAC_QUIRK_31BIT }, /* PERC 3/Di (Iguana FlipChip/PERC3DiF */
+	{ 0x1028, 0x0002, 0x1028, 0x00d1, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2, AAC_QUIRK_31BIT }, /* PERC 3/Di (Viper/PERC3DiV) */
+	{ 0x1028, 0x0002, 0x1028, 0x00d9, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2, AAC_QUIRK_31BIT }, /* PERC 3/Di (Lexus/PERC3DiL) */
+	{ 0x1028, 0x000a, 0x1028, 0x0106, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 1, AAC_QUIRK_31BIT }, /* PERC 3/Di (Jaguar/PERC3DiJ) */
+	{ 0x1028, 0x000a, 0x1028, 0x011b, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2, AAC_QUIRK_31BIT }, /* PERC 3/Di (Dagger/PERC3DiD) */
+	{ 0x1028, 0x000a, 0x1028, 0x0121, aac_rx_init, "percraid", "DELL    ", "PERCRAID        ", 2, AAC_QUIRK_31BIT }, /* PERC 3/Di (Boxster/PERC3DiB) */
+	{ 0x9005, 0x0283, 0x9005, 0x0283, aac_rx_init, "aacraid",  "ADAPTEC ", "catapult        ", 2, AAC_QUIRK_31BIT }, /* catapult */
+	{ 0x9005, 0x0284, 0x9005, 0x0284, aac_rx_init, "aacraid",  "ADAPTEC ", "tomcat          ", 2, AAC_QUIRK_31BIT }, /* tomcat */
+	{ 0x9005, 0x0285, 0x9005, 0x0286, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 2120S   ", 1, AAC_QUIRK_31BIT }, /* Adaptec 2120S (Crusader) */
+	{ 0x9005, 0x0285, 0x9005, 0x0285, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 2200S   ", 2, AAC_QUIRK_31BIT }, /* Adaptec 2200S (Vulcan) */
+	{ 0x9005, 0x0285, 0x9005, 0x0287, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 2200S   ", 2, AAC_QUIRK_31BIT }, /* Adaptec 2200S (Vulcan-2m) */
+	{ 0x9005, 0x0285, 0x17aa, 0x0286, aac_rx_init, "aacraid",  "Legend  ", "Legend S220     ", 1, AAC_QUIRK_31BIT }, /* Legend S220 (Legend Crusader) */
+	{ 0x9005, 0x0285, 0x17aa, 0x0287, aac_rx_init, "aacraid",  "Legend  ", "Legend S230     ", 2, AAC_QUIRK_31BIT }, /* Legend S230 (Legend Vulcan) */
+
+	{ 0x9005, 0x0285, 0x9005, 0x0288, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 3230S   ", 2 }, /* Adaptec 3230S (Harrier) */
+	{ 0x9005, 0x0285, 0x9005, 0x0289, aac_rx_init, "aacraid",  "ADAPTEC ", "Adaptec 3240S   ", 2 }, /* Adaptec 3240S (Tornado) */
+	{ 0x9005, 0x0285, 0x9005, 0x028a, aac_rx_init, "aacraid",  "ADAPTEC ", "ASR-2020S PCI-X ", 2 }, /* ASR-2020S PCI-X ZCR (Skyhawk) */
+	{ 0x9005, 0x0285, 0x9005, 0x028b, aac_rx_init, "aacraid",  "ADAPTEC ", "ASR-2020S PCI-X ", 2 }, /* ASR-2020S SO-DIMM PCI-X ZCR (Terminator) */
+/*	{ 0x9005, 0x0286, 0x9005, 0x028c, aac_rx_init, "aacraid",  "ADAPTEC ", "ASR-2230S PCI-X ", 2 }, */ /* ASR-2230S PCI-X (Lancer pre-production) */
+	{ 0x9005, 0x0285, 0x9005, 0x0290, aac_rx_init, "aacraid",  "ADAPTEC ", "AAR-2410SA SATA ", 1 }, /* AAR-2410SA PCI SATA 4ch (Jaguar II) */
+	{ 0x9005, 0x0285, 0x1028, 0x0291, aac_rx_init, "aacraid",  "DELL    ", "CERC SR2        ", 1 }, /* CERC SATA RAID 2 PCI SATA 6ch (DellCorsair) */
+	{ 0x9005, 0x0285, 0x9005, 0x0292, aac_rx_init, "aacraid",  "ADAPTEC ", "AAR-2810SA SATA ", 1 }, /* AAR-2810SA PCI SATA 8ch (Corsair-8) */
+	{ 0x9005, 0x0285, 0x9005, 0x0293, aac_rx_init, "aacraid",  "ADAPTEC ", "AAR-21610SA SATA", 1 }, /* AAR-21610SA PCI SATA 16ch (Corsair-16) */
+	{ 0x9005, 0x0285, 0x9005, 0x0294, aac_rx_init, "aacraid",  "ADAPTEC ", "SO-DIMM SATA ZCR", 1 }, /* ESD SO-DIMM PCI-X SATA ZCR (Prowler) */
+	{ 0x9005, 0x0285, 0x0E11, 0x0295, aac_rx_init, "aacraid",  "ADAPTEC ", "SATA 6Channel   ", 1 }, /* SATA 6Ch (Bearcat) */
 
-	{ 0x9005, 0x0285, 0x1028, 0x0287, aac_rx_init, "percraid", "DELL    ", "PERC 320/DC     ", 2 }, /* Perc 320/DC*/
+	{ 0x9005, 0x0285, 0x1028, 0x0287, aac_rx_init, "percraid", "DELL    ", "PERC 320/DC     ", 2, AAC_QUIRK_31BIT }, /* Perc 320/DC*/
 	{ 0x1011, 0x0046, 0x9005, 0x0365, aac_sa_init, "aacraid",  "ADAPTEC ", "Adaptec 5400S   ", 4 }, /* Adaptec 5400S (Mustang)*/
 	{ 0x1011, 0x0046, 0x9005, 0x0364, aac_sa_init, "aacraid",  "ADAPTEC ", "AAC-364         ", 4 }, /* Adaptec 5400S (Mustang)*/
-	{ 0x1011, 0x0046, 0x9005, 0x1364, aac_sa_init, "percraid", "DELL    ", "PERCRAID        ", 4 }, /* Dell PERC2 "Quad Channel" */
-	{ 0x1011, 0x0046, 0x103c, 0x10c2, aac_sa_init, "hpnraid",  "HP      ", "NetRAID         ", 4 }  /* HP NetRAID-4M */
+	{ 0x1011, 0x0046, 0x9005, 0x1364, aac_sa_init, "percraid", "DELL    ", "PERCRAID        ", 4, AAC_QUIRK_31BIT }, /* Dell PERC2/QC */
+	{ 0x1011, 0x0046, 0x103c, 0x10c2, aac_sa_init, "hpnraid",  "HP      ", "NetRAID         ", 4 }, /* HP NetRAID-4M */
+
+	{ 0x9005, 0x0285, 0x1028, PCI_ANY_ID,
+					  aac_rx_init, "aacraid",  "DELL    ", "RAID            ", 2, AAC_QUIRK_31BIT }, /* Dell Catchall */
+	{ 0x9005, 0x0285, 0x17aa, PCI_ANY_ID,
+					  aac_rx_init, "aacraid",  "Legend  ", "RAID            ", 2, AAC_QUIRK_31BIT }, /* Legend Catchall */
+	{ 0x9005, 0x0285, PCI_ANY_ID, PCI_ANY_ID,
+					  aac_rx_init, "aacraid",  "ADAPTEC ", "RAID            ", 2, AAC_QUIRK_31BIT }, /* Adaptec Catch All */
 };
 
 #define NUM_AACTYPES	(sizeof(aac_drivers) / sizeof(struct aac_driver_ident))
@@ -174,6 +185,7 @@
 	struct aac_dev *aac;
 	struct fsa_scsi_hba *fsa_dev_ptr;
 	char *name = NULL;
+	int ret;
 	
 	printk(KERN_INFO "Red Hat/Adaptec aacraid driver (%s %s)\n", AAC_DRIVER_VERSION, AAC_DRIVER_BUILD_DATE);
 
@@ -194,7 +206,15 @@
 			if (pci_enable_device(dev))
 				continue;
 			pci_set_master(dev);
-			pci_set_dma_mask(dev, 0xFFFFFFFFULL);
+			if (aac_drivers[index].quirks & AAC_QUIRK_31BIT)
+				ret = pci_set_dma_mask(dev, 0x7FFFFFFFULL);
+			else
+				ret = pci_set_dma_mask(dev, 0xFFFFFFFFULL);
+
+			if (ret) {
+				printk(KERN_WARNING "aacraid: Can't set DMA mask.\n");
+				continue;
+			}
 
 			if((dev->subsystem_vendor != aac_drivers[index].subsystem_vendor) || 
 			   (dev->subsystem_device != aac_drivers[index].subsystem_device))

-- 
Mark Haverkamp <markh@osdl.org>

