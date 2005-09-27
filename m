Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVI0U4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVI0U4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVI0U4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:56:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34018
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965063AbVI0U4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:56:33 -0400
Date: Tue, 27 Sep 2005 13:56:26 -0700 (PDT)
Message-Id: <20050927.135626.88296134.davem@davemloft.net>
To: suzannew@cs.pdx.edu
Cc: linux-kernel@vger.kernel.org, Robert.Olsson@data.slu.se,
       paulmck@us.ibm.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical
 sections
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200509081712.j88HCqke013162@rastaban.cs.pdx.edu>
References: <200509081712.j88HCqke013162@rastaban.cs.pdx.edu>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzanne Wood <suzannew@cs.pdx.edu>
Date: Thu, 8 Sep 2005 10:12:52 -0700 (PDT)

> Please consider this request for suggestions on an attempt at a partial patch 
> based on the assumptions below to identify rcu read-side critical sections 
> for in_dev_get() defined in inetdevice.h.  Thank you.

Thanks a lot for your patch, and patience in waiting for it
to get reviewed :-)

I agree with the changes to add rcu_dereference() use.
Those were definitely lacking and needed.

This following case is clever and correct, though.  It is from
the net/ipv4/devinet.c part of your patch:

@@ -409,7 +412,8 @@ static int inet_rtm_deladdr(struct sk_bu
 
 	if ((in_dev = inetdev_by_index(ifm->ifa_index)) == NULL)
 		goto out;
-	__in_dev_put(in_dev);
+	in_dev_put(in_dev);
+	rcu_read_unlock();
 
 	for (ifap = &in_dev->ifa_list; (ifa = *ifap) != NULL;
 	     ifap = &ifa->ifa_next) {

Everyone gets fooled by a certain invariant in the Linux networking
locking.  If the RTNL semaphore is held, _all_ device and address
configuration changes are blocked.  IP addresses cannot be removed,
devices cannot be brought up or down, routes cannot be added or
deleted, etc.  The RTNL semaphore serializes all of these operations.
And it is held during inet_rtm_deladdr() here.

So we _know_ that if inetdev_by_index() returns non-NULL someone
else (the device itself) holds at least _one_ reference to that
object which cannot go away, because all such actions would need
to take the RTNL semaphore which we hold.

So __in_dev_put() is safe here.

Arguably, it's being overly clever for questionable gain.
It definitely deserves a comment, how about that? :-)

Finally, about adding rcu_read_{lock,unlock}() around even
in_dev_{get,put}().  I bet that really isn't needed but I cannot
articulate why we can get away without it.  For example, if we
are given a pair executed in a function like:

	in_dev_get();

	...

	in_dev_put();

who cares if we preempt?  The local function's execution holds the
necessary reference, so the object's refcount cannot ever fall to
zero.

We can't get any RCU callbacks invoked, as a result, so we don't
need the rcu_read_{lock,unlock}() calls here.

The in_dev_put() uses atomic_dec_and_test(), which provides a memory
barrier, so no out-of-order cpu memory references to the object
can escape past the decrement to zero of the object reference count.

In short, I think adding rcu_read_{lock,unlock}() is very heavy
handed and unnecessary.
