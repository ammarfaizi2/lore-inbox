Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbVIBPoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbVIBPoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVIBPoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:44:01 -0400
Received: from ns2.limegroup.com ([66.92.115.81]:60378 "EHLO ns2.limegroup.com")
	by vger.kernel.org with ESMTP id S1751492AbVIBPoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:44:00 -0400
Date: Fri, 2 Sep 2005 11:43:56 -0400 (EDT)
From: Ion Badulescu <lists@limebrokerage.com>
X-X-Sender: ion@guppy.limebrokerage.com
To: John Heffner <jheffner@psc.edu>
cc: "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <002cb4586f9d008438e81da96e5cecd0@psc.edu>
Message-ID: <Pine.LNX.4.61.0509021127040.6083@guppy.limebrokerage.com>
References: <20050901.154300.118239765.davem@davemloft.net>
 <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
 <2d02c76a84655d212634a91002b3eccd@psc.edu> <20050901.232823.123760177.davem@davemloft.net>
 <Pine.LNX.4.61.0509020948350.6083@guppy.limebrokerage.com>
 <6064b8272aa4562242eb60eb75c7cdae@psc.edu> <Pine.LNX.4.61.0509021022230.6083@guppy.limebrokerage.com>
 <002cb4586f9d008438e81da96e5cecd0@psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, John Heffner wrote:

> If it is window clamping, then you should be asymptotically approaching a 
> ratio between receive buffer and window that corresponds (with a fudge 
> factor) to the ratio between TCP segment data size and allocated packet size. 
> If you make the receive buffer large enough, then the clamped window should 
> still end up big enough.

For what it's worth, running with a 512k receive buffer still caused the 
clamping to occur, though it took longer than with the normal buffer size. 
The window went down from a maximum of 12291 (times 2^4 due to window 
scaling) to 3190 currently. That's still enough for our purposes, but I'll 
keep monitoring it to see if it shrinks any further. It could be a viable 
work-around for the time being.

Is this a bug, though, or a feature? :)

> Also, since you have "real time" data, a larger 
> receive buffer should probably be adequate to eliminate this problem, since 
> it only occurs when the receiving application falls behind for a while, and a 
> bigger receive buffer allows it to fall behind more without triggering the 
> window clamping.

Correct. I noticed too while experimenting that the clamping never occurs 
if the application is fast enough to keep the socket buffer empty. It's 
when data is allowed to accumulate in the buffer that the window shrinks, 
and then it never grows back, as if a portion of the buffer got lost 
permanently.

-Ion
