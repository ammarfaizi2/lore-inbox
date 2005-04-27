Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVD0Wjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVD0Wjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVD0Wjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:39:36 -0400
Received: from smtp.istop.com ([66.11.167.126]:1430 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262083AbVD0Whu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:37:50 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 0/7] dlm: overview
Date: Wed, 27 Apr 2005 18:38:18 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20050425151136.GA6826@redhat.com> <200504271600.57993.phillips@istop.com> <20050427202009.GE4431@marowsky-bree.de>
In-Reply-To: <20050427202009.GE4431@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504271838.18441.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 April 2005 16:20, Lars Marowsky-Bree wrote:
> > > - How do the node ids look like? Are they sparse integers, continuous
> > >   ints, uuids, IPv4 or IPv6 address of the 'primary' IP of a node,
> > >   hostnames...?
> >
> > 32 bit integers at the moment.  I hope it stays that way.
>
> You have just excluded a certain number of clustering stacks from
> working. Or at least required them to maintain translation tables. A
> UUID has many nice properties; one of the most important ones being that
> it is inherently unique (and thus doesn't require an adminstrator to
> assign a node id), and that it also happens to be big enough to hold
> anything else you might want to, like the primary IPv6 address of a
> node.

Uuids's at this level are inherently bogus, unless of course you have more 
than 2**32 cluster nodes.  I don't know about you, but I do not have even 
half that many nodes over here.

Translation tables are just the thing for people who can't get by without 
uuids.  (Heck, who needs uuids, just use root's email address.)

> > > - How are the communication links configured? How to tell it which
> > >   interfaces to use for IP, for example?
> >
> > CMAN provides a PF_CLUSTER.  This facility seems cool, but I haven't got
> > much experience with it, and certainly not enough to know if PF_CLUSTER
> > is really necessary, or should be put forth as a required component of
> > the common infrastructure.  It is not clear to me that SCTP can't be used
> > directly, perhaps with some library support.
>
> You've missed the point of my question. I did not mean "How does an
> application use the cluster comm links", but "How is the kernel
> component told which paths/IPs it should use".

I believe cman gives you an address in AF_CLUSTER at the same time it hands 
you your event socket.  Last time I did this, the actual mechanism was buried 
under a wrapper (magma) so I could have that got that slightly wrong.  
Anybody want to clarify?

> > > - How do we actually deliver the membership events - echo "current
> > > node list" >/sys/cluster/gfs/membership or...?
> >
> > This is rather nice: event messages are delivered over a socket.  The
> > specific form of the messages sucks somewhat, as do the wrappers
> > provided.  These need some public pondering.
>
> Again, you've told me how user-space learns about the events. This
> wasn't the question; I was asking how user-space tells the kernel about
> the membership.

Since cman has now moved to user space, userspace does not tell the kernel 
about membership, it just gets a socket+address from cman, which tells cman 
that the node just joined.  Kernel code can also join the cluster if it wants 
to, likewise by poking cman.  I'm not sure exactly how that works now that 
cman has been moved into userspace.  (Hopefully, docs will appear here soon.  
One could also read the posted patches...)

> > Yes.  For the next month or two it should be ambitious enough just to
> > ensure that the interfaces are simple, sane, and known to satisfy the
> > base requirements of everybody with existing cluster code to contribute.
>
> Which is what the above questions were about ;-) heartbeat uses UUIDs
> for node identification; we've got a pretty strict security model, and
> we do not necessarily use IP as the transport mechanism, and our
> membership runs in user-space.

Can we have a list of all the reasons that you cannot wrap your heartbeat 
interface around cman, please?  You will need translation for the UUIDs, you 
will keep your security model as-is (possibly showing everybody how it should 
be done) and you are perfectly free to use whatever transport you wish when 
you are not talking directly to cman.

Factoid: I do not use PF_CLUSTER for synchronization in my block devices, 
simply because regular tcp streams are faster in this context.  As far as I 
know (g)dlm is the only user of PF_CLUSTER for any purpose other than talking 
to cman.

> > I _hope_ that we can arrive at a base membership infrastructure that is
> > convenient to use either from kernel or user space.  User space libraries
> > already exist, but with warts of various sizes.
>
> ... which is why I asked the above questions: User-space needs to
> interface with the kernel to tell it the membership (if the membership
> is user-space driven), or retrieve it (if it is kernel driven).

Passing things around via sockets is a powerful model.  PF_UNIX can even pass 
a socket to kernel, which is how I go about setting up communication for my 
block devices.  I think (g)dlm calls open() from within kernel, something 
like that.  The exact method used to get hold of the appropriate socket is a 
just matter of taste.  Of course, I like to suppose that _my_ method shows 
the most taste of all.

> This implies we need to understand the expected semantics of the kernel,
> and either standarize them, or have a way for user-space to figure out
> which are wanted when interfacing with a particular kernel.

Of course, we could always read the patches...

Regards,

Daniel
