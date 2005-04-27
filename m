Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVD0UUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVD0UUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVD0UUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:20:33 -0400
Received: from gate.in-addr.de ([212.8.193.158]:48067 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261614AbVD0UUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:20:17 -0400
Date: Wed, 27 Apr 2005 22:20:09 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050427202009.GE4431@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com> <200504260130.17016.phillips@istop.com> <20050427135635.GA4431@marowsky-bree.de> <200504271600.57993.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504271600.57993.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-27T16:00:57, Daniel Phillips <phillips@istop.com> wrote:

> > Questions which need to be settled, or which the API at least needs to
> > export so we know what is expected from us:
> >
> > - How do the node ids look like? Are they sparse integers, continuous
> >   ints, uuids, IPv4 or IPv6 address of the 'primary' IP of a node,
> >   hostnames...?
> 32 bit integers at the moment.  I hope it stays that way.

You have just excluded a certain number of clustering stacks from
working. Or at least required them to maintain translation tables. A
UUID has many nice properties; one of the most important ones being that
it is inherently unique (and thus doesn't require an adminstrator to
assign a node id), and that it also happens to be big enough to hold
anything else you might want to, like the primary IPv6 address of a
node.

We've had that discussion on the OCF list, and I think that was one of
the few really good ones.

> > - How are the communication links configured? How to tell it which
> >   interfaces to use for IP, for example?
> CMAN provides a PF_CLUSTER.  This facility seems cool, but I haven't got much 
> experience with it, and certainly not enough to know if PF_CLUSTER is really 
> necessary, or should be put forth as a required component of the common 
> infrastructure.  It is not clear to me that SCTP can't be used directly, 
> perhaps with some library support.

You've missed the point of my question. I did not mean "How does an
application use the cluster comm links", but "How is the kernel
component told which paths/IPs it should use".

> > - How do we actually deliver the membership events - echo "current
> > node list" >/sys/cluster/gfs/membership or...?
> This is rather nice: event messages are delivered over a socket.  The
> specific form of the messages sucks somewhat, as do the wrappers
> provided.  These need some public pondering.

Again, you've told me how user-space learns about the events. This
wasn't the question; I was asking how user-space tells the kernel about
the membership.

> > - What kind of semantics are expected: Can we deliver the membership
> >   events as they come, do we need to introduce suspend/resume barriers
> >   etc?
> Suspend/resume barriers take the form of a simple message protocol, 
> administered by CMAN.

Not what I asked; see the discussion with David.

> > - How to security credentials play into this, and where are they
> >   enforced - so that a user-space app doesn't mess with kernel locks?
> Security?  What is that?  (Too late for me to win that dinner now...)
> Security is currently provided by restricting socket access to root.

So you'd expect a user-level suid daemon of sorts to wrap around this.
Fair enough.

> Yes.  For the next month or two it should be ambitious enough just to ensure 
> that the interfaces are simple, sane, and known to satisfy the base 
> requirements of everybody with existing cluster code to contribute. 

Which is what the above questions were about ;-) heartbeat uses UUIDs
for node identification; we've got a pretty strict security model, and
we do not necessarily use IP as the transport mechanism, and our
membership runs in user-space.

The automagic aspects are the icing on the cake ;-)

> > Or maybe these will be abstracted by user-space wrapper libraries, and
> > everybody does in the kernel what they deem best.
> I _hope_ that we can arrive at a base membership infrastructure that is 
> convenient to use either from kernel or user space.  User space libraries 
> already exist, but with warts of various sizes.

... which is why I asked the above questions: User-space needs to
interface with the kernel to tell it the membership (if the membership
is user-space driven), or retrieve it (if it is kernel driven).

This implies we need to understand the expected semantics of the kernel,
and either standarize them, or have a way for user-space to figure out
which are wanted when interfacing with a particular kernel.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

