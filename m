Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSLTVAG>; Fri, 20 Dec 2002 16:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSLTVAG>; Fri, 20 Dec 2002 16:00:06 -0500
Received: from mail229.mail.bellsouth.net ([205.152.58.199]:36530 "EHLO
	imf25bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S265612AbSLTVAD>; Fri, 20 Dec 2002 16:00:03 -0500
Date: Fri, 20 Dec 2002 16:16:11 -0500
From: David Meybohm <dmeybohm@bellsouth.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Ted Kaminski <mouschi@wi.rr.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>
Subject: Re: pnp/IDE question- help fixing up a patch
References: <007e01c2a19b$934e9a00$6400a8c0@win01> <Pine.LNX.4.10.10212120025570.7114-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10212120025570.7114-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Dec 12, 2002 at 12:33:01AM -0800
X-No-Archive: Yes
Message-Id: <20021220210954.YOWP1365.imf25bis.bellsouth.net@loki>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 12, 2002 at 12:33:01AM -0800, Andre Hedrick wrote:
> 
> The difference in the two locations has to do with early initalization.
> One the issues of concern in the patch, is the usage of "passive".
> A stronger position for setup would have a hwif->intq_mode operator.
> Regardless if it is a bit field or not.

Is this patch any better? This patch also fixes the SB16 pnpide, and
is against 2.4.21-pre2.

> This would force ide-probe to initialize the hwif_intr properly.
> Next the mask of the field would provide a method for poking the
> drive_is_ready().

i was wondering if it would be reliable to choose STATUS or ALTSTATUS
in drive_is_ready() based on which one actual_try_to_identify() uses
for probing. Is this what you mean by "initialize the hwif_intr
properly", or something else?

> One the config option for share or not interrupts goes away.

I didn't remove CONFIG_IDEPCI_SHARE_IRQ completely because some
architectures have if off by default. So I set the default poking
method based on CONFIG_IDEPCI_SHARE_IRQ.

Thanks,
David

 drivers/ide/ide-iops.c  |    4 +---
 drivers/ide/ide-pnp.c   |   34 ++++++++++++++++++++++++++++------
 drivers/ide/ide-probe.c |    5 ++---
 drivers/ide/ide.c       |    3 +++
 include/linux/ide.h     |    1 +
 5 files changed, 35 insertions, 12 deletions

--- v2.4.21-pre2/drivers/ide/ide.c~sb16fix-pre2	Fri Dec 20 16:08:37 2002
+++ v2.4.21-pre2-sb16fix-pre2/drivers/ide/ide.c	Fri Dec 20 16:08:37 2002
@@ -240,6 +240,9 @@ static void init_hwif_data (unsigned int
 	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)
 		hwif->noprobe = 1; /* may be overridden by ide_setup() */
 #endif /* CONFIG_BLK_DEV_HD */
+#ifndef CONFIG_IDEPCI_SHARE_IRQ
+	hwif->no_altstat = 1;
+#endif /* !CONFIG_IDEPCI_SHARE_IRQ */
 	hwif->major	= ide_hwif_to_major[index];
 	hwif->name[0]	= 'i';
 	hwif->name[1]	= 'd';
--- v2.4.21-pre2/drivers/ide/ide-iops.c~sb16fix-pre2	Fri Dec 20 16:08:37 2002
+++ v2.4.21-pre2-sb16fix-pre2/drivers/ide/ide-iops.c	Fri Dec 20 16:08:37 2002
@@ -473,17 +473,15 @@ int drive_is_ready (ide_drive_t *drive)
 	udelay(1);
 #endif
 
-#ifdef CONFIG_IDEPCI_SHARE_IRQ
 	/*
 	 * We do a passive status test under shared PCI interrupts on
 	 * cards that truly share the ATA side interrupt, but may also share
 	 * an interrupt with another pci card/device.  We make no assumptions
 	 * about possible isa-pnp and pci-pnp issues yet.
 	 */
-	if (IDE_CONTROL_REG)
+	if (IDE_CONTROL_REG && !hwif->no_altstat)
 		stat = hwif->INB(IDE_ALTSTATUS_REG);
 	else
-#endif /* CONFIG_IDEPCI_SHARE_IRQ */
 		/* Note: this may clear a pending IRQ!! */
 		stat = hwif->INB(IDE_STATUS_REG);
 
--- v2.4.21-pre2/drivers/ide/ide-pnp.c~sb16fix-pre2	Fri Dec 20 16:08:37 2002
+++ v2.4.21-pre2-sb16fix-pre2/drivers/ide/ide-pnp.c	Fri Dec 20 16:08:37 2002
@@ -58,7 +58,7 @@ static int __init pnpide_generic_init(st
 		return 0;
 
 	if (!(DEV_IO(dev, 0) && DEV_IO(dev, 1) && DEV_IRQ(dev, 0)))
-		return 1;
+		return -1;
 
 	ide_setup_ports(&hw, (ide_ioreg_t) DEV_IO(dev, 0),
 			generic_ide_offsets,
@@ -69,16 +69,38 @@ static int __init pnpide_generic_init(st
 
 	index = ide_register_hw(&hw, NULL);
 
-	if (index != -1) {
+	if (index != -1) 
 	    	printk(KERN_INFO "ide%d: %s IDE interface\n", index, DEV_NAME(dev));
+	return index;
+}
+
+
+/* Initialisation function for SB16 ISA PnP IDE interface */
+static int __init pnpide_sb16_init(struct pci_dev *dev, int enable)
+{
+	int index;
+
+	if (!enable)
 		return 0;
-	}
 
-	return 1;
-}
+	index = pnpide_generic_init(dev, enable);
+	if (index == -1)
+		return index;
+
+	/*
+	 * The SB16 IDE controller doesn't like ALTSTATUS.
+	 */
+	ide_hwifs[index].no_altstat = 1;
 
+	return index;
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
@@ -136,7 +158,7 @@ void __init pnpide_init(int enable)
 			}
 
 			/* Call device initialization function */
-			if (dev_type->init_fn(dev, 1)) {
+			if (dev_type->init_fn(dev, 1) == -1) {
 				if (dev->deactivate(dev))
 					dev->deactivate(dev);
 			} else {
--- v2.4.21-pre2/drivers/ide/ide-probe.c~sb16fix-pre2	Fri Dec 20 16:08:37 2002
+++ v2.4.21-pre2-sb16fix-pre2/drivers/ide/ide-probe.c	Fri Dec 20 16:08:37 2002
@@ -884,9 +884,8 @@ int init_irq (ide_hwif_t *hwif)
 
 		if (IDE_CHIPSET_IS_PCI(hwif->chipset)) {
 			sa = SA_SHIRQ;
-#ifndef CONFIG_IDEPCI_SHARE_IRQ
-			sa |= SA_INTERRUPT;
-#endif /* CONFIG_IDEPCI_SHARE_IRQ */
+			if (hwif->no_altstat)
+				sa |= SA_INTERRUPT;
 		}
 
 		if (hwif->io_ports[IDE_CONTROL_OFFSET])
--- v2.4.21-pre2/include/linux/ide.h~sb16fix-pre2	Fri Dec 20 16:08:37 2002
+++ v2.4.21-pre2-sb16fix-pre2/include/linux/ide.h	Fri Dec 20 16:14:36 2002
@@ -1009,6 +1009,7 @@ typedef struct hwif_s {
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
 	unsigned	highmem    : 1;	/* can do full 32-bit dma */
 	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
+	unsigned	no_altstat : 1; /* 0 default, 1 don't use ALTSTATUS */
 
 	void		*hwif_data;	/* extra hwif data */
 } ide_hwif_t;

