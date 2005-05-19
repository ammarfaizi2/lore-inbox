Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVESMwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVESMwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVESMwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:52:34 -0400
Received: from alog0431.analogic.com ([208.224.222.207]:13184 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262477AbVESMuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:50:52 -0400
Date: Thu, 19 May 2005 08:50:07 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Michael H. Warfield" <mhw@wittsend.com>
cc: linux@horizon.com, lsorense@csclub.uwaterloo.ca,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sync option destroys flash!  Now I'm confused...
In-Reply-To: <1116450529.4384.135.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0505190821080.29560@chaos.analogic.com>
References: <20050517203117.10588.qmail@science.horizon.com>
 <Pine.LNX.4.61.0505171638560.10811@chaos.analogic.com>
 <1116450529.4384.135.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Michael H. Warfield wrote:

> 	All right...  Now I'm really confused.
>
> 	There are, obviously, some individuals on this list who are a LOT more
> knowledgeable about the internal workings of flash, so I'm hoping for a
> clear(er) understanding of just WHAT is going on here.
>
> On Tue, 2005-05-17 at 16:43 -0400, Richard B. Johnson wrote:
>> On Tue, 17 May 2005 linux@horizon.com wrote:
>
>>>> It can also respond to loosing power during write by getting it's state
>>>> so mixed up the whole card is dead (it identifies but all sectors fail
>>>> to read).
>
>>> Gee, that just happened to me!  Well, actually, thanks to Linux's
>>> *insistence* on reading the partition table, I haven't managed to
>>> get I/O errors on anything bit sectors 0 through 7, but I am quite
>>> sure I wasn't writing those sectors when I pulled the plug:
>
>>> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
>>> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
>>> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
>>> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
>>> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
>>> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
>>> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
>>> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
>>> ide0: reset: success
>>> hda: read_intr: status=0x51 { DriveReady SeekComplete Error }
>>> hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=6, sector=6
>>> end_request: I/O error, dev 03:00 (hda), sector 6
>>> unable to read partition table
>> [SNIPPED...]
>
>> You can "fix" this by writing all sectors. Although the data is lost,
>> the flash-RAM isn't. This can (read will) happen if you pull the
>> flash-RAM out of its socket with the power ON.
>
> 	I'm the original poster and someone in another message remarked about
> not having enough details on the damage to the card...  So I just did
> some spot checking on the card for some details.
>
> 	Block checking with dd bs=512 if=/dev/sda gave me some indicators...
>
> Blocks 0-7 DOA, hard read errors, 0+0 records in.
>
> Blocks 8-31 would read 8 blocks at a time and then give me an error, but
> the next 8 blocks would read fine.  So 24 consecutive blocks SEEMED to
> read but strangely.
>
> Blocks 32-39 DOA
>
> Blocks 40-71 would read 8 blocks at a time.
>
> Roughly 1/3 of the blocks seem to be dead in multiples of 8 blocks on 8
> block boundries early on.  No real pattern to which ones were dead and
> which ones would read 8 and then error.
>
> Once past block 512, huge blocks would be readable but eventually give
> me an error.
>
> Dead fields (0 records read) were always multiples of 8 512 byte blocks,
> 4KBytes falling on an 4K boundry.
>
> Reading with dd bs=4096 gave similar results for 4K blocks with skip
> count less than 64.  Skip count 64 and greater gave me large swaths that
> were readable.  No time did I see a partial record read (indicating a
> failure off a 4K boundry).
>
> 	Basically, that re-enforced my option that it was block wear-out from
> uneven wear leveling when copying that 700 Meg file and beating the
> bejesus out of the FAT tables.  Front part of the flash was heavily
> damaged with sporatic damage deeper in the flash.
>
> 	Now, I saw this message...  Well...  I didn't remove the key when it
> was being written to but, what the hell...  The key is dead, I've got
> nothing to loose, and it might yield some more information as to the
> nature of the failure.  So I copied zeros to the entire key with "dd
> if=/dev/zero of=/dev/sda bs=16M".  I'll be a son of a bitch but that key
> recovered.  I've partitioned it and read the whole damn thing back end
> to end and it's perfect.
>
> 	Ok...  So, WTF?  It wasn't (AFAICT) due to loss of power or pulling it
> while writing.  What was this failure and why did overwriting it fix it?
> Did the stick just flaw out all the burned out blocks or did it really
> recover the ECC errors?  I'm really baffled now.
>
> 	BTW...  I've killed the "sync" option in hal (you just have to create
> an XML policy file in the right location to specify that option as false
> in all cases) and have been beating the crap out of several other keys
> without a single failure.  I'm going to try this key again...
>
> 	Thank you very VERY much for this hint to recover the damaged key.
> That's a trick I've used for damaged IDE & SCSI hard drives (recover
> head drift and soft errors) and I never thought to try it with a flash
> key.  I'll be damned if I understand just what has happened at this
> point but I really appreciate that trick.
>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
>>   Notice : All mail here is now cached for review by Dictator Bush.
>>                   98.36% of all statistics are fiction.
>
> 	Regards,
> 	Mike

The problem is that it's a RAM disk that uses flash-RAM, plus a
little bit of SRAM for one page of I/O. Some devices use two
pages of SRAM to ping-pong for speed. The size of the 'pages'
might vary with the manufacturer. The only thing known is that
these pages will be a multiple of the de facto 512 byte 'sector'
size of a physical disk.

You fixed the device by writing to the whole device without
an intervening read. Writes work like this. The data written goes
into a SRAM page that is shadowed. When that page is filled,
before another page is switched, the flash-RAM page that was
shadowed is now written to the real flash-RAM. This is necessary
because flash-RAM can only be written by resetting bits, not
setting them. So first the page is erased which takes a lot of
time and sets all the bits high. The writing process sends an
unlock-sequence to the flash-RAM controller, followed by the
offset into the page, followed by the data byte. This also
takes time so flash-RAM without the SRAM random-access shadow
page is somewhat limited in value. This process continues util
you have written the whole device.

Normal random access works like this, the page to be accessed
is calculated by dividing the offset you want, by the real
page-size. The offset into that page is the remainder from
the division. Any unflushed data in the SRAM gets written to
the device as previously shown. The newly calculated page
is read into the SRAM. You do I/O from the SRAM. The chip
remembers if any writes occur. If a write occurs, the contents
of the SRAM is flushed to the calculated page any time the
page is about to be changed. There is also a "stale" alogrithm
that writes out a page that hasn't been accessed for some
time.

Now, if you interrupt this sequence by killing the power at
some 'bad' time, data will not be correct. In fact, you could
have an erased page with all bits set.

Now, when you have a file-system that has inodes scattered
all through it, any inodes that are on an erased page will
cause the next access to be at some offset (sector) that
doesn't exist. Since there are no 'sector IDs' as shown
in the errors reported, they must be created by the hard-disk
emulation. So, looking at errors with Sector ID=6, etc.,
simply means that the emulator was 'confused'. It was probably
the Nth wrap of some hardware variable.

Anyway, I've used the SanDisk and PNY flash-RAM that emulates
a 'type 3' IDE drive since they first became available. I haven't
killed any yet. But.... I've destroyed many file-systems by
unplugging them while accesses were occurring.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
