Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130009AbRBTSVZ>; Tue, 20 Feb 2001 13:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRBTSVP>; Tue, 20 Feb 2001 13:21:15 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:56836 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129569AbRBTSVK>;
	Tue, 20 Feb 2001 13:21:10 -0500
Date: Tue, 20 Feb 2001 19:20:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andre Hedrick <andre@linux-ide.org>, Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] meaningless #ifndef?
Message-ID: <20010220192056.A6846@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0102201705280.11260-100000@alloc> <Pine.LNX.4.21.0102201730260.1046-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0102201730260.1046-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Feb 20, 2001 at 05:45:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 05:45:52PM +0000, Hugh Dickins wrote:
> > 
> > > from drivers/ide/ide-features.c:
> > > 
> > > /*
> > >  *  All hosts that use the 80c ribbon mus use!
> > >  */
> > > byte eighty_ninty_three (ide_drive_t *drive)
> > > {
> > >         return ((byte) ((HWIF(drive)->udma_four) &&
> > > #ifndef CONFIG_IDEDMA_IVB
> > >                         (drive->id->hw_config & 0x4000) &&
> > > #endif /* CONFIG_IDEDMA_IVB */
> > >                         (drive->id->hw_config & 0x6000)) ? 1 : 0);
> > > }
> > > 
> > > If i see well, then this is always same whether CONFIG_IDEDMA_IVB is
> > > defined or not.
> > > What's the clue?

> > The first is true only if bit 14 is set.
> > The second is true if either bit 13 or 14 is set.
> > 
> > Togather they test for two bits.
> > The first test is exclusive to bit 14
> > The second test is inclusive of bits 13 and 14.

> Andre, please read through that code again, and through your reply.
> It seems to me that Poszar is absolutely right, and your reply is
> (once again) just saying "there's lots of confusion out there, so
> my code has to be confused too".  Or do your &s and &&s behave
> differently from ours?

Well, the code looks weird. However, it doesn't behave the same when
CONFIG_IDEDMA_IVB is enabled or not. If it is not, normal case, it's
just:

(drive->id->hw_config & 0x6000)

If CONFIG_IDEDMA_IVB is enabled, it boils down to:

(drive->id->hw_config & 0x4000)

because the second bit test includes the earlier test already only
loosening it. Because of that, it's superfluous. And the code relies on
the compiler to optimize it out.

If written like:

#ifndef CONFIG_IDEDMA_IVB
#define IDE_UDMA_MASK 0x4000
#else
#define IDE_UDMA_MASK 0x6000
#endif /* CONFIG_IDEDMA_IVB */

byte eighty_ninty_three (ide_drive_t *drive)
{       
        return HWIF(drive)->udma_four &&
		(drive->id->hw_config & IDE_UDMA_MASK);
}

it'd be probably somewhat clearer.

-- 
Vojtech Pavlik
SuSE Labs
