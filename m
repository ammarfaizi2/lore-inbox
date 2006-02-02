Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWBBPYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWBBPYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWBBPYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:24:25 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:38588 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932072AbWBBPYY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:24:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQaTbqEUwR1iLT/z3mKP1P6FlOkH4xoZNyr81tVZYgARNTTI3uAo4Q/YJ2AsLvmIYHpvAque1qUKeHdq0qe7EKTTh6eftPOXeyRU+axfmDsrC6NQoYq0zR6FkfeHhqKk7VqurXpdHsaCXpYutAdwB+WoH64AzfTKbAeSsWvaDd0=
Message-ID: <787b0d920602020724q7be70037qf898da7ea362b2b1@mail.gmail.com>
Date: Thu, 2 Feb 2006 10:24:22 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <1138809303.16643.28.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
	 <200601311333.36000.oliver@neukum.org>
	 <200601311444.47199.vda@ilport.com.ua>
	 <Pine.LNX.4.61.0602011634520.22529@yvahk01.tjqt.qr>
	 <1138809303.16643.28.camel@tara.firmix.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Bernd Petrovitsch <bernd@firmix.at> wrote:
> On Wed, 2006-02-01 at 16:37 +0100, Jan Engelhardt wrote:
> [...]
> > >Do we need to expose IDE master/slave, primary/secondary concepts in Linux?
> > >
> > AFAICS, we do. hda is always primary slave, etc. With the SCSI layer it's
> > (surprisingly) the other way round, sda just happens to be the first disk
> > inserted (SCA, USB, etc.)
>
> The (historical) reason was: There were not enough major/minor numbers
> (IIRC 8 bit for each of them) for a sane (and static) SCSI device number
> mapping (similar to IDE) - just multiply the possible # of partitions *
> # of LUNs * # IDs for a few controllers.

It's a hashing problem, and should have originally been seen as such.
The constraints are that you'd like some stability as devices come
and go. Splitting /dev into fields could have worked nicely:

1. the partition
2. dev type: disk, CD-ROM, built-in (ramdisk,loop), other
3. physical: master/slave, SCSI target, IDE 1/2/other, "is USB"...
4. volatile+rare stuff: PCI slot, ISA address, USB position, LUN

(needlessly crammed into 16 bits: 5:2:4:5 or 5:2:5:4)

For the physical stuff, per-driver values are assigned explicitly
in the source code. Collisions are determined by humans. We make
USB collide with something old, like XT disks and Atari disks.
Collisions are chosen so that normal machines are unlikely to
suffer from them.

Note that I use "IDE 1/2/other". Only an x86 PC can have a primary
or secondary controller, as determined by IO port location. Macs
just have "other", as a single value. (they differentiate based on
the rare and volatile stuff as needed) USB is distinguished from SCSI,
FireWire, and IDE unless delibrately made to collide because of a bit
shortage.

Collisions found at run-time are resolved by mucking with the field
for volatile and rare stuff. Adding a new USB device can will probably
not mess up a different USB device, because the hashing is not too
likely to pick the same number. Adding a new USB device will certainly
not mess up a non-USB device unless the non-USB device is in a class
of physical devices that was delibrately made to collide with USB.
Adding a SCSI device with target ID 4 will only stand a chance of
messing up other SCSI devices with target ID 4, on other busses or
with other LUNs. It wouldn't mess up SCSI target ID 3, FireWire, USB,
or anything else UNLESS those share the "physical" field ID.

Not that Joerg would like this: LUN values and bus numbers get tossed
into a hash function. You can't recover the individual numbers.
