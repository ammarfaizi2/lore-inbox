Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVEEM0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVEEM0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVEEM0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:26:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262075AbVEEM0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:26:17 -0400
Subject: Re: [PATCH 1b/7] dlm: core locking
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Stephen Tweedie <sct@redhat.com>, Daniel McNeil <daniel@osdl.org>,
       David Teigland <teigland@redhat.com>, Lars Marowsky-Bree <lmb@suse.de>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Patrick Caulfield <pcaulfie@redhat.com>
In-Reply-To: <200504300509.24887.phillips@istop.com>
References: <20050425165826.GB11938@redhat.com>
	 <20050429040104.GB9900@redhat.com>
	 <1114815509.18352.200.camel@ibm-c.pdx.osdl.net>
	 <200504300509.24887.phillips@istop.com>
Content-Type: text/plain
Message-Id: <1115295930.1988.229.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 05 May 2005 13:25:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2005-04-30 at 10:09, Daniel Phillips wrote:

> As you know, this is how I currently determine ownership of such resources as  
> cluster snapshot metadata and ddraid dirty log.  I find the approach 
> distinctly unsatisfactory.  The (g)dlm is rather verbose to use, particularly 
> taking into the account the need to have two different state machine paths, 
> depending on whether a lock happens to master locally or not, and the need to 
> coordinate a number of loosely coupled elements: lock status blocks, asts, 
> the calls themselves.  The result is quite a _long_ and opaque program to do 
> a very simple thing.

Why on earth do you need to care where a lock is mastered?  Use of ASTs
etc. should be optional, too --- you can just use blocking variants of
the lock primitives if you want.  There's a status block, sure, but you
can call the lock grant function synchronously and the status block is
guaranteed unambiguously to be filled on return.  

So the easy way to use the DLM for metadata ownership is simply to have
a thread which tries, synchronously, to acquire an EX lock on a
resource.  You get it or you stay waiting; when you get it, you own the
metadata.  Pretty simple.  (The only real complication in this
particular case is how to deal with the resource going away while you
wait, eg. unmount.)

> And indeed, instinct turns out to be correct: there is a far simpler way to 
> handle this: let the oldest member of the cluster decide who owns the 
> metadata resources.

Deciding who owns it is one thing.  You still need the smarts to work
out if recovery is *already* in progress somewhere, and to coordinate
wakeup of whoever you've granted the new metadata ownership to, etc. 
Using a lock effectively gets you much of that for free, once you've
done the work to acquire the EX lock in the first place.

> Good instinct.  In fact, as I've said before, you don't necessarily need a dlm 
> in a cluster application at all.  What you need is _global synchronization_, 
> however that is accomplished.  For example, I have found it simpler and more 
> efficient to use network messaging for the cluster applications I've tackled 
> so far.

Yes, there is definitely room for both.  In particular, the more your
application looks like client/server, the less appropriate a DLM is.

>    This suggests to me that the dlm is going to end up pretty much as 
> a service needed only by a cfs, and not much else.

But once you've got a CFS, it suddenly becomes possible to do so much
more in user-space in a properly distributed fashion, rather than via
client/server.  Cluster-wide /etc/passwd?  Just lock for read, access
the file, unlock.  Things like shared batch/print queues become easier. 
And using messaging is often completely the wrong model for such things,
simply because there's no server to send the message to.  A DLM will
often be a far better fit for such applications.

> The corollary of that is, 
> we should concentrate on making the dlm work well for the cfs, and not get 
> too wrapped up in trying to make it solve every global synchronization 
> problem in the world.

Trouble is, I think you're mixing problems here.  There are two
different problems: whether the DLM locking model is a good primitive to
use for a given case; and whether the specific DLM API in question is a
good fit for the model itself.

And your initial complaints about needing to know local vs. remote
master, dealing with ASTs etc. are really complaints about the API, not
the model.  Using blocking, interruptible APIs gets rid of the AST issue
entirely for applications that don't need that level of complexity.  And
you obviously want to have an API variant that doesn't care where the
lock gets mastered --- for one thing, a remotely mastered lock can turn
into a locally mastered one after a cluster membership transition.

So let's keep the two separate.  Sure, there will be cases where a DLM
model is more or less appropriate; but given that there are cases where
the model does work, what are the particular unnecessary complications
that the current API forces on us?  Remove those and you've made the DLM
model a lot more attractive to use for non-CFS applications.

--Stephen


