Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131555AbRAVLUi>; Mon, 22 Jan 2001 06:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131698AbRAVLU2>; Mon, 22 Jan 2001 06:20:28 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:52770 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S131498AbRAVLUV>;
	Mon, 22 Jan 2001 06:20:21 -0500
Date: Mon, 22 Jan 2001 12:19:10 +0100 (CET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Neil Brown <neilb@cse.unsw.edu.au>, Otto Meier <gf435@gmx.net>,
        Hans Reiser <reiser@namesys.com>, <edward@namesys.com>,
        Ed Tomlinson <tomlins@cam.org>,
        Nils Rennebarth <nils@ipe.uni-stuttgart.de>,
        David Willmore <n0ymv@callsign.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] - filesystem corruption on soft RAID5 in 2.4.0+
In-Reply-To: <3A6B5125.6781E69D@colorfullife.com>
Message-Id: <Pine.LNX.4.30.0101221207040.19844-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Jan 2001, Manfred Spraul wrote:

> I've attached Holger's testcase (ext2, SMP, raid5)
> boot with "mem=64M" and run the attached script.
> The script creates and deletes 9 directories with 10.000 in each dir.
> Neil, could you run it? I don't have an raid 5 array - SMP+ext2 without
> raid5 is ok.
>
> Holger, what's your ext2 block size, and do you run with a degraded
> array?
>
No, I do not have a degraded array and the blocksize of ext2 is 4096. Here is
what /proc/mdstat looks like:

     afdbench@florix:~/testdir$ cat /proc/mdstat
     Personalities : [raid1] [raid5]
     read_ahead 1024 sectors
     md3 : active raid1 sdc1[1] sdb1[0]
           136448 blocks [2/2] [UU]

     md4 : active raid1 sde1[1] sdd1[0]
           136448 blocks [2/2] [UU]

     md0 : active raid1 sdf2[5] sde2[4] sdd2[3] sdc2[2] sdb2[1] sda2[0]
           24000 blocks [5/5] [UUUUU]

     md1 : active raid5 sdf3[5] sde3[4] sdd3[3] sdc3[2] sdb3[1] sda3[0]
           3148288 blocks level 5, 64k chunk, algorithm 0 [5/5] [UUUUU]

     md2 : active raid5 sdf4[5] sde4[4] sdd4[3] sdc4[2] sdb4[1] sda4[0]
           32033280 blocks level 5, 32k chunk, algorithm 0 [5/5] [UUUUU]

     unused devices: <none>

What I do have is a spare disk and I am running swap on raid1. However,
my machine at home, which experienes the same problems, does not have swap
on raid and is also not degraded.

I applied Neils patch to 2.4.1-pre9 and rerun the test, again with
filesystem corruption. I now pressed the reset button and had all parity
recalculated under 2.2.18 and rebooted again to 2.4.1-pre9 to rerun
the test. Now, I do not see anymore filesystem corruption in syslog,
however forcing a check with e2fsck produces the following:

   root@florix:~# !e2fsck
   e2fsck -f /dev/md2
   e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
   Pass 1: Checking inodes, blocks, and sizes
   Special (device/socket/fifo) inode 3630145 has non-zero size.  Fix<y>? yes

   Special (device/socket/fifo) inode 3630156 has non-zero size.  Fix<y>? yes

   Pass 2: Checking directory structure
   Pass 3: Checking directory connectivity
   Pass 4: Checking reference counts
   Pass 5: Checking group summary information

   /dev/md2: ***** FILE SYSTEM WAS MODIFIED *****
   /dev/md2: 20002/4006240 files (4.8% non-contiguous), 219556/8008320 blocks

Doing this three times, two of them reported the same inodes with non-zero
size. One test went without any problem (first time ever under 2.4.x).
Now, I am not sure if this still is a filessytem corruption and why
the corruptions where so bad, before the parity recalculation under
2.2.18. I do remember the first time I run 2.4.x with a much larger
testset, it corrupted my system so badly that I had to push the reset
button and parity was recalculated under 2.4.1-pre3.

I will now run my other testset, but this always takes 8 hours. When
this is done I report back.

Holger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
