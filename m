Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130251AbQLFA2y>; Tue, 5 Dec 2000 19:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbQLFA2o>; Tue, 5 Dec 2000 19:28:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23304 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130251AbQLFA2h>; Tue, 5 Dec 2000 19:28:37 -0500
Date: Tue, 5 Dec 2000 15:57:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Urban Widmark <urban@teststation.com>, Alexander Viro <aviro@redhat.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs writepage & struct file
In-Reply-To: <Pine.LNX.4.21.0012051959090.3205-100000@cola.svenskatest.se>
Message-ID: <Pine.LNX.4.10.10012051530100.13428-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Urban Widmark wrote:
> 
> Hardlinks are not supported by smbfs, but they may be supported on the
> server side (ntfs). Haven't looked if smb has anything on this. Not sure
> if there are any implications on caching and such for smbfs. (If hardlinks
> need to be handled, smbfs is probably broken anyway wrt those).

Without hardlinks there will be a 1:1 relation between inodes and
dentries, which means that the dentry could be used as a mapping host.
Then you could just do

	struct dentry *dentry = (struct dentry *)mapping->host;

and get the inode from "dentry->d_inode". The problem with going the other
ways is that you can have an inode where the dentry has been reaped by
shrink_dcache() due to memory pressure, so the inode->i_dentry list could
in theory be empty. The reverse can never be true (if the dentry exists,
the inode will exist too).

HOWEVER, the problem with just making the dentry be the mapping host is
that I don't think it has ever been done before, so there is no good
source of examples on how to do this. You would just initialize it in
"smb_iget()", but then you'd have to pass the dentry down to that routine
in order to know what to initialize the mapping host to, of course.

Even after you'd do that, there are other problems: the inode shrinking
code knows about having pages attached to the inode. The same is not true
of the dentry shrinking code - so we could shrink a dentry that is still
busy in that it has pages in its mapping. 

In comparison to these dentry host problems, your patch looks fine. But I
suspect that you _can_ trigger the BUG() with an empty dentry list due to
dentry shrinking. So what I did is basically to (a) apply your patch and
(b) set writepage to NULL in the address space operations, so that shared
mappings will be disabled for the time being.

I also cc'd Al, because he's likely to just come up with a clever scheme
that solves this, and call me an idiot.

Hmm.. The smb filesystem code in general seems to assume that if we have
an inode, we'd always have a dentry and vice versa. Because otherwise we'd
have potentially multiple inodes for the same dentry. Every time we do a
successful dentry lookup(), we do a "new_inode()", so if we drop the
dentry and re-lookup, we'd have aliased inodes (and thus various page
cache aliases too, etc).

Having aliased inodes is not wrong per se: it's just that it doesn't mix
well with having the page cache associated with the inode. So it probably
works fine as-is, it just has the potential to not cache things as well as
it could (because dropping the dentry will basically mean dropping the
full page cache).

Al? Any ideas?

> I was "borrowing" stuff from the nfs code and this looked strange:
> 
> nfs_writepage_sync:
>         struct dentry   *dentry = file->f_dentry;
>         struct rpc_cred *cred = nfs_file_cred(file);
> 
> yet it is called like this from nfs_writepage:
>         err = nfs_writepage_sync(NULL, inode, page, 0, offset);
> 
> where file is the 1st argument. Oh, it calls nfs_writepage_async most of
> the time. All of the time?

That's bogus. But Trond probably overlooked it in testing, because yes, it
always calls the async version unless there has been errors doing async
writes (which should be rather uncommon).

Trond? Can you massage the sync version to do the same as the async one?

Thanks for noticing.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
