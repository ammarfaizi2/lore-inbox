Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbVLOGEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbVLOGEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbVLOGEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:04:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161111AbVLOGEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:04:53 -0500
Date: Wed, 14 Dec 2005 22:06:46 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, mpm@selenic.com, sri@us.ibm.com,
       ak@suse.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051214220646.6952f936@localhost.localdomain>
In-Reply-To: <20051215054245.GD18862@brahms.suse.de>
References: <20051214092228.GC18862@brahms.suse.de>
	<1134582945.8698.17.camel@w-sridhar2.beaverton.ibm.com>
	<20051215033937.GC11856@waste.org>
	<20051214.203023.129054759.davem@davemloft.net>
	<20051215054245.GD18862@brahms.suse.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005 06:42:45 +0100
Andi Kleen <ak@suse.de> wrote:

> On Wed, Dec 14, 2005 at 08:30:23PM -0800, David S. Miller wrote:
> > From: Matt Mackall <mpm@selenic.com>
> > Date: Wed, 14 Dec 2005 19:39:37 -0800
> > 
> > > I think we need a global receive pool and per-socket send pools.
> > 
> > Mind telling everyone how you plan to make use of the global receive
> > pool when the allocation happens in the device driver and we have no
> > idea which socket the packet is destined for?  What should be done for
> 
> In theory one could use multiple receive queue on intelligent enough
> NIC with the NIC distingushing the sockets.
> 
> But that would be still a nasty "you need advanced hardware FOO to avoid
> subtle problem Y" case. Also it would require lots of  driver hacking.
> 
> And most NICs seem to have limits on the size of the socket tables for this, which
> means you would end up in a "only N sockets supported safely" situation,
> with N likely being quite small on common hardware.
> 
> I think the idea of the original poster was that just freeing non critical packets
> after a short time again would be good enough, but I'm a bit sceptical
> on that.
> 
> > I truly dislike these patches being discussed because they are a
> > complete hack, and admittedly don't even solve the problem fully.  I
> 
> I agree. 
> 
> > I think GFP_ATOMIC memory pools are more powerful than they are given
> > credit for.  There is nothing preventing the implementation of dynamic
> 
> Their main problem is that they are used too widely and in a lot
> of situations that aren't really critical.

Most of the use of GFP_ATOMIC is by stuff that could fail but can't
sleep waiting for memory. How about adding a GFP_NORMAL for allocations
while holding a lock.

#define GFP_NORMAL (__GFP_NOMEMALLOC)

Then get people to change the unneeded GFP_ATOMIC's to GFP_NORMAL in
places where the error paths are reasonable.
