Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVCIHTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVCIHTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 02:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVCIHTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 02:19:49 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:17861 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262058AbVCIHTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 02:19:23 -0500
Date: Tue, 8 Mar 2005 23:19:11 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>
Subject: --update-- Re: [CHECKER] crash after fsync causing serious FS
 corruptions (ext2, 2.6.11)
In-Reply-To: <20050308123109.GA7005@thunk.org>
Message-ID: <Pine.GSO.4.44.0503082304490.29715-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the mouth.)  It is *expected* behaviour, yes, and it is mitigated by
> two factors.  (1) Metadata for ext2 is synced out every 5 seconds,
> while data is synced out every 60, so the max window for this race
> described above is 5 seconds, and in practice rarely shows up if you
> are not using fsync.  (2) Unlike BSD's fsck, when a block is owned by
> two different files, we offer an option to clone the affected files so
> data isn't lost, while BSD's fsck shoots both files and asks questions
> later.

FiSC detects another related warning: a file's data are not what they
should be after fsync.  Turns out that e2fsck -y clears invalid indirect
blocks before it clones the shared blocks, causing file to lose data when
these invalid blocks are also shared blocks.  Considering the following
case:

file A has block 100 as indirect block on disk
file B has block 100 as data block, and user writes garbage to block 100,
then fsync(B).

Now clearing block 100 before cloning in e2fsck would cause file B to
loose its data block.  Possible fix would be to clone duplicate blocks
before clear invalid blocks?  Any thoughts?  Or user has to run e2fsck
twice in this case?

to reproduce the warning, get http://fisc.stanford.edu/bug5/crash.c. it
uses fixed mount point /mnt/sbd0.

e2fsck output:
e2fsck 1.36 (05-Feb-2005)
/dev/ide/host0/bus0/target0/lun0/part9 was not cleanly unmounted, check
forced.
Pass 1: Checking inodes, blocks, and sizes
Inode 12 has illegal block(s).  Clear? yes

Illegal block #-2 (2517328384) in inode 12.  CLEARED.
Inode 12, i_blocks is 24, should be 16.  Fix? yes

Duplicate blocks found... invoking duplicate block passes.
Pass 1B: Rescan for duplicate/bad blocks
Duplicate/bad block(s) in inode 12: 22 25 26 27
Duplicate/bad block(s) in inode 13: 22
Duplicate/bad block(s) in inode 16: 25 26 27
Pass 1C: Scan directories for inodes with dup blocks.
Pass 1D: Reconciling duplicate blocks
(There are 3 inodes containing duplicate/bad blocks.)

File ... (inode #12, mod time Tue Mar  8 21:32:38 2005)
  has 4 duplicate block(s), shared with 2 file(s):
	... (inode #16, mod time Tue Mar  8 21:32:40 2005)
	... (inode #13, mod time Tue Mar  8 21:32:39 2005)
Clone duplicate/bad blocks? yes

File ... (inode #13, mod time Tue Mar  8 21:32:39 2005)
  has 1 duplicate block(s), shared with 1 file(s):
	... (inode #12, mod time Tue Mar  8 21:32:38 2005)
Duplicated blocks already reassigned or cloned.

File ... (inode #16, mod time Tue Mar  8 21:32:40 2005)
  has 3 duplicate block(s), shared with 1 file(s):
	... (inode #12, mod time Tue Mar  8 21:32:38 2005)
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

Unattached inode 16
Connect to /lost+found? yes

Inode 16 ref count is 2, should be 1.  Fix? yes

Pass 5: Checking group summary information
Free blocks count wrong for group #0 (28, counted=24).
Fix? yes

Free blocks count wrong (28, counted=24).
Fix? yes

Inode bitmap differences:  -(14--15)
Fix? yes

Free inodes count wrong for group #0 (0, counted=2).
Fix? yes

Directories count wrong for group #0 (4, counted=2).
Fix? yes

Free inodes count wrong (0, counted=2).
Fix? yes

-Junfeng


