Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWHIMlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWHIMlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWHIMlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:41:44 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:17595 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750732AbWHIMln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:41:43 -0400
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
In-Reply-To: <20060809054648.GD17446@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	 <20060809054648.GD17446@2ka.mipt.ru>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 14:37:20 +0200
Message-Id: <1155127040.12225.25.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 09:46 +0400, Evgeniy Polyakov wrote:
> On Tue, Aug 08, 2006 at 09:33:25PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> >    http://lwn.net/Articles/144273/
> >    "Kernel Summit 2005: Convergence of network and storage paths"
> > 
> > We believe that an approach very much like today's patch set is
> > necessary for NBD, iSCSI, AoE or the like ever to work reliably. 
> > We further believe that a properly working version of at least one of
> > these subsystems is critical to the viability of Linux as a modern
> > storage platform.
> 
> There is another approach for that - do not use slab allocator for
> network dataflow at all. It automatically has all you pros amd if
> implemented correctly can have a lot of additional usefull and
> high-performance features like full zero-copy and total fragmentation
> avoidance.

On your site where you explain the Network Tree Allocator:

 http://tservice.net.ru/~s0mbre/blog/devel/networking/nta/index.html

You only test the fragmentation scenario with the full scale of sizes.
Fragmentation will look different if you use a limited number of sizes
that share no factors (other than the block size); try 19, 37 and 79 
blocks with 1:1:1 ratio.

Also, I have yet to see how you will do full zero-copy receives; full 
zero-copy would mean getting the data from driver DMA to user-space
without
a single copy. The to user-space part almost requires that each packet
live
on its own page.

As for the VM deadlock avoidance; I see no zero overhead allocation path
-
you do not want to deadlock your allocator. I see no critical resource 
isolation (our SOCK_MEMALLOC). Without these things your allocator might
improve the status quo but it will not aid in avoiding the deadlock we
try
to tackle here.



