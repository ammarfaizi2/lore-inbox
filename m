Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSJ0UCt>; Sun, 27 Oct 2002 15:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbSJ0UCt>; Sun, 27 Oct 2002 15:02:49 -0500
Received: from mail2.uklinux.net ([80.84.72.32]:3281 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id <S262506AbSJ0UCr>;
	Sun, 27 Oct 2002 15:02:47 -0500
Date: Sun, 27 Oct 2002 20:09:03 +0000 (GMT)
From: Peter Denison <lkml@marshadder.uklinux.net>
X-X-Sender: peterd@marshall.localnet
To: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE: correct partially initialised hw structures
Message-ID: <Pine.LNX.4.44.0210271954160.9670-100000@marshall.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Initialise all parts of hw_regs_t structures before passing them
to ide_register_hw

The hw structure (specifically the hw->chipset field) held uninitialised
data.  This (before the initialisation order fixup recently posted) meant
that no chipset could ever get selected by an idex=<chipset> commandline
(silently!).

Only occurs on non-PCI platforms. All ARM platforms have already been
fixed - though slightly differently.

I'm not sure how valid a lot of the code I patched actually is. Does it
make sense on e.g. ia64 or x86_64 to specify CONFIG_PCI = n? Or even to
have the concept of default interfaces?  The interfaces should get probed
anyway, and the ide_init_hwif_ports() part is called from init_hwif_data()
already. The only thing these arch-specific routines do extra is calling
ide_register_hw, which probably wants to happen from the probes, not here.

Applies: 2.5.44 (and probably others)

--- linux/include/asm-ia64/ide.h.old	2002-10-06 10:11:35.000000000 +0100
+++ linux/include/asm-ia64/ide.h	2002-10-27 18:47:26.000000000 +0000
@@ -82,6 +82,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-x86_64/ide.h.old	2002-10-19 12:43:40.000000000 +0100
+++ linux/include/asm-x86_64/ide.h	2002-10-27 18:47:46.000000000 +0000
@@ -69,6 +69,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-ppc/ide.h.old	2002-10-06 10:11:33.000000000 +0100
+++ linux/include/asm-ppc/ide.h	2002-10-27 18:48:20.000000000 +0000
@@ -89,6 +89,8 @@
 	int index;
 	ide_ioreg_t base;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for (index = 0; index < MAX_HWIFS; index++) {
 		base = ide_default_io_base(index);
 		if (base == 0)
--- linux/include/asm-mips/ide.h.old	2002-08-25 13:26:53.000000000 +0100
+++ linux/include/asm-mips/ide.h	2002-10-27 19:37:39.000000000 +0000
@@ -55,6 +55,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-parisc/ide.h.old	2002-08-25 13:26:53.000000000 +0100
+++ linux/include/asm-parisc/ide.h	2002-10-27 18:48:54.000000000 +0000
@@ -71,6 +71,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-i386/ide.h.old	2002-10-06 10:02:03.000000000 +0100
+++ linux/include/asm-i386/ide.h	2002-10-19 00:17:05.000000000 +0100
@@ -68,6 +68,8 @@
 #ifndef CONFIG_PCI
 	hw_regs_t hw;
 	int index;
+
+	memset(&hw, 0, sizeof(hw_regs_t));

 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
--- linux/include/asm-sparc64/ide.h.old	2002-10-06 10:02:03.000000000 +0100
+++ linux/include/asm-sparc64/ide.h	2002-10-27 18:50:10.000000000 +0000
@@ -59,6 +59,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-alpha/ide.h.old	2002-10-06 10:11:37.000000000 +0100
+++ linux/include/asm-alpha/ide.h	2002-10-27 18:50:58.000000000 +0000
@@ -72,6 +72,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-sparc/ide.h.old	2002-10-06 10:02:03.000000000 +0100
+++ linux/include/asm-sparc/ide.h	2002-10-27 18:52:12.000000000 +0000
@@ -63,6 +63,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for (index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-cris/ide.h.old	2002-08-25 13:26:53.000000000 +0100
+++ linux/include/asm-cris/ide.h	2002-10-27 18:52:48.000000000 +0000
@@ -79,6 +79,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-mips64/ide.h.old	2002-08-25 13:26:53.000000000 +0100
+++ linux/include/asm-mips64/ide.h	2002-10-27 19:38:04.000000000 +0000
@@ -58,6 +58,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
--- linux/include/asm-sh/ide.h.old	2002-08-25 13:26:53.000000000 +0100
+++ linux/include/asm-sh/ide.h	2002-10-27 18:53:46.000000000 +0000
@@ -97,6 +97,8 @@
 	hw_regs_t hw;
 	int index;

+	memset(&hw, 0, sizeof(hw_regs_t));
+
 	for(index = 0; index < MAX_HWIFS; index++) {
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));

-- 
Peter Denison <peterd at marshadder dot uklinux dot net>
Please use the address above only for personal mail, not copied to any lists
that are gatewayed to news or web pages unless the addresses are removed.

