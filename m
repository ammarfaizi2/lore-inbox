Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVKQNwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVKQNwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVKQNwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:52:44 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:32643 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1750826AbVKQNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:52:44 -0500
Date: Thu, 17 Nov 2005 08:52:42 -0500
From: "Bill Rugolsky Jr." <bill@rugolsky.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: jonathan@jonmasters.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ipt_ROUTE loopback
Message-ID: <20051117135242.GC25134@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <bill@rugolsky.com>,
	Willy Tarreau <willy@w.ods.org>, jonathan@jonmasters.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <35fb2e590511161901t7a615992s123a22cd8403511d@mail.gmail.com> <20051117043853.GH11266@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117043853.GH11266@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 05:38:53AM +0100, Willy Tarreau wrote:
> You need to use Julian Anastasov's "send-to-self" patch from ssi.bg/~ja/.
> The problem is not with ipt_route, but with the local addresses. If you
> want the packet to go out, you need to remove the local route for the
> destination. The packet will then go out, but when it will come back,
> the system won't take it because its destination won't match a local
> route. Try "ip r l t local" to see what I mean.
> 
> With Julian's patch, IIRC, you write '1' into /proc/sys/net/ipv4/$IF/loop,
> then you define some cross-routes for destinations with the respective
> sources from the opposite interfaces, then all packets routed out with
> a 'looped' interface address in their source will effectively go out.
> 
> I also suggest that you get his whole '-ja' patch, and that you look
> in Documentation/networking/ip-sysctl.txt in which he adds some
> documentation about this (and I believe there was a more complete
> example on his site).

I've used Julian's patch; it worked fine.  But while trying to debug some
issues with a 4xE1/T1 card, I had to do external loopback with an
unpatched 2.4 kernel.  IIRC, the following did the trick:

for p in 0 1
do
   /sbin/ip link set dev hdlc$p up multicast on
   /sbin/ip addr add dev hdlc$p local 192.168.$p.1 peer 192.168.$p.2
   echo 0 > /proc/sys/net/ipv4/conf/hdlc$p/rp_filter
done

# Trick the kernel into sending the packets over the wire
/sbin/iptables -t mangle -F
/sbin/iptables -t nat -F
/sbin/iptables -t nat -A POSTROUTING -d 192.168.0.2 -j SNAT --to 192.168.1.2
/sbin/iptables -t nat -A POSTROUTING -d 192.168.1.2 -j SNAT --to 192.168.0.2
/sbin/iptables -t nat -A PREROUTING -t nat -d 192.168.1.2 -j DNAT --to 192.168.0.1
/sbin/iptables -t nat -A PREROUTING -t nat -d 192.168.0.2 -j DNAT --to 192.168.1.1

To test, send traffic to either 192.168.0.2, or 192.168.1.2, e.g.,

    ping -T tsandaddr 192.168.0.2

Regards,

	Bill Rugolsky
