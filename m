Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313207AbSC2MkR>; Fri, 29 Mar 2002 07:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313341AbSC2MkH>; Fri, 29 Mar 2002 07:40:07 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:5022 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S313207AbSC2Mj6>;
	Fri, 29 Mar 2002 07:39:58 -0500
Date: Fri, 29 Mar 2002 13:39:56 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203291239.NAA25704@harpo.it.uu.se>
To: vojtech@ucw.cz
Subject: 2.5.7 pre-UDMA PIIX bug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech's version of drivers/ide/piix.c which went into 2.5.7
oopses with a divide-by-zero exception when initialising older
pre-UDMA chips, like in the following 430HX chipset:

00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
(PCI IDs 8086:1250, 8086:7000, and 8086:7010, respectively)

The error occurs in piix.c:piix_set_drive() line 334, shown below.
The 82371SB has PIIX_UDMA_NONE in the piix_ide_chips[] array,
so piix_config->flags & PIIX_UDMA is zero, which makes "umul" zero,
which causes the divide-by-zero on line 334.

  317	static int piix_set_drive(ide_drive_t *drive, unsigned char speed)
  318	{
  319		ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
  320		struct ata_timing t, p;
  321		int err, T, UT, umul;
  322	
  323		if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
  324			if ((err = ide_config_drive_speed(drive, speed)))
  325				return err;
  326	
  327		umul =  min((speed > XFER_UDMA_4) ? 4 : ((speed > XFER_UDMA_2) ? 2 : 1),
  328			piix_config->flags & PIIX_UDMA);
  329	
  330		if (piix_config->flags & PIIX_VICTORY)
  331			umul = 2;
  332	
  333		T = 1000000000 / piix_clock;
  334		UT = T / umul;

/Mikael
