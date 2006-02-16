Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWBPQjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWBPQjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWBPQjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:39:15 -0500
Received: from spirit.analogic.com ([204.178.40.4]:20231 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932313AbWBPQjO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:39:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43F499A8.4080204@cfl.rr.com>
X-OriginalArrivalTime: 16 Feb 2006 16:39:05.0971 (UTC) FILETIME=[807F0430:01C63317]
Content-class: urn:content-classes:message
Subject: Re: RFC: disk geometry via sysfs
Date: Thu, 16 Feb 2006 11:39:05 -0500
Message-ID: <Pine.LNX.4.61.0602161125580.23082@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: disk geometry via sysfs
thread-index: AcYzF4CIQcNhwCsIRmWG2oNaD5f7gw==
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <11 <Pine.LNX.4.61.0602160728100.20319@chaos.analogic.com> <43F499A8.4080204@cfl.rr.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Seewer Philippe" <philippe.seewer@bfh.ch>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2006, Phillip Susi wrote:

> linux-os (Dick Johnson) wrote:
>>> I'm talking about the geometry of the disk.  If the disk has 16 sectors
>>> and 8 heads, then the maximum value allowed for any valid address is 16
>>> in the sector field and 7 in the heads field.  This influences the
>>> translation to/from LBA.  A sector with LBA of 1234 would have a CHS
>>> address using this geometry of 9/5/3.  If the disk reports a geometry of
>>> x/8/16 but the bios is using a geometry of x/255/63, then when you pass
>>> 9/5/3 to int 13 it will fetch LBA 144902 which is clearly not going to
>>> give you what you wanted.
>>>
>>
>> Wrong! The disk gets an OFFSET!  It doesn't care how that OFFSET
>> is obtained. That OFFSET is the sum of some variables. Some start
>> at 0 and some start at 1. The BIOS takes these PHONY things, without
>> checking to see if they "fit" in some pre-conceived notion of
>> "geometery" and sums them all up to make an OFFSET. The C/H/S
>> stuff started and ENDED with the ST-506 interface.  PERIOD.
>>
>
> Please reread my explanation above.  The bios has to compute the
> absolute offset based on the geometry and the values you pass it.  It
> does so by multiplying the track number you pass by the number of
> sectors per track, multiplies the cylinder number by the number of
> sectors per track and the number of tracks, and adds those two values to
> the sector number you pass to arrive at the LBA to read.  If it performs
> the CHS->LBA translation using a different geometry than you used to go
> from LBA->CHS, then it will get the wrong sector.
>

I read it, and it's wrong. You don't bother to learn. I will
take one last hack at this and then drop it.

When a disk is first accessed, the BIOS reads the disk capacity.
That's all. This disk capacity is in 512-byte things called "sectors".

>From that information, ** AND THAT INFORMATION ALONE **, the
BIOS builds a BIOS parameter block (BPB) for subsequent INT 0x13
translation. This will be used ONLY BY THIS BIOS to extract the
required drive access parameters from the BIOS INT 0x13 interface.

The BIOS knows that the maximum number of cylinders is 1024.
It also knows that the maximum head number is 255, and the
maximum sector number is 255 because that's what's available
in the registers.

It will find the sectors to access in AL, the starting cylinder
in CH (low 8 bits) and CL (high 2 bits), CL also contains 6 bits
of the starting sector. DH will contain the head number. Note
that the BIOS interface only has 6 bits available for the sector!
It doesn't care even though there may be 255 in your phony table
it will just adjust the head number during the access to obtain
the offset exactly.

With that information, the BIOS will tear apart an offset into,
the highest available cylinder, the highest available starting
sector, and the highest head number.

Since there are only 6 bits available for sectors, it will be
limited to 64, in spite of the fact that there may be thousands
of sectors available on a real track.

You see that these are simply "chunks" of sectors. You can make
them up from many different combinations of heads and cylinders.

If the disk has no equivalent "read capacity" command, like
floppy disks and old ST-506 interface disks, then it needs to
use it's internal tables generated from C/H/S that was either
supplied by IBM (for the first AT) or, later when Phoenix started
making BIOS(es), by the user setting a particular type. If the
BIOS is set to "auto" the C/H/S are calculated from the "read
capacity command" as described.

In all cases, the C/H/S is never read from the media. DOS `fdisk`
puts a BPB on the media after it has been partitioned. It is a
throw-back to floppy disks. It is possible for some donkey's boot-
code to fail to boot if it doesn't see a BPB at the correct location,
however that was a W/95 problem.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5590.48 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
