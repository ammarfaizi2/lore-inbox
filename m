Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVHZVph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVHZVph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 17:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVHZVph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 17:45:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63898 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S965172AbVHZVpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 17:45:36 -0400
Date: Fri, 26 Aug 2005 22:48:39 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: torvalds@osdl.org, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] Fixup symlink function pointers for hppfs [for 2.6.13]
Message-ID: <20050826214839.GB9322@parcelfarce.linux.theplanet.co.uk>
References: <20050826145749.03BFE24D661@zion.home.lan> <20050826190339.GA9322@parcelfarce.linux.theplanet.co.uk> <200508262204.43683.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508262204.43683.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 10:04:43PM +0200, Blaisorblade wrote:
> And beyond that what? I cannot even think what's the rest *. And "obvious" 
> doesn't hold with me.

vfsmount *mnt = do_kern_mount("proc", 0, "proc", NULL);

done at init time,

mntput(mnt);

at exit

and mntget(mnt) instead of your NULL in dentry_open().

Do not mess with get_fs_type() anywhere - the above will give you access
to procfs superblock just fine.

The real issue is what you are doing with procfs dentries there.  You do
*not* call ->d_revalidate().  And you do not evict these suckers when
procfs dentry goes away.  E.g. when process dies...

What the hell is going on with iget() calls, BTW?  Especially since all
of them get the same inumber...  Looks completely broken.

Why does is_pid() bother with checks for fs dentry belongs to?

copy_from_user() return value needs to be checked.

Use of file->f_pos is blatantly racy; don't do that.

->permission() is missing on hppfs; since procfs is not using generic one,
we have a problem.

read_proc() is a guaranteed fsckup if hppfs_open() is called with KERNEL_DS.

That's from the quick look through the current code...
