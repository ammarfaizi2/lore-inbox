Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVI1AWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVI1AWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVI1AWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:22:42 -0400
Received: from lead.cat.pdx.edu ([131.252.208.91]:7115 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751137AbVI1AWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:22:41 -0400
Date: Tue, 27 Sep 2005 17:22:21 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200509280022.j8S0MLql000686@rastaban.cs.pdx.edu>
To: davem@davemloft.net
Cc: Robert.Olsson@data.slu.se, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for all you've provided here. 

   > From davem@davemloft.net  Tue Sep 27 14:36:32 2005

   > I agree with the changes to add rcu_dereference() use.
   > Those were definitely lacking and needed.

   > This following case is clever and correct, though.  It is from
   > the net/ipv4/devinet.c part of your patch:

   > @@ -409,7 +412,8 @@ static int inet_rtm_deladdr(struct sk_bu
   >  
   >         if ((in_dev = inetdev_by_index(ifm->ifa_index)) == NULL)
   >                 goto out;
   > -       __in_dev_put(in_dev);
   > +       in_dev_put(in_dev);
   > +       rcu_read_unlock();
   >  
   >         for (ifap = &in_dev->ifa_list; (ifa = *ifap) != NULL;
   >              ifap = &ifa->ifa_next) {

   > Everyone gets fooled by a certain invariant in the Linux networking
   > locking.  If the RTNL semaphore is held, _all_ device and address
   > configuration changes are blocked.  IP addresses cannot be removed,
   > devices cannot be brought up or down, routes cannot be added or
   > deleted, etc.  The RTNL semaphore serializes all of these operations.
   > And it is held during inet_rtm_deladdr() here.

   > So we _know_ that if inetdev_by_index() returns non-NULL someone
   > else (the device itself) holds at least _one_ reference to that
   > object which cannot go away, because all such actions would need
   > to take the RTNL semaphore which we hold.

   > So __in_dev_put() is safe here.

In this case, you want the refcnt decremented without the unnecessary 
test that in_dev_put() would incur.   I was concerned about the 
pairings of __in_dev_get which doesn't increment refcnt with 
__in_dev_put which decrements.  Didn't mean to address that til 
after some feedback, but thank you for clarifying my error here
since I can't trace any pairing with the use of __in_dev_put 
in inet_rtm_deladdr.

   > Arguably, it's being overly clever for questionable gain.
   > It definitely deserves a comment, how about that? :-)

   > Finally, about adding rcu_read_{lock,unlock}() around even
   > in_dev_{get,put}().  I bet that really isn't needed but I cannot
   > articulate why we can get away without it.  For example, if we
   > are given a pair executed in a function like:

   >         in_dev_get();

   >         ...

   >         in_dev_put();

   > who cares if we preempt?  The local function's execution holds the
   > necessary reference, so the object's refcount cannot ever fall to
   > zero.

   > We can't get any RCU callbacks invoked, as a result, so we don't
   > need the rcu_read_{lock,unlock}() calls here.

   > The in_dev_put() uses atomic_dec_and_test(), which provides a memory
   > barrier, so no out-of-order cpu memory references to the object
   > can escape past the decrement to zero of the object reference count.

   > In short, I think adding rcu_read_{lock,unlock}() is very heavy
   > handed and unnecessary.

In Paul McKenney's reference at
www.rdrop.com/users/paulmck/RCU/whatisRCU.html
"Reference counts may be used in conjunction with RCU to maintain 
longer-term references to data structures."  So you're right.  I
was basing those rcu_read_lock extents on the idea that the calling
function has the vision of the need for protection of an
rcu_dereference'd pointer.  Paul has also provided further insight
into discriminating between read-side and update-side uses of
rcu_dereference which I need to incorporate.

Many thanks again and I'll try for a better submission.
