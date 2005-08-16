Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVHPP5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVHPP5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVHPP5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:57:33 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:27629 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030199AbVHPP5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:57:32 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.13-rc6 ntfs oops
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0508152125000.11229@hermes-1.csi.cam.ac.uk>
References: <4300B407.60409@ribosome.natur.cuni.cz>
	 <Pine.LNX.4.60.0508152125000.11229@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain; charset=UTF-8
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 16 Aug 2005 16:57:13 +0100
Message-Id: <1124207833.30476.19.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-08-15 at 21:50 +0100, Anton Altaparmakov wrote:
> On Mon, 15 Aug 2005, [ISO-8859-2] Martin MOKREJ© wrote:
> >   I was just copying some data from ntfs partition to xfs and I got the following:
> > Does someone need more info? Briefly, no SMP but HIGHMEm 4GB, i686 P4 machine, 32bit.
> 
> Yes, please.  Could you do (assuming your built kernel sources are in 
> /usr/src/linux-2.6.13-rc6):
> 
> cd /usr/src/linux-2.6.13-rc6/drivers/block
> 
> objdump -Sl ll_rw_blk.o | sed -e '0,/generic_make_request/d' |
> sed -e '350,$d' | bzip2 -9 - > lrw.bz2
> 
> And then email me the file lrw.bz2?  Thanks!

Thanks a lot for sending me the file!  It allowed me to find the bug in
less than 60 seconds.  (-8

You can apply the below patch to fix it.  I will be submitting to Linus
ASAP so it gets in before 2.6.13 is released.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

[PATCH] NTFS: Fix bug in mft record writing where we forgot to set the device in
      the buffers when mapping them after the VM had discarded them.
      Thanks to Martin MOKREJŠ for the bug report.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
---

 fs/ntfs/ChangeLog |    3 +++
 fs/ntfs/mft.c     |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

e74589ac250e463973361774a90fee2c9d71da02
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -174,6 +174,9 @@ ToDo/Notes:
 	  fact that the vfs and ntfs inodes are one struct in memory to find
 	  the ntfs inode in memory if present.  Also, the ntfs inode has its
 	  own locking so it does not matter if the vfs inode is locked.
+	- Fix bug in mft record writing where we forgot to set the device in
+	  the buffers when mapping them after the VM had discarded them
+	  Thanks to Martin MOKREJŠ for the bug report.
 
 2.1.22 - Many bug and race fixes and error handling improvements.
 
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -533,6 +533,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vo
 			LCN lcn;
 			unsigned int vcn_ofs;
 
+			bh->b_bdev = vol->sb->s_bdev;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = ((VCN)mft_no << vol->mft_record_size_bits) +
 					(block_start - m_start);
@@ -725,6 +726,7 @@ int write_mft_record_nolock(ntfs_inode *
 			LCN lcn;
 			unsigned int vcn_ofs;
 
+			bh->b_bdev = vol->sb->s_bdev;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = ((VCN)ni->mft_no << vol->mft_record_size_bits) +
 					(block_start - m_start);



