Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270663AbTHOR4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270652AbTHOR4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:56:54 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:15848 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S270663AbTHOR40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:56:26 -0400
Message-Id: <5.2.1.1.2.20030815135013.01b05bf8@oscarmayer.east.sun.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 15 Aug 2003 13:55:59 -0400
To: andrea@suse.de
From: Pete Nishimoto <Peter.Nishimoto@Sun.COM>
Subject: possible auto-partition bug? (linux-2.4.20-8)
Cc: linux-kernel@vger.kernel.org, Peten@ekb.East.Sun.COM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

         My name is Pete Nishimoto and I work for Sun Microsystems
         as a linux device driver developer, currently working with
         RedHat 9.0 (2.4.20-8) and I believe I have found a problem
         with the partitioning logic and the pager, which I've
         detailed below.  I look forward to any replies/comments
         and thanks in advance to all who review/read this.

                 Pete (Peter.Nishimoto@sun.com)

------------------------------------------------------------------------------


         I am writing a virtual disk driver for linux (a container
         file within which resides the "linux" disk).  To that end,
         I am able to freely to specify the disk geometry in any terms,
         specifically we can manipulate the maximum number of heads.

         I believe the I have uncovered a problem with the
         autopartitioning logic used during installation.
         The result is that there are partitions created that cannot be
         successfully scanned by badblocks.  Note that even though I
         found this on our virtual disks, when applying the same
         installation criteria to real PC harddisks, about half of
         the PC harddisks exhibited the same problem (badblock scan fails).
         At the end of this messages is appended some results of
         real disks on real PCs for which badblocks fails.

         This could be considered a non-problem, since it appears that
         only badblocks fails, and it only fails on the last
         block of the partition.  One might consider saying that
         these are just true "bad" blocks and can be discarded/disregarded.
         Further, these "bad" blocks would only be see if something
         tried to read (or write) to the last block of the partition.
         However, the problem (as I had uncovered it). is that the
         badblock utility is used during install, and, if badblocks
         reports an error during install, the installation will halt.
         Again, this might be explained away because it requires a
         "non-standard" installation sequence.  The exact installation
         sequence must be:

                 - start with a disk < 6 GBytes
                 - autopartition the entire disk
                 - check that a badblocks scan should be done
                 - select *all* packages are to be installed.   Note
                   that since this is a small disk, not all packages
                   will fit
                 - watch the first badblock scan succeed
                 - installation will then see that not all packages
                   will fit, so the user is prompted to respecify the
                   packages to install.
                 - once a new (smaller) package list has been specified,
                   installation will run badblocks again.
                 - this 2nd pass of badblocks will report and error and
                   the installation fails.

         The specifics are that the autopartitioning logic will allocate
         partitions on cylinder boundaries.  By definition, each cylinder
         contains an integral number of sectors (0x200 bytes/sector).
         However, during partitioning, mke2fs (and probably others like
         mke3fs) will set the blocksize for the filesystem.  For smaller
         partitions, this is usually set to 0x400 bytes.  However, for larger
         partitions, this is set to 0x1000 bytes.  This is effectively
         the page size for filesystem.  The problem occurs because
         when the partitions were generated, they may not contain
         an integral number of blocks (pages).  Thus, as badblocks
         traverses the partition and requests reads only of 0x1000 size
         blocks, at the end of the partition, since the partition is
         not an integral number of blocks/pages, the paging read
         fails (generic_make_request() in ./drivers/block/ll_rw_blk.c).
         While this may not seem to be a problem, as the blocks size is
         stored in the superblock, during installation the kernel has
         retained some data structures (some inodes) generated prior
         to the change in blocksize.

         During autopartitioning (see parted-1.6.5/libpared/disk.c)
         the partitioning logic uses a granularity of
         (max sectors * max head ), which is the number of sectors per
         cylinder.   Therefore, each partition will be allocated on
         cylinder bondaries, reguardless of overall disk size.

         A following is an actual example from our disk driver (kdev == 
0x1602):

Geometry ( 3.29 Gbytes, 6426000. (620d90) Sectors, 3290112000. (c41b2000) 
Bytes)


         nCyls                   :0x00000190 (     400.)
         nHeads                  :0x000000ff (     255.)
         SectorsPerTrack         :0x0000003f (      63.)
         BytesPerCylinder        :0x007d8200 ( 8225280.)
         BytesPerTrack           :0x00007e00 (   32256.)
         StartingOffset          :0x00000400 (    1024.)

         Installation autopartitioning will allocate in the following manner:

                 /boot   =  208782.  (0x32f8e)
                 /       = 5172930.  (0x4eeec2)
                 /swap   = 1044255.  (0xfef01)
                          ---------
                           6425967.


         Now, the linux pager read/writes the disk in units of
         diskblocks. This blocksize is stored
         in a couple of places, one of which is the superblock, but
         it is also stored in a global array blksize_size[], which is
         indexed per device major/minor number.

         The sequence order for the file system generation is:

                 - create the partitions (via a set of 'parted' libraries)
                 - create the filesystem (via mkfs)

         The autopartitioner will divvy up the disk as best as possible
         into 3 partitions, using the (above mentioned) granularity as
         a limiting factor.

         When generating the filesystem for ext2 (via mke2fs),
         mke2fs sets the blocksize depending upon
         the size of the partition.  Specifically, the code path
         is (where size is in MBytes):

                 if (size >= 0)     blocksize = 0x1000
                 if (size <= 0x200) blocksize = 0x400
                 if (size <= 0x3)   blocksize = 0x400

         Of particular note, when the partitions are created, the
         blocksize isn't taken into account (in fact, it hasn't even been
         set yet).    Thus, we have partitions that aren't an integral
         multiple of the blocksize.

         Note that:

                 sector size        == 0x200 bytes
                 initial block size == 0x400 bytes
                 linux page size    == 0x400 or 0x1000 bytes (blocksize)

         For our default disk case, note that:

                 4eeec2 % 3ec1     == 0
                 4eeec2 % 400/200  == 0
                 4eeec2 % 1000/200 != 0

         This means, that the partition, which is on a cylinder boundary,
         is an integral number of sectors (which is obvious), but it
         IS NOT an integral number of 1000/200 units, where 0x1000 is
         a valid page blocksize.

         When badblocks traverses the disk, it causes the pager
         to sequence through the partition, and it does this in
         blocksize blocks (the blocksize specified for badblocks is for
         the usermode badblocks program only, and does not have anything
         to do with the pager's blocksize).  So, since the partition
         is NOT an integral multiple of blocksize, in the above
         partition, the end of the partition cannot be read by
         a single page, since it is less than a page in size.
         Thus, badblocks will die.

         The blocksize for our drivers are initially set at driver startup.
         However, during autopartitiong, when the partition size has been
         determined, libparted (invoked from autopart.py during
         installation) DECIDES TO CHANGE the blocksize, from 0x400
         (which is our default) to 0x1000.  This information is then
         written to the disk (the superblock) and blksize_size[]
         has been updated, but some extant
         internal kernel data structures (inodes) have not been updated,
         thus there is data skew for the blocksize within the kernel.

         Now, the block size is determined by the value
         i_blksize stored in the inode.  This is initially set by
         alloc_inode() (./fs/inode.c), but is later modified by
         bdget() (./fs/block_dev.c).  However, the problem is that
         bgget() does not check to see what the current blocksize of
         the filesystem is.  Note that there is no extant superblock
         in the kernel superblock table for lookup at the time that
         bgget() is reassociating the inode.  Thus, the i_blksize
         of an inode is that of the RAMDISK_DEVICE (the "template
         device that was used to create the inode - i,e., the superblock
         of the caller of alloc_inode() - 0x400), a default which is a kernel
         system default and NOT the default supplied by the driver.
         Thus, there is no way for an extant inode to get updated after
         the new partition/filesystem has been generated, and a new blocksize
         has been determined/set.

         The precise inode sequence is as follows:

                 - mke2fs is invoked, setting the blocksize of the
                   filesystem to 0x1000

                 - alloc_inode() generates an inode based on the
                   RAMDISK superblock (sb->s_dev == 0x1).  blocksize
                   is set to 0x400

                 - bdget() is called with our disk driver (kdev == 0x1602).
                   No mods for the blocksize.  Note:

                     - the blksize_size[] entry for 0x1602 is now 0x1000
                     - there is no superblock entry in the global superblock
                       table for 0x1602, so a call to get_super()
                       (./fs/super.c) or even copy-coding the inline
                       routine find_super() (./fs/super.c) locally produces
                       no superblock for any 0x1600 device.


         Now, for the first pass of badblocks, the inode->i_blkbits
         is set at 0x400.  This is fine as the number of sectors in
         the partition is an integral number of 0x400.  However, upon
         the 2nd pass of badblocks, the inodes are recreated and the
         "new" blocksize of 0x1000 is used.  Since the partition is
         not an integral number of 0x1000 blocks, the kernel
         (generic_make_request() in ./drivers/block/ll_rw_blk.c) will
         fail as there will be a paging request to read a page
         (of blocksize) starting at sector 0x4eeec0.

         Thus, there are 2 problems:

            1) the autopartition "granularity".  This is hardcoded to
               be the max number of cylinders and heads (255. * 63.).

            2) the changing paging blocksize

         Problem #2 is directly related to problem #1 in that the granularity
         must be an integral number of the paging blocksize.  Since the
         paging blocksize changes for the current implementation, then
         we should set the paging blocksize to the maximum (0x1000)
         so that it will be later changed from 0x400.  Thus, the
         granularity should be an integral mutiple of 8, since 0x1000
         and 0x400 are multples of 0x8 and such a granularity will
         be an integral mutiple of 0x400 and 0x1000 as well.  This
         value is then should be 248. * 63.


         Attempts:

             1) change default blocksize for our drivers.

                 result: doesn't affect partitioning, and we still get
                         badblocks because of block indexing.

             2) force mke2fs to always use 0x400 as the blocksize

                 result: works

                 issue : do this for ext3 and other file systems?
                 issue : how to get this version in at install?

             3) change superblock blocksize on fly

                 result: unknown

                 issue : when is a good time for this?  There is no
                         kernel callback notification, and, when this is
                         done, it already has an inode active, etc.

             4) change initial allocation so that we get good numbers
                (e.g., granularity now 248 * 63, which is divisible by 8)

                 result : paritioning works, but 2nd pass of badblocks
                          still fails.  And, if no badblocks check is made
                          during install, badblocks still fails after
                          install because the blocksize for the partition
                          has been set to 0x1000 (use debugfs to show).

             5) change initial allocation so that we get good numbers
                (e.g., granularity now 248 * 63, which is divisible by 8)
                AND change default blocksize for our drivers to 0x1000.

                This is to combine the autopartition compensation (granularity)
                and to account for superblock blocksize override after
                the file system is made.

                "New" default redhat disk geometry:


Geometry ( 3.26 Gbytes, 6374592. (6144c0) Sectors, 3263791104. (c2898000) 
Bytes)


         nCyls                   :0x00000198 (     408.)
         nHeads                  :0x000000f8 (     248.)
         SectorsPerTrack         :0x0000003f (      63.)
         BytesPerCylinder        :0x007a1000 ( 7999488.)
         BytesPerTrack           :0x00007e00 (   32256.)
         StartingOffset          :0x00000400 (    1024.)

                 result: partitions fine, BUT mke2fs fails because
                         while the blocksize is now 0x1000, the kernel
                         still retains inodes for which the blocksize
                         is 0x400.  Thus, when mke2fs makes a call to
                         zero_blocks() to zero out the "last" block,
                         it will obtain the inode with the wrong blocksize,
                         and this results in a seek failure.  See appended log.

                 issue : can we change the inode->i_blkbits at the right time?

             6) change initial allocation so that we get good numbers
                (e.g., granularity now 248 * 63, which is divisible by 8)
                AND change default blocksize for our drivers to 0x1000
                AND put a kernel fix in bdget() to update the blocksize

                 result: partitions fine.  installs fine.
                         badblocks works (does not fail).


-------------------------------------------------------------------------------

                         Successful tests of Attempt #6


Geometry ( 3.26 Gbytes, 6374592. (6144c0) Sectors, 3263791104. (c2898000) 
Bytes)


         nCyls                   :0x00000198 (     408.)
         nHeads                  :0x000000f8 (     248.)
         SectorsPerTrack         :0x0000003f (      63.)
         BytesPerCylinder        :0x007a1000 ( 7999488.)
         BytesPerTrack           :0x00007e00 (   32256.)
         StartingOffset          :0x00000400 (    1024.)


Geometry ( 5.44 Gbytes, 10624320. (a21d40) Sectors, 5439651840. (1443a8000) 
Byte
s):
         nCyls                   :0x000002a8 (     680.)
         nHeads                  :0x000000f8 (     248.)
         SectorsPerTrack         :0x0000003f (      63.)
         BytesPerCylinder        :0x007a1000 ( 7999488.)
         BytesPerTrack           :0x00007e00 (   32256.)
         StartingOffset          :0x00000400 (    1024.)


Geometry (13.38 Gbytes, 26123328. (18e9c40) Sectors, 13375143936. 
(31d388000) By
tes):
         nCyls                   :0x00000688 (    1672.)
         nHeads                  :0x000000f8 (     248.)
         SectorsPerTrack         :0x0000003f (      63.)
         BytesPerCylinder        :0x007a1000 ( 7999488.)
         BytesPerTrack           :0x00007e00 (   32256.)
         StartingOffset          :0x00000400 (    1024.)


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


                         "Real PCs" Autopartition Failure


         On a real PC, the following is allocated:

==================================================================

Disk /dev/hda: 4303 MB, 4303272960 bytes
255 heads, 63 sectors/track, 523 cylinders, total 8404830 sectors
Units = sectors of 1 * 512 = 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *        63    208844    104391   83  Linux
/dev/hda2        208845   7630874   3711015   83  Linux
/dev/hda3       7630875   8401994    385560   82  Linux swap

Command (m for help): u
Changing display/entry units to cylinders

Command (m for help): p

Disk /dev/hda: 4303 MB, 4303272960 bytes
255 heads, 63 sectors/track, 523 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1        13    104391   83  Linux
/dev/hda2            14       475   3711015   83  Linux
/dev/hda3           476       523    385560   82  Linux swap

==================================================================

         Now:

                 7630874
                 -208845
                 -------
                 7422029+1 => 7422030 sectors = 71404d

                 71404d % 8 != 0

         Badblocks -sv /dev/hda2 fails.

         Disk label specs:

                 8894 Cyl
                 4303 MB
                   15 Heads
                   63 Sectors



-------------------------------------------------------------------------------

         Another PC failure:

==================================================================

Disk /dev/hda: 20.4 GB, 20493656064 bytes
255 heads, 63 sectors/track, 2491 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1        13    104391   83  Linux
/dev/hda2            14      2443  19518975   83  Linux
/dev/hda3          2444      2491    385560   82  Linux swap

Command (m for help): u
Changing display/entry units to sectors

Command (m for help): p

Disk /dev/hda: 20.4 GB, 20493656064 bytes
255 heads, 63 sectors/track, 2491 cylinders, total 40026672 sectors
Units = sectors of 1 * 512 = 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *        63    208844    104391   83  Linux
/dev/hda2        208845  39246794  19518975   83  Linux
/dev/hda3      39246795  40017914    385560   82  Linux swap

Command (m for help):

==================================================================

         badblocks -sv /dev/hda2 fails.

         Disk label specs:

                 16383 Cyl
                    16 heads
                    63 sectors


-------------------------------------------------------------------------------

         Another PC failure:

==================================================================


Disk /dev/hda: 40.0 GB, 40020664320 bytes
255 heads, 63 sectors/track, 4865 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1        13    104391   83  Linux
/dev/hda2            14      4817  38588130   83  Linux
/dev/hda3          4818      4865    385560   82  Linux swap

Command (m for help): u
Changing display/entry units to sectors

Command (m for help): p

Disk /dev/hda: 40.0 GB, 40020664320 bytes
255 heads, 63 sectors/track, 4865 cylinders, total 78165360 sectors
Units = sectors of 1 * 512 = 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *        63    208844    104391   83  Linux
/dev/hda2        208845  77385104  38588130   83  Linux
/dev/hda3      77385105  78156224    385560   82  Linux swap

==================================================================

         badblocks -sv /dev/hda2 fails.

         No Disk label specs

-----------------------------------------------------------------------------
------------------------------------------------------------------------------

               Debug Log of mke2fs failure for "Attempt #5"


#### mke2fs invoked



Mon Aug 11 10:47:53 2003 : (mke2fs) Main: built on Aug 11 2003 at 10:17:05
Mon Aug 11 10:47:53 2003 : (mke2fs) Main: argc 2.
Mon Aug 11 10:47:53 2003 : (mke2fs) Main:    arg 0. = /usr/sbin/mke2fs
Mon Aug 11 10:47:53 2003 : (mke2fs) Main:    arg 1. = /tmp/hdc2
Mon Aug 11 10:47:53 2003 : (mke2fs) PRS: entry - param 805abc0 
param.s_log_block
_size 0 blocksize 0 blocks_count 0
Mon Aug 11 10:47:53 2003 : (lib/ext2fs/getsize.c) ext2fs_get_device_size: entry
- file /tmp/hdc2
Mon Aug 11 10:47:53 2003 : (32) alloc_inode: inode c277d480 sb c1aa0400 s_dev 1
s_blocksize_bits a
Mon Aug 11 10:47:53 2003 : (32) bdget: inode c277d480 old i_dev 1 new 
i_dev/i_rd
ev 1602 bdev 0
Mon Aug 11 10:47:53 2003 : (lib/ext2fs/getsize.c) ext2fs_get_device_size: 
exit -
  BLKGETSIZE size 4e3240 blocksize 400 retblocks 271920
Mon Aug 11 10:47:53 2003 : (mke2fs) PRS: ext2fs_get_device_size results - 
dev_si
ze 271920

#### mke2fs/set_fs_defaults() called, which determines the blocksize


Mon Aug 11 10:47:53 2003 : (mke2fs) set_fs_defaults: entry - super 805abc0 
fs_ty
pe 0 blocksize 0 super->s_log_block_size 0 s_blocks_count 271920
Mon Aug 11 10:47:53 2003 : (mke2fs) set_fs_defaults:     megs 9c6 p->size 0 
p->b
locksize 1000 type default
Mon Aug 11 10:47:53 2003 : (mke2fs) set_fs_defaults:     NOT SKIPPED
Mon Aug 11 10:47:53 2003 : (mke2fs) set_fs_defaults:    setting blocksize - 
sett
ings type default p->blocksize 1000
Mon Aug 11 10:47:53 2003 : (mke2fs) set_fs_defaults:    set 
s_log_block_size 2 b
locksize 1000
Mon Aug 11 10:47:53 2003 : (mke2fs) set_fs_defaults:     megs 9c6 p->size 
200 p-
 >blocksize 400 type default
Mon Aug 11 10:47:53 2003 : (mke2fs) set_fs_defaults:     megs 9c6 p->size 3 
p->b
locksize 400 type default
Mon Aug 11 10:47:53 2003 : (mke2fs) set_fs_defaults: exit - super 805abc0 
blocks
ize 0 super->s_log_block_size 2
Mon Aug 11 10:47:53 2003 : (mke2fs) PRS: exit - param 805abc0 
param.s_log_block_
size 2 blocksize 0


#### alloc_inode 0xc277d480 with superblock of s_dev == 0x1, blocksize 0x400


Mon Aug 11 10:47:53 2003 : (32) alloc_inode: inode c277d480 sb c1aa0400 s_dev 1
s_blocksize_bits a


#### bdget() called with inode 0xc277d480 and dev == 0x1602 (sundska2)
#### no change to blocksize (s_blocksize_bits == 0xa).  The blocksize
#### for 0x1602 is 0x1000, which is equivalent to blocksize_bits of 0xc

Mon Aug 11 10:47:53 2003 : (32) bdget: inode c277d480 old i_dev 1 new 
i_dev/i_rd
ev 1602 bdev 0

#### continue execution (debug left here for elucidation)


Mon Aug 11 10:47:53 2003 : (32) SunDskOpen: entry - Inode ccf9bdc0 Filep 
cd13c84
0
Mon Aug 11 10:47:53 2003 : (32) SunDskOpen: exit - status 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: entry - inode cf7cb340 
*ppos
  5bfc4 i_rdev 0 i_blkbits a
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5bfc4 limit 0 count 
ffff
ffff
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5bfc4 s_maxbytes 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: entry inode cf7cb340 
i_bl
kbits a block 16c
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (10) __add_to_page_cache: page c108b690 offset 5c
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: entry inode cf7cb340 
i_bl
kbits a block 170
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: exit - err 6c 108.
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: entry - inode c277d480 
*ppos
  400 i_rdev 1602 i_blkbits a
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: pos 400 limit 0 count 
ffffff
ff
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (32) __add_to_page_cache: page c10896a0 offset 0
Mon Aug 11 10:47:53 2003 : (32) __block_prepare_write: entry inode c277d480 
i_bl
kbits a block 0
Mon Aug 11 10:47:53 2003 : (32) blkdev_get_block: rdev 1602 
inode->i_blkbits a b
h ccc8ecc0 iblock 1
Mon Aug 11 10:47:53 2003 : (32) max_block: entry - dev 1602
Mon Aug 11 10:47:53 2003 : (32) max_block: size 1000 blocks 271923 
BLOCK_SIZE_BI
TS a sizebits c retval c0000000
Mon Aug 11 10:47:53 2003 : (32) max_block: exit - retval 9c648
Mon Aug 11 10:47:53 2003 : (32) blkdev_get_block: rdev 1602 
inode->i_blkbits a b
h ccc8e240 iblock 2
Mon Aug 11 10:47:53 2003 : (32) max_block: entry - dev 1602
Mon Aug 11 10:47:53 2003 : (32) max_block: size 1000 blocks 271923 
BLOCK_SIZE_BI
TS a sizebits c retval c0000000
Mon Aug 11 10:47:53 2003 : (32) max_block: exit - retval 9c648
Mon Aug 11 10:47:53 2003 : (32) blkdev_get_block: rdev 1602 
inode->i_blkbits a b
h ccf07c40 iblock 3
Mon Aug 11 10:47:53 2003 : (32) max_block: entry - dev 1602
Mon Aug 11 10:47:53 2003 : (32) max_block: size 1000 blocks 271923 
BLOCK_SIZE_BI
TS a sizebits c retval c0000000
Mon Aug 11 10:47:53 2003 : (32) max_block: exit - retval 9c648
Mon Aug 11 10:47:53 2003 : (32) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: exit - err c00 3072.
Mon Aug 11 10:47:53 2003 : (32) alloc_inode: inode c277d080 sb c1a7ec00 
s_dev 10
0 s_blocksize_bits a
Mon Aug 11 10:47:53 2003 : (32) do_generic_file_read: entry - ppos 0 index 
0 off
set 0
Mon Aug 11 10:47:53 2003 : (32) block_read_full_page: entry - iblock 0 page 
c108
96a0 page->index 0
Mon Aug 11 10:47:53 2003 : (32) blkdev_get_block: rdev 1602 
inode->i_blkbits a b
h ccc8ed40 iblock 0
Mon Aug 11 10:47:53 2003 : (32) max_block: entry - dev 1602
Mon Aug 11 10:47:53 2003 : (32) max_block: size 1000 blocks 271923 
BLOCK_SIZE_BI
TS a sizebits c retval c0000000
Mon Aug 11 10:47:53 2003 : (32) max_block: exit - retval 9c648
Mon Aug 11 10:47:53 2003 : (32) block_read_full_page: calling submit_bh 
ccc8ed40

Mon Aug 11 10:47:53 2003 : (32) submit_bh: entry - b_blocknr 0 bh->b_size 
400 co
unt 2
Mon Aug 11 10:47:53 2003 : (32) submit_bh: exit
Mon Aug 11 10:47:53 2003 : (32) block_read_full_page:     submit_bh complete
Mon Aug 11 10:47:53 2003 : (32) SunDskRequest: entry - Queue c0314238
Mon Aug 11 10:47:53 2003 : (32) SunDskIpcReadWrite: entry - Device d00ccc20 
Read
Write 0 StartSector 0 NumSectors 2 Buffer c2742000
Mon Aug 11 10:47:53 2003 : (32) CalcCHS: Device d00ccc20 DiskNum 0 PartitionNum
2 LBA 0
Mon Aug 11 10:47:53 2003 : (32) CalcCHS: exit - Cylinder d Head 0 Sector 1
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: entry - inode cf7cb340 
*ppos
  5c030 i_rdev 0 i_blkbits a
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c030 limit 0 count 
ffff
ffff
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c030 s_maxbytes 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: entry inode cf7cb340 
i_bl
kbits a block 170
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: exit - err 128 296.
Mon Aug 11 10:47:53 2003 : (32) SunDskIpcReadWrite: exit - status 0
Mon Aug 11 10:47:53 2003 : (32) SunDskRequest: exit - status 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: entry - inode cf7cb340 
*ppos
  5c158 i_rdev 0 i_blkbits a
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c158 limit 0 count 
ffff
ffff
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c158 s_maxbytes 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: entry inode cf7cb340 
i_bl
kbits a block 170
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: exit - err 61 97.
Mon Aug 11 10:47:53 2003 : (32) file_read_actor: entry - page c10896a0 offset 0
size 1000 count 200
Mon Aug 11 10:47:53 2003 : (32) file_read_actor: exit - size 200
Mon Aug 11 10:47:53 2003 : (32) do_generic_file_read: called actor - ret 
200 off
set 0 index 0
Mon Aug 11 10:47:53 2003 : (32) do_generic_file_read: new offset 200 index 0
Mon Aug 11 10:47:53 2003 : (32) do_generic_file_read: exit - ppos 200 index 
0 of
fset 0
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: entry - inode c277d480 
*ppos
  0 i_rdev 1602 i_blkbits a
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: pos 0 limit 0 count 
ffffffff

Mon Aug 11 10:47:53 2003 : (32) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (32) __block_prepare_write: entry inode c277d480 
i_bl
kbits a block 0
Mon Aug 11 10:47:53 2003 : (32) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: exit - err 400 1024.


#### mke2fs makes call to zero_blocks()


Mon Aug 11 10:47:53 2003 : (mke2fs) Main: rsv 10 blocks 9c648 start 9c640
Mon Aug 11 10:47:53 2003 : (mke2fs) Main: calling zero_blocks - start 9c630 
bloc
ks 9c648 blocks-start 18
Mon Aug 11 10:47:53 2003 : (mke2fs) zero_blocks: entry blk 9c630 num 18
Mon Aug 11 10:47:53 2003 : (mke2fs) zero_blocks: blk 9c630 (640560.)
Mon Aug 11 10:47:53 2003 : (32) alloc_inode: inode c277d280 sb c1aa0400 s_dev 1
s_blocksize_bits a
Mon Aug 11 10:47:53 2003 : (32) bdget: inode c277d280 old i_dev 1 new 
i_dev/i_rd
ev c800 bdev 0
Mon Aug 11 10:47:53 2003 : (32) alloc_inode: inode c277d280 sb c1aa0400 s_dev 1
s_blocksize_bits a
Mon Aug 11 10:47:53 2003 : (32) bdget: inode c277d280 old i_dev 1 new 
i_dev/i_rd
ev 1600 bdev 0
Mon Aug 11 10:47:53 2003 : (32) SunDskOpen: entry - Inode cdad3980 Filep 
cd13c94
0
Mon Aug 11 10:47:53 2003 : (32) SunDskOpen: exit - status 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: entry - inode cf7cb340 
*ppos
  5c1b9 i_rdev 0 i_blkbits a
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c1b9 limit 0 count 
ffff
ffff
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c1b9 s_maxbytes 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: entry inode cf7cb340 
i_bl
kbits a block 170
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: exit - err 6c 108.
Mon Aug 11 10:47:53 2003 : (32) SunDskIoctl: entry - Inode cdad3980 Filep 
cd13c9
40 Command 534400 Argument 8055ced
Mon Aug 11 10:47:53 2003 : (32) SunDskIoctl: SunDebugPrintForceToBridge 
turned O
N
Mon Aug 11 10:47:53 2003 : (32) SunDskIoctl: SunDebugPrintForceToBridge 
turned O
N
Mon Aug 11 10:47:53 2003 : (32) SunDskIoctl: exit - status 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: entry - inode cf7cb340 
*ppos
  5c225 i_rdev 0 i_blkbits a
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c225 limit 0 count 
ffff
ffff
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c225 s_maxbytes 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: entry inode cf7cb340 
i_bl
kbits a block 170
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: exit - err cf 207.
Mon Aug 11 10:47:53 2003 : (32) SunDskIoctl: entry - Inode cdad3980 Filep 
cd13c9
40 Command 534400 Argument bfffe390
Mon Aug 11 10:47:53 2003 : (32) SunDskIoctl: SunDebugLevel set to ffffffff
Mon Aug 11 10:47:53 2003 : (32) SunDskIoctl: SunDebugLevel set to ffffffff
Mon Aug 11 10:47:53 2003 : (32) SunDskIoctl: exit - status 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: entry - inode cf7cb340 
*ppos
  5c2f4 i_rdev 0 i_blkbits a
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c2f4 limit 0 count 
ffff
ffff
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c2f4 s_maxbytes 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: entry inode cf7cb340 
i_bl
kbits a block 170
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: exit - err c9 201.
Mon Aug 11 10:47:53 2003 : (32) SunDskOpen: entry - Inode c277d280 Filep 0
Mon Aug 11 10:47:53 2003 : (32) SunDskRelease: i_rdev 1600 MINOR 0
Mon Aug 11 10:47:53 2003 : (32) SunDskRelease: diskNum 0 partitionNum 0
Mon Aug 11 10:47:53 2003 : (32) SunDskRelease: exit - status 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: entry - inode cf7cb340 
*ppos
  5c3bd i_rdev 0 i_blkbits a
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c3bd limit 0 count 
ffff
ffff
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: pos 5c3bd s_maxbytes 0
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: entry inode cf7cb340 
i_bl
kbits a block 170
Mon Aug 11 10:47:53 2003 : (10) __block_prepare_write: exit
Mon Aug 11 10:47:53 2003 : (10) generic_file_write: exit - err d1 209.


#### pager works on mke2fs/zero_blocks() write request with inode 0xc277d480
#### However, inode->i_blkbits == 0xa (0x400 blocksize), but the
#### blocksize for 0x1602 is really 0x1000 (i_blkbits should be 0xc)


Mon Aug 11 10:47:53 2003 : (32) generic_file_write: entry - inode c277d480 
*ppos
  9c630000 i_rdev 1602 i_blkbits a
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: pos 9c630000 limit 0 
count f
fffffff
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: ready for write
Mon Aug 11 10:47:53 2003 : (32) __add_to_page_cache: page c10894e0 offset 9c630

#### __block_prepare_write() (./fs/block_dev.c) sets up the write by first
#### "getting" the block.  It computes the block number using inode->i_blkbits,
#### which is essentially 0x400.  Note that in this case, it is asking to
#### write the "last" block of the partition.


Mon Aug 11 10:47:53 2003 : (32) __block_prepare_write: entry inode c277d480 
i_bl
kbits a block 2718c0


#### blkdev_get_block() (./fs/block_dev.c) is invoked to get the "last" block
#### 0x2718c0, based on a blocksize of 0x400.  First thing that it does
#### is a check to see if we exceed the partition size by getting the
#### size of the partition via max_block().  max_block() (./fs/block_dev.c)
#### uses the blksize_size[] global arrays which says that the blocksize
#### is 0x1000.  Thus, the result that max_block() returns is in terms of
#### 0x1000 blocksized blocks, which is numerically less than the block
#### index passed into blkdev_get_block() as the "last" block.  Thus,
#### blkdev_get_block() returns an error


Mon Aug 11 10:47:53 2003 : (32) blkdev_get_block: rdev 1602 
inode->i_blkbits a b
h ccc8e740 iblock 2718c0
Mon Aug 11 10:47:53 2003 : (32) max_block: entry - dev 1602
Mon Aug 11 10:47:53 2003 : (32) max_block: size 1000 blocks 271923 
BLOCK_SIZE_BI
TS a sizebits c retval c0000000
Mon Aug 11 10:47:53 2003 : (32) max_block: exit - retval 9c648
Mon Aug 11 10:47:53 2003 : (32) max_block: entry - dev 1602
Mon Aug 11 10:47:53 2003 : (32) max_block: size 1000 blocks 271923 
BLOCK_SIZE_BI
TS a sizebits c retval c0000000
Mon Aug 11 10:47:53 2003 : (32) max_block: exit - retval 9c648
Mon Aug 11 10:47:53 2003 : (32) blkdev_get_block: max_block(inode->i_rdev) 
9c648
  failure
Mon Aug 11 10:47:53 2003 : (32) __block_prepare_write: get_block failure - 
err 2
718c0 block ccc8e740
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: prepare_write failure - 
stat
us fffffffb
Mon Aug 11 10:47:53 2003 : (32) generic_file_write: exit - err fffffffb -5.

