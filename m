Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVD1Ntk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVD1Ntk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 09:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVD1Ntb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 09:49:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:948 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262135AbVD1NtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 09:49:13 -0400
Subject: Re: [PATCH 1a/7] dlm: core locking
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Teigland <teigland@redhat.com>
Cc: Stephen Tweedie <sct@redhat.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050428034550.GA10628@redhat.com>
References: <20050425165705.GA11938@redhat.com>
	 <20050427214136.GC938@ca-server1.us.oracle.com>
	 <20050428034550.GA10628@redhat.com>
Content-Type: text/plain
Message-Id: <1114696137.1920.32.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 28 Apr 2005 14:48:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-04-28 at 04:45, David Teigland wrote:

> A comment in _can_be_granted() quotes the VMS rule:
> 
> "By default, a new request is immediately granted only if all three of the
> following conditions are satisfied when the request is issued:
> 
> - The queue of ungranted conversion requests for the resoure is empty.
> - The queue of ungranted new requests for the resource is empty.
> - The mode of the new request is compatible with the most
>   restrictive mode of all granted locks on the resource."

Right.  It's a fairness issue.  If you've got a read lock, then a new
read lock request *can* be granted immediately; but if there are write
lock requests on the queue (and remember, those may be on other nodes,
you can't tell just from the local node state), then granting new read
locks immediately can lead to writer starvation.

By default NL requests just follow the same rule, but because it's
always theoretically possible to grant NL immediately, you can expedite
it.  And NL is usually used for one of two reasons: either to pin the
lock value block for the resource in the DLM, or to keep the resource
around while it's unlocked for performance reasons (resources are
destroyed when there are no more locks against them; a NL lock keeps the
resource present, so new lock requests can be granted much more
quickly.)  In both of those cases, observing the normal lock ordering
rules is irrelevant.

> > Where's the LKM_LOCAL equivalent? What happens a dlm user wants to create a
> > lock on a resource it knows to be unique in the cluster (think file creation
> > for a cfs)? Does it have to hit the network for a resource lookup on those
> > locks?

That is always needed if you've got a lock directory model --- you have
to have, at minimum, a communication with the lock directory node for
the given resource (which might be the local node if you're lucky). 
Even if you know the resource did not previously exist, you still need
to tell the directory node that it *does* exist now so that future users
can find it.  

I suppose you could short-cut the wait for the response, though, to
reduce the latency for this case.  My gut feeling, though, is that I'd
still prefer to see the DLM doing its work properly, cluster-wide in
this case, as precaution against accidents if we get inconsistent states
on disk leading to two nodes trying to create the same lock at once. 
Experience suggests that such things *do* go wrong, and it's as well to
plan for them --- early detection is good!

--Stephen


