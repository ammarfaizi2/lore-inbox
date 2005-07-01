Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263312AbVGAMCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbVGAMCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 08:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263314AbVGAMCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 08:02:13 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:61449 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263312AbVGAMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 08:01:34 -0400
To: akpm@osdl.org
CC: aia21@cam.ac.uk, arjan@infradead.org, linux-kernel@vger.kernel.org,
       frankvm@frankvm.com
In-reply-to: <20050701042955.39bf46ef.akpm@osdl.org> (message from Andrew
	Morton on Fri, 1 Jul 2005 04:29:55 -0700)
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
	<E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	<20050701010229.4214f04e.akpm@osdl.org>
	<E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu> <20050701042955.39bf46ef.akpm@osdl.org>
Message-Id: <E1DoKCR-0002hx-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 14:00:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A dirty page is being written back, but the userspace server needs to
> > allocate memory to complete the request.  But the allocation will
> > block, since there's no more free memory.  
> 
> That shouldn't happen with write() traffic due to the dirty memory
> balancing logic.

How?  It either blocks other allocations until the writeback is
completed (DoS) or allows memory to be exhausted (deadlock).

Making unpriv mounts work securely is not a trivial thing I can tell
you ;)

> > User does unlink("/mnt/userfs/file").  Userspace server receives
> > request to unlink "/file".  Then the daemon does
> > unlink("/mnt/userfs/file").  This will deadlock on i_sem.
> 
> eh?  How can the fuse client and the fuse server both get access to the
> same file in this manner?  I don't see how you could set that up with NFS,
> for example.

With a custom userspace NFS server you can do whatever you want.
That's the whole purpose of the exercise.

> > Because, I can well imagine a synthetic filesystem, where file
> > data/metadata change aribitrarily.  In this case the timeout heuristic
> > in NFS is not useful.
> > 
> > In fact with NFS it's often a PITA, that it doesn't want to refresh a
> > file's data/metatata, which I _know_ has changed on the server.
> 
> I think nfs can do this, as long as the modification was done through the
> server.  I'd expect v9fs would be the same.

It's often not.  Sshfs is a good example.  File server will not be
able to notify the client when anything changes.  Polling is the only
solution, and NFS doesn't always get it right (and in fact it cannot).
It's much better to leave cache timeout policy to the userspace
filesystem, then trying to guess it in the kernel.


> > > Plus NFS and v9fs work across the network...
> > 
> > Yes.  I consider that a drawback.
> 
> Others (many) would disagree.
> 
> 
> Sorry, but I'm not buying it.  I still don't see a solid reason why all
> this could not be done with nfs/v9fs, some kernel tweaks and the rest in
> userspace.  It would take some effort, but that effort would end up
> strengthening existing kernel capabilities rather than adding brand new
> things, which is good.

I'm not sure.  NFS is a monster, everybody can agree.  Getting all the
requirements of FUSE (safe unprivileged mounts, etc) would be a
nightmare.

FUSE does one thing, and it does that right.  I think that's good.

Miklos
