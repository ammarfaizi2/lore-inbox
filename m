Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVD1O5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVD1O5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 10:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVD1O5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 10:57:36 -0400
Received: from gate.in-addr.de ([212.8.193.158]:2785 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262012AbVD1O5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 10:57:22 -0400
Date: Thu, 28 Apr 2005 16:57:15 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050428145715.GA21645@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com> <200504271600.57993.phillips@istop.com> <20050427202009.GE4431@marowsky-bree.de> <200504271838.18441.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504271838.18441.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-27T18:38:18, Daniel Phillips <phillips@istop.com> wrote:

> Uuids's at this level are inherently bogus, unless of course you have more 
> than 2**32 cluster nodes.  I don't know about you, but I do not have even 
> half that many nodes over here.

This is not quite the argument. With that argument, 16 bit would be
fine. And even then, I'd call you guilty of causing my lights to flicker
;-)

The argument about UUIDs goes a bit beyond that: No admin needed to
assign them; they can stay the same even if clusters/clusters merge (in
theory); they can be used for inter-cluster addressing too, because they
aren't just unique within a single cluster (think clusters of clusters,
grids etc, whatever the topology), and finally, UUID is a big enough
blob to put all other identifiers in, be it a two bit node id, a
nodename, 32bit IPv4 address or a 128bit IPv6.

This piece is important. It defines one of the fundamental objects in
the API.

I recommend you read up on the discussions on the OCF list on this; this
has probably been one of the hottest arguments.

> > > > - How are the communication links configured? How to tell it which
> > > >   interfaces to use for IP, for example?
> > >
> > > CMAN provides a PF_CLUSTER.  This facility seems cool, but I haven't got
> > > much experience with it, and certainly not enough to know if PF_CLUSTER
> > > is really necessary, or should be put forth as a required component of
> > > the common infrastructure.  It is not clear to me that SCTP can't be used
> > > directly, perhaps with some library support.
> >
> > You've missed the point of my question. I did not mean "How does an
> > application use the cluster comm links", but "How is the kernel
> > component told which paths/IPs it should use".
> 
> I believe cman gives you an address in AF_CLUSTER at the same time it hands 
> you your event socket.  Last time I did this, the actual mechanism was buried 
> under a wrapper (magma) so I could have that got that slightly wrong.  
> Anybody want to clarify?

This still doesn't answer the question. You're telling me how I get my
address in AF_CLUSTER. I was asking, again: "How is the kernel component
configured which paths/IP to use" - ie, the equivalent of ifconfig/route
for the cluster stack, if you so please.

Doing this in a wrapper is one answer - in which case we'd have a
consistent user-space API provided by shared libraries wrapping a
specific kernel component. This places the boundary in user-space.

This seems to be a main point of contention, also applicable to the
first question about node identifiers: What does the kernel/user-space
boundary look like, and is this the one we are aiming to clarify?

Or do we place the boundary in user-space with a specific wrapper around
a given kernel solution.

I can see both or even a mix, but it's an important question.

> Since cman has now moved to user space, userspace does not tell the kernel 
> about membership, 

That partial sentence already makes no sense. So how does the kernel
(DLM in this case) learn about whether a node is assumed to be up or
down if the membership is in user-space? Right! User-space must tell
it.

Again, this is sort of the question of where the API boundary between
published/internal is.

For example, with OCFS2 (w/user-space membership, which it doesn't yet
have, but which they keep telling me is trivial to add, but we're
busying them with other work right now ;-) it is supposed to work like
this: When a membership event occurs, user-space transfers this event
to the kernel by writing to a configfs mount.

Likewise, the node ids and comm links the kernel DLM uses with OCFS2
are configured via that interface.

If we could standarize at the kernel/user-space boundary for clustering,
like we do for syscalls, this would IMHO be cleaner than having
user-space wrappers.

> Can we have a list of all the reasons that you cannot wrap your heartbeat 
> interface around cman, please? 

Any API can be mapped to any other API. That wasn't the question. I was
aiming at the kernel/user-space boundary again.

> > ... which is why I asked the above questions: User-space needs to
> > interface with the kernel to tell it the membership (if the membership
> > is user-space driven), or retrieve it (if it is kernel driven).
> Passing things around via sockets is a powerful model.

Passing a socket in to use for communication makes sense. "I want you to
use this transport when talking to the cluster". However, that begs the
question whether you're passing in a unicast peer-to-peer socket or a
multicast one which reaches all of the nodes, and what kind of
security, ordering, and reliability guarantees that transport needs to
provide.

Again, this is (from my side) about understanding the user-space/kernel
boundary, and the APIs used within the kernel.

> > This implies we need to understand the expected semantics of the kernel,
> > and either standarize them, or have a way for user-space to figure out
> > which are wanted when interfacing with a particular kernel.
> Of course, we could always read the patches...

Reading patches is fine for understanding syntax, and spotting some
nits. I find actual discussion with the developers to be invaluable to
figure out the semantics and the _intention_ of the code, which takes
much longer to deduce from the code alone; and you know, just sometimes
the code doesn't actually reflect the intentions of the programmers who
wrote it ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

