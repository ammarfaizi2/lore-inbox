Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVIBU64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVIBU64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVIBU6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:58:41 -0400
Received: from ns1.limegroup.com ([64.48.93.2]:522 "EHLO ns1.limegroup.com")
	by vger.kernel.org with ESMTP id S1751234AbVIBU6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:58:12 -0400
Date: Fri, 2 Sep 2005 16:57:53 -0400 (EDT)
From: Ion Badulescu <ion.badulescu@limegroup.com>
X-X-Sender: ion@guppy.limebrokerage.com
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
cc: Ion Badulescu <lists@limebrokerage.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <20050902183656.GA16537@yakov.inr.ac.ru>
Message-ID: <Pine.LNX.4.61.0509021609430.6083@guppy.limebrokerage.com>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
 <20050901.154300.118239765.davem@davemloft.net>
 <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
 <20050902183656.GA16537@yakov.inr.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Fri, 2 Sep 2005, Alexey Kuznetsov wrote:

>> This is where things start going bad. The window starts shrinking from
>> 15340 all the way down to 2355 over the course of 0.3 seconds. Notice the
>> many duplicate acks that serve no purpose
>
> These are not duplicate, TCP_NODELAY sender just starts flooding
> tiny segments, and those are normal ACKs acking those segments, note
> ACK field is not the same.

Well, take a look at the double acks for 84439343, 84440447 and 84441059, 
they seem pretty much identical to me.

> I still do not know how the value of 184 is possible in your case,
> I would expect 730 as an absolute possible minumum. I see 9420 (2355*4).

The numbers I mentioned are straight from the tcpdump and are not scaled, 
so they need to be multiplied by 4. But even 9420, combined with a RTT of 
20ms, results in a total usable bandwidth of about 3.75 Mbps, not enough 
for this real-time stream at peak times.

Besides, it often gets even worse than 2355, all it takes is a few 
application slowdowns.

> Anyway, ignoring this puzzle, the following patch for 2.4 should help.
>
>
> --- net/ipv4/tcp_input.c.orig	2003-02-20 20:38:39.000000000 +0300
> +++ net/ipv4/tcp_input.c	2005-09-02 22:28:00.845952888 +0400
> @@ -343,8 +343,6 @@
> 			app_win -= tp->ack.rcv_mss;
> 		app_win = max(app_win, 2U*tp->advmss);
>
> -		if (!ofo_win)
> -			tp->window_clamp = min(tp->window_clamp, app_win);
> 		tp->rcv_ssthresh = min(tp->window_clamp, 2U*tp->advmss);
> 	}
> }

That makes perfect sense...

I'll test it out on Tuesday, when I can connect again to the real-time 
streams that we use.

Thanks a lot!
-Ion
