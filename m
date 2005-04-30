Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVD3JIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVD3JIh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 05:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVD3JIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 05:08:37 -0400
Received: from smtp.istop.com ([66.11.167.126]:27272 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261164AbVD3JId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 05:08:33 -0400
From: Daniel Phillips <phillips@istop.com>
To: Daniel McNeil <daniel@osdl.org>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Sat, 30 Apr 2005 05:09:24 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, Lars Marowsky-Bree <lmb@suse.de>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Patrick Caulfield <pcaulfie@redhat.com>
References: <20050425165826.GB11938@redhat.com> <20050429040104.GB9900@redhat.com> <1114815509.18352.200.camel@ibm-c.pdx.osdl.net>
In-Reply-To: <1114815509.18352.200.camel@ibm-c.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504300509.24887.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 April 2005 18:58, Daniel McNeil wrote:
> I have always thought that an distributed application could use the DLM
> alone to protect access to shared storage.   The DLM would coordinate
> access between the distributed application running on the nodes
> in the cluster AND DLM locks would not be recovered and possibly
> granted to applications running on the nodes still in the membership
> until after nodes that are no longer a member of the cluster are safely
> prevented from doing any harm.

As you know, this is how I currently determine ownership of such resources as  
cluster snapshot metadata and ddraid dirty log.  I find the approach 
distinctly unsatisfactory.  The (g)dlm is rather verbose to use, particularly 
taking into the account the need to have two different state machine paths, 
depending on whether a lock happens to master locally or not, and the need to 
coordinate a number of loosely coupled elements: lock status blocks, asts, 
the calls themselves.  The result is quite a _long_ and opaque program to do 
a very simple thing.  It is full of long chains of reasoning, connected with 
the behavior of lvbs, asynchronous lock event flow, error behavior, myriad 
other details.  This just _feels wrong_ and the code looks ugly, no matter 
how much I try to dress it up.

And indeed, instinct turns out to be correct: there is a far simpler way to 
handle this: let the oldest member of the cluster decide who owns the 
metadata resources.  This is simple, unambiguous, fast, efficient, easy to 
implement and obviously correct.  And it has nothing to do with the dlm, it 
relies only on cman.  Or it would, if cman supported a stable ordering of 
cluster node longevity, which I do not think it does.  (Please correct me if 
I'm wrong, Patrick.)

So this is easy: fix cman so that it does support a stable ordering of cluster 
node membership age, if it does not already.

> So, when I said that the DLM was dependent on fencing, I was thinking
> of the membership, quorum, prevention of harm (stalling of i/o to
> prevent corrupting shared resource) as described above.
>
> So, if an application was using your DLM to protect shared storage,
> I think you are saying it possible the DLM lock could be granted
> before the node that was previously holding the lock and now is not
> part of the cluster is fenced.  Is that right?
>
> If it is, what prevents GFS from getting a DLM lock granted and writing
> to the shared storage before the node that previously had it is fenced?

In my opinion, using the dlm to protect the shared storage resource 
constitutes tackling the problem far too high up on the food chain.

> PS if an application is writing to local storage, what does it need a
> DLM for?

Good instinct.  In fact, as I've said before, you don't necessarily need a dlm 
in a cluster application at all.  What you need is _global synchronization_, 
however that is accomplished.  For example, I have found it simpler and more 
efficient to use network messaging for the cluster applications I've tackled 
so far.   This suggests to me that the dlm is going to end up pretty much as 
a service needed only by a cfs, and not much else.  The corollary of that is, 
we should concentrate on making the dlm work well for the cfs, and not get 
too wrapped up in trying to make it solve every global synchronization 
problem in the world.

Regards,

Daniel
