Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313452AbSC2PIt>; Fri, 29 Mar 2002 10:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313453AbSC2PIk>; Fri, 29 Mar 2002 10:08:40 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:13219 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313452AbSC2PI0>;
	Fri, 29 Mar 2002 10:08:26 -0500
Date: Fri, 29 Mar 2002 16:08:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, martin@dalecki.de
Subject: Re: 2.5.7 pre-UDMA PIIX bug
Message-ID: <20020329160818.A30814@ucw.cz>
In-Reply-To: <200203291239.NAA25704@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2002 at 01:39:56PM +0100, Mikael Pettersson wrote:
> Vojtech's version of drivers/ide/piix.c which went into 2.5.7
> oopses with a divide-by-zero exception when initialising older
> pre-UDMA chips, like in the following 430HX chipset:
> 
> 00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
> 00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> 00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
> (PCI IDs 8086:1250, 8086:7000, and 8086:7010, respectively)
> 
> The error occurs in piix.c:piix_set_drive() line 334, shown below.
> The 82371SB has PIIX_UDMA_NONE in the piix_ide_chips[] array,
> so piix_config->flags & PIIX_UDMA is zero, which makes "umul" zero,
> which causes the divide-by-zero on line 334.
> 
>   317	static int piix_set_drive(ide_drive_t *drive, unsigned char speed)
>   318	{
>   319		ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
>   320		struct ata_timing t, p;
>   321		int err, T, UT, umul;
>   322	
>   323		if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
>   324			if ((err = ide_config_drive_speed(drive, speed)))
>   325				return err;
>   326	
>   327		umul =  min((speed > XFER_UDMA_4) ? 4 : ((speed > XFER_UDMA_2) ? 2 : 1),
>   328			piix_config->flags & PIIX_UDMA);
>   329	
>   330		if (piix_config->flags & PIIX_VICTORY)
>   331			umul = 2;
>   332	
>   333		T = 1000000000 / piix_clock;
>   334		UT = T / umul;

Thanks for the bug report! The attached patch should fix that.

Martin, please apply this patch.

-- 
Vojtech Pavlik
SuSE Labs

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fixpiix.diff"

diff -urN linux-2.5.7/drivers/ide/piix.c linux-2.5.7-fixpiix/drivers/ide/piix.c
--- linux-2.5.7/drivers/ide/piix.c	Fri Mar 29 16:01:51 2002
+++ linux-2.5.7-fixpiix/drivers/ide/piix.c	Fri Mar 29 16:07:05 2002
@@ -1,5 +1,5 @@
 /*
- * $Id: piix.c,v 1.2 2002/03/13 22:50:43 vojtech Exp $
+ * $Id: piix.c,v 1.3 2002/03/29 16:06:06 vojtech Exp $
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -128,7 +128,7 @@
 
 	piix_print("----------PIIX BusMastering IDE Configuration---------------");
 
-	piix_print("Driver Version:                     1.2");
+	piix_print("Driver Version:                     1.3");
 	piix_print("South Bridge:                       %s", bmide_dev->name);
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
@@ -331,7 +331,7 @@
 		umul = 2;
 
 	T = 1000000000 / piix_clock;
-	UT = T / umul;
+	UT = umul ? (T / umul) : 0;
 
 	ata_timing_compute(drive, speed, &t, T, UT);
 

--yrj/dFKFPuw6o+aM--
