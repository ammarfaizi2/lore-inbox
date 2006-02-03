Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWBCA6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWBCA6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWBCA6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:58:03 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:60046 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751212AbWBCA6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:58:02 -0500
Date: Fri, 3 Feb 2006 01:57:52 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Bill Davidsen <davidsen@tmr.com>
cc: Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <43E26CB6.7030808@tmr.com>
Message-ID: <Pine.LNX.4.60.0602030037520.18478@kepler.fjfi.cvut.cz>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org>
 <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz> <43E26CB6.7030808@tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="546507526-4245689-1138924497=:18478"
Content-ID: <Pine.LNX.4.60.0602030055230.18478@kepler.fjfi.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--546507526-4245689-1138924497=:18478
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.60.0602030055231.18478@kepler.fjfi.cvut.cz>

On Thu, 2 Feb 2006, Bill Davidsen wrote:

Just to state clearly in the first place. I've allready solved the problem=
=20
by low-level formatting the entire disk that this inconsistent array in=20
question was part of.

So now everything is back to normal. So unforunatelly I would not be able=
=20
to do any more tests on the device in the non-working state.

I mentioned this problem here now just to let you konw that there is such=
=20
a problematic Linux behviour (and IMO flawed) in such circumstances, and=20
that perhaps it may let you think of such situations when doing further=20
improvements and development in the design of the block device layer (or=20
wherever the problem may possibly come from).

And I also hope you would understand, that I wouldn't try to create that=20
state again deliberatelly, since my main system is running on that array=20
and I wouldn't risk loosing some more data because of this.

However maybe someone perhaps in Adaptec or smewhere else may have=20
some simillar system at the disposal on which he could allow to experiment=
=20
on demand without any serious risk of loosing anything important.

So what I may say is that it is an Adaptec 2410SA with 8205 firmware and=20
without a battery backup system (which is probably the crutial thing).=20
And the inconsistency was caused by a MB protection of CPU overheat=20
shutdown, because I've started the system and booted Linux from the array=
=20
in question (which consisted by just one part of one disk), while I've=20
forgotten to turn on the water cooling of the CPU and northbridge. So=20
after about 3 minutes the system automatically shut down and Linux was=20
probably doing some writing in that very moment, which wasn't able to=20
complete fully (most probably due to the lack of the battery backup system=
=20
on the RAID controller). So my guess is that this may be artificially=20
reproduced when you suddenly switch off a power source of the system while=
=20
Linux is doing some writing to the array.

My arrays in particular are:

=09HDD1 (160 GB): 120 GB Array 1, 40 GB Array 2
=09HDD2 (120 GB): 120 GB Array 1
=09HDD3 (120 GB): 120 GB Array 1
=09HDD4 (120 GB): 120 GB Array 1

Where Array 1 is a RAID 5 array /dev/sdb (labeled as "Data 1"), which=20
contains just one 330 GB partition /dev/sdb1, and Array 2 is a bootable=20
(in Adaptec BIOS setup so called) Volume array (i.e. no RAID) /dev/sda=20
(labeled as "SYSTEM"), which contains /dev/sda1 (NTFS Windows), /dev/sda2=
=20
(ext3 Linux), /dev/sda3 (Linux swap). Problem was accessing the whole Array=
 2.=20
Array 1 from Linux worked well.

Then, when I tried, the array checking function within the BIOS of the=20
Adaptec controller found an inconsistency on the position somewhere in the=
=20
middle of the /dev/sda, so somewhere within the /dev/sda2 in particular.=20
So I low-level formatted the entire HDD1, resynced the Array 1 (which is=20
RAID 5, so no problem) and reinstalled both systems in Array 2, and now it=
=20
is all back to normal again.

> Martin Drab wrote:
>=20
> > Well, I had a similar experience lately with the Adaptec AAC-2410SA RAI=
D 5
> > array. Due to the CPU overheating the whole box was suddenly shot down =
by
> > the CPU damage protection mechanism. While there is no battery backup o=
n
> > this particular RAID controller, the sudden poweroff caused some very
> > localized inconsistency of one disk in the RAID. The configuration was =
1x160
> > GB and 3x120GB, with the 160 GB being split into 120 GB part within the=
 RAID
> > 5 and a 40 GB part as a separate volume. The inconsistency happend in t=
he 40
> > GB part of the 160 GB HDD (as reported by the Adaptec BIOS media check)=
=2E In
> > particular the problem was in the /dev/sda2 (with /dev/sda being the 40=
 GB
> > Volume, /dev/sda1 being an NTFS Windows system, and /dev/sda2 being ext=
3
> > Linux system).
> >=20
> > Now, what is interesting, is that Linux completely refused any possible
> > access to every byte within /dev/sda, not even dd(1) reading from any
> > position within /dev/sda, not even "fdisk /dev/sda", nothing. Everythin=
g
                                        ^^^^^^^^^^^^^^
> > ended up with lots of following messages:
> >=20
> >         sd 0:0:0:0: SCSI error: return code =3D 0x8000002
> >         sda: Current: sense key: Hardware Error
> >             Additional sense: Internal target failure
> >         Info fld=3D0x0
> >         end_request: I/O error, dev sda, sector <some sector number>
>=20
> But /dev/sda is not a Linux filesystem, running fsck on it makes no sense=
=2E You
> wanted to run on /dev/sda2.

But I was talking about fdisk(1). This wasn't a problematic behaviour of a=
=20
filesystem, but of the entire block device.

> > I've consulted this with Mark Salyzyn, because I thought it was a probl=
em of
> > the AACRAID driver. But I was told, that there is nothing that AACRAID =
can
> > possibly do about it, and that it is a problem of the upper Linux layer=
s
> > (block device layer?) that are strictly fault intollerant, and thouth t=
he
> > problem was just an inconsistency of one particular localized region in=
side
> > /dev/sda2, Linux was COMPLETELY UNABLE (!!!!!) to read a single byte fr=
om
> > the ENTIRE VOLUME (/dev/sda)!
>=20
> The obvious test of this "it's not us" statement is to connect that one d=
rive
> to another type controller and see if the upper level code recovers. I'm
> assuming that "sda" is a real drive and not some pseudo-drive which exist=
s
> only in the firmware of the RAID controller.

/dev/sda is a 40 GB RAID array consisting of just one 40 GB part of one=20
160 GB drive. But it is in fact a virtual device supplied by the=20
controller. I.e. this 40 GB part of that disc behaves as an entire=20
harddisk (with it's own MBR etc.). And it is at the end of the drive, so=20
it may be a little tricky to find the exact position of the partitions=20
there, but it may be possible.

> That message is curious, did you
> cat /proc/scsi/scsi to see what the system thought was there? Use the inf=
amous
> "cdrecord -scanbus" command?

----------
$ cdrecord -scanbus
Cdrecord-Clone 2.01.01a03-dvd (i686-pc-linux-gnu) Copyright (C) 1995-2005 J=
=EF=BF=BDg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to warly at mandriva.com.
Note: The author of cdrecord should not be bothered with problems in this=
=20
version.
Linux sg driver version: 3.5.33
Using libscg version 'schily-0.8'.
scsibus0:
        0,0,0     0) 'Adaptec ' 'SYSTEM          ' 'V1.0' Disk
        0,1,0     1) 'Adaptec ' 'Data 1          ' 'V1.0' Disk
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Adaptec  Model: SYSTEM           Rev: V1.0
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: Adaptec  Model: Data 1           Rev: V1.0
  Type:   Direct-Access                    ANSI SCSI revision: 02
-----------

The 0,0,0 is the /dev/sda. And even though this is now, after low-level=20
formatting of the previously inconsistent disc, the indications back then=
=20
were just the same. Which means every indication behaved as usual. Both=20
arrays were properly identified. But when I was accessing the inconsistent=
=20
one, i.e. /dev/sda, in any way (even just bytes, this has nothing to do=20
with any filesystems) the error messages mentioned above appeared. I'm not=
=20
sure what exactly was generating them, but I've CC'd Mark Salyzyn, maybe=20
he can explain more to it.

> > And now for the best part: From Windows, I was able to access the ENTIR=
E
> > VOLUME without the slightest problem. Not only did Windows boot entirel=
y
> > from the /dev/sda1, but using Total Commander's ext3 plugin I was also =
able
> > to access the ENTIRE /dev/sda2 and at least extract the most important =
data
> > and configurations, before I did the complete low-level formatting of t=
he
> > drive, which fixed the inconsistency problem.
> >=20
> > I call this "AN IRONY" to be forced to use Windows to extract informati=
on
> > from Linux partition, wouldn't you? ;)
> >=20
> > (Besides, even GRUB (using BIOS) accessed the /dev/sda without complica=
tions
> > - as it was the bootable volume. Only Linux failed here a 100%. :()
>=20
> From the way you say sda when you presumably mean sda1 or sda2 it's not c=
lear
> if you don't understand the difference between drive and partition access=
 or
> are just so pissed off you are not taking the time to state the distincti=
on
> clearly.

No, I understand the differences very clearly. But maybe I was just=20
unclear in my expressions (for which I appologize). What I mean is that=20
the problem was with the entire RAID array /dev/sda. So whenever ANY=20
access to ANY part of /dev/sda, which of course also includes accesses to=
=20
all of /dev/sda1, /dev/sda2, and /dev/sda3, the error messages appeared=20
and no access was performed. That includes even accesses like this
"dd if=3D/dev/sda of=3D/dev/null bs=3D512 count=3D1" and any other possible=
=20
accesses. So the problem was with the entire device /dev/sda.

> There was a problem with recovery from errors in RAID-5 which is addresse=
d by
> recent changes to fail a sector, try rewriting it, etc.

Maybe this was again my bad explanation, but this wasn't a problem of a=20
RAID 5 array, and much less of a software array. Adaptec 2410SA is a=20
4-channel HW SATA-I RAID controller.

> I would have to read linux-raid archives to explain it, so I'll stop=20
> with the overview. I don't think that's the issue here, you're using a=20
> RAID controller rather than the software RAID, so it should not apply.

Yes, exactly. And again, I've solved it by lowlevel formatting.

> I assume that the problem is gone, so we can't do any more analysis after=
 the
> fact.

Unfortunatelly, yes. But I've described above how did it happen, so maybe=
=20
someone in Adaptec would be able to reproduce, Mark?

Martin
--546507526-4245689-1138924497=:18478--
