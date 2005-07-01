Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263230AbVGALbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbVGALbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 07:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbVGALbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 07:31:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263230AbVGALbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 07:31:06 -0400
Date: Fri, 1 Jul 2005 04:29:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: miklos@szeredi.hu, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-Id: <20050701042955.39bf46ef.akpm@osdl.org>
In-Reply-To: <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
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
	<E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > Well, there's the "unsolvable" writeback deadlock problem, that FUSE
> > > works around by not buffering dirty pages (and not allowing writable
> > > mmap).  Does NFS solve that?  I'm interested :)
> > 
> > I don't know - first you'd have to describe it.
> 
> A dirty page is being written back, but the userspace server needs to
> allocate memory to complete the request.  But the allocation will
> block, since there's no more free memory.  

That shouldn't happen with write() traffic due to the dirty memory
balancing logic.

It'll happen with MAP_SHARED.  Totally disallowing MAP_SHARED sounds a bit
drastic, but of course nfs/v9fs could be taught to do that.

> > > Then there's the usual "filesystem recursing into itself" deadlock.
> > 
> > Describe this completely as well, please.
> 
> User does unlink("/mnt/userfs/file").  Userspace server receives
> request to unlink "/file".  Then the daemon does
> unlink("/mnt/userfs/file").  This will deadlock on i_sem.

eh?  How can the fuse client and the fuse server both get access to the
same file in this manner?  I don't see how you could set that up with NFS,
for example.

> > > Userspace can tell the kernel, how long a dentry should be valid.  I
> > > don't think the NFS protocol provides this. Same holds for the inode
> > > attributes.
> > 
> > Why is that needed?
> 
> Because, I can well imagine a synthetic filesystem, where file
> data/metadata change aribitrarily.  In this case the timeout heuristic
> in NFS is not useful.
> 
> In fact with NFS it's often a PITA, that it doesn't want to refresh a
> file's data/metatata, which I _know_ has changed on the server.

I think nfs can do this, as long as the modification was done through the
server.  I'd expect v9fs would be the same.

> > Plus NFS and v9fs work across the network...
> 
> Yes.  I consider that a drawback.

Others (many) would disagree.


Sorry, but I'm not buying it.  I still don't see a solid reason why all
this could not be done with nfs/v9fs, some kernel tweaks and the rest in
userspace.  It would take some effort, but that effort would end up
strengthening existing kernel capabilities rather than adding brand new
things, which is good.
