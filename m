Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135968AbREJBRa>; Wed, 9 May 2001 21:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135971AbREJBRV>; Wed, 9 May 2001 21:17:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25156 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135968AbREJBRI>; Wed, 9 May 2001 21:17:08 -0400
Date: Thu, 10 May 2001 03:16:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Kurt Garloff <garloff@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
Message-ID: <20010510031652.G2506@athlon.random>
In-Reply-To: <20010510020819.F2506@athlon.random> <Pine.LNX.4.21.0105091931410.15959-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105091931410.15959-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, May 09, 2001 at 07:38:01PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 07:38:01PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Thu, 10 May 2001, Andrea Arcangeli wrote:
> 
> > On Wed, May 09, 2001 at 07:02:16PM -0300, Marcelo Tosatti wrote:
> > > Why don't you clean I_DIRTY_PAGES ? 
> > 
> > we don't have visibilty on the inode_lock from there, we could make a
> > function in fs/inode.c or export the inode_lock to do that, but the flag
> > will be collected when the inode is released anyways, and it's only an
> > hint to make the common case fast (the common case is when nobody ever
> > did a MAP_SHARED on the inode). Other places msync/fsync doesn't even
> > check for such bit but they fdatasync/fdatawait unconditionally. 
> 
> Actually msync/fsync _can't_ rely on this bit because there is no
> guarantee that data is fully synced on disk even if the bit is cleared.
> (__sync_one (fs/inode.c) clears the bit _before_ starting the writeout,
> and thats it).

correct sorry, fsync/msync cannot check that bit of course.

> You have the same problem with your code, so I guess its better to just
> remove the I_DIRTY_PAGES check. 

The point you have to clarify before claming we should remove the check
is if the munmap flush needs to be synchronous or not. In general munmap
doesn't need to be synchronous. If you want to commit the writes an
explicit msync(MS_SYNC) or fsync on the file is required.  Otherwise the
updates will hit the platter in a rasonable amount of finite time
asynchronously. If somebody just intiated the fdatasync he will have to
finish before we can collect away the inode and in turn drop all its
cache, so those dirty pages cannot get lost in iput if somebody started
doing the flush under us either, and the guy doing the fdatasync under
us will have to wait synchronously for the stuff to be committed before
it can return.

If some page wasn't yet visible in the dirty_pages list by the time
__sync_one started, we'll find I_DIRTY_PAGES set. This is enforced by
the locking order (sync_one first clears the I_DIRTY_PAGES and then
it starts browsing the dirty_pages list while set_page_dirty first make the
page visible and then marks the inode dirty).

So the I_DIRTY_PAGES check guarantees that those dirty pages cannot be
lost in iput, that was the _only_ object of the patch and that is
certainly enough to fix the nfs fs data corruption reported.

Now if you claim that munmap needs to be synchronous for nfs that's a
completly different matter. I didn't even tried to make it synchronous.
It is possible it has to be synchronous, even write(2) (in theory ;) has
to behave like O_SYNC with nfs, but I'm not sure.


Another thing (completly unrelated to the above issues) that I noticed
while looking over this nfs code is that the __sync_one() for example
called by generic_file_write(O_SYNC) will recall fdatasync but no nfs_wb_all
is put before the fdatawait, and I'm not sure that the nfs_sync_page
called by the fdatawait is enough to rapidly flush the writepaged stuff
to the nfs server. nfs_sync_page apparently only cares about speculative
reads, not at all about committing writebacks. It would look much saner
to me if nfs_sync_page also does a nfs_wb_all() on the inode, so that
the ->sync_page callback gets the same semantics it has for the real
filesystems.

Comments?

Andrea
