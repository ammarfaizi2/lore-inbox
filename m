Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWBUNaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWBUNaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 08:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWBUNaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 08:30:17 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:49540 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030259AbWBUNaP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 08:30:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SDqlE5wdcQMgcM28HQTX8XWcF6iPiDvJMyfExwmmccvQZDhfbnhrPu5Z3CIhytMHLO/HgK7h4qdzEOibs3QA46kt+8sQ+xbhnm01+ii2Rk4cQmw9IwsEafhFqEprcJPus2taKKjpjMXCVKgze/4srarvcwyMKQR3BEafTF+TaLQ=
Message-ID: <62b0912f0602210530i5e820ccci3f4068c9f1b66a7d@mail.gmail.com>
Date: Tue, 21 Feb 2006 14:30:14 +0100
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: Support HDIO_GETGEO on device-mapper volumes
Cc: "device-mapper development" <dm-devel@redhat.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       "Chris McDermott" <lcm@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43FA34F0.8020201@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EBEDD0.60608@us.ibm.com>
	 <20060210145348.GA12173@agk.surrey.redhat.com>
	 <43ECAD5B.9070308@cfl.rr.com>
	 <62b0912f0602101227q719e712bq40da5b2f0c5422c5@mail.gmail.com>
	 <43ED03F1.4010308@cfl.rr.com>
	 <62b0912f0602201009o3e3338d4lf7bdcdf1af172dda@mail.gmail.com>
	 <43FA34F0.8020201@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Right.  Unfortunately, it seems this was specifically removed from the
> kernel because it was problematic,

Ok.  Got an archive link or other references?

> IIRC, grub just uses the geometry it finds in the MBR, or you can
> override with the geometry command.

Last I checked, grub used HDIO_GETGEO when running under Linux.

Which makes it pretty useless if what you say above is true.  Except
of course in the particular cases where the bogus values that the
Linux kernel makes up happens to be correct.

Horribly unsafe way for a boot loader to function, if you ask me.
(Not really grub's fault, more the Linux kernel it seems.)


> In the case where fdisk must initialize a brand new MBR, then it should
> assume sensible defaults and allow you to override.

There are no sensible defaults.

There's the translation that the BIOS (and thus DOS, PartitionMagic,
yadda) uses, and then there's everything else, which is wrong.

It won't do you any good to fill in "sensible defaults", since if it
doesn't comply with what the BIOS decides (or you decide in the BIOS
setup as is the case on my Compaq), those old programs just won't
work.
And Linux doesn't care about CHS values anyway, so no point in filling
in hocus pocus "sensible" stuff on that account.


> Most of the time though, people will already have a drive formatted by
> windows which will have the correct geometry written in the MBR,
> so the linux tools will just use that.

Yes, well, but it WOULD be nice if Linux was able to partition the
disk in a compatible way.

It's a stupid feature that one HAS to first boot a Windows CD,
partition the harddrive and install Windows and then install Linux
afterwards.  Should be doable the other way around.

Moreover, the MBR values are not guaranteed to be correct if you want
to partition your disk in a way compatible with the BIOS in your
system.  The disk might have been moved from another PC (using another
translation), in which case the MBR values will be wrong.  Another
example is dd'ing an entire drive to a larger drive - the BIOS might
use different translation for the two drives, and the MBR values will
be incorrect.

Ok, quite theoretical perhaps, but the main idea is that if you want
to partition a disk to be compatible with DOS, Windows etc. on the PC
the disk is sitting in, you have to use BIOS, not MBR values.

(MBR values can be good for other things, for example preparing a disk
for a different system.)


> > Ok, the better approach might be to destroy HDIO_GETGEO entirely and
> > tell userspace apps to use /sys/firmware/edd/int13_dev instead.  It
> > provides for a cleaner implementation.
> >
> > But then again, that breaks compatibility with current tools.
>
> They are already broken since the HDIO_GETGEO isn't returning the values
> from the bios.

Ok.

> What is the status of edd?  Is that officially supported
> or is it depreciated?

Can't imagine why it would be deprecated.

> If it is ok to use, then it would probably be a
> good place for fdisk to get that info from, though it's going to have to
> figure out which int13_dev ( if any ) corresponds to the device you are
> partitioning.

Comparing the first and last sector should do.
If not, we can error out without mapping certain devices.
If that's a problem to any users, they can use a tool to write unique
sigs to the start ~2kB or end ~2kB of disks..

> Sensible defaults for well known devices like /dev/hda
> should cover most cases, but not all.

Nah, I don't think that's a good idea.
Figure out the right mappings or error out, don't guess.

> For instance, I recently
> configured a server's bios to disable the primary ide channel because
> that disk was bad and I needed to boot from the second mirrored drive,
> so /dev/hdb actually corresponded to bios device 80, not /dev/hda.

And there are far more weird and obscure cases than this.

> > A good way to get the ball rolling could be if we could all agree that
> > there are a number of tools that need the BIOS CHS numbers.  Then we
> > can decide where the universal logic that attempts to guess which
> > devices are which should go.  Then a proper implementation could be
> > discussed and conjured, and dmraid, <whatever>fdisk, perhaps LILO/GRUB
> > etc. could be made dependant on it.  And THEN the HDIO_GETGEO could be
> > ripped...
>
> Aye, well put.  So let's see here.  As far as I can see, the only tools
> that need this information are ones that can create MBRs, so that's
> fdisk, cfdisk, parted, and friends.  Everything else can/should just use
> the values listed in the MBR.
>
> Agree?

GRUB and LILO might want to see CHS values too, in case you're
preparing a boot loader on a PC without int13 LBA extensions.  Ok,
that's pretty far out, but could happen :-).  If nothing else, then
because the user accidentally chose CHS mode.

dmraid might want to see the CHS values, in case there's an ATARAID
adapter which might or might not be capping drives to their last GB,
and dmraid wants to know whether the capping feature is enabled.  Not
sure if this is a sensible way to gather that information, but it
might be the only one for some adapters (who knows).

Can't think of anything else on top of my head (not saying that there
isn't any :-)).
