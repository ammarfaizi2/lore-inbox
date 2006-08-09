Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030578AbWHIHUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbWHIHUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030577AbWHIHUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:20:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25764 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030574AbWHIHUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:20:33 -0400
Message-ID: <44D98CAB.8090202@garzik.org>
Date: Wed, 09 Aug 2006 03:20:11 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: David Miller <davem@davemloft.net>, phillips@google.com,
       netdev@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 8/9] 3c59x driver conversion
References: <20060808193447.1396.59301.sendpatchset@lappy>	 <44D9191E.7080203@garzik.org>	<44D977D8.5070306@google.com>	 <20060808.225537.112622421.davem@davemloft.net>	 <44D980EB.5010608@garzik.org> <1155107002.23134.40.camel@lappy>
In-Reply-To: <1155107002.23134.40.camel@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Wed, 2006-08-09 at 02:30 -0400, Jeff Garzik wrote:
>> David Miller wrote:
>>> From: Daniel Phillips <phillips@google.com>
>>> Date: Tue, 08 Aug 2006 22:51:20 -0700
>>>
>>>> Elaborate please.  Do you think that all drivers should be updated to
>>>> fix the broken blockdev semantics, making NETIF_F_MEMALLOC redundant?
>>>> If so, I trust you will help audit for it?
>>> I think he's saying that he doesn't think your code is yet a
>>> reasonable way to solve the problem, and therefore doesn't belong
>>> upstream.
>> Pretty much.  It is completely non-sensical to add NETIF_F_MEMALLOC, 
>> when it should be blindingly obvious that every net driver will be 
>> allocating memory, and every net driver could potentially be used with 
>> NBD and similar situations.
> 
> Sure, but until every single driver is converted I'd like to warn people
> about the fact that their setups is not up to expectations. Iff all
> drivers are converted I'll be the forst to submit a patch that removes
> the feature flag.

A temporary-for-years flag is not a good approach.  The flag is not 
_needed_ for technical reasons, but for supposed user expectation reasons.

Rather, just go ahead and convert drivers to netdev_alloc_skb() where 
people care.  If someone suddenly gets a burr up their ass about the 
sunlance or epic100 driver deadlocking on NBD, then they can convert it 
or complain loudly themselves.

Overall, a good solution needs to be uniform across all net drivers. 
NETIF_F_MEMALLOC is just _encouraging_ people to be slackers and delay 
converting other drivers, creating two classes of drivers, the "haves" 
and the "have nots".

Just make a big netdev_alloc_skb() patch that converts most users. 
netdev_alloc_skb() is a good thing to use, because it builds an 
association with struct net_device and the allocation.

	Jeff



P.S.  Since netdev_alloc_skb() calls skb_reserve(), you need to take 
that into account.  That's a bug in current patches.
