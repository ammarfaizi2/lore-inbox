Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUHMPNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUHMPNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUHMPNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:13:51 -0400
Received: from netmail01.eng.net ([213.130.128.38]:29144 "EHLO
	netmail01.eng.net") by vger.kernel.org with ESMTP id S265909AbUHMPNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:13:46 -0400
From: Chris Clayton <chris@theclaytons.giointernet.co.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: CDMRW in 2.6
Date: Fri, 13 Aug 2004 16:15:24 +0000
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk> <200408131435.17362.chris@theclaytons.giointernet.co.uk> <20040813135036.GR2663@suse.de>
In-Reply-To: <20040813135036.GR2663@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408131615.24613.chris@theclaytons.giointernet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 Aug 2004 13:50, Jens Axboe wrote:
> On Fri, Aug 13 2004, Chris Clayton wrote:
> > > > I'll try a full (as opposed to quick) blank with cdrwtool plus a
> > > > forced format with cdmrw and report back when that has finished.
> > >
> > > Yes please do that, if that doesn't work it's really screwed.
> >
> > Ok, here's the results:
> >
> > [chris:~]$ cdrwtool -t 10 -d /dev/hdc -b full
> > setting speed to 10
> > using device /dev/hdc
> > full blank
> > 1386KB internal buffer
> > setting write speed to 10x
> >
> > <<no new messages from dmesg>>
> >
> > [chris:~]$ cdmrw -d /dev/hdc -f full -F
> > not a mrw formatted disc
> > LBA space: DMA
> >
> > <<no new messages from dmesg>>
> >
> > [chris:~]$ while cdmrw -d /dev/hdc -f full | grep "mrw format running" ;
> > do sleep 20; done
> > mrw format running
> > <snip>
> > mrw format running
> >
> > <<no new messages from dmesg>>
> >
> > [chris:~]$ mkudffs --media-type=cdrw /dev/hdc
> > start=0, blocks=16, type=RESERVED
> > start=16, blocks=3, type=VRS
> > start=19, blocks=237, type=USPACE
> > start=256, blocks=1, type=ANCHOR
> > start=257, blocks=31, type=USPACE
> > start=288, blocks=32, type=PVDS
> > start=320, blocks=32, type=LVID
> > start=352, blocks=32, type=STABLE
> > start=384, blocks=1024, type=SSPACE
> > start=1408, blocks=256480, type=PSPACE
> > start=257888, blocks=31, type=USPACE
> > start=257919, blocks=1, type=ANCHOR
> > start=257920, blocks=160, type=USPACE
> > start=258080, blocks=32, type=STABLE
> > start=258112, blocks=32, type=RVDS
> > start=258144, blocks=31, type=USPACE
> > start=258175, blocks=1, type=ANCHOR
> >
> > <<the following new messages from dmesg>>
> >
> > cdrom: hdc: mrw address space DMA selected
> > cdrom open: mrw_status 'mrw complete'
> > hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> > hdc: command error: error=0x54
>
> Ok yes, same error. It's the drive doing something odd, I have no idea
> what...
>
> > I'll try the same process (except the blanking) with a brand new piece of
> > media and report when that is complete.
>
> I doubt it'll help.

You were right Jens, it didn't :(

mkudffs resulted in the following new messages in dmesg:

cdrom: hdc: mrw address space DMA selected
cdrom open: mrw_status 'mrw complete'
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1048576
Buffer I/O error on device hdc, logical block 262144
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 1048580
Buffer I/O error on device hdc, logical block 262145
hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdc: media error (bad sector): error=0x30
end_request: I/O error, dev hdc, sector 917504
Buffer I/O error on device hdc, logical block 229376
hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdc: media error (bad sector): error=0x30
end_request: I/O error, dev hdc, sector 917508
Buffer I/O error on device hdc, logical block 229377
hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdc: media error (bad sector): error=0x30
end_request: I/O error, dev hdc, sector 917120
Buffer I/O error on device hdc, logical block 229280
lost page write due to I/O error on hdc
hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdc: media error (bad sector): error=0x30
end_request: I/O error, dev hdc, sector 917500
Buffer I/O error on device hdc, logical block 229375
lost page write due to I/O error on hdc

One perhaps interesting thing is that, although there were fewer instances of 
the error, the first two instances on this new media were for exactly the 
same sectors/logical block as on the previously-used-and-blanked media. 
Although I'm relatively inexperienced in Linux, I have worked in IT for over 
25 years, and that's just too much of a coincidence for me. I guess it 
supports Jens' belief that the drive is doing something odd. One other 
interesting thing is that when it ran cdmrw, it reported that the media was 
already cdmrw formatted, even though I know it was blank, because I'd just 
removed the selophane wrapping from the jewel case! Oh well, Mt Rainier would 
be nice to have, but I'll just have to be content with packet writing, 
unless...

Slightly off-topic I guess, but can anyone name an IDE drive that does support 
Mt Rainier with a 2.6 kernel, please. Mail me off-list if that would be the 
correct (netiquette) thing to do - although there could well be at least two 
other folks interested in the reply.

-- 
Chris
