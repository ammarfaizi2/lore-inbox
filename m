Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWHIAZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWHIAZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 20:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWHIAZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 20:25:50 -0400
Received: from smtp-out.google.com ([216.239.45.12]:35257 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030372AbWHIAZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 20:25:49 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=PKx9PmIiWKqg62iwDiWKcUkjWnn2DoVlj0fhg5wf3qgyyLFeSKbZIjdCuic/ESoNP
	aWIm3MLR3zxnAYWgcE6Xg==
Message-ID: <44D92B78.20408@google.com>
Date: Tue, 08 Aug 2006 17:25:28 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Indan Zupancic <indan@nul.nu>, netdev@vger.kernel.org
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808193325.1396.58813.sendpatchset@lappy>    <20060808193345.1396.16773.sendpatchset@lappy> <42414.81.207.0.53.1155080443.squirrel@81.207.0.53>
In-Reply-To: <42414.81.207.0.53.1155080443.squirrel@81.207.0.53>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indan Zupancic wrote:
> Hello,
> Saw the patch on lkml, and wondered about some things.
> On Tue, August 8, 2006 21:33, Peter Zijlstra said:
> 
>>+static inline void dev_unreserve_skb(struct net_device *dev)
>>+{
>>+	if (atomic_dec_return(&dev->rx_reserve_used) < 0)
>>+		atomic_inc(&dev->rx_reserve_used);
>>+}
>>+
> 
> This looks strange. Is it possible for rx_reserve_used to become negative?
> A quick look at the code says no, except in the one case where there isn't a
> "if (unlikely(dev_reserve_used(skb->dev)))" check:

Yes, you can see what I'm trying to do there, I was short an atomic op to
do it,  My ugly solution may well be... probably is racy.  Let's rewrite
it with something better.  We want the atomic op that some people call
"monus": decrement unless zero.

>>@@ -389,6 +480,8 @@ void __kfree_skb(struct sk_buff *skb)
>> #endif
>>
>> 	kfree_skbmem(skb);
>>+	if (dev && (dev->flags & IFF_MEMALLOC))
>>+		dev_unreserve_skb(dev);
>> }
> 
> So it seems that that < 0 check in dev_unreserve_skb() was only added to handle
> this case (though there seems to be a race between those two atomic ops).
> Isn't it better to remove that check and just do:
> 
> if (dev && (dev->flags & IFF_MEMALLOC) && dev_reserve_used(dev))

Seems to me that unreserve is also called from each protocol handler.
Agreed, the < 0 check is fairly sickening.

> The use of atomic seems a bit dubious. Either it's necessary, in which case
> changes depending on tests seem unsafe as they're not atomic and something
> crucial could change between the read and the check, or normal reads and writes
> combined with barriers would be sufficient. All in all it seems better to
> move that "if (unlikely(dev_reserve_used(skb->dev)))" check into
> dev_unreserve_skb(), and make the whole atomic if necessary. Then let
> dev_unreserve_skb() return wether rx_reserve_used was positive.
> Getting rid of dev_reserve_used() and using the atomic_read directly might be
> better, as it is set with the bare atomic instructions too and rarely used without
> dev_unreserve_skb().

Barriers should work for this reserve accounting, but is that better than
an atomic op?  I don't know, let's let the barrier mavens opine.

IMHO the cleanest thing to do is code up "monus", in fact I dimly recall
somebody already added something similar.

Side note: please don't be shy, just reply-all in future so the discussion
stays public.  Part of what we do is try to share our development process
so people see not only what we have done, but why we did it.  (And sometimes
so they can see what dumb mistakes we make, but I won't get into that...)

I beg for forgiveness in advance having taken the liberty of CCing this
reply to lkml.

Regards,

Daniel
