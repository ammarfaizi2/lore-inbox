Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRLHOr0>; Sat, 8 Dec 2001 09:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280836AbRLHOrS>; Sat, 8 Dec 2001 09:47:18 -0500
Received: from f272.law11.hotmail.com ([64.4.16.147]:45576 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S280938AbRLHOrG>;
	Sat, 8 Dec 2001 09:47:06 -0500
X-Originating-IP: [212.205.234.219]
From: "PANTELIS PROIOS" <pproios@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [problem] a bit OT: kernel 2.4.13 complains about E2FS utils trying to write pas
Date: Sat, 08 Dec 2001 16:47:00 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F272dZjfNLnlyg35sQt0001e2e1@hotmail.com>
X-OriginalArrivalTime: 08 Dec 2001 14:47:00.0928 (UTC) FILETIME=[319FA400:01C17FF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry if it might be a bit OT, but I need immediate help...

I am having some problems with e2fs utils v1.25 and kernel 2.4.13 (any 
kernel?) and was wondering if you could help clear some things out for me.

What i wanted to do:
1) format an empty ext2 partiton (first doing badblocks on it)
2) re-install some software on it

I couldn't do it "properly" and here's why:

I start with a dump of my partition table:
##########################################################################
FDISK
##########################################################################

:#  fdisk -l /dev/hdc
Disk /dev/hdc: 255 heads, 63 sectors, 789 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1   *         1       399   3204936    b  Win95 FAT32
/dev/hdc2           400       529   1044225    e  Win95 FAT16 (LBA)
/dev/hdc3           530       659   1044225   83  Linux native
/dev/hdc4           660       789   1044225   83  Linux native

#  fdisk -l -u /dev/hdc
Disk /dev/hdc: 255 heads, 63 sectors, 789 cylinders
Units = sectors of 1 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1   *        63   6409934   3204936    b  Win95 FAT32
/dev/hdc2       6409935   8498384   1044225    e  Win95 FAT16 (LBA)
/dev/hdc3       8498385  10586834   1044225   83  Linux native
/dev/hdc4      10586835  12675284   1044225   83  Linux native


Next, I tried to badblock the partition space before I mke2fs.
2 weird things happened:

1) badblocks kept on trying to access a block beyond the end of the
device/partition (1044226) !!  Thank god it wasn't allowed to do it. Below
is the output from the badblocks run and also from my /var/log/messages
(see the below BADBLOCKS section, and look for the kernel messages _after_ 
the badblocks output)

2) (NOT SO IMPORTANT) even though badblocks finished, it never showed me on 
stdout the badblock numbers!! I had to rerun with -o badblocks.txt to get 
the
actual numbers. Is this a bug ?  Now that I think of it a second time,
the badblock # was 10440224, which might mean this: Note the "<----WTF
???" comments. Maybe when it was printed out on screen, it was written
over by the blocks counter (due to me using the -s switch) and thus I
couldn't "see it" on screen.

Does my thinking here make sense?

Should badblocks display the bad blocks at the end of the run if the -s
switch is used ?

##########################################################################
BADBLOCKS
##########################################################################

# badblocks -c64 -svw /dev/hdc3

Checking for bad blocks in read-write mode
>From block 0 to 1044225
Writing pattern 0xaaaaaaaa: done
Reading and comparing: 104422472/  1044225 <--- WTF ????
done
Writing pattern 0x55555555: done
Reading and comparing: done
Writing pattern 0xffffffff: done
Reading and comparing: done
Writing pattern 0x00000000: done
Reading and comparing: done
Pass completed, 1 bad blocks found.

----------------------
/var/log/messages said:

#at the end of each "Writing pattern 0x...."
Dec  3 20:25:39  kernel: attempt to access beyond end of device
Dec  3 20:25:39  kernel: 16:03: rw=0, want=1044226, limit=1044225

#at the end of each "Reading and comparing: done"
Dec  3 20:28:03  kernel: attempt to access beyond end of device
Dec  3 20:28:03  kernel: 16:03: rw=0, want=1044226, limit=1044225


Well after I was done with badblocks -o I went on to e2fsck with 1024byte
blocks (I am gonna have lots of small files). But that wouldn't fly. The
output below tells why, but I am not sure why it would be having short
reads that early into the partition...

##########################################################################
MKE2FS 1024
##########################################################################

# mke2fs -b 0124 -m 1 /dev/hdc3

Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
131072 inodes, 1044225 blocks
10442 blocks (1.00%) reserved for the super user
First data block=1
128 block groups
8192 blocks per group, 8192 fragments per group
1024 inodes per group
Superblock backups stored on blocks:
        8193, 24577, 40961, 57345, 73729, 204801, 221185, 401409, 663553,
        1024001

Writing inode tables:   0/128^H^H^H^H^H^H^H
Could not write 8 blocks in inode table starting at 8:
Attempt to write block from filesystem resulted in short write


So I tried 2048byte blocks, but I got yet another problem this time! It
ignores the badblock (1044224) saying it's out of range!? (even though the
partition has 1044225 blocks, and even though I never specified the
start/end blocks myself (i let it auto-figure it out)). Any ideas ?

Should my partitions have been even-numbered in block size ?

##########################################################################
MKE2FS 2048
##########################################################################

# mke2fs -c -l /tmp/bad -b 2048 -m 1 /dev/hdc3

mke2fs 1.25 (20-Sep-2001)
Filesystem label=
OS type: Linux
Block size=2048 (log=1)
Fragment size=2048 (log=1)
130560 inodes, 522112 blocks
5221 blocks (1.00%) reserved for the super user
First data block=0
32 block groups
16384 blocks per group, 16384 fragments per group
4080 inodes per group
Superblock backups stored on blocks:
        16384, 49152, 81920, 114688, 147456, 409600, 442368

Bad block 1044224 out of range; ignored.  <--- WTF ???
Checking for bad blocks (read-only test): done
Writing inode tables: done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 38 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.


##########################################################################

Any feedback/help would be much appreciated.

Thanks in advance



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

