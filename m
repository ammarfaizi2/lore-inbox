Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVCGJ5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVCGJ5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCGJ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:57:22 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:58580 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261729AbVCGJ5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:57:12 -0500
Date: Mon, 7 Mar 2005 01:57:10 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devl@stanford.edu>
Subject: [CHECKER] crash after fsync causing serious FS corruptions (ext2,
 2.6.11)
Message-ID: <Pine.GSO.4.44.0503070124460.29202-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

FiSC (our FS checker) issues a warning on ext2, complaining that crash
after fsync causes file system to corrupt.  FS corrupts in two different
ways: 1. file contains illegal blocks (such as block # -2) 2. one block
owned by two different files.

I diagnosed the warning a little bit and it appears that this warning can
be triggered by the following steps:

1. a file is truncated, so several blocks are freed
2. a new file is created, and the blocks freed in step 1 are reused
3. fsync on the new file
4. crash and run fsck to recover.

fsync should guarantee that a specific file is persistent on disk.
Presumably, operations on other files should not mess up with the file we
just fsync (true ?)  However, I also understand that ext2 by default
relies on e2fsck to provide file system consistency.  Do you guys consider
the above warning as a bug or not?  Any clarification on this will be very
helpful.

To reproduce the warning, please download the test case at
http://fisc.stanford.edu/bug3/crash.tar.bz2, untar, compile and run the
executable ./crash <disk partition> <mount point> This test case is
semi-automatically generated.  It may contain more than enough FS
operations to trigger the warning.  **NOTE**: it'll run mke2fs on <disk
partition> and reboot your machine!

e2fsck output:
e2fsck 1.36 (05-Feb-2005)
/dev/ide/host0/bus0/target0/lun0/part9 was not cleanly unmounted, check
forced.
Pass 1: Checking inodes, blocks, and sizes
Inode 12 has illegal block(s).  Clear? yes

Illegal block #-2 (2305145833) in inode 12.  CLEARED.
Inode 12, i_blocks is 24, should be 16.  Fix? yes

Duplicate blocks found... invoking duplicate block passes.
Pass 1B: Rescan for duplicate/bad blocks
Duplicate/bad block(s) in inode 12: 24
Duplicate/bad block(s) in inode 13: 24
Pass 1C: Scan directories for inodes with dup blocks.
Pass 1D: Reconciling duplicate blocks
(There are 2 inodes containing duplicate/bad blocks.)

File ... (inode #12, mod time Mon Mar  7 01:27:12 2005)
  has 1 duplicate block(s), shared with 1 file(s):
  ... (inode #13, mod time Mon Mar  7 01:27:14 2005)
Clone duplicate/bad blocks? yes

File ... (inode #13, mod time Mon Mar  7 01:27:14 2005)
  has 1 duplicate block(s), shared with 1 file(s):
     ... (inode #12, mod time Mon Mar  7 01:27:12 2005)
Duplicated blocks already reassigned or cloned.

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Unattached inode 12
Connect to /lost+found? yes

Inode 12 ref count is 2, should be 1.  Fix? yes

Unattached inode 13
Connect to /lost+found? yes

Inode 13 ref count is 2, should be 1.  Fix? yes

Pass 5: Checking group summary information
Block bitmap differences:  +(21--22) +(29--31)
Fix? yes

Free blocks count wrong for group #0 (37, counted=31).
Fix? yes

Free blocks count wrong (37, counted=31).
Fix? yes


/dev/ide/host0/bus0/target0/lun0/part9: ***** FILE SYSTEM WAS MODIFIED
*****
/dev/ide/host0/bus0/target0/lun0/part9: 13/16 files (7.7% non-contiguous),
29/60 blocks
running cmd "sudo mount -t ext2 /dev/ide/host0/bus0/target0/lun0/part9
/mnt/sbd1

-Junfeng

