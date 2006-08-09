Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWHIMDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWHIMDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWHIMDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:03:20 -0400
Received: from helium.samage.net ([83.149.67.129]:42650 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S1161005AbWHIMDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:03:19 -0400
Message-ID: <35608.81.207.0.53.1155124956.squirrel@81.207.0.53>
In-Reply-To: <44D92B78.20408@google.com>
References: <20060808193325.1396.58813.sendpatchset@lappy>   
    <20060808193345.1396.16773.sendpatchset@lappy>
    <42414.81.207.0.53.1155080443.squirrel@81.207.0.53>
    <44D92B78.20408@google.com>
Date: Wed, 9 Aug 2006 14:02:36 +0200 (CEST)
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: "Indan Zupancic" <indan@nul.nu>
To: "Daniel Phillips" <phillips@google.com>
Cc: netdev@vger.kernel.org, "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, August 9, 2006 2:25, Daniel Phillips said:
> Indan Zupancic wrote:
>> Hello,
>> Saw the patch on lkml, and wondered about some things.
>> On Tue, August 8, 2006 21:33, Peter Zijlstra said:
>>
>>>+static inline void dev_unreserve_skb(struct net_device *dev)
>>>+{
>>>+	if (atomic_dec_return(&dev->rx_reserve_used) < 0)
>>>+		atomic_inc(&dev->);
>>>+}
>>>+
>>
>> This looks strange. Is it possible for rx_reserve_used to become negative?
>> A quick look at the code says no, except in the one case where there isn't a
>> "if (unlikely(dev_reserve_used(skb->dev)))" check:
>
> Yes, you can see what I'm trying to do there, I was short an atomic op to
> do it,  My ugly solution may well be... probably is racy.  Let's rewrite
> it with something better.  We want the atomic op that some people call
> "monus": decrement unless zero.

Currently atomic_inc_not_zero(), atomic_add_unless() and atomic_cmpxchg()
exist, so making an atomic_dec_not_zero() should be easy.

>>>@@ -389,6 +480,8 @@ void __kfree_skb(struct sk_buff *skb)
>>> #endif
>>>
>>> 	kfree_skbmem(skb);
>>>+	if (dev && (dev->flags & IFF_MEMALLOC))
>>>+		dev_unreserve_skb(dev);
>>> }
>>
>> So it seems that that < 0 check in dev_unreserve_skb() was only added to handle
>> this case (though there seems to be a race between those two atomic ops).
>> Isn't it better to remove that check and just do:
>>
>> if (dev && (dev->flags & IFF_MEMALLOC) && dev_reserve_used(dev))
>
> Seems to me that unreserve is also called from each protocol handler.
> Agreed, the < 0 check is fairly sickening.

Yes, but those all do that (racy) "if (unlikely(dev_reserve_used(skb->dev)))"
check. Adding another racy check doesn't improve the situation.


>> The use of atomic seems a bit dubious. Either it's necessary, in which case
>> changes depending on tests seem unsafe as they're not atomic and something
>> crucial could change between the read and the check, or normal reads and writes
>> combined with barriers would be sufficient. All in all it seems better to
>> move that "if (unlikely(dev_reserve_used(skb->dev)))" check into
>> dev_unreserve_skb(), and make the whole atomic if necessary. Then let
>> dev_unreserve_skb() return wether rx_reserve_used was positive.
>> Getting rid of dev_reserve_used() and using the atomic_read directly might be
>> better, as it is set with the bare atomic instructions too and rarely used without
>> dev_unreserve_skb().
>
> Barriers should work for this reserve accounting, but is that better than
> an atomic op?  I don't know, let's let the barrier mavens opine.

The atomic ops are fine, but if you do two atomic ops then that as a whole
isn't atomic any more and often racy. That's what seems to be the case
here.

> IMHO the cleanest thing to do is code up "monus", in fact I dimly recall
> somebody already added something similar.

I'm not sure, to me it looks like dev_unreserve_skb() is always called
without really knowing if it is justified or not, or else there wouldn't
be a chance that the counter became negative. So avoiding the negative
reserve usage seems like papering over bad accounting.

The assumption made seems to be that if there's reserve used, then it must
be us using it, and it's unreserved. So it appears that either that
assumption is wrong, and we can unreserve for others while we never
reserved for ourselves, or it is correct, in which case it probably makes
more sense to check for the IFF_MEMALLOC flag.

All in all it seems like a per skb flag which tells us if this skb was the
one reserving anything is missing. Or rx_reserve_used must be updated for
all in flight skbs whenever the IFF_MEMALLOC flag changes, so that we can
be sure that the accounting works correctly. Oh wait, isn't that what the
memalloc flag is for? So shouldn't it be sufficient to check only with
sk_is_memalloc()? That avoids lots of checks and should guarantee that the
accounting is correct, except in the case when the IFF_MEMALLOC flag is
cleared and the counter is set to zero manually. Can't that be avoided and
just let it decrease to zero naturally? So checking IFF_MEMALLOC for new
skbs and use sk_is_memalloc() for existing ones seems workable, if I'm not
missing anything (I think I do).

> Side note: please don't be shy, just reply-all in future so the discussion
> stays public.  Part of what we do is try to share our development process
> so people see not only what we have done, but why we did it.  (And sometimes
> so they can see what dumb mistakes we make, but I won't get into that...)

Yes, I know, but as I don't have much kernel programming experience I
didn't want to add unnecessary noise.

> I beg for forgiveness in advance having taken the liberty of CCing this
> reply to lkml.

No problem.

Greetings,

Indan


