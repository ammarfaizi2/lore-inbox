Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVD3KdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVD3KdH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 06:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVD3KdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 06:33:06 -0400
Received: from gate.in-addr.de ([212.8.193.158]:55192 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261182AbVD3Kcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 06:32:33 -0400
Date: Sat, 30 Apr 2005 12:32:21 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>, Daniel McNeil <daniel@osdl.org>
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050430103221.GQ21645@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com> <20050429040104.GB9900@redhat.com> <1114815509.18352.200.camel@ibm-c.pdx.osdl.net> <200504300509.24887.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504300509.24887.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-30T05:09:24, Daniel Phillips <phillips@istop.com> wrote:

> And indeed, instinct turns out to be correct: there is a far simpler
> way to handle this: let the oldest member of the cluster decide who
> owns the metadata resources.  This is simple, unambiguous, fast,
> efficient, easy to implement and obviously correct.  And it has
> nothing to do with the dlm, it relies only on cman.  Or it would, if
> cman supported a stable ordering of cluster node longevity, which I do
> not think it does.  (Please correct me if I'm wrong, Patrick.)
> 
> So this is easy: fix cman so that it does support a stable ordering of
> cluster node membership age, if it does not already.

This is actually a property the Concensus Cluster Membership layer in
heartbeat provides.

Also, this was how I originally intended the master to coordinate
resource recovery: rely on the global ordering of nodes provided by the
CCM layer and just pick the first one. So, I'm with you on the general
direction ;-)

However, further thinking has shown this to not be a really good idea.
The principle is sound, but the oldest node might not be running the
newest version of the software, or just because the node shows up in the
node membership doesn't imply it's running the piece of software in
question at all (in the absence of group membership/services). And,
after a merge, one of the two (or more) masters better stop doing what
it's doing right now and hand over to the new one, so there's the need
for a barrier.

So, CRM now employs a voting algorithm as part of the application level
join protocol, which is designed to make sure that a) only nodes which
actually run our piece of software participate, and b) the node with the
most recent software release wins. (Plus some other parameters, ie, if
several nodes run that software, the "age", intactness and uptodateness
of local configuration copies etc also play in.)

The property b) is particularly interesting: It simplifies version
compatibility a whole lot, because we only need to implement backwards
compatibility for the master to client (as for that particular
transition) code path, not for the client-to-master path.

While we obviously don't have much experience with backwards
compatibility yet (I was thinking about introducing a deliberate
non-backwards compatible change somewhere in the development series just
to test that ;-), the other properties have been very good so far.

> > If it is, what prevents GFS from getting a DLM lock granted and writing
> > to the shared storage before the node that previously had it is fenced?
> In my opinion, using the dlm to protect the shared storage resource 
> constitutes tackling the problem far too high up on the food chain.

Au contraire. Something pretty high up the food chain needs to decide
resource ownership / access permissions.

> > PS if an application is writing to local storage, what does it need
> > a DLM for?
> Good instinct.  In fact, as I've said before, you don't necessarily
> need a dlm in a cluster application at all.  What you need is _global
> synchronization_, however that is accomplished.  For example, I have
> found it simpler and more efficient to use network messaging for the
> cluster applications I've tackled so far.   This suggests to me that
> the dlm is going to end up pretty much as a service needed only by a
> cfs, and not much else.  The corollary of that is, we should
> concentrate on making the dlm work well for the cfs, and not get too
> wrapped up in trying to make it solve every global synchronization
> problem in the world.

This isn't quite true. It _is_ true that essentially every locking /
coordination mechanism can be mapped to every other one: locks can be
implemented via barriers, barriers via locks, locks via messages, global
ordering via barriers, voting via locks, locks via voting, and then
there's all the different possible kinds of locks... And internally,
they might well share certain code paths. (Ie, a DLM electing a
transition master for lockspace recovery internally via voting, because
obviously _it_ can't use itself to pull itself out of the mess ;-)

However, for most problems, there's one approach which makes the problem
you're dealing with much easier to express, and potentially more
efficient.

A good cluster suite should offer support for barriers, locking, voting
and (group) messaging with extended virtual synchrony, so that the
problems can be addressed correctly. Compare how the kernel offers more
than one form for synchronization on SMP systems: semaphores,
spinlocks, RCU, atomic operations...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

