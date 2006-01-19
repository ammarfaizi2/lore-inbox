Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWASDdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWASDdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWASDdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:33:42 -0500
Received: from mx1.rowland.org ([192.131.102.7]:57612 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1161009AbWASDdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:33:42 -0500
Date: Wed, 18 Jan 2006 22:33:40 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@davemloft.net>, <bcrl@kvack.org>, <akpm@osdl.org>,
       <sekharan@us.ibm.com>, <kaos@sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
In-Reply-To: <1137625585.1760.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0601182204090.18293-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Benjamin LaHaise wrote:

> On Wed, Jan 18, 2006 at 05:09:10PM -0500, Alan Stern wrote:
> > On Wed, 18 Jan 2006, Benjamin LaHaise wrote:
> > 
> > > The notifier interface is supposed to be *light weight*.
> > 
> > Again, where is that documented?
> 
> Read the kernel.  Notifiers are called from all sorts of hot paths, so they 
> damned well better be light.

_Some_ notifiers better be light.  Others can be heavier.  And it sure 
would be a good thing to indicate in the code which are which.  That's a 
lot better than trying to read and understand the entire kernel in order 
to gather impressions about how a certain class of routines is used.

In the patch we classified chains as blocking or atomic based on how they
were used, not on how often they get called.  The patch includes a
provision specifically for lightweight notifiers: the raw notifier type.  
If you want to identify which chains should be switched over to the raw
type, then fine.  But _you_ will have to provide protection for them.

> > Which is worse: overhead due to cache misses or an oops caused by code 
> > being called after it was unloaded?
> 
> Given that the overhead need not be present at all, neither.
> 
> > Do you have a better proposal for a way to prevent blocking notifier 
> > chains from being modified while in use?  Or would you prefer to rewrite 
> > all the callout routines that currently block, so that all the notifier 
> > chains can be made atomic and we don't need the blocking notifier API?
> 
> Easy: in register_notifier stuff a serial number for each entry put on 
> a notifier chain.  Remember the serial number of the entry before performing 
> ->notifier_call in notifier_call_chain.  Upon return, if the chain has been 
> modified (easy to detect by nature of the serial number changing), walk 
> the chain looking for the entry following the last serial number run.  Voila, 
> rcu can be used to protect the chain's contents.

What happens if the last serial number run is no longer on the chain?  
You would never find it, and so would never know where to pick up from.  
And what happens if the chain is changed while you are checking (or just
after you have checked) the serial number?  There's still a race.

You see?  Doing this correctly is not so easy after all...

If you think about it a little more carefully, you'll see why.  To be
safe, unregistration has to guarantee when it returns that the entry being
removed is not in use and will not be called in the future.  If other CPUs
are traversing the chain in a lightweight fashion, the only way you can
fulfill this guarantee is to wait until all the current traversers have 
finished, a la RCU.  And if the traversers can sleep, the simplest way to 
wait for them is to use an rwsem.


On Wed, 18 Jan 2006, Alan Cox wrote:

> On Mer, 2006-01-18 at 14:00 -0800, David S. Miller wrote:
> > For example, IPV6 addresses can get added/removed from a device
> > in response to packets, and these operations trigger the
> > inet6addr_chain notifier in net/ipv6/addrconf.c
> > 
> > So sleeping in a notifier is indeed illegal.
> 
> On the specific example yet. Notifiers get used for many things and
> there has never been a rule about them not sleeping. There are lots of
> cases where notifiers sleeping make sense including its early use in
> power manglement.
> 
> Notifiers should not have locks. That was intentional in the original
> implementation.

But not documented.

>  You want locks, you implement them in the API *using*
> the notifier, because its odds on you actually need to hold that lock
> for other things too.

In going through the kernel, looking for places where notifier chains were
locked locally, there were surprisingly few instances (no more than one, I
think) where that lock was used for other things too.

There are a lot of notifier chains that _can_ use locks.  That's what the 
patch is for, to provide the locking for them, all in one place, so they 
don't have to do it themselves in many different places.

For other notifier chains that don't want locking (or don't want the kind
of locking provided by the new API), there's always the raw notifier type.

Alan Stern

