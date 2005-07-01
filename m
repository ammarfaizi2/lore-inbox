Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263353AbVGAOTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbVGAOTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbVGAOTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:19:17 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:2711 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263353AbVGAOTF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:19:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c4kUsdWICFU0AQntp3D+QJ+BrlE6szA1g8tpo0YGAxjCcOXVvNwZvxDy8TKlwFVAp/Q+j/R/ZFqG5AJxkP9HjNrHF++4Xnpj8RTwx/hVFvSS1kCW51RvLC096KiRF37axMf/+4vHQBvX5Jm7P5cKGOeK4japr9JFpJ6Nen4hLug=
Message-ID: <a4e6962a05070107183862ed22@mail.gmail.com>
Date: Fri, 1 Jul 2005 09:18:59 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: FUSE merging?
Cc: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
In-Reply-To: <E1DoLxK-0002ua-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	 <20050630235059.0b7be3de.akpm@osdl.org>
	 <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	 <20050701001439.63987939.akpm@osdl.org>
	 <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <20050701010229.4214f04e.akpm@osdl.org>
	 <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a050701062136435471@mail.gmail.com>
	 <E1DoLxK-0002ua-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > I don't know where 9P "suffers" from being too generic, it's just
> > well-designed and has done a good job of keeping things simple --
> > something that the plethora of over designed, bloated interfaces of
> > today could learn from.
> 
> True.  I very much like the simplicity of the 9P protocol.  But it's
> system independence sometimes makes it fit poorly to the Linux VFS
> interface.  I guess you have a wide experience with this :)
>

Yeah, but most of our problems had less to do with the VFS interface
per se, and more to do with the dcache/page-cache.   In the long run,
the portability is something you may want though -- not only to
provide support under BSD or whatever, but also to insulate changes in
the VFS API from user file servers.
 
> 
> So it's much more important to reduce the number of round-trips for a
> single operation, than multiplexing requests for multiple operations.
>

Agreed, this will be something we'll (v9fs) have to keep a close tab
on to keep things efficient.
 
> > With a proper mux there is no reason why v9fs can't be made as
> > efficient as FUSE - and that's what we intend to demonstrate in
> > v9fs-2.1.  Plus, with v9fs you get the benefit of being able to
> > export your synthetic file systems over the network with no
> > additional copies.
> 
> Yes, but does that matter?  I'm not sure that it's a good idea
> bundling network filesystem functionality together with userspace
> filesystem functionality.  Each has it's own set of requirements, and
> it's own way of working optimally.
> 

I see your point, but increasingly common usage environments are
distributed systems and I think network synthetics will have their
niche.

> What would people say if ext3 was always mounted locally through NFS,
> because the kernel would only provide the NFS filesystem client.

Probably the same thing they would say if ext3 was a user-space
application that always needed to be mounted via FUSE ;)

> 
> Differentiation of interfaces depending on the "closeness" of the
> client to the server makes good sense IMO.  We currently have
> in-kernel and across-network.  FUSE adds in-userspace in between those
> two.
> 

I think that remains to be seen.  There is much to be gained from
blurring the differentiation as we move Linux towards a first-class
distributed system.  If unified interfaces can be made "good-enough"
performance wise, what justifies having multiple interfaces depending
on network versus local?  Specialization has its place, but
performance mongering at the cost of design is what killed systems
research.  In the end, specialization has its place, but I think it's
always worth striving towards unified interfaces when performance
doesn't suffer to a great degree.

> 
> > Further, when you create an infrastructure which is meant to work over
> > a network, you take fewer things for granted -- which ultimately leads
> > to a more robust system capable of dealing with many of these
> > problems.
> 
> Yes.  I'm not speaking agains v9fs, which I think has a valid niche,
> as well as FUSE.
> 

FUSE certainly has its place, and has done a great job creating an
environment in which it is relatively easy to create new file systems
in user-space.  My main point in responding was to take the position
that the v9fs mechanisms are adequate to provide user-space file
systems and that while it was not the primary motivation behind the
v9fs project, we are actively pursuing improving the performance and
robustness of our mechanisms for providing user-space (as well as
kernel-space) file service and developing an SDK to ease the
implementation of 9P-based synthetic file servers.

         -eric
