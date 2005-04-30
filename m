Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVD3LMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVD3LMH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 07:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVD3LMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 07:12:07 -0400
Received: from smtp.istop.com ([66.11.167.126]:27274 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261197AbVD3LLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 07:11:54 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Sat, 30 Apr 2005 07:12:46 -0400
User-Agent: KMail/1.7
Cc: Daniel McNeil <daniel@osdl.org>, David Teigland <teigland@redhat.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Patrick Caulfield <pcaulfie@redhat.com>
References: <20050425165826.GB11938@redhat.com> <200504300509.24887.phillips@istop.com> <20050430103221.GQ21645@marowsky-bree.de>
In-Reply-To: <20050430103221.GQ21645@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504300712.46835.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 April 2005 06:32, Lars Marowsky-Bree wrote:
> > > If it is, what prevents GFS from getting a DLM lock granted and writing
> > > to the shared storage before the node that previously had it is fenced?
> >
> > In my opinion, using the dlm to protect the shared storage resource
> > constitutes tackling the problem far too high up on the food chain.
>
> Au contraire. Something pretty high up the food chain needs to decide
> resource ownership / access permissions.

You confused "high up the food chain" with "being intelligent".  Nothing 
prevents your oldest cluster node from making complex decisions, or calling 
into play other services in order to make those decision.  It could, for 
example, invoke some server on some other node to make the actual decision.

The important thing is to always have an easy _starting point_ for making 
decisions.  I do not think that dlm-based algorithms are suitable in that 
regard, because of the unavoidable code complexity just to kick off the 
process.  And obviously, there already is some reliable starting point or 
cman would not work.  So let's just expose that and have a better cluster 
stack.

> > > PS if an application is writing to local storage, what does it need
> > > a DLM for?
> >
> > Good instinct.  In fact, as I've said before, you don't necessarily
> > need a dlm in a cluster application at all.  What you need is _global
> > synchronization_, however that is accomplished.  For example, I have
> > found it simpler and more efficient to use network messaging for the
> > cluster applications I've tackled so far.   This suggests to me that
> > the dlm is going to end up pretty much as a service needed only by a
> > cfs, and not much else.  The corollary of that is, we should
> > concentrate on making the dlm work well for the cfs, and not get too
> > wrapped up in trying to make it solve every global synchronization
> > problem in the world.
>
> This isn't quite true. It _is_ true that essentially every locking /
> coordination mechanism can be mapped to every other one: locks can be
> implemented via barriers, barriers via locks, locks via messages, global
> ordering via barriers, voting via locks, locks via voting, and then
> there's all the different possible kinds of locks... And internally,
> they might well share certain code paths. (Ie, a DLM electing a
> transition master for lockspace recovery internally via voting, because
> obviously _it_ can't use itself to pull itself out of the mess ;-)

But note that it _can_ use the oldest cluster member as a recovery master, or 
to designate a recovery master.  It can, and should - there is no excuse for 
making this any more complex than it needs to be.

> However, for most problems, there's one approach which makes the problem
> you're dealing with much easier to express, and potentially more
> efficient.

True.  My point is that the sweet spot for cluster synchronization is, in my 
experience, usually _not_ the dlm.

> A good cluster suite should offer support for barriers, locking, voting
> and (group) messaging with extended virtual synchrony, so that the
> problems can be addressed correctly. Compare how the kernel offers more
> than one form for synchronization on SMP systems: semaphores,
> spinlocks, RCU, atomic operations...

All agreed, except that voting and group messaging should be provided as 
separate services in the style of plugins, on which the base cluster 
infrastructure does not depend.

OK, once we have found a way to plug in voting and whiz-bang messaging, I 
think we have discovered the mythical "vcs", the virtual cluster switch.  It 
doesn't need to be in-kernel though.

Regards,

Daniel
