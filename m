Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTFTL2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 07:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTFTL2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 07:28:08 -0400
Received: from remt23.cluster1.charter.net ([209.225.8.33]:45052 "EHLO
	remt23.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262931AbTFTL2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 07:28:03 -0400
Date: Fri, 20 Jun 2003 07:40:30 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: misty-@charter.net, Bernd Schubert <bernd-schubert@web.de>,
       andre@linux-ide.org, linux-kernel@vger.kernel.org, despair@adelphia.net
Subject: Re: Problems with IDE on GA-7VAXP motherboard
Message-ID: <20030620114030.GA11827@charter.net>
References: <200306191429.40523.bernd-schubert@web.de> <20030619193118.GA32406@charter.net> <20030620075249.GA7833@charter.net> <20030620105853.A16743@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620105853.A16743@ucw.cz>
User-Agent: Mutt/1.3.28i
From: misty-@charter.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 10:58:53AM +0200, Vojtech Pavlik wrote:
> On Fri, Jun 20, 2003 at 03:52:51AM -0400, misty-@charter.net wrote:
> 
> > using hdparm -i /dev/hda shows the disk wasn't configured to do any pio
> > mode or udma/dma mode at boot time. Strange, right?
> 
> Not very strange. Some disks even cannot report it. And, any disk if set
> to PIO only may not report any mode as active, since that is only
> applicable to DMA modes.
Hmm. Interesting, as the information shown with -i matches what the disk
supports, and -I matches what the controller supports. maybe a bug in
hdparm, or perhaps I was using it incorrectly. I'll investigate.

> If you use hdparm -I and the drive reports udma4, it can understand
> udma4, since hdparm -I is straight from the drive's mouth.
again that's interesting as -i shows the max the disk can do is udma2 -
and in fact, that *is* the max.

> > add in the fact I currently have a 40 wire cable connected to the disk
> > and my brain starts frying :)
> 
> That's a problem I assume. If the drive can do udma3 and higher, the
> chipset can do udma3 and higher, and you have a 40-wire cable and some
> bad luck, the BIOS or the driver may misdetect the cable and try to
> operate the drive at, most likely, udma4. This won't work, of course.
hrm. The BIOS detects I have a 40 wire cable, however tells the chipset
that I have an 80 wire cable. (Confirmed by checking /proc/ide/via) So, things are pretty f'd up in the BIOS, and I can't figure out why it's doing this. Not that it really matters now that I can get it to work *anyway* - but.

> > At a suggestion of a friend, I set the disk to use mdma2 - via the line:
> > 
> > hdparm -Xmdma2 -d1 /dev/hda
> 
> Don't do this. If your drive supports udma, then there is no reason to
> use mwdma. Ever. mwdma is not crc-protected and that can lead to drive
> data corruption, namely in the case where you seem to have cabling
> problems.
I was totally unaware of this. Thanks for the information!

> 
> If you have a 40-wire cable, udma2 will work just fine on it. If you
> want a slower speed, use udma1 or udma0, which is the same speed as
> mwdma2, but is CRC protected and thanks to the udma signalling also more
> robust.
OK, I wasn't aware udma2 worked on this type of cable, and was planning
on switching back to the other 80 wire cable before I continued. Thanks.

> 
> > It worked, for all of two seconds. Remember, this is a WD drive. WD
> > drives, or at least mine, like to screw up in pretty amazing ways when
> > you turn dma on initially. Mine throws a screenful of CRC errors,
> > causing the kernel to reset the ide channel.
> 
> CRC errors in mwdma mode? Weird. Those CRC errors must've come from the
> drive itself - them not being transfer CRC errors but surface CRC
> errors. That's mean the drive is dying and you should be getting them in
> PIO mode as well
I know a little more about this than you having dealt with this buggy
drive for more than two years. Basically wd drives don't deal well with
DMA as their hardware doesn't follow the spec - specifically, something
in the crc handling is f'd up, so occasionally the drive will report a
crc error that doesn't actually exist. And it will continue reporting
crc errors infinitely until the ide channel and all devices on it are
reset - which can be maddening at times when I'm playing quake,
something tries to load a file and for two seconds my computer is
frozen. Luckily due to the kernel's error handling, it can deal with
this, and life goes on. I've never lost any data due to this hardware
bug, it's just annoying. If you're in the market for a hard disk, I'd
avoid Western Digital hard disks for this very reason - they're cheap
for a reason. :)

The whole crc errors filling the screen thing - that's actually NORMAL
for this disk when you initially turn dma on. It used to happen on the
old system, so I was actually glad to see it happening again, because it
meant things were working. The error messages weren't showing up in
udma4 mode, and in fact it was acting as if dma was totally turned
off... I guess because the disk doesn't understand udma4 at all.

> > Oddly, I noticed that dma
> > was still on despite the fact the channel had been reset - so I checked
> > with -I again, only to find out now the disk was told to use udma*3*! -
> > this wasn't getting me anywhere. >D
> 
> Note that the asterisk stays even after the drive is used back in PIO
> mode. The way to check if DMA is being used is hdparm /dev/hd*
Yes, I did that, which is why I noticed dma was still enabled to my
astonishment. Rather than get my hopes up, I checked what the drive was
set to with -i, and nothing showed up - so I checked with -I and my
eyebrow started twitching because it had neither stayed at the setting
I'd set nor gone back to the setting it was at before.

I've never set up a hard disk with PIO modes before, so I'd like to hear
any advice you have on that - currently whatever setup the hard disk is
trying to use with dma off is malfunctioning in a grand manner, and I'd
like to have a failsafe in case for whatever reason the hard disk throws
the gauntlet down and refuses to do dma in the future for whatever
reason.

Mostly, I want to know if what is listed by a -i/-I is assumed 'safe' to
use. Certaintly I'm expecting you to say 'no, backup your data first
before experimenting' so, you need not surprise me. However, any other
advice you have would certaintly be appreciated. Also, I have a 486 with
dma capable hard disks that has a non dma capable disk controller, so if
I can get PIO modes working on it's hard disks it might speed things up
slightly, who knows.

Thanks for your comments,
Timothy C. McGrath
