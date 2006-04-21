Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWDUIxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWDUIxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDUIxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:53:42 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:54293 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932277AbWDUIxl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:53:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=luRqEG3KwwXd+yIU2fxQnogQzxW1JxqAMihXtgdlBGkM4i7IC6J6HzGB8TvyTCfnexmZvyN3yx/MYoEB2Vft2TeqOPcaYtkGo3CgWRGkFRJ66lS+06R5Sm8httP4TRi8UBA/ewjtfiCkY4hsHfmf0FmPLC9/xNovROV5IqOEmWE=
Message-ID: <58d0dbf10604210153r208504d4r4a7f4139e711ff7f@mail.gmail.com>
Date: Fri, 21 Apr 2006 10:53:39 +0200
From: "Jan Kiszka" <jan.kiszka@googlemail.com>
To: "Esben Nielsen" <simlo@phys.au.dk>
Subject: Re: Van Jacobson's net channels and real-time
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/4/20, Esben Nielsen <simlo@phys.au.dk>:
> Before I start, where is VJ's code? I have not been able to find it anywhere.
>
> With the preempt-realtime branch maturing and finding it's way into the
> mainline kernel, using Linux (without sub-kernels) for real-time applications
> is becomming an realistic option without having to do a lot of hacks in the
> kernel on your own.

Well, commenting on this statement would likely create a thread of its own...

> But the network stack could be improved and some of the
> ideas in Van Jacobson's net channels could be usefull when receiving network
> packages with real-time latencies.

... so it's better to focus on a fruitful discussion on these
interesting ideas which may lay the ground for a future coexistence of
both hard-RT and throughput optimised networking stacks in the
mainline kernel. I'm slightly sceptical, but maybe I'll be proven
wrong.

My following remarks are biased toward hart-RT. What may appear
problematic in this context could be a non-issue for scenarios where
the overall throughput counts, not individual packet latencies.

>
> Finding the end point in the receive interrupt and send of the packet to
> the receiving process directly is a good idea if it is fast enough to do
> so in the interrupt context (and I think it can be done very fast). One

This heavily depends on the protocol to parse. Single-packet messages
based on TCP, UDP, or whatever, are yet easy to demux: some table for
the frame type, some for the IP protocol, and another for the port (or
an overall hash for a single table) -> here's the receiver.

But now think of fragmented IP packets. The first piece can be
assigned normally, but the succeeding fragments require a dynamically
added detection in that critical demux path (IP fragments are
identified by src+dest IP, protocol, and an arbitrary ID). Each
pending chain of fragments for a netchannel would create yet another
demux rule. But I'm also curious to see the code used for this by Van
Jacobson.

BTW, that's the issue we also face in RTnet when handling UDP/IP under
hart-RT constraints. We avoid unbounded demux complexity by setting a
hard limit on the number of open chains. If you want to have a look at
the code: www.rtnet.org

> problem in the current setup, is that everything has to go through the
> soft interrupt.  That is even if you make a completely new, non-IP
> protocol, the latency for delivering the frame to your application is
> still limited by the latency of the IP-stack because it still have to go
> through soft irq which might be busy working on IP packages. Even if you
> open a raw socket, the latency is limited to the latency of the soft irq.
> At work we use a widely used commercial RTOS. It got exactly the same
> problem of having every network packet being handled by the same thread.

The question of _where_ to do that demultiplexing is actually not that
critical as _how_ to do it - and with which complexity. For hard-RT,
it should to be O(1) or, if not feasible, O(n), where n is only
influenced by the RT applications and their traffic footprints, but
not by an unknown set of non-RT applications and communication links.
[Even with O(1) demux, the pure numbers of incoming non-RT packets can
still cause QoS crosstalk - a different issue.]

>
> Buffer management is another issue. On the RTOS above you make a buffer pool
> per network device for receiving packages. On Linux received packages are taken
> from the global memory pool with GFP_ATOMIC. On both systems you can easily run
> out of buffers if they are not freed back to the pool fast enough. In that
> case you will just have to drop packages as they are received. Without
> having the code to VJ's net channels, it looks like they solve the problem:
> Each end receiver provides his own receive resources. If a receiver can't cope
> with  all the traffic, it will loose packages, the others wont. That makes it
> safe to run important real-time traffic along with some unpredictable, low
> priority  TCP/IP traffic. If the TCP/IP receivers does not run fast enough,
> their packages will be dropped, but the driver will not drop the real-time
> packages. The nice thing about a real-time task is that you know it's latency
> and therefore know how many receive buffers it needs to avoid loosing
> packages in a worst case scenario.

Yep, this is a core feature for RT networking. And this is essentially
the way we handle it in RTnet for quite some time: "Here is a filled
buffer for you. Give me an empty one from your pool, and it will be
yours. If you can't, I'll drop it!" The existing concept works quite
well for single consumers. But it's still a tricky thing when
considering multiple consumers sharing a physical buffer. RTnet
doesn't handle this so far (except for packet capturing). I have some
rough ideas for a generic solution in my mind, but RTnet users didn't
ask for this so far loudly, thus no further effort was spent on it.

Actually the pre-allocation issue is not only limited to skb-based
networking. It's one reason why we have separate RT Firewire and RT
USB projects. The restrictions and modifications they require make
them unhandy for standard use but perfectly fitting for deterministic
applications.


Ok, to sum up what I see as the core topics for the first steps: we
need A) a mechanism to use pre-allocated buffers for certain
communication links and B) a smart early-demux algorithm of manageable
complexity which decides what receiver has to be accounted for an
incoming packet.

The former is widely a question of restructuring the existing code,
but the latter is still unclear to me. Let me sketch my first idea:

struct pattern {
        unsigned long offset;
        unsigned long mask;
        unsigned long value; /* buffer[offset] & mask == value? */
}

struct rule {
        struct list_head rules;
        int pattern_count;
        struct pattern pattern[MAX_PATTERNS_PER_RULE];
        struct netchannel *destination;
}

For each incoming packet, the NIC or a demux thread would then walk
its list of rules, apply all patterns, and push the packet into the
channel on match. Kind of generic and protocol-agnostic, but will
surely not scale very well, specifically when allowing rules for
fragmented messages popping up. An optimisation might be to use
hard-coded pattern checks for the well-known protocols (UDP, TCP, IP
fragment, etc.). But maybe I'm just overseeing THE simple solution of
the problem now, am I?

Once we had those two core features in the kernel, it would start
making sense to think about how to manage other modifications to NIC
drivers, protocols, and APIs gracefully that are required or desirable
for hard-RT networking.

Looking forward to further discussions!

Jan
