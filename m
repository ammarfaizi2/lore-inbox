Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSIWKzv>; Mon, 23 Sep 2002 06:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265485AbSIWKzv>; Mon, 23 Sep 2002 06:55:51 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:11961 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265457AbSIWKzu>;
	Mon, 23 Sep 2002 06:55:50 -0400
Date: Mon, 23 Sep 2002 13:01:01 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209231101.NAA14150@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.35+ IDE problems on old pre-PCI HW
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my test boxes has serious problems with the 2.5 IDE
code since 2.5.35. It's a 486 with a QD6580 VLB dual-channel
controller card. No PCI in sight :-(

2.5.33/.34 worked with CONFIG_BLK_DEV_QD65XX && !CONFIG_PCI,
and "ide0=qd65xx idebus=33 ide0=autotune ide1=autotune" kernel
parameters. 2.4 and 2.2 + Andre's IDE patch also work.

2.5.35/.36/.38 all reboot instantly after loading the kernel,
if I pass "ide0=qd65xx" as a kernel parameter. Martin's 2.5
IDE code also had this problem. Skipping "ide0=qd65xx" allows
.35 and .36 to boot.

2.5.38 boots w/o "ide0=qd65xx" but hangs near the end of INIT.
(With the ide_toggle_bounce() patch applied to prevent an oops.)

OTOH, current 2.5 works fine on my PIIX/ICH2 boxes.

Below is a patch for a long-standing bug which affects PCI-less
kernels. The early setup passes a partially uninitialised local
variable to ide_register_hw(), which copies the uninitialised
fields. Among other things, this puts garbage in the "chipset"
field, which can prevent chipset-selection options like
"ide0=qd65xx" from succeeding.

/Mikael

--- linux-2.5.38/include/asm-i386/ide.h.~1~	Sat Sep 21 15:26:21 2002
+++ linux-2.5.38/include/asm-i386/ide.h	Mon Sep 23 11:41:42 2002
@@ -70,6 +70,7 @@
 	int index;
 
 	for(index = 0; index < MAX_HWIFS; index++) {
+		memset(&hw, 0, sizeof hw);
 		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
 		hw.irq = ide_default_irq(ide_default_io_base(index));
 		ide_register_hw(&hw, NULL);
