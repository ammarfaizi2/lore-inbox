Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbVIBOF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbVIBOF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVIBOF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:05:28 -0400
Received: from ns1.limegroup.com ([64.48.93.2]:57604 "EHLO ns1.limegroup.com")
	by vger.kernel.org with ESMTP id S1751331AbVIBOF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:05:27 -0400
Date: Fri, 2 Sep 2005 10:05:15 -0400 (EDT)
From: lists@limebrokerage.com
X-X-Sender: ion@guppy.limebrokerage.com
To: "David S. Miller" <davem@davemloft.net>
cc: jheffner@psc.edu, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <20050901.232823.123760177.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0509020948350.6083@guppy.limebrokerage.com>
References: <20050901.154300.118239765.davem@davemloft.net>
 <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
 <2d02c76a84655d212634a91002b3eccd@psc.edu> <20050901.232823.123760177.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, 1 Sep 2005, David S. Miller wrote:

> From: John Heffner <jheffner@psc.edu>
> Date: Thu, 1 Sep 2005 22:51:48 -0400
>
>> I have an idea why this is going on.  Packets are pre-allocated by the
>> driver to be a max packet size, so when you send small packets, it
>> wastes a lot of memory.  Currently Linux uses the packets at the
>> beginning of a connection to make a guess at how best to advertise its
>> window so as not to overflow the socket's memory bounds.  Since you
>> start out with big segments then go to small ones, this is defeating
>> that mechanism.  It's actually documented in the comments in
>> tcp_input.c. :)
>>
>>   * The scheme does not work when sender sends good segments opening
>>   * window and then starts to feed us spagetti. But it should work
>>   * in common situations. Otherwise, we have to rely on queue collapsing.
>
> That's a strong possibility, good catch John.

That's possible, but see below.

> Although, I'm still not ruling out some box in the middle
> even though I consider it less likely than your theory.

There is no funky box in the middle, that much I can guarantee you.

I said yesterday that I don't have access to the sender. While that's true 
for the flow I had captured in those dumps, I saw the same phenomenon 
occur between two boxes I control fully. The sender is running Windows 
2000, and is separated from the receiver by a single Catalyst 6500 
switch/router (they are on different VLAN's) which doesn't do anything 
fancy (I control the switch as well).

This particular Win2k sender sends _only_ real-time data, it's not capable 
of rewinding. So it's always sending small packets, from start to finish, 
yet the problem still occurs.

Note that even real-time data can end up generating a stream of full-size 
packets occassionally. It's just very unlikely they would occur at the 
start of the flow, as market data is very thin in the pre-market open hours.

> So you're suggesting that tcp_prune_queue() should do the:
>
> 	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
> 		tcp_clamp_window(sk, tp);
>
> check after attempting to collapse the queue.
>
> But, that window clamping should fix the problem, as we recalculate
> the window to advertise.

Patches for testing are very much welcome...

Thanks,
-Ion
