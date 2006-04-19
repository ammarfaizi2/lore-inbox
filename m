Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWDSMvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDSMvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWDSMvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:51:31 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:6830 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750722AbWDSMva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:51:30 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 19 Apr 2006 13:51:21 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Matthew Wilcox <matthew@wil.cx>
cc: Al Viro <viro@ftp.linux.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: A missing i_mutex in rename? (Linux kernel 2.6.latest)
In-Reply-To: <20060419121826.GI24104@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0604191328160.12158@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0604191102260.17373@hermes-1.csi.cam.ac.uk>
 <20060419121826.GI24104@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Thanks for the quick reply.

On Wed, 19 Apr 2006, Matthew Wilcox wrote:
> On Wed, Apr 19, 2006 at 11:50:00AM +0100, Anton Altaparmakov wrote:
> > Both sys_unlink()/sys_rmdir() and sys_link() all end up taking the i_mutex 
> > on all parent directories and source/destination inodes before calling 
> > into the file system inode operations.
> > 
> > sys_rename() OTOH, does not take i_mutex on the old inode.  It only takes 
> > i_mutex on the two parent directories and on the target inode if it 
> > exists.
> > 
> > Why is this?  To me it seems that either sys_rename() must take i_mutex on 
> > the old inode or sys_unlink()/sys_rmdir(), sys_link(), etc do not need to 
> > hold the i_mutex.
> > 
> > What am I missing?
> 
> I believe the current locking scheme to be correct.  Reading
> Documentation/filesystems/directory-locking and pondering for a few
> minutes leads me to the following conclusions:
> 
>  - sys_rmdir() must take the lock on the parent directory and on the
>    victim.  If a different process is trying to create a file in the
>    victim, sys_rmdir() mustn't race with it.

Agreed.

>  - I don't immediately see a race that taking the lock on the victim of
>    sys_unlink() solves; however, for symmetry with sys_rmdir(), it seems
>    desirable.

I guess the symmetry thing is fair enough.

>  - sys_link() needs to lock the target to be sure it isn't removed and
>    replaced with a directory in the meantime.

Agreed.

>  - sys_rename() does not need to lock the old inode.  Since the parent
>    is already locked, the old inode can't be removed/renamed by a racing
>    process.  It doesn't matter if something's created or deleted from
>    within the old inode (if it's a directory), unlike rmdir().  It
>    doesn't need to be protected from a sys_link() race.

Agreed.

> If you need to lock the old inode inside ntfs for your own consistency
> purposes, that looks like it should be fine, but the VFS doesn't need to
> lock it for you.

Great, thanks.  That was my own conclusion also but it never hurts to be 
sure.  (-:

ntfs_rename() at the moment looks roughly like this:

if (target_inode) {
	if (S_ISDIR(target_inode->i_mode)
		ntfs_rmdir(target_dir_inode, target_dentry);
	else
		ntfs_unlink(target_dir_inode, target_dentry);
}
mutex_lock(&old_inode->i_mutex);
ntfs_link(old_dentry, target_dir_inode, target_dentry);
ntfs_unlink(old_dir_inode, old_dentry);
mutex_unlock(&old_inode->i_mutex);

Which is incredibly inefficient but very simple and works (with minimal 
special casing in ntfs_link() and ntfs_unlink() mostly so if old_inode is 
a directory we never get a link count greater one on the VFS inode) and I 
doubt sys_rename() is a very often invoked system call.  Normally, a 
sys_link() and sys_unlink() would take i_mutex on old_inode as shown in 
above code which is why I was wondering whether I should take it as shown 
above or whether I can just not worry and not take yet another lock in a 
code path where tons of locks are already being taken and released.

My conclusion is that the above code is safe even if I remove the 
mutex_lock()/mutex_unlock() around the ntfs_link()/ntfs_unlink() given 
that sys_unlink() only takes the lock for symmetry reasons and 
sys_link()'s need for locking is taken care of by the fact that 
sys_rename() has the lock on both parent directory inodes.

Would you agree?

Thanks a lot in advance!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
