Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312476AbSC3NJn>; Sat, 30 Mar 2002 08:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312479AbSC3NJe>; Sat, 30 Mar 2002 08:09:34 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:57024 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312476AbSC3NJO>;
	Sat, 30 Mar 2002 08:09:14 -0500
Date: Sat, 30 Mar 2002 14:09:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Fran?ois Cami <stilgar2k@wanadoo.fr>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
        martin@dalecki.de
Subject: Re: Anyone with an ICH2 or ICH3 Intel southbridge and UDMA133 harddrive willing to test?
Message-ID: <20020330140910.A731@ucw.cz>
In-Reply-To: <20020330124208.A537@ucw.cz> <3CA5B628.2010202@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 30, 2002 at 01:57:12PM +0100, Fran?ois Cami wrote:

> Vojtech Pavlik wrote:
> > Hi!
> > 
> > I think it should be possible to make the ICH2 and ICH3 Intel chips
> > (82801BA and 82801CA) do UDMA133. (Intel only says they can do UDMA100).
> > If anyone running a 2.5 kernel with an Intel mainboard with one of those
> > chips and a UDMA133 capable harddrive is willing to test this, please
> > contact me, I'll give you a patch.
> 
> I'm in.
> i815ep (tusl2-c mainboard) + maxtor 80GB udma 133.
> 
> I'm wondering how you can do that though... Would you
> explain, please ?

The ich2/3 use a 133 MHz base clock for IDE timing. And have a divisor
settable, they divide by three to get 50 MHz base clock for UDMA100
(it's 16-bit), and can divide by two to get 66 and hence UDMA133.
However that value (division by 2 with 133 MHz clock) is marked as
'reserved' in the specs.

In the end it may or may not work. I'm very curious, though.

VERY untested patch attached.

-- 
Vojtech Pavlik
SuSE Labs

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="piix-test.diff"

diff -urN linux-2.5.7/drivers/ide/piix.c linux-2.5.7-piix/drivers/ide/piix.c
--- linux-2.5.7/drivers/ide/piix.c	Fri Mar 29 16:01:51 2002
+++ linux-2.5.7-piix/drivers/ide/piix.c	Sat Mar 30 14:08:31 2002
@@ -1,5 +1,5 @@
 /*
- * $Id: piix.c,v 1.2 2002/03/13 22:50:43 vojtech Exp $
+ * $Id: piix.c,v 1.2-test133 2002/03/13 22:50:43 vojtech Exp $
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -62,7 +62,7 @@
 #define PIIX_UDMA_33		0x01
 #define PIIX_UDMA_66		0x02
 #define PIIX_UDMA_V66		0x03
-#define PIIX_UDMA_100		0x04
+#define PIIX_UDMA_133		0x05
 #define PIIX_NO_SITRE		0x08	/* Chip doesn't have separate slave timing */
 #define PIIX_PINGPONG		0x10	/* Enable ping-pong buffers */
 #define PIIX_VICTORY		0x20	/* Efar Victory66 has a different UDMA setup */
@@ -77,10 +77,10 @@
 	unsigned short id;
 	unsigned char flags;
 } piix_ide_chips[] = {
-	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CA ICH3 */
-	{ PCI_DEVICE_ID_INTEL_82801CA_10,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CAM ICH3-M */
-	{ PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BA ICH2 */
-	{ PCI_DEVICE_ID_INTEL_82801BA_8,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BAM ICH2-M */
+	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801CA ICH3 */
+	{ PCI_DEVICE_ID_INTEL_82801CA_10,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801CAM ICH3-M */
+	{ PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801BA ICH2 */
+	{ PCI_DEVICE_ID_INTEL_82801BA_8,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801BAM ICH2-M */
 	{ PCI_DEVICE_ID_INTEL_82801AB_1,	PIIX_UDMA_33  | PIIX_PINGPONG },                    /* Intel 82801AB ICH0 */
 	{ PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },                    /* Intel 82801AA ICH */
 	{ PCI_DEVICE_ID_INTEL_82372FB_1,	PIIX_UDMA_66 },	                                    /* Intel 82372FB PIIX5 */
@@ -97,7 +97,7 @@
 static unsigned int piix_80w;
 static unsigned int piix_clock;
 
-static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA66", "UDMA100" };
+static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA66", "UDMA100", "UDMA133" };
 
 /*
  * PIIX/ICH /proc entry.
@@ -128,7 +128,7 @@
 
 	piix_print("----------PIIX BusMastering IDE Configuration---------------");
 
-	piix_print("Driver Version:                     1.2");
+	piix_print("Driver Version:                     1.2-test133");
 	piix_print("South Bridge:                       %s", bmide_dev->name);
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
@@ -199,7 +199,7 @@
 
 		if (~piix_config->flags & PIIX_VICTORY) {
 			if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 && (u & (1 << i))) umul = 2;
-			if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 && (u & ((1 << i) + 12))) umul = 1;
+			if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_133 && (u & (1 << (i + 12)))) umul = 1;
 			udma[i] = (4 - ((e >> (i << 2)) & 3)) * umul;
 		} else  udma[i] = (8 - ((e >> (i << 2)) & 7)) * 2;
 
@@ -388,7 +388,7 @@
 			(piix_config->flags & PIIX_NODMA ? 0 : (XFER_SWDMA | XFER_MWDMA |
 			(piix_config->flags & PIIX_UDMA ? XFER_UDMA : 0) |
 			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 ? XFER_UDMA_66 : 0) |
-			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 ? XFER_UDMA_100 : 0))));
+			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_133 ? (XFER_UDMA_100 | XFER_UDMA_133) : 0))));
 
 		piix_set_drive(drive, speed);
 
@@ -458,7 +458,7 @@
 	switch (piix_config->flags & PIIX_UDMA) {
 
 		case PIIX_UDMA_66:
-		case PIIX_UDMA_100:
+		case PIIX_UDMA_133:
 			pci_read_config_dword(dev, PIIX_IDECFG, &u);
 			piix_80w = ((u & 0x30) ? 1 : 0) | ((u & 0xc0) ? 2 : 0);
 			break;

--wac7ysb48OaltWcw--
