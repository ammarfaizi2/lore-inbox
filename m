Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWD0IJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWD0IJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWD0IJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:09:11 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:3693 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964968AbWD0IJK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:09:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IPcW1l2Cg+9T5D1yGyeeOQFisw10HZyjlFxep1P+iV5DU4LCtHrt4kzbfvAGnmKvO85txxuyjAEFBD9EKymF5Vsmn5qAh52LLPry4B3asAAO4g+gRvLC0qsziJhXJETcIjmJUpgTL71GS4DAOh0xa1TlCAxDIc/kxBPzE7HnSN8=
Message-ID: <58d0dbf10604270109j13ba5208h78f9b4de891370a8@mail.gmail.com>
Date: Thu, 27 Apr 2006 10:09:06 +0200
From: "Jan Kiszka" <jan.kiszka@googlemail.com>
To: "Esben Nielsen" <simlo@phys.au.dk>
Subject: Re: Van Jacobson's net channels and real-time
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0604212332110.30761-100000@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <58d0dbf10604210153r208504d4r4a7f4139e711ff7f@mail.gmail.com>
	 <Pine.LNX.4.64.0604212332110.30761-100000@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/4/24, Esben Nielsen <simlo@phys.au.dk>:
> On Fri, 21 Apr 2006, Jan Kiszka wrote:
>
> > 2006/4/20, Esben Nielsen <simlo@phys.au.dk>:
> >>
> >> Finding the end point in the receive interrupt and send of the packet to
> >> the receiving process directly is a good idea if it is fast enough to do
> >> so in the interrupt context (and I think it can be done very fast). One
> >
> > This heavily depends on the protocol to parse. Single-packet messages
> > based on TCP, UDP, or whatever, are yet easy to demux: some table for
> > the frame type, some for the IP protocol, and another for the port (or
> > an overall hash for a single table) -> here's the receiver.
> >
> > But now think of fragmented IP packets. The first piece can be
> > assigned normally, but the succeeding fragments require a dynamically
> > added detection in that critical demux path (IP fragments are
> > identified by src+dest IP, protocol, and an arbitrary ID). Each
> > pending chain of fragments for a netchannel would create yet another
> > demux rule. But I'm also curious to see the code used for this by Van
> > Jacobson.
>
> Turn off fragmentation :-) Web servers often do that (giving a lot of
> trouble to pppoe users). IPv6 is also defined without fragmentation at
> this level, right?

As far as I see it the demux situation is not that different with IPv6
- as long as you do not prepare the fragments specifically. I'm
thinking of IP options carrying the destination port which is so far
only contained in the first fragment. But such tweaks only work if all
participants follow the rules. Anyway, worth to keep in mind.

> A good first solution would be to send framented IP through the usual IP
> stack.
>

Although this excludes protocols which exploit this feature. But you
are right, one problem after the other.

>
> >
> > BTW, that's the issue we also face in RTnet when handling UDP/IP under
> > hart-RT constraints. We avoid unbounded demux complexity by setting a
> > hard limit on the number of open chains. If you want to have a look at
> > the code: www.rtnet.org
>
> I am only on the net about 30 min every 2nd day. I write mails offline and
> send them later - that is why I am so late at answering.
>

Different situation on my side - same effect. :-/

> >
> >> problem in the current setup, is that everything has to go through the
> >> soft interrupt.  That is even if you make a completely new, non-IP
> >> protocol, the latency for delivering the frame to your application is
> >> still limited by the latency of the IP-stack because it still have to go
> >> through soft irq which might be busy working on IP packages. Even if you
> >> open a raw socket, the latency is limited to the latency of the soft irq.
> >> At work we use a widely used commercial RTOS. It got exactly the same
> >> problem of having every network packet being handled by the same thread.
> >
> > The question of _where_ to do that demultiplexing is actually not that
> > critical as _how_ to do it - and with which complexity. For hard-RT,
> > it should to be O(1) or, if not feasible, O(n), where n is only
> > influenced by the RT applications and their traffic footprints, but
> > not by an unknown set of non-RT applications and communication links.
> > [Even with O(1) demux, the pure numbers of incoming non-RT packets can
> > still cause QoS crosstalk - a different issue.]
>
> Yep, ofcourse. But not obviouse to people in not familiar with
> deterministic RT. I assume that you mean the same by "hard RT" as I mean
> by "deterministic RT". Old discussions on lkml has shown that there is a
> lot of disagreement about what is meant :-)

I tend to be sluggish, I know. Actually, when being pedantic, soft RT
can also be deterministic in failing to meet the specified deadline
once in a while :). But I'm sure we mean the same: the required
logical and temporal properties must always be fulfilled, i.e. without
even rare exceptions.

>
> >
> >>
> >> Buffer management is another issue. On the RTOS above you make a buffer pool
> >> per network device for receiving packages. On Linux received packages are taken
> >> from the global memory pool with GFP_ATOMIC. On both systems you can easily run
> >> out of buffers if they are not freed back to the pool fast enough. In that
> >> case you will just have to drop packages as they are received. Without
> >> having the code to VJ's net channels, it looks like they solve the problem:
> >> Each end receiver provides his own receive resources. If a receiver can't cope
> >> with  all the traffic, it will loose packages, the others wont. That makes it
> >> safe to run important real-time traffic along with some unpredictable, low
> >> priority  TCP/IP traffic. If the TCP/IP receivers does not run fast enough,
> >> their packages will be dropped, but the driver will not drop the real-time
> >> packages. The nice thing about a real-time task is that you know it's latency
> >> and therefore know how many receive buffers it needs to avoid loosing
> >> packages in a worst case scenario.
> >
> > Yep, this is a core feature for RT networking. And this is essentially
> > the way we handle it in RTnet for quite some time: "Here is a filled
> > buffer for you. Give me an empty one from your pool, and it will be
> > yours. If you can't, I'll drop it!" The existing concept works quite
> > well for single consumers. But it's still a tricky thing when
> > considering multiple consumers sharing a physical buffer. RTnet
> > doesn't handle this so far (except for packet capturing). I have some
> > rough ideas for a generic solution in my mind, but RTnet users didn't
> > ask for this so far loudly, thus no further effort was spent on it.
> >
>
> Exchanging skbs instead of simply handing over skbs is ofcourse a good
> idea, but it will slow down the stack slightly.  VJ _might_ have made
> stuff more effective.

I'm scratching my head, digging for the reasons why I once considered
and then dropped the idea of accounting, i.e. maintaining counters
instead of passing empty buffers. One reason likely was that RTnet is
not built on top of strict one-way channels. This means you either
have to maintain a central pool for free buffers (not that scalable)
or will run into troubles having enough real buffers in the local
pools of NICs, sockets, etc. when they are actually needed. Might be
feasible, though, under the constraint of single producer / single
consumer.

>
> I came up with a simple, quite general idea - but not general enough
> to include fragmentation. See below.
>

I like it! It's a bit memory-hungry, but I guess this can be improved.
See data structure suggestions below.

> > Once we had those two core features in the kernel, it would start
> > making sense to think about how to manage other modifications to NIC
> > drivers, protocols, and APIs gracefully that are required or desirable
> > for hard-RT networking.
> >
> > Looking forward to further discussions!
> >
> You will have it :-)

Oh, yeah, I'm afraid. ;)

>
> > Jan
> >
>
> Here is a simple filter idea. The kernel have to put a maximum
> filter length to make the filtering deterministic.
>
> filter.h:
> ----------------------------------------------------------------------
> /*
>  * Copyright (c) 2006 Esben Nielsen
>  *
>  * Distributeable under GPL
>  *
>  * Released under the terms of the GNU GPL v2.0.
>  */
>
> #ifndef FILTER_H
> #define FILTER_H
>
> enum rx_action_type
> {
>         LOOK_AT_BYTE,
>         GIVE_TO_CHANNEL
> };

I would additionally introduce COMPARE_BYTE in order to replace
table-based lookup in case the number of different bytes is simply too
small. Look e.g. at the high byte of the Ethernet frame type
considering ETH_P_ARP and ETH_P_IP (the common case) - they are
identical.

>
> struct rx_action
> {
>         int usage;
>         enum rx_action_type type;
>         union
>         {
>                 struct {
>                         unsigned long offset;
>                         struct rx_action *actions[256];
>                         struct rx_action *not_that_long;
>                 } look_at_byte;
>                 struct {
>                         struct netchannel *channel;
>                         struct rx_action *cont;
>                 } give_to_channel;
>         } args;
> };

What about this:

struct rx_action_hdr
{
        int usage;
        enum rx_action_type type;
}

struct rx_demux_byte
{
        struct rx_action_hdr hdr;
        unsigned long offset;
        struct rx_action *actions[256];
        struct rx_action *not_that_long;
}

struct rx_compare_byte
{
        struct rx_action_hdr hdr;
        unsigned long offset;
        unsigned char value;
        struct rx_action *action;
        struct rx_action *not_that_long;
}

struct rx_give_to_channel{
        struct rx_action_hdr hdr;
        struct netchannel *channel;
        struct rx_action *cont;
}

Sorry, I haven't looked at further details of your implementation yet.

Jan
