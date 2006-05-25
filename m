Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWEYMjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWEYMjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbWEYMjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:39:18 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:23237 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965131AbWEYMjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:39:17 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][0/24]extend file size and filesystem size
Message-Id: <20060525213906sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:39:06 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas, all,

On Apr 27, 2006, Andreas wrote:
>>   [11/21] enlarge file size(ext3)
>>           - If the flag is set to super block, i_blocks of disk
>>             inode (ext3_inode) is filesystem-block unit, and
>>             i_blocks of VFS inode is sector unit.
>>           - If the flag is set to super block, max file size is set
>>             to (FS blocksize) * (2^32 -1).
>
>I like this patch, but prefer if we maintain as much compatibility as 
>possible.  There is not really a reason to make a filesystem 
>incompatible unless there are actually files > 2TB stored in it (just 
>like we didn't make filesystems incompatible for large_file unless 
>there were files over 2GB in the filesystem).

I updated my "i_blocks patch set" to keep as much compatibility as
possible.

Overview:
- In case of writing an inode of >2TB file to the disk,
  o set EXT2/3_HUGE_FILE_FL to inode.i_flags.
  o set EXT2_FEATURE_RO_COMPAT_HUGE_FILE to super block.
  o set blocks count to i_blocks of disk inode(ext3_inode) by
    filesystem-block unit.

- In case of reading an inode of >2TB file from the disk,
    if EXT2/3_HUGE_FILE_FL is set, i_blocks of disk inode(ext3_inode)
    is converted from filesystem-block unit to sector unit, and set to
    i_blocks of VFS inode.

- Once a >2TB file is created, super block flag(EXT2_FEATURE_RO_COMPAT_
  HUGE_FILE) is never unset even if every >2TB files are deleted.

- A filesystem with EXT2_FEATURE_RO_COMPAT_HUGE_FILE is allowed to be
  mounted read-only on existing kernel.

- In order to make filesystem with >2^31 blocks, execute mke2fs with
  "-O huge_fs".  Then super block flag(EXT2/3_FEATURE_
  INCOMPAT_HUGE_FS) is set.  Without this INCOMPAT flag, old kernel may
  mount huge filesystem and treat >2^31 block number as negative value.

This reform consists of the following 23 patches.
Five of them([12/24], [13/24], [14/24], [18/24], [22/24]) are the
patches I modified this time,

two of them([1/24], [2/24]) are the update of Minming Cao's patches
linked from the following URL,

  http://marc.theaimsgroup.com/?l=ext2-devel&m=114368281629281&w=2

one of them([19/24]) is the update of Jitendra Pawar's patch linked
from the following URL,

  http://marc.theaimsgroup.com/?l=ext2-devel&m=114734611020743&w=2

and the others are just the same as before except for version.
Minming, Jitendra, thanks for your help.

I'm working on typedef, but haven't merged yet.


----------------------
  Summary Of Patches
----------------------
The following is the patches for applying to linux-2.6.17-rc4.

  [1/24]  modify around the block allocation code(ext3)
          - Modify around the ext3 block allocation code to replace
            "int" type filesystem block number with "unsigned long".

  [2/24]  modify non block allocation code(ext3)
          - Same fix as above.

  [3/24]  add percpu_llcounter for ext3
          - The number of blocks and inodes are counted using
            percpu_counter whose entry for counter is long type, so it
            can only have less than 2G-1.  Then I add percpu_llcounter
            whose entry for counter is long long type in ext3.

  [4/24]  add percpu_llcounter for ext2
          - Same fix as ext3 described above [3/23].

  [5/24]  modify format strings in print(ext3)
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

  [6/24]  modify format strings in print(ext2)
          - Same fix as ext3 described above [5/23].

  [7/24]  modify format strings in print(bfs)
          - As i_blocks of VFS inode gets 8 byte variable, change its
            string format to %lld.

  [8/24]  modify format strings in print(efs)
          - Same fix as bfs described above [7/23].

  [9/24]  modify format strings in print(jbd)
          - Same fix as ext3 described above [5/23].

  [10/24]  change the type of variables manipulating a block or an
          inode(ext3)
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

  [11/24]  change the type of variables manipulating a block or an
           inode(ext2)
          - Same fix as ext3 described above [10/23].

  [12/24] enlarge block size(ext3)
          - Add an incompat flag "EXT3_FEATURE_INCOMPAT_LARGE_BLOCK"
            which indicates that the filesystem is extended.

          - Allow block size till pagesize in ext3.

  [13/24] extend file size(ext3)
          - If the flag is set to super block, i_blocks of disk inode
            (ext3_inode) is filesystem-block unit, and i_blocks of VFS
            inode is sector unit.

          - If the flag is set to super block, max file size is set to
            (FS blocksize) * (2^32 -1).

  [14/24] extend file size(ext2)
          - Same fix as ext3 described above [13/23].


The following is the patches for applying to e2fsprogs-1.39-WIP-2006-04-09.

  [15/24] modify format strings in print
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

  [16/24] change the type of variables manipulating a block and an
          inode
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

  [17/24] change the type of variables which manipulate bitmap
          - Change the type of 4byte variables manipulating bitmap
            from signed to unsigned.

  [18/24] enlarge file size and filesystem size
          - Add an option "-O large_block" in mke2fs.

          - With this option, the maximum size of a file is (blocksize)
            * (2^32-1) bytes, and of a filesystem is (pagesize) *
           (2^32-1).

  [19/24] large files and filesystem support
          - This fixes what remains unmodified.


The following is the patches for applying to ext2resize-1.1.19.

  [20/24] fix the bug related to the option "resize_inode"
          - A format of resize-inode in ext2prepare is different from
            the one in mke2fs, so ext2prepare fails.  Then I adapt
            ext2prepare's to mke2fs's.

  [21/24] fix the bug that an offset of an inode table is erroneously
          calculated
          - Running ext2resize results in failure due to an erroneous
            offset of an inode table, then I fix how to calculate it.

  [22/24] enlarge file size and filesystem size
          - With "-O large_block" option in mke2fs, the maximum size of
            a file is (blocksize) * (2^32-1) bytes, and of a filesystem
            is (pagesize) * (2^32-1).

  [23/24] change the type of variables manipulating a block or an inode
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

  [24/24] modify format strings in print
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.


Andreas, does this fix meet your demand?


Cheers, sho
