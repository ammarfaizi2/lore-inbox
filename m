Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTHTXMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTHTXMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:12:09 -0400
Received: from brmea-mail-2.Sun.COM ([192.18.98.43]:40691 "EHLO
	brmea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262328AbTHTXMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:12:03 -0400
Subject: Re: 2.6 test3-bk7 & -mm3 : HPT374 - cable missdetection, lock-ups
From: Duncan Laurie <duncan@sun.com>
To: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-C+2fFTMOGhHFXzYHPgiZ"
Message-Id: <1061420966.18520.5.camel@atherton.home.iceblink.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 16:09:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C+2fFTMOGhHFXzYHPgiZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> first test run of 2.6 on Epox 8k9a3+ VIA KT400 VT8235,
> HPT374 and 4 IBM Deskstar GXP120 80Gb on each chanel as master
> Mandrake-cooker gcc-3.3.1
>
> the 3rd and the 4th chanel of the HPT374 are saying that the used 
> cable is 40 wires, so it forces the drives in UDMA33 which i think
> causes the lock-ups several seconds after booting in runlevel 1

Here is a patch (against 2.6.0-test3) for the cable detect problem
on the 3rd/4th channels of the hpt374.  This same patch made its
way into 2.4 via the -ac tree but hasn't been put in 2.6 yet.

It fixes some cable detect issues that stem from the fact that the
cable detect pins are also used as address/data lines, so they need
to first be configured as inputs to read valid cable detect state.

For everything from the 370 to function 0 of the 374:
  bit 0 of register 0x5b must be cleared in order to make the
  SCBLID/MA15 and PCBLID/MA16 pins as input.

For the 374 third/fourth channels (function 1):
  bit 15 of register 0x52 and bit 15 of register 0x56 must be
  set for TCBLID/MD6 and FCBLID/MD1 pins to be input.

I'm not sure it will actually help with your lockups, but at least
things will be detected right...

-duncan


--=-C+2fFTMOGhHFXzYHPgiZ
Content-Disposition: attachment; filename=hpt366_2.6.0test3.patch
Content-Type: text/plain; name=hpt366_2.6.0test3.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- hpt366.c.orig	Wed Aug 20 15:25:43 2003
+++ hpt366.c	Wed Aug 20 15:27:45 2003
@@ -989,7 +989,40 @@
 	hwif->intrproc			= &hpt3xx_intrproc;
 	hwif->maskproc			= &hpt3xx_maskproc;
 
-	pci_read_config_byte(hwif->pci_dev, 0x5a, &ata66);
+	/*
+	 * The HPT37x uses the CBLID pins as outputs for MA15/MA16
+	 * address lines to access an external eeprom.  To read valid
+	 * cable detect state the pins must be enabled as inputs.
+	 */
+	if (hpt_minimum_revision(dev, 8) && PCI_FUNC(dev->devfn) & 1) {
+		/*
+		 * HPT374 PCI function 1
+		 * - set bit 15 of reg 0x52 to enable TCBLID as input
+		 * - set bit 15 of reg 0x56 to enable FCBLID as input
+		 */
+		u16 mcr3, mcr6;
+		pci_read_config_word(dev, 0x52, &mcr3);
+		pci_read_config_word(dev, 0x56, &mcr6);
+		pci_write_config_word(dev, 0x52, mcr3 | 0x8000);
+		pci_write_config_word(dev, 0x56, mcr6 | 0x8000);
+		/* now read cable id register */
+		pci_read_config_byte(dev, 0x5a, &ata66);
+		pci_write_config_word(dev, 0x52, mcr3);
+		pci_write_config_word(dev, 0x56, mcr6);
+	} else if (hpt_minimum_revision(dev, 3)) {
+		/*
+		 * HPT370/372 and 374 pcifn 0
+		 * - clear bit 0 of 0x5b to enable P/SCBLID as inputs
+		 */
+		u8 scr2;
+		pci_read_config_byte(dev, 0x5b, &scr2);
+		pci_write_config_byte(dev, 0x5b, scr2 & ~1);
+		/* now read cable id register */
+		pci_read_config_byte(dev, 0x5a, &ata66);
+		pci_write_config_byte(dev, 0x5b, scr2);
+	} else {
+		pci_read_config_byte(dev, 0x5a, &ata66);
+	}
 
 #ifdef DEBUG
 	printk("HPT366: reg5ah=0x%02x ATA-%s Cable Port%d\n",

--=-C+2fFTMOGhHFXzYHPgiZ--

