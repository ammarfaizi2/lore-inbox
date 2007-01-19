Return-Path: <linux-kernel-owner+w=401wt.eu-S932769AbXASW5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbXASW5N (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 17:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbXASW5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 17:57:13 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:40977 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932769AbXASW5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 17:57:12 -0500
Date: Sat, 20 Jan 2007 01:56:43 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: Possible ways of dealing with OOM conditions.
Message-ID: <20070119225643.GA22728@2ka.mipt.ru>
References: <20070117045426.GA20921@2ka.mipt.ru> <1169024848.22935.109.camel@twins> <20070118104144.GA20925@2ka.mipt.ru> <1169122724.6197.50.camel@twins> <20070118135839.GA7075@2ka.mipt.ru> <1169133052.6197.96.camel@twins> <20070118155003.GA6719@2ka.mipt.ru> <1169141513.6197.115.camel@twins> <20070118183430.GA3345@2ka.mipt.ru> <1169211195.6197.143.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1169211195.6197.143.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 20 Jan 2007 01:56:51 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 01:53:15PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > 2. You differentiate by hand between critical and non-critical
> > allocations by specifying some kernel users as potentially possible to
> > allocate from reserve. 
> 
> True, all sockets that are needed for swap, no-one else.
> 
> > This does not prevent from NVIDIA module to
> > allocate from that reserve too, does it?
> 
> All users of the NVidiot crap deserve all the pain they get.
> If it breaks they get to keep both pieces.

I meant that pretty anyone can be those user, who can just add a bit
into own gfp_flags which are used for allocation.

> > And you artificially limit
> > system to process only tiny bits of what it must do, thus potentially
> > leaking pathes which must use reserve too.
> 
> How so? I cover pretty much every allocation needed to process an skb by
> setting PF_MEMALLOC - the only drawback there is that the reserve might
> not actually be large enough because it covers more allocations that
> were considered. (thats one of the TODO items, validate the reserve
> functions parameters)

You only covered ipv4/v6 and arp, maybe some route updates.
But it is very possible, that some allocations are missed like
multicast/broadcast. Selecting only special pathes out of the whole
possible network alocations tends to create a situation, when something
is missed or cross dependant on other pathes.

> > So, solution is to have a reserve in advance, and manage it using
> > special path when system is in OOM. So you will have network memory
> > reserve, which will be used when system is in trouble. It is very
> > similar to what you had.
> > 
> > But the whole reserve can never be used at all, so it should be used,
> > but not by those who can create OOM condition, thus it should be
> > exported to, for example, network only, and when system is in trouble,
> > network would be still functional (although only critical pathes).
> 
> But the network can create OOM conditions for itself just fine. 
> 
> Consider the remote storage disappearing for a while (it got rebooted,
> someone tripped over the wire etc..). Now the rest of the network
> traffic keeps coming and will queue up - because user-space is stalled,
> waiting for more memory - and we run out of memory.

Hmm... Neither UDP, nor TCP work that way actually.

> There must be a point where we start dropping packets that are not
> critical to the survival of the machine.

You still can drop them, the main point is that network allocations do
not depend on other allocations.

> > Even further development of such idea is to prevent such OOM condition
> > at all - by starting swapping early (but wisely) and reduce memory
> > usage.
> 
> These just postpone execution but will not avoid it.

No. If system allows to have such a condition, then
something is broken. It must be prevented, instead of creating special
hacks to recover from it.

-- 
	Evgeniy Polyakov
