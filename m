Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135871AbRDYPEs>; Wed, 25 Apr 2001 11:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135873AbRDYPEj>; Wed, 25 Apr 2001 11:04:39 -0400
Received: from pop.gmx.net ([194.221.183.20]:46862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135871AbRDYPEW>;
	Wed, 25 Apr 2001 11:04:22 -0400
Message-ID: <3AE6E8F0.BCD74256@gmx.at>
Date: Wed, 25 Apr 2001 17:10:40 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Paul Flinders <P.Flinders@ftel.co.uk>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <Pine.LNX.4.10.10104212104160.627-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andre,

Sorry for responding a little late. I spent some time in the big blue
room (not that is was that blue lately!).

Andre Hedrick wrote:
> 
> On Wed, 18 Apr 2001, Wilfried Weissmann wrote:
> 
> > > off to the head or tail of the drive and get me that raid-voodoo-bios-os
> > > communication transport layer, and do it ins DMA modes, NOW!"
> >
> > "voodoo" would be the sector where the raid configuration is stored
> > then, right!? Maybe I did not understand you properly...
> 
> We are on the same page, good.

OK, and here it is (I extracted this out of the *BSD ata-raid.h):

This is the hpt-raid config block located at offset 0x1220 (sector 9).
All data is stored in little endian format.

0x0020 32 bits; magic cookie
	0x5a7816f0 for good array
	0x5a7816fd for bad array

0x0024 32 bits; raid volume cookie
	used to distinguish between raid volumes

0x0028 32 bits; raid-10 volume cookie ???

0x002C 32 bits; order bitmask
	0x04 status is OK
	0x02 striping
	0x01 mirroring
	Note: bits 0 and 1 appear to matter only in raid 10

0x0030 8 bits; disks in array

0x0031 8 bits; chunksize (1U << (*this+9))

0x0032 8 bits; raid level
	0x00 raid 0
	0x01 raid 1
	0x02 raid 10 & raid 0 (not supported)
	0x03 span
	0x04 raid 3 (not supported)
	0x05 raid 5 (not supported)
	0x06 single disk
	0x07 raid 10 & raid 1 (not supported)
	Note: raid 10 is done with raid level = raid 0 and order = ( mirroring
| striping )

0x0033 8 bits; disk number in array

0x0034 32 bits; raid volume size in sectors

0x0038 32 bits; disk mode ???

0x003C 32 bits; boot mode ???

0x0040 8 bits; boot disk ???

0x0041 8 bits; boot protect ???

0x0042 8 bits; error log entries

0x0043 8 bits error log index

0x0044 32x error entries
	32 bits; timestamp
	8 bits; reason (0xFF=broken, 0xFE=removed)
	8 bits; disk
	8 bits; status
	8 bits; sectors
	32 bits; lba

Mine looks like this:
001220 f0 16 78 5a b3 04 b3 84 00 00 00 00 04 00 00 00
001230 02 05 00 00 c0 2a 28 07 00 00 00 00 78 56 34 12
001240 a5 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
001250 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
This is the signature of the first disk in a raid0 with 2 30GB disks and
16k chunk size.


Everything related to raid 10 is a bit weird, and I am not sure if the
BSD code is 100% accurate there. I am goint to install Abit's Gentus on
my system. This distro states that it supports most Abit hw quite well.
Maybe there is some good sourcecode somewhere...

[snip]

> > > I do not have the desire to do personality tables, but I can.
> 
> > > With about 96% of all linux boxes in the world dependent on some form of
> > > ATA/ATAPI, Linus and Alan are very sensitive to even the sligthest change.
> >
> > I would avoid to change anything there, but do a raid personality...
> > Well, we are back at our your solution vs. my raid personality
> > discussion again!
> 
> No we are back to your "raid personality", and a functional API to the
> ATA driver.

So you want that an ata raid level reuses the existing raid code?

> This is probably the first and last time I will openly agree for someone
> to tell me were to go, and do it ;-).

Well, I guess that is the reason why people keep kicking and banning me
from IRC channels...

> You tell me what you want the driver to do, and I will make it happen.
> It will be legal and technically correct.  Does that sound like a good
> idea?

Perfect! Since FreeBSD supports that controller, do you think Highpoint
would provide us "offical" documentation? Or do you already have some?

Do you want to have a look at my module? As I said only raid 0 is
implemented, but anyway...

I try to get written down what HPT would need from the API in hard
facts.

bye,
Wilfried

-- 
Wilfried Weissmann ( mailto:Wilfried.Weissmann@gmx.at )
Mobile: +43 676 9444465
