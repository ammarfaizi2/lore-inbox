Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVJaOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVJaOXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJaOXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:23:04 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:15829 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932331AbVJaOXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:23:02 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:22:47 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-GIT] NTFS: Release 2.1.25.
Message-ID: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git

This is the next NTFS update containing more extended write support (and 
in fact pretty much completely rewritten file write support)!  This has 
been in -mm for a while and at least one person (other than me that is) 
tested it, found a bug which I fixed, and since then noone has reported 
any bugs with the code.  So I think it is definitely ready for a larger 
audience, i.e. the mainline kernel.  (-:

Please apply.  Thanks!  (Diffstat is at bottom of email.)

And people: please try it before Linus releases 2.6.15 and report back 
(especially if you find bugs but even a "it works" would be nice to hear 
from a few more people)...

The new features are:

Given an existing uncompressed and unencrypted file, you can use:

- write(2) to write to the file, including beyond the end of the
existing file, and the file will be extended appropriately.  Both
resident and non-resident files are supported.  Support for heavily
fragmented files still has some limitations but you will just get an
EOPNOTSUPP error if you hit one.  Everything will still be consistent on
the volume.  Sparse files can also be written to and holes will be
filled in appropriately.

- truncate(2) and ftruncate(2) to change the size of the file, inlcuding
using open(2) with O_TRUNC flag.  As with write(2) there still are some
limitations for heavily fragmented files, and as above, everything will
still be consistent on the volume if you hit an unsupported case.  Note, 
that no sparse regions are created yet as this requires directory 
operations to be implemented, too, which they are not yet.  This is not as 
bad as it sounds as the regions are allocated but not initialized at the 
time of the truncate call so it is still very fast.  Though a subsequent 
write then needs to initialize the space so may be slow...

What this means is that you can now run your favourite editor on an 
existing file, e.g. "vim /ntfs/somefile.txt" works fine and you can save 
your changes.  Also things like running OpenOffice and editing existing MS 
Office documents works.  Basically anything that does not need to create 
temporary files in the same directory as the document should work fine 
now.

Still not supported features are creation/deletion of files/directories
and mmap(2) based writes to sparse regions of files.  (The mmap(2)
support has not been modified since the last release, only the file
write(2) support was rewritten.)

Here is the diffstat for those who care...

 b/Documentation/filesystems/ntfs.txt |   42 
 b/fs/ntfs/ChangeLog                  |  117 +
 b/fs/ntfs/Makefile                   |    4 
 b/fs/ntfs/aops.c                     |  832 ------------
 b/fs/ntfs/attrib.c                   |  987 +++++++++++++--
 b/fs/ntfs/attrib.h                   |   10 
 b/fs/ntfs/file.c                     | 2289 ++++++++++++++++++++++++++++++++++-
 b/fs/ntfs/inode.c                    |  514 +++++++
 b/fs/ntfs/layout.h                   |   31 
 b/fs/ntfs/lcnalloc.c                 |   60 
 b/fs/ntfs/lcnalloc.h                 |   43 
 b/fs/ntfs/malloc.h                   |    3 
 b/fs/ntfs/mft.c                      |   26 
 b/fs/ntfs/super.c                    |    2 
 14 files changed, 3879 insertions(+), 1081 deletions(-)

I am sending the changesets as actual patches generated using git
format-patch for non-git users in follow up emails (in reply to this one).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
