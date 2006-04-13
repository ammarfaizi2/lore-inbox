Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWDMGpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWDMGpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 02:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWDMGpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 02:45:08 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:40841 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S964794AbWDMGpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 02:45:06 -0400
To: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC][0/21]extend file size and filesystem size
Message-Id: <20060413154430sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 13 Apr 2006 15:44:30 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have tried to extend the filesystem size and file size in ext2/3
until now.  And this time, I merged all the previous patches.
Base kernel and command(e2fsprogs) were updated.  As for functional
aspect, nothing changed particularly.  But I added patches in relation
to ext2resize, including 2 bug fixes.


A summary of my reform to extend the specs in ext2/3 is as below.

  - enlarge block size
      Max block size in ext3 is restricted to 4KB by kernel, then I
      modified to allow blocksize up to pagesize in checking blocksize
      through mount.

  - increase the number of blocks in filesystem
      Max number of blocks is restricted to 2G-1 in ext2/3.  This is
      because the number of blocks is treated as unsigned 4byte
      variable in kernel and command, and assembler instruction, which
      can't treat >2G offset, is used on some commands.  Then I made
      up to 4G-1 blocks in filesystem usable by extending the
      type of variables in relation to block and inode, and not using
      assembler instruction which can't treat >2G offset.

  - enlarge file size
      Max file size in ext3 is about 2TB because i_blocks of ext3_inode
      is 4byte variable by sector.  And then, I extended the max file
      size by changing the unit of ext3_inode.i_blocks from sector to
      filesystem block.

Due to above reform, specs of the filesystem can be extended as below.

	Max filesystem size:
	Block size      Original    Extended
	       4KB           8TB        16TB
	      64KB         128TB       256TB

	Max file size:
	Block size      Original    Extended
	       4KB      1.998TB     4.003TB
	      64KB      1.998TB       256TB

This reform consists of the following 21 patches, but two of them
([17/21], [18/21]) are the fixes against the existing bugs in
ext2resize-1.1.19.

----------------------
  Summary Of Patches
----------------------

The following is the patches for applying to linux-2.6.17-rc1 after
applying Mingming Cao's patch: "Extend ext3 filesystem limit from 8TB
to 16TB" linked from the following URL.

    http://marc.theaimsgroup.com/?l=ext2-devel&m=114368281629281&w=2


  [1/21]  add percpu_llcounter for ext3
          - The number of blocks and inodes are counted using
            percpu_counter whose entry for counter is long type, so it
            can only have less than 2G-1.  Then I add percpu_llcounter
            whose entry for counter is long long type in ext3.

  [2/21]  add percpu_llcounter for ext2
          - Same fix as ext3 described above [1/21].

  [3/21]  modify format strings in print(ext3)
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

  [4/21]  modify format strings in print(ext2)
          - Same fix as ext3 described above [3/21].

  [5/21]  modify format strings in print(bfs)
          - As i_blocks of VFS inode gets 8 byte variable, change its
            string format to %lld.

  [6/21]  modify format strings in print(efs)
          - Same fix as bfs described above [5/21].

  [7/21]  modify format strings in print(jbd)
          - Same fix as ext3 described above [3/21].

  [8/21]  change the type of variables manipulating a block or an
          inode(ext3)
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

  [9/21]  change the type of variables manipulating a block or an
          inode(ext2)
          - Same fix as ext3 described above [8/21].

  [10/21] enlarge block size(ext3)
          - Add an incompat flag "EXT3_FEATURE_INCOMPAT_LARGE_BLOCK"
            which indicates that the filesystem is extended.

          - Allow block size till pagesize in ext3.

  [11/21] extend file size(ext3)
          - If the flag is set to super block, i_blocks of disk inode
            (ext3_inode) is filesystem-block unit, and i_blocks of VFS
            inode is sector unit.

          - If the flag is set to super block, max file size is set to
            (FS blocksize) * (2^32 -1).

  [12/21] extend file size(ext2)
          - Same fix as ext3 described above [11/21].


The following is the patches for applying to e2fsprogs-1.39-WIP-2006-04-09.

  [13/21] modify format strings in print
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.

  [14/21] change the type of variables manipulating a block and an
          inode
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

  [15/21] change the type of variables which manipulate bitmap
          - Change the type of 4byte variables manipulating bitmap
            from signed to unsigned.

  [16/21] enlarge file size and filesystem size
          - Add an option "-O large_block" in mke2fs.

          - With this option, the maximum size of a file is (blocksize)
            * (2^32-1) bytes, and of a filesystem is (pagesize) *
           (2^32-1).


The following is the patches for applying to ext2resize-1.1.19.

  [17/21] fix the bug related to the option "resize_inode"
          - A format of resize-inode in ext2prepare is different from
            the one in mke2fs, so ext2prepare fails.  Then I adapt
            ext2prepare's to mke2fs's.

  [18/21] fix the bug that an offset of an inode table is erroneously
          calculated
          - Running ext2resize results in failure due to an erroneous
            offset of an inode table, then I fix how to calculate it.

  [19/21] enlarge file size and filesystem size
          - With "-O large_block" option in mke2fs, the maximum size of
            a file is (blocksize) * (2^32-1) bytes, and of a filesystem
            is (pagesize) * (2^32-1).

  [20/21] change the type of variables manipulating a block or an inode
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

  [21/21] modify format strings in print
          - The part which prints the signed value, related to a block
            and an inode, in decimal is corrected so that it can print
            unsigned one.
