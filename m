Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWBUQDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWBUQDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWBUQDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:03:19 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:61854 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932262AbWBUQDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:03:18 -0500
Message-ID: <43FB397C.1070509@cfl.rr.com>
Date: Tue, 21 Feb 2006 11:02:04 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: device-mapper development <dm-devel@redhat.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Support HDIO_GETGEO on device-mapper volumes
References: <43EBEDD0.60608@us.ibm.com>  <20060210145348.GA12173@agk.surrey.redhat.com>  <43ECAD5B.9070308@cfl.rr.com>  <62b0912f0602101227q719e712bq40da5b2f0c5422c5@mail.gmail.com>  <43ED03F1.4010308@cfl.rr.com>  <62b0912f0602201009o3e3338d4lf7bdcdf1af172dda@mail.g <62b0912f0602210530i5e820ccci3f4068c9f1b66a7d@mail.gmail.com>
In-Reply-To: <62b0912f0602210530i5e820ccci3f4068c9f1b66a7d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2006 16:04:34.0822 (UTC) FILETIME=[820F8260:01C63700]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14281.000
X-TM-AS-Result: No--43.500000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> Ok.  Got an archive link or other references?
> 

Unfortunately, no.

>> IIRC, grub just uses the geometry it finds in the MBR, or you can
>> override with the geometry command.
> 
> Last I checked, grub used HDIO_GETGEO when running under Linux.
> 
> Which makes it pretty useless if what you say above is true.  Except
> of course in the particular cases where the bogus values that the
> Linux kernel makes up happens to be correct.
> 

Exactly.  Oddly enough though, most of the time these days the bogus 
values do match the bios values.  If grub is using HDIO_GETGEO then yea, 
it should just use the geometry in the MBR instead.  That probably 
explains why I had to issue the geometry command explicitly when 
installing grub on my hardware fakeraid.  I guess grub assumed some odd 
defaults when HDIO_GETGEO failed.  I should investigate that further.

> Horribly unsafe way for a boot loader to function, if you ask me.
> (Not really grub's fault, more the Linux kernel it seems.)
> 

It is unsafe, but it is also partly grub's fault since it shouldn't be 
calling HDIO_GETGEO in the first place.  It should assume that the 
values stored in the MBR already are correct, since if they weren't, the 
system wouldn't boot anyhow, and use those rather than ask the kernel.

> 
>> In the case where fdisk must initialize a brand new MBR, then it should
>> assume sensible defaults and allow you to override.
> 
> There are no sensible defaults.
> 

Sure there are: 255 heads and 63 sectors.  Most bioses will map most 
modern hard disks ( > 8 GB ) to this geometry.  Fdisk seems to use this 
default, and most of the time, it is correct.

> There's the translation that the BIOS (and thus DOS, PartitionMagic,
> yadda) uses, and then there's everything else, which is wrong.
> 
> It won't do you any good to fill in "sensible defaults", since if it
> doesn't comply with what the BIOS decides (or you decide in the BIOS
> setup as is the case on my Compaq), those old programs just won't
> work.
> And Linux doesn't care about CHS values anyway, so no point in filling
> in hocus pocus "sensible" stuff on that account.
> 

You have to use SOMETHING and since most of the time it will be 255/63, 
the tools may as well default to that, possibly with a warning informing 
the user that they may need to change that to be able to dual boot with 
windows.

> 
>> Most of the time though, people will already have a drive formatted by
>> windows which will have the correct geometry written in the MBR,
>> so the linux tools will just use that.
> 
> Yes, well, but it WOULD be nice if Linux was able to partition the
> disk in a compatible way.
> 
> It's a stupid feature that one HAS to first boot a Windows CD,
> partition the harddrive and install Windows and then install Linux
> afterwards.  Should be doable the other way around.
> 

You can do it the other way around, you just have to make sure that 
linux's fdisk guesses the correct geometry, which it will most of the 
time.

> Moreover, the MBR values are not guaranteed to be correct if you want
> to partition your disk in a way compatible with the BIOS in your
> system.  The disk might have been moved from another PC (using another
> translation), in which case the MBR values will be wrong.  Another
> example is dd'ing an entire drive to a larger drive - the BIOS might
> use different translation for the two drives, and the MBR values will
> be incorrect.
> 

Correct, which is why fdisk needs to allow you to override the geometry, 
but most of the time users won't run into this so it is sensible to 
assume sensible defaults.

> Ok, quite theoretical perhaps, but the main idea is that if you want
> to partition a disk to be compatible with DOS, Windows etc. on the PC
> the disk is sitting in, you have to use BIOS, not MBR values.
> 
> (MBR values can be good for other things, for example preparing a disk
> for a different system.)
> 
> 
>> They are already broken since the HDIO_GETGEO isn't returning the values
>> from the bios.
> 
> Ok.
> 
>> What is the status of edd?  Is that officially supported
>> or is it depreciated?
> 
> Can't imagine why it would be deprecated.
> 
>> If it is ok to use, then it would probably be a
>> good place for fdisk to get that info from, though it's going to have to
>> figure out which int13_dev ( if any ) corresponds to the device you are
>> partitioning.
> 
> Comparing the first and last sector should do.
> If not, we can error out without mapping certain devices.
> If that's a problem to any users, they can use a tool to write unique
> sigs to the start ~2kB or end ~2kB of disks..
> 

Good idea.  It is a bit kludgey, but it should work well enough.  It 
also requires being able to call int 13 to read the first and last sector.

>> Sensible defaults for well known devices like /dev/hda
>> should cover most cases, but not all.
> 
> Nah, I don't think that's a good idea.
> Figure out the right mappings or error out, don't guess.
> 
>> For instance, I recently
>> configured a server's bios to disable the primary ide channel because
>> that disk was bad and I needed to boot from the second mirrored drive,
>> so /dev/hdb actually corresponded to bios device 80, not /dev/hda.
> 
> And there are far more weird and obscure cases than this.
> 
> 
> GRUB and LILO might want to see CHS values too, in case you're
> preparing a boot loader on a PC without int13 LBA extensions.  Ok,
> that's pretty far out, but could happen :-).  If nothing else, then
> because the user accidentally chose CHS mode.
> 

They should be getting the geometry from the MBR anyhow since if they do 
choose a value different from those used to create the partition table, 
it will screw the pooch.

> dmraid might want to see the CHS values, in case there's an ATARAID
> adapter which might or might not be capping drives to their last GB,
> and dmraid wants to know whether the capping feature is enabled.  Not
> sure if this is a sensible way to gather that information, but it
> might be the only one for some adapters (who knows).
> 

I don't follow.  dmraid doesn't know or care about ATARAID adapters that 
may or may not be hiding the tail end of the disk, that is taken care of 
by the driver, which just disables the hiding.  dmraid just looks at the 
tail of the disks for the bios configuration block and sets up device 
mapper to access the disks.

> Can't think of anything else on top of my head (not saying that there
> isn't any :-)).

