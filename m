Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSCCWCl>; Sun, 3 Mar 2002 17:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSCCWCV>; Sun, 3 Mar 2002 17:02:21 -0500
Received: from hera.cwi.nl ([192.16.191.8]:28098 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S289226AbSCCWCU>;
	Sun, 3 Mar 2002 17:02:20 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 3 Mar 2002 22:02:15 GMT
Message-Id: <UTC200203032202.WAA145534.aeb@cwi.nl>
To: dalecki@evision-ventures.com, torvalds@transmeta.com
Subject: IDE cleanup eats disks
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On one of my machines I lose two disk drives with
2.5.6-pre2 that still were present with 2.5.6-pre1.
Looking why, I see that the cleanup of ide-pci.c
cleaned them away.

This is not necessarily bad, leaving things as they are is
certainly an option, although maybe I prefer the old situation,
but I just report the fact that the cleanup changes behaviour.

In this case I had two disks hanging off a HPT366 card
but no CONFIG_BLK_DEV_HPT366 selected. Until now this
worked: the values {PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366}
were always compiled in. On the other hand, 2.5.6-pre2 only
knows about them when CONFIG_BLK_DEV_HPT366 is selected,
so does not recognize the card and does not see the disks.

As a check I changed 2.5.6-pre2 by

 #ifdef CONFIG_BLK_DEV_HPT366
        {PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, pci_init_hpt366, ...
+#else
+       {PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, NULL, NULL,
+        IDE_NO_DRIVER, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+	 OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK },
 #endif

and indeed, this brings the drives back to life.

Andries


[Of course this is not a suggested patch. The same comment applies
to all devices, not just HPT366.]
[Thus, the old situation was that if one did not use DMA then all
just worked, and no special chipset code was required. The new
situation is that one has to select DMA before encountering the
CONFIG_BLK_DEV_HPT366 option.]
