Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265716AbUGHBKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbUGHBKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbUGHBKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:10:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265716AbUGHBHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:07:13 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Wed, 7 Jul 2004 21:14:07 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Lon Hohberger <lhh@redhat.com>,
       David Teigland <teigland@redhat.com>
References: <200407050209.29268.phillips@redhat.com> <200407061734.51023.phillips@redhat.com> <20040707181650.GD12255@marowsky-bree.de>
In-Reply-To: <20040707181650.GD12255@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407072114.07291.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 July 2004 14:16, Lars Marowsky-Bree wrote:
> On 2004-07-06T17:34:51, Daniel Phillips <phillips@redhat.com> said:
> > > And the "industry" was very reluctant
> > > too. Which meant that everybody spend ages talking and not much
> > > happening.
> >
> > We're showing up with loads of Sistina code this time.  It's up to
> > everybody else to ante up, and yes, I see there's more code out
> > there. It's going to be quite a summer reading project.
>
> Yeah, I wish you the best. There's always been quite a bit of code to
> show, but that alone didn't convince people ;-) I've certainly grown
> a bit more experienced / cynical during that time. (Which, according
> to Oscar Wilde, is the same anyway ;)

OK, what I've learned from the discussion so far is, we need to avoid 
getting stuck too much on the HA aspects and focus more on the 
cluster/performance side for now.  There are just too many entrenched 
positions on failover.  Even though every component of the cluster is 
designed to fail over, that's just a small part of what we have to deal 
with:

  - Cluster Volume management
  - Cluster configuration management
  - Cluster membership/quorum
  - Node Fencing
  - Parallel cluster filesystems with local semantics
  - Distributed Locking
  - Cluster mirror block device
  - Cluster snapshot block device
  - Cluster administration interface, including volume managment
  - Cluster resource balancing
  - bits I forgot to mention

Out of that, we need to pick the three or four items we're prepared to 
address immediately, that we can obviously share between at least two 
known cluster filesystems, and get them onto lkml for peer review.  
Trying to push the whole thing as one lump has never worked for 
anybody, and won't work in this case either.  For example, the DLM is 
fairly non-controversial, and important in terms of performance and 
reliability.  Let's start with that.

Furthermore, nobody seems interested in arguing about the cluster block 
devices either, so lets just discuss how they work and get them out of 
the way.

Then let's tackle the low level infrastructure, such as CCS (Cluster 
Configuration System) that does a simple job, that is, it distributes 
configuration files racelessly.

I heard plenty of fascinating discussion of quorum strategies last 
night, and have a number of papers to read as a result.  But that's a 
diversion: it can and must be pluggable.  We just need to agree on how 
the plugs work, a considerably less ambitious task.

In general, the principle is: the less important it is, the more 
argument there will be about it.  Defer that, make it pluggable, call 
it policy, push it to user space, and move on.  We need to agree on the 
basics so that we can manage network volumes with cluster filesystems 
on top of them.

> > I can believe it.  What I have just done with my cluster snapshot
> > target over the last couple of weeks is, removed _every_ dependency
> > on cluster infrastructure and moved the one remaining essential
> > interface to user space.
>
> Is there a KS presentation on this? I didn't get invited to KS and
> will just be allowed in for OLS, but I'll be around town already...

There will be a BOF at OLS, "Cluster Infrastructure".  Since I didn't 
get a KS invite either and what remains is more properly lkml stuff 
anyway, I will go canoing with Matt O'Keefe during KS as planned.  We 
already did the necessary VFS fixups over the last year (save the 
non-critical flock patch, which is now in play) so there is nothing 
much left to beg Linus for.  There are additional VFS hooks that would 
be nice to have for optimization, but they can wait, people will 
appreciate them more that way ;)

The non-vfs cluster infrastructure just uses the normal module API, 
except for a couple of places in the DM cluster block devices where 
I've allowed myself some creative license, easily undone.  Again, this 
is lkml material, not KS stuff.

> > It looks like fencing is more of an issue, because having several
> > node fencing systems running at the same time in ignorance of each
> > other is deeply wrong.  We can't just wave our hands at this by
> > making it pluggable, we need to settle on one that works and use
> > it.  I'll humbly suggest that Sistina is furthest along in this
> > regard.
>
> Your fencing system is fine with me; based on the assumption that you
> always have to fence a failed node, you are doing the right thing.
> However, the issues are more subtle when this is no longer true, and
> in a 1:1 how do you arbitate who is allowed to fence?

Good question.  Since two-node clusters are my primary interest at the 
moment, I need some answers.  I think the current plan is: they try to 
fence each other, winner take all.  Each node will introspect to decide 
if it's in good enough shape to do the job itself, then go try to fence 
the other one.  Alternatively, they can be configured so that one has 
more votes than the other, if somebody wants that broken arrangement.  

This is my dim recollection, I'll have more to say when I've actually 
hooked my stuff up to it.  There are others with plenty of experience 
in this, see below.

> > Cluster resource management is the least advanced of the components
> > that our Red Hat Sistina group has to offer, mainly because it is
> > seen as a matter of policy, and so the pressing need at this state
> > is to provide suitable hooks.
> >
> > "STOMITH" :)  Yes, exactly.  Global load balancing is another big
> > item, i.e., which node gets assigned the job of running a
> > particular service, which means you need to know how much of each
> > of several different kinds of resources a particular service
> > requires, and what the current resource usage profile is for each
> > node on the cluster.  Rik van Riel is taking a run at this.
>
> Right, cluster resource management is one of the things where I'm
> quite happy with the approach the new heartbeat resource manager is
> heading down (or up, I hope ;).

Combining heartbeat and resource management sounds like a good idea.  
Currently, we have them separate and since I have not tried it myself 
yet, I'll reserve comment.  Dave Teigland would be more than happy to 
wax poetic, though.

> > It's a huge, scary problem.  We _must_ be able to plug in different
> > solutions, all the way from completely manual to completely
> > automagic, and we have to be able to handle more than one at once.
>
> You can plug multiple ones as long as they are managing independent
> resources, obviously. However, if the CRM is the one which ultimately
> decides whether a node needs to be fenced or not - based on its
> knowledge of which resources it owns or could own - this gets a lot
> more scary still...

We do not see the CRM as being involved in fencing at present, though I 
can see why perhaps it ought to be.  The resource manager that Lon 
Hohberger is cooking up is scriptable and rule-driven.  I'm sure we 
could spend 100% of the available time on that alone.  My strategy is, 
I send my manually-configurable cluster bits to Lon and he hooks them 
in so everything is automagic, then I look at how much the end result 
sucks/doesn't suck.

There's some philosophy at work here: I feel that any cluster device 
that requires elaborate infrastructure and configuration to run is 
broken.  If you can set the cluster devices up manually and they depend 
only on existing kernel interfaces, they're more likely to get unit 
testing.  At the same time, these devices have to fit well into a 
complex infrastructure, therefore the manual interface can be driven 
equally well by a script or C program, and there is one tiny but 
crucial additional hook to allow for automatic reconnection to the 
cluster if something bad happens, or if the resource manager just feels 
the need to reorganize things.

So while I'm rambling here, I'll mention that the resource manager (or 
anybody else) can just summarily cut the block target's pipe and the 
block target will politely go ask for a new one.  No IOs will be 
failed, nothing will break, no suspend needed, just one big breaker 
switch to throw.  This of course depends on the target using a pipe 
(socket) to communicate with the cluster, but even if I do switch to 
UDP, I'll still keep at least one pipe around, just because it makes 
the target so easy to control.

It didn't start this way.  The first prototype had a couple thousand 
lines of glue code to work with various possible infrastructures.  Now 
that's all gone and there are just two pipes left, one to local user 
space for cluster management and the other to somewhere out on the 
cluster for synchronization.  It's now down to 30% of the original size 
and runs faster as a bonus.  All cluster interfaces are "read/write", 
except for one ioctl to reconnect a broken pipe.

> > Incidently, there is already a nice crosssection of the cluster
> > community on the way to sunny Minneapolis for the July meeting. 
> > We've reached about 50% capacity, and we have quorum, I think :-)
>
> Uhm, do I have to be frightened of being fenced? ;)

Only if you drink too much of that kluster Koolaid

Regards,

Daniel
