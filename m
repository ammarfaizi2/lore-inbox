Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267924AbTBRRxa>; Tue, 18 Feb 2003 12:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbTBRRx3>; Tue, 18 Feb 2003 12:53:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19465 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267924AbTBRRxD>; Tue, 18 Feb 2003 12:53:03 -0500
Subject: PATCH: clean up the IDE iops, add ones for a dead iface
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:03:21 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lC5R-00067P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also adds the new OUTBSYNC iop

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-iops.c linux-2.5.61-ac2/drivers/ide/ide-iops.c
--- linux-2.5.61/drivers/ide/ide-iops.c	2003-02-10 18:38:18.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-iops.c	2003-02-18 18:06:17.000000000 +0000
@@ -31,60 +31,129 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
+/*
+ *	IDE operator we assign to an unplugged device so that
+ *	we don't trash new hardware assigned the same resources
+ */
+ 
+static u8 ide_unplugged_inb (unsigned long port)
+{
+	return 0xFF;
+}
+
+static u16 ide_unplugged_inw (unsigned long port)
+{
+	return 0xFFFF;
+}
+
+static void ide_unplugged_insw (unsigned long port, void *addr, u32 count)
+{
+}
+
+static u32 ide_unplugged_inl (unsigned long port)
+{
+	return 0xFFFFFFFF;
+}
+
+static void ide_unplugged_insl (unsigned long port, void *addr, u32 count)
+{
+}
+
+static void ide_unplugged_outb (u8 addr, unsigned long port)
+{
+}
+
+static void ide_unplugged_outw (u16 addr, unsigned long port)
+{
+}
+
+static void ide_unplugged_outsw (unsigned long port, void *addr, u32 count)
+{
+}
+
+static void ide_unplugged_outl (u32 addr, unsigned long port)
+{
+}
+
+static void ide_unplugged_outsl (unsigned long port, void *addr, u32 count)
+{
+}
 
-static u8 ide_inb (ide_ioreg_t port)
+void unplugged_hwif_iops (ide_hwif_t *hwif)
+{
+	hwif->OUTB	= ide_unplugged_outb;
+	hwif->OUTBSYNC	= ide_unplugged_outb;
+	hwif->OUTW	= ide_unplugged_outw;
+	hwif->OUTL	= ide_unplugged_outl;
+	hwif->OUTSW	= ide_unplugged_outsw;
+	hwif->OUTSL	= ide_unplugged_outsl;
+	hwif->INB	= ide_unplugged_inb;
+	hwif->INW	= ide_unplugged_inw;
+	hwif->INL	= ide_unplugged_inl;
+	hwif->INSW	= ide_unplugged_insw;
+	hwif->INSL	= ide_unplugged_insl;
+}
+
+EXPORT_SYMBOL(unplugged_hwif_iops);
+
+/*
+ *	Conventional PIO operations for ATA devices
+ */
+
+static u8 ide_inb (unsigned long port)
 {
 	return (u8) inb(port);
 }
 
-static u16 ide_inw (ide_ioreg_t port)
+static u16 ide_inw (unsigned long port)
 {
 	return (u16) inw(port);
 }
 
-static void ide_insw (ide_ioreg_t port, void *addr, u32 count)
+static void ide_insw (unsigned long port, void *addr, u32 count)
 {
 	return insw(port, addr, count);
 }
 
-static u32 ide_inl (ide_ioreg_t port)
+static u32 ide_inl (unsigned long port)
 {
 	return (u32) inl(port);
 }
 
-static void ide_insl (ide_ioreg_t port, void *addr, u32 count)
+static void ide_insl (unsigned long port, void *addr, u32 count)
 {
 	insl(port, addr, count);
 }
 
-static void ide_outb (u8 value, ide_ioreg_t port)
+static void ide_outb (u8 addr, unsigned long port)
 {
-	outb(value, port);
+	outb(addr, port);
 }
 
-static void ide_outw (u16 value, ide_ioreg_t port)
+static void ide_outw (u16 addr, unsigned long port)
 {
-	outw(value, port);
+	outw(addr, port);
 }
 
-static void ide_outsw (ide_ioreg_t port, void *addr, u32 count)
+static void ide_outsw (unsigned long port, void *addr, u32 count)
 {
 	outsw(port, addr, count);
 }
 
-static void ide_outl (u32 value, ide_ioreg_t port)
+static void ide_outl (u32 addr, unsigned long port)
 {
-	outl(value, port);
+	outl(addr, port);
 }
 
-static void ide_outsl (ide_ioreg_t port, void *addr, u32 count)
+static void ide_outsl (unsigned long port, void *addr, u32 count)
 {
-	outsl(port, addr, count);
+	return outsl(port, addr, count);
 }
 
 void default_hwif_iops (ide_hwif_t *hwif)
 {
 	hwif->OUTB	= ide_outb;
+	hwif->OUTBSYNC	= ide_outb;
 	hwif->OUTW	= ide_outw;
 	hwif->OUTL	= ide_outl;
 	hwif->OUTSW	= ide_outsw;
@@ -98,78 +167,66 @@
 
 EXPORT_SYMBOL(default_hwif_iops);
 
-static u8 ide_mm_inb (ide_ioreg_t port)
+/*
+ *	MMIO operations, typically used for SATA controllers
+ */
+
+static u8 ide_mm_inb (unsigned long port)
 {
 	return (u8) readb(port);
 }
 
-static u16 ide_mm_inw (ide_ioreg_t port)
+static u16 ide_mm_inw (unsigned long port)
 {
 	return (u16) readw(port);
 }
 
-static void ide_mm_insw (ide_ioreg_t port, void *addr, u32 count)
+static void ide_mm_insw (unsigned long port, void *addr, u32 count)
 {
-#ifdef CONFIG_PPC
-	/* Can we move the barrier out of the loop ? */
-	while (count--) { *(u16 *)addr = __raw_readw(port); iobarrier_r(); addr += 2; }
-#else /* everything else is sane benh */
-	while (count--) { *(u16 *)addr = readw(port); addr += 2; }
-#endif
+	__ide_mm_insw(port, addr, count);
 }
 
-static u32 ide_mm_inl (ide_ioreg_t port)
+static u32 ide_mm_inl (unsigned long port)
 {
 	return (u32) readl(port);
 }
 
-static void ide_mm_insl (ide_ioreg_t port, void *addr, u32 count)
+static void ide_mm_insl (unsigned long port, void *addr, u32 count)
 {
-#ifdef CONFIG_PPC
-	/* Can we move the barrier out of the loop ? */
-	while (count--) { *(u32 *)addr = __raw_readl(port); iobarrier_r(); addr += 4; }
-#else /* everything else is sane benh */
-	while (count--) { *(u32 *)addr = readl(port); addr += 4; }
-#endif
+	__ide_mm_insl(port, addr, count);
 }
 
-static void ide_mm_outb (u8 value, ide_ioreg_t port)
+static void ide_mm_outb (u8 value, unsigned long port)
 {
 	writeb(value, port);
 }
 
-static void ide_mm_outw (u16 value, ide_ioreg_t port)
+static void ide_mm_outw (u16 value, unsigned long port)
 {
 	writew(value, port);
 }
 
-static void ide_mm_outsw (ide_ioreg_t port, void *addr, u32 count)
+static void ide_mm_outsw (unsigned long port, void *addr, u32 count)
 {
-#ifdef CONFIG_PPC
-	/* Can we move the barrier out of the loop ? */
-	while (count--) { __raw_writew(*(u16 *)addr, port); iobarrier_w(); addr += 2; }
-#else /* everything else is sane benh */
-	while (count--) { writew(*(u16 *)addr, port); addr += 2; }
-#endif
+	__ide_mm_outsw(port, addr, count);
 }
 
-static void ide_mm_outl (u32 value, ide_ioreg_t port)
+static void ide_mm_outl (u32 value, unsigned long port)
 {
 	writel(value, port);
 }
 
-static void ide_mm_outsl (ide_ioreg_t port, void *addr, u32 count)
+static void ide_mm_outsl (unsigned long port, void *addr, u32 count)
 {
-#ifdef CONFIG_PPC
-	while (count--) { __raw_writel(*(u32 *)addr, port); iobarrier_w(); addr += 4; }
-#else /* everything else is sane benh */
-	while (count--) { writel(*(u32 *)addr, port); addr += 4; }
-#endif
+	__ide_mm_outsl(port, addr, count);
 }
 
 void default_hwif_mmiops (ide_hwif_t *hwif)
 {
 	hwif->OUTB	= ide_mm_outb;
+	/* Most systems will need to override OUTBSYNC, alas however
+	   this one is controller specific! */
+	hwif->OUTBSYNC	= ide_mm_outb;
 	hwif->OUTW	= ide_mm_outw;
 	hwif->OUTL	= ide_mm_outl;
 	hwif->OUTSW	= ide_mm_outsw;
