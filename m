Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUH0Shu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUH0Shu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUH0Sht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:37:49 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:52694 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267180AbUH0Sgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:36:36 -0400
Message-ID: <41b516cb04082711363a009dbc@mail.gmail.com>
Date: Fri, 27 Aug 2004 11:36:36 -0700
From: Chris Leech <chris.leech@gmail.com>
Reply-To: Chris Leech <chris.leech@gmail.com>
To: "David S. Miller" <davem@redhat.com>, shane@hathawaymix.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000 rx buffer allocation
In-Reply-To: <20040826181843.342da7a3.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.60.0408261727170.9545@orangutan.jungle> <20040826181843.342da7a3.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 18:18:43 -0700, David S. Miller <davem@redhat.com> wrote:
> On Thu, 26 Aug 2004 17:35:38 -0600 (MDT)
> shane@hathawaymix.org wrote:
> 
> > Independently of my patch, I'm a little concerned about what will happen
> > if the driver runs out of rx buffers.  Ideally, it will just drop packets,
> > but I wonder if the code will panic instead.
> 
> It is a good question.  Some chips are known to hang when
> the rx buffer has no entries in it and a packet arrives.

The e1000 driver and PRO/1000 hardware don't have a problem with that,
other than dropping packets until receive buffers become available. 
Packets that make it into the receive FIFO, but then stall because
there are no buffers available, cause the "receive no buffers" counter
to increment and sit in the FIFO until a buffer is available.  Packets
that are received once the FIFO is full cause the "missed packet"
counter to increment and are dropped.

As for moving the allocations out of the hard interrupt context, e1000
was one of several drivers that tried that a few years back by using
tasklets.  What I found is that if you split the allocation from the
receive processing, it's far to easy to generate an interrupt load
which starves the skb allocations.  The result is that you
continuously use all of the buffers then stall while they all get
replaced, and performance is horrible.  But if the patch works for
your network load ...

A better approach for improving jumbo frame allocations might be to
use multiple smaller buffers for each receive, something the PRO/1000
hardware can do but the e1000 driver has never taken advantage of.

Dave, you mentioned the possibility of drivers doing that in a
conversation with Harald about handling fragmented packets
(http://marc.theaimsgroup.com/?l=linux-netdev&m=109293677816177&w=2) 
What would be the more correct approach to this?  Putting all receive
data into page allocations and filling out the frags array, or
chaining together small skbs using the frag_list?

- Chris
