Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSHAQgb>; Thu, 1 Aug 2002 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSHAQgb>; Thu, 1 Aug 2002 12:36:31 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:18147 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315628AbSHAQga>;
	Thu, 1 Aug 2002 12:36:30 -0400
Date: Thu, 1 Aug 2002 18:39:47 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200208011639.SAA03245@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-rc5 IDE kernel option breakage
Cc: andre@linux-ide.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BLK_DEV_IDEPCI is disabled, using a kernel option
to activate a non-PCI IDE chipset on x86 (e.g. via "ide0=qd65xx")
fails with a "-- BAD OPTION" error from ide_setup().

This is because include/asm-i386/ide.h:ide_init_default_hwifs()
passes a partially uninitialised variable "hw" to
drivers/ide/ide.c:ide_register_hw(), which in turn copies it,
including the unitialised fields, to a hwif. In particular,
ide_init_default_hwifs() puts random junk in hwif->chipset.
ide_setup() later believes that a chipset already has been selected
(line 3434), so it rejects any chipset-selection kernel option.

This does not happen when CONFIG_BLK_DEV_IDEPCI=y because in that
case ide_init_default_hwifs() doesn't call ide_register_hw(),
and consequently doesn't put junk in hwif->chipset.

A minimal fix (included below) is to clear hw before setting it
up and passing it to ide_register_hw().

/Mikael

--- linux-2.4.19-rc5/include/asm-i386/ide.h.~1~	Thu Aug  1 14:49:03 2002
+++ linux-2.4.19-rc5/include/asm-i386/ide.h	Thu Aug  1 15:05:20 2002
@@ -79,6 +79,7 @@
 	int index;
 
 	for(index = 0; index < MAX_HWIFS; index++) {
+		memset(&hw, 0, sizeof hw);
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
 		ide_register_hw(&hw, NULL);
