Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWAMNdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWAMNdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWAMNdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:33:36 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:19235 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422662AbWAMNdg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:33:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AoHRZ1Om3KoDtkqxtjdzg9cvfXVE7XYBvlhqjRN3Oe/AyM+N2GLEJR8rkPbT78ebP8E+2gy/X46kkkXzPrAf02reZTruf+l1EHpGTQiYcXOjtATdzk1HNdBCZw7TPmjjF//ClnSz6crLeadtwCL3X+nlv/JbP+Cn58CLsl3KFp8=
Message-ID: <58cb370e0601130533n5842cb5fufc5058f9a1acc606@mail.gmail.com>
Date: Fri, 13 Jan 2006 14:33:34 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Fwd: ide-cd turning off DMA when verifying DVD-R
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Robert Hancock <hancockr@shaw.ca>,
       Volker Kuhlmann <list0570@paradise.net.nz>, Jens Axboe <axboe@suse.de>,
       linux-ide <linux-ide@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060113112510.GA23264@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it>
	 <43C72F41.5060207@shaw.ca> <20060113083009.GE12338@paradise.net.nz>
	 <58cb370e0601130119g5c62b749r1bc5da59a0d4a56c@mail.gmail.com>
	 <58cb370e0601130121s2f6c0a26jda00ff64df197342@mail.gmail.com>
	 <20060113093818.GA22984@sci.fi>
	 <58cb370e0601130149g32323b4axbf0ac55f83ac9148@mail.gmail.com>
	 <20060113112510.GA23264@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm adding missing cc:, I hope I didn't forget about anybody this time.

There is now bugzilla entry for this bug (thanks Ondrej):
http://bugzilla.kernel.org/show_bug.cgi?id=5882

Jens, could you take a look at the part related to ide-cd timeouts?

On 1/13/06, Ville Syrjälä <syrjala@sci.fi> wrote:
> On Fri, Jan 13, 2006 at 10:49:22AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 1/13/06, Ville Syrjälä <syrjala@sci.fi> wrote:
> > > On Fri, Jan 13, 2006 at 10:21:44AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > On 1/13/06, Volker Kuhlmann <list0570@paradise.net.nz> wrote:
> > > > > On Fri 13 Jan 2006 17:40:33 NZDT +1300, Robert Hancock wrote:
> > > > >
> > > > > > I'm thinking the IDE code is too aggressive in assuming that the failure
> > > > > >  is because of a DMA problem and disabling it.. Most likely all that's
> > > > > > happening is the drive is taking a long time to complete the current
> > > > > > command.
> > > >
> > > > What actually happened is that normal command timed out
> > > > and because of that driver reset the device which caused
> > > > it to loose DMA:
> > > >
> > > > ->ide_atapi_error()
> > > >     ->ide_do_reset()
> > > >       ->pre_reset()
> > > >         ->check_dma_crc()
> > > >           ->__ide_dma_off()
> > > >
> > > > Somebody needs to investigate why __ide_dma_off() is called
> > > > et all and if we need to restore DMA after reset (don't count ATM
> > > > on me, I'm buried by bugreports).  Ondrej, could you fill the bug at
> > > > http://bugzilla.kernel.org so we don't lose it?
> > >
> > > It looks like this has been fixed recently. In 2.6.14-rc4-mm1
> > > check_dma_crc() used to call __ide_dma_off() when no CRC errors were
> > > registered. The bug has been fixed before 2.6.15-rc5-mm1. I'm still
> > > running 2.6.14-rc4-mm1 on my burning system so I haven't actually tested
> > > this on a recent kernel.
> >
> > I don't see it being fixed, could you point me at the patch?
>
> It seems the patch was carried along during the 2.6.15-rc-mm series but
> was later dropped.
>
> Here it is:
> http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/ide-promise-flushing-hang-fix.patch
>
> There's a bunch of other stuff in that patch besides the __ide_dma_off()
> change. Maybe that approach isn't correct and just increasing some
> timeout value would work. LG burners are just really slow recognizing
> discs.

The patch was NACK-ed by Alan Cox and I agree with him (this should be
done differently).  This __ide_dma_off() chunk looks sensible but does it fix
the issue?  I was under impression that after a reset drive looses its DMA
xfer mode and needs to be reprogrammed (ATA spec has the answer).

> I just took some random discs from my colletion and measured the time it
> took for the drive to recognize them.
>
> ~12 seconds for CD-R
> ~15 seconds for some DVD+R
> ~27 seconds for some DVD+R
>
> I'm not sure why it takes so long for some discs. I know they aren't
> bad burns because my laptop DVD-ROM drive, which is more sensitive to
> disc quality than the LG, can read them without any problems and it
> recognizes them in a few seconds.

I'll let Jens comment on this one. :)

Bartlomiej
