Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWHOSfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWHOSfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWHOSfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:35:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54507 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030280AbWHOSfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:35:31 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060815104813.7e3a0f98.akpm@osdl.org> 
References: <20060815104813.7e3a0f98.akpm@osdl.org>  <20060815065035.648be867.akpm@osdl.org> <20060814143110.f62bfb01.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <10791.1155580339@warthog.cambridge.redhat.com> <918.1155635513@warthog.cambridge.redhat.com> <29717.1155662998@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 19:35:20 +0100
Message-ID: <6241.1155666920@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> NFS: nfs_fhget(0:15/0 ct=1)

That's the dummy root dentry (attached to s_root) which we don't actually use
for anything.

> NFS: nfs_fhget(0:15/2 ct=1)

That's the actual root of the subtree for this mount (inode 2).

> SELinux: initialized (dev 0:15, type nfs), uses genfs_contexts

I wonder if this is something to do with it.  I run my testbox with SELinux
disabled since it won't boot if it's turned on (udev takes so long to run that
it gets backgrounded and then fsck tries to run, but can't find any blockdev
files).  Can you try turning SELinux off (booting with selinux=0 on the kernel
command line might do it).

> NFS: nfs_update_inode(0:15/2 ct=1 info=0x6)

Update the root inode from attributes with NFS_ATTR_FATTR_V3|NFS_ATTR_FATTR.

> NFS: permission(0:15/2), mask=0x1, res=0
> NFS: permission(0:15/2), mask=0x1, res=0

Check MAY_EXEC on root.  It all looks reasonable to this point.

> NFS: lookup(/usr)

But _why_?  This is very strange.  We shouldn't be looking at bix:/usr yet
because we haven't read the directory and we can't know it exists yet.

Also, why isn't there a call to nfs_fhget() for bix:/usr?

> NFS: permission(0:15/2), mask=0x3, res=0

Though it appears we do have permission to write and exec the directory (I
assume that mask=0x3 -> MAY_WRITE|MAY_EXEC), though *why* we'd be trying to do
that, I don't know.

> NFS: dentry_delete(/usr, 0)
> NFS: permission(0:15/2), mask=0x1, res=0
> NFS: permission(0:15/2), mask=0x1, res=0

Again, check MAY_EXEC on the root dir.

> NFS: lookup(/mnt)

And again: _why_?  We shouldn't know about bix:/mnt either.

> NFS: permission(0:15/2), mask=0x3, res=0

Again we're asking for MAY_WRITE permission as well as MAY_EXEC.

> NFS: dentry_delete(/mnt, 0)
> NFS: nfs_update_inode(0:15/2 ct=1 info=0x6)
> NFS: permission(0:15/2), mask=0x4, res=0

Check we have MAY_READ on the root dir.

> NFS: opendir(0:15/2)

And open it for reading.

> NFS: readdir(/) starting at cookie 0

Okay... read some entries from the directory.

> NFS: nfs_fhget(0:15/11 ct=1)
> NFS: dentry_delete(/lost+found, 0)
> NFS: nfs_fhget(0:15/65537 ct=1)
> NFS: dentry_delete(/dev, 0)

Go through the first two, which looks fine.

> NFS: dentry_delete(/usr, 8)

And then we read bix:/usr, but don't call nfs_fhget() - which is should be
reasonable since we fetched it earlier.  Note that the dentry specifies
DCACHE_REFERENCED in d_flags.

> NFS: nfs_fhget(0:15/196609 ct=1)
> NFS: dentry_delete(/var, 0)

And this looks fine.

> ...
> NFS: permission(0:15/2), mask=0x1, res=0
> NFS: dentry_delete(/usr, 8)

Then we come to stat bix:/usr, and this looks fine.



On the basis of nfs_lookup() apparently not calling nfs_fhget() for the first
lookup of /usr, can you stick a printk() at the end of nfs_lookup() (in
fs/nfs/dir.c), just before the return-statement so that it prints out the
return value.  And can you make nfs_lookup() print nd->flags on entry?


I'm wondering if autofs4 is trying to create a couple of directories in the
NFS share, though I can't think why it would.  Uncommenting:

	/* #define DEBUG */

in fs/autofs4/autofs_i.h might also be informative.

David
