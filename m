Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313455AbSC2PKU>; Fri, 29 Mar 2002 10:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313453AbSC2PKL>; Fri, 29 Mar 2002 10:10:11 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:14755 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313454AbSC2PJ4>;
	Fri, 29 Mar 2002 10:09:56 -0500
Date: Fri, 29 Mar 2002 16:09:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 pre-UDMA PIIX bug
Message-ID: <20020329160949.B30814@ucw.cz>
In-Reply-To: <200203291239.NAA25704@harpo.it.uu.se> <3CA47378.70208@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 03:00:24PM +0100, Martin Dalecki wrote:
> Mikael Pettersson wrote:
> > Vojtech's version of drivers/ide/piix.c which went into 2.5.7
> > oopses with a divide-by-zero exception when initialising older
> > pre-UDMA chips, like in the following 430HX chipset:
> > 
> > 00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
> > 00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> > 00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
> > (PCI IDs 8086:1250, 8086:7000, and 8086:7010, respectively)
> > 
> > The error occurs in piix.c:piix_set_drive() line 334, shown below.
> > The 82371SB has PIIX_UDMA_NONE in the piix_ide_chips[] array,
> > so piix_config->flags & PIIX_UDMA is zero, which makes "umul" zero,
> > which causes the divide-by-zero on line 334.
> > 
> >   317	static int piix_set_drive(ide_drive_t *drive, unsigned char speed)
> >   318	{
> >   319		ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
> >   320		struct ata_timing t, p;
> >   321		int err, T, UT, umul;
> >   322	
> >   323		if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
> >   324			if ((err = ide_config_drive_speed(drive, speed)))
> >   325				return err;
> >   326	
> >   327		umul =  min((speed > XFER_UDMA_4) ? 4 : ((speed > XFER_UDMA_2) ? 2 : 1),
> >   328			piix_config->flags & PIIX_UDMA);
> >   329	
> >   330		if (piix_config->flags & PIIX_VICTORY)
> >   331			umul = 2;
> >   332	
> >   333		T = 1000000000 / piix_clock;
> >   334		UT = T / umul;
> 
> I think that it should be just sufficient to add the
> following test just in front of the offending calculartion.
> 
> if (umul == 0)
>    ++umul;
> 
> Vojtech is this right?

Probably yes, the value of UT isn't used in that case, because we will
never try to set an UDMA mode on such a chipset. I've sent you a
slightly different patch, though.

-- 
Vojtech Pavlik
SuSE Labs
