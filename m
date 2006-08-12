Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWHLIrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWHLIrs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 04:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWHLIrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 04:47:48 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:49360 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932403AbWHLIrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 04:47:47 -0400
Date: Sat, 12 Aug 2006 12:47:13 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060812084713.GA29523@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <44DD4E3A.4040000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44DD4E3A.4040000@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 12 Aug 2006 12:47:16 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 11:42:50PM -0400, Rik van Riel (riel@redhat.com) wrote:
> >Dropping these non-essential packets makes sure the reserve memory 
> >doesn't get stuck in some random blocked user-space process, hence
> >you can make progress.
> 
> In short:
>  - every incoming packet needs to be received at the packet level
>  - when memory is low, we only deliver data to memory critical sockets
>  - packets to other sockets get dropped, so the memory can be reused
>    for receiving other packets, including the packets needed for the
>    memory critical sockets to make progress
> 
> Forwarding packets while in low memory mode should not be a problem
> at all, since forwarded packets get freed quickly.
> 
> The memory pool for receiving packets does not need much accounting
> of any kind, since every packet will end up coming from that pool
> when normal allocations start failing.   Maybe Evgeniy's allocator
> can do something smarter internally, and mark skbuffs as MEMALLOC
> when the number of available skbuffs is getting low?

As you described above, memory for each packet must be allocated (either
from SLAB or from reserve), so network needs special allocator in OOM
condition, and that allocator should be separated from SLAB's one which 
got OOM, so my purpose is just to use that different allocator (with
additional features) for netroking always. Since every piece of
networking is limited (socket queues, socket numbers, hardware queues,
hardware wire speeds an so on) there is always a maximum amount of
memory it can consume and can never exceed, so if network allocator will 
get that amount of memory at the begining, it will never meet OOM, 
so it will _always_ work and thus can allow to make slow progress for 
OOM-capable things like block devices and swap issues. 
There are no special reserve and no need to switch to/from it and 
no possibility to have OOM by design.

-- 
	Evgeniy Polyakov
