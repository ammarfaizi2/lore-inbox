Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSKHLHY>; Fri, 8 Nov 2002 06:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbSKHLHY>; Fri, 8 Nov 2002 06:07:24 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:57433 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S261842AbSKHLHV>; Fri, 8 Nov 2002 06:07:21 -0500
Date: Fri, 8 Nov 2002 06:10:20 -0500
From: David Meybohm <dmeybohm@bellsouth.net>
To: linux-kernel@vger.kernel.org
Cc: Santiago Garcia Mantinan <manty@manty.net>,
       Ted Kaminski <mouschi@wi.rr.com>,
       David Meybohm <dmeybohm@bellsouth.net>
Subject: [PATCH] Fix SB16 PnP IDE controller in 2.4
Message-ID: <20021108061020.A14168@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the SB16 PnP IDE controller in 2.4 and is
against 2.4.20-rc1.  It changes the IDE code to use "active"
status probing on the SB16 instead of passive.  An
alternative workaround is disabling CONFIG_IDEPCI_SHARE_IRQ.  

I restart the search for controllers in pnpide_init() (the
"dev = NULL" part) in order to avoid possibly skipping a
second or third controller due to mismatch between device
list order and IDE PnP devices order. Is this correct? 

Two additional people, Santiago Mantinan and Ted Kaminski,
have tested versions of this patch.  They both said it
worked for them.  Santiago tested it on a box with an
additional, different ISAPnP controller and he said it
worked.  This version of the patch is identical to the patch
that Santiago tested except that I removed some
non-essential changes to the pnp_dev_t struct.

Since this is the first kernel patch I've made for general
consumption, I was wondering if there were any problems with
it.  So here goes..

Thanks,
David

 drivers/ide/ide-pnp.c |   28 +++++++++++++++++++++++++++-
 drivers/ide/ide.c     |    3 ++-
 include/linux/ide.h   |    1 +
 3 files changed, 30 insertions, 2 deletions

--- v2.4.20-rc1/drivers/ide/ide.c~sb16pnpide	Fri Nov  8 04:39:26 2002
+++ v2.4.20-rc1-hipnod/drivers/ide/ide.c	Fri Nov  8 04:39:26 2002
@@ -543,7 +543,7 @@ int drive_is_ready (ide_drive_t *drive)
 	 * an interrupt with another pci card/device.  We make no assumptions
 	 * about possible isa-pnp and pci-pnp issues yet.
 	 */
-	if (IDE_CONTROL_REG)
+	if (IDE_CONTROL_REG && !HWIF(drive)->hw.no_passive)
 		stat = GET_ALTSTAT();
 	else
 #endif /* CONFIG_IDEPCI_SHARE_IRQ */
@@ -2419,6 +2419,7 @@ void ide_setup_ports (	hw_regs_t *hw,
 	}
 	hw->irq = irq;
 	hw->dma = NO_DMA;
+	hw->no_passive = 0;
 	hw->ack_intr = ack_intr;
 }
 
--- v2.4.20-rc1/drivers/ide/ide-pnp.c~sb16pnpide	Fri Nov  8 04:39:26 2002
+++ v2.4.20-rc1-hipnod/drivers/ide/ide-pnp.c	Fri Nov  8 04:39:26 2002
@@ -54,7 +54,8 @@ struct pnp_dev_t {
 };
 
 /* Generic initialisation function for ISA PnP IDE interface */
-static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
+static int __init pnpide_do_generic_init(struct pci_dev *dev, int enable,
+					 int no_passive)
 {
 	hw_regs_t hw;
 	int index;
@@ -69,6 +70,8 @@ static int __init pnpide_generic_init(st
 			generic_ide_offsets, (ide_ioreg_t) DEV_IO(dev, 1),
 			0, NULL, DEV_IRQ(dev, 0));
 
+	hw.no_passive = no_passive;
+
 	index = ide_register_hw(&hw, NULL);
 
 	if (index != -1) {
@@ -79,8 +82,30 @@ static int __init pnpide_generic_init(st
 	return 1;
 }
 
+static int __init pnpide_generic_init(struct pci_dev *dev, int enable) 
+{
+	return pnpide_do_generic_init(dev, enable, 0);
+}
+
+/* Initialisation function for SB16 ISA PnP IDE interface */
+static int __init pnpide_sb16_init(struct pci_dev *dev, int enable)
+{
+	int no_passive;
+	
+	/*
+	 * Disable passive status testing on the SB16 PnP controller.
+	 */
+	no_passive = 1;
+
+	return pnpide_do_generic_init(dev, enable, no_passive);
+}
+
 /* Add your devices here :)) */
 struct pnp_dev_t idepnp_devices[] __initdata = {
+	/* SB16 PnP IDE controller */
+	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('C', 'T', 'L'), ISAPNP_DEVICE(0x2011), 
+		pnpide_sb16_init },
   	/* Generic ESDI/IDE/ATA compatible hard disk controller */
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('P', 'N', 'P'), ISAPNP_DEVICE(0x0600),
@@ -123,6 +148,7 @@ void __init pnpide_init(int enable)
 	}
 #endif
 	for (dev_type = idepnp_devices; dev_type->vendor; dev_type++) {
+		dev = NULL;
 		while ((dev = isapnp_find_dev(NULL, dev_type->vendor,
 			dev_type->device, dev))) {
 
--- v2.4.20-rc1/include/linux/ide.h~sb16pnpide	Fri Nov  8 04:39:26 2002
+++ v2.4.20-rc1-hipnod/include/linux/ide.h	Fri Nov  8 04:39:26 2002
@@ -277,6 +277,7 @@ typedef struct hw_regs_s {
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	int		irq;			/* our irq number */
 	int		dma;			/* our dma entry */
+	int		no_passive;		/* no passive status tests */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	void		*priv;			/* interface specific data */
 	hwif_chipset_t  chipset;

[patch ends]
