Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLXPns>; Sun, 24 Dec 2000 10:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbQLXPnh>; Sun, 24 Dec 2000 10:43:37 -0500
Received: from ip165-74.fli-ykh.psinet.ne.jp ([210.129.165.74]:14532 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S129585AbQLXPnS>;
	Sun, 24 Dec 2000 10:43:18 -0500
Message-ID: <3A46125E.910E6CE6@yk.rim.or.jp>
Date: Mon, 25 Dec 2000 00:12:30 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Guest section DW <dwguest@win.tue.nl>
Subject: Re: IDE woes:linux and BIOS won't agree on C/H/S detection
In-Reply-To: <3A424B0F.39E71E4F@yk.rim.or.jp> <20001221222735.A15396@win.tue.nl> <3A436F2D.3F15E158@yk.rim.or.jp> <20001222163447.A16476@win.tue.nl>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW wrote:

> On Sat, Dec 23, 2000 at 12:11:41AM +0900, Ishikawa wrote:
>
> > I have to think more deeply then what the best measure would be.
>
> I suppose you can get all systems involved to agree on 255 heads
> if you select LBA in the BIOS.
>
> Andries

Hi,

I think I misunderstood one thing before all the tips came in.
I somehow assumed that the Win98 would use the
disk geometry that AMI BIOS reported during boot for the
hard disk.  I was wrong.
Win98 seems to have its own idea of picking up
convenient CHS just as linux might do.
(And incidentally, this CHS seems to agree between w98 and linux!)
Or AMI BIOS is lying to me during the boot and
pass a different info to the OS when inquired afterward as
suggested by someone.

Anyway, when the geometry mismatch was reported
in linux fdisk after trying to install win98 and
found that linux picked up CHS geometry different from
that of BIOS's, I thought this was the problem.

But as Andries pointed out Win98 seemed to use
the same geometry information as linux used before
I made it to use the BIOS geometry by means of
boot command line parameter.
This means two to one favor against BIOS's idea of CHS!
The two OSs used 255 heads geometry.

So what I did was this.
(In the end, I didn't have to remove SCSI disk to check if the
linux or BIOS gets confused with the SCSI disk geometry info.)

Firstly, from linux, I did the following in order to
try my another attempt to wipe out the partition information for sure.

    dd if=/dev/zero of=/dev/hda bs=16kb count=1

Please note the much larger bs than I originally used.
Also note the generic hda device rather than the
/dev/hdaZ (Z=1 or whatever).
I probably should have made count much bigger, but
I ran the command in this mannter. And it seemed to do the trick anyway.

[This obviously wiped out the partition information completely. Good.]

Then I rebooted the computer (reboot from linux).
During the boot, I entered the BIOS setup mode.
I manually set the BIOS geometry for the disk from AUTO to USER and set
2940/255/63, which was used by Linux and seemingly win98 too.

Next, I booted the PC using win98 installation floppy and found that it
reported
"no partition exists" warning!
Good. Wiping out of  the  partition info confirmed.
(As a matter of fact, previously when I experimented with dd, etc., the
partition information somehow persisted. At this stage in my previous
attempt, I could run Win98 format command and it simplay answered
all the data on c drive would
disappear, and I was forced to wonder WHERE format picked up
the idea of the C driver partition. Obviously, my dd command was
not clearing large enough area or I was mistyping the command
parameter(?))

As a next step, although I was advised to stay away from disk
manager tools, which I  believe is a good advice in general,
I used Seagate Disk Manager DM.exe for partition/formating
purpose ONLY (I think).
If you compare the speed of formating of this tool agains MS's, this
tool
wins hands down. It is BLAZINGLY fast. (Actually I found that Western
Digital's similar tool also runs very fast. Maybe the same origin.)

Anyway, using DM.exe, I ended up again with 10 FAT16 partitions on the
disk,
one of which is the primary partition, and the rest are logical partions
in the
extended partition.

Now it is time to learn whether both the win98 (or more to the point
the DM.exe) , and linux used the same geometry now recorded in the
BIOS explicitly.

So I rebooted Linux using loadlin  floppy WITHOUT specifiying
hda=ccc,hhh.sss. : previously I had hda=39694/16/63, which was
the natural CHS picked up on AWARD BIOS motherboards for
this disk somehow. (Without hda parameter, it used the 2940/255/63
after I began playing with old Debian GNU/Linux CD as explained
in my previous post.).

After booting linux, I checked the print out of the fdisk: the following
is
the output.
As you can see below, no boundary mismatch information reported
anymore. Perfect.
---------------------------------------------
Command (m for help): p

Disk /dev/hda: 255 heads, 63 sectors, 2490 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       249   2000061    6  FAT16
/dev/hda2           250      2490  18000832+   f  Win95 Ext'd (LBA)
/dev/hda5           250       498   2000061    6  FAT16
/dev/hda6           499       747   2000061    6  FAT16
/dev/hda7           748       996   2000061    6  FAT16
/dev/hda8           997      1245   2000061    6  FAT16
/dev/hda9          1246      1494   2000061    6  FAT16
/dev/hda10         1495      1743   2000061    6  FAT16
/dev/hda11         1744      1992   2000061    6  FAT16
/dev/hda12         1993      2241   2000061    6  FAT16
/dev/hda13         2242      2490   2000061    6  FAT16
------------------------------------------------

So I think in my case the command with a large bs worked:

dd if=/dev/zero of=/dev/hda bs=16kb count=1

Under this partitioning scheme, I re-installed win98 in the
/dev/hda1 partition above, and as far as I can see,
win98 boots just fine.
My 2.4.0-test12 image resides in a separate scsi disk and
I can boot it using loadlin and the boot image that reside in
the /dev/hda1 partition: I enter win98 commad only mode and
run loadlin from there. I am thinking of installing 2.2.18 on one of the

logical partitions now.

I would like to thank people including Andries and
those who sent me tips via e-mailed, too.

PS: Given that there was off-by-one error in the BIOS
calculation of CHS, I wonder if the AMI BIOS is returning
the appropriate info to the inquirying OS (linux or win98).
I don't understand why linux and win98 use different CHS inforamtion
than the one BIOS used (when AUTO detection is turned on).
As far as linux was concerned, the BIOS and linux geometry matched
on AWARD BIOS motherboards.
On the other hand,  there seems to be
enough freedom in picking up the mapping (for LBA, etc..) in the
handling of large disks and that AWARD BIOS seems to use
an algorithm that is friendly or idential to the geometry alogrithm
used by linux and win98. So AMI BIOS may not be to blame after
all.

Very puzzling situation until things settled down somehow.

Thank you again.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
