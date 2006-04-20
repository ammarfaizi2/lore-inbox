Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWDTMYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWDTMYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWDTMYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:24:35 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:56786 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750838AbWDTMYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:24:34 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 20 Apr 2006 13:24:20 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: A missing i_mutex in rename? (Linux kernel 2.6.latest)
In-Reply-To: <20060420105929.GV27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0604201312030.19187@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0604191102260.17373@hermes-1.csi.cam.ac.uk>
 <20060419121826.GI24104@parisc-linux.org> <Pine.LNX.4.64.0604191328160.12158@hermes-1.csi.cam.ac.uk>
 <20060420105929.GV27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, Al Viro wrote:
> On Wed, Apr 19, 2006 at 01:51:21PM +0100, Anton Altaparmakov wrote:
> > >  - I don't immediately see a race that taking the lock on the victim of
> > >    sys_unlink() solves; however, for symmetry with sys_rmdir(), it seems
> > >    desirable.
> > 
> > I guess the symmetry thing is fair enough.
> 
> Not only; it does, among other things, guarantee that fs can assume that
> ->link() won't race with unlink() (and that link count is protected by
> ->i_mutex, while we are at it).

Ok.

> > ntfs_rename() at the moment looks roughly like this:
> > 
> > if (target_inode) {
> > 	if (S_ISDIR(target_inode->i_mode)
> > 		ntfs_rmdir(target_dir_inode, target_dentry);
> > 	else
> > 		ntfs_unlink(target_dir_inode, target_dentry);
> > }
> > mutex_lock(&old_inode->i_mutex);
> > ntfs_link(old_dentry, target_dir_inode, target_dentry);
> > ntfs_unlink(old_dir_inode, old_dentry);
> > mutex_unlock(&old_inode->i_mutex);
> 
> Have fun dealing with error handling in the above...  Note that failing
> rename() should _NOT_ lead to target disappearing.

Indeed.  But if I do not define a rename operation at all then the mv 
command looses the target if the move fails, too.  So I don't see how the 
native rename needs to be any better other than for standards compliance.

Error recovery is actually pretty easy as if the second ntfs_unlink() 
fails I simply ntfs_unlink() the link I just created with ntfs_link().  
That already works fine.  But yes at the moment I do lose the target if 
either the ntfs_link() or the second ntfs_unlink() fails.

I am planning to fix this though.  It is not too hard because I can more 
or less just ntfs_link() it back in (with a few special casings).

Even if I implement are more "native" rename not using 
ntfs_unlink()/ntfs_link() I still have to remove the target first 
otherwise I cannot insert the new target because you cannot have two 
entries in the B+tree that have identical index keys (the index key is the 
filename itself so the two would be equal).  And I cannot simply replace 
the B+tree index entry because NTFS is not case sensitive so the two 
names (old and new) may not be in the same place in the B+tree.  The only 
thing I can do is to remove the old B+tree index entry and add the new one 
after that fact.  So no matter what I do, I have to be able to recreate 
the old index entry and that is just what ntfs_link() does which is why 
I chose my "simplified rename" approach in the first place.

Thanks a lot for you comments about the locking!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
