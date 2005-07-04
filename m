Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVGDO17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVGDO17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVGDO17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:27:59 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:19101 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261207AbVGDO1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 10:27:32 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Problem with inotify
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>,
       Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42C7BF37.9010005@gentoo.org>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
	 <20050630193320.GA1136@fargo>
	 <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
	 <20050630204832.GA3854@fargo>
	 <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
	 <42C65A8B.9060705@gentoo.org>
	 <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
	 <42C72563.7040103@gentoo.org>
	 <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
	 <42C7BF37.9010005@gentoo.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 04 Jul 2005 15:27:21 +0100
Message-Id: <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-03 at 11:34 +0100, Daniel Drake wrote:
> I reverted the patch you sent earlier
> (inotify_unmount_inodes-list-iteration-fix.diff) and applied the one you
> attached here (inotify_unmount_inodes-list-iteration-fix2.diff).
> 
> The good news is that the hang is gone. The bad news is that you cured the
> hang by introducing an oops :(

)-:  I have addressed the only things I can think off that could cause
the oops and below is the resulting patch.  Could you please test it?

Thanks a lot!

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- linux-2.6.13-rc1-mm1-vanilla/fs/inotify.c	2005-07-01 14:51:09.000000000 +0100
+++ linux-2.6.13-rc1-mm1/fs/inotify.c	2005-07-04 15:18:14.000000000 +0100
@@ -560,22 +560,45 @@ EXPORT_SYMBOL_GPL(inotify_get_cookie);
  */
 void inotify_unmount_inodes(struct list_head *list)
 {
-	struct inode *inode, *next_i;
+	struct inode *inode, *next_i, *need_iput = NULL;
 
 	list_for_each_entry_safe(inode, next_i, list, i_sb_list) {
+		struct inode *need_iput_tmp;
 		struct inotify_watch *watch, *next_w;
 		struct list_head *watches;
 
 		/*
+		 * If i_count is zero, the inode cannot have any watches and
+		 * doing an __iget/iput with MS_ACTIVE clear would actually
+		 * evict all inodes from icache which is unnecessarily violent.
+		 */
+		if (!atomic_read(&inode->i_count))
+			continue;
+		/*
 		 * We cannot __iget() an inode in state I_CLEAR or I_FREEING,
 		 * which is fine becayse by that point the inode cannot have
 		 * any associated watches.
 		 */
-		if (inode->i_state & (I_CLEAR | I_FREEING))
+		if (inode->i_state & (I_CLEAR | I_FREEING | I_WILL_FREE))
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
+		if ((&next_i->i_sb_list != list) &&
+				atomic_read(&next_i->i_count) &&
+				!(next_i->i_state & (I_CLEAR | I_FREEING |
+				I_WILL_FREE))) {
+			__iget(next_i);
+			need_iput = next_i;
+		}
 
 		/*
 		 * We can safely drop inode_lock here because the per-sb list
@@ -584,6 +607,9 @@ void inotify_unmount_inodes(struct list_
 		 */
 		spin_unlock(&inode_lock);
 
+		if (need_iput_tmp)
+			iput(need_iput_tmp);
+
 		/* for each watch, send IN_UNMOUNT and then remove it */
 		down(&inode->inotify_sem);
 		watches = &inode->inotify_watches;


