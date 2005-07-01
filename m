Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVGAHjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVGAHjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbVGAHjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:39:32 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:24583 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261433AbVGAHjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:39:24 -0400
To: akpm@osdl.org
CC: miklos@szeredi.hu, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050701001439.63987939.akpm@osdl.org> (message from Andrew
	Morton on Fri, 1 Jul 2005 00:14:39 -0700)
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
	<E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu> <20050701001439.63987939.akpm@osdl.org>
Message-Id: <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 09:38:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > > >
> > > >  > - aren't we going to remove the nfs semi-server feature?
> > > > 
> > > >  I leave the decision to you ;)  It's a separate independent patch
> > > >  already (fuse-nfs-export.patch).
> > > 
> > > Let's leave it out - that'll stimulate some activity in the
> > > userspace-nfs-server-for-FUSE area.
> > > 
> > > Speaking of which, dumb question: what does FUSE offer over simply using
> > > NFS protocol to talk to the userspace filesystem driver?
> > 
> > Oh lots:
> > 
> >   - no deadlocks (NFS mounted from localhost is riddled with them)
> 
> It is?  We had some low-memory problems a while back, but they got fixed. 
> During that work I did some nfs-to-localhost testing and things seemed OK.

Well, there's the "unsolvable" writeback deadlock problem, that FUSE
works around by not buffering dirty pages (and not allowing writable
mmap).  Does NFS solve that?  I'm interested :)

Then there's the usual "filesystem recursing into itself" deadlock.
Mounting with 'intr' probably solves this for NFS, but that has
unwanted side effects.  FUSE only allows KILL to interrupt a request.

> >   - efficient protocol, optimized for less context switches
> 
> One wouldn't really expect a userspace filesystem to be particularly fast,

FUSE is pretty fast.  >100Mbytes/s transfer speeds on a moderate
hardware are not unusual.

> and the performance will be dominated by memory copies and IO wait anyway.

Memory copies don't seem to be an issue (and FUSE does very little of
it).  Performance is mostly dominated by context switch times (if the
underlying filesystem can keep up).  Unfortunately unbuffered writes
mean a separate request for each written page, and thus a context
switch (on UP at least).  This has a marked effect on write
performance.

> >   - dcache invalidation policy
> 
> What's that?

Userspace can tell the kernel, how long a dentry should be valid.  I
don't think the NFS protocol provides this. Same holds for the inode
attributes.

> >   - probably more, but I can't remember
> 
> Please do..

OK, I'll do a little research.

Miklos
