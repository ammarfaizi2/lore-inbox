Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293541AbSBZIVY>; Tue, 26 Feb 2002 03:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293539AbSBZIVP>; Tue, 26 Feb 2002 03:21:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37136 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293540AbSBZIVA>; Tue, 26 Feb 2002 03:21:00 -0500
Date: Tue, 26 Feb 2002 00:20:28 -0800
Message-Id: <200202260820.AAA03790@sodium.transmeta.com>
From: Daniel Quinlan <quinlan@transmeta.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Dave Bogdanoff <bog@transmeta.com>, quinlan@transmeta.com
Subject: [PATCH] Linux Secondary Slave IDE timings
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: quinlan@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fix is from Dave Bogdanoff <bog@transmeta.com>.

Linux incorrectly sets up IDE timings for secondary slave drives on PC
systems that use Intel PIIX Southbridges.

This will correctly shift IDE slave PCI timings for register 44h so
that:

 - secondary slave (drive1) uses bits 4-7
 - primary slave   (drive1) uses bits 0-3

(The addition of the parentheses is needed so the shift will take
place after the bitwise-or.  Without the parentheses, the shift will
incorrectly always take place before the bitwise-or.)

--- linux/drivers/ide/piix.c.orig	Tue Jan 29 23:26:55 2002
+++ linux/drivers/ide/piix.c	Tue Jan 29 23:27:33 2002
@@ -258,8 +258,8 @@
 			master_data = master_data | 0x0070;
 		pci_read_config_byte(HWIF(drive)->pci_dev, slave_port, &slave_data);
 		slave_data = slave_data & (HWIF(drive)->index ? 0x0f : 0xf0);
-		slave_data = slave_data | ((timings[pio][0] << 2) | (timings[pio][1]
-					   << (HWIF(drive)->index ? 4 : 0)));
+		slave_data = slave_data | (((timings[pio][0] << 2) | timings[pio][1])
+					   << (HWIF(drive)->index ? 4 : 0));
 	} else {
 		master_data = master_data & 0xccf8;
 		if (pio > 1)
