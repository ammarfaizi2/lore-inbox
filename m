Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUJBJxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUJBJxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUJBJxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:53:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38290 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267370AbUJBJw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:52:56 -0400
Date: Sat, 2 Oct 2004 10:52:54 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Mahoney <jeffm@novell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] Race with iput and umount
Message-ID: <20041002095254.GH23987@parcelfarce.linux.theplanet.co.uk>
References: <415E5EE6.3010800@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415E5EE6.3010800@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 03:55:18AM -0400, Jeff Mahoney wrote:
> generic_shutdown_super() will happily call the ->put_super fs method,
> destroying data structures still in use by the iput (->delete_inode) in
> progress.  That's where Oopsen come into play.
> 
> The unlink path will call the ->unlink fs method, release the path (thus
> dropping the reference to the vfsmount, and then call iput. Since the
> vfsmount reference is dropped back to 1, a umount will succeed, causing
> the superblock to be cleaned up.

Arrgh...

Bug is in the ->i_count hacks in sys_unlink().  1001st proof that VFS has
no fscking business playing with inode refcount directly...

OK, quick and dirty fix follows.  Note: all places that go to exit1: or exit:
will have NULL inode, so we are not leaking anything here and it is OK do that
iput() early; indeed, the goal of that kludge was to postpone the final
iput() past the unlocking the parent for the sake of contention if a wunch
of bankers is doing parallel unlink() on files in the same directory and
normally it would happen on dput() after vfs_unlink())

--- linux/fs/namei.c	Mon Sep 13 01:32:00 2004
+++ linux/fs/namei.c.fix	Sat Oct  2 05:48:21 2004
@@ -1825,13 +1825,12 @@
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
+	if (inode)
+		iput(inode);	/* truncate the inode here */
 exit1:
 	path_release(&nd);
 exit:
 	putname(name);
-
-	if (inode)
-		iput(inode);	/* truncate the inode here */
 	return error;
 
 slashes:
