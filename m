Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbTEKK0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTEKKYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:24:54 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:63570 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261248AbTEKKVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:40 -0400
Date: Sun, 11 May 2003 12:31:02 +0200
Message-Id: <200305111031.h4BAV2TT019700@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Q40/Q60 IDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q40/Q60 IDE: Use the standard IDE operations, which are always MMIO on m68k,
but make sure IDE shows up in /proc/ioports (from Richard Zidlicky).

--- linux-2.5.x/drivers/ide/legacy/q40ide.c	Tue Feb 25 11:39:23 2003
+++ linux-m68k-2.5.x/drivers/ide/legacy/q40ide.c	Sun Mar  9 12:29:58 2003
@@ -31,7 +31,7 @@
 #define PCIDE_BASE5	0x1e0
 #define PCIDE_BASE6	0x160
 
-static const q40ide_ioreg_t pcide_bases[Q40IDE_NUM_HWIFS] = {
+static const unsigned long pcide_bases[Q40IDE_NUM_HWIFS] = {
     PCIDE_BASE1, PCIDE_BASE2, /* PCIDE_BASE3, PCIDE_BASE4  , PCIDE_BASE5,
     PCIDE_BASE6 */
 };
@@ -41,23 +41,21 @@
      *  Offsets from one of the above bases
      */
 
+/* used to do addr translation here but it is easier to do in setup ports */
+/*#define IDE_OFF_B(x)	((unsigned long)Q40_ISA_IO_B((IDE_##x##_OFFSET)))*/
 
-/* HD_DATA was redefined in asm-m68k/ide.h */
-#undef HD_DATA
-#define HD_DATA  0x1f0
-
-
-#define PCIDE_REG(x)	((q40ide_ioreg_t)(HD_##x-PCIDE_BASE1))
+#define IDE_OFF_B(x)	((unsigned long)((IDE_##x##_OFFSET)))
+#define IDE_OFF_W(x)	((unsigned long)((IDE_##x##_OFFSET)))
 
 static const int pcide_offsets[IDE_NR_PORTS] = {
-    PCIDE_REG(DATA), PCIDE_REG(ERROR), PCIDE_REG(NSECTOR), PCIDE_REG(SECTOR),
-    PCIDE_REG(LCYL), PCIDE_REG(HCYL), PCIDE_REG(CURRENT), PCIDE_REG(STATUS),
-    PCIDE_REG(CMD)
+    IDE_OFF_W(DATA), IDE_OFF_B(ERROR), IDE_OFF_B(NSECTOR), IDE_OFF_B(SECTOR),
+    IDE_OFF_B(LCYL), IDE_OFF_B(HCYL), 6 /*IDE_OFF_B(CURRENT)*/, IDE_OFF_B(STATUS),
+    518/*IDE_OFF(CMD)*/
 };
 
-static int q40ide_default_irq(q40ide_ioreg_t base)
+static int q40ide_default_irq(unsigned long base)
 {
-           switch (base) { 
+           switch (base) {
 	            case 0x1f0: return 14;
 		    case 0x170: return 15;
 		    case 0x1e8: return 11;
@@ -67,14 +65,58 @@
 }
 
 
+/*
+ * This is very similar to ide_setup_ports except that addresses
+ * are pretranslated for q40 ISA access
+ */
+void q40_ide_setup_ports ( hw_regs_t *hw,
+			unsigned long base, int *offsets,
+			unsigned long ctrl, unsigned long intr,
+			ide_ack_intr_t *ack_intr,
+/*
+ *			ide_io_ops_t *iops,
+ */
+			int irq)
+{
+	int i;
 
-    /*
-     *  Probe for Q40 IDE interfaces
-     */
+	for (i = 0; i < IDE_NR_PORTS; i++) {
+		/* BIG FAT WARNING: 
+		   assumption: only DATA port is ever used in 16 bit mode */
+		if ( i==0 )
+			hw->io_ports[i] = Q40_ISA_IO_W(base + offsets[i]);
+		else
+			hw->io_ports[i] = Q40_ISA_IO_B(base + offsets[i]);
+	}
+	
+	hw->irq = irq;
+	hw->dma = NO_DMA;
+	hw->ack_intr = ack_intr;
+/*
+ *	hw->iops = iops;
+ */
+}
+
+
+
+/* 
+ * the static array is needed to have the name reported in /proc/ioports,
+ * hwif->name unfortunately isn´t available yet
+ */
+static const char *q40_ide_names[Q40IDE_NUM_HWIFS]={
+	"ide0", "ide1"
+};
+
+/*
+ *  Probe for Q40 IDE interfaces
+ */
 
 void q40ide_init(void)
 {
     int i;
+    ide_hwif_t *hwif;
+    int index;
+    const char *name;
 
     if (!MACH_IS_Q40)
       return ;
@@ -82,12 +124,27 @@
     for (i = 0; i < Q40IDE_NUM_HWIFS; i++) {
 	hw_regs_t hw;
 
-	ide_setup_ports(&hw,(unsigned long) pcide_bases[i], (int *)pcide_offsets, 
+	name = q40_ide_names[i];
+	if (!request_region(pcide_bases[i], 8, name)) {
+		printk("could not reserve ports %lx-%lx for %s\n",
+		       pcide_bases[i],pcide_bases[i]+8,name);
+		continue;
+	}
+	if (!request_region(pcide_bases[i]+0x206, 1, name)) {
+		printk("could not reserve port %lx for %s\n",
+		       pcide_bases[i]+0x206,name);
+		release_region(pcide_bases[i], 8);
+		continue;
+	}
+	q40_ide_setup_ports(&hw,(unsigned long) pcide_bases[i], (int *)pcide_offsets, 
 			pcide_bases[i]+0x206, 
 			0, NULL,
-//			pcide_iops,
+//			m68kide_iops,
 			q40ide_default_irq(pcide_bases[i]));
-	ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw, &hwif);
+	// **FIXME**
+	if (index != -1)
+		hwif->mmio = 2;
     }
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
