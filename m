Return-Path: <linux-kernel-owner+w=401wt.eu-S965100AbXASMzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbXASMzY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 07:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbXASMzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 07:55:24 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:19796 "EHLO
	amsfep13-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965100AbXASMzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 07:55:23 -0500
Subject: Re: Possible ways of dealing with OOM conditions.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
In-Reply-To: <20070118183430.GA3345@2ka.mipt.ru>
References: <20070116153315.GB710@2ka.mipt.ru>
	 <1168963695.22935.78.camel@twins> <20070117045426.GA20921@2ka.mipt.ru>
	 <1169024848.22935.109.camel@twins> <20070118104144.GA20925@2ka.mipt.ru>
	 <1169122724.6197.50.camel@twins> <20070118135839.GA7075@2ka.mipt.ru>
	 <1169133052.6197.96.camel@twins> <20070118155003.GA6719@2ka.mipt.ru>
	 <1169141513.6197.115.camel@twins>  <20070118183430.GA3345@2ka.mipt.ru>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 13:53:15 +0100
Message-Id: <1169211195.6197.143.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Let me briefly describe your approach and possible drawbacks in it.
> You start reserving some memory when systems is under memory pressure.
> when system is in real trouble, you start using that reserve for special
> tasks mainly for network path to allocate packets and process them in
> order to get committed some memory swapping.
> 
> So, the problems I see here, are following:
> 1. it is possible that when you are starting to create a reserve, there
> will not be enough memeory at all. So the solution is to reserve in
> advance.

Swap is usually enabled at startup, but sure, if you want you can mess
this up.

> 2. You differentiate by hand between critical and non-critical
> allocations by specifying some kernel users as potentially possible to
> allocate from reserve. 

True, all sockets that are needed for swap, no-one else.

> This does not prevent from NVIDIA module to
> allocate from that reserve too, does it?

All users of the NVidiot crap deserve all the pain they get.
If it breaks they get to keep both pieces.

> And you artificially limit
> system to process only tiny bits of what it must do, thus potentially
> leaking pathes which must use reserve too.

How so? I cover pretty much every allocation needed to process an skb by
setting PF_MEMALLOC - the only drawback there is that the reserve might
not actually be large enough because it covers more allocations that
were considered. (thats one of the TODO items, validate the reserve
functions parameters)

> So, solution is to have a reserve in advance, and manage it using
> special path when system is in OOM. So you will have network memory
> reserve, which will be used when system is in trouble. It is very
> similar to what you had.
> 
> But the whole reserve can never be used at all, so it should be used,
> but not by those who can create OOM condition, thus it should be
> exported to, for example, network only, and when system is in trouble,
> network would be still functional (although only critical pathes).

But the network can create OOM conditions for itself just fine. 

Consider the remote storage disappearing for a while (it got rebooted,
someone tripped over the wire etc..). Now the rest of the network
traffic keeps coming and will queue up - because user-space is stalled,
waiting for more memory - and we run out of memory.

There must be a point where we start dropping packets that are not
critical to the survival of the machine.

> Even further development of such idea is to prevent such OOM condition
> at all - by starting swapping early (but wisely) and reduce memory
> usage.

These just postpone execution but will not avoid it.


