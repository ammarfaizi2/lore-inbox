Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUIVMO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUIVMO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUIVMO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:14:28 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:46539 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264704AbUIVMOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:14:23 -0400
Date: Wed, 22 Sep 2004 13:14:20 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-BK-URL] NTFS 2.1.18 release
Message-ID: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

This update includes Ingo's scheduling latency fix and an endianness fix.  
The rest is really just cleanup.  The update is of course tested and 
working.

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

 Documentation/filesystems/ntfs.txt |    4 
 fs/ntfs/ChangeLog                  |   37 +++
 fs/ntfs/Makefile                   |    4 
 fs/ntfs/aops.c                     |   57 ++--
 fs/ntfs/attrib.c                   |  425 +++++++++++++++++++++----------------
 fs/ntfs/attrib.h                   |   26 --
 fs/ntfs/debug.c                    |    2 
 fs/ntfs/dir.c                      |   75 +++---
 fs/ntfs/index.c                    |   32 +-
 fs/ntfs/index.h                    |    2 
 fs/ntfs/inode.c                    |  264 +++++++++++++---------
 fs/ntfs/mft.c                      |    3 
 fs/ntfs/namei.c                    |   48 ++--
 fs/ntfs/super.c                    |   60 ++---
 fs/ntfs/volume.h                   |    3 
 15 files changed, 614 insertions(+), 428 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/08/27 1.1832.26.1)
   NTFS: Remove vol->nr_mft_records as it was pretty meaningless and optimize
         the calculation of total/free inodes as used by statfs().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/14 1.1864.1.2)
   NTFS: Fix scheduling latencies in ntfs_fill_super() by dropping the BKL
         because the code itself is using the ntfs_lock semaphore which
         provides safe locking.  (Ingo Molnar)
   
   Signed-off-by: Ingo Molnar <mingo@elte.hu>
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/16 1.1867.9.2)
   NTFS: Fix a potential bug in fs/ntfs/mft.c::map_extent_mft_record() that
         could occur in the future for when we start closing/freeing extent
         inodes if we don't set base_ni->ext.extent_ntfs_inos to NULL after
         we free it.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/21 1.1941)
   NTFS: Rename {find,lookup}_attr() to ntfs_attr_{find,lookup}() as well as
         find_external_attr() to ntfs_external_attr_find() to cleanup the
         namespace a bit and to be more consistent with libntfs.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/21 1.1942)
   NTFS: Rename {{re,}init,get,put}_attr_search_ctx() to
         ntfs_attr_{{re,}init,get,put}_search_ctx() as well as the type
         attr_search_context to ntfs_attr_search_ctx.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/21 1.1942.1.1)
   NTFS: - Fix endianness bug in ntfs_external_attr_find().
         - Change ntfs_{external_,}attr_find() to return 0 on success, -ENOENT
   	if the attribute is not found, and -EIO on real error.  In the case
   	of -ENOENT, the search context is updated to describe the attribute
   	before which the attribute being searched for would need to be
   	inserted if such an action were to be desired and in the case of
   	ntfs_external_attr_find() the search context is also updated to
   	indicate the attribute list entry before which the attribute list
   	entry of the attribute being searched for would need to be inserted
   	if such an action were to be desired.  Also make ntfs_find_attr()
   	static and remove its prototype from attrib.h as it is not used
   	anywhere other than attrib.c.  Update ntfs_attr_lookup() and all
   	callers of ntfs_{external,}attr_{find,lookup}() for the new return
   	values.
         - Force use of ntfs_attr_find() in ntfs_attr_lookup() when searching
   	for the attribute list attribute itself.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/22 1.1942.1.2)
   NTFS: 2.1.18 release
   
   - Minor cleanup of fs/ntfs/inode.c::ntfs_init_locked_inode().
   - Bump version number and update Documentation/filesystems/ntfs.txt
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

