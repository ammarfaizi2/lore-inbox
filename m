Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUJCS5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUJCS5U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJCS5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:57:20 -0400
Received: from bay16-f20.bay16.hotmail.com ([65.54.186.70]:27184 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S268084AbUJCS5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:57:02 -0400
X-Originating-IP: [64.81.213.196]
X-Originating-Email: [dinoklein@hotmail.com]
From: "Dino Klein" <dinoklein@hotmail.com>
To: aia21@cam.ac.uk, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: PROBLEM: 2.6.9-rc3 Bug in NTFS code
Date: Sun, 03 Oct 2004 14:56:20 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F20TUSzbAUfKR0000060b@hotmail.com>
X-OriginalArrivalTime: 03 Oct 2004 18:57:01.0237 (UTC) FILETIME=[C3FBA650:01C4A97A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

initially I applied only the second patch (since I didn't realize there were 
two different patches), and that fixed the umount problem.
afterwards I applied both, checked again, and there were no problems as 
well.

thanks.

>On Sun, 3 Oct 2004, Anton Altaparmakov wrote:
> > On Sat, 2 Oct 2004, Dino Klein wrote:
> > > below is what I had in the logs when attempting to umount a readonly 
>NTFS.
> > [snip]
> >
> > I suspect that this is caused by a bug I introduced in 2.1.18 release 
>and
> > that I already fixed in my development tree.  I unfortunately completely
> > forgot that the code containing the bug was already in the mainstream
> > kernels so I didn't think of submitting the fix straight away.  )))-:
>
>Ouch.  Having slept over it I awoke this morning with the realization that
>there is in fact another bug, which would definitely cause exactly the BUG
>check to trigger that Dino reported.  )-:  Sorry about that.  Just goes to
>show that when I was porting my code from libntfs to the kernel and
>thinking "wow, this is really too easy", I was actually missing the
>subtleties involved so I broke it.  )-:
>
>Linus, please do a
>
>	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6
>
>to apply the fix which is also shown below in diff style patch.  Thanks!
>
>Dino, could you apply the below patch and just check that the bug goes
>away in case I have missed yet another problem...  I am pretty confident
>that this is it this time but you never know. (You can just add the lines
>"if (ni != base_ni) unmap_extent_mft_record(ni);" to fs/ntfs/attrib.c as
>shown in the patch.)  Thanks a lot in advance!
>
>Note you also want the fix from my previous email as the two bugs/fixes
>are related...
>
>Best regards,
>
>	Anton
>--
>Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
>Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
>WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
>
>This will update the following files:
>
>  Documentation/filesystems/ntfs.txt |    2 +-
>  fs/ntfs/ChangeLog                  |    4 ++++
>  fs/ntfs/attrib.c                   |    4 +++-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
>through these ChangeSets:
>
><aia21@cantab.net> (04/10/03 1.2034.1.1)
>    NTFS: Fix another stupid bug in 
>fs/ntfs/attrib.c::ntfs_external_attr_find()
>          where we forgot to unmap the extent mft record when we had 
>finished
>          enumerating an attribute which caused a bug check to trigger when 
>the
>          VFS calls ->clear_inode.
>
>    Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
>
>===================================================================
>
>diff -Nru a/Documentation/filesystems/ntfs.txt 
>b/Documentation/filesystems/ntfs.txt
>--- a/Documentation/filesystems/ntfs.txt	2004-10-03 08:17:35 +01:00
>+++ b/Documentation/filesystems/ntfs.txt	2004-10-03 08:17:35 +01:00
>@@ -278,7 +278,7 @@
>  Note, a technical ChangeLog aimed at kernel hackers is in 
>fs/ntfs/ChangeLog.
>
>  2.1.20:
>-	- Fix a stupid bug introduced in 2.1.18 release.
>+	- Fix two stupid bugs introduced in 2.1.18 release.
>  2.1.19:
>  	- Minor bugfix in handling of the default upcase table.
>  	- Many internal cleanups and improvements.  Many thanks to Linus
>diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
>--- a/fs/ntfs/ChangeLog	2004-10-03 08:17:35 +01:00
>+++ b/fs/ntfs/ChangeLog	2004-10-03 08:17:35 +01:00
>@@ -27,6 +27,10 @@
>  	  where we did not clear ctx->al_entry but it was still set due to
>  	  changes in ntfs_attr_lookup() and ntfs_external_attr_find() in
>  	  particular.
>+	- Fix another stupid bug in fs/ntfs/attrib.c::ntfs_external_attr_find()
>+	  where we forgot to unmap the extent mft record when we had finished
>+	  enumerating an attribute which caused a bug check to trigger when the
>+	  VFS calls ->clear_inode.
>
>  2.1.19 - Many cleanups, improvements, and a minor bug fix.
>
>diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
>--- a/fs/ntfs/attrib.c	2004-10-03 08:17:35 +01:00
>+++ b/fs/ntfs/attrib.c	2004-10-03 08:17:35 +01:00
>@@ -1738,11 +1738,13 @@
>  	 * correctly yet as we do not know what @ctx->attr will be set to by
>  	 * the call to ntfs_attr_find() below.
>  	 */
>+	if (ni != base_ni)
>+		unmap_extent_mft_record(ni);
>  	ctx->mrec = ctx->base_mrec;
>  	ctx->attr = (ATTR_RECORD*)((u8*)ctx->mrec +
>  			le16_to_cpu(ctx->mrec->attrs_offset));
>  	ctx->is_first = TRUE;
>-	ctx->ntfs_ino = ctx->base_ntfs_ino;
>+	ctx->ntfs_ino = base_ni;
>  	ctx->base_ntfs_ino = NULL;
>  	ctx->base_mrec = NULL;
>  	ctx->base_attr = NULL;

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement

