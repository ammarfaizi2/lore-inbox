Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268883AbUIXQPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbUIXQPC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268896AbUIXQOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:14:45 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:54656 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268883AbUIXQLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:11:36 -0400
Date: Fri, 24 Sep 2004 17:11:32 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups and a bugfix
Message-ID: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

This includes the (off-list) discussed NTFS sparse annotations, some other
cleanups and a fix for a bug found by the bitwise sparse annotations.  (-:

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

 Documentation/filesystems/ntfs.txt |    5 
 fs/ntfs/ChangeLog                  |   36 +
 fs/ntfs/Makefile                   |    4 
 fs/ntfs/attrib.c                   |    9 
 fs/ntfs/attrib.h                   |    4 
 fs/ntfs/collate.c                  |   20 
 fs/ntfs/collate.h                  |   12 
 fs/ntfs/compress.c                 |    8 
 fs/ntfs/dir.c                      |   62 -
 fs/ntfs/endian.h                   |   78 +-
 fs/ntfs/index.c                    |    4 
 fs/ntfs/inode.c                    |  148 +++-
 fs/ntfs/inode.h                    |    8 
 fs/ntfs/layout.h                   | 1216 ++++++++++++++++++-------------------
 fs/ntfs/logfile.c                  |    8 
 fs/ntfs/logfile.h                  |   68 +-
 fs/ntfs/mft.c                      |   12 
 fs/ntfs/mst.c                      |   23 
 fs/ntfs/ntfs.h                     |    2 
 fs/ntfs/quota.c                    |    2 
 fs/ntfs/super.c                    |   21 
 fs/ntfs/time.h                     |    6 
 fs/ntfs/types.h                    |   14 
 fs/ntfs/unistr.c                   |   12 
 fs/ntfs/upcase.c                   |    3 
 25 files changed, 961 insertions(+), 824 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/09/22 1.1947)
   NTFS: - Remove BKL use from ntfs_setattr() syncing up with the rest of the
           kernel.
         - Update ->setattr (fs/ntfs/inode.c::ntfs_setattr()) to refuse to
           change the uid, gid, and mode of an inode as we do not support NTFS
           ACLs yet.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/22 1.1948)
   NTFS: Get rid of the ugly transparent union in fs/ntfs/dir.c::ntfs_readdir()
         and ntfs_filldir() as per suggestion from Al Viro.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/22 1.1949)
   NTFS: Improve the previous transparent union removal.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/23 1.1951)
   NTFS: Change '\0' and L'\0' to simply 0 as per advice from Linus Torvalds.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/23 1.1952)
   NTFS: - Update ->truncate (fs/ntfs/inode.c::ntfs_truncate()) to check if the
           inode size has changed and to only output an error if so.
         - Rename fs/ntfs/attrib.h::attribute_value_length() to ntfs_attr_size().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/24 1.1952.1.1)
   NTFS: Begin of sparse annotations: new data types and endianness conversion.
   
   - Add le{16,32,64} as well as sle{16,32,64} data types to fs/ntfs/types.h.
   - Change ntfschar to be le16 instead of u16 in fs/ntfs/types.h.
   - Add le versions of VCN, LCN, and LSN called leVCN, leLCN, and leLSN,
     respectively, to fs/ntfs/types.h.
   - Update endianness conversion macros in fs/ntfs/endian.h to use the
     new types as appropriate.
   - Do proper type casting when using sle64_to_cpup() in fs/ntfs/dir.c
     and index.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/24 1.1952.1.2)
   NTFS: Continuing sparse annotations: finish data types and header files.
   
   - Add leMFT_REF data type to fs/ntfs/layout.h.
   - Update all NTFS header files with the new little endian data types.
     Affected files are fs/ntfs/layout.h, logfile.h, and time.h.
   - Do proper type casting when using ntfs_is_*_recordp() in
     fs/ntfs/logfile.c, mft.c, and super.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/24 1.1952.1.3)
   NTFS: Finish off sparse annotation.
   
   - Fix all the sparse bitwise warnings.  Had to change all the enums
     storing little endian values to #defines because we cannot set enums
     to be little endian so we had lots of bitwise warnings from sparse.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/24 1.1952.1.4)
   NTFS: 2.1.19 - Many cleanups, improvements, and a minor bug fix.
   
   - Fix bug found by the new sparse bitwise warnings where the default
     upcase table was defined as a pointer to wchar_t rather than ntfschar
     in fs/ntfs/ntfs.h and super.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/24 1.1956)
   NTFS: Fix a stupid bug where I forgot to actually do the attribute lookup
         and then went and used the looked up attribute...  Ooops.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

