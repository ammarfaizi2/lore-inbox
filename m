Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWGKRoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWGKRoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWGKRoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:44:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10681 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751145AbWGKRoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:44:14 -0400
Message-ID: <44B3E365.1020602@watson.ibm.com>
Date: Tue, 11 Jul 2006 13:44:05 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, jlan@sgi.com,
       csturtiv@sgi.com, pj@sgi.com, balbir@in.ibm.com, sekharan@us.ibm.com,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [Patch 6/6] per task delay accounting taskstats interface: fix
 clone skbs for each listener
References: <20060711030524.39abc3d5.akpm@osdl.org> <E1G0FU2-0002oE-00@gondolin.me.apana.org.au> <20060711035731.63c087b3.akpm@osdl.org> <20060711111525.GA11175@gondor.apana.org.au>
In-Reply-To: <20060711111525.GA11175@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Tue, Jul 11, 2006 at 03:57:31AM -0700, Andrew Morton wrote:
> 
>>>>>      down_write(&listeners->sem);
>>>>>      list_for_each_entry_safe(s, tmp, &listeners->list, list) {
>>>>>-             ret = genlmsg_unicast(skb, s->pid);
>>>>>+             skb_next = NULL;
>>>>>+             if (!list_islast(&s->list, &listeners->list)) {
>>>>>+                     skb_next = skb_clone(skb_cur, GFP_KERNEL);
>>>>
>>>>If we do a GFP_KERNEL allocation with this semaphore held, and the
>>>>oom-killer tries to kill something to satisfy the allocation, and the
>>>>killed task gets stuck on that semaphore, I wonder of the box locks up.

Hmm...doesn't look very safe does it.
There's no real need for us to skb_clone within the sem. Keeping a count of
listeners and doing the clone outside should let us avoid this problem.

I was trying to avoid doing the above because of the potential for
listeners getting added continuously to the list
(and having to repeat the allocation loop outside the down_write).

But on second thoughts, we're under no obligation to send the data to all the
listeners who add themselves in the short time between our taking a snapshot
of the listener count and when the send is done (within the down_write). So
it should be ok.

>>>
>>>We do GFP_KERNEL inside semaphores/mutexes in lots of places.  So if this
>>>can deadlock with the oom-killer we probably should fix that, preferably
>>>by having GFP_KERNEL fail in that case.
>>
>>This lock is special, in that it's taken on the exit() path (I think).  So
>>it can block tasks which are trying to exit.
> 
> 
> Sorry, missed the context.
> 
> If there is a deadlock then it's not just this allocation that you
> need worry about.  There is also an allocation within genlmsg_uniast
> that would be GFP_KERNEL.
> 

Thats true. The GFP_KERNEL allocation potentially called in netlink_trim() as part
of the genlmsg/netlink_unicast() is again a problem.

So perhaps we should switch to using RCU for protecting the listener list.

--Shailabh

> Cheers,

