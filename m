Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319469AbSH3HDO>; Fri, 30 Aug 2002 03:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319456AbSH3HDO>; Fri, 30 Aug 2002 03:03:14 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:50193 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S319493AbSH3HDM>; Fri, 30 Aug 2002 03:03:12 -0400
Date: Fri, 30 Aug 2002 02:07:36 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <1030649283.7290.168.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208300206140.9431-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I have some good news and some bad news.

The bad news is that I replicated the corruption.

The good news is that I replicated the corruption.  Oh, and I can
cause it on demand, and not lose my system in the process.  I can
provide LOTS and LOTS of details now.  What do you want to know?

Some additional background:  The 160GB Maxtor has a number of file
systems on it.  Here's the fdisk -l output:

Disk /dev/hde: 255 heads, 63 sectors, 19929 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hde1   *         1       912   7325608+   c  Win95 FAT32 (LBA)
/dev/hde2           913     19929 152754052+   5  Extended
/dev/hde5           913       936    192748+  83  Linux
/dev/hde6           937       985    393561   83  Linux
/dev/hde7           986      1058    586341   82  Linux swap
/dev/hde8          1059      1423   2931831   83  Linux
/dev/hde9          1424     19929 148649413+  83  Linux

The file system that started all the fireworks was the big one at the
end, hde9.  The rescue partition that booted up corrupted
afterwards was hde6.  The toasted root partition was hde8.


Here's what I did:

1. I pulled a spare hard drive (80GB Maxtor) and installed it in the
   system as hda (primary controller, primary channel, master).

2. I put a Debian installation there.  Updated the kernel to
   2.4.19-ac4.

3. With a stable system on the spare drive, I moved the 160GB Maxtor
   to be hdc (primary controller, secondary channel, master).

4. Using an alternate superblock I managed to fsck the fsck'ed up file
   systems on the 160GB drive while running as hdc, while booted under
   2.4.19-ac4.

5. I then ran additional fsck passes on the 160GB drive, checking all
   partitions.  Just for paranoia's sake.  All now passed clean.

6. I shut down the system, moved the 160GB drive to be hde (Promise
   controller, primary channel, master), and rebooted.

7. I ran the fsck passes again on the drive.  Note: This is still
   under 2.4.19-ac4, but using the Promise controller.  All passed,
   squeaky clean.  So under 2.4.19-ac4 there's no problem.

8. I rebooted the system to 2.4.20-pre4-ac1 and fsck'ed the big
   partition again.  Splat.  Some time after 50% done it reported an
   error.

Unlike the initial carnage, I wasn't an idiot and didn't use the -y
fsck option this time, so it stopped after the first error and since
I'm not writing to the drive, the contents hopefully should still be
OK.  I've already rebooted again and repeated the last step.  I should
be able to repeat this experiment as often as needed.

Clearly there's something wrong in 2.4.20-pre4-ac1 that wasn't wrong
in 2.4.19-ac4 that is impacting my setup.

Some additional datapoints:

  1. During bootup of 2.4.20-pre4-ac1, I found the following message
     in the kernel log, not previously seen:

     > hde: Maxtor 4G160J8, ATA DISK drive
     > ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
     >          Switching to Ultra33 mode.
     > Warning: Primary channel requires an 80-pin cable for operation.
     > hde reduced to Ultra33 mode.

     What makes this notable is that there is indeed an 80 pin cable
     connecting the 160GB drive to that controller.  I hadn't noticed
     this message in 2.4.19-ac4, but honestly I didn't directly look
     for it yet.  I'll check that.

  2. I did something else that night that may have been less than
     smart.  I remembered it tonight and repeated the experiment.  I
     tried to read-only mount hde9 while the fsck was running.  When
     this happens, the fsck process gets a short read and complains.
     Obviously that's going to mess up fsck.  However that little
     shenanigan is not needed to screw things up.  Tonight I ran step
     8 (above) twice.  The first time was after restarting fsck, after
     fsck had failed on account of my trying to ro-mount the file
     system.  The second time - after rebooting - I still got the fsck
     failure some time after 50% completion, without having to try to
     mount anything.

I've got a system here that I can foul-up on demand now.  What would
you like me to do?

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

