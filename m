Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTIBSlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbTIBSlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:41:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:409 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261334AbTIBSkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:40:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide: kill ide_setup_ports()
Date: Tue, 2 Sep 2003 20:41:00 +0200
User-Agent: KMail/1.5
Cc: linux-m68k@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309022041.00163.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ linux-m68k cc: because most of the patch touches m68k only code ]

ide: kill ide_setup_ports()

Remove this pseudo helper and convert buddha, gayle, falconide, macide
and ide-pnp host drivers to initialize hwif->hw themselves.
Also kill q40_ide_setup_ports(), a q40ide variant of ide_setup_ports().

As a side-effect code sizes of all these host drivers were slightly decreased
(with exception of macide - size unchanged), so ide_setup_ports() really was
an obfuscation, not a helper.

 drivers/ide/ide-pnp.c          |   35 +++++++----------
 drivers/ide/ide.c              |   56 ----------------------------
 drivers/ide/legacy/buddha.c    |   64 +++++++++++++++-----------------
 drivers/ide/legacy/falconide.c |   41 +++++++++-----------
 drivers/ide/legacy/gayle.c     |   33 +++++++---------
 drivers/ide/legacy/macide.c    |   65 ++++++++++++++++----------------
 drivers/ide/legacy/q40ide.c    |   82 ++++++++++++-----------------------------
 include/linux/ide.h            |   14 -------
 8 files changed, 135 insertions(+), 255 deletions(-)

diff -puN drivers/ide/ide.c~ide-setup-ports drivers/ide/ide.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide.c~ide-setup-ports	2003-09-02 18:07:42.480762448 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide.c	2003-09-02 18:07:42.507758344 +0200
@@ -935,62 +935,6 @@ abort:
 
 EXPORT_SYMBOL(ide_unregister);
 
-
-/**
- *	ide_setup_ports 	-	set up IDE interface ports
- *	@hw: register descriptions
- *	@base: base register
- *	@offsets: table of register offsets
- *	@ctrl: control register
- *	@ack_irq: IRQ ack
- *	@irq: interrupt lie
- *
- *	Setup hw_regs_t structure described by parameters.  You
- *	may set up the hw structure yourself OR use this routine to
- *	do it for you. This is basically a helper
- *
- */
- 
-void ide_setup_ports (	hw_regs_t *hw,
-			unsigned long base, int *offsets,
-			unsigned long ctrl, unsigned long intr,
-			ide_ack_intr_t *ack_intr,
-/*
- *			ide_io_ops_t *iops,
- */
-			int irq)
-{
-	int i;
-
-	for (i = 0; i < IDE_NR_PORTS; i++) {
-		if (offsets[i] == -1) {
-			switch(i) {
-				case IDE_CONTROL_OFFSET:
-					hw->io_ports[i] = ctrl;
-					break;
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-				case IDE_IRQ_OFFSET:
-					hw->io_ports[i] = intr;
-					break;
-#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
-				default:
-					hw->io_ports[i] = 0;
-					break;
-			}
-		} else {
-			hw->io_ports[i] = base + offsets[i];
-		}
-	}
-	hw->irq = irq;
-	hw->dma = NO_DMA;
-	hw->ack_intr = ack_intr;
-/*
- *	hw->iops = iops;
- */
-}
-
-EXPORT_SYMBOL(ide_setup_ports);
-
 /*
  * Register an IDE interface, specifying exactly the registers etc
  * Set init=1 iff calling before probes have taken place.
diff -puN drivers/ide/ide-pnp.c~ide-setup-ports drivers/ide/ide-pnp.c
--- linux-2.6.0-test4-bk3/drivers/ide/ide-pnp.c~ide-setup-ports	2003-09-02 18:07:42.483761992 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/ide-pnp.c	2003-09-02 18:07:42.507758344 +0200
@@ -21,21 +21,6 @@
 
 #include <linux/pnp.h>
 
-#define GENERIC_HD_DATA		0
-#define GENERIC_HD_ERROR	1
-#define GENERIC_HD_NSECTOR	2
-#define GENERIC_HD_SECTOR	3
-#define GENERIC_HD_LCYL		4
-#define GENERIC_HD_HCYL		5
-#define GENERIC_HD_SELECT	6
-#define GENERIC_HD_STATUS	7
-
-static int generic_ide_offsets[IDE_NR_PORTS] = {
-	GENERIC_HD_DATA, GENERIC_HD_ERROR, GENERIC_HD_NSECTOR, 
-	GENERIC_HD_SECTOR, GENERIC_HD_LCYL, GENERIC_HD_HCYL,
-	GENERIC_HD_SELECT, GENERIC_HD_STATUS, -1, -1
-};
-
 /* Add your devices here :)) */
 struct pnp_device_id idepnp_devices[] = {
   	/* Generic ESDI/IDE/ATA compatible hard disk controller */
@@ -47,17 +32,25 @@ static int idepnp_probe(struct pnp_dev *
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
+	unsigned long base;
+	unsigned int i;
 	int index;
 
 	if (!(pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) && pnp_irq_valid(dev, 0)))
 		return -1;
 
-	ide_setup_ports(&hw, (unsigned long) pnp_port_start(dev, 0),
-			generic_ide_offsets,
-			(unsigned long) pnp_port_start(dev, 1),
-			0, NULL,
-//			generic_pnp_ide_iops,
-			pnp_irq(dev, 0));
+	base = (unsigned long) pnp_port_start(dev, 0);
+
+	for (i = IDE_DATA_OFFSET; i < IDE_CONTROL_OFFSET; i++)
+		hw.io_ports[i] = base + i;
+
+	hw.io_ports[IDE_CONTROL_OFFSET] = (unsigned long)
+					  pnp_port_start(dev, 1);
+	hw.io_ports[IDE_IRQ_OFFSET] = 0;
+
+	hw.irq = pnp_irq(dev, 0);
+	hw.dma = NO_DMA;
+	hw.ack_intr = NULL;
 
 	index = ide_register_hw(&hw, &hwif);
 
diff -puN drivers/ide/legacy/buddha.c~ide-setup-ports drivers/ide/legacy/buddha.c
--- linux-2.6.0-test4-bk3/drivers/ide/legacy/buddha.c~ide-setup-ports	2003-09-02 18:07:42.486761536 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/legacy/buddha.c	2003-09-02 18:07:42.508758192 +0200
@@ -61,26 +61,7 @@ static u_int xsurf_bases[XSURF_NUM_HWIFS
      *  Offsets from one of the above bases
      */
 
-#define BUDDHA_DATA	0x00
-#define BUDDHA_ERROR	0x06		/* see err-bits */
-#define BUDDHA_NSECTOR	0x0a		/* nr of sectors to read/write */
-#define BUDDHA_SECTOR	0x0e		/* starting sector */
-#define BUDDHA_LCYL	0x12		/* starting cylinder */
-#define BUDDHA_HCYL	0x16		/* high byte of starting cyl */
-#define BUDDHA_SELECT	0x1a		/* 101dhhhh , d=drive, hhhh=head */
-#define BUDDHA_STATUS	0x1e		/* see status-bits */
 #define BUDDHA_CONTROL	0x11a
-#define XSURF_CONTROL   -1              /* X-Surf has no CS1* (Control/AltStat) */
-
-static int buddha_offsets[IDE_NR_PORTS] __initdata = {
-    BUDDHA_DATA, BUDDHA_ERROR, BUDDHA_NSECTOR, BUDDHA_SECTOR, BUDDHA_LCYL,
-    BUDDHA_HCYL, BUDDHA_SELECT, BUDDHA_STATUS, BUDDHA_CONTROL, -1
-};
-
-static int xsurf_offsets[IDE_NR_PORTS] __initdata = {
-    BUDDHA_DATA, BUDDHA_ERROR, BUDDHA_NSECTOR, BUDDHA_SECTOR, BUDDHA_LCYL,
-    BUDDHA_HCYL, BUDDHA_SELECT, BUDDHA_STATUS, XSURF_CONTROL, -1
-};
 
     /*
      *  Other registers
@@ -146,6 +127,7 @@ static int xsurf_ack_intr(ide_hwif_t *hw
 void __init buddha_init(void)
 {
 	hw_regs_t hw;
+	unsigned long base;
 	int i, index;
 
 	struct zorro_dev *z = NULL;
@@ -171,6 +153,7 @@ void __init buddha_init(void)
 
 /*
  * FIXME: we now have selectable mmio v/s iomio transports.
+ * FIXME2: split init on Buddha and Catweasel/X-Surf.
  */
 
 		if(type != BOARD_XSURF) {
@@ -196,22 +179,35 @@ fail_base2:
 			z_writeb(0, buddha_board+BUDDHA_IRQ_MR);
 		
 		for(i=0;i<buddha_num_hwifs;i++) {
-			if(type != BOARD_XSURF) {
-				ide_setup_ports(&hw, (buddha_board+buddha_bases[i]),
-						buddha_offsets, 0,
-						(buddha_board+buddha_irqports[i]),
-						buddha_ack_intr,
-//						budda_iops,
-						IRQ_AMIGA_PORTS);
+
+			if (type != BOARD_XSURF)
+				base = buddha_board + buddha_bases[i];
+			else
+				base = buddha_board + xsurf_bases[i];
+
+			hw.io_ports[IDE_DATA_OFFSET]	= base;
+			hw.io_ports[IDE_ERROR_OFFSET]	= base + 0x06;
+			hw.io_ports[IDE_NSECTOR_OFFSET]	= base + 0x0a;
+			hw.io_ports[IDE_SECTOR_OFFSET]	= base + 0x0e;
+			hw.io_ports[IDE_LCYL_OFFSET]	= base + 0x12;
+			hw.io_ports[IDE_HCYL_OFFSET]	= base + 0x16;
+			hw.io_ports[IDE_SELECT_OFFSET]	= base + 0x1a;
+			hw.io_ports[IDE_STATUS_OFFSET]	= base + 0x1e;
+
+			if (type != BOARD_XSURF) {
+				hw.io_ports[IDE_CONTROL_OFFSET] = base + BUDDHA_CONTROL;
+				hw.io_ports[IDE_IRQ_OFFSET] = buddha_board + buddha_irqports[i];
+				hw.ack_intr = buddha_ack_intr;
 			} else {
-				ide_setup_ports(&hw, (buddha_board+xsurf_bases[i]),
-						xsurf_offsets, 0,
-						(buddha_board+xsurf_irqports[i]),
-						xsurf_ack_intr,
-//						xsurf_iops,
-						IRQ_AMIGA_PORTS);
-			}	
-			
+				/* X-Surf has no CS1* (Control/AltStat) */
+				hw.io_ports[IDE_CONTROL_OFFSET] = 0;
+				hw.io_ports[IDE_IRQ_OFFSET] = buddha_board + xsurf_irqports[i];
+				hw.ack_intr = xsurf_ack_intr;
+			}
+
+			hw.irq = IRQ_AMIGA_PORTS;
+			hw.dma = NO_DMA;
+
 			index = ide_register_hw(&hw, NULL);
 			if (index != -1) {
 				printk("ide%d: ", index);
diff -puN drivers/ide/legacy/falconide.c~ide-setup-ports drivers/ide/legacy/falconide.c
--- linux-2.6.0-test4-bk3/drivers/ide/legacy/falconide.c~ide-setup-ports	2003-09-02 18:07:42.489761080 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/legacy/falconide.c	2003-09-02 18:07:42.509758040 +0200
@@ -28,25 +28,6 @@
 
 #define ATA_HD_BASE	0xfff00000
 
-    /*
-     *  Offsets from the above base
-     */
-
-#define ATA_HD_DATA	0x00
-#define ATA_HD_ERROR	0x05		/* see err-bits */
-#define ATA_HD_NSECTOR	0x09		/* nr of sectors to read/write */
-#define ATA_HD_SECTOR	0x0d		/* starting sector */
-#define ATA_HD_LCYL	0x11		/* starting cylinder */
-#define ATA_HD_HCYL	0x15		/* high byte of starting cyl */
-#define ATA_HD_SELECT	0x19		/* 101dhhhh , d=drive, hhhh=head */
-#define ATA_HD_STATUS	0x1d		/* see status-bits */
-#define ATA_HD_CONTROL	0x39
-
-static int falconide_offsets[IDE_NR_PORTS] __initdata = {
-    ATA_HD_DATA, ATA_HD_ERROR, ATA_HD_NSECTOR, ATA_HD_SECTOR, ATA_HD_LCYL,
-    ATA_HD_HCYL, ATA_HD_SELECT, ATA_HD_STATUS, ATA_HD_CONTROL, -1
-};
-
 
     /*
      *  falconide_intr_lock is used to obtain access to the IDE interrupt,
@@ -64,12 +45,26 @@ void __init falconide_init(void)
 {
     if (MACH_IS_ATARI && ATARIHW_PRESENT(IDE)) {
 	hw_regs_t hw;
+	unsigned long base;
 	int index;
 
-	ide_setup_ports(&hw, ATA_HD_BASE, falconide_offsets,
-			0, 0, NULL,
-//			falconide_iops,
-			IRQ_MFP_IDE);
+	base = ATA_HD_BASE;
+
+	hw.io_ports[IDE_DATA_OFFSET]	= base;
+	hw.io_ports[IDE_ERROR_OFFSET]	= base + 0x05;
+	hw.io_ports[IDE_NSECTOR_OFFSET]	= base + 0x09;
+	hw.io_ports[IDE_SECTOR_OFFSET]	= base + 0x0d;
+	hw.io_ports[IDE_LCYL_OFFSET]	= base + 0x11;
+	hw.io_ports[IDE_HCYL_OFFSET]	= base + 0x15;
+	hw.io_ports[IDE_SELECT_OFFSET]	= base + 0x19;
+	hw.io_ports[IDE_STATUS_OFFSET]	= base + 0x1d;
+	hw.io_ports[IDE_CONTROL_OFFSET]	= base + 0x39;
+	hw.io_ports[IDE_IRQ_OFFSET]	= 0;
+
+	hw.irq = IRQ_MFP_IDE;
+	hw.dma = NO_DMA;
+	hw.ack_intr = NULL;
+
 	index = ide_register_hw(&hw, NULL);
 
 	if (index != -1)
diff -puN drivers/ide/legacy/gayle.c~ide-setup-ports drivers/ide/legacy/gayle.c
--- linux-2.6.0-test4-bk3/drivers/ide/legacy/gayle.c~ide-setup-ports	2003-09-02 18:07:42.492760624 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/legacy/gayle.c	2003-09-02 18:07:42.509758040 +0200
@@ -35,22 +35,8 @@
      *  Offsets from one of the above bases
      */
 
-#define GAYLE_DATA	0x00
-#define GAYLE_ERROR	0x06		/* see err-bits */
-#define GAYLE_NSECTOR	0x0a		/* nr of sectors to read/write */
-#define GAYLE_SECTOR	0x0e		/* starting sector */
-#define GAYLE_LCYL	0x12		/* starting cylinder */
-#define GAYLE_HCYL	0x16		/* high byte of starting cyl */
-#define GAYLE_SELECT	0x1a		/* 101dhhhh , d=drive, hhhh=head */
-#define GAYLE_STATUS	0x1e		/* see status-bits */
 #define GAYLE_CONTROL	0x101a
 
-static int gayle_offsets[IDE_NR_PORTS] __initdata = {
-    GAYLE_DATA, GAYLE_ERROR, GAYLE_NSECTOR, GAYLE_SECTOR, GAYLE_LCYL,
-    GAYLE_HCYL, GAYLE_SELECT, GAYLE_STATUS, -1, -1
-};
-
-
     /*
      *  These are at different offsets from the base
      */
@@ -153,10 +139,21 @@ void __init gayle_init(void)
 	base = (unsigned long)ZTWO_VADDR(phys_base);
 	ctrlport = GAYLE_HAS_CONTROL_REG ? (base + GAYLE_CONTROL) : 0;
 
-	ide_setup_ports(&hw, base, gayle_offsets,
-			ctrlport, irqport, ack_intr,
-//			&gayle_iops,
-			IRQ_AMIGA_PORTS);
+	hw.io_ports[IDE_DATA_OFFSET]	= base;
+	hw.io_ports[IDE_ERROR_OFFSET]	= base + 0x06;
+	hw.io_ports[IDE_NSECTOR_OFFSET]	= base + 0x0a;
+	hw.io_ports[IDE_SECTOR_OFFSET]	= base + 0x0e;
+	hw.io_ports[IDE_LCYL_OFFSET]	= base + 0x12;
+	hw.io_ports[IDE_HCYL_OFFSET]	= base + 0x16;
+	hw.io_ports[IDE_SELECT_OFFSET]	= base + 0x1a;
+	hw.io_ports[IDE_STATUS_OFFSET]	= base + 0x1e;
+
+	hw.io_ports[IDE_CONTROL_OFFSET]	= ctrlport;
+	hw.io_ports[IDE_IRQ_OFFSET]	= irqport;
+
+	hw.irq = IRQ_AMIGA_PORTS;
+	hw.dma = NO_DMA;
+	hw.ack_intr = ack_intr;
 
 	index = ide_register_hw(&hw, &hwif);
 	if (index != -1) {
diff -puN drivers/ide/legacy/macide.c~ide-setup-ports drivers/ide/legacy/macide.c
--- linux-2.6.0-test4-bk3/drivers/ide/legacy/macide.c~ide-setup-ports	2003-09-02 18:07:42.495760168 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/legacy/macide.c	2003-09-02 18:21:38.786624632 +0200
@@ -28,21 +28,6 @@
 #define IDE_BASE 0x50F1A000	/* Base address of IDE controller */
 
 /*
- * Generic IDE registers as offsets from the base
- * These match MkLinux so they should be correct.
- */
-
-#define IDE_DATA	0x00
-#define IDE_ERROR	0x04	/* see err-bits */
-#define IDE_NSECTOR	0x08	/* nr of sectors to read/write */
-#define IDE_SECTOR	0x0c	/* starting sector */
-#define IDE_LCYL	0x10	/* starting cylinder */
-#define IDE_HCYL	0x14	/* high byte of starting cyl */
-#define IDE_SELECT	0x18	/* 101dhhhh , d=drive, hhhh=head */
-#define IDE_STATUS	0x1c	/* see status-bits */
-#define IDE_CONTROL	0x38	/* control/altstatus */
-
-/*
  * Mac-specific registers
  */
 
@@ -64,11 +49,6 @@
 
 volatile unsigned char *ide_ifr = (unsigned char *) (IDE_BASE + IDE_IFR);
 
-static int macide_offsets[IDE_NR_PORTS] = {
-    IDE_DATA, IDE_ERROR,  IDE_NSECTOR, IDE_SECTOR, IDE_LCYL,
-    IDE_HCYL, IDE_SELECT, IDE_STATUS,  IDE_CONTROL
-};
-
 int macide_ack_intr(ide_hwif_t* hwif)
 {
 	if (*ide_ifr & 0x20) {
@@ -87,6 +67,27 @@ static void macide_mediabay_interrupt(in
 }
 #endif
 
+static void macide_init_io_ports(hw_regs_t *hw, unsigned long base)
+{
+	/*
+	 * Generic IDE registers as offsets from the base.
+	 * These match MkLinux so they should be correct.
+	 */
+	hw->io_ports[IDE_DATA_OFFSET]		= base;
+	hw->io_ports[IDE_ERROR_OFFSET]		= base + 0x04;
+	hw->io_ports[IDE_NSECTOR_OFFSET]	= base + 0x08;
+	hw->io_ports[IDE_SECTOR_OFFSET]		= base + 0x0c;
+	hw->io_ports[IDE_LCYL_OFFSET]		= base + 0x10;
+	hw->io_ports[IDE_HCYL_OFFSET]		= base + 0x14;
+	hw->io_ports[IDE_SELECT_OFFSET]		= base + 0x18;
+	hw->io_ports[IDE_STATUS_OFFSET]		= base + 0x1c;
+
+	hw->io_ports[IDE_CONTROL_OFFSET]	= base + 0x38;
+
+	/* FIXME: probably wrong, but orginal code did it. */
+	hw->io_ports[IDE_IRQ_OFFSET]		= base;
+}
+
 /*
  * Probe for a Macintosh IDE interface
  */
@@ -98,24 +99,24 @@ void macide_init(void)
 
 	switch (macintosh_config->ide_type) {
 	case MAC_IDE_QUADRA:
-		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
-				0, 0, macide_ack_intr,
-//				quadra_ide_iops,
-				IRQ_NUBUS_F);
+		macide_init_io_ports(&hw, IDE_BASE);
+		hw.irq = IRQ_NUBUS_F;
+		hw.ack_intr = macide_ack_intr;
+		hw.dma = NO_DMA;
 		index = ide_register_hw(&hw, NULL);
 		break;
 	case MAC_IDE_PB:
-		ide_setup_ports(&hw, IDE_BASE, macide_offsets,
-				0, 0, macide_ack_intr,
-//				macide_pb_iops,
-				IRQ_NUBUS_C);
+		macide_init_io_ports(&hw, IDE_BASE);
+		hw.irq = IRQ_NUBUS_C;
+		hw.ack_intr = macide_ack_intr;
+		hw.dma = NO_DMA;
 		index = ide_register_hw(&hw, NULL);
 		break;
 	case MAC_IDE_BABOON:
-		ide_setup_ports(&hw, BABOON_BASE, macide_offsets,
-				0, 0, NULL,
-//				macide_baboon_iops,
-				IRQ_BABOON_1);
+		macide_init_io_ports(&hw, BABOON_BASE);
+		hw.irq = IRQ_BABOON_1;
+		hw.ack_intr = NULL;
+		hw.dma = NO_DMA;
 		index = ide_register_hw(&hw, NULL);
 		if (index == -1) break;
 		if (macintosh_config->ident == MAC_MODEL_PB190) {
diff -puN drivers/ide/legacy/q40ide.c~ide-setup-ports drivers/ide/legacy/q40ide.c
--- linux-2.6.0-test4-bk3/drivers/ide/legacy/q40ide.c~ide-setup-ports	2003-09-02 18:07:42.498759712 +0200
+++ linux-2.6.0-test4-bk3-root/drivers/ide/legacy/q40ide.c	2003-09-02 18:21:57.861724776 +0200
@@ -36,23 +36,6 @@ static const unsigned long pcide_bases[Q
     PCIDE_BASE6 */
 };
 
-
-    /*
-     *  Offsets from one of the above bases
-     */
-
-/* used to do addr translation here but it is easier to do in setup ports */
-/*#define IDE_OFF_B(x)	((unsigned long)Q40_ISA_IO_B((IDE_##x##_OFFSET)))*/
-
-#define IDE_OFF_B(x)	((unsigned long)((IDE_##x##_OFFSET)))
-#define IDE_OFF_W(x)	((unsigned long)((IDE_##x##_OFFSET)))
-
-static const int pcide_offsets[IDE_NR_PORTS] = {
-    IDE_OFF_W(DATA), IDE_OFF_B(ERROR), IDE_OFF_B(NSECTOR), IDE_OFF_B(SECTOR),
-    IDE_OFF_B(LCYL), IDE_OFF_B(HCYL), 6 /*IDE_OFF_B(CURRENT)*/, IDE_OFF_B(STATUS),
-    518/*IDE_OFF(CMD)*/
-};
-
 static int q40ide_default_irq(unsigned long base)
 {
            switch (base) {
@@ -64,41 +47,6 @@ static int q40ide_default_irq(unsigned l
 	   }
 }
 
-
-/*
- * This is very similar to ide_setup_ports except that addresses
- * are pretranslated for q40 ISA access
- */
-void q40_ide_setup_ports ( hw_regs_t *hw,
-			unsigned long base, int *offsets,
-			unsigned long ctrl, unsigned long intr,
-			ide_ack_intr_t *ack_intr,
-/*
- *			ide_io_ops_t *iops,
- */
-			int irq)
-{
-	int i;
-
-	for (i = 0; i < IDE_NR_PORTS; i++) {
-		/* BIG FAT WARNING: 
-		   assumption: only DATA port is ever used in 16 bit mode */
-		if ( i==0 )
-			hw->io_ports[i] = Q40_ISA_IO_W(base + offsets[i]);
-		else
-			hw->io_ports[i] = Q40_ISA_IO_B(base + offsets[i]);
-	}
-	
-	hw->irq = irq;
-	hw->dma = NO_DMA;
-	hw->ack_intr = ack_intr;
-/*
- *	hw->iops = iops;
- */
-}
-
-
-
 /* 
  * the static array is needed to have the name reported in /proc/ioports,
  * hwif->name unfortunately isn´t available yet
@@ -123,6 +71,8 @@ void q40ide_init(void)
 
     for (i = 0; i < Q40IDE_NUM_HWIFS; i++) {
 	hw_regs_t hw;
+	unsigned long base;
+	unsigned int j;
 
 	name = q40_ide_names[i];
 	if (!request_region(pcide_bases[i], 8, name)) {
@@ -136,11 +86,29 @@ void q40ide_init(void)
 		release_region(pcide_bases[i], 8);
 		continue;
 	}
-	q40_ide_setup_ports(&hw,(unsigned long) pcide_bases[i], (int *)pcide_offsets, 
-			pcide_bases[i]+0x206, 
-			0, NULL,
-//			m68kide_iops,
-			q40ide_default_irq(pcide_bases[i]));
+
+	base = pcide_bases[i];
+
+	/*
+	   Pretranslate addresses for q40 ISA access.
+
+	   BIG FAT WARNING:
+	   assumption: only DATA port is ever used in 16 bit mode
+	 */
+	hw.io_ports[IDE_DATA_OFFSET] = Q40_ISA_IO_W(base);
+
+	for (j = IDE_ERROR_OFFSET; j < IDE_CONTROL_OFFSET; j++)
+		hw.io_ports[j] = Q40_ISA_IO_B(base+j);
+
+	hw.io_ports[IDE_CONTROL_OFFSET] = Q40_ISA_IO_B(base+518);
+
+	/* FIXME: probably wrong, but orginal code did it. */
+	hw.io_ports[IDE_IRQ_OFFSET] = Q40_ISA_IO_B(0);
+
+	hw.irq = q40ide_default_irq(base);
+	hw.dma = NO_DMA;
+	hw.ack_intr = NULL;
+
 	index = ide_register_hw(&hw, &hwif);
 	// **FIXME**
 	if (index != -1)
diff -puN include/linux/ide.h~ide-setup-ports include/linux/ide.h
--- linux-2.6.0-test4-bk3/include/linux/ide.h~ide-setup-ports	2003-09-02 18:07:42.502759104 +0200
+++ linux-2.6.0-test4-bk3-root/include/linux/ide.h	2003-09-02 18:07:42.512757584 +0200
@@ -305,20 +305,6 @@ typedef struct hw_regs_s {
  */
 int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
 
-/*
- * Set up hw_regs_t structure before calling ide_register_hw (optional)
- */
-void ide_setup_ports(	hw_regs_t *hw,
-			unsigned long base,
-			int *offsets,
-			unsigned long ctrl,
-			unsigned long intr,
-			ide_ack_intr_t *ack_intr,
-#if 0
-			ide_io_ops_t *iops,
-#endif
-			int irq);
-
 #include <asm/ide.h>
 
 /* Currently only m68k, apus and m8xx need it */

_

