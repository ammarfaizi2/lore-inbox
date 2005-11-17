Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbVKQE5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbVKQE5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 23:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbVKQE5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 23:57:38 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:60170 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1161134AbVKQE5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 23:57:38 -0500
Date: Thu, 17 Nov 2005 05:38:53 +0100
From: Willy Tarreau <willy@w.ods.org>
To: jonathan@jonmasters.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ipt_ROUTE loopback
Message-ID: <20051117043853.GH11266@alpha.home.local>
References: <35fb2e590511161901t7a615992s123a22cd8403511d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590511161901t7a615992s123a22cd8403511d@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 03:01:46AM +0000, Jon Masters wrote:
> Folks,
> 
> I'm trying to find an easy way to have a Linux box completely ignore
> the local routing table and have traffic destined for one interface go
> out of a loopback cable and back into the other rather than traversing
> the local routing within the host, viz:
> 
> eth0
> x.x.x.x
>    |
>    | <--- loopback cable
>    |
> eth1
> y.y.y.y
>
> This is completely against normal practice, but useful for test. I've
> so far tried playing around with iproute2 and have this evening built
> up ipt_ROUTE, which seems more promising. I can get traffic forced out
> of the "correct" interface and bypass the local routing table, but it
> always has the destination MAC of the first interface when it reaches
> the second.
> 
> So, I can bodge the destination MAC (I'm still deciding how to do that
> - maybe I'll take apart ipt_ROUTE and have it do MAC rewriting too)
> but I'm curious as to whether there's a "right" way to do this that
> I've so far missed? I've considered using the briding code in some
> weird kind of transparent-yet-not-really bridge setup, but I don't
> really want to do that.
> 
> Any suggestions? This seems like something others must have also
> wanted to do. I'm happy to break things in doing it, but I'm hopeful
> for a "you missed this page...".

You missed this page...  :-)

You need to use Julian Anastasov's "send-to-self" patch from ssi.bg/~ja/.
The problem is not with ipt_route, but with the local addresses. If you
want the packet to go out, you need to remove the local route for the
destination. The packet will then go out, but when it will come back,
the system won't take it because its destination won't match a local
route. Try "ip r l t local" to see what I mean.

With Julian's patch, IIRC, you write '1' into /proc/sys/net/ipv4/$IF/loop,
then you define some cross-routes for destinations with the respective
sources from the opposite interfaces, then all packets routed out with
a 'looped' interface address in their source will effectively go out.

I also suggest that you get his whole '-ja' patch, and that you look
in Documentation/networking/ip-sysctl.txt in which he adds some
documentation about this (and I believe there was a more complete
example on his site).

Good luck,
Willy

