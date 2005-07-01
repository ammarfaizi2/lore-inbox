Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbVGAKMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbVGAKMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 06:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbVGAKMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 06:12:49 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:54028 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263301AbVGAKMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 06:12:34 -0400
To: akpm@osdl.org
CC: miklos@szeredi.hu, miklos@szeredi.hu, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050701010229.4214f04e.akpm@osdl.org> (message from Andrew
	Morton on Fri, 1 Jul 2005 01:02:29 -0700)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	<20050630124622.7c041c0b.akpm@osdl.org>
	<E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	<20050630235059.0b7be3de.akpm@osdl.org>
	<E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	<20050701001439.63987939.akpm@osdl.org>
	<E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu> <20050701010229.4214f04e.akpm@osdl.org>
Message-Id: <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 12:11:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, there's the "unsolvable" writeback deadlock problem, that FUSE
> > works around by not buffering dirty pages (and not allowing writable
> > mmap).  Does NFS solve that?  I'm interested :)
> 
> I don't know - first you'd have to describe it.

A dirty page is being written back, but the userspace server needs to
allocate memory to complete the request.  But the allocation will
block, since there's no more free memory.  

> > Then there's the usual "filesystem recursing into itself" deadlock.
> 
> Describe this completely as well, please.

User does unlink("/mnt/userfs/file").  Userspace server receives
request to unlink "/file".  Then the daemon does
unlink("/mnt/userfs/file").  This will deadlock on i_sem.

> > Mounting with 'intr' probably solves this for NFS, but that has
> > unwanted side effects.  FUSE only allows KILL to interrupt a request.
> 
> Maybe these things can be solved in NFS?

Possibly.

> 
> > > >   - dcache invalidation policy
> > > 
> > > What's that?
> > 
> > Userspace can tell the kernel, how long a dentry should be valid.  I
> > don't think the NFS protocol provides this. Same holds for the inode
> > attributes.
> 
> Why is that needed?

Because, I can well imagine a synthetic filesystem, where file
data/metadata change aribitrarily.  In this case the timeout heuristic
in NFS is not useful.

In fact with NFS it's often a PITA, that it doesn't want to refresh a
file's data/metatata, which I _know_ has changed on the server.

> > > >   - probably more, but I can't remember
> > > 
> > > Please do..
> > 
> > OK, I'll do a little research.
> > 
> 
> v9fs has a user-level server too.  Maybe it has been used in FUSE-like
> scenarios more than NFS.

I think the p9 protocol is suffering from trying to be too generic.
The FUSE kernel interface is probably slightly tied to the linux VFS,
and would present problems if trying to port to other *NIX or god
forbid some other OS family altogether.

That may seem like a drawback, but I don't think it is:

   - people are encouraged to use the FUSE library API instead of the
     raw kernel interface

   - if it will be ported to other systems, even the kernel interface
     could probably be made compatible, only at the loss of
     simplicity/performance.

> Plus NFS and v9fs work across the network...

Yes.  I consider that a drawback.  FUSE does data transfer very
efficiently (single copy), without the heavy network infrastructure
being in the way.

Miklos

