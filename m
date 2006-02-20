Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWBTSJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWBTSJZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWBTSJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:09:25 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:53047 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932619AbWBTSJY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:09:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=foJX6k4hefVXCcGmjJu5T5da3SJZzcomsCvyFjNVf+78g/NRj0mJ6PB0lG3ES/GVPuq62ACN1tMfnfkvJ6gClgf50WqJVHviMAK+BqmxC2NcybMt1pRk8rZjRPj4wL3ggW3D/OB0X+dCsAcs93t5QIw4XCf3V6QiMs5XNNM6aew=
Message-ID: <62b0912f0602201009o3e3338d4lf7bdcdf1af172dda@mail.gmail.com>
Date: Mon, 20 Feb 2006 19:09:22 +0100
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: Support HDIO_GETGEO on device-mapper volumes
Cc: "device-mapper development" <dm-devel@redhat.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       "Chris McDermott" <lcm@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43ED03F1.4010308@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EBEDD0.60608@us.ibm.com>
	 <20060210145348.GA12173@agk.surrey.redhat.com>
	 <43ECAD5B.9070308@cfl.rr.com>
	 <62b0912f0602101227q719e712bq40da5b2f0c5422c5@mail.gmail.com>
	 <43ED03F1.4010308@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Molle Bestefich wrote:
> > It would be better to make the decision once and for all, in one place.
> >
> > It would be even better for the HDIO_GETGEO call to return the same
> > geometry that the BIOS uses, so that Grub is handed numbers that
> > actually mean *something*.
>
> The problem is that the numbers don't actually mean anything, even to
> the bios.  They are only there for backward compatibility with real mode
> software that makes int 13 calls.  The bios just fakes the geometry
> anyway so it can emulate something, but there really is no meaning to
> the geometry; it's just smoke and mirrors.

Obviously.

That doesn't stop the Linux kernel and device-mapper from presenting
usable numbers to user space tools.

What are "usable numbers"?
The only usable numbers are the exact ones that the BIOS uses, because
they are the only CHS numbers that have a purpose:

The purpose of those numbers is backwards compatibility with DOS and
Windows.  Stuff like PartitionMagic, FreeDOS, odd boot loaders
(including Windows XP's), weird implementations of fdisk, etc.

And that's the reason that the kernel and device mapper should either
represent the numbers that the BIOS currently uses, or nothing at all.

Fair'n'square..

> In the case of dm, which geometry should it report?  In some cases it
> might make sense to pass up the values from the bios,

It does, I've come across a few.

> but in most, there
> is no sensible way to choose what to report, and any value you do report
> is meaningless gibberish anyhow, so why bother at all?

The statement that "any value is gibberish" is plain wrong, since the
BIOS translations are useful values under some circumstances.

In cases where it does make sense, you want a consistent and well
maintained method of matching BIOS drives to devices and reporting
BIOS numbers.

In cases where it does not make sense, you just want to return error
and let the app handle it.

> Just bring the apps still using it ( grub, lilo ) into the 21st century and have them
> stop using these meaningless values in the first place.

LILO is already fit for fight if you use the right flag.

Good idea to fix GRUB.
The GRUB code does look like a mess to me, though.
An ETA on GRUB2 would be nice, or an alternate source tree where
people could improve on the existing GRUB..

> LBA has been around for a good 10 years now, so I think it is safe to no longer
> require these made up values to support CHS addressing.

If you rip all CHS out of the kernel right now, user space tools has
to make guesses when mucking with partition tables.  Any attempts to
make Linux <whatever>fdisk compatible with other fdisk's will be
futile.  Stuff like for example placing a partition on a (virtual)
cylinder boundary is going to break when Linux <whatever>fdisk
translates LBA to CHS in one way (since the kernel doesn't provide a
meaningful value) and your BIOS does it another.

> > When 'dmraid' has assembled an array, it should find the matching BIOS
> > drive in /proc/bios/int13_dev* and then it should tell device-mapper
> > to present that geometry to whomever asks via HDIO_GETGEO.
>
> dmraid is only one client of the kernel device mapper.  It has numerous
> uses that have nothing to do with hardware fakeraid, including LVM.  In
> the special case of dmraid there is a bios int13 dev for the raid that
> provides some geometry, but why hack dm for this special case

Ok, the better approach might be to destroy HDIO_GETGEO entirely and
tell userspace apps to use /sys/firmware/edd/int13_dev instead.  It
provides for a cleaner implementation.

But then again, that breaks compatibility with current tools.

A good way to get the ball rolling could be if we could all agree that
there are a number of tools that need the BIOS CHS numbers.  Then we
can decide where the universal logic that attempts to guess which
devices are which should go.  Then a proper implementation could be
discussed and conjured, and dmraid, <whatever>fdisk, perhaps LILO/GRUB
etc. could be made dependant on it.  And THEN the HDIO_GETGEO could be
ripped...

Anyway, just a personal idea, your concept of completely nuking CHS
from the kernel right now might be acceptable as well.
