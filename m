Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270711AbTHALKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 07:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270713AbTHALKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 07:10:31 -0400
Received: from angband.namesys.com ([212.16.7.85]:2177 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S270711AbTHALK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 07:10:29 -0400
Date: Fri, 1 Aug 2003 15:10:28 +0400
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [PATCH] [2.5] reiserfs: fix races between link and unlink on same file
Message-ID: <20030801111027.GA1108@namesys.com>
References: <20030731144204.GP14081@namesys.com> <20030731133708.04bcd0c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731133708.04bcd0c9.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jul 31, 2003 at 01:37:08PM -0700, Andrew Morton wrote:

> > This patch (originally by Chris Mason) fixes link/unlink races in reiserfs.
> Could you describe the race a little more please?  Why is the VFS's hold of
> i_sem on the parent directory not sufficient?

Well, we do not take i_sem on parent directory of source filename for sys_link, I think.
So we might endup in sys_link() with inode that is already deleted/being deleted (and nlink==0).
Actually, I naturally thought that only i_nlink check to be non zero at reiserfs_link time should be
enough, but Chris is sure that we need entire patch, so may be he may add more comments to that.

BTW, looking at vfs_link, this patch (below the message) seems to be natural thing to do, is not it?

> > +
> > +    /* 
> > +     * we schedule before doing the add_save_link call, save the link
> > +     * count so we don't race
> This comment would seem to imply lock_kernel()-based locking, but
> lock_kernel() is not held here.

It is.
This reiserfs_write_lock/unlock stuff are in fact lock_kernel()/unlock_kernel(),
only I invented those macroses to easy conversion to more fine-grained locking later.
Except that Hans now does not want this to happen.

Bye,
    Oleg

===== fs/namei.c 1.81 vs edited =====
--- 1.81/fs/namei.c	Fri Jul 11 09:23:45 2003
+++ edited/fs/namei.c	Fri Aug  1 14:40:29 2003
@@ -1793,17 +1793,17 @@
 		return -EPERM;
 	if (!dir->i_op || !dir->i_op->link)
 		return -EPERM;
-	if (S_ISDIR(old_dentry->d_inode->i_mode))
+	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
 
 	error = security_inode_link(old_dentry, dir, new_dentry);
 	if (error)
 		return error;
 
-	down(&old_dentry->d_inode->i_sem);
+	down(&inode->i_sem);
 	DQUOT_INIT(dir);
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
-	up(&old_dentry->d_inode->i_sem);
+	up(&inode->i_sem);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_link(old_dentry, dir, new_dentry);
