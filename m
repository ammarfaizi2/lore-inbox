Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTFCXlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 19:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTFCXlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 19:41:15 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:31860 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261932AbTFCXlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 19:41:12 -0400
Date: Tue, 3 Jun 2003 16:54:38 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: nfs_refresh_inode: inode number mismatch
Message-ID: <20030603165438.A24791@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Previously sent to nfs@sourceforge with no response]

I'm using a frankenstein kernel, 2.4.21-rc3 with some -ac bits,
and 2.5.69 NFS+RPC backported to it.  Like the CITI kernel (for krb5),
but a little more aggressive on the bits backported.  For the purpose
of this email, I think the code I have questions with is similar or even
identical from 2.4.21->2.5.69.  I can reproduce this problem on a RH
2.4.20-9smp kernel.

Consider these two shells running on the same machine:

	    1				    2

	cd /nfs				cd /nfs
	mkdir t
	echo foo > t/foo
	less t/foo
	 [less waits for input]
					rm -rf t
	'v'
	 [vi tries to access tmp/foo]

At this point, fs/nfs/inode.c:__nfs_refresh_inode() prints the "inode
number mismatch" error.  AFAICT, this is just noise, but the noise is
driving me crazy. :-)

Now, if sequence 2 is run on a different machine, there is no error!
So that hints to me that the local cache just needs to be cleared,
perhaps in nfs_rmdir() or maybe in nfs_unlink()/nfs_safe_remove().
I've tried a few things, but I'm not familiar enough with the code
and am making slow progress.  I can suppress this error by testing
for 'unlinked but open' in __nfs_refresh_inode:

        if (NFS_FILEID(inode) != fattr->fileid) {
		if (inode->i_nlink)	/* quiet if inode DNE anymore */
			printk(...)
	}

Do you think this is safe?  Some minimal logs:

kernel: NFS: dentry_delete(t/.nfs01c7d70600000001, 2)	| renamed file
kernel: NFS: delete_inode(e/29873926)			| unlink of renamed foo

kernel: NFS: refresh_inode(e/29873923 ct=1 info=0x6)	| accessing t/
kernel: nfs_refresh_inode: inode number mismatch
kernel: expected (0xe/0x1c7d703), got (0xe/0xe63bc2)
kernel: NFS: dentry_delete(fsstress/t, 0)
kernel: NFS: delete_inode(e/29873923)

and then access calls beginning at the root.  I apologize for the likely
uselessness of the above logs.  I can email some annotated logs if desired,
but the problem is very easy to reproduce, so I'll hold off for now.

This problem only exists for nfsv3.  This problem doesn't occur if there
is a third process also holding foo open (note that the directory does
get removed, just no kernel error when trying to access it).

The 2.2 kernel doesn't have this problem, because (apparently) it doesn't
allow you to unlink a .nfsXXX file while it's open (and therefore you
cannot remove the dir).

Which made me look around (2.5.69):  In nfs_silly_rename(), the new
dentry (sdentry) gets a d_count of 1.  Doesn't this indicate that no
one is holding this file open?  (which then tells nfs_unlink() to just
call nfs_safe_remove() rather than nfs_silly_rename())  Is that really
desirable?  Even if I set the d_count to match what the previous
dentry->d_count had, and avoid calling dput(sdentry), on the next run
through nfs_unlink() the d_count is 1 and it just goes to nfs_safe_remove().
I think that clearly, I don't understand what the d_move() is for.
(My guess is to avoid nfs_async_unlink() getting passed a dentry which
we are actually about to get rid of, but I haven't wrapped my head around
the dcache yet.)

Then I noticed that the DCACHE_NFSFS_RENAMED seems a little racy.
nfs_async_unlink() sets this and when the call completes,
nfs_complete_unlink() resets it.  So while it's being deleted, if an
rm -rf quickly picks up the .nfs name before the async unlink returns,
it won't get removed.  But if the nfs call completes first, it does
get removed.  Is the intention just to prevent removal of the .nfs
file until the old file is removed on the server?  What's the benefit
of this?

So, even with that error message quieted, fsstress reports lots of
inode mismatches.  I am in the process of trying to piece together a
simple reproducible sequence of NFS calls.

This is against a netapp server, although I can't see how the server would
matter.

Thanks for any advice, guidance, or hopefully fixes!  BTW, I'm interested
to hear what tools folks use to stress the NFS client.

/fc
