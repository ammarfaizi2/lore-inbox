Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276765AbRJHCdP>; Sun, 7 Oct 2001 22:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJHCdG>; Sun, 7 Oct 2001 22:33:06 -0400
Received: from c999639-a.carneg1.pa.home.com ([24.180.243.111]:3060 "EHLO
	maul.jdc.home") by vger.kernel.org with ESMTP id <S276765AbRJHCcz> convert rfc822-to-8bit;
	Sun, 7 Oct 2001 22:32:55 -0400
Subject: Re: AIC7xxx panic
From: Jim Crilly <noth@noth.is.eleet.ca>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011007163158.Q1555-100000@gerard>
In-Reply-To: <20011007163158.Q1555-100000@gerard>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Oct 2001 22:31:48 -0400
Message-Id: <1002508308.452.3.camel@warblade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I changed AHC_NSEG from 128 to 512 and as expected the panic went away,
but does this mean the default should be higher in the kernel or is
there a real bug here? The main reason I wonder is because it ran fine
on disk 0 but panic'd on disk 1.

On Sun, 2001-10-07 at 10:48, Gérard Roudier wrote:
> 
> 
> On Sun, 7 Oct 2001, David M. Grimes wrote:
> 
> > On Sun, Oct 07, 2001 at 07:28:57AM -0400, Jim Crilly wrote:
> > > Both disks on the controller are Seagate Cheetahs, the one being worked
> > > during the panic is a ST39204LW, the other disk is a ST318451LW.
> >
> > I've seen this on a 2-disk system (both Seagate ST150176LW) on a
> > VA-Systems onboad AIC 7xxx.  I enabled TCQ, and noticed the default
> > depth increased sometime around 2.4.10, not exactly sure when (it used
> > to be 8, now much higher).  I've seen it on both disks.
> >
> > In drivers/scsi/aic7xxx/aic7xxx_osm.h is the #define for NSEG, and I
> > changed it from 128 to 512, and it stopped the problem.  Question is,
> > why was the TCQ depth increased, and should NSEG have been upped with
> > it?
> 
> The default TCQ depth was 8 in Doug Ledford's aic7xxx driver but was 253
> in Justin Gibbs' aic7xxx driver. As seen from driver developpers the TCQ
> depth haven't been changed. :-)
> 
> The max number of DMA segments and TCQ depths are totally unrelated items.
> Your guessed work-around may just indicate that their interaction may
> trigger some software bug. Using larger TCQ depths make more pressure on
> memory and disk IOs, leading to more memory being locked for IO pending
> and memory segmentation being more likely.
> 
> > > I did have TCQ enabled and I left it at the default of 255, I'll try a
> > > lower value tomorrow, since it's so late.
> >
> > This also fixed my problem, I left NSEG at 128 and lowered the TCQ depth
> > back to 8.  This worked fine as well.
> >
> > I'll be intereted to see what the eventual outcome of this is, so I can
> > apply the "right" fix!
> 
> The right fix might well not apply to the driver code. Btw, I donnot plan
> to look into the problem, as Justin may just be studying it, in my
> guessing.  I just wanted to suggest to also look into upper layers and not
> to only focus on the low-level driver.
> 
>   Gérard.
> 
> > Anyhow, thought you might want another datapoint.
> >
> >   Thanks,
> >
> >   Dave
> >
> > >
> > > Jim
> > >
> > > On Sun, 2001-10-07 at 06:48, Rob Turk wrote:
> > > > "Jim Crilly" <noth@noth.is.eleet.ca> wrote in message
> > > > news:cistron.1002451051.3718.20.camel@warblade...
> > > > > I got a reproducible panic while running dbench simulating 25+ clients,
> > > > > the new aic7xxx driver panics with "Too few segs for dma mapping.
> > > > > "Increase AHC_NSEG". The partition in question is FAT32 and on a
> > > > > different disk than /, I'm not using HIGHMEM. I am using XFS and the
> > > > > preempt patches, but I don't think they're related to the panic.
> > > > >
> > > > > The odd thing, is if I run dbench in the same manner on my / partition,
> > > > > which is on a different disk on the same controller, it goes fine. It
> > > > > seems, to my untrained eye anyway, to be a bad interaction between the
> > > > > vfat driver and the aic7xxx driver.
> > > > >
> > > > > I'm using the old aic7xxx driver right now and it's fine, has anyone
> > > > > else seen anything like this?
> > > > >
> > > > > Jim
> > > >
> > > > Since this seems to fail on just one disk, it might have to do with one of the
> > > > disk characteristics, like command queue depth. Did you enable Tagged Command
> > > > Queueing, and if so, can you try playing around with the maximum depth?
> > > >
> > > > Rob
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
-- 
Help protect your rights on-line.
Join the Electronic Frontiers Foundation today: http://www.eff.org/join
-----------------------------------------------------------------------
Security: Antonyms: See Microsoft
-----------------------------------------------------------------------
"We are coming after you. God may have mercy on you, but we won't,"
declared Sen. John McCain, R-Arizona.

