Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWHLJho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWHLJho (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 05:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWHLJho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 05:37:44 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:11487 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932308AbWHLJhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 05:37:43 -0400
Date: Sat, 12 Aug 2006 13:37:06 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060812093706.GA13554@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <44DD4E3A.4040000@redhat.com> <20060812084713.GA29523@2ka.mipt.ru> <1155374390.13508.15.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155374390.13508.15.camel@lappy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 12 Aug 2006 13:37:10 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 11:19:49AM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > As you described above, memory for each packet must be allocated (either
> > from SLAB or from reserve), so network needs special allocator in OOM
> > condition, and that allocator should be separated from SLAB's one which 
> > got OOM, so my purpose is just to use that different allocator (with
> > additional features) for netroking always. Since every piece of
> > networking is limited (socket queues, socket numbers, hardware queues,
> > hardware wire speeds an so on) there is always a maximum amount of
> > memory it can consume and can never exceed, so if network allocator will 
> > get that amount of memory at the begining, it will never meet OOM, 
> > so it will _always_ work and thus can allow to make slow progress for 
> > OOM-capable things like block devices and swap issues. 
> > There are no special reserve and no need to switch to/from it and 
> > no possibility to have OOM by design.
> 
> I'm not sure if the network stack is bounded as you say; for instance
> imagine you taking a lot of packets for blocked user-space processes,
> these will just accumulate in the network stack and go nowhere. In that
> case memory usage is very much unbounded.

No it is not. There are socket queues and they are limited. Things like
TCP behave even better.

> Even if blocked sockets would only accept a limited amount of packets,
> it would then become a function of the amount of open sockets, which is
> again unbounded.

Does it? I though it is possible to only have 64k of working sockets per
device in TCP.

> In any scheme you need to bound the amount of memory, and in low memory
> situations it is very usefull to return memory as soon as possible.

Feel free to drop packets as soon as it was found that they belong to
something that you do not want to get data right now.
It is an additional step, not a requirement.
All robust systems are built on top of priveledge separation and layered
access, so one compromised component would not affect other, it was 
proven in a lot of CS theories. In case of reserve, which is based on
main allocator, system still uses SLAB for both types of data flows - 
network and block data, there is always a possibility to have that 
reserve empty or not refilled when OOM happens, so problem is not solved, 
only system painfull death is slightly postponed (and maybe it will solve 
the problem for exact condition, but it's roots are still there).
If system is limited enough to provide enough memory for network tree
allocator, it is possible to create it's own drop condition inside NTA,
but it must be saparated from the weakest chain element in that
conditions - SLAB OOM.

-- 
	Evgeniy Polyakov
