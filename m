Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282369AbRKXGUu>; Sat, 24 Nov 2001 01:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282370AbRKXGUk>; Sat, 24 Nov 2001 01:20:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24612 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282369AbRKXGUW>; Sat, 24 Nov 2001 01:20:22 -0500
Date: Sat, 24 Nov 2001 07:20:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124072039.A2398@athlon.random>
In-Reply-To: <20011124064739.J1324@athlon.random> <Pine.GSO.4.21.0111240054080.4000-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111240054080.4000-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 24, 2001 at 01:04:48AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 01:04:48AM -0500, Alexander Viro wrote:
> 
> 
> On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> 
> > On Fri, Nov 23, 2001 at 04:22:17PM -0500, Alexander Viro wrote:
> > > 	Sigh...  Supposed fix to problems with stale inodes was completely
> > > broken.
> > > 
> > > 	What we need is "if we are doing last iput() on fs that is getting
> > > shut, sync it and don't leave it in cache".  And yes, we have a similar
> > 
> > What's this "stale inode" problem? invalidate_inodes in kill_super will
> > obviously get rid of all of them or we would be getting the
> 
> First of all, there is ->read_super() side of the things.  If it fails
> after iget() on root, we have nothing to kick inode out of cache.  And
> no, we can't call invalidate_inodes() here - too late for calling any
> methods.

why should you call any method, the ->read_super just make sure if it
fails you can safely get rid of the logical struct inode. I don't see
any problem in solving this case without special iput cases.

> 
> What's more, for stuff like inodes held by superblock (e.g. fs keeping
> block bitmaps in a file - in that case the earliest point that _can_
> do iput() on that sucker is ->put_super(); ditto for $BIGNUM similar
> cases - journal, other fs structures of that kind - ACLs, etc., etc.)
> we get final iput() _after_ invalidate_inodes().  And doing anything
							^^^^^^^^^^^^^^
> after ->put_super() is again too late.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

	if (sop) {
		if (sop->write_super && sb->s_dirt)
			sop->write_super(sb);
		if (sop->put_super)
			sop->put_super(sb);
			^^^^^^^^^^^^^^
	}

	/* Forget any remaining inodes */
	if (invalidate_inodes(sb)) {
	    ^^^^^^^^^^^^^^^^^^^^^
		printk("VFS: Busy inodes after unmount. "
			"Self-destruct in 5 seconds.  Have a nice day...\n");
	}

> 
> IOW, we can kick inode out of icache only between successful ->read_super()
> and ->put_super().  Any iput() done outside of that range must go immediately
> and yes, such cases are not only possible but actually exist.

If put_user changes an inode and then it does an iput internally, it's
its own business to recall fsync_dev internally if necessary. btw, we could
even move all the invalidate code into the lowlevel callbacks, the point
of having it at the VFS is because most fs are just fine with it, but it
doesn't restrict any functionality.

Andrea
