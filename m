Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278012AbRJIWNP>; Tue, 9 Oct 2001 18:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278011AbRJIWM4>; Tue, 9 Oct 2001 18:12:56 -0400
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:19205 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S278010AbRJIWMs>; Tue, 9 Oct 2001 18:12:48 -0400
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Tue, 9 Oct 2001 18:13:20 -0400
To: linux-kernel@vger.kernel.org
Cc: Daniel Freedman <freedman@ccmr.cornell.edu>
Subject: 'set_blocksize' & 'nr_blocks changed' during Raid1 mount...
Message-ID: <20011009181319.C15093@ccmr.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm looking for clarification on the following kernel messages that I
received during a mount of a recently-created raid1 device.  I'm using
a 2.2.19 kernel (close to stock, actually Debian's Potato kernel,
which is stock +~ BigPhysArea patch), which I've then patched with
Ingo Molnar's 0.90 RAID layer (I used the correct 2.2.19 patches).

Here's what I did to create the /dev/md0 device:

# partition /dev/sda5 and /dev/sdb5 to participate in raid1
# create appropriate /etc/raidtab (listed at end of email)
mkraid /dev/md0
# following commands were executing while partitions were
# still re-syncing (if that's relevant)
mke2fs /dev/md0
# /dev/md0 is configured as /home as listed in fstab (at end of email)
mount /home

I then received the following kernel messages on mounting /dev/md0:

Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058688, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058689, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058690, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058691, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058692, from 00000900
 <snip>
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058807, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058808, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058809, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058810, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058811, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058812, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058813, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058814, from 00000900
Oct  9 15:56:49 newton kernel: set_blocksize: b_count 2, dev md(9,0), block 31058815, from 00000900
Oct  9 15:56:49 newton kernel: md0: blocksize changed during read
Oct  9 15:56:49 newton kernel: nr_blocks changed to 32 (blocksize 4096, j 7764672, max_blocks 15868160)

Interestingly enough, I now no longer get any kernel messages when I
mount or unmount the raid1 partition.  Could this possibly be because
md0's no longer in the resync process?  I did a linux-kernel and
linux-raid mailing list search as well as a google and usenet search
and found a few messages posting the same or related scenaria but no
replies to their questions.  Casually examining the source code did
not provide any obvious clues to me.  Any advice is greatly
appreciated.

Thanks,
Daniel

ps: kindly cc me on replies if possible.





Additional info:

newton:~# fdisk -l /dev/sda

Disk /dev/sda: 255 heads, 63 sectors, 8924 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1             1      8924  71681998+   5  Extended
/dev/sda5             1      7902  63472752   fd  Linux raid autodetect
/dev/sda6          7903      8924   8209183+  fd  Linux raid autodetect
newton:~# fdisk -l /dev/sdb

Disk /dev/sdb: 255 heads, 63 sectors, 8924 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1             1      8924  71681998+   5  Extended
/dev/sdb5             1      7902  63472752   fd  Linux raid autodetect
/dev/sdb6          7903      8924   8209183+  fd  Linux raid autodetect
newton:~# grep /home /etc/fstab 
/dev/md0        /home   ext2    rw                              0       2
newton:~# cat /proc/mdstat 
Personalities : [raid1] 
read_ahead 1024 sectors
md0 : active raid1 sdb5[1] sda5[0] 63472640 blocks [2/2] [UU]
unused devices: <none>
newton:~# cat /etc/raidtab 
raiddev /dev/md0
        raid-level      1
        nr-raid-disks   2
        nr-spare-disks  0
        chunk-size      4
        persistent-superblock   1
        device          /dev/sda5
        raid-disk       0
        device          /dev/sdb5
        raid-disk       1
newton:~# e2fsck -n -f /dev/md0
e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/md0: 20/7946240 files (0.0% non-contiguous), 249369/15868160 blocks





-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
