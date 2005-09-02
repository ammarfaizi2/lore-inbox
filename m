Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVIBG20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVIBG20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbVIBG20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:28:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22940
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030359AbVIBG2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:28:24 -0400
Date: Thu, 01 Sep 2005 23:28:23 -0700 (PDT)
Message-Id: <20050901.232823.123760177.davem@davemloft.net>
To: jheffner@psc.edu
Cc: lists@limebrokerage.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent
 2.4.x/2.6.x kernels
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <2d02c76a84655d212634a91002b3eccd@psc.edu>
References: <20050901.154300.118239765.davem@davemloft.net>
	<Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
	<2d02c76a84655d212634a91002b3eccd@psc.edu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Heffner <jheffner@psc.edu>
Date: Thu, 1 Sep 2005 22:51:48 -0400

> I have an idea why this is going on.  Packets are pre-allocated by the 
> driver to be a max packet size, so when you send small packets, it 
> wastes a lot of memory.  Currently Linux uses the packets at the 
> beginning of a connection to make a guess at how best to advertise its 
> window so as not to overflow the socket's memory bounds.  Since you 
> start out with big segments then go to small ones, this is defeating 
> that mechanism.  It's actually documented in the comments in 
> tcp_input.c. :)
> 
>   * The scheme does not work when sender sends good segments opening
>   * window and then starts to feed us spagetti. But it should work
>   * in common situations. Otherwise, we have to rely on queue collapsing.

That's a strong possibility, good catch John.

Although, I'm still not ruling out some box in the middle
even though I consider it less likely than your theory.

So you're suggesting that tcp_prune_queue() should do the:

	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
		tcp_clamp_window(sk, tp);

check after attempting to collapse the queue.

But, that window clamping should fix the problem, as we recalculate
the window to advertise.
