Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAOM2h>; Mon, 15 Jan 2001 07:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAOM20>; Mon, 15 Jan 2001 07:28:26 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:57135 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S129401AbRAOM2Q>;
	Mon, 15 Jan 2001 07:28:16 -0500
Date: Mon, 15 Jan 2001 13:28:05 +0100 (CET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: More filesystem corruption with 2.4.1-pre3 and SW raid5
Message-Id: <Pine.LNX.4.30.0101151325380.25963-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Doing further tests I have experienced more filesystem corruption.
This time on another node, but also with SMP and SW raid5. The machine
has run the same test several times under 2.2.18, 2.2.17, 2.2.14 and
2.2.12 with no problems. This was the first time the test was run under
2.4.1 and gave me filesystem corruption. I observed the same thing on
my machine at home.

The test I am doing is copying/linking thousands of files around and delete
them again. The test starts of with 58 process copying 600 files (SMALL),
then 135 process copy around 9000 files (MEDIUM) and the in the last
test 325 process copy 80000 files (BIG). Each of the three tests (SMALL,
MEDIUM, BIG) is further divided into one test where the files get transmitted
via FTP (localhost) and another where the files are just being linked
from one directory to another one. And it always starts when I come
to the linking test. The link rate is about 2000 files/s. Here follows
some data what syslog reported:

   Jan 13 17:09:03 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1881249), 0
   Jan 13 17:09:03 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1881250), 0
   Jan 13 17:09:03 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1881251), 0
       .
       .
       .
   Jan 13 17:19:56 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 6688150
   Jan 13 17:19:57 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3338561), 0
   Jan 13 17:19:57 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3338562), 0
   Jan 13 17:19:57 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3338563), 0
       .
       .
       .
   Jan 13 17:20:00 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3338647), 0
   Jan 13 17:20:00 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 6688139
   Jan 13 17:20:00 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 6688136
   Jan 13 17:20:00 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 6688182
   Jan 13 17:26:34 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3361022), 0
   Jan 13 17:26:34 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3361023), 0
   Jan 13 17:26:34 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3361024), 0
       .
       .
       .
   Jan 13 17:26:35 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3361023), 0
   Jan 13 17:26:35 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (3361024), 0
   Jan 13 17:29:20 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 918960
   Jan 13 17:29:20 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 918961
   Jan 13 17:29:20 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 918962
       .
       .
       .
   Jan 13 17:30:57 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 3808052
   Jan 13 17:30:57 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 3808053
   Jan 13 17:30:57 florix kernel: EXT2-fs error (device md(9,2)): ext2_free_blocks: bit already cleared for block 3808054
   Jan 13 17:32:56 florix kernel: EXT2-fs error (device md(9,2)): ext2_readdir: bad entry in directory #2894349: rec_len % 4 != 0 - offset=0, inode=270105152, rec_len=1397, name_len=39
   Jan 13 17:32:56 florix kernel: EXT2-fs warning (device md(9,2)): empty_dir: bad directory (dir #2894349) - no `.' or `..'
   Jan 13 17:37:22 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1940635), 0
   Jan 13 17:37:22 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1940636), 0
   Jan 13 17:37:22 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1940637), 0
   Jan 13 17:37:22 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1940638), 0
       .
       .
       .
    Jan 13 19:34:27 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1933469), 0
    Jan 13 19:34:27 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1933471), 0
    Jan 13 19:34:27 florix kernel: EXT2-fs warning (device md(9,2)): ext2_unlink: Deleting nonexistent file (1933472), 0


At this point I was not able to log in on the machine but it was still
running and doing something as I discovered this morning when I came to
work. On console it was constantly writting:

    __alloc_pages: 0-order allocation failed

I was not able to log in so I had to reset the machine. After it came
back I had to repair the filesystem by hand but only the filesystem
and directories and files where I was doing my test where effected.
Here are some messages when I was fsck the disk:

    Duplicate or bad block in use ...
    Has 1 duplicate block(s), shared with 1 file(s): ...
    Entry XXX has deleted/unused inode ...
    Unattached inode XXX connect to /lost+found
    Inode XXX ref count is 2, should be 1.
    Inode XXX ref count is 6, should be 5.
    Free blocks count wrong for group XXX

Here are the details of the machine:

    Asus P2B-DS with two P3-450 and 256 MB ECC SDRAM
    Oboard Adaptec AIC-7890/1 Ultra2 SCSI
    6 x 9GB U2W SCSI disk put together as SW Raid 5
    2 x Intel EEPro 100
    RedHat 6.1 with the following installed:

    Linux florix 2.4.1-pre2 #3 SMP Sat Jan 13 15:39:55 GMT 2001 i686 unknown
    Kernel modules         2.4.1
    Gnu C                  egcs-2.91.66
    Gnu Make               3.77
    Binutils               2.9.1.0.25
    Linux C Library        2.1.2
    Dynamic linker         ldd (GNU libc) 2.1.2
    Procps                 2.0.4
    Mount                  2.10r
    Net-tools              1.53
    Console-tools          1999.03.02
    Sh-utils               2.0
    Modules Loaded         w83781d sensors i2c-piix4 i2c-isa i2c-core

Holger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
