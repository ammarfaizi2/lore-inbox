Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317039AbSEWWvL>; Thu, 23 May 2002 18:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317040AbSEWWvK>; Thu, 23 May 2002 18:51:10 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:53154 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317039AbSEWWvI>;
	Thu, 23 May 2002 18:51:08 -0400
Date: Fri, 24 May 2002 00:50:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Oleg Drokin <green@namesys.com>, "Gryaznova E." <grev@namesys.botik.ru>,
        martin@dalecki.de, Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020524005057.F27005@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com> <3CED004A.6000109@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 04:44:26PM +0200, Martin Dalecki wrote:
> Uz.ytkownik Oleg Drokin napisa?:
> > Hello!
> > 
> > On Thu, May 23, 2002 at 04:27:39PM +0200, Martin Dalecki wrote:
> > 
> >>>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >>>hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> >>
> >>Since this error can be expected to be quite common.
> >>Its an installation error. I will just make the corresponding
> >>error message more intelliglible to the average user:
> >>hda: checksum error on data transfer occurred!
> > 
> > 
> > BTW, I have a particular setup that spits out such errors,
> > and I somehow thinks the cable is good.
> > 
> > I have IBM DTLA-307030 drive and Seagate Barracuda IV drive (last one purchased
> > only recently).
> > IBM drive is connected to far end of 80-wires IDE cable and Barracuda is
> > connected to the middle of this same wire.
> > Before I bought IBM drive, everything was ok.
> > But now I see BadCRC errors on hdb (only on hdb, which is barracuda drive)
> > usually when both drives are active.
> > If I disable DMA on IBM drive (or if kernel disables it by itself for some
> > reason, and it actually does it sometimes), these errors seems to go away.
> > 
> > This is all on 2.4.18, but actually I think this is irrelevant.
> > 
> > If that's a bad cable, why it is only happens when both drives are working
> > in DMA mode?
> 
> It's most likely the cable. The error comes directly from the
> status register of the drive. The drive is reporting that it got
> corrupted data from the wire. This will be only checked in the
> 80 cable requiring DMA transfer modes.

No. It doesn't depend on the number of cables - the additional cables
are GND only. 32-bit CRCs are used even on 40 wire cables.

> So if the drive resorts to
> slower operation all will be fine. If it does not - well
> you see the above...

The driver cannot resort to a slower speed by itself - the kernel has to
tell it.

Also note than on UDMA we have two different speeds - for writing we set
it in the controller registers and for reading it's set on the drive by
a set_feature command.

In PIO and DMA modes everything is driven by the controller.

> Having two drives on a single cable canges the termination
> of the cable as well as other electrical properties significantly
> and apparently you are just out of luck with the above system.

It might not be the cable, but the drives - I'd try exchanging their
positions.

> What should really help is simple resort to slower operations
> int he case of the driver.
> 
> It can of course be as well that the host chip driver is simply
> programming the channel for too aggressive values.

Depends whether it happens on reads or writes. For reads it'd be the
drive is too fast and the controller can't get the data (because the
data is damaged electrically or it just can't cope with the speed), for
writes it's the opposite.

> Hmm thinking again about it... It occurrs to me
> that actually there should be a mechanism which tells the
> host chip drivers whatever there are only just one or
> two drivers connected. I will have to look in to it.

There is no such mechanism (except for probing the drives). IDE has
quite nonsensical "split" termination - the termination resistors are
always present even on the middle device. This is to "simplify" things
...

-- 
Vojtech Pavlik
SuSE Labs
