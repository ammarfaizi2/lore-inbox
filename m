Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWHLLyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWHLLyV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 07:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWHLLyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 07:54:20 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:23759 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751454AbWHLLyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 07:54:20 -0400
Date: Sat, 12 Aug 2006 15:53:42 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060812115342.GA29676@2ka.mipt.ru>
References: <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <44DD4E3A.4040000@redhat.com> <20060812084713.GA29523@2ka.mipt.ru> <1155374390.13508.15.camel@lappy> <20060812093706.GA13554@2ka.mipt.ru> <1155377887.13508.27.camel@lappy> <20060812104224.GA12353@2ka.mipt.ru> <1155382830.13508.38.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155382830.13508.38.camel@lappy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 12 Aug 2006 15:53:43 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 01:40:29PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> On Sat, 2006-08-12 at 14:42 +0400, Evgeniy Polyakov wrote:
> 
> > When network uses the same allocator, it depends on it, and thus it is
> > possible to have (cut by you) a situation when reserve (which depends on
> > SLAB and it's OOM too) is not filled or even does not exist.
> 
> No, the reserve does not depend on SLAB, and I totally short-circuit the
> SLAB allocator for skbs and related on memory pressure.
> 
> The memalloc reserve is on the page allocator level and is only
> accessable for PF_MEMALLOC processes or __GFP_MEMALLOC (new in my
> patches) allocations. (arguably there could be some more deadlocks wrt.
> PF_MEMALLOC where the code under PF_MEMALLOC is not properly bounded,
> those would be bugs and should be fixed if present/found)

By SLAB I always mean allocator which is used to get the memory.
In your design main allocator is used to reserve the memory, which then
can be used by your own allocator.

> > If transferred to your implementation, then just steal some pages from
> > SLAB when new network device is added and use them when OOM happens.
> > It is much simpler and can help in the most of situations.
> 
> SLAB reclaim is painfull and has been tried by the time you OOM.

Just never return reserved pages, provide kernel parameter of how large
your reserve is and get pages from there when you detected OOM.
SLAB (main allocator) can do anything it want, but your reserve will never 
be touched by it.

-- 
	Evgeniy Polyakov
