Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUJCHZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUJCHZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 03:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJCHZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 03:25:28 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:60109 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267743AbUJCHZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 03:25:23 -0400
Date: Sun, 3 Oct 2004 08:25:20 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>, Dino Klein <dinoklein@hotmail.com>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: PROBLEM: 2.6.9-rc3 Bug in NTFS  code
In-Reply-To: <Pine.LNX.4.60.0410030116580.24862@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410030818010.18461@hermes-1.csi.cam.ac.uk>
References: <BAY16-F38bigPasSmz600007d7b@hotmail.com>
 <Pine.LNX.4.60.0410030116580.24862@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2004, Anton Altaparmakov wrote:
> On Sat, 2 Oct 2004, Dino Klein wrote:
> > below is what I had in the logs when attempting to umount a readonly NTFS.
> [snip]
> 
> I suspect that this is caused by a bug I introduced in 2.1.18 release and 
> that I already fixed in my development tree.  I unfortunately completely 
> forgot that the code containing the bug was already in the mainstream 
> kernels so I didn't think of submitting the fix straight away.  )))-:

Ouch.  Having slept over it I awoke this morning with the realization that 
there is in fact another bug, which would definitely cause exactly the BUG 
check to trigger that Dino reported.  )-:  Sorry about that.  Just goes to 
show that when I was porting my code from libntfs to the kernel and 
thinking "wow, this is really too easy", I was actually missing the 
subtleties involved so I broke it.  )-:

Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

to apply the fix which is also shown below in diff style patch.  Thanks!

Dino, could you apply the below patch and just check that the bug goes 
away in case I have missed yet another problem...  I am pretty confident 
that this is it this time but you never know. (You can just add the lines 
"if (ni != base_ni) unmap_extent_mft_record(ni);" to fs/ntfs/attrib.c as 
shown in the patch.)  Thanks a lot in advance!

Note you also want the fix from my previous email as the two bugs/fixes 
are related...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2 +-
 fs/ntfs/ChangeLog                  |    4 ++++
 fs/ntfs/attrib.c                   |    4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/10/03 1.2034.1.1)
   NTFS: Fix another stupid bug in fs/ntfs/attrib.c::ntfs_external_attr_find()
         where we forgot to unmap the extent mft record when we had finished
         enumerating an attribute which caused a bug check to trigger when the
         VFS calls ->clear_inode.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-10-03 08:17:35 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-10-03 08:17:35 +01:00
@@ -278,7 +278,7 @@
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
 2.1.20:
-	- Fix a stupid bug introduced in 2.1.18 release.
+	- Fix two stupid bugs introduced in 2.1.18 release.
 2.1.19:
 	- Minor bugfix in handling of the default upcase table.
 	- Many internal cleanups and improvements.  Many thanks to Linus
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-03 08:17:35 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-03 08:17:35 +01:00
@@ -27,6 +27,10 @@
 	  where we did not clear ctx->al_entry but it was still set due to
 	  changes in ntfs_attr_lookup() and ntfs_external_attr_find() in
 	  particular.
+	- Fix another stupid bug in fs/ntfs/attrib.c::ntfs_external_attr_find()
+	  where we forgot to unmap the extent mft record when we had finished
+	  enumerating an attribute which caused a bug check to trigger when the
+	  VFS calls ->clear_inode.
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-10-03 08:17:35 +01:00
+++ b/fs/ntfs/attrib.c	2004-10-03 08:17:35 +01:00
@@ -1738,11 +1738,13 @@
 	 * correctly yet as we do not know what @ctx->attr will be set to by
 	 * the call to ntfs_attr_find() below.
 	 */
+	if (ni != base_ni)
+		unmap_extent_mft_record(ni);
 	ctx->mrec = ctx->base_mrec;
 	ctx->attr = (ATTR_RECORD*)((u8*)ctx->mrec +
 			le16_to_cpu(ctx->mrec->attrs_offset));
 	ctx->is_first = TRUE;
-	ctx->ntfs_ino = ctx->base_ntfs_ino;
+	ctx->ntfs_ino = base_ni;
 	ctx->base_ntfs_ino = NULL;
 	ctx->base_mrec = NULL;
 	ctx->base_attr = NULL;
