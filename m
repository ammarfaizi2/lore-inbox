Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTFGRn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 13:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTFGRn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 13:43:26 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:8577 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S263309AbTFGRnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 13:43:16 -0400
Date: Sat, 7 Jun 2003 18:56:37 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Alan Cox <alan@redhat.com>
Cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, andre@linux-ide.org
Subject: [PATCH][RFC] Add support for Adaptec 1210SA (was: Re: SiI3112 (Adaptec 1210SA): no devices)
Message-ID: <20030607175637.GA1266@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Alan Cox <alan@redhat.com>, Samuel Flory <sflory@rackable.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	andre@linux-ide.org
References: <20030605211526.GE1542@carfax.org.uk> <200306052207.h55M74Q26865@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <200306052207.h55M74Q26865@devserv.devel.redhat.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2003 at 06:07:04PM -0400, Alan Cox wrote:
> > just couldn't find _any_ other SiI3112 SATA card on the market in this
> > country. I don't run Red Hat or SuSE, and particularly not their
> > kernels -- (I normally run Alan's kernels). Does this mean that I've
> > bought a pig in a poke?
> 
> If its a standard SI3112 series device with a different device ID then it
> ought to work just by adding the ids to the driver.

   Like the patch below?

   I've assumed that it's exactly like a SiI3112 in making these
changes. The kernel now recognises the device, and I can (e.g.) run
cfdisk. However, any read or write on the disk causes huge delays, and
these:

Jun  7 17:55:47 src@vlad kernel: hda: dma_timer_expiry: dma status == 0x24
Jun  7 17:55:57 src@vlad kernel: hda: DMA interrupt recovery
Jun  7 17:55:57 src@vlad kernel: hda: lost interrupt

   I don't have the knowledge to determine whether this is similar to
the SiI3112 problems people have been having elsewhere, or if it's a
different cause due to something funny that Adaptec did when building
the controller.

   Note, however, that the 'hdparm -X66 -d1' doesn't fix the lost
interrupt problem, nor does the 'echo "max_kb_per_request:15" >
/proc/ide/hde/settings'. I haven't tried Andre's suggestion of
drive->id->hwconfig |= 0x6000, because it's not clear to me where in
the code the line should go.

   After running the hdparm command to set UDMA, I can get the
following output:

vlad:/dev/ide# hdparm -i /dev/ide/host0/bus0/target0/lun0/disc 

/dev/ide/host0/bus0/target0/lun0/disc:

 Model=ST3120026AS, FwRev=3.05, SerialNo=3JT059GT
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 *mdma2 
 UDMA modes: udma0 udma1 udma2 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6

   FWIW, the hard drive is a 120Gb Seagate Barracuda V. The machine
I'm running all this on is a K6-2/500, and I don't have APIC or ACPI
support built into this kernel.

   Hugo.


diff -ur -X patch-help/ignore linux-2.4.21-rc7-ac1/drivers/ide/pci/siimage.c linux-test/drivers/ide/pci/siimage.c
--- linux-2.4.21-rc7-ac1/drivers/ide/pci/siimage.c	2003-06-05 12:02:22.000000000 +0100
+++ linux-test/drivers/ide/pci/siimage.c	2003-06-07 13:26:59.000000000 +0100
@@ -172,6 +172,7 @@
 
 	switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_SII_3112:
+		case PCI_DEVICE_ID_ADAPTEC_1210SA:
 			/* FIXME: should we pick UDMA100 for
 			   Maxtor devices in case its on a PATA adapter ? */
 			return 4;
@@ -367,7 +368,8 @@
 	ultra &= ~0x3F;
 	scsc = ((scsc & 0x30) == 0x00) ? 0 : 1;
 
-	scsc = (hwif->pci_dev->device == PCI_DEVICE_ID_SII_3112) ? 1 : scsc;
+	scsc = (hwif->pci_dev->device == PCI_DEVICE_ID_SII_3112 
+		|| hwif->pci_dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA) ? 1 : scsc;
 
 	switch(speed) {
 		case XFER_PIO_4:
@@ -674,7 +676,8 @@
 	if (drive->media != ide_disk)
 		return;
 
-	if (HWIF(drive)->pci_dev->device == PCI_DEVICE_ID_SII_3112) {
+	if (HWIF(drive)->pci_dev->device == PCI_DEVICE_ID_SII_3112
+		|| HWIF(drive)->pci_dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA) {
 		drive->special.b.set_geometry = 0;
 		drive->special.b.recalibrate = 0;
 	}
@@ -734,7 +737,8 @@
  
 static void proc_reports_siimage (struct pci_dev *dev, u8 clocking, const char *name)
 {
-	if (dev->device == PCI_DEVICE_ID_SII_3112)
+	if (dev->device == PCI_DEVICE_ID_SII_3112
+		|| dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA)
 		goto sata_skip;
 
 	printk(KERN_INFO "%s: BASE CLOCK ", name);
@@ -800,7 +804,8 @@
 	pci_set_drvdata(dev, ioaddr);
 	addr = (unsigned long) ioaddr;
 
-	if (dev->device == PCI_DEVICE_ID_SII_3112) {
+	if (dev->device == PCI_DEVICE_ID_SII_3112
+		|| dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA) {
 		writel(0, addr + 0x148);
 		writel(0, addr + 0x1C8);
 	}
@@ -838,7 +843,8 @@
 	writel(0x43924392, addr + 0xE8);
 	writel(0x40094009, addr + 0xEC);
 
-	if (dev->device == PCI_DEVICE_ID_SII_3112) {
+	if (dev->device == PCI_DEVICE_ID_SII_3112
+		|| dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA) {
 		writel(0xFFFF0000, addr + 0x108);
 		writel(0xFFFF0000, addr + 0x188);
 		writel(0x00680000, addr + 0x148);
@@ -976,7 +982,8 @@
 
 	hw.io_ports[IDE_IRQ_OFFSET]	= 0;
 
-        if (dev->device == PCI_DEVICE_ID_SII_3112) {
+        if (dev->device == PCI_DEVICE_ID_SII_3112
+			|| dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA) {
         	base = (unsigned long) addr;
         	if(ch)
         		base += 0x80;
@@ -993,7 +1000,8 @@
 	memcpy(&hwif->hw, &hw, sizeof(hw));
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
 
-	if (hwif->pci_dev->device == PCI_DEVICE_ID_SII_3112) {
+	if (hwif->pci_dev->device == PCI_DEVICE_ID_SII_3112
+		|| hwif->pci_dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA) {
 		memcpy(hwif->sata_scr, hwif->hw.sata_scr, sizeof(hwif->hw.sata_scr));
 		memcpy(hwif->sata_misc, hwif->hw.sata_misc, sizeof(hwif->hw.sata_misc));
 	}
@@ -1035,7 +1043,8 @@
 	hwif->hwif_data = 0;
 
 	hwif->rqsize = 128;
-	if (dev->device == PCI_DEVICE_ID_SII_3112 && !class_rev)
+	if ((dev->device == PCI_DEVICE_ID_SII_3112
+		 || dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA) && !class_rev)
 		hwif->rqsize = 16;
 
 	if (pci_get_drvdata(dev) == NULL)
@@ -1082,7 +1091,8 @@
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 
-	if(hwif->pci_dev->device == PCI_DEVICE_ID_SII_3112)
+	if(hwif->pci_dev->device == PCI_DEVICE_ID_SII_3112
+		|| hwif->pci_dev->device == PCI_DEVICE_ID_ADAPTEC_1210SA)
 		hwif->busproc   = &siimage_busproc;
 
 	if (!hwif->dma_base) {
@@ -1095,7 +1105,8 @@
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
 
-	if (hwif->pci_dev->device != PCI_DEVICE_ID_SII_3112)
+	if (hwif->pci_dev->device != PCI_DEVICE_ID_SII_3112
+		&& hwif->pci_dev->device != PCI_DEVICE_ID_ADAPTEC_1210SA)
 		hwif->atapi_dma = 1;
 
 	hwif->ide_dma_check = &siimage_config_drive_for_dma;
@@ -1159,6 +1170,7 @@
 static struct pci_device_id siimage_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_ADAPTEC_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 	{ 0, },
 };
 
diff -ur -X patch-help/ignore linux-2.4.21-rc7-ac1/drivers/ide/pci/siimage.h linux-test/drivers/ide/pci/siimage.h
--- linux-2.4.21-rc7-ac1/drivers/ide/pci/siimage.h	2003-06-06 09:08:57.000000000 +0100
+++ linux-test/drivers/ide/pci/siimage.h	2003-06-07 13:37:41.000000000 +0100
@@ -73,6 +73,19 @@
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
+	},{	/* 2 */
+		.vendor		= PCI_VENDOR_ID_CMD,
+		.device		= PCI_DEVICE_ID_ADAPTEC_1210SA,
+		.name		= "Adaptec AAR-1210SA",
+		.init_chipset	= init_chipset_siimage,
+		.init_iops	= init_iops_siimage,
+		.init_hwif	= init_hwif_siimage,
+		.init_dma	= init_dma_siimage,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
 	},{
 		.vendor		= 0,
 		.device		= 0,
diff -ur -X patch-help/ignore linux-2.4.21-rc7-ac1/include/linux/pci_ids.h linux-test/include/linux/pci_ids.h
--- linux-2.4.21-rc7-ac1/include/linux/pci_ids.h	2003-06-05 12:02:27.000000000 +0100
+++ linux-test/include/linux/pci_ids.h	2003-06-06 08:51:42.000000000 +0100
@@ -761,6 +761,7 @@
 #define PCI_DEVICE_ID_SUN_HUMMINGBIRD	0xa001
 
 #define PCI_VENDOR_ID_CMD		0x1095
+#define PCI_DEVICE_ID_ADAPTEC_1210SA	0x0240
 #define PCI_DEVICE_ID_CMD_640		0x0640
 #define PCI_DEVICE_ID_CMD_643		0x0643
 #define PCI_DEVICE_ID_CMD_646		0x0646


-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
       --- Never underestimate the bandwidth of a Volvo filled ---       
                           with backup tapes.                            

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+4idVssJ7whwzWGARAsFSAJ9MbpfR6AvVrDVD0nSBijvRTY3ARwCgi8/w
nLM39bHfa4qifk8u+r0p1jk=
=fjrY
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
