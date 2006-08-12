Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWHLKm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWHLKm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 06:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWHLKm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 06:42:57 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:46053 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964818AbWHLKm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 06:42:56 -0400
Date: Sat, 12 Aug 2006 14:42:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060812104224.GA12353@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <44DD4E3A.4040000@redhat.com> <20060812084713.GA29523@2ka.mipt.ru> <1155374390.13508.15.camel@lappy> <20060812093706.GA13554@2ka.mipt.ru> <1155377887.13508.27.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155377887.13508.27.camel@lappy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 12 Aug 2006 14:42:31 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 12:18:07PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > Does it? I though it is possible to only have 64k of working sockets per
> > device in TCP.
> 
> 65535 sockets * 128 packets * 16384 bytes/packet = 
> 1^16 * 1^7 * 1^14 = 1^(16+7+14) = 1^37 = 128G of memory per IP
> 
> And systems with a lot of IP numbers are not unthinkable.
> 
> I wonder what kind of system you have to feel that that is not a
> problem. (I'm not sure on the 128 packets per socket, and the 16k per
> packet is considering jumbo frames without scather gather receive)

:) have you ever tried to get those numbers in practice?

There are couple of problems with that:
1. You only have 1gbit/sec link (someone has 10gbit/sec).
2. Depending on packet size those limit can be lower (and it _is_ lower
for the real-world traffic where you need to send ACKs).
3. If data transferred is supposed to be processed somehow, you need to
add those cost too.
4. When we are talking about OOM conditions, they whole system is slowed
down hard, so you again can not achieve those limit.

And there are a lot of other factors which can slow down you network
(like netfilter, ipsec and others).

> > If system is limited enough to provide enough memory for network tree
> > allocator, it is possible to create it's own drop condition inside NTA,
> > but it must be saparated from the weakest chain element in that
> > conditions - SLAB OOM.
> 
> Hence the alternative allocator to use on tight memory conditions.

You seems to not understand the situation.
You want to make a progress in SLAB OOM condition which is bound to
network and since progress requires allocation, it can deadlock.
That is the problem - SLAB allocator got OOM condition.
The only solution for that (expect more memory addition) is to make
underlying system robust (in discussed case it is network). Robust means
not depend on condition which leads to SLAB OOM.
When network uses the same allocator, it depends on it, and thus it is
possible to have (cut by you) a situation when reserve (which depends on
SLAB and it's OOM too) is not filled or even does not exist.
Underlying system can have it's own problems, millions of problems, but
it does not matter when we are talking about higher-layer conditions -
forward progress in this scenario does not depend on the weakest chain
element in described conditions - it does not depend on SLAB OOM.

If transferred to your implementation, then just steal some pages from
SLAB when new network device is added and use them when OOM happens.
It is much simpler and can help in the most of situations.

-- 
	Evgeniy Polyakov
