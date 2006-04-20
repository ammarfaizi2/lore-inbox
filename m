Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWDTK7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWDTK7d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDTK7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:59:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23783 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750850AbWDTK7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:59:32 -0400
Date: Thu, 20 Apr 2006 11:59:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: A missing i_mutex in rename? (Linux kernel 2.6.latest)
Message-ID: <20060420105929.GV27946@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0604191102260.17373@hermes-1.csi.cam.ac.uk> <20060419121826.GI24104@parisc-linux.org> <Pine.LNX.4.64.0604191328160.12158@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604191328160.12158@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 01:51:21PM +0100, Anton Altaparmakov wrote:
> >  - I don't immediately see a race that taking the lock on the victim of
> >    sys_unlink() solves; however, for symmetry with sys_rmdir(), it seems
> >    desirable.
> 
> I guess the symmetry thing is fair enough.

Not only; it does, among other things, guarantee that fs can assume that
->link() won't race with unlink() (and that link count is protected by
->i_mutex, while we are at it).

> >  - sys_link() needs to lock the target to be sure it isn't removed and
> >    replaced with a directory in the meantime.
> 
> Agreed.

"Replaced" part is bogus - we'd done lookup, so we won't get anything new.

> > If you need to lock the old inode inside ntfs for your own consistency
> > purposes, that looks like it should be fine, but the VFS doesn't need to
> > lock it for you.
> 
> Great, thanks.  That was my own conclusion also but it never hurts to be 
> sure.  (-:
> 
> ntfs_rename() at the moment looks roughly like this:
> 
> if (target_inode) {
> 	if (S_ISDIR(target_inode->i_mode)
> 		ntfs_rmdir(target_dir_inode, target_dentry);
> 	else
> 		ntfs_unlink(target_dir_inode, target_dentry);
> }
> mutex_lock(&old_inode->i_mutex);
> ntfs_link(old_dentry, target_dir_inode, target_dentry);
> ntfs_unlink(old_dir_inode, old_dentry);
> mutex_unlock(&old_inode->i_mutex);

Have fun dealing with error handling in the above...  Note that failing
rename() should _NOT_ lead to target disappearing.
