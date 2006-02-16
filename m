Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWBPQPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWBPQPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWBPQPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:15:34 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:7555 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S932149AbWBPQPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:15:33 -0500
Thread-Index: AcYzFC/O9CYqg4NjS+yk4+QgM26urA==
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F4A519.4050005@bfh.ch>
Date: Thu, 16 Feb 2006 17:15:21 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <11 <Pine.LNX.4.61.0602160728100.20319@chaos.analogic.com> <43F499A8.4080204@cfl.rr.com>
In-Reply-To: <43F499A8.4080204@cfl.rr.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 16:15:21.0525 (UTC) FILETIME=[2F75CE50:01C63314]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Phillip Susi wrote:
> linux-os (Dick Johnson) wrote:
> 
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
> 

Guys, lets not forget ourself... ok?

For an in depth explanation of the whole c/h/s lba thing go here:
http://www.mossywell.com/boot-sequence/

This is the best reference i've found thus far.

I think what we should be talking about here is what is necessary to
write a mbr and partition a disk, not how the whole c/h/s shebang works,
because that is no longer of any real interest.

The important fact here is that Linux does not really depend on an MBR
which matches the BIOS. Only other os do...

The current behaviour of partitioning tools under Linux is (most of the
time) quite simple: If an MBR exists, determine the geometry to use to
create new partitions from the MBR.

The problem starts when creating a new MBR. In this case we need a
geometry. There most Utilities depend (probably historically) on
HDIO_GETGEO. By now we know that these values do not necessarily
correspond to bios values. They don't have to, because they can contain
as much bogus as we want. Why? Because all partitions will be created
with these values as a base. The question here is actually only if the
user wants compatible values or not.

The problem increases when we use tools such as dosemu, which need to
emulate a bios. If we do things there like deploy windows with dosemu
(please remember, this is just an example), the geometry values
represented by dosemu need to be exactly the same as the bios returns.

The problem increases further with the use of bootloaders. Because they
need at least some basic geometry information. See the thread "Support
HDIO_GETGEO on device-mapper volumes" in this mailinglist for an example
(Actually this thread is among the reasons why I started this).

So the whole thing comes to the question whether we drop any interfaces
reporting geometry, making userspace tools responsible or if we provide
a common interface which can be modified by userspace if necessary.
(There are no other workable options i can see)

I vote for keeping it in the kernel, because otherwise tons of
user-space tools would need to be modified and it actually might be the
case that a driver knows what he's returning...

