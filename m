Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313585AbSDHIRW>; Mon, 8 Apr 2002 04:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313587AbSDHIRV>; Mon, 8 Apr 2002 04:17:21 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:3996 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313585AbSDHIRK>;
	Mon, 8 Apr 2002 04:17:10 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15537.20957.722974.330178@argo.ozlabs.ibm.com>
Date: Mon, 8 Apr 2002 18:16:29 +1000 (EST)
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide-pmac.c update
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

The patch below updates drivers/ide/ide-pmac.c (the powermac IDE
driver) to use the PCI DMA API and to correspond with the recent
changes to the ide driver.  It also arranges for report_drive_dmaing
to be exported from ide-dma.c so ide-pmac.c can use it, and fixes a
minor problem in ide-probe.c where an instance of "ide_floppy" got
missed in the change to ATA_FLOPPY.

Assuming the patch looks OK to you, could you forward it to Linus for
him to apply to his linux-2.5 tree, please?  If you prefer I can make
this available in a bitkeeper tree for you to pull from.

Thanks,
Paul.

diff -urN linux-2.5/drivers/ide/ide-dma.c linuxppc-2.5/drivers/ide/ide-dma.c
--- linux-2.5/drivers/ide/ide-dma.c	Wed Mar 27 13:47:13 2002
+++ linuxppc-2.5/drivers/ide/ide-dma.c	Thu Apr  4 14:48:21 2002
@@ -421,7 +421,7 @@
 	return 0;
 }
 
-static int report_drive_dmaing (ide_drive_t *drive)
+int report_drive_dmaing (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 
diff -urN linux-2.5/drivers/ide/ide-probe.c linuxppc-2.5/drivers/ide/ide-probe.c
--- linux-2.5/drivers/ide/ide-probe.c	Fri Mar 22 13:04:10 2002
+++ linuxppc-2.5/drivers/ide/ide-probe.c	Thu Apr  4 14:48:21 2002
@@ -140,7 +140,7 @@
 				/* kludge for Apple PowerBook internal zip */
 				if (!strstr(id->model, "CD-ROM") && strstr(id->model, "ZIP")) {
 					printk ("FLOPPY");
-					type = ide_floppy;
+					type = ATA_FLOPPY;
 					break;
 				}
 #endif
diff -urN linux-2.5/drivers/ide/ide-pmac.c linuxppc-2.5/drivers/ide/ide-pmac.c
--- linux-2.5/drivers/ide/ide-pmac.c	Wed Mar 27 13:47:13 2002
+++ linuxppc-2.5/drivers/ide/ide-pmac.c	Mon Apr  8 16:29:07 2002
@@ -15,6 +15,16 @@
  * Some code taken from drivers/ide/ide-dma.c:
  *
  *  Copyright (c) 1995-1998  Mark Lord
+ *  
+ * TODO:
+ * 
+ *  - Find a way to duplicate less code with ide-dma and use the
+ *    dma fileds in the hwif structure instead of our own
+ *  - Fix check_disk_change() call
+ *  - Make module-able (includes setting ppc_md. hooks from within
+ *    this file and not from arch code, and handling module deps with
+ *    mediabay (by having both modules do dynamic lookup of each other
+ *    symbols or by storing hooks at arch level).
  *
  */
 #include <linux/config.h>
@@ -24,26 +34,30 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/pci.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/ide.h>
 #include <asm/mediabay.h>
-#include <asm/feature.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/sections.h>
+#include <asm/irq.h>
 #ifdef CONFIG_PMAC_PBOOK
 #include <linux/adb.h>
 #include <linux/pmu.h>
-#include <asm/irq.h>
 #endif
 #include "ata-timing.h"
 
 extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);
+extern spinlock_t ide_lock;
 
 #undef IDE_PMAC_DEBUG
 
-#define IDE_SYSCLK_NS		30
-#define IDE_SYSCLK_ULTRA_PS	0x1d4c /* (15 * 1000 / 2)*/
+#define DMA_WAIT_TIMEOUT	500
 
 struct pmac_ide_hwif {
 	ide_ioreg_t			regbase;
@@ -53,11 +67,20 @@
 	struct device_node*		node;
 	u32				timings[2];
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
+	/* Those fields are duplicating what is in hwif. We currently
+	 * can't use the hwif ones because of some assumptions that are
+	 * beeing done by the generic code about the kind of dma controller
+	 * and format of the dma table. This will have to be fixed though.
+	 */
 	volatile struct dbdma_regs*	dma_regs;
-	struct dbdma_cmd*		dma_table;
-#endif
+	struct dbdma_cmd*		dma_table_cpu;
+	dma_addr_t			dma_table_dma;
+	struct scatterlist*		sg_table;
+	int				sg_nents;
+	int				sg_dma_direction;
+#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 	
-} pmac_ide[MAX_HWIFS];
+} pmac_ide[MAX_HWIFS] __pmacdata;
 
 static int pmac_ide_count;
 
@@ -65,36 +88,160 @@
 	controller_ohare,	/* OHare based */
 	controller_heathrow,	/* Heathrow/Paddington */
 	controller_kl_ata3,	/* KeyLargo ATA-3 */
-	controller_kl_ata4	/* KeyLargo ATA-4 */
+	controller_kl_ata4,	/* KeyLargo ATA-4 */
+	controller_kl_ata4_80	/* KeyLargo ATA-4 with 80 conductor cable */
 };
 
+/*
+ * Extra registers, both 32-bit little-endian
+ */
+#define IDE_TIMING_CONFIG	0x200
+#define IDE_INTERRUPT		0x300
+
+/*
+ * Timing configuration register definitions
+ */
+
+/* Number of IDE_SYSCLK_NS ticks, argument is in nanoseconds */
+#define SYSCLK_TICKS(t)		(((t) + IDE_SYSCLK_NS - 1) / IDE_SYSCLK_NS)
+#define SYSCLK_TICKS_66(t)	(((t) + IDE_SYSCLK_66_NS - 1) / IDE_SYSCLK_66_NS)
+#define IDE_SYSCLK_NS		30	/* 33Mhz cell */
+#define IDE_SYSCLK_66_NS	15	/* 66Mhz cell */
+
+/* 66Mhz cell, found in KeyLargo. Can do ultra mode 0 to 2 on
+ * 40 connector cable and to 4 on 80 connector one.
+ * Clock unit is 15ns (66Mhz)
+ * 
+ * 3 Values can be programmed:
+ *  - Write data setup, which appears to match the cycle time. They
+ *    also call it DIOW setup.
+ *  - Ready to pause time (from spec)
+ *  - Address setup. That one is weird. I don't see where exactly
+ *    it fits in UDMA cycles, I got it's name from an obscure piece
+ *    of commented out code in Darwin. They leave it to 0, we do as
+ *    well, despite a comment that would lead to think it has a
+ *    min value of 45ns.
+ * Apple also add 60ns to the write data setup (or cycle time ?) on
+ * reads. I can't explain that, I tried it and it broke everything
+ * here.
+ */
+#define TR_66_UDMA_MASK			0xfff00000
+#define TR_66_UDMA_EN			0x00100000 /* Enable Ultra mode for DMA */
+#define TR_66_UDMA_ADDRSETUP_MASK	0xe0000000 /* Address setup */
+#define TR_66_UDMA_ADDRSETUP_SHIFT	29
+#define TR_66_UDMA_RDY2PAUS_MASK	0x1e000000 /* Ready 2 pause time */
+#define TR_66_UDMA_RDY2PAUS_SHIFT	25
+#define TR_66_UDMA_WRDATASETUP_MASK	0x01e00000 /* Write data setup time */
+#define TR_66_UDMA_WRDATASETUP_SHIFT	21
+#define TR_66_MDMA_MASK			0x000ffc00
+#define TR_66_MDMA_RECOVERY_MASK	0x000f8000
+#define TR_66_MDMA_RECOVERY_SHIFT	15
+#define TR_66_MDMA_ACCESS_MASK		0x00007c00
+#define TR_66_MDMA_ACCESS_SHIFT		10
+#define TR_66_PIO_MASK			0x000003ff
+#define TR_66_PIO_RECOVERY_MASK		0x000003e0
+#define TR_66_PIO_RECOVERY_SHIFT	5
+#define TR_66_PIO_ACCESS_MASK		0x0000001f
+#define TR_66_PIO_ACCESS_SHIFT		0
+
+/* 33Mhz cell, found in OHare, Heathrow (& Paddington) and KeyLargo
+ * Can do pio & mdma modes, clock unit is 30ns (33Mhz)
+ * 
+ * The access time and recovery time can be programmed. Some older
+ * Darwin code base limit OHare to 150ns cycle time. I decided to do
+ * the same here fore safety against broken old hardware ;)
+ * The HalfTick bit, when set, adds half a clock (15ns) to the access
+ * time and removes one from recovery. It's not supported on KeyLargo
+ * implementation afaik. The E bit appears to be set for PIO mode 0 and
+ * is used to reach long timings used in this mode.
+ */
+#define TR_33_MDMA_MASK			0x003ff800
+#define TR_33_MDMA_RECOVERY_MASK	0x001f0000
+#define TR_33_MDMA_RECOVERY_SHIFT	16
+#define TR_33_MDMA_ACCESS_MASK		0x0000f800
+#define TR_33_MDMA_ACCESS_SHIFT		11
+#define TR_33_MDMA_HALFTICK		0x00200000
+#define TR_33_PIO_MASK			0x000007ff
+#define TR_33_PIO_E			0x00000400
+#define TR_33_PIO_RECOVERY_MASK		0x000003e0
+#define TR_33_PIO_RECOVERY_SHIFT	5
+#define TR_33_PIO_ACCESS_MASK		0x0000001f
+#define TR_33_PIO_ACCESS_SHIFT		0
+
+/*
+ * Interrupt register definitions
+ */
+#define IDE_INTR_DMA			0x80000000
+#define IDE_INTR_DEVICE			0x40000000
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
 # define BAD_DMA_DRIVE		0
 # define GOOD_DMA_DRIVE		1
 
-typedef struct {
+/* Rounded Multiword DMA timings
+ * 
+ * I gave up finding a generic formula for all controller
+ * types and instead, built tables based on timing values
+ * used by Apple in Darwin's implementation.
+ */
+struct mdma_timings_t {
 	int	accessTime;
+	int	recoveryTime;
 	int	cycleTime;
-} pmac_ide_timing;
+};
 
-/* Multiword DMA timings */
-static pmac_ide_timing mdma_timings[] =
+struct mdma_timings_t mdma_timings_33[] __pmacdata =
 {
-    { 215,    480 },	/* Mode 0 */
-    {  80,    150 },	/*      1 */
-    {  70,    120 }	/*      2 */
+    { 240, 240, 480 },
+    { 180, 180, 360 },
+    { 135, 135, 270 },
+    { 120, 120, 240 },
+    { 105, 105, 210 },
+    {  90,  90, 180 },
+    {  75,  75, 150 },
+    {  75,  45, 120 },
+    {   0,   0,   0 }
 };
 
-/* Ultra DMA timings (for use when I know how to calculate them */
-static pmac_ide_timing udma_timings[] =
+struct mdma_timings_t mdma_timings_33k[] __pmacdata =
 {
-    {   0,    114 },	/* Mode 0 */
-    {   0,     75 },	/*      1 */
-    {   0,     55 },	/*      2 */
-    {   100,   45 },	/*      3 */
-    {   100,   25 }	/*      4 */
+    { 240, 240, 480 },
+    { 180, 180, 360 },
+    { 150, 150, 300 },
+    { 120, 120, 240 },
+    {  90, 120, 210 },
+    {  90,  90, 180 },
+    {  90,  60, 150 },
+    {  90,  30, 120 },
+    {   0,   0,   0 }
+};
+
+struct mdma_timings_t mdma_timings_66[] __pmacdata =
+{
+    { 240, 240, 480 },
+    { 180, 180, 360 },
+    { 135, 135, 270 },
+    { 120, 120, 240 },
+    { 105, 105, 210 },
+    {  90,  90, 180 },
+    {  90,  75, 165 },
+    {  75,  45, 120 },
+    {   0,   0,   0 }
+};
+
+/* Ultra DMA timings (rounded) */
+struct {
+	int	addrSetup; /* ??? */
+	int	rdy2pause;
+	int	wrDataSetup;
+} udma_timings[] __pmacdata =
+{
+    {   0, 180,  120 },	/* Mode 0 */
+    {   0, 150,  90 },	/*      1 */
+    {   0, 120,  60 },	/*      2 */
+    {   0, 90,   45 },	/*      3 */
+    {   0, 90,   30 }	/*      4 */
 };
 
 /* allow up to 256 DBDMA commands per xfer */
@@ -124,7 +271,7 @@
 };
 #endif /* CONFIG_PMAC_PBOOK */
 
-static int
+static int __pmac
 pmac_ide_find(ide_drive_t *drive)
 {
 	struct ata_channel *hwif = drive->channel;
@@ -143,7 +290,8 @@
  * N.B. this can't be an initfunc, because the media-bay task can
  * call ide_[un]register at any time.
  */
-void pmac_ide_init_hwif_ports(hw_regs_t *hw,
+void __pmac
+pmac_ide_init_hwif_ports(hw_regs_t *hw,
 			      ide_ioreg_t data_port, ide_ioreg_t ctrl_port,
 			      int *irq)
 {
@@ -174,7 +322,7 @@
 	ide_hwifs[ix].tuneproc = pmac_ide_tuneproc;
 	ide_hwifs[ix].selectproc = pmac_ide_selectproc;
 	ide_hwifs[ix].speedproc = &pmac_ide_tune_chipset;
-	if (pmac_ide[ix].dma_regs && pmac_ide[ix].dma_table) {
+	if (pmac_ide[ix].dma_regs && pmac_ide[ix].dma_table_cpu) {
 		ide_hwifs[ix].dmaproc = &pmac_ide_dmaproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 		if (!noautodma)
@@ -201,24 +349,33 @@
 /* Setup timings for the selected drive (master/slave). I still need to verify if this
  * is enough, I beleive selectproc will be called whenever an IDE command is started,
  * but... */
-static void
+static void __pmac
 pmac_ide_selectproc(ide_drive_t *drive)
 {
 	int i = pmac_ide_find(drive);
 	if (i < 0)
 		return;
-			
-	if (drive->select.all & 0x10)
-		out_le32((unsigned *)(IDE_DATA_REG + 0x200 + _IO_BASE), pmac_ide[i].timings[1]);
+
+	if (drive->select.b.unit & 0x01)
+		out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
+			pmac_ide[i].timings[1]);
 	else
-		out_le32((unsigned *)(IDE_DATA_REG + 0x200 + _IO_BASE), pmac_ide[i].timings[0]);
+		out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
+			pmac_ide[i].timings[0]);
+	(void)in_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE));
 }
 
-/* Number of IDE_SYSCLK_NS ticks, argument is in nanoseconds */
-#define SYSCLK_TICKS(t)		(((t) + IDE_SYSCLK_NS - 1) / IDE_SYSCLK_NS)
-#define SYSCLK_TICKS_UDMA(t)	(((t) + IDE_SYSCLK_ULTRA_PS - 1) / IDE_SYSCLK_ULTRA_PS)
 
-static __inline__ int
+/* Note: We don't use the generic routine here because for some
+ * yet unexplained reasons, it cause some media-bay CD-ROMs to
+ * lockup the bus. Strangely, this new version of the code is
+ * almost identical to the generic one and works, I've not yet
+ * managed to figure out what bit is causing the lockup in the
+ * generic code, possibly a timing issue...
+ * 
+ * --BenH
+ */
+static int __pmac
 wait_for_ready(ide_drive_t *drive)
 {
 	/* Timeout bumped for some powerbooks */
@@ -244,57 +401,80 @@
 	return 0;
 }
 
-/* Note: We don't use the generic routine here because some of Apple's
- * controller seem to be very sensitive about how things are done.
- * We should probably set the NIEN bit, but that's an example of thing
- * that can cause the controller to hang under some circumstances when
- * done on the media-bay CD-ROM during boot. We do get occasional
- * spurrious interrupts because of that.
- * --BenH
- */
-static int
+static int __pmac
 pmac_ide_do_setfeature(ide_drive_t *drive, byte command)
 {
-	unsigned long flags;
 	int result = 1;
-
-	save_flags(flags);
-	cli();
+	unsigned long flags;
+	struct ata_channel *hwif = HWIF(drive);
+	
+	disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
 	udelay(1);
 	SELECT_DRIVE(drive->channel, drive);
 	SELECT_MASK(drive->channel, drive, 0);
 	udelay(1);
+	(void)GET_STAT(); /* Get rid of pending error state */
 	if(wait_for_ready(drive)) {
 		printk(KERN_ERR "pmac_ide_do_setfeature disk not ready before SET_FEATURE!\n");
 		goto out;
 	}
-	OUT_BYTE(SETFEATURES_XFER, IDE_FEATURE_REG);
+	udelay(10);
+	OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
 	OUT_BYTE(command, IDE_NSECTOR_REG);
+	OUT_BYTE(SETFEATURES_XFER, IDE_FEATURE_REG);
 	OUT_BYTE(WIN_SETFEATURES, IDE_COMMAND_REG);
 	udelay(1);
+	__save_flags(flags);	/* local CPU only */
+	ide__sti();		/* local CPU only -- for jiffies */
 	result = wait_for_ready(drive);
+	__restore_flags(flags); /* local CPU only */
+	OUT_BYTE(drive->ctl, IDE_CONTROL_REG);
 	if (result)
 		printk(KERN_ERR "pmac_ide_do_setfeature disk not ready after SET_FEATURE !\n");
 out:
-	restore_flags(flags);
+	SELECT_MASK(HWIF(drive), drive, 0);
+	if (result == 0) {
+		drive->id->dma_ultra &= ~0xFF00;
+		drive->id->dma_mword &= ~0x0F00;
+		drive->id->dma_1word &= ~0x0F00;
+		switch(command) {
+			case XFER_UDMA_7:   drive->id->dma_ultra |= 0x8080; break;
+			case XFER_UDMA_6:   drive->id->dma_ultra |= 0x4040; break;
+			case XFER_UDMA_5:   drive->id->dma_ultra |= 0x2020; break;
+			case XFER_UDMA_4:   drive->id->dma_ultra |= 0x1010; break;
+			case XFER_UDMA_3:   drive->id->dma_ultra |= 0x0808; break;
+			case XFER_UDMA_2:   drive->id->dma_ultra |= 0x0404; break;
+			case XFER_UDMA_1:   drive->id->dma_ultra |= 0x0202; break;
+			case XFER_UDMA_0:   drive->id->dma_ultra |= 0x0101; break;
+			case XFER_MW_DMA_2: drive->id->dma_mword |= 0x0404; break;
+			case XFER_MW_DMA_1: drive->id->dma_mword |= 0x0202; break;
+			case XFER_MW_DMA_0: drive->id->dma_mword |= 0x0101; break;
+			case XFER_SW_DMA_2: drive->id->dma_1word |= 0x0404; break;
+			case XFER_SW_DMA_1: drive->id->dma_1word |= 0x0202; break;
+			case XFER_SW_DMA_0: drive->id->dma_1word |= 0x0101; break;
+			default: break;
+		}
+	}
+	enable_irq(hwif->irq);
 
 	return result;
 }
 
 /* Calculate PIO timings */
-static void
+static void __pmac
 pmac_ide_tuneproc(ide_drive_t *drive, byte pio)
 {
 	struct ata_timing *t;
 	int i;
 	u32 *timings;
-	int accessTicks, recTicks;
+	unsigned accessTicks, recTicks;
+	unsigned accessTime, recTime;
 
 	i = pmac_ide_find(drive);
 	if (i < 0)
 		return;
 
-	if (pio = 255)
+	if (pio == 255)
 		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
 	else
 		pio = XFER_PIO_0 + min_t(byte, pio, 4);
@@ -302,27 +482,40 @@
 	t = ata_timing_data(pio);
 
 	accessTicks = SYSCLK_TICKS(t->active);
-	if (drive->select.all & 0x10)
-		timings = &pmac_ide[i].timings[1];
-	else
-		timings = &pmac_ide[i].timings[0];
-
-	if (pmac_ide[i].kind == controller_kl_ata4) {
-		/* The "ata-4" IDE controller of Core99 machines */
-		accessTicks = SYSCLK_TICKS_UDMA(t->active * 1000);
-		recTicks = SYSCLK_TICKS_UDMA(t->cycle * 1000) - accessTicks;
+	timings = &pmac_ide[i].timings[drive->select.b.unit & 0x01];
 
-		*timings = ((*timings) & 0x1FFFFFC00) | accessTicks | (recTicks << 5);
+	recTime = t->cycle - t->active - t->setup;
+	recTime = max(recTime, 150U);
+	accessTime = t->active;
+	accessTime = max(accessTime, 150U);
+	if (pmac_ide[i].kind == controller_kl_ata4 ||
+		pmac_ide[i].kind == controller_kl_ata4_80) {
+		/* 66Mhz cell */
+		accessTicks = SYSCLK_TICKS_66(accessTime);
+		accessTicks = min(accessTicks, 0x1fU);
+		recTicks = SYSCLK_TICKS_66(recTime);
+		recTicks = min(recTicks, 0x1fU);
+		*timings = ((*timings) & ~TR_66_PIO_MASK) |
+				(accessTicks << TR_66_PIO_ACCESS_SHIFT) |
+				(recTicks << TR_66_PIO_RECOVERY_SHIFT);
 	} else {
-		/* The old "ata-3" IDE controller */
-		accessTicks = SYSCLK_TICKS(t->active);
-		if (accessTicks < 4)
-			accessTicks = 4;
-		recTicks = SYSCLK_TICKS(t->cycle) - accessTicks - 4;
-		if (recTicks < 1)
-			recTicks = 1;
-	
-		*timings = ((*timings) & 0xFFFFFF800) | accessTicks | (recTicks << 5);
+		/* 33Mhz cell */
+		int ebit = 0;
+		accessTicks = SYSCLK_TICKS(accessTime);
+		accessTicks = min(accessTicks, 0x1fU);
+		accessTicks = max(accessTicks, 4U);
+		recTicks = SYSCLK_TICKS(recTime);
+		recTicks = min(recTicks, 0x1fU);
+		recTicks = max(recTicks, 5U) - 4;
+		if (recTicks > 9) {
+			recTicks--; /* guess, but it's only for PIO0, so... */
+			ebit = 1;
+		}
+		*timings = ((*timings) & ~TR_33_PIO_MASK) |
+				(accessTicks << TR_33_PIO_ACCESS_SHIFT) |
+				(recTicks << TR_33_PIO_RECOVERY_SHIFT);
+		if (ebit)
+			*timings |= TR_33_PIO_E;
 	}
 
 #ifdef IDE_PMAC_DEBUG
@@ -335,70 +528,134 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
-static int
-set_timings_udma(int intf, u32 *timings, byte speed)
+static int __pmac
+set_timings_udma(u32 *timings, byte speed)
 {
-	int cycleTime, accessTime;
-	int rdyToPauseTicks, cycleTicks;
-
-	if (pmac_ide[intf].kind != controller_kl_ata4)
-		return 1;
-		
-	cycleTime = udma_timings[speed & 0xf].cycleTime;
-	accessTime = udma_timings[speed & 0xf].accessTime;
-
-	rdyToPauseTicks = SYSCLK_TICKS_UDMA(accessTime * 1000);
-	cycleTicks = SYSCLK_TICKS_UDMA(cycleTime * 1000);
+	unsigned rdyToPauseTicks, wrDataSetupTicks, addrTicks;
 
-	*timings = ((*timings) & 0xe00fffff) |
-			((cycleTicks << 1) | (rdyToPauseTicks << 5) | 1) << 20;
+	rdyToPauseTicks = SYSCLK_TICKS_66(udma_timings[speed & 0xf].rdy2pause);
+	wrDataSetupTicks = SYSCLK_TICKS_66(udma_timings[speed & 0xf].wrDataSetup);
+	addrTicks = SYSCLK_TICKS_66(udma_timings[speed & 0xf].addrSetup);
+
+	*timings = ((*timings) & ~(TR_66_UDMA_MASK | TR_66_MDMA_MASK)) |
+			(wrDataSetupTicks << TR_66_UDMA_WRDATASETUP_SHIFT) | 
+			(rdyToPauseTicks << TR_66_UDMA_RDY2PAUS_SHIFT) |
+			(addrTicks <<TR_66_UDMA_ADDRSETUP_SHIFT) |
+			TR_66_UDMA_EN;
+#ifdef IDE_PMAC_DEBUG
+	printk(KERN_ERR "ide_pmac: Set UDMA timing for mode %d, reg: 0x%08x\n",
+		speed & 0xf,  *timings);
+#endif	
 
 	return 0;
 }
 
-static int
-set_timings_mdma(int intf, u32 *timings, byte speed)
+static int __pmac
+set_timings_mdma(int intf_type, u32 *timings, byte speed, int drive_cycle_time)
 {
-	int cycleTime, accessTime;
-	int accessTicks, recTicks;
+	int cycleTime, accessTime, recTime;
+	unsigned accessTicks, recTicks;
+	struct mdma_timings_t* tm;
+	int i;
 
-	/* Calculate accesstime and cycle time */
-	cycleTime = mdma_timings[speed & 0xf].cycleTime;
-	accessTime = mdma_timings[speed & 0xf].accessTime;
-	if ((pmac_ide[intf].kind == controller_ohare) && (cycleTime < 150))
+	/* Get default cycle time for mode */
+	switch(speed & 0xf) {
+		case 0: cycleTime = 480; break;
+		case 1: cycleTime = 150; break;
+		case 2: cycleTime = 120; break;
+		default:
+			return -1;
+	}
+	/* Adjust for drive */
+	if (drive_cycle_time && drive_cycle_time > cycleTime)
+		cycleTime = drive_cycle_time;
+	/* OHare limits according to some old Apple sources */	
+	if ((intf_type == controller_ohare) && (cycleTime < 150))
 		cycleTime = 150;
+	/* Get the proper timing array for this controller */
+	switch(intf_type) {
+		case controller_kl_ata4:
+		case controller_kl_ata4_80:
+			tm = mdma_timings_66;
+			break;
+		case controller_kl_ata3:
+			tm = mdma_timings_33k;
+			break;
+		default:
+			tm = mdma_timings_33;
+			break;
+	}
+	/* Lookup matching access & recovery times */
+	i = -1;
+	for (;;) {
+		if (tm[i+1].cycleTime < cycleTime)
+			break;
+		i++;
+	}
+	if (i < 0)
+		return -1;
+	cycleTime = tm[i].cycleTime;
+	accessTime = tm[i].accessTime;
+	recTime = tm[i].recoveryTime;
 
-	/* For ata-4 controller */
-	if (pmac_ide[intf].kind == controller_kl_ata4) {
-		accessTicks = SYSCLK_TICKS_UDMA(accessTime * 1000);
-		recTicks = SYSCLK_TICKS_UDMA(cycleTime * 1000) - accessTicks;
-		*timings = ((*timings) & 0xffe003ff) |
-			(accessTicks | (recTicks << 5)) << 10;
+#ifdef IDE_PMAC_DEBUG
+	printk(KERN_ERR "ide_pmac: MDMA, cycleTime: %d, accessTime: %d, recTime: %d\n",
+		cycleTime, accessTime, recTime);
+#endif	
+	if (intf_type == controller_kl_ata4 || intf_type == controller_kl_ata4_80) {
+		/* 66Mhz cell */
+		accessTicks = SYSCLK_TICKS_66(accessTime);
+		accessTicks = min(accessTicks, 0x1fU);
+		accessTicks = max(accessTicks, 0x1U);
+		recTicks = SYSCLK_TICKS_66(recTime);
+		recTicks = min(recTicks, 0x1fU);
+		recTicks = max(recTicks, 0x3U);
+		/* Clear out mdma bits and disable udma */
+		*timings = ((*timings) & ~(TR_66_MDMA_MASK | TR_66_UDMA_MASK)) |
+			(accessTicks << TR_66_MDMA_ACCESS_SHIFT) |
+			(recTicks << TR_66_MDMA_RECOVERY_SHIFT);
+	} else if (intf_type == controller_kl_ata3) {
+		/* 33Mhz cell on KeyLargo */
+		accessTicks = SYSCLK_TICKS(accessTime);
+		accessTicks = max(accessTicks, 1U);
+		accessTicks = min(accessTicks, 0x1fU);
+		accessTime = accessTicks * IDE_SYSCLK_NS;
+		recTicks = SYSCLK_TICKS(recTime);
+		recTicks = max(recTicks, 1U);
+		recTicks = min(recTicks, 0x1fU);
+		*timings = ((*timings) & ~TR_33_MDMA_MASK) |
+				(accessTicks << TR_33_MDMA_ACCESS_SHIFT) |
+				(recTicks << TR_33_MDMA_RECOVERY_SHIFT);
 	} else {
+		/* 33Mhz cell on others */
 		int halfTick = 0;
 		int origAccessTime = accessTime;
-		int origCycleTime = cycleTime;
+		int origRecTime = recTime;
 		
 		accessTicks = SYSCLK_TICKS(accessTime);
-		if (accessTicks < 1)
-			accessTicks = 1;
+		accessTicks = max(accessTicks, 1U);
+		accessTicks = min(accessTicks, 0x1fU);
 		accessTime = accessTicks * IDE_SYSCLK_NS;
-		recTicks = SYSCLK_TICKS(cycleTime - accessTime) - 1;
-		if (recTicks < 1)
-			recTicks = 1;
-		cycleTime = (recTicks + 1 + accessTicks) * IDE_SYSCLK_NS;
-
-		/* KeyLargo ata-3 don't support the half-tick stuff */
-		if ((pmac_ide[intf].kind != controller_kl_ata3) &&
-			(accessTicks > 1) &&
-			((accessTime - IDE_SYSCLK_NS/2) >= origAccessTime) &&
-			((cycleTime - IDE_SYSCLK_NS) >= origCycleTime)) {
-            			halfTick    = 1;
-				accessTicks--;
+		recTicks = SYSCLK_TICKS(recTime);
+		recTicks = max(recTicks, 2U) - 1;
+		recTicks = min(recTicks, 0x1fU);
+		recTime = (recTicks + 1) * IDE_SYSCLK_NS;
+		if ((accessTicks > 1) &&
+		    ((accessTime - IDE_SYSCLK_NS/2) >= origAccessTime) &&
+		    ((recTime - IDE_SYSCLK_NS/2) >= origRecTime)) {
+            		halfTick = 1;
+			accessTicks--;
 		}
-		*timings = ((*timings) & 0x7FF) |
-			(accessTicks | (recTicks << 5) | (halfTick << 10)) << 11;
+		*timings = ((*timings) & ~TR_33_MDMA_MASK) |
+				(accessTicks << TR_33_MDMA_ACCESS_SHIFT) |
+				(recTicks << TR_33_MDMA_RECOVERY_SHIFT);
+		if (halfTick)
+			*timings |= TR_33_MDMA_HALFTICK;
 	}
+#ifdef IDE_PMAC_DEBUG
+	printk(KERN_ERR "ide_pmac: Set MDMA timing for mode %d, reg: 0x%08x\n",
+		speed & 0xf,  *timings);
+#endif	
 	return 0;
 }
 #endif /* #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC */
@@ -406,11 +663,11 @@
 /* You may notice we don't use this function on normal operation,
  * our, normal mdma function is supposed to be more precise
  */
-static int
+static int __pmac
 pmac_ide_tune_chipset (ide_drive_t *drive, byte speed)
 {
 	int intf		= pmac_ide_find(drive);
-	int unit		= (drive->select.all & 0x10) ? 1:0;
+	int unit		= (drive->select.b.unit & 0x01);
 	int ret			= 0;
 	u32 *timings;
 
@@ -423,19 +680,25 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 		case XFER_UDMA_4:
 		case XFER_UDMA_3:
+			if (pmac_ide[intf].kind != controller_kl_ata4_80)
+				return 1;		
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
-			ret = set_timings_udma(intf, timings, speed);
+			if (pmac_ide[intf].kind != controller_kl_ata4 &&
+				pmac_ide[intf].kind != controller_kl_ata4_80)
+				return 1;		
+			ret = set_timings_udma(timings, speed);
 			break;
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
+			ret = set_timings_mdma(pmac_ide[intf].kind, timings, speed, 0);
+			break;
 		case XFER_SW_DMA_2:
 		case XFER_SW_DMA_1:
 		case XFER_SW_DMA_0:
-			ret = set_timings_mdma(intf, timings, speed);
-			break;
+			return 1;
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 		case XFER_PIO_4:
 		case XFER_PIO_3:
@@ -460,13 +723,46 @@
 	return 0;
 }
 
-ide_ioreg_t
+static void __pmac
+sanitize_timings(int i)
+{
+	unsigned value;
+	
+	switch(pmac_ide[i].kind) {
+		case controller_kl_ata4:
+		case controller_kl_ata4_80:
+			value = 0x0008438c;
+			break;
+		case controller_kl_ata3:
+			value = 0x00084526;
+			break;
+		case controller_heathrow:
+		case controller_ohare:
+		default:
+			value = 0x00074526;
+			break;
+	}
+	pmac_ide[i].timings[0] = pmac_ide[i].timings[1] = value;
+}
+
+ide_ioreg_t __pmac
 pmac_ide_get_base(int index)
 {
 	return pmac_ide[index].regbase;
 }
 
-int
+int __pmac
+pmac_ide_check_base(ide_ioreg_t base)
+{
+	int ix;
+	
+ 	for (ix = 0; ix < MAX_HWIFS; ++ix)
+		if (base == pmac_ide[ix].regbase)
+			return ix;
+	return -1;
+}
+
+int __pmac
 pmac_ide_get_irq(ide_ioreg_t base)
 {
 	int ix;
@@ -477,7 +773,7 @@
 	return 0;
 }
 
-static int ide_majors[] = { 3, 22, 33, 34, 56, 57 };
+static int ide_majors[]  __pmacdata = { 3, 22, 33, 34, 56, 57 };
 
 kdev_t __init
 pmac_find_ide_boot(char *bootdevice, int n)
@@ -494,11 +790,11 @@
 		name = pmac_ide[i].node->full_name;
 		if (memcmp(name, bootdevice, n) == 0 && name[n] == 0) {
 			/* XXX should cope with the 2nd drive as well... */
-			return MKDEV(ide_majors[i], 0);
+			return mk_kdev(ide_majors[i], 0);
 		}
 	}
 
-	return 0;
+	return NODEV;
 }
 
 void __init
@@ -541,9 +837,12 @@
 
 	for (i = 0, np = atas; i < MAX_HWIFS && np != NULL; np = np->next) {
 		struct device_node *tp;
+		struct pmac_ide_hwif *pmif;
 		int *bidp;
 		int in_bay = 0;
-
+		u8 pbus, pid;
+		struct pci_dev *pdev = NULL;
+		
 		/*
 		 * If this node is not under a mac-io or dbdma node,
 		 * leave it to the generic PCI driver.
@@ -561,6 +860,15 @@
 			continue;
 		}
 
+		/* We need to find the pci_dev of the mac-io holding the
+		 * IDE interface
+		 */
+		if (pci_device_from_OF_node(tp, &pbus, &pid) == 0)
+			pdev = pci_find_slot(pbus, pid);
+		if (pdev == NULL)
+			printk(KERN_WARNING "ide: no PCI host for device %s, DMA disabled\n",
+			       np->full_name);
+		
 		/*
 		 * If this slot is taken (e.g. by ide-pci.c) try the next one.
 		 */
@@ -569,8 +877,23 @@
 			++i;
 		if (i >= MAX_HWIFS)
 			break;
+		pmif = &pmac_ide[i];
 
-		base = (unsigned long) ioremap(np->addrs[0].address, 0x200) - _IO_BASE;
+		/*
+		 * Some older OFs have bogus sizes, causing request_OF_resource
+		 * to fail. We fix them up here
+		 */
+		if (np->addrs[0].size > 0x1000)
+			np->addrs[0].size = 0x1000;
+		if (np->n_addrs > 1 && np->addrs[1].size > 0x100)
+			np->addrs[1].size = 0x100;
+
+		if (request_OF_resource(np, 0, "  (mac-io IDE IO)") == NULL) {
+			printk(KERN_ERR "ide-pmac(%s): can't request IO resource !\n", np->name);
+			continue;
+		}
+
+		base = (unsigned long) ioremap(np->addrs[0].address, 0x400) - _IO_BASE;
 
 		/* XXX This is bogus. Should be fixed in the registry by checking
 		   the kind of host interrupt controller, a bit like gatwick
@@ -583,21 +906,30 @@
 		} else {
 			irq = np->intrs[0].line;
 		}
-		pmac_ide[i].regbase = base;
-		pmac_ide[i].irq = irq;
-		pmac_ide[i].node = np;
+		pmif->regbase = base;
+		pmif->irq = irq;
+		pmif->node = np;
 		if (device_is_compatible(np, "keylargo-ata")) {
 			if (strcmp(np->name, "ata-4") == 0)
-				pmac_ide[i].kind = controller_kl_ata4;
+				pmif->kind = controller_kl_ata4;
 			else
-				pmac_ide[i].kind = controller_kl_ata3;
+				pmif->kind = controller_kl_ata3;
 		} else if (device_is_compatible(np, "heathrow-ata"))
-			pmac_ide[i].kind = controller_heathrow;
+			pmif->kind = controller_heathrow;
 		else
-			pmac_ide[i].kind = controller_ohare;
+			pmif->kind = controller_ohare;
 
 		bidp = (int *)get_property(np, "AAPL,bus-id", NULL);
-		pmac_ide[i].aapl_bus_id =  bidp ? *bidp : 0;
+		pmif->aapl_bus_id =  bidp ? *bidp : 0;
+
+		if (pmif->kind == controller_kl_ata4) {
+			char* cable = get_property(np, "cable-type", NULL);
+			if (cable && !strncmp(cable, "80-", 3))
+				pmif->kind = controller_kl_ata4_80;
+		}
+
+		/* Make sure we have sane timings */
+		sanitize_timings(i);
 
 		if (np->parent && np->parent->name
 		    && strcasecmp(np->parent->name, "media-bay") == 0) {
@@ -605,39 +937,22 @@
 			media_bay_set_ide_infos(np->parent,base,irq,i);
 #endif /* CONFIG_PMAC_PBOOK */
 			in_bay = 1;
-		} else if (pmac_ide[i].kind == controller_ohare) {
+			if (!bidp)
+				pmif->aapl_bus_id = 1;
+		} else if (pmif->kind == controller_ohare) {
 			/* The code below is having trouble on some ohare machines
 			 * (timing related ?). Until I can put my hand on one of these
 			 * units, I keep the old way
 			 */
-			 feature_set(np, FEATURE_IDE0_enable);
+			ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, 0, 1);
 		} else {
  			/* This is necessary to enable IDE when net-booting */
 			printk(KERN_INFO "pmac_ide: enabling IDE bus ID %d\n",
-				pmac_ide[i].aapl_bus_id);
-			switch(pmac_ide[i].aapl_bus_id) {
-			    case 0:
-				feature_set(np, FEATURE_IDE0_reset);
-				mdelay(10);
- 				feature_set(np, FEATURE_IDE0_enable);
-				mdelay(10);
-				feature_clear(np, FEATURE_IDE0_reset);
-				break;
-			    case 1:
-				feature_set(np, FEATURE_IDE1_reset);
-				mdelay(10);
- 				feature_set(np, FEATURE_IDE1_enable);
-				mdelay(10);
-				feature_clear(np, FEATURE_IDE1_reset);
-				break;
-			    case 2:
-			    	/* This one exists only for KL, I don't know
-				   about any enable bit */
-				feature_set(np, FEATURE_IDE2_reset);
-				mdelay(10);
-				feature_clear(np, FEATURE_IDE2_reset);
-				break;
-			}
+				pmif->aapl_bus_id);
+			ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmif->aapl_bus_id, 1);
+			ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmif->aapl_bus_id, 1);
+			mdelay(10);
+			ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmif->aapl_bus_id, 0);
 			big_delay = 1;
 		}
 
@@ -646,13 +961,15 @@
 		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 		hwif->chipset = ide_pmac;
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET] || in_bay;
+		hwif->udma_four = (pmif->kind == controller_kl_ata4_80);
+		hwif->pci_dev = pdev;
 #ifdef CONFIG_PMAC_PBOOK
 		if (in_bay && check_media_bay_by_base(base, MB_CD) == 0)
 			hwif->noprobe = 0;
 #endif /* CONFIG_PMAC_PBOOK */
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
-		if (np->n_addrs >= 2) {
+		if (pdev && np->n_addrs >= 2) {
 			/* has a DBDMA controller channel */
 			pmac_ide_setup_dma(np, i);
 		}
@@ -674,7 +991,15 @@
 static void __init 
 pmac_ide_setup_dma(struct device_node *np, int ix)
 {
-	pmac_ide[ix].dma_regs =
+	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
+
+	if (request_OF_resource(np, 1, " (mac-io IDE DMA)") == NULL) {
+		printk(KERN_ERR "ide-pmac(%s): can't request DMA resource !\n",
+			np->name);
+		return;
+	}
+
+	pmif->dma_regs =
 		(volatile struct dbdma_regs*)ioremap(np->addrs[1].address, 0x200);
 
 	/*
@@ -682,14 +1007,24 @@
 	 * The +2 is +1 for the stop command and +1 to allow for
 	 * aligning the start address to a multiple of 16 bytes.
 	 */
-	pmac_ide[ix].dma_table = (struct dbdma_cmd*)
-	       kmalloc((MAX_DCMDS + 2) * sizeof(struct dbdma_cmd), GFP_KERNEL);
-	if (pmac_ide[ix].dma_table == 0) {
+	pmif->dma_table_cpu = (struct dbdma_cmd*)pci_alloc_consistent(
+		ide_hwifs[ix].pci_dev,
+		(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
+		&pmif->dma_table_dma);
+	if (pmif->dma_table_cpu == NULL) {
 		printk(KERN_ERR "%s: unable to allocate DMA command list\n",
 		       ide_hwifs[ix].name);
 		return;
 	}
 
+	pmif->sg_table = kmalloc(sizeof(struct scatterlist) * MAX_DCMDS,
+				 GFP_KERNEL);
+	if (pmif->sg_table == NULL) {
+		pci_free_consistent(	ide_hwifs[ix].pci_dev,
+					(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
+				    	pmif->dma_table_cpu, pmif->dma_table_dma);
+		return;
+	}
 	ide_hwifs[ix].dmaproc = &pmac_ide_dmaproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)
@@ -697,6 +1032,62 @@
 #endif
 }
 
+static int
+pmac_ide_build_sglist (int ix, struct request *rq)
+{
+	struct ata_channel *hwif = &ide_hwifs[ix];
+	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
+	request_queue_t *q = &hwif->drives[DEVICE_NR(rq->rq_dev) & 1].queue;
+	struct scatterlist *sg = pmif->sg_table;
+	int nents;
+
+	nents = blk_rq_map_sg(q, rq, pmif->sg_table);
+
+	if (rq->q && nents > rq->nr_phys_segments)
+		printk("ide-pmac: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
+
+	if (rq_data_dir(rq) == READ)
+		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+	else
+		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
+
+	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
+}
+
+static int
+pmac_ide_raw_build_sglist (int ix, struct request *rq)
+{
+	struct ata_channel *hwif = &ide_hwifs[ix];
+	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
+	struct scatterlist *sg = pmif->sg_table;
+	int nents = 0;
+	ide_task_t *args = rq->special;
+	unsigned char *virt_addr = rq->buffer;
+	int sector_count = rq->nr_sectors;
+
+	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
+		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
+	else
+		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+
+	if (sector_count > 128) {
+		memset(&sg[nents], 0, sizeof(*sg));
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+		sg[nents].length = 128  * SECTOR_SIZE;
+		nents++;
+		virt_addr = virt_addr + (128 * SECTOR_SIZE);
+		sector_count -= 128;
+	}
+	memset(&sg[nents], 0, sizeof(*sg));
+	sg[nents].page = virt_to_page(virt_addr);
+	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+	sg[nents].length =  sector_count  * SECTOR_SIZE;
+	nents++;
+
+	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
+}
+
 /*
  * pmac_ide_build_dmatable builds the DBDMA command list
  * for a transfer and sets the DBDMA channel to point to it.
@@ -704,47 +1095,40 @@
 static int
 pmac_ide_build_dmatable(ide_drive_t *drive, int ix, int wr)
 {
-	struct dbdma_cmd *table, *tstart;
-	int count = 0;
+	struct dbdma_cmd *table;
+	int i, count = 0;
 	struct request *rq = HWGROUP(drive)->rq;
-	struct buffer_head *bh = rq->bh;
-	unsigned int size, addr;
 	volatile struct dbdma_regs *dma = pmac_ide[ix].dma_regs;
+	struct scatterlist *sg;
+
+	/* DMA table is already aligned */
+	table = (struct dbdma_cmd *) pmac_ide[ix].dma_table_cpu;
 
-	table = tstart = (struct dbdma_cmd *) DBDMA_ALIGN(pmac_ide[ix].dma_table);
+	/* Make sure DMA controller is stopped (necessary ?) */
 	out_le32(&dma->control, (RUN|PAUSE|FLUSH|WAKE|DEAD) << 16);
 	while (in_le32(&dma->status) & RUN)
 		udelay(1);
 
-	do {
-		/*
-		 * Determine addr and size of next buffer area.  We assume that
-		 * individual virtual buffers are always composed linearly in
-		 * physical memory.  For example, we assume that any 8kB buffer
-		 * is always composed of two adjacent physical 4kB pages rather
-		 * than two possibly non-adjacent physical 4kB pages.
-		 */
-		if (bh == NULL) {  /* paging requests have (rq->bh == NULL) */
-			addr = virt_to_bus(rq->buffer);
-			size = rq->nr_sectors << 9;
-		} else {
-			/* group sequential buffers into one large buffer */
-			addr = virt_to_bus(bh->b_data);
-			size = bh->b_size;
-			while ((bh = bh->b_reqnext) != NULL) {
-				if ((addr + size) != virt_to_bus(bh->b_data))
-					break;
-				size += bh->b_size;
-			}
-		}
+	/* Build sglist */
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
+		pmac_ide[ix].sg_nents = i = pmac_ide_raw_build_sglist(ix, rq);
+	} else {
+		pmac_ide[ix].sg_nents = i = pmac_ide_build_sglist(ix, rq);
+	}
+	if (!i)
+		return 0;
 
-		/*
-		 * Fill in the next DBDMA command block.
-		 * Note that one DBDMA command can transfer
-		 * at most 65535 bytes.
-		 */
-		while (size) {
-			unsigned int tc = (size < 0xfe00)? size: 0xfe00;
+	/* Build DBDMA commands list */
+	sg = pmac_ide[ix].sg_table;
+	while (i) {
+		u32 cur_addr;
+		u32 cur_len;
+
+		cur_addr = sg_dma_address(sg);
+		cur_len = sg_dma_len(sg);
+
+		while (cur_len) {
+			unsigned int tc = (cur_len < 0xfe00)? cur_len: 0xfe00;
 
 			if (++count >= MAX_DCMDS) {
 				printk(KERN_WARNING "%s: DMA table too small\n",
@@ -753,15 +1137,17 @@
 			}
 			st_le16(&table->command, wr? OUTPUT_MORE: INPUT_MORE);
 			st_le16(&table->req_count, tc);
-			st_le32(&table->phy_addr, addr);
+			st_le32(&table->phy_addr, cur_addr);
 			table->cmd_dep = 0;
 			table->xfer_status = 0;
 			table->res_count = 0;
-			addr += tc;
-			size -= tc;
+			cur_addr += tc;
+			cur_len -= tc;
 			++table;
 		}
-	} while (bh != NULL);
+		sg++;
+		i--;
+	}
 
 	/* convert the last command to an input/output last command */
 	if (count)
@@ -773,10 +1159,24 @@
 	memset(table, 0, sizeof(struct dbdma_cmd));
 	out_le16(&table->command, DBDMA_STOP);
 
-	out_le32(&dma->cmdptr, virt_to_bus(tstart));
+	out_le32(&dma->cmdptr, pmac_ide[ix].dma_table_dma);
 	return 1;
 }
 
+/* Teardown mappings after DMA has completed.  */
+static void
+pmac_ide_destroy_dmatable (ide_drive_t *drive, int ix)
+{
+	struct pci_dev *dev = HWIF(drive)->pci_dev;
+	struct scatterlist *sg = pmac_ide[ix].sg_table;
+	int nents = pmac_ide[ix].sg_nents;
+
+	if (nents) {
+		pci_unmap_sg(dev, sg, nents, pmac_ide[ix].sg_dma_direction);
+		pmac_ide[ix].sg_nents = 0;
+	}
+}
+
 
 static __inline__ unsigned char
 dma_bits_to_command(unsigned char bits)
@@ -791,12 +1191,14 @@
 }
 
 static __inline__ unsigned char
-udma_bits_to_command(unsigned char bits)
+udma_bits_to_command(unsigned char bits, int high_speed)
 {
-	if(bits & 0x10)
-		return XFER_UDMA_4;
-	if(bits & 0x08)
-		return XFER_UDMA_3;
+	if (high_speed) {
+		if(bits & 0x10)
+			return XFER_UDMA_4;
+		if(bits & 0x08)
+			return XFER_UDMA_3;
+	}
 	if(bits & 0x04)
 		return XFER_UDMA_2;
 	if(bits & 0x02)
@@ -807,14 +1209,13 @@
 }
 
 /* Calculate MultiWord DMA timings */
-static int
+static int __pmac
 pmac_ide_mdma_enable(ide_drive_t *drive, int idx)
 {
 	byte bits = drive->id->dma_mword & 0x07;
 	byte feature = dma_bits_to_command(bits);
 	u32 *timings;
-	int cycleTime, accessTime;
-	int accessTicks, recTicks;
+	int drive_cycle_time;
 	struct hd_driveid *id = drive->id;
 	int ret;
 
@@ -830,66 +1231,30 @@
 		drive->init_speed = feature;
 	
 	/* which drive is it ? */
-	if (drive->select.all & 0x10)
+	if (drive->select.b.unit & 0x01)
 		timings = &pmac_ide[idx].timings[1];
 	else
 		timings = &pmac_ide[idx].timings[0];
 
-	/* Calculate accesstime and cycle time */
-	cycleTime = mdma_timings[feature & 0xf].cycleTime;
-	accessTime = mdma_timings[feature & 0xf].accessTime;
+	/* Check if drive provide explicit cycle time */
 	if ((id->field_valid & 2) && (id->eide_dma_time))
-		cycleTime = id->eide_dma_time;
-	if ((pmac_ide[idx].kind == controller_ohare) && (cycleTime < 150))
-		cycleTime = 150;
+		drive_cycle_time = id->eide_dma_time;
+	else
+		drive_cycle_time = 0;
+
+	/* Calculate controller timings */
+	set_timings_mdma(pmac_ide[idx].kind, timings, feature, drive_cycle_time);
 
-	/* For ata-4 controller */
-	if (pmac_ide[idx].kind == controller_kl_ata4) {
-		accessTicks = SYSCLK_TICKS_UDMA(accessTime * 1000);
-		recTicks = SYSCLK_TICKS_UDMA(cycleTime * 1000) - accessTicks;
-		*timings = ((*timings) & 0xffe003ff) |
-			(accessTicks | (recTicks << 5)) << 10;
-	} else {
-		int halfTick = 0;
-		int origAccessTime = accessTime;
-		int origCycleTime = cycleTime;
-		
-		accessTicks = SYSCLK_TICKS(accessTime);
-		if (accessTicks < 1)
-			accessTicks = 1;
-		accessTime = accessTicks * IDE_SYSCLK_NS;
-		recTicks = SYSCLK_TICKS(cycleTime - accessTime) - 1;
-		if (recTicks < 1)
-			recTicks = 1;
-		cycleTime = (recTicks + 1 + accessTicks) * IDE_SYSCLK_NS;
-
-		/* KeyLargo ata-3 don't support the half-tick stuff */
-		if ((pmac_ide[idx].kind != controller_kl_ata3) &&
-			(accessTicks > 1) &&
-			((accessTime - IDE_SYSCLK_NS/2) >= origAccessTime) &&
-			((cycleTime - IDE_SYSCLK_NS) >= origCycleTime)) {
-            			halfTick    = 1;
-				accessTicks--;
-		}
-		*timings = ((*timings) & 0x7FF) |
-			(accessTicks | (recTicks << 5) | (halfTick << 10)) << 11;
-	}
-#ifdef IDE_PMAC_DEBUG
-	printk(KERN_INFO "ide_pmac: Set MDMA timing for mode %d, reg: 0x%08x\n",
-		feature & 0xf, *timings);
-#endif
 	drive->current_speed = feature;	
 	return 1;
 }
 
 /* Calculate Ultra DMA timings */
-static int
-pmac_ide_udma_enable(ide_drive_t *drive, int idx)
+static int __pmac
+pmac_ide_udma_enable(ide_drive_t *drive, int idx, int high_speed)
 {
 	byte bits = drive->id->dma_ultra & 0x1f;
-	byte feature = udma_bits_to_command(bits);
-	int cycleTime, accessTime;
-	int rdyToPauseTicks, cycleTicks;
+	byte feature = udma_bits_to_command(bits, high_speed);
 	u32 *timings;
 	int ret;
 
@@ -905,25 +1270,18 @@
 		drive->init_speed = feature;
 
 	/* which drive is it ? */
-	if (drive->select.all & 0x10)
+	if (drive->select.b.unit & 0x01)
 		timings = &pmac_ide[idx].timings[1];
 	else
 		timings = &pmac_ide[idx].timings[0];
 
-	cycleTime = udma_timings[feature & 0xf].cycleTime;
-	accessTime = udma_timings[feature & 0xf].accessTime;
-
-	rdyToPauseTicks = SYSCLK_TICKS_UDMA(accessTime * 1000);
-	cycleTicks = SYSCLK_TICKS_UDMA(cycleTime * 1000);
-
-	*timings = ((*timings) & 0xe00fffff) |
-			((cycleTicks << 1) | (rdyToPauseTicks << 5) | 1) << 20;
+	set_timings_udma(timings, feature);
 
 	drive->current_speed = feature;	
 	return 1;
 }
 
-static int
+static int __pmac
 pmac_ide_check_dma(ide_drive_t *drive)
 {
 	int ata4, udma, idx;
@@ -944,21 +1302,20 @@
 		enable = 0;
 
 	udma = 0;
-	ata4 = (pmac_ide[idx].kind == controller_kl_ata4);
+	ata4 = (pmac_ide[idx].kind == controller_kl_ata4 ||
+		pmac_ide[idx].kind == controller_kl_ata4_80);
 
 	if(enable) {
 		if (ata4 && (drive->type == ATA_DISK) &&
-		    (id->field_valid & 0x0004) && (id->dma_ultra & 0x17)) {
+		    (id->field_valid & 0x0004) && (id->dma_ultra & 0x1f)) {
 			/* UltraDMA modes. */
-			drive->using_dma = pmac_ide_udma_enable(drive, idx);
+			drive->using_dma = pmac_ide_udma_enable(drive, idx,
+				pmac_ide[idx].kind == controller_kl_ata4_80);
 		}
 		if (!drive->using_dma && (id->dma_mword & 0x0007)) {
 			/* Normal MultiWord DMA modes. */
 			drive->using_dma = pmac_ide_mdma_enable(drive, idx);
 		}
-		/* Without this, strange things will happen on Keylargo-based
-		 * machines
-		 */
 		OUT_BYTE(0, IDE_CONTROL_REG);
 		/* Apply settings to controller */
 		pmac_ide_selectproc(drive);
@@ -966,11 +1323,26 @@
 	return 0;
 }
 
+static void ide_toggle_bounce(ide_drive_t *drive, int on)
+{
+	dma64_addr_t addr = BLK_BOUNCE_HIGH;
+
+	if (on && drive->type == ATA_DISK && HWIF(drive)->highmem) {
+		if (!PCI_DMA_BUS_IS_PHYS)
+			addr = BLK_BOUNCE_ANY;
+		else
+			addr = HWIF(drive)->pci_dev->dma_mask;
+	}
+
+	blk_queue_bounce_limit(&drive->queue, addr);
+}
+
 int pmac_ide_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
 {
-	int ix, dstat, i;
+	int ix, dstat, reading, ata4;
 	volatile struct dbdma_regs *dma;
-
+	byte unit = (drive->select.b.unit & 0x01);
+	
 	/* Can we stuff a pointer to our intf structure in config_data
 	 * or select_data in hwif ?
 	 */
@@ -978,59 +1350,106 @@
 	if (ix < 0)
 		return 0;		
 	dma = pmac_ide[ix].dma_regs;
-
+	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
+		pmac_ide[ix].kind == controller_kl_ata4_80);
+	
 	switch (func) {
 	case ide_dma_off:
 		printk(KERN_INFO "%s: DMA disabled\n", drive->name);
 	case ide_dma_off_quietly:
 		drive->using_dma = 0;
+		ide_toggle_bounce(drive, 0);
 		break;
 	case ide_dma_on:
 	case ide_dma_check:
+		/* Change this to better match ide-dma.c */
 		pmac_ide_check_dma(drive);
+		ide_toggle_bounce(drive, drive->using_dma);
 		break;
 	case ide_dma_read:
 	case ide_dma_write:
-		if (!pmac_ide_build_dmatable(drive, ix, func==ide_dma_write))
+		/* this almost certainly isn't needed since we don't
+		   appear to have a rwproc */
+		if (HWIF(drive)->rwproc)
+			HWIF(drive)->rwproc(drive, func);
+		reading = (func == ide_dma_read);
+		if (!pmac_ide_build_dmatable(drive, ix, !reading))
 			return 1;
+		/* Apple adds 60ns to wrDataSetup on reads */
+		if (ata4 && (pmac_ide[ix].timings[unit] & TR_66_UDMA_EN)) {
+			out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
+				pmac_ide[ix].timings[unit] + 
+				((func == ide_dma_read) ? 0x00800000UL : 0));
+			(void)in_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE));
+		}
 		drive->waiting_for_dma = 1;
 		if (drive->type != ATA_DISK)
 			return 0;
 		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-		OUT_BYTE(func==ide_dma_write? WIN_WRITEDMA: WIN_READDMA,
-			 IDE_COMMAND_REG);
+		if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
+		    (drive->addressing == 1)) {
+			ide_task_t *args = HWGROUP(drive)->rq->special;
+			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+		} else if (drive->addressing) {
+			OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
+		} else {
+			OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+		}
+		/* fall through */
 	case ide_dma_begin:
 		out_le32(&dma->control, (RUN << 16) | RUN);
+		/* Make sure it gets to the controller right now */
+		(void)in_le32(&dma->control);
 		break;
-	case ide_dma_end:
+	case ide_dma_end: /* returns 1 on error, 0 otherwise */
 		drive->waiting_for_dma = 0;
 		dstat = in_le32(&dma->status);
 		out_le32(&dma->control, ((RUN|WAKE|DEAD) << 16));
+		pmac_ide_destroy_dmatable(drive, ix);
 		/* verify good dma status */
 		return (dstat & (RUN|DEAD|ACTIVE)) != RUN;
-	case ide_dma_test_irq:
-		if ((in_le32(&dma->status) & (RUN|ACTIVE)) == RUN)
-			return 1;
-		/* That's a bit ugly and dangerous, but works in our case
-		 * to workaround a problem with the channel status staying
-		 * active if the drive returns an error
+	case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
+		/* We have to things to deal with here:
+		 * 
+		 * - The dbdma won't stop if the command was started
+		 * but completed with an error without transfering all
+		 * datas. This happens when bad blocks are met during
+		 * a multi-block transfer.
+		 * 
+		 * - The dbdma fifo hasn't yet finished flushing to
+		 * to system memory when the disk interrupt occurs.
+		 * 
+		 * The trick here is to increment drive->waiting_for_dma,
+		 * and return as if no interrupt occured. If the counter
+		 * reach a certain timeout value, we then return 1. If
+		 * we really got the interrupt, it will happen right away
+		 * again.
+		 * Apple's solution here may be more elegant. They issue
+		 * a DMA channel interrupt (a separate irq line) via a DBDMA
+		 * NOP command just before the STOP, and wait for both the
+		 * disk and DBDMA interrupts to have completed.
 		 */
-		if (IDE_CONTROL_REG) {
-			byte stat;
-			stat = GET_ALTSTAT();
-			if (stat & ERR_STAT)
-				return 1;
-		}
-		/* In some edge cases, some datas may still be in the dbdma
-		 * engine fifo, we wait a bit for dbdma to complete
+		 
+		/* If ACTIVE is cleared, the STOP command have passed and
+		 * transfer is complete.
 		 */
-		while ((in_le32(&dma->status) & (RUN|ACTIVE)) != RUN) {
-			if (++i > 100)
-				return 0;
-			udelay(1);
+		if (!(in_le32(&dma->status) & ACTIVE))
+			return 1;
+		if (!drive->waiting_for_dma)
+			printk(KERN_WARNING "ide%d, ide_dma_test_irq \
+				called while not waiting\n", ix);
+
+		/* If dbdma didn't execute the STOP command yet, the
+		 * active bit is still set */
+		drive->waiting_for_dma++;
+		if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
+			printk(KERN_WARNING "ide%d, timeout waiting \
+				for dbdma command stop\n", ix);
+			return 1;
 		}
-		return 1;
+		udelay(1);
+		return 0;
 
 		/* Let's implement tose just in case someone wants them */
 	case ide_dma_bad_drive:
@@ -1051,7 +1470,6 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
-#ifdef CONFIG_PMAC_PBOOK
 static void idepmac_sleep_device(ide_drive_t *drive, int i, unsigned base)
 {
 	int j;
@@ -1062,7 +1480,9 @@
 	switch (drive->type) {
 	case ATA_DISK:
 		/* Spin down the drive */
-		outb(0xa0, base+0x60);
+		outb(drive->select.all, base+0x60);
+		(void)inb(base+0x60);
+		udelay(100);
 		outb(0x0, base+0x30);
 		outb(0x0, base+0x20);
 		outb(0x0, base+0x40);
@@ -1086,19 +1506,21 @@
 	}
 }
 
-static void idepmac_wake_device(ide_drive_t *drive, int used_dma)
- {
+#ifdef CONFIG_PMAC_PBOOK
+static void __pmac
+idepmac_wake_device(ide_drive_t *drive, int used_dma)
+{
 	/* We force the IDE subdriver to check for a media change
 	 * This must be done first or we may lost the condition
 	 *
 	 * Problem: This can schedule. I moved the block device
 	 * wakeup almost late by priority because of that.
 	 */
-	if (DRIVER(drive) && DRIVER(drive)->media_change)
-		DRIVER(drive)->media_change(drive);
+	if (drive->driver != NULL && ata_ops(drive)->check_media_change)
+		ata_ops(drive)->check_media_change(drive);
 
 	/* We kick the VFS too (see fix in ide.c revalidate) */
-	check_disk_change(MKDEV(drive->channel->major, (drive->select.b.unit) << PARTN_BITS));
+	check_disk_change(mk_kdev(drive->channel->major, (drive->select.b.unit) << PARTN_BITS));
 	
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	/* We re-enable DMA on the drive if it was active. */
@@ -1108,15 +1530,16 @@
 	 */
 	if (used_dma && !ide_spin_wait_hwgroup(drive)) {
 		/* Lock HW group */
-		HWGROUP(drive)->busy = 1;
+		set_bit(IDE_BUSY, &HWGROUP(drive)->flags);
 		pmac_ide_check_dma(drive);
-		HWGROUP(drive)->busy = 0;
+		clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
 		spin_unlock_irq(&ide_lock);
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 }
 
-static void idepmac_sleep_interface(int i, unsigned base, int mediabay)
+static void __pmac
+idepmac_sleep_interface(int i, unsigned base, int mediabay)
 {
 	struct device_node* np = pmac_ide[i].node;
 
@@ -1128,73 +1551,81 @@
 	if (mediabay)
 		return;
 	
-	/* Disable and reset the bus */
-	feature_set(np, FEATURE_IDE0_reset);
-	feature_clear(np, FEATURE_IDE0_enable);
-	switch(pmac_ide[i].aapl_bus_id) {
-	    case 0:
-		feature_set(np, FEATURE_IDE0_reset);
-		feature_clear(np, FEATURE_IDE0_enable);
-		break;
-	    case 1:
-		feature_set(np, FEATURE_IDE1_reset);
-		feature_clear(np, FEATURE_IDE1_enable);
-		break;
-	    case 2:
-		feature_set(np, FEATURE_IDE2_reset);
-		break;
-	}
+	/* Disable the bus */
+	ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmac_ide[i].aapl_bus_id, 0);
 }
 
-static void idepmac_wake_interface(int i, unsigned long base, int mediabay)
+static void __pmac
+idepmac_wake_interface(int i, unsigned long base, int mediabay)
 {
 	struct device_node* np = pmac_ide[i].node;
 
 	if (!mediabay) {
 		/* Revive IDE disk and controller */
-		switch(pmac_ide[i].aapl_bus_id) {
-		    case 0:
-			feature_set(np, FEATURE_IDE0_reset);
-			feature_set(np, FEATURE_IOBUS_enable);
-			mdelay(10);
-	 		feature_set(np, FEATURE_IDE0_enable);
-			mdelay(10);
-			feature_clear(np, FEATURE_IDE0_reset);
-			break;
-		    case 1:
-			feature_set(np, FEATURE_IDE1_reset);
-			feature_set(np, FEATURE_IOBUS_enable);
-			mdelay(10);
-	 		feature_set(np, FEATURE_IDE1_enable);
-			mdelay(10);
-			feature_clear(np, FEATURE_IDE1_reset);
-			break;
-		    case 2:
-		    	/* This one exists only for KL, I don't know
-			   about any enable bit */
-			feature_set(np, FEATURE_IDE2_reset);
-			mdelay(10);
-			feature_clear(np, FEATURE_IDE2_reset);
-			break;
-		}
+		ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmac_ide[i].aapl_bus_id, 1);
+		ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmac_ide[i].aapl_bus_id, 1);
+		mdelay(10);
+		ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmac_ide[i].aapl_bus_id, 0);
 	}
+}
+
+static void
+idepmac_sleep_drive(ide_drive_t *drive, int idx, unsigned long base)
+{
+	/* Wait for HW group to complete operations */
+	if (ide_spin_wait_hwgroup(drive))
+		// What can we do here ? Wake drive we had already
+		// put to sleep and return an error ?
+		return;
+	else {
+		/* Lock HW group */
+		set_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+		/* Stop the device */
+		idepmac_sleep_device(drive, idx, base);
+		spin_unlock_irq(&ide_lock);
+	}
+}
+
+static void
+idepmac_wake_drive(ide_drive_t *drive, unsigned long base)
+{
+	int j;
 	
 	/* Reset timings */
-	pmac_ide_selectproc(&ide_hwifs[i].drives[0]);
+	pmac_ide_selectproc(drive);
 	mdelay(10);
+	
+	/* Wait up to 20 seconds for the drive to be ready */
+	for (j = 0; j < 200; j++) {
+		int status;
+		mdelay(100);
+		outb(drive->select.all, base + 0x60);
+		if (inb(base + 0x60) != drive->select.all)
+			continue;
+		status = inb(base + 0x70);
+		if (!(status & BUSY_STAT))
+			break;
+	}
+
+	/* We resume processing on the HW group */
+	spin_lock_irq(&ide_lock);
+	clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+	if (!list_empty(&drive->queue.queue_head))
+		do_ide_request(&drive->queue);
+	spin_unlock_irq(&ide_lock);
 }
 
 /* Note: We support only master drives for now. This will have to be
  * improved if we want to handle sleep on the iMacDV where the CD-ROM
  * is a slave
  */
-static int idepmac_notify_sleep(struct pmu_sleep_notifier *self, int when)
+static int __pmac
+idepmac_notify_sleep(struct pmu_sleep_notifier *self, int when)
 {
 	int i, ret;
 	unsigned long base;
-	unsigned long flags;
 	int big_delay;
-
+ 
 	switch (when) {
 	case PBOOK_SLEEP_REQUEST:
 		break;
@@ -1203,34 +1634,19 @@
 	case PBOOK_SLEEP_NOW:
 		for (i = 0; i < pmac_ide_count; ++i) {
 			struct ata_channel *hwif;
-			ide_drive_t *drive;
-			int unlock = 0;
+			int dn;
 
 			if ((base = pmac_ide[i].regbase) == 0)
-				continue;	
+				continue;
 
 			hwif = &ide_hwifs[i];
-			drive = &hwif->drives[0];
-			
-			if (drive->present) {
-				/* Wait for HW group to complete operations */
-				if (ide_spin_wait_hwgroup(drive)) {
-					// What can we do here ? Wake drive we had already
-					// put to sleep and return an error ?
-				} else {
-					unlock = 1;
-					/* Lock HW group */
-					HWGROUP(drive)->busy = 1;
-
-					/* Stop the device */
-					idepmac_sleep_device(drive, i, base);
-				
-				}
+			for (dn=0; dn<MAX_DRIVES; dn++) {
+				if (!hwif->drives[dn].present)
+					continue;
+				idepmac_sleep_drive(&hwif->drives[dn], i, base);
 			}
 			/* Disable irq during sleep */
 			disable_irq(pmac_ide[i].irq);
-			if (unlock)
-				spin_unlock_irq(&ide_lock);
 			
 			/* Check if this is a media bay with an IDE device or not
 			 * a media bay.
@@ -1247,6 +1663,9 @@
 			if ((base = pmac_ide[i].regbase) == 0)
 				continue;
 				
+			/* Make sure we have sane timings */		
+			sanitize_timings(i);
+
 			/* Check if this is a media bay with an IDE device or not
 			 * a media bay
 			 */
@@ -1263,43 +1682,29 @@
 	
 		for (i = 0; i < pmac_ide_count; ++i) {
 			struct ata_channel *hwif;
-			ide_drive_t *drive;
-			int j, used_dma;
+			int used_dma, dn;
+			int irq_on = 0;
 			
 			if ((base = pmac_ide[i].regbase) == 0)
 				continue;
 				
 			hwif = &ide_hwifs[i];
-			drive = &hwif->drives[0];
-
-			/* Wait for the drive to come up and set it's DMA */
-			if (drive->present) {
-				/* Wait up to 20 seconds */
-				for (j = 0; j < 200; j++) {
-					int status;
-					mdelay(100);
-					status = inb(base + 0x70);
-					if (!(status & BUSY_STAT))
-						break;
+			for (dn=0; dn<MAX_DRIVES; dn++) {
+				ide_drive_t *drive = &hwif->drives[dn];
+				if (!drive->present)
+					continue;
+				/* We don't have re-configured DMA yet */
+				used_dma = drive->using_dma;
+				drive->using_dma = 0;
+				idepmac_wake_drive(drive, base);
+				if (!irq_on) {
+					enable_irq(pmac_ide[i].irq);
+					irq_on = 1;
 				}
-			}
-			
-			/* We don't have re-configured DMA yet */
-			used_dma = drive->using_dma;
-			drive->using_dma = 0;
-
-			/* We resume processing on the HW group */
-			spin_lock_irqsave(&ide_lock, flags);
-			enable_irq(pmac_ide[i].irq);
-			if (drive->present)
-				HWGROUP(drive)->busy = 0;
-			spin_unlock_irqrestore(&ide_lock, flags);
-			
-			/* Wake the device
-			 * We could handle the slave here
-			 */
-			if (drive->present)
 				idepmac_wake_device(drive, used_dma);
+			}
+			if (!irq_on)
+				enable_irq(pmac_ide[i].irq);
 		}
 		break;
 	}
