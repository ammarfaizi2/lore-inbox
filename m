Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319319AbSIFSad>; Fri, 6 Sep 2002 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319308AbSIFSac>; Fri, 6 Sep 2002 14:30:32 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:4001 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S319303AbSIFSa2>;
	Fri, 6 Sep 2002 14:30:28 -0400
Message-ID: <3D78F55C.4020207@colorfullife.com>
Date: Fri, 06 Sep 2002 20:35:08 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>, jamal <hadi@cyberus.ca>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> The real question is why NAPI causes so much more work for the client.
 >
[Just a summary from my results from last year. All testing with a 
simple NIC without hw interrupt mitigation, on a Cyrix P150]

My assumption was that NAPI increases the cost of receiving a single 
packet: instead of one hw interrupt with one device access (ack 
interrupt) and the softirq processing, the hw interrupt must ack & 
disable the interrupt, then the processing occurs in softirq context, 
and the interrupts are reenabled at softirq context.

The second point was that interrupt mitigation must remain enabled, even 
with NAPI: the automatic mitigation doesn't work with process space 
limited loads (e.g. TCP: backlog queue is drained quickly, but the 
system is busy processing the prequeue or receive queue)

jamal, it is possible that a driver uses both napi and the normal 
interface, or would that break fairness?
Use netif_rx, until it returns dropping. If that happens, disable the 
interrupt, and call netif_rx_schedule().

Is it possible to determine the average number of packets that are 
processed for each netif_rx_schedule()?

--
	Manfred

