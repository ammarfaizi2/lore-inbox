Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTEKKXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTEKKXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:23:22 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:20245 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S261233AbTEKKVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:37 -0400
Date: Sun, 11 May 2003 12:31:01 +0200
Message-Id: <200305111031.h4BAV1Tc019694@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k IDE:
  - Update for new-style low-level IDE operations. Since so far no single
    m68k platform uses ISA/PCI I/O space for IDE, we always use the `raw' MMIO
    versions.
  - ATA_ARCH_LOCK was renamed to IDE_ARCH_LOCK
  - Define ide_ack_intr() and set IDE_ARCH_ACK_INTR

--- linux-2.5.x/include/asm-m68k/ide.h	Sun Apr 13 13:53:20 2003
+++ linux-m68k-2.5.x/include/asm-m68k/ide.h	Sun Mar 30 23:02:15 2003
@@ -82,72 +82,64 @@
 {
 }
 
-#undef SUPPORT_SLOW_DATA_PORTS
-#define SUPPORT_SLOW_DATA_PORTS 0
-
-/* this definition is used only on startup .. */
-#undef HD_DATA
-#define HD_DATA NULL
-
-
-/* get rid of defs from io.h - ide has its private and conflicting versions */
+/*
+ * Get rid of defs from io.h - ide has its private and conflicting versions
+ * Since so far no single m68k platform uses ISA/PCI I/O space for IDE, we
+ * always use the `raw' MMIO versions
+ */
 #undef inb
 #undef inw
+#undef insw
+#undef inl
+#undef insl
 #undef outb
 #undef outw
-#undef inb_p
-#undef outb_p
-#undef insw
 #undef outsw
-#undef insw_swapw
-#undef outsw_swapw
-
-/* 
- * define IO method and translation,
- * so far only Q40 has ide-if on ISA 
-*/
-#ifndef CONFIG_Q40
-
-#define ADDR_TRANS_B(_addr_) (_addr_)
-#define ADDR_TRANS_W(_addr_) (_addr_)
-
-#else
-
-#define ADDR_TRANS_B(_addr_) (MACH_IS_Q40 ? ((unsigned char *)Q40_ISA_IO_B(_addr_)) : (_addr_))
-#define ADDR_TRANS_W(_addr_) (MACH_IS_Q40 ? ((unsigned char *)Q40_ISA_IO_W(_addr_)) : (_addr_))
-#endif
-
-#define inb(p)     in_8(ADDR_TRANS_B(p))
-#define inb_p(p)     in_8(ADDR_TRANS_B(p))
-#define inw(p)     in_be16(ADDR_TRANS_W(p))
-#define inw_p(p)     in_be16(ADDR_TRANS_W(p))
-#define outb(v,p)  out_8(ADDR_TRANS_B(p),v)
-#define outb_p(v,p)  out_8(ADDR_TRANS_B(p),v)
-#define outw(v,p)  out_be16(ADDR_TRANS_W(p),v)
-
-#define insw(port, buf, nr) raw_insw(ADDR_TRANS_W(port), buf, nr)
-#define outsw(port, buf, nr) raw_outsw(ADDR_TRANS_W(port), buf, nr)
-
-#define insl(data_reg, buffer, wcount) insw(data_reg, buffer, (wcount)<<1)
-#define outsl(data_reg, buffer, wcount) outsw(data_reg, buffer, (wcount)<<1)
-
-
+#undef outl
+#undef outsl
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
+#define insw_swapw(port, addr, n)	raw_insw_swapw((u16 *)port, addr, n)
+#define outsw_swapw(port, addr, n)	raw_outsw_swapw((u16 *)port, addr, n)
+#endif
 
-#define insl_swapw(data_reg, buffer, wcount) \
-    insw_swapw(data_reg, buffer, (wcount)<<1)
-#define outsl_swapw(data_reg, buffer, wcount) \
-    outsw_swapw(data_reg, buffer, (wcount)<<1)
-
-#define insw_swapw(port, buf, nr) raw_insw_swapw(ADDR_TRANS_W(port), buf, nr)
-#define outsw_swapw(port, buf, nr) raw_outsw_swapw(ADDR_TRANS_W(port),buf,nr)
-
-#endif /* CONFIG_ATARI || CONFIG_Q40 */
 
-#define ATA_ARCH_ACK_INTR
+/* Q40 and Atari have byteswapped IDE busses and since many interesting
+ * values in the identification string are text, chars and words they
+ * happened to be almost correct without swapping.. However *_capacity
+ * is needed for drives over 8 GB. RZ */
+#if defined(CONFIG_Q40) || defined(CONFIG_ATARI)
+#define M68K_IDE_SWAPW  (MACH_IS_Q40 || MACH_IS_ATARI)
+#endif
 
 #ifdef CONFIG_BLK_DEV_FALCON_IDE
-#define ATA_ARCH_LOCK
+#define IDE_ARCH_LOCK
 
 extern int falconide_intr_lock;
 
@@ -175,5 +167,9 @@
 	}
 }
 #endif /* CONFIG_BLK_DEV_FALCON_IDE */
+
+#define IDE_ARCH_ACK_INTR
+#define ide_ack_intr(hwif)	((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)
+
 #endif /* __KERNEL__ */
 #endif /* _M68K_IDE_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
