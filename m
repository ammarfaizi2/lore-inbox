Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135277AbRDWPDV>; Mon, 23 Apr 2001 11:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135283AbRDWPDL>; Mon, 23 Apr 2001 11:03:11 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:5903 "HELO
	zmamail03.zma.compaq.com") by vger.kernel.org with SMTP
	id <S135277AbRDWPDD>; Mon, 23 Apr 2001 11:03:03 -0400
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD110441B@cceexc19.americas.cpqcorp.net>
From: "Dupuis, Don" <Don.Dupuis@COMPAQ.com>
To: "'phiviv@hacklab.net'" <phiviv@hacklab.net>, linux-kernel@vger.kernel.org
Cc: sebastien.godard@wanadoo.fr, timb@claire.org, axboe@suse.de
Subject: RE: Device Major max and Disk Max in 2.4.x kernel
Date: Mon, 23 Apr 2001 10:02:35 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have already sent a patch to Alan and Linus on this issue.  Linus has
never responed and Alan said he would look into it in the middle of April.
Nothing is new at this point

-----Original Message-----
From: PhiloVivero [mailto:pvspam-dntrepl@hacklab.net]
Sent: Sunday, April 22, 2001 12:12 AM
To: linux-kernel@vger.kernel.org
Cc: sebastien.godard@wanadoo.fr; timb@claire.org; axboe@suse.de;
phiviv@hacklab.net
Subject: Device Major max and Disk Max in 2.4.x kernel


I have a problem. Trying to write an iostat for Linux (or use an existing
one):

>From the kernel source:

[/usr/src/linux-2.4.2/include/linux] :) grep DK_MAX *.h
kernel_stat.h:#define DK_MAX_MAJOR 16
kernel_stat.h:#define DK_MAX_DISK 16

What to notice: MAJOR and DISK max are 16.

Again, from the kernel source:

[/usr/src/linux-2.4.2/fs/proc] :) grep -15 DK_MAX proc_misc.c
<snip>
    for (major = 0; major < DK_MAX_MAJOR; major++) {
            for (disk = 0; disk < DK_MAX_DISK; disk++) {
                    int active = kstat.dk_drive[major][disk] +
                            kstat.dk_drive_rblk[major][disk] +
                            kstat.dk_drive_wblk[major][disk];
                    if (active)
                            len += sprintf(page + len,
                                    "(%u,%u):(%u,%u,%u,%u,%u) ",
                                    major, disk,
                                    kstat.dk_drive[major][disk],
                                    kstat.dk_drive_rio[major][disk],
                                    kstat.dk_drive_rblk[major][disk],
                                    kstat.dk_drive_wio[major][disk],
                                    kstat.dk_drive_wblk[major][disk]
                    );
            }
    }

What to notice: We are looping up to the DK_MAX_MAJOR and DK_MAX_DISK. What
this means is, any major >16 or disk >16 won't be listed in /proc/stat under
the "disk_io" section.

Problem. On my system, which I figure is not too uncommon, I have several
partitions on two hard drives and a CDROM. They are configured thusly:

# cat /proc/partitions
major minor  #blocks  name
   3     0   20094480 hda
   3     1    6313513 hda1
   3     2     401625 hda2
   3     3   13374112 hda3
   3    64    4497152 hdb
  56     0   45034920 hdi
  56     1   22490968 hdi1
  56     2   22539195 hdi2

What to notice: I have a drive on /dev/hdi (never mind why, it actually
works)
that is block major 56. Not only that, my cdrom device on /dev/hdb is block
major 3, but minor number 64. I am assuming for disks, minor == disk. Sorry
if
this is an incorrect assumption.

No stats for /dev/hdi nor /dev/hdb ever show up in /proc/stat. Only for
/dev/hda. On my other 2.4.2 system, with multiple hard drives under 16/16,
I get multiple devices under /proc/stat.

The patch seems relatively easy. Change linux/include/linux/kernel_stat.h to
allow block major up to 56 (in my case... 64 in general???) and disks up to
64
(in my case).

But we might need more than 64 disks on a block major (there are MANY snips
in
this so-called cut 'n' paste, because I figure you don't want to see them
all):

# l /dev/hd* | sort -n
brw-rw----    1 root     disk       3,  79 Feb 22 08:57 /dev/hdb15
brw-rw----    1 root     disk       3,  80 Feb 22 08:57 /dev/hdb16
brw-rw----    1 root     disk      22,  79 Feb 22 08:57 /dev/hdd15
brw-rw----    1 root     disk      22,  80 Feb 22 08:57 /dev/hdd16
brw-rw----    1 root     disk      33,  79 Feb 22 08:57 /dev/hdf15
brw-rw----    1 root     disk      33,  80 Feb 22 08:57 /dev/hdf16
brw-rw----    1 root     disk      34,  79 Feb 22 08:57 /dev/hdh15
brw-rw----    1 root     disk      34,  80 Feb 22 08:57 /dev/hdh16
brw-rw----    1 root     disk      56, 126 Mar 25 17:14 /dev/hdj62
brw-rw----    1 root     disk      56, 127 Mar 25 17:14 /dev/hdj63

What to notice: We have disks up to 127. I never see any block major over 64
on my system. The /dev/hdj device isn't used on my system. /dev/hdi and
/dev/hdj belong to a Promise RAID controller on a new-ish
ASUS AMD motherboard.

Let me know if I can be of further service. I must bashfully admit that I'm
not enough of a guru to recompile my kernel anymore, or I'd tweak the
kernel_stat.h file and recompile myself to test this.

This is just hazy recollection, but I think the 2.2.x kernels have the same
problem.

--
PhiloVivero
ps -- I'm not subscribed to this list, so if you want me to see replies...
please send to email!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
