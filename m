Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263876AbUEGXkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUEGXkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 19:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUEGXkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 19:40:14 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:47353 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263876AbUEGXj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 19:39:59 -0400
Date: Fri, 7 May 2004 22:25:23 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [2.6.6-rc3-bk] NTFS: 2.1.8 release - Improving on data safety.
Message-ID: <Pine.SOL.4.58.0405072219100.9227@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.6

Thanks!  This is the next NTFS release 2.1.8.  It goes a long way towards
ensuring the safety of people's data by refusing read-write mounts when
the inode mirror or the journal are dirty and by emptying the journal when
it is clean so Windows cannot cause data corruption by replaying a stale
journal.  Also, the new nano-second kernel time precision is used to
improve on the NTFS <-> Linux time conversion functions.  The detailed
ChangeLog is in the descriptions of the ChangeSets below.

Note the patch is rather large because of a lot of white space cleanups
that happened while editing (removal of trailing spaces and conversion of
spaces to tabs).

This is tested with NTFS volumes with clean and dirty journals created by
Win2k and XP and I am quite confident it will work with NT4 and Win2003
and later.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/ntfs/time.c                     |   82 ----
 Documentation/filesystems/ntfs.txt |   13
 fs/ntfs/ChangeLog                  |   46 ++
 fs/ntfs/Makefile                   |   18
 fs/ntfs/aops.c                     |   46 +-
 fs/ntfs/attrib.c                   |   39 +
 fs/ntfs/compress.c                 |   18
 fs/ntfs/dir.c                      |   98 ++--
 fs/ntfs/inode.c                    |   85 ----
 fs/ntfs/inode.h                    |   53 ++
 fs/ntfs/layout.h                   |  385 ++++++++++---------
 fs/ntfs/logfile.c                  |  737 +++++++++++++++++++++++++++++++++++++
 fs/ntfs/logfile.h                  |  305 +++++++++++++++
 fs/ntfs/malloc.h                   |   11
 fs/ntfs/mft.h                      |   15
 fs/ntfs/mst.c                      |   56 +-
 fs/ntfs/ntfs.h                     |   22 -
 fs/ntfs/super.c                    |  520 ++++++++++++++++++++------
 fs/ntfs/time.h                     |  100 +++++
 fs/ntfs/types.h                    |   32 -
 fs/ntfs/volume.h                   |   26 -
 21 files changed, 2070 insertions(+), 637 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/04/24 1.1371.748.5)
   NTFS: Use get_bh() instead of manual atomic_inc() in fs/ntfs/compress.c.

<aia21@cantab.net> (04/04/24 1.1371.748.6)
   NTFS: - Modify fs/ntfs/time.c::ntfs2utc(), get_current_ntfs_time(), and
           utc2ntfs() to work with struct timespec instead of time_t on the
           Linux UTC time side thus preserving the full precision of the NTFS
           time and only loosing up to 99 nano-seconds in the Linux UTC time.
         - Move fs/ntfs/time.c to fs/ntfs/time.h and make the time functions
           static inline.

<aia21@cantab.net> (04/04/25 1.1371.748.7)
   NTFS: - Remove unused ntfs_dirty_inode().
         - Cleanup super operations declaration.

<aia21@cantab.net> (04/04/25 1.1371.748.8)
   NTFS: Wrap flush_dcache_mft_record_page() in #ifdef NTFS_RW.

<aia21@cantab.net> (04/04/25 1.1371.748.9)
   NTFS: Add NInoTestSetFoo() and NInoTestClearFoo() macro magic to
         fs/ntfs/inode.h and use it to declare NInoTest{Set,Clear}Dirty.

<aia21@cantab.net> (04/04/25 1.1371.748.10)
   NTFS: Move typedefs for ntfs_attr and test_t from fs/ntfs/inode.c to
         fs/ntfs/inode.h so they can be used elsewhere.

<aia21@cantab.net> (04/04/25 1.1371.748.11)
   NTFS: Determine the mft mirror size as the number of mirrored mft records
         and store it in ntfs_volume->mftmirr_size (fs/ntfs/super.c).

<aia21@cantab.net> (04/04/27 1.1525.1.3)
   NTFS: Load the mft mirror at mount time and compare the mft records
         stored in it to the ones in the mft (fs/ntfs/super.c).

<aia21@cantab.net> (04/04/28 1.1589)
   NTFS: - Fix compiler warnings related to type casting.
         - Move %L to %ll as %L is floating point and %ll is integer which
           is what we want.
         - Add logfile inode to ntfs_volume structure and the code to clean
           it up in super.c.

<aia21@cantab.net> (04/05/07 1.1594)
   NTFS: Read the journal ($LogFile) and determine if the volume has been
   	 shutdown cleanly and force a read-only mount if not (fs/ntfs/super.c
	 and fs/ntfs/logfile.c).  This is a little bit of a crude check in
	 that we only look at the restart areas and not at the actual log
	 records so that there will be a very small number of cases where we
	 think that a volume is dirty when in fact it is clean.  This should
	 only affect volumes that have not been shutdown cleanly and did not
	 have any pending, non-check-pointed i/o.

<aia21@cantab.net> (04/05/07 1.1595)
   NTFS:  Eeek.  Forgot to revert the Makefile before checking it in last time...

<aia21@cantab.net> (04/05/07 1.1597)
   NTFS: 2.1.8 release - If the $LogFile indicates a clean shutdown and a
         read-write (re)mount is requested, empty $LogFile by overwriting it
         with 0xff bytes to ensure that Windows cannot cause data corruption
         by replaying a stale journal after Linux has written to the volume.

===================================================================

This is the simple GNU diff -urNp for non-BK users:

I am not including the patch as it is far too big (165kiB) but you can
find it here if you want it:

	http://www-uxsup.csx.cam.ac.uk/~aia21/linux/

The file is linux-2.6.6-rc3-bk-ntfs-2.1.8.diff or if you prefer a smaller
file, linux-2.6.6-rc3-bk-ntfs-2.1.8.diff.bz2.
