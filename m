Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbVGANyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbVGANyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbVGANyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:54:11 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:64263 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263340AbVGANyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:54:01 -0400
To: ericvh@gmail.com
CC: miklos@szeredi.hu, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
In-reply-to: <a4e6962a050701062136435471@mail.gmail.com> (message from Eric
	Van Hensbergen on Fri, 1 Jul 2005 08:21:23 -0500)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	 <20050630124622.7c041c0b.akpm@osdl.org>
	 <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	 <20050630235059.0b7be3de.akpm@osdl.org>
	 <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	 <20050701001439.63987939.akpm@osdl.org>
	 <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <20050701010229.4214f04e.akpm@osdl.org>
	 <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu> <a4e6962a050701062136435471@mail.gmail.com>
Message-Id: <E1DoLxK-0002ua-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 15:53:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know where 9P "suffers" from being too generic, it's just
> well-designed and has done a good job of keeping things simple --
> something that the plethora of over designed, bloated interfaces of
> today could learn from.

True.  I very much like the simplicity of the 9P protocol.  But it's
system independence sometimes makes it fit poorly to the Linux VFS
interface.  I guess you have a wide experience with this :)

> > > Plus NFS and v9fs work across the network...
> > 
> > Yes.  I consider that a drawback.  FUSE does data transfer very
> > efficiently (single copy), without the heavy network infrastructure
> > being in the way.
> > 
> 
> I'll grant you this is something v9fs-2.0 suffers from, but its
> something we are actively addressing in v9fs-2.1.  We're working more
> towards the implementation that is present in the Plan 9 kernel, where
> the core efficiently multiplexes the requests either directly to local
> servers (in Plan 9's case via function call APIs) or encapsulates them
> for shipping across the network.  The 9P interface is used for both,
> it just has different embodiments depending on underlying transport.
> 
> That being said, I imagine the time spent context switching in and out
> of the kernel dominates performance.

Context switch happens from one process to the other, not when
entering/leaving the kernel (which is very efficient).

So it's much more important to reduce the number of round-trips for a
single operation, than multiplexing requests for multiple operations.

> With a proper mux there is no reason why v9fs can't be made as
> efficient as FUSE - and that's what we intend to demonstrate in
> v9fs-2.1.  Plus, with v9fs you get the benefit of being able to
> export your synthetic file systems over the network with no
> additional copies.

Yes, but does that matter?  I'm not sure that it's a good idea
bundling network filesystem functionality together with userspace
filesystem functionality.  Each has it's own set of requirements, and
it's own way of working optimally.

What would people say if ext3 was always mounted locally through NFS,
because the kernel would only provide the NFS filesystem client.

Differentiation of interfaces depending on the "closeness" of the
client to the server makes good sense IMO.  We currently have
in-kernel and across-network.  FUSE adds in-userspace in between those
two.

Sometime these can overlap, but one interface will always be more
optimal (in terms of functionality as well as speed) for a specific
application.

> Further, when you create an infrastructure which is meant to work over
> a network, you take fewer things for granted -- which ultimately leads
> to a more robust system capable of dealing with many of these
> problems.

Yes.  I'm not speaking agains v9fs, which I think has a valid niche,
as well as FUSE.

Miklos

