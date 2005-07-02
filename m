Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVGBWOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVGBWOc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVGBWOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:14:31 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:441 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261305AbVGBWJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 18:09:30 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 2 Jul 2005 23:09:22 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Daniel Drake <dsd@gentoo.org>
cc: =?UTF-8?B?RGF2aWQgR8OzbWV6?= <david@pleyades.net>,
       Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
In-Reply-To: <42C65A8B.9060705@gentoo.org>
Message-ID: <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
 <20050630193320.GA1136@fargo> <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
 <20050630204832.GA3854@fargo> <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
 <42C65A8B.9060705@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2 Jul 2005, Daniel Drake wrote:
> I'm trying to work around the NTFS lockup issue. Like others, I can reproduce
> it just by opening nautilus on an NTFS partition (i.e. creating an inotify
> watch on it) and then unmount at some point after - instant system lockup.
> 
> I have tried applying two patches:
> fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation.patch from 2.6.13-rc1-mm1
> and the "NTFS: Fix a nasty deadlock that appeared in recent kernels" patch
> from your git tree.
> 
> However, I still get the freezing up on unmount. I am using 2.6.12, plus
> inotify-0.23-15, and the two patches mentioned above. Anything else I can try?

Thinking about it some more made me realize that there may be a problem in 
inotify after all...  Could you try the below patch to fs/inotify.c and 
tell me if it cures the lockup you are seeing?  (Note patch compiles but 
is otherwise untested.  But given it locks up without the patch it can't 
do much worse with it!)

Thanks a lot in advance!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

inotify_unmount_inodes-list-iteration-fix.diff

Patch description: I believe that the inode reference that is being 
dropped by inotify's remove_watch() can cause inodes other than the 
current @inode to be moved away from the per-sb list.  And if this happens 
to be the next inode in the list, i.e. @next_i, then the iteration will 
proceed on the list that @next_i was moved to rather than the per-sb list.  
Thus, the check in the for loop (list_for_each_entry_safe()) for the @head 
being reached will _never_ be true and hence the for loop will keep going 
for ever...  Even worse the memory backing @next_i could be completely 
freed and then completely random results would be obtained.

Basically, I do not believe that using list_for_each_entry_safe() is safe 
at all as it only guards against removal of the current entry but not 
against removal of the next entry.  This patch tries to work around this 
by getting a reference to @next_i whilst the inode_lock is dropped.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

--- linux-2.6.13-rc1-mm1-vanilla/fs/inotify.c	2005-07-01 14:51:09.000000000 +0100
+++ linux-2.6.13-rc1-mm1/fs/inotify.c	2005-07-02 22:11:11.000000000 +0100
@@ -560,9 +560,10 @@ EXPORT_SYMBOL_GPL(inotify_get_cookie);
  */
 void inotify_unmount_inodes(struct list_head *list)
 {
-	struct inode *inode, *next_i;
+	struct inode *inode, *next_i, *need_iput = NULL;
 
 	list_for_each_entry_safe(inode, next_i, list, i_sb_list) {
+		struct inode *need_iput_tmp;
 		struct inotify_watch *watch, *next_w;
 		struct list_head *watches;
 
@@ -574,8 +575,20 @@ void inotify_unmount_inodes(struct list_
 		if (inode->i_state & (I_CLEAR | I_FREEING))
 			continue;
 
+		need_iput_tmp = need_iput;
+		need_iput = NULL;
+
 		/* In case the remove_watch() drops a reference */
-		__iget(inode);
+		if (inode != need_iput_tmp)
+			__iget(inode);
+		else
+			need_iput_tmp = NULL;
+
+		/* In case the dropping of a reference would nuke next_i. */
+		if (!next_i->i_state & (I_CLEAR | I_FREEING)) {
+			__iget(next_i);
+			need_iput = next_i;
+		}
 
 		/*
 		 * We can safely drop inode_lock here because the per-sb list
@@ -584,6 +597,9 @@ void inotify_unmount_inodes(struct list_
 		 */
 		spin_unlock(&inode_lock);
 
+		if (need_iput_tmp)
+			iput(need_iput_tmp);
+
 		/* for each watch, send IN_UNMOUNT and then remove it */
 		down(&inode->inotify_sem);
 		watches = &inode->inotify_watches;
@@ -599,6 +615,11 @@ void inotify_unmount_inodes(struct list_
 
 		spin_lock(&inode_lock);
 	}
+	if (need_iput) {
+		spin_unlock(&inode_lock);
+		iput(need_iput);
+		spin_lock(&inode_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(inotify_unmount_inodes);
 
