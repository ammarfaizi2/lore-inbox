Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbVIAWxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbVIAWxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbVIAWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:53:19 -0400
Received: from ns1.limegroup.com ([64.48.93.2]:28676 "EHLO ns1.limegroup.com")
	by vger.kernel.org with ESMTP id S1030441AbVIAWxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:53:18 -0400
Date: Thu, 1 Sep 2005 18:53:15 -0400 (EDT)
From: Ion Badulescu <lists@limebrokerage.com>
X-X-Sender: ion@guppy.limebrokerage.com
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <20050901.154300.118239765.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
 <20050901.154300.118239765.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, 1 Sep 2005, David S. Miller wrote:

> Thanks for the empty posting.  Please provide the content you
> intended to post, and furthermore please post it to the network
> developer mailing list, netdev@vger.kernel.org

First of all, thanks for the reply (even to an empty posting :).

The posting wasn't actually empty, it was probably too long (94K according 
to my sent-mail folder) and majordomo truncated it to zero. It has some 
tcpdump snippets, that's what made it so long... unfortunately, they're 
all necessary to understand the nature of the bug. I wasn't sure about 
netdev, that's why I posted it only to linux-kernel and linux-net.

I can provide the full tcpdump out-of-band to interested people, since I 
don't think I can get it past majordomo.

Here is the text of the message without the tcpdump inserts:

---------------------------------------------------------------------------
Hello,

I've been tracking down this bug for some time, and I'm fairly convinced 
at this point that it's a kernel bug.

Under certain conditions, the TCP stack starts shrinking the TCP window 
down to some ridiculously low values (hundreds of bytes, as low as 181) 
and never recovers. The certain conditions I mentioned are not well 
understood at this point, but they include a long-lived connection with a 
very one-sided, fluctuating traffic flowing through it.

So far I've been able to reproduce it on plain-vanilla 2.4.9, 2.4.11.9, 
and 2.4.12.2, as well as on the RHEL3 kernels 2.4.21-20 and 2.4.21-31. The 
hardware is dual Opteron 250, running both 32- and 64-bit SMP kernels 
(seems to make no difference). I've also seen the bug occur on a single 
Athlon XP running 2.6.11.9 UP.

The bug occurs with all sysctl settings at their default values. I've 
tried enabling and disabling pretty much all the tcp-related sysctl's in 
/proc/sys/net/ipv4, to no visible improvement.

Here are a few tcpdump snippets of a TCP connection exhibiting the bug 
(the complete tcpdump is available upon request, but it's very large). 
10.2.20.246 is the data receiver and is the box exhibiting the bug (I'm 
not sure what 10.2.224.182 is running, I don't have access to it). The 
data being sent through is real-time financial data; the session begins by 
catching up (at line speed) to present time, then continues to receive 
real-time data as it is being generated. For what it's worth, we've never 
been seen the bug occur while the session is still catching up (and 
receiving a few large packets at a time); it always seems to happen while 
receiving real-time data (many small packets, variably interspaced).

[I apologize for the amount of tcpdump data, but it's the only way to show 
the bug in action.]

[tcpdump output removed]

The connection is established and the receiver's TCP window quickly ramps 
up to 8192.

[tcpdump output removed]

Shortly thereafter the TCP window increases further to 16534. It remains 
around 16534 for the next 5 minutes or so.

[tcpdump output removed]

A few minutes later it has finally caught up to present time and it starts 
receiving smaller packets containing real-time data. The TCP window is 
still 16534 at this point.

[tcpdump output removed]

This is where things start going bad. The window starts shrinking from 
15340 all the way down to 2355 over the course of 0.3 seconds. Notice the 
many duplicate acks that serve no purpose (there are no lost packets and 
the tcpdump is taken on the receiver so there is no packets/acks crossed 
in flight).

[tcpdump output removed]

Five minutes later the TCP window is still at 2355, having never 
recovered. The window is so small that the available bandwidth for this 
connection is too small to keep up with the real-time data so it is 
falling behind, hence large packets are again being used. The application 
processing the data (Java-based) is mostly idle at this point, and netstat 
shows its recv queue to be empty. There is no apparent reason why the 
kernel shouldn't enlarge the window.

In fact, if I let it continue, it eventually shrinks the window even 
further (by 18:19:29, the time I'm writing this email, it's gone all the 
way down to 1373). As I mentioned earlier, I've seen it go as low as 181.

We are kind of stumped at this point, and it's proving to be a 
show-stopping bug for our purposes, especially over WAN links that have 
higher latency (for obvious reasons). Any kind of assistance would be 
greatly appreciated.

Thanks,
-Ion
