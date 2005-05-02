Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVEBWUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVEBWUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVEBWUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:20:49 -0400
Received: from smtp.istop.com ([66.11.167.126]:27604 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261180AbVEBWUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:20:35 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Mon, 2 May 2005 18:21:49 -0400
User-Agent: KMail/1.7
Cc: Daniel McNeil <daniel@osdl.org>, David Teigland <teigland@redhat.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Patrick Caulfield <pcaulfie@redhat.com>
References: <20050425165826.GB11938@redhat.com> <200504300712.46835.phillips@istop.com> <20050502205135.GC4722@marowsky-bree.de>
In-Reply-To: <20050502205135.GC4722@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505021821.49699.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 May 2005 16:51, Lars Marowsky-Bree wrote:
> On 2005-04-30T07:12:46, Daniel Phillips <phillips@istop.com> wrote:
> > process.  And obviously, there already is some reliable starting point or
> > cman would not work.  So let's just expose that and have a better cluster
> > stack.
>
> Most memberships internally construct such a fixed starting point from
> voting or other 'chatty' techniques.

But running a whole voting algorithm from square one makes no sense at all, 
because cman has already taken care of the first step.  Cman just fails to 
expose the result in the obvious way.  (I believe this remains the case in 
the current code - Patrick, could you confirm or deny please, and could we 
please have a pointer to the latest incarnation of cman?).

Now, please actually take a look at one of those voting schemes and chances 
are, you'll just see a perverse way of picking the lowest-numbered node.  But 
cman already knows which one that is, and even better, it knows the exact 
order each node joined the cluster.  So does every other node!

So we can just allow the oldest cluster node to supervise a full-fancy 
election (if indeed anything fancy is needed) or if it is too lazy for that, 
merely to designate the actual election master and then go back to whatever 
it was doing.  In this way, we compress dozens of lines of 
hard-to-read-and-maintain boilerplate cluster code running on multiple nodes 
and taking up valuable recovery time... into... _nothing_.

See?

So let's lose the "chatty" code and use the sensible, obvious approach that 
cman already uses for itself.

> This is exposed by the membership (providing all nodes in the same order
> on all nodes), however the node level membership does not necessarily
> reflect the service/application level membership. So to get it right,
> you essentially have to run such an algorithm at that level again too.

Yessirree!  But please lets get the easy base-level thing above out of the way 
first, then we can take a good hard look at how service groups need to work 
in order to be simple, sane, etc.  Note: what we want is not so different 
from how cman _already_ handles service groups.  Basically: take the oldest 
node concept (aka stable node enumeration) and apply it to service groups as 
well.  Then we need events from the service groups, just like the main 
cluster membership (which is in effect, an anonymous service group that all 
cluster nodes must join before they can join any other service group).  To be 
sure, cman is more-or-less designed _and documented_ this way already - we 
just need to do a few iterative improvements to turn it into a truly sensible 
gizmo.

> True enough it would be helpful if the group membership service provided
> such, but here we're at the node level.

It does, we just need to extract the diamond from the, ehm, rough ground.

> > But note that it _can_ use the oldest cluster member as a recovery
> > master, or to designate a recovery master.  It can, and should - there
> > is no excuse for making this any more complex than it needs to be.
>
> The oldest node might not be running that particular service, or it
> might not be healthy. To figure that out, you need to vote.

Not necessary!  Remember, we also have service groups.  Membership in each 
service group can (read: should) follow the same rules as cluster membership, 
and offers a similar, stable enumeration.  That is, the oldest member of each 
service group is, by default, the boss.  Therefore, except for certain 
recovery intervals that have to be handled by barriers, every node in the 
cluster always knows the identity of the boss of a particular service group.

> This is straying a bit from LKML issues, maybe it ought to be moved to
> one of the clustering lists.

It is very much on-topic here, and thankyou for driving it.

The reason this infrastructure track is on topic is, without this background, 
no core maintainer has the context they need to know why we think things 
should be done one way versus another in (g)dlm, let alone the incoming gfs 
code.

In the end, we will hatch a lovely kernel API, but not if we cluster mavens 
are the only ones who actually have a sense of direction.  Left to discuss 
the issues only amongst ourselves, we would likely end up with little more 
than eternal out-of-tree status.

Regards,

Daniel
