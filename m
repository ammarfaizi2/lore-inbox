Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbUKJNou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbUKJNou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKJNot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:44:49 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:24264 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261838AbUKJNoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:09 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-BK-URL] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsk5-0006JQ-KD@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:42:33 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Hi Andrew, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

This fixes lots of bugs and races and improves error handling and in
particular handling of volumes with errors.  This fixes all known bugs
with the ntfs driver.

Please apply.  Thanks!

For the benefit of non-BK users and to make code review easier, I am
sending each ChangeSet in a separate email as a diff -u style patch.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/Locking  |    4 
 Documentation/filesystems/ntfs.txt |    7 
 fs/ntfs/ChangeLog                  |   88 +++
 fs/ntfs/Makefile                   |    4 
 fs/ntfs/aops.c                     |  899 +++++++++++++++++++++----------------
 fs/ntfs/aops.h                     |    7 
 fs/ntfs/attrib.c                   |  153 +++++-
 fs/ntfs/attrib.h                   |    8 
 fs/ntfs/debug.c                    |   19 
 fs/ntfs/dir.c                      |   48 +
 fs/ntfs/file.c                     |    2 
 fs/ntfs/index.c                    |   22 
 fs/ntfs/inode.c                    |  326 +++++++------
 fs/ntfs/inode.h                    |    5 
 fs/ntfs/layout.h                   |    4 
 fs/ntfs/lcnalloc.c                 |    2 
 fs/ntfs/mft.c                      |  183 +++++--
 fs/ntfs/namei.c                    |   22 
 fs/ntfs/ntfs.h                     |    3 
 fs/ntfs/quota.c                    |    5 
 fs/ntfs/runlist.c                  |   24 
 fs/ntfs/super.c                    |   43 +
 22 files changed, 1206 insertions(+), 672 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/10/20 1.2000.1.12)
   NTFS: Fix two typos in Documentation/filesystems/ntfs.txt.
   
   Thanks to Richard Russon for pointing them out.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/21 1.2000.1.13)
   NTFS: Improve error handling in fs/ntfs/inode.c::ntfs_truncate().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/25 1.2026.1.19)
   NTFS: Add fs/ntfs/aops.c to list of providers for ->b_end_io method in
         Documentation/filesystems/Locking.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/25 1.2026.1.20)
   NTFS: - Change fs/ntfs/inode.c::ntfs_truncate() to return an error code
           instead of void and provide a helper ntfs_truncate_vfs() for the
           vfs ->truncate method.
         - Add a new ntfs inode flag NInoTruncateFailed() and modify
           fs/ntfs/inode.c::ntfs_truncate() to set and clear it appropriately.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/25 1.2026.1.21)
   NTFS: Fix min_size and max_size definitions in ATTR_DEF structure in
         fs/ntfs/layout.h to be signed.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/25 1.2026.1.22)
   NTFS: Add attribute definition handling helpers to fs/ntfs/attrib.[hc]:
         ntfs_attr_size_bounds_check(), ntfs_attr_can_be_non_resident(), and
         ntfs_attr_can_be_resident(), which in turn use the new private helper
         ntfs_attr_find_in_attrdef().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/25 1.2026.1.23)
   NTFS: In fs/ntfs/aops.c::mark_ntfs_record_dirty(), take the
         mapping->private_lock around the dirtying of the buffer heads
         analagous to the way it is done in __set_page_dirty_buffers().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/27 1.2026.1.31)
   NTFS: Ensure the mft record size does not exceed the PAGE_CACHE_SIZE at
         mount time as this cannot work with the current implementation.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/27 1.2026.1.32)
   NTFS: Check for location of attribute name and improve error handling in
         general in fs/ntfs/inode.c::ntfs_read_locked_inode() and friends.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/28 1.2026.1.35)
   NTFS: In fs/ntfs/aops.c::ntfs_writepage(), if t he page is fully outside
         i_size, i.e. race with truncate, invalidate the buffers on the page
         so that they become freeable and hence the page does not leak.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/28 1.2026.1.36)
   NTFS: Implement extension of resident files in the regular file write code
         paths (fs/ntfs/aops.c::ntfs_{prepare,commit}_write()).  At present
         this only works until the data attribute becomes too big for the mft
         record after which we abort the write returning -EOPNOTSUPP from
         ntfs_prepare_write().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/29 1.2026.37.1)
   NTFS: Remove unused function fs/ntfs/runlist.c::ntfs_rl_merge().  (Adrian Bunk)
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/01 1.2026.48.1)
   NTFS: Fix stupid bug in fs/ntfs/attrib.c::ntfs_attr_find() that resulted in
         a NULL pointer dereference in the error code path when a corrupt
         attribute was found.
   
   Thanks to Domen Puncer for the bug report.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/01 1.2026.1.44)
   NTFS: Add MODULE_VERSION() to fs/ntfs/super.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/01 1.2026.53.1)
   NTFS: Make several functions and variables static.  (Adrian Bunk)
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/03 1.2026.1.50)
   NTFS: Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() so it allocates
         buffers for the page if they are not present and then marks the
         buffers belonging to the ntfs record dirty.  This causes the buffers
         to become busy and hence they are safe from removal until the page
         has been written out.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/04 1.2026.1.52)
   NTFS: Fix stupid bug in fs/ntfs/attrib.c::ntfs_external_attr_find() in the
         error handling code path that resulted in a BUG() due to trying to
         unmap an extent mft record when the mapping of it had failed and it
         thus was not mapped.  (Thanks to Ken MacFerrin for the bug report.)
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/04 1.2026.1.53)
   NTFS: Drop the runlist lock after the vcn has been read in
         fs/ntfs/lcnalloc.c::__ntfs_cluster_free().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/05 1.2026.1.54)
   NTFS: Rewrite handling of multi sector transfer errors.  We now do not set
         PageError() when such errors are detected in the async i/o handler           fs/ntfs/aops.c::ntfs_end_buffer_async_read().  All users of mst           protected attributes now check the magic of each ntfs record as they           use it and act appropriately.  This has the effect of making errors
         granular per ntfs record rather than per page which solves the case
         where we cannot access any of the ntfs records in a page when a
         single one of them had an mst error.  (Thanks to Ken MacFerrin for
         the bug report.)
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/05 1.2026.1.55)
   NTFS: Fix error handling in fs/ntfs/quota.c::ntfs_mark_quotas_out_of_date()
         where we failed to release i_sem on the $Quota/$Q attribute inode.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/05 1.2026.1.56)
   NTFS: Fix bug in handling of bad inodes in fs/ntfs/namei.c::ntfs_lookup().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/05 1.2026.1.57)
   NTFS: Minor cleanup of fs/ntfs/debug.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/09 1.2026.1.63)
   NTFS: - Add mapping of unmapped buffers to all remaining code paths, i.e.
           fs/ntfs/aops.c::ntfs_write_mst_block(), mft.c::ntfs_sync_mft_mirror(),
           and write_mft_record_nolock().  From now on we require that the
           complete runlist for the mft mirror is always mapped into memory.
         - Add creation of buffers to fs/ntfs/mft.c::ntfs_sync_mft_mirror().
         - Do not check for the page being uptodate in mark_ntfs_record_dirty()
           as we now call this after marking the page not uptodate during mft
           mirror synchronisation (fs/ntfs/mft.c::ntfs_sync_mft_mirror()).
         - Improve error handling in fs/ntfs/aops.c::ntfs_{read,write}_block().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/09 1.2026.1.64)
   NTFS: - Fix creation of buffers in fs/ntfs/mft.c::ntfs_sync_mft_mirror().
           Cannot just call fs/ntfs/aops.c::mark_ntfs_record_dirty() since
           this also marks the page dirty so we create the buffers by hand
           and set them uptodate.
         - Revert the removal of the page uptodate check from
           fs/ntfs/aops.c::mark_ntfs_record_dirty() as it is no longer called
           from fs/ntfs/mft.c::ntfs_sync_mft_mirror().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/09 1.2026.1.65)
   NTFS: Disable the file size changing code from
         fs/ntfs/aops.c::ntfs_prepare_write() for now as it is not safe.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/11/10 1.2026.1.66)
   NTFS: 2.1.22 - Many bug and race fixes and error handling improvements.
   
   - Cleanup fs/ntfs/aops.c::ntfs_{read,write}page() since we know that a
     resident attribute will be smaller than a page which makes the code
     simpler.  Also make the code more tolerant to concurrent ->truncate.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

