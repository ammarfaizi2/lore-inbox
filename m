Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWHRRIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWHRRIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWHRRIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:08:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17825 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964913AbWHRRIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:08:43 -0400
Date: Fri, 18 Aug 2006 10:04:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Arnd Bergmann <arnd@arndb.de>,
       David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
In-Reply-To: <200608181129.15075.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608180959190.31844@schroedinger.engr.sgi.com>
References: <20060814110359.GA27704@2ka.mipt.ru> <20060816142557.acccdfcf.ak@suse.de>
 <Pine.LNX.4.64.0608171920220.28680@schroedinger.engr.sgi.com>
 <200608181129.15075.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006, Andi Kleen wrote:

> Also I must say it's still not quite clear to me if it's better to place
> network packets on the node the device is connected to or on the 
> node which contains the CPU who processes the packet data 
> For RX this can be three different nodes in the worst case
> (CPU processing is often split on different CPUs between softirq
> and user context), for TX  two. Do you have some experience that shows 
> that a particular placement is better than the other?

The more nodes are involved the more numa traffic and the slower the 
overall performance. It is best to place all control information on the 
node of the network card. The actual data is read via DMA and one may
place that local to the executing process. The DMA transfer will then have 
to cross the NUMA interlink but that DMA transfer is a linear and 
predictable stream that can often be optimized by hardware. If you 
would create the data on the network node then you would have off 
node overhead when creating the data (random acces to cache lines?) which 
is likely worse.

One should be able to place the process near the node that has the network 
card. Our machines typically have multiple network cards. It would be best 
if the network stack could choose the one that is nearest to the process.

