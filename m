Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSCaAVy>; Sat, 30 Mar 2002 19:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSCaAVp>; Sat, 30 Mar 2002 19:21:45 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:64641 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S293632AbSCaAV1>;
	Sat, 30 Mar 2002 19:21:27 -0500
Message-ID: <3CA6563D.CF452358@colorfullife.com>
Date: Sun, 31 Mar 2002 01:20:13 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre1-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PDC20269 error handling problem
In-Reply-To: <E16rMsL-0003OO-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------588E74E2D795C3D705E3D07A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------588E74E2D795C3D705E3D07A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch "fixes" the bug. How bad sectors cause just sector
errors, no more system hangs. The patch is not perfect, but definitively
an improvement:

<<<<<<<
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x01 { AddrMarkNotFound }, LBAsect=43141736,
high=2, low=9587304, sector=43141736
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x01 { AddrMarkNotFound }, LBAsect=43141736,
high=2, low=9587304, sector=43141736
hde: DMA disabled
PDC202XX: Primary channel reset.
ide2: reset: master: error (0x00?)
hde: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hde: task_in_intr: error=0x40 { UncorrectableError }, LBAsect=43141736,
high=2, low=9587304, sector=43141736
end_request: I/O error, dev 21:00 (hde), sector 43141736
hde: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hde: task_in_intr: error=0x40 { UncorrectableError }, LBAsect=43141736,
high=2, low=9587304, sector=43141736
<<<

I think "master: error (0x00?)" indicate another bug.
Andre, what do you think?

--
	Manfred
--------------588E74E2D795C3D705E3D07A
Content-Type: text/plain; charset=us-ascii;
 name="patch-pdc202"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pdc202"

--- 2.4/drivers/ide/pdc202xx.c	Fri Mar 29 14:34:13 2002
+++ build-2.4/drivers/ide/pdc202xx.c	Sun Mar 31 01:04:02 2002
@@ -729,12 +729,7 @@
 	byte mask		= hwif->channel ? 0x08 : 0x02;
 	unsigned short c_mask	= hwif->channel ? (1<<11) : (1<<10);
 
-	byte ultra_66		= ((id->dma_ultra & 0x0010) ||
-				   (id->dma_ultra & 0x0008)) ? 1 : 0;
-	byte ultra_100		= ((id->dma_ultra & 0x0020) ||
-				   (ultra_66)) ? 1 : 0;
-	byte ultra_133		= ((id->dma_ultra & 0x0040) ||
-				   (ultra_100)) ? 1 : 0;
+	byte fast_ultra		= id->dma_ultra & 0x0078;
 
 	switch(dev->device) {
 		case PCI_DEVICE_ID_PROMISE_20276:
@@ -792,7 +787,7 @@
 	 * parameters.
 	 */
 
-	if (((ultra_66) || (ultra_100) || (ultra_133)) && (cable)) {
+	if (fast_ultra && cable) {
 #ifdef DEBUG
 		printk("ULTRA66: %s channel of Ultra 66 requires an 80-pin cable for Ultra66 operation.\n", hwif->channel ? "Secondary" : "Primary");
 		printk("         Switching to Ultra33 mode.\n");
@@ -805,17 +800,13 @@
 		printk("%s reduced to Ultra33 mode.\n", drive->name);
 		udma_66 = 0; udma_100 = 0; udma_133 = 0;
 	} else {
-		if ((ultra_66) || (ultra_100) || (ultra_133)) {
+		if (fast_ultra) {
 			/*
 			 * check to make sure drive on same channel
 			 * is u66 capable
 			 */
 			if (hwif->drives[!(drive->dn%2)].id) {
-				if ((hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0040) ||
-				    (hwif->drives[!(drive->dn%2)].id->dma_ultra
-& 0x0020) ||
-				    (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0010) ||
-				    (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0008)) {
+				if (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0078) {
 					if (!jumpbit)
 						OUT_BYTE(CLKSPD | mask, (high_16 + 0x11));
 				} else {
@@ -1075,6 +1066,8 @@
 	mdelay(1000);
 	printk("PDC202XX: %s channel reset.\n",
 		HWIF(drive)->channel ? "Secondary" : "Primary");
+	/* the reset clears the configuration, reinit to pio */
+	config_chipset_for_pio(drive, 5);
 }
 
 void pdc202xx_reset (ide_drive_t *drive)

--------------588E74E2D795C3D705E3D07A--


