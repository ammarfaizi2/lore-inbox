Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUELA5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUELA5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUELA5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:57:38 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:4301 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S265000AbUELAze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:55:34 -0400
Date: Tue, 11 May 2004 17:55:30 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>,
       <madan@cs.Stanford.EDU>, "David L. Dill" <dill@cs.Stanford.EDU>
Subject: [CHECKER] e2fsck writes out blocks out of order, causing root dir
 to be corrupted (ext3, linux 2.4.19, e2fsprogs 1.34)
Message-ID: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We got a warning that the filesystem was in a inconsistent state when:
1. created a crashed disk image
2. ran fsck over the image and then crash fsck at certain point
3. re-ran fsck.

We got the crashed disk image by making 2 directories under / then runing
kjournald to commit.  once we saw the commit block was written to disk, we
crashed the experimental disk (a virtual ram disk), prior to actual disk
writes.

We then ran fsck over the crashed disk image.  We interrupted fsck after
 the journal super block was reset on disk (fsck will reset the journal
superblock once it is done replaying).  We ran fsck again on the half-done
disk image (half-done because some block writes were cached by fsck).
e2fsck complained that the two directories we created are unconnected and
linked them into lost+found.  It also fixed the datablock for the root /.

After we investigated the message, it seems that e2fsck does cache writes
(unix_io.c).  Actual raw block device writes can happen when 1. a dirty
block is kicked out of the cache 2. the cache is flushed.  Neither of
these pay attention to the journaling constraints of EXT3 and JBD.

In our case, after journal recovering, the journal super block hits the
disk before the root dir block hits the disk.  If fsck is interrupted
(e.g. power outage) after the journal super block and the first few
sectors of the root dir block are written, we could be in an irrecoverable
state with a corrupted root dir block.  (Worse things could happen if
blocks can be written out in arbitrary order)

We checked ext3 on linux 2.4.19, with e2fsprogs-1.34.  The crashed disk
image can be obtained from http://keeda.stanford.edu/~junfeng/exp_disk.tgz

As usual, clarifications/confirmations are appreciated.  Let me know if
anything is not clear.

Thanks,
-Junfeng

------------------------------------------------------------------------------
Below is the commented messages collected from runing e2fsck without
interruption.  We print out a debug message when unix_write_blk,
flush_cached_blocks, reuse_cache, raw_blk_write are called.  reuse_cache
does the cache eviction.  Comments are in brackets.

e2fsck 1.34 (25-Jul-2003)
FSCK: unix_write_blk block 268   [268 = journal super block]
FSCK: cache hit for block 268
/dev/shm/junfeng/exp_disk: recovering journal
FSCK: unix_write_blk block 4
FSCK: unix_write_blk block 2
FSCK: cache evict block 268
FSCK: raw_write_blk 268
FSCK: unix_write_blk block 1
FSCK: unix_write_blk block 6
FSCK: unix_write_blk block 3
FSCK: cache evict block 4
FSCK: raw_write_blk 4	         [4 = inode bitmap]
FSCK: unix_write_blk block 1298
FSCK: cache evict block 2
FSCK: raw_write_blk 2		 [2 = group descriptor]
FSCK: unix_write_blk block 5
FSCK: cache evict block 1
FSCK: raw_write_blk 1		 [1 = super block]
FSCK: unix_write_blk block 255 	 [255 = first block for root /]
FSCK: cache evict block 6
FSCK: raw_write_blk 6		 [write inodes for the two new dirs]
FSCK: unix_write_blk block 1299
FSCK: cache evict block 3
FSCK: raw_write_blk 3		 [3 = block bitmap]
FSCK: unix_write_blk block 268
FSCK: cache evict block 1298
FSCK: raw_write_blk 1298
FSCK: cache flush block 1299
FSCK: raw_write_blk 1299
FSCK: cache flush block 268
FSCK: raw_write_blk 268		  [log is reset by this write]
FSCK: cache flush block 255 	  [if crash here, bad!]
FSCK: raw_write_blk 255		  [write out root block after journal is reset]
FSCK: cache flush block 5
FSCK: raw_write_blk 5		  [write root inode]
FSCK: unix_write_blk block 2
FSCK: cache flush block 2
FSCK: raw_write_blk 2
FSCK: unix_write_blk block 268
FSCK: cache hit for block 268
Pass 1: Checking inodes, blocks, and sizes
FSCK: cache flush block 268
FSCK: raw_write_blk 268
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/shm/junfeng/exp_disk: 13/2000 files (0.0% non-contiguous), 1300/8000 blocks
FSCK: unix_write_blk block 2
FSCK: cache flush block 2
FSCK: raw_write_blk 2

------------------------------------------------------------------------------
Here are the details of how to get the crashed disk image:

1. Call sys_create to create a directory '1' under /. The filesystem looks like
[0:D]
  [1:D]

2. journal->j_commit_timer times out.

3. Call sys_create to create another directory '2'.
[0:D]
  [1:D]
  [2:D]

4. kjournald starts to run.  once we see the commit block is written to
disk, we crash the experimental disk

