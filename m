Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265032AbUFHLnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbUFHLnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUFHLnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:43:10 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:23743 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265032AbUFHLnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:43:01 -0400
Date: Tue, 8 Jun 2004 12:42:59 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: [2.6.7-BK] NTFS 2.1.13 - Enable overwriting of resident files and
 housekeeping of system files.
Message-ID: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

The next NTFS release.  This one is a milestone in that it finally allows
people to overwrite resident, i.e. very small, files, too.  As a bonus we
also do all the necessary housekeeping of the NTFS system files to ensure
data integrity and hence ntfsfix is no longer needed to be run after
unmounting.  Thanks!

This will update the following files:

 Documentation/filesystems/ntfs.txt |   13
 fs/ntfs/ChangeLog                  |   65 +++
 fs/ntfs/Makefile                   |    4
 fs/ntfs/aops.c                     |   62 +--
 fs/ntfs/attrib.c                   |    4
 fs/ntfs/compress.c                 |    4
 fs/ntfs/inode.c                    |  117 +++++-
 fs/ntfs/mft.c                      |  682 ++++++++++++++++++++++++++++++++++++-
 fs/ntfs/mft.h                      |   54 ++
 fs/ntfs/super.c                    |  377 +++++++++++++++++---
 10 files changed, 1264 insertions(+), 118 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/05/28 1.1736)
   NTFS: Implement writing of mft records (fs/ntfs/mft.[hc]), which includes
         keeping the mft mirror in sync with the mft when mirrored mft records
         are written.  The functions are write_mft_record{,_nolock}().  The
         implementation is quite rudimentary for now with lots of things not
         implemented yet but I am not sure any of them can actually occur so
         I will wait for people to hit each one and only then implement it.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/05/28 1.1737)
   NTFS: Commit open system inodes at umount time.  This should make it
         virtually impossible for sync_mft_mirror_umount() to ever be needed.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/05/28 1.1738)
   NTFS: Implement ->write_inode (fs/ntfs/inode.c::ntfs_write_inode()) for the
         ntfs super operations.  This gives us inode writing via the VFS inode
         dirty code paths.  Note:  Access time updates are not implemented yet.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/06/01 1.1739)
   NTFS: - Implement fs/ntfs/mft.[hc]::{,__}mark_mft_record_dirty() and make
           fs/ntfs/aops.c::ntfs_writepage() and ntfs_commit_write() use it, thus
           finally enabling resident file overwrite!  (-8  This also includes a
           placeholder for ->writepage (ntfs_mft_writepage()), which for now
           just redirties the page and returns.  Also, at umount time, we for
           now throw away all mft data page cache pages after the last call to
           ntfs_commit_inode() in the hope that all inodes will have been
           written out by then and hence no dirty (meta)data will be lost.  We
           also check for this case and emit an error message telling the user
           to run chkdsk.
         - If the user is trying to enable (dir)atime updates, warn about the
           fact that we are disabling them.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/06/04 1.1743)
   NTFS: Use set_page_writeback()/end_page_writeback() in ntfs_writepage()
         resident attribute write code path as otherwise the radix-tree tag
         PAGECACHE_TAG_DIRTY remains set even though the page is clean.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/06/04 1.1744)
   NTFS: Implement ntfs_mft_writepage() so it now checks if any of the mft
         records in the page are dirty and if so redirties the page and
         returns.  Otherwise it just returns (after doing set_page_writeback(),
         unlock_page(), end_page_writeback() or the radix-tree tag
         PAGECACHE_TAG_DIRTY  remains set even though the page is clean), thus
         alowing the VM to do with the page as it pleases.  Also, at umount
         time, now only throw away dirty mft (meta)data pages if dirty inodes
         are present and ask the user to email us if they see this happening.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/06/07 1.1748)
   NTFS: Add functions ntfs_{clear,set}_volume_flags(), to modify the volume
         information flags (fs/ntfs/super.c).

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/06/08 1.1750)
   NTFS: 2.1.13 - Enable overwriting of resident files and housekeeping of system files.
   - Mark the volume dirty when (re)mounting read-write and mark it clean
     when unmounting or remounting read-only.  If any volume errors are
     found, the volume is left marked dirty to force chkdsk to run.
   - Add code to set the NT4 compatibility flag when (re)mounting
     read-write for newer NTFS versions but leave it commented out for now
     since we do not make any modifications that are NTFS 1.2 specific yet
     and since setting this flag breaks Captive-NTFS which is not nice.
     This code must be enabled once we start writing NTFS 1.2 specific
     changes otherwise Windows NTFS driver might crash / cause corruption.
   - Fix a silly bug that caused a deadlock in ntfs_mft_writepage().
     For inode 0, i.e. $MFT itself, we cannot use ilookup5() from
     there because the inode is already locked by the kernel
     (fs/fs-writeback.c::__sync_single_inode()) and ilookup5() waits
     until the inode is unlocked before returning it and it never gets
     unlocked because ntfs_mft_writepage() never returns.  )-:
     Fortunately, we have inode 0 pinned in icache for the duration
     of the mount so we can access it directly.

   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

For the benefit of non-BK users and to make code review easier, I am
sending each ChangeSet in a separate email as a diff -u style patch.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
