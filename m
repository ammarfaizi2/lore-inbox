Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbSLPKbl>; Mon, 16 Dec 2002 05:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266918AbSLPKbl>; Mon, 16 Dec 2002 05:31:41 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:54242 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266917AbSLPKbf>;
	Mon, 16 Dec 2002 05:31:35 -0500
Date: Mon, 16 Dec 2002 11:39:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Patrick Petermair <black666@inode.at>,
       AnonimoVeneziano <voloterreno@tin.it>,
       Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE-CD and VT8235 issue!!!
Message-ID: <20021216113924.A31907@ucw.cz>
References: <3DFB7B21.7040004@tin.it> <3DFBC4F3.2070603@tin.it> <20021215215057.A12689@ucw.cz> <200212152256.25266.black666@inode.at> <20021216113458.A31837@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021216113458.A31837@ucw.cz>; from vojtech@suse.cz on Mon, Dec 16, 2002 at 11:34:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2002 at 11:34:58AM +0100, Vojtech Pavlik wrote:
> On Sun, Dec 15, 2002 at 10:56:25PM +0100, Patrick Petermair wrote:
> > Vojtech Pavlik:
> > 
> > > You're not alone with this problem. I suspect some fishy stuff in the
> > > vt8235, because the driver programs it exactly the same as vt8233a,
> > > but while the vt8233a doesn't seem to have problems with DVDs and
> > > CDs, the vt8235 fails for many people.
> > 
> > Thanks for the info ... like I expected ...
> > 
> > > Can you send me 'hdparm -i' of the drive?
> > 
> > starbase:/# hdparm -i /dev/hdc
> > 
> > /dev/hdc:
> > 
> >  Model=TOSHIBA DVD-ROM SD-M1302, FwRev=1006, SerialNo=X900304741
> >  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
> >  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
> >  BuffType=unknown, BuffSize=256kB, MaxMultSect=0
> >  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
> >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes:  pio0 pio1 pio2 pio3 pio4 
> >  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
> >  UDMA modes: udma0 udma1 *udma2 
> >  AdvancedPM=no
> > 
> > Thanks for all your effort here. It's great to see such a good 
> > community.
> 
> If you can, please try 2.4.20 with this patch.

Patch attached now.

-- 
Vojtech Pavlik
SuSE Labs

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=vt8235-dvd

ChangeSet@1.884, 2002-12-16 11:00:04+01:00, vojtech@suse.cz
  Workaround problems with vt8235 and certain CD/DVD-ROMs.


 via82cxxx.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)


diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	Mon Dec 16 11:33:37 2002
+++ b/drivers/ide/pci/via82cxxx.c	Mon Dec 16 11:33:37 2002
@@ -67,6 +67,7 @@
 #define VIA_SET_FIFO		0x040	/* Needs to have FIFO split set */
 #define VIA_NO_UNMASK		0x080	/* Doesn't work with IRQ unmasking on */
 #define VIA_BAD_ID		0x100	/* Has wrong vendor ID (0x1107) */
+#define VIA_NO_CMD_AS		0x200	/* Don't program command and address setup timings */
 
 /*
  * VIA SouthBridge chips.
@@ -80,10 +81,10 @@
 	u16 flags;
 } via_isa_bridges[] = {
 #ifdef FUTURE_BRIDGES
-	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
+	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_NO_CMD_AS },
 #endif
-	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
-	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 },
+	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_NO_CMD_AS },
+	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_NO_CMD_AS },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8231",	PCI_DEVICE_ID_VIA_8231,     0x00, 0x2f, VIA_UDMA_100 },
@@ -292,12 +293,15 @@
 {
 	u8 t;
 
-	pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
-	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
-	pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
+	if (~via_config->flags & VIA_NO_CMD_AS) {
+
+		pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
+		t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
+		pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
 
-	pci_write_config_byte(dev, VIA_8BIT_TIMING + (1 - (dn >> 1)),
-		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));
+		pci_write_config_byte(dev, VIA_8BIT_TIMING + (1 - (dn >> 1)),
+			((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));
+	}
 
 	pci_write_config_byte(dev, VIA_DRIVE_TIMING + (3 - dn),
 		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));

--oyUTqETQ0mS9luUI--
