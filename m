Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTDMM76 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTDMM6q (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:58:46 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:25366 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S263496AbTDMM4L (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:56:11 -0400
Date: Sun, 13 Apr 2003 15:05:13 +0200
Message-Id: <200304131305.h3DD5Drj001281@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] 2.4 IDE driver code for m68k
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE driver and architecture specific updates for m68k:
  - Atari Falcon IDE: Add falconide_intr_lock
  - Amiga A1200/A4000 Gayle IDE: Set hwif->mmio = 2 to prevent the generic IDE
    code from messing with resources
  - Q40 IDE: Fix resource handling, so the interface shows up in /proc/ioports
    while we do use MMIO ops (from Richard Zidlicky)
  - ide_ioreg_t is unsigned long
  - Always use MMIO IDE operations, since so far no single m68k platform uses
    ISA/PCI I/O space for IDE.
  - Make ide_{get,release}_lock() handling completely Atari Falcon-specific
  - Define ide_ack_intr() and set IDE_ARCH_ACK_INTR

--- linux-2.4.21-pre7/drivers/ide/legacy/falconide.c	Thu Feb 27 10:15:46 2003
+++ linux-m68k-2.4.21-pre7/drivers/ide/legacy/falconide.c	Sun Mar 30 22:22:40 2003
@@ -49,6 +49,14 @@
 
 
     /*
+     *  falconide_intr_lock is used to obtain access to the IDE interrupt,
+     *  which is shared between several drivers.
+     */
+
+int falconide_intr_lock;
+
+
+    /*
      *  Probe for a Falcon IDE interface
      */
 
--- linux-2.4.21-pre7/drivers/ide/legacy/gayle.c	Thu Feb 27 10:15:46 2003
+++ linux-m68k-2.4.21-pre7/drivers/ide/legacy/gayle.c	Sun Mar 30 22:22:40 2003
@@ -125,6 +125,7 @@
 	ide_ioreg_t base, ctrlport, irqport;
 	ide_ack_intr_t *ack_intr;
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
 	int index;
 	unsigned long phys_base, res_start, res_n;
 
@@ -154,11 +155,12 @@
 
 	ide_setup_ports(&hw, base, gayle_offsets,
 			ctrlport, irqport, ack_intr,
-//			gaule_iops,
+//			&gayle_iops,
 			IRQ_AMIGA_PORTS);
 
-	index = ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw, &hwif);
 	if (index != -1) {
+	    hwif->mmio = 2;
 	    switch (i) {
 		case 0:
 		    printk("ide%d: Gayle IDE interface (A%d style)\n", index,
--- linux-2.4.21-pre7/drivers/ide/legacy/q40ide.c	Thu Feb 27 10:15:46 2003
+++ linux-m68k-2.4.21-pre7/drivers/ide/legacy/q40ide.c	Wed Apr  9 14:41:28 2003
@@ -31,7 +31,7 @@
 #define PCIDE_BASE5	0x1e0
 #define PCIDE_BASE6	0x160
 
-static const q40ide_ioreg_t pcide_bases[Q40IDE_NUM_HWIFS] = {
+static const ide_ioreg_t pcide_bases[Q40IDE_NUM_HWIFS] = {
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
+#define IDE_OFF_B(x)	((ide_ioreg_t)((IDE_##x##_OFFSET)))
+#define IDE_OFF_W(x)	((ide_ioreg_t)((IDE_##x##_OFFSET)))
 
 static const int pcide_offsets[IDE_NR_PORTS] = {
-    PCIDE_REG(DATA), PCIDE_REG(ERROR), PCIDE_REG(NSECTOR), PCIDE_REG(SECTOR),
-    PCIDE_REG(LCYL), PCIDE_REG(HCYL), PCIDE_REG(CURRENT), PCIDE_REG(STATUS),
-    PCIDE_REG(CMD)
+    IDE_OFF_W(DATA), IDE_OFF_B(ERROR), IDE_OFF_B(NSECTOR), IDE_OFF_B(SECTOR),
+    IDE_OFF_B(LCYL), IDE_OFF_B(HCYL), 6 /*IDE_OFF_B(CURRENT)*/, IDE_OFF_B(STATUS),
+    518/*IDE_OFF(CMD)*/
 };
 
-static int q40ide_default_irq(q40ide_ioreg_t base)
+static int q40ide_default_irq(ide_ioreg_t base)
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
+			ide_ioreg_t base, int *offsets,
+			ide_ioreg_t ctrl, ide_ioreg_t intr,
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
 
-	ide_setup_ports(&hw,(ide_ioreg_t) pcide_bases[i], (int *)pcide_offsets, 
-			pcide_bases[i]+0x206, 
-			0, NULL,
-//			pcide_iops,
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
+	q40_ide_setup_ports(&hw, (ide_ioreg_t)pcide_bases[i],
+			(int *)pcide_offsets,
+			(ide_ioreg_t)pcide_bases[i]+0x206, 0, NULL,
+//			m68kide_iops,
 			q40ide_default_irq(pcide_bases[i]));
-	ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw, &hwif);
+	// **FIXME**
+	if (index != -1)
+		hwif->mmio = 2;
     }
 }
 
--- linux-2.4.21-pre7/include/asm-m68k/hdreg.h	Fri Dec 20 13:21:32 2002
+++ linux-m68k-2.4.21-pre7/include/asm-m68k/hdreg.h	Sun Mar 30 22:22:40 2003
@@ -7,8 +7,6 @@
 #ifndef _M68K_HDREG_H
 #define _M68K_HDREG_H
 
-typedef unsigned int   q40ide_ioreg_t;
-typedef unsigned char * ide_ioreg_t;
-//typedef unsigned long ide_ioreg_t;
+typedef unsigned long ide_ioreg_t;
 
 #endif /* _M68K_HDREG_H */
--- linux-2.4.21-pre7/include/asm-m68k/ide.h	Fri Dec 20 13:21:32 2002
+++ linux-m68k-2.4.21-pre7/include/asm-m68k/ide.h	Sun Mar 30 22:22:40 2003
@@ -50,9 +50,6 @@
 #define MAX_HWIFS	4	/* same as the other archs */
 #endif
 
-/*
- * FIXME: IOPS struct calls needed for taskfile.
- */
 
 static __inline__ int ide_default_irq(ide_ioreg_t base)
 {
@@ -69,7 +66,9 @@
  * Set up a hw structure for a specified data port, control port and IRQ.
  * This should follow whatever the default interface uses.
  */
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+static __inline__ void ide_init_hwif_ports(hw_regs_t *hw,
+					   ide_ioreg_t data_port,
+					   ide_ioreg_t ctrl_port, int *irq)
 {
 	if (data_port || ctrl_port)
 		printk("ide_init_hwif_ports: must not be called\n");
@@ -83,170 +82,94 @@
 {
 }
 
-static __inline__ int ide_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
-			unsigned long flags, const char *device, void *dev_id)
-{
-#ifdef CONFIG_AMIGA
-	if (MACH_IS_AMIGA)
-		return request_irq(irq, handler, 0, device, dev_id);
-#endif /* CONFIG_AMIGA */
-#ifdef CONFIG_Q40
-	if (MACH_IS_Q40)
-	  	return request_irq(irq, handler, 0, device, dev_id);
-#endif /* CONFIG_Q40*/
-#ifdef CONFIG_MAC
-	if (MACH_IS_MAC)
-		return request_irq(irq, handler, 0, device, dev_id);
-#endif /* CONFIG_MAC */
-	return 0;
-}
-
-static __inline__ void ide_free_irq(unsigned int irq, void *dev_id)
-{
-#ifdef CONFIG_AMIGA
-	if (MACH_IS_AMIGA)
-		free_irq(irq, dev_id);
-#endif /* CONFIG_AMIGA */
-#ifdef CONFIG_Q40
-	if (MACH_IS_Q40)
-	  	free_irq(irq, dev_id);
-#endif /* CONFIG_Q40*/
-#ifdef CONFIG_MAC
-	if (MACH_IS_MAC)
-		free_irq(irq, dev_id);
-#endif /* CONFIG_MAC */
-}
-
 /*
- * We should really implement those some day.
- */
-static __inline__ int ide_check_region (ide_ioreg_t from, unsigned int extent)
-{
-	return 0;
-}
-
-static __inline__ void ide_request_region (ide_ioreg_t from, unsigned int extent, const char *name)
-{
-#ifdef CONFIG_Q40
-        if (MACH_IS_Q40)
-            request_region((q40ide_ioreg_t)from,extent,name);
-#endif
-}
-
-static __inline__ void ide_release_region (ide_ioreg_t from, unsigned int extent)
-{
-#ifdef CONFIG_Q40
-        if (MACH_IS_Q40)
-            release_region((q40ide_ioreg_t)from,extent);
-#endif
-}
-
-#undef SUPPORT_SLOW_DATA_PORTS
-#define SUPPORT_SLOW_DATA_PORTS 0
-
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
-/* this definition is used only on startup .. */
-#undef HD_DATA
-#define HD_DATA NULL
-
-
-/*
- * get rid of defs from io.h
- * ide still has some private and conflicting versions
+ * Get rid of defs from io.h - ide has its private and conflicting versions
+ * Since so far no single m68k platform uses ISA/PCI I/O space for IDE, we
+ * always use the `raw' MMIO versions
  */
+#undef inb
+#undef inw
 #undef insw
+#undef inl
 #undef insl
+#undef outb
+#undef outw
 #undef outsw
+#undef outl
 #undef outsl
-
-
-/*
- * define IO method and translation,
- * so far only Q40 has ide-if on ISA
- */
-#ifndef CONFIG_Q40
-
-#define ADDR_TRANS_B(_addr_) (_addr_)
-#define ADDR_TRANS_W(_addr_) (_addr_)
-#define ADDR_TRANS_L(_addr_) (_addr_)
-
-#else
-
-#define ADDR_TRANS_B(_addr_) (MACH_IS_Q40 ? ((unsigned char *)Q40_ISA_IO_B(_addr_)) : (_addr_))
-#define ADDR_TRANS_W(_addr_) (MACH_IS_Q40 ? ((unsigned char *)Q40_ISA_IO_W(_addr_)) : (_addr_))
-#define ADDR_TRANS_L(_addr_) (MACH_IS_Q40 ? ((unsigned char *)Q40_ISA_IO_L(_addr_)) : (_addr_))
-#endif
-
-#define HAVE_ARCH_OUT_BYTE 1
-
-#define OUT_BYTE(v,p)	out_8(ADDR_TRANS_B((p)), (v))
-#define OUT_WORD(v,p)	out_be16(ADDR_TRANS_W((p)), (v))
-#define OUT_LONG(v,p)	out_be32(ADDR_TRANS_L((p)), (v))
-
-#define HAVE_ARCH_IN_BYTE 1
-
-#define IN_BYTE(p)	in_8(ADDR_TRANS_B((p)))
-#define IN_WORD(p)	in_be16(ADDR_TRANS_W((p)))
-#define IN_LONG(p)	in_be32(ADDR_TRANS_L((p)))
-
-#define insw(port, buf, nr) raw_insw(ADDR_TRANS_W(port), buf, nr)
-#define outsw(port, buf, nr) raw_outsw(ADDR_TRANS_W(port), buf, nr)
-
-#define insl(data_reg, buffer, wcount) insw(data_reg, buffer, (wcount)<<1)
-#define outsl(data_reg, buffer, wcount) outsw(data_reg, buffer, (wcount)<<1)
-
-
+#undef readb
+#undef readw
+#undef readl
+#undef writeb
+#undef writew
+#undef writel
+
+#define inb				in_8
+#define inw				in_be16
+#define insw(port, addr, n)		raw_insw((u16 *)port, addr, n)
+#define inl				in_be32
+#define insl(port, addr, n)		raw_insl((u32 *)port, addr, n)
+#define outb(val, port)			out_8(port, val)
+#define outw(val, port)			out_be16(port, val)
+#define outsw(port, addr, n)		raw_outsw((u16 *)port, addr, n)
+#define outl(val, port)			out_be32(port, val)
+#define outsl(port, addr, n)		raw_outsl((u32 *)port, addr, n)
+#define readb				in_8
+#define readw				in_be16
+#define __ide_mm_insw(port, addr, n)	raw_insw((u16 *)port, addr, n)
+#define readl				in_be32
+#define __ide_mm_insl(port, addr, n)	raw_insl((u32 *)port, addr, n)
+#define writeb(val, port)		out_8(port, val)
+#define writew(val, port)		out_be16(port, val)
+#define __ide_mm_outsw(port, addr, n)	raw_outsw((u16 *)port, addr, n)
+#define writel(val, port)		out_be32(port, val)
+#define __ide_mm_outsl(port, addr, n)	raw_outsl((u32 *)port, addr, n)
 #if defined(CONFIG_ATARI) || defined(CONFIG_Q40)
-
-#define insl_swapw(data_reg, buffer, wcount) \
-    insw_swapw(data_reg, buffer, (wcount)<<1)
-#define outsl_swapw(data_reg, buffer, wcount) \
-    outsw_swapw(data_reg, buffer, (wcount)<<1)
-
-#define insw_swapw(port, buf, nr) raw_insw_swapw(ADDR_TRANS_W(port), buf, nr)
-#define outsw_swapw(port, buf, nr) raw_outsw_swapw(ADDR_TRANS_W(port),buf,nr)
-
-#endif /* CONFIG_ATARI || CONFIG_Q40 */
+#define insw_swapw(port, addr, n)	raw_insw_swapw((u16 *)port, addr, n)
+#define outsw_swapw(port, addr, n)	raw_outsw_swapw((u16 *)port, addr, n)
+#endif
 
 
-/* Q40 and Atari have byteswapped IDE bus and since many interesting
+/* Q40 and Atari have byteswapped IDE busses and since many interesting
  * values in the identification string are text, chars and words they
- * happened to be almost correct without swapping.. However *_capacity 
+ * happened to be almost correct without swapping.. However *_capacity
  * is needed for drives over 8 GB. RZ */
 #if defined(CONFIG_Q40) || defined(CONFIG_ATARI)
 #define M68K_IDE_SWAPW  (MACH_IS_Q40 || MACH_IS_ATARI)
 #endif
 
-#ifdef CONFIG_ATARI
-#define IDE_ARCH_LOCK 1
+#ifdef CONFIG_BLK_DEV_FALCON_IDE
+#define IDE_ARCH_LOCK
+
+extern int falconide_intr_lock;
 
-static __inline__ void ide_release_lock (int *ide_lock)
+static __inline__ void ide_release_lock(void)
 {
 	if (MACH_IS_ATARI) {
-		if (*ide_lock == 0) {
+		if (falconide_intr_lock == 0) {
 			printk("ide_release_lock: bug\n");
 			return;
 		}
-		*ide_lock = 0;
+		falconide_intr_lock = 0;
 		stdma_release();
 	}
 }
 
-static __inline__ void ide_get_lock (int *ide_lock, void (*handler)(int, void *, struct pt_regs *), void *data)
+static __inline__ void ide_get_lock(void (*handler)(int, void *, struct pt_regs *), void *data)
 {
 	if (MACH_IS_ATARI) {
-		if (*ide_lock == 0) {
+		if (falconide_intr_lock == 0) {
 			if (in_interrupt() > 0)
 				panic( "Falcon IDE hasn't ST-DMA lock in interrupt" );
 			stdma_lock(handler, data);
-			*ide_lock = 1;
+			falconide_intr_lock = 1;
 		}
 	}
 }
-#endif /* CONFIG_ATARI */
+#endif /* CONFIG_BLK_DEV_FALCON_IDE */
 
-#endif /* __KERNEL__ */
+#define IDE_ARCH_ACK_INTR
+#define ide_ack_intr(hwif)	((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)
 
+#endif /* __KERNEL__ */
 #endif /* _M68K_IDE_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
