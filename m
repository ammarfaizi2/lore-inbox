Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263495AbTDMM76 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTDMM6B (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:58:01 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:9490 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S263495AbTDMM4K (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:56:10 -0400
Date: Sun, 13 Apr 2003 15:05:12 +0200
Message-Id: <200304131305.h3DD5C6X001275@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] 2.4 IDE core code for m68k
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE core code updates for m68k. Most of these are already in 2.5.x.
  - Remove first parameter of ide_{get,release}_lock() so it can be handled
    completely inside the Atari Falcon-specific code
  - outsl() returns void
  - Both Atari and Q40 have byteswapped IDE interfaces
  - Fix drive ID swapping (perhaps we want some arch-specific function call
    here?)
  - Print irq number in decimal
  - ide_ack_intr() is defined by arch-specific code if IDE_ARCH_ACK_INTR is set

--- linux-2.4.x/drivers/ide/ide-io.c	Sun Apr  6 10:28:46 2003
+++ linux-m68k-2.4.21-pre7/drivers/ide/ide-io.c	Sun Apr  6 11:29:19 2003
@@ -788,7 +788,7 @@
 	ide_startstop_t	startstop;
 
 	/* for atari only: POSSIBLY BROKEN HERE(?) */
-	ide_get_lock(&ide_intr_lock, ide_intr, hwgroup);
+	ide_get_lock(ide_intr, hwgroup);
 
 	/* necessary paranoia: ensure IRQs are masked on local CPU */
 	local_irq_disable();
@@ -828,7 +828,7 @@
 				 */
 
 				/* for atari only */
-				ide_release_lock(&ide_intr_lock);
+				ide_release_lock();
 				hwgroup->busy = 0;
 			}
 			/* no more work for this hwgroup (for now) */
--- linux-2.4.21-pre7/drivers/ide/ide-iops.c	Sun Apr  6 10:28:46 2003
+++ linux-m68k-2.4.21-pre7/drivers/ide/ide-iops.c	Sun Apr  6 11:29:19 2003
@@ -157,7 +157,7 @@
 
 static void ide_outsl (unsigned long port, void *addr, u32 count)
 {
-	return outsl(port, addr, count);
+	outsl(port, addr, count);
 }
 
 void default_hwif_iops (ide_hwif_t *hwif)
@@ -393,7 +393,7 @@
 		insw_swapw(IDE_DATA_REG, buffer, bytecount / 2);
 		return;
 	}
-#endif /* CONFIG_ATARI */
+#endif /* CONFIG_ATARI || CONFIG_Q40 */
 	hwif->ata_input_data(drive, buffer, bytecount / 4);
 	if ((bytecount & 0x03) >= 2)
 		hwif->INSW(IDE_DATA_REG, ((u8 *)buffer)+(bytecount & ~0x03), 1);
@@ -412,7 +412,7 @@
 		outsw_swapw(IDE_DATA_REG, buffer, bytecount / 2);
 		return;
 	}
-#endif /* CONFIG_ATARI */
+#endif /* CONFIG_ATARI || CONFIG_Q40 */
 	hwif->ata_output_data(drive, buffer, bytecount / 4);
 	if ((bytecount & 0x03) >= 2)
 		hwif->OUTSW(IDE_DATA_REG, ((u8*)buffer)+(bytecount & ~0x03), 1);
@@ -429,6 +429,23 @@
 # ifdef __BIG_ENDIAN
 	int i;
 	u16 *stringcast;
+
+#ifdef __mc68000__
+	if (!MACH_IS_AMIGA && !MACH_IS_MAC && !MACH_IS_Q40 && !MACH_IS_ATARI)
+		return;
+
+#ifdef M68K_IDE_SWAPW
+	if (M68K_IDE_SWAPW) {	/* fix bus byteorder first */
+		u_char *p = (u_char *)id;
+		u_char t;
+		for (i = 0; i < 512; i += 2) {
+			t = p[i];
+			p[i] = p[i+1];
+			p[i+1] = t;
+		}
+	}
+#endif
+#endif /* __mc68000__ */
 
 	id->config         = __le16_to_cpu(id->config);
 	id->cyls           = __le16_to_cpu(id->cyls);
--- linux-2.4.21-pre7/drivers/ide/ide-probe.c	Sun Apr  6 10:28:47 2003
+++ linux-m68k-2.4.21-pre7/drivers/ide/ide-probe.c	Sun Apr  6 11:29:19 2003
@@ -1136,7 +1136,7 @@
 		hwif->io_ports[IDE_DATA_OFFSET]+7,
 		hwif->io_ports[IDE_CONTROL_OFFSET], __irq_itoa(hwif->irq));
 #else
-	printk("%s at %x on irq 0x%08x", hwif->name,
+	printk("%s at 0x%08lx on irq %d", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET], hwif->irq);
 #endif /* __mc68000__ && CONFIG_APUS */
 	if (match)
--- linux-2.4.21-pre7/drivers/ide/ide.c	Sun Apr  6 10:28:47 2003
+++ linux-m68k-2.4.21-pre7/drivers/ide/ide.c	Sun Apr  6 11:29:20 2003
@@ -174,14 +174,6 @@
 
 static int ide_scan_direction;	/* THIS was formerly 2.2.x pci=reverse */
 
-#if defined(__mc68000__) || defined(CONFIG_APUS)
-/*
- * ide_lock is used by the Atari code to obtain access to the IDE interrupt,
- * which is shared between several drivers.
- */
-static int ide_intr_lock;
-#endif /* __mc68000__ || CONFIG_APUS */
-
 #ifdef CONFIG_IDEDMA_AUTO
 int noautodma = 0;
 #else
@@ -2371,12 +2363,12 @@
 
 #ifdef CONFIG_BLK_DEV_IDE
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
-		ide_get_lock(&ide_intr_lock, NULL, NULL); /* for atari only */
+		ide_get_lock(NULL, NULL); /* for atari only */
 
 	(void) ideprobe_init();
 
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
-		ide_release_lock(&ide_intr_lock);	/* for atari only */
+		ide_release_lock();	/* for atari only */
 #endif /* CONFIG_BLK_DEV_IDE */
 
 #ifdef CONFIG_PROC_FS
--- linux-2.4.21-pre7/include/linux/ide.h	Sun Apr  6 10:29:52 2003
+++ linux-m68k-2.4.21-pre7/include/linux/ide.h	Sun Apr  6 11:33:19 2003
@@ -344,17 +344,14 @@
 #include <asm/ide.h>
 
 /* Currently only m68k, apus and m8xx need it */
-#ifdef IDE_ARCH_ACK_INTR
-extern int ide_irq_lock;
-# define ide_ack_intr(hwif) (hwif->hw.ack_intr ? hwif->hw.ack_intr(hwif) : 1)
-#else
+#ifndef IDE_ARCH_ACK_INTR
 # define ide_ack_intr(hwif) (1)
 #endif
 
 /* Currently only Atari needs it */
 #ifndef IDE_ARCH_LOCK
-# define ide_release_lock(lock)			do {} while (0)
-# define ide_get_lock(lock, hdlr, data)		do {} while (0)
+# define ide_release_lock()			do {} while (0)
+# define ide_get_lock(hdlr, data)		do {} while (0)
 #endif /* IDE_ARCH_LOCK */
 
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
