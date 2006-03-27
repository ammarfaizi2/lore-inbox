Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWC0RpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWC0RpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWC0RpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:45:09 -0500
Received: from spirit.analogic.com ([204.178.40.4]:63495 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751130AbWC0RpH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:45:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060327161845.GA16775@csclub.uwaterloo.ca>
x-originalarrivaltime: 27 Mar 2006 17:44:51.0695 (UTC) FILETIME=[2670F7F0:01C651C6]
Content-class: urn:content-classes:message
Subject: Re: Lifetime of flash memory
Date: Mon, 27 Mar 2006 12:44:50 -0500
Message-ID: <Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Lifetime of flash memory
Thread-Index: AcZRxiZ4jpm/fmyxRw+S+o05ra2AfA==
References: <20060326162100.9204.qmail@science.horizon.com> <4426C320.9010002@yandex.ru> <20060327161845.GA16775@csclub.uwaterloo.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>, <linux@horizon.com>,
       <kalin@thinrope.net>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2006, Lennart Sorensen wrote:

> On Sun, Mar 26, 2006 at 08:36:48PM +0400, Artem B. Bityutskiy wrote:
>> I'm actually interested in:
>>
>> 1. CF wear-levelling algorithms: how good or bad is it?
>
> Depends on the maker.
>
>> 2. How does CF implement block mapping, does it store the mapping table
>> on-flash or in memory, does it build it by scanning, how scalable are
>> those algorithms.
>
> Well the map has to be stored in flash or other non volatile memory.
>
>> 3. Does CF perform bad erasable blocks hadling transparently when new
>> bad eraseblocks appear.
>
> No idea, but it is almost certainly also vendor specific.
>
>> 4. How tolerant CF to powrer-offs.
>
> I have seen some that a power off in the middle of a write would leave
> the card dead (it left it with a partially updated block map).  On
> others nothing happened (well you loose the write in progress of course
> just as a harddisk would).
>
>> 5. Is there a Garbage Collector in CF and how clever/stupid is it.
>
> That is vendor specific.  Depends how they did it.  Different
> generations from a given company may also be different in behaviour.  I
> imagine some parts of it are patented by some of the comapnies involed
> in flash card making.
>
>> I've heard CF does not have good characteristics in the above mentioned
>> aspects, but still, it would be interesting to know details. I'm not
>> going to use CFs, but as I'm working with flashes, I'm just interested.
>> It'd help me explaining people why it is bad to use CF for more serious
>> applications then those just storing pictures.
>
> The wearleveling is not a part of the CF spec.  So saying anything about
> CF in general just doesn't make much sense.  It all depends on the
> controller in the CF you are using.
>
> Len Sorensen

CompactFlash(tm) like SanDisk(tm) has very good R/W characteristics.
It consists of a connector that exactly emulates an IDE drive connector
in miniature, an interface controller that emulates and responds to
most IDE commands, plus a method of performing reads and writes using
static RAM buffers and permanent storage in NVRAM.

The algorithms used are proprietary. However, the techniques used
are designed to put all new data into permanent storage before
updating a block location table in static RAM. This table is built
when a reset is sent to the device and dynamically as long as there
is power to the chip. Destruction of this table will not lose any
data, because it is built upon power-up from block relocation
information saved in NVRAM. Note that the actual block size is
usually 64k, not the 512 bytes of a 'sector'. Apparently, some
of the data-space on each block is used for relocation and
logical-to-physical mapping.

Experimental data show that it is not possible to 'destroy' the
chip by interrupting a write as previously reported by others.
In fact, one of the destroyed devices was recovered by writing
all the sectors in the device as in:
 	 `dd if=/dev/zero of=/dev/hdb bs=1M count=122`.

Note that there __is__ a problem that may become a "gotcha" if
you intend to RAW copy devices, one to another, for production.
The reported size (number of sectors) is different between
devices of the same type and manufacturer! Apparently, the size
gets set when the device is tested.

If you intend to make a bootable disk out of one of these, you
need to make a partition that is smaller than the smallest size
you are likely to encounter, on a 63-sector (virtual head) boundary.
Otherwise, at least with FAT file-systems, the device will boot
but file-system software won't be able to find the directory!

I have had very good results with these devices. My embedded
software mounts the root file-system R/O with a ram-disk mounted
on /tmp and /var. However, any parameter changes made by
the customer require a mount change to R/W, then a change
back to R/O. We thought that this was necessary. However,
we have a two year old system that writes hourly data to R/W
logs without any problems whatsoever. Basically, finite life
is a fact, but you are unlikely to encounter it as a problem
with real-world systems.

There are some 'Camera only' CompactFlash devices out there
such as "RITZ BIG PRINT DIGITAL FILM" made by Lexar Media.
The problem with this is that it's not 5-volt tollerant.
I've found that if you plug this into an IDE converter/connector,
it gets very hot and hangs the whole IDE I/O subsystem. It
didn't burn out anything, however, and I was able to use
it subsequently in my camera which uses only about 3 volts.
So, before you actually purchase something for production
stock, make sure that it works in your hardware.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
