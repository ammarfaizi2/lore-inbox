Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWBTVbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWBTVbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBTVbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:31:36 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:58910 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932404AbWBTVbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:31:35 -0500
Message-ID: <43FA34F0.8020201@cfl.rr.com>
Date: Mon, 20 Feb 2006 16:30:24 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: device-mapper development <dm-devel@redhat.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Support HDIO_GETGEO on device-mapper volumes
References: <43EBEDD0.60608@us.ibm.com> <20060210145348.GA12173@agk.surrey.redhat.com> <43ECAD5B.9070308@cfl.rr.com> <62b0912f0602101227q719e712bq40da5b2f0c5422c5@mail.gmail.com> <43ED03F1.4010308@cfl.rr.com> <62b0912f0602201009o3e3338d4lf7bdcdf1af172dda@mail.gmail.com>
In-Reply-To: <62b0912f0602201009o3e3338d4lf7bdcdf1af172dda@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2006 21:32:35.0855 (UTC) FILETIME=[2A7511F0:01C63665]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14280.000
X-TM-AS-Result: No--26.300000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> 
> Obviously.
> 
> That doesn't stop the Linux kernel and device-mapper from presenting
> usable numbers to user space tools.
> 
> What are "usable numbers"?
> The only usable numbers are the exact ones that the BIOS uses, because
> they are the only CHS numbers that have a purpose:
> 
> The purpose of those numbers is backwards compatibility with DOS and
> Windows.  Stuff like PartitionMagic, FreeDOS, odd boot loaders
> (including Windows XP's), weird implementations of fdisk, etc.
> 
> And that's the reason that the kernel and device mapper should either
> represent the numbers that the BIOS currently uses, or nothing at all.
> 
> Fair'n'square..
> 

Exactly!  If guesses have to be made because the correct values can not 
be obtained from the bios, then it should be fdisk/parted/whatever that 
has to make that guess ( or ask the user for manual intervention ), not 
the kernel.

> The statement that "any value is gibberish" is plain wrong, since the
> BIOS translations are useful values under some circumstances.
> 

In certain dm configurations ( specifically, when used for dmraid 
assisted hardware fakeraid ) it might make sense, but for many dm 
configurations it won't because the bios can't access the volume anyhow, 
so it hardly makes any sense to associate a bios geometry with it. 
That's what I meant by gibberish; if the drive isn't seen by the bios, 
any geometry you come up with has no meaning.

> In cases where it does make sense, you want a consistent and well
> maintained method of matching BIOS drives to devices and reporting
> BIOS numbers.
> 

Right.  Unfortunately, it seems this was specifically removed from the 
kernel because it was problematic, which I don't really mind since CHS 
addressing needs to die anyhow.

> In cases where it does not make sense, you just want to return error
> and let the app handle it.
> 

Bingo.

>> Just bring the apps still using it ( grub, lilo ) into the 21st century and have them
>> stop using these meaningless values in the first place.
> 
> LILO is already fit for fight if you use the right flag.
> 
> Good idea to fix GRUB.
> The GRUB code does look like a mess to me, though.
> An ETA on GRUB2 would be nice, or an alternate source tree where
> people could improve on the existing GRUB..
> 

IIRC, grub just uses the geometry it finds in the MBR, or you can 
override with the geometry command.

>> LBA has been around for a good 10 years now, so I think it is safe to no longer
>> require these made up values to support CHS addressing.
> 
> If you rip all CHS out of the kernel right now, user space tools has
> to make guesses when mucking with partition tables.  Any attempts to
> make Linux <whatever>fdisk compatible with other fdisk's will be
> futile.  Stuff like for example placing a partition on a (virtual)
> cylinder boundary is going to break when Linux <whatever>fdisk
> translates LBA to CHS in one way (since the kernel doesn't provide a
> meaningful value) and your BIOS does it another.
> 

Right, but this has already been done.  The values currently in the 
kernel are not taken from the bios, so as you said, either report it 
right, or don't report it at all.

In the case where fdisk must initialize a brand new MBR, then it should 
assume sensible defaults and allow you to override.  Most of the time 
though, people will already have a drive formatted by windows which will 
have the correct geometry written in the MBR, so the linux tools will 
just use that.

> 
> Ok, the better approach might be to destroy HDIO_GETGEO entirely and
> tell userspace apps to use /sys/firmware/edd/int13_dev instead.  It
> provides for a cleaner implementation.
> 
> But then again, that breaks compatibility with current tools.
> 

They are already broken since the HDIO_GETGEO isn't returning the values 
from the bios.  What is the status of edd?  Is that officially supported 
or is it depreciated?  If it is ok to use, then it would probably be a 
good place for fdisk to get that info from, though it's going to have to 
figure out which int13_dev ( if any ) corresponds to the device you are 
partitioning.  Sensible defaults for well known devices like /dev/hda 
should cover most cases, but not all.  For instance, I recently 
configured a server's bios to disable the primary ide channel because 
that disk was bad and I needed to boot from the second mirrored drive, 
so /dev/hdb actually corresponded to bios device 80, not /dev/hda.

> A good way to get the ball rolling could be if we could all agree that
> there are a number of tools that need the BIOS CHS numbers.  Then we
> can decide where the universal logic that attempts to guess which
> devices are which should go.  Then a proper implementation could be
> discussed and conjured, and dmraid, <whatever>fdisk, perhaps LILO/GRUB
> etc. could be made dependant on it.  And THEN the HDIO_GETGEO could be
> ripped...
> 

Aye, well put.  So let's see here.  As far as I can see, the only tools 
that need this information are ones that can create MBRs, so that's 
fdisk, cfdisk, parted, and friends.  Everything else can/should just use 
the values listed in the MBR.

Agree?

> Anyway, just a personal idea, your concept of completely nuking CHS
> from the kernel right now might be acceptable as well.
> 

