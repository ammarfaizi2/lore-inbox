Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283006AbRLXWq0>; Mon, 24 Dec 2001 17:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283234AbRLXWqR>; Mon, 24 Dec 2001 17:46:17 -0500
Received: from tourian.nerim.net ([62.4.16.79]:8201 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S283006AbRLXWqG>;
	Mon, 24 Dec 2001 17:46:06 -0500
Message-ID: <3C27B02B.7070804@free.fr>
Date: Mon, 24 Dec 2001 23:46:03 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011220
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniela Engert <dani@ngrt.de>
Cc: linux-kernel@vger.kernel.org, Chris Shutters <cshutters@ebiz-tech.com>
Subject: [RFC] SIS5513 ATA100 support
Content-Type: multipart/mixed;
 boundary="------------000807040102030203090000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000807040102030203090000
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Daniela,

here's my first patch to sis5513.c : this should set the correct timings 
for ATA100 chips (and hopefully say goodbye to heavy fs corruption in 
UDMA modes).

It compiles cleanly but is **not yet tested**. I'm currently waiting for 
~30GB to move from my test drive to a safe location (gory details: 
source DMA drive, destination PIO drive, accross NFS on a 100kKiB :-P 
full-duplex Ethernet).

If there's an obvious mistake please tell me (I've a couple of hours to 
wait for the transfer before testing with and without the patch on a 
"blank" ATA-100 drive).

If others want to have a look or even (I repeat **not yet tested**) try 
this code **on backuped data** they're more than welcome.

If you want to have a quick look at the whole new sis5513.c :

http://gyver.homeip.net/sis5513.c



I'm now on to a more general sis5513.c cleanup :

1/ There is some suspicious code (sis_get_info seems broken to me from 
ATA66 on and config_art_rwp_pio is not yet ATA100-chip friendly)
2/ I'll probably move to per chip types funcs as the current generic 
ones become uglier and uglier at each new sis chipset).


LB

--------------000807040102030203090000
Content-Type: text/plain;
 name="sis.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis.patch"

--- linux-orig/drivers/ide/sis5513.c	Fri Sep  7 18:28:38 2001
+++ linux/drivers/ide/sis5513.c	Mon Dec 24 22:46:21 2001
@@ -32,11 +32,13 @@
 #define SIS5513_DEBUG_DRIVE_INFO	0
 
 static struct pci_dev *host_dev = NULL;
+static unsigned int capabilities = 0;
 
 #define SIS5513_FLAG_ATA_00		0x00000000
 #define SIS5513_FLAG_ATA_16		0x00000001
 #define SIS5513_FLAG_ATA_33		0x00000002
 #define SIS5513_FLAG_ATA_66		0x00000004
+#define SIS5513_FLAG_ATA_100		0x00000008
 #define SIS5513_FLAG_LATENCY		0x00000010
 
 static const struct {
@@ -48,15 +50,15 @@
 	{ "SiS540",	PCI_DEVICE_ID_SI_540,	SIS5513_FLAG_ATA_66, },
 	{ "SiS620",	PCI_DEVICE_ID_SI_620,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
 	{ "SiS630",	PCI_DEVICE_ID_SI_630,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS635",	PCI_DEVICE_ID_SI_635,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS635",	PCI_DEVICE_ID_SI_635,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
 	{ "SiS640",	PCI_DEVICE_ID_SI_640,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS645",	PCI_DEVICE_ID_SI_645,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS650",	PCI_DEVICE_ID_SI_650,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS730",	PCI_DEVICE_ID_SI_730,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS735",	PCI_DEVICE_ID_SI_735,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS740",	PCI_DEVICE_ID_SI_740,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS745",	PCI_DEVICE_ID_SI_745,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS750",	PCI_DEVICE_ID_SI_750,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS645",	PCI_DEVICE_ID_SI_645,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS650",	PCI_DEVICE_ID_SI_650,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS730",	PCI_DEVICE_ID_SI_730,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS735",	PCI_DEVICE_ID_SI_735,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS740",	PCI_DEVICE_ID_SI_740,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS745",	PCI_DEVICE_ID_SI_745,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS750",	PCI_DEVICE_ID_SI_750,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
 	{ "SiS5591",	PCI_DEVICE_ID_SI_5591,	SIS5513_FLAG_ATA_33, },
 	{ "SiS5597",	PCI_DEVICE_ID_SI_5597,	SIS5513_FLAG_ATA_33, },
 	{ "SiS5600",	PCI_DEVICE_ID_SI_5600,	SIS5513_FLAG_ATA_33, },
@@ -229,6 +231,7 @@
 byte sis_proc = 0;
 extern char *ide_xfer_verbose (byte xfer_rate);
 
+/* Enables Prefetch and Postwrite on drive */
 static void config_drive_art_rwp (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -298,8 +301,8 @@
 	 * Do a blanket clear of active and recovery timings.
 	 */
 
-	test1 &= ~0x07;
-	test2 &= ~0x0F;
+	test1 &= ~0x0F;
+	test2 &= ~0x07;
 
 	switch(timing) {
 		case 4:		test1 |= 0x01; test2 |= 0x03; break;
@@ -379,6 +382,7 @@
 	pci_read_config_byte(dev, drive_pci, &test1);
 	pci_read_config_byte(dev, drive_pci|0x01, &test2);
 
+	/* If not an UDMA mode switch off udma bit */
 	if ((speed <= XFER_MW_DMA_2) && (test2 & 0x80)) {
 		pci_write_config_byte(dev, drive_pci|0x01, test2 & ~0x80);
 		pci_read_config_byte(dev, drive_pci|0x01, &test2);
@@ -386,7 +390,31 @@
 		pci_write_config_byte(dev, drive_pci|0x01, test2 & ~unmask);
 	}
 
-	switch(speed) {
+	if (capabilities & SIS5513_FLAG_ATA_100) {
+		switch(speed) {
+#ifdef CONFIG_BLK_DEV_IDEDMA
+		case XFER_UDMA_5: mask = 0x01; break;
+		case XFER_UDMA_4: mask = 0x02; break;
+		case XFER_UDMA_3: mask = 0x04; break;
+		case XFER_UDMA_2: mask = 0x05; break;
+		case XFER_UDMA_1: mask = 0x07; break;
+		case XFER_UDMA_0: mask = 0x0B; break;
+		case XFER_MW_DMA_2:
+		case XFER_MW_DMA_1:
+		case XFER_MW_DMA_0:
+		case XFER_SW_DMA_2:
+		case XFER_SW_DMA_1:
+		case XFER_SW_DMA_0: break;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+		case XFER_PIO_4: return((int) config_chipset_for_pio(drive, 4));
+		case XFER_PIO_3: return((int) config_chipset_for_pio(drive, 3));
+		case XFER_PIO_2: return((int) config_chipset_for_pio(drive, 2));
+		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
+		case XFER_PIO_0:
+		default:	 return((int) config_chipset_for_pio(drive, 0));
+		}
+	} else {
+		switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 		case XFER_UDMA_5: mask = 0x80; break;
 		case XFER_UDMA_4: mask = 0x90; break;
@@ -407,6 +435,7 @@
 		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
 		case XFER_PIO_0:
 		default:	 return((int) config_chipset_for_pio(drive, 0));
+		}
 	}
 
 	if (speed > XFER_MW_DMA_2)
@@ -583,6 +612,7 @@
 			continue;
 
 		host_dev = host;
+		capabilities = SiSHostChipInfo[i].flags;
 		printk(SiSHostChipInfo[i].name);
 		printk("\n");
 		if (SiSHostChipInfo[i].flags & SIS5513_FLAG_LATENCY) {

--------------000807040102030203090000--

