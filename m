Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129527AbRBREs2>; Sat, 17 Feb 2001 23:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbRBREsR>; Sat, 17 Feb 2001 23:48:17 -0500
Received: from [64.160.188.242] ([64.160.188.242]:11527 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129527AbRBREsB>; Sat, 17 Feb 2001 23:48:01 -0500
Date: Sat, 17 Feb 2001 20:47:59 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Asus CUV4X-D mobo
In-Reply-To: <Pine.LNX.4.10.10102171709561.27328-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0102172007360.8461-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Mark Hahn wrote:

> the 0-4 drives attached to the primary controller are fundamentally
> different in behavior than any other controller's drives.
>

Wait, when I first started in computers I found that by using the CHS
count on the drive made the drives work correctly due to the fact that
those day BIOSes didn't understand how to do LBA or any enhianced modes.
You HAD to specify the CHS count. Then, hard drives and mobo BIOSes
improved to the point that the motherboards would check a chip on the
drive telling it what the geometry was for that drive. this allowed the
BIOS to configure the system. All *I*'ve been doing is simply stating the
straight CHS counts manually in the BIOS. I've also played with toggling
the LBA mode on and off.

The problem is that the 686B controller reads the chip as reading
1024x16x63+LBA to equal 30GB for the drive. This is clearly not the right
count. So, I booted to a rescue disk and ran hdparm against the drive to
see what the drive itself is saying the setting is.

This is my first clue that the mobo is not reading the drive correctly, since the drive shows
RawCHS as being 16383x16x63+LBA. (RawCHS being the field in hdparm's
output I understand to be what the drive is truly reporting)  So, I then
ran fdisk to see what IT was seeing for the cylinder count which I believe it
gets by taking the reported CHS, does the LBA magic itself then displays what
it came up with for it's translation. fdisk reported 58168x16x63.
Obviously 2 of the translations are incorrect. 16383x16x63 is obviously
not the right one. Booting with that geometry fails to find the
partition.

That leaves 1024x16x63 which just doesn't add up to the max of the
drive. Looking on the drive you see a sector count that matches what fdisk
reads the drive to be. No CHS count just the total sector count of the
drive and LBA. (Most hard drives usually have the CHS written
on them so it's easy to throw them back in. This drive doesn't have a CHS count
on it. That's what made this difficult.)

Now the controller can see the drive correctly and all partitions are
accessible. BUT ONLY if i boot from a CD. Not because of the kernel, but
because no matter what, LILO will NOT load correctly to reboot back into linux.
I consistently get LI (stage 2 loader) problems. Now, dig this, switch
these drives just as they are to the Promise controller (which reads the
drives the same way as fdisk does AND the LI problems completely
disappear.

Now, you COULD make the argument that since my motherboard has the option
to match translations to the partition table that THAT should have worked
and allowed access to the drive. (It's a feature of this particular
board and is an actual menu options.) This of course is NOT the case.
Setting it this way did not fix the problem. At this point, I've manually
stated the drive is 58383x16x63 in the BIOS, toggled LBA both on and off,
told it to match the translation to that reported by the partition table,
and nothing got it to boot from LILO.

I decided to wipe the drive leaving NO partitions and see what happened
when I torched the drives.

So i cold booted with no partition table on the drive, ran fdisk /MBR
from windows against the MBR to make sure LILO was compeltely gone,
rebooted the system with the drives unplugged from the mobo and the bios
set to NONE for drives.

Then I reattached the drives, booted up, manualy specied the CHS+LBA only,
saved bios, rebooted, and ran through a Linux install. (Completely
different distrib as well.) Once again I got the LI errors again. It would
always blow right at the point that it looks at the drive for the raw
starting sector for the kernel. (2nd stage loader)

Now, enter back in the Promise PDC20267 controller. I went back into the
BIOS, disabled the onboard controllers, rebooted again and ran the install
from the Promise. I ran all the way through the entire steps again with
the Promise. First I tried it leaving the partiton table just the way it
was on the other controller, rebooted back from the install CD to the
drive and reran LILO just as it was on the drive. Rebooted the system and
this time around I get a working LILO prompt.

I decided to do the 2nd half of the test by removing the partitions,
rebooting, removing the drives from the controller, rebooting so it
doesn't have a memory of the drives, re-attaching the drives,
repartitioning the now-blank drives and reinstalling linux. Again LILO
works flawlessly the first time.

To me, this says the mobo's controller or it's chipset are bad. Since I've
had numerous problems with the VIA chipset in the past, even from years
ago, I'm more willing to believe that the 686B is a screwy chip.


BTW, marking a drive and cables is nothing more than marking them 1/2 for
primary master/slave and 3/4 for 2ndary master/slave. I also record the
geometry of the drive somwhere on the side or a peice of paper within the
machine itself so I don't have to mess with yankin drives and such. I
couldn't record the geometry for these drives as they're not marked with
it. I had to basically deduce what the setup is. As I said, this is the
first time I've seen a drive NOT be marked.

David
-- 
David D.W. Downey - RHCE
Consulting Engineer
Ensim Corporation - Sunnyvale, CA

