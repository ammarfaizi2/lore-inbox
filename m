Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWHQTx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWHQTx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWHQTx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:53:28 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:25479 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030214AbWHQTx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:53:26 -0400
Date: Thu, 17 Aug 2006 23:48:50 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Daniel Phillips <phillips@google.com>, David Miller <davem@davemloft.net>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060817194850.GA19647@2ka.mipt.ru>
References: <1155130353.12225.53.camel@twins> <20060809.165431.118952392.davem@davemloft.net> <1155189988.12225.100.camel@twins> <44DF888F.1010601@google.com> <20060814051323.GA1335@2ka.mipt.ru> <44E3F525.3060303@google.com> <20060817053636.GA30920@2ka.mipt.ru> <44E4AF10.5030308@google.com> <20060817184206.GA2873@2ka.mipt.ru> <1155842114.5696.310.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155842114.5696.310.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 17 Aug 2006 23:52:18 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 09:15:14PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > I got openssh as example of situation when system does not know in 
> > advance, what sockets must be marked as critical.
> > OpenSSH works with network and unix sockets in parallel, so you need to
> > hack openssh code to be able to allow it to use reserve when there is 
> > not enough memory.
> 
> OpenSSH or any other user-space program will never ever have the problem
> we are trying to solve. Nor could it be fixed the way we are solving it,
> user-space programs can be stalled indefinite. We are concerned with
> kernel services, and the continued well being of the kernel, not
> user-space. (well therefore indirectly also user-space of course)

You limit your system here - it is possible that userspace should send
some command when kernel agent requires some negotiation.
And even for them it is possible to require ARP request and/or ICMP
processing.

> >  Actually all sockets must be able to get data, since
> > kernel can not diffirentiate between telnetd and a process which will 
> > receive an ack for swapped page or other significant information.
> 
> Oh, but it does, the kernel itself controls those sockets: NBD / iSCSI
> and AoE are all kernel services, not user-space. And it is the core of
> our work to provide this information to the kernel; to distinguish these
> few critical sockets.

As I stated above it is not enough.
And even if you will cover all kernel-only network allocations, which are
used for your selected datapath, problem still there - admin is unable
to connect although it can be critical connection too.

> > So network must behave separately from main allocator in that period of 
> > time, but since it is possible that reserve can be not filled or has not
> > enough space or something other, it must be preallocated in far advance
> > and should be quite big, but then why netwrok should use it at all, when
> > being separated from main allocations solves the problem?
> 
> You still need to guarantee data-paths to these services, and you need
> to make absolutely sure that your last bit of memory is used to service
> these critical sockets, not some random blocked user-space process.
> 
> You cannot pre-allocate enough memory _ever_ to satisfy the total
> capacity of the network stack. You _can_ allot a certain amount of
> memory to the network stack (avoiding DoS), and drop packets once you
> exceed that. But still, you need to make sure these few critical
> _kernel_ services get their data.

Feel free to implement any receiving policy inside _separated_ allocator
to meet your needs, but if allocator depends on main system's memory
conditions it is always possible that it will fail to make forward
progress.

> > I do not argue that your approach is bad or does not solve the problem,
> > I'm just trying to show that further evolution of that idea eventually
> > ends up in separated allocator (as long as all most robust systems
> > separate operations), which can improve things in a lot of other sides
> > too.
> 
> Not a separate allocator per-se, separate socket group, they are
> serviced by the kernel, they will never refuse to process data, and it
> is critical for the continued well-being of your kernel that they get
> their data.

You do not know in advance which sockets must be separated (since only
in the simplest situation it is the same as in NBD and is
kernelspace-only),
you can not solve problem with ARP/ICMP/route changes and other control
messages, netfilter, IPsec and compression which still can happen in your 
setup, 
if something goes wrong and receiving will require additional
allocation from network datapath, system is dead,
this strict conditions does not allow flexible control over possible
connections and does not allow to create additional connections.

As far as I understood, it is ok to solve the problem in the exact your
case without all or most of the above issues in the setup, but in
general some other mechanism should be used, which will not suffer or
will allow to control above issues.

> Also, I do not think people would like it if say 100M of their 1G system
> just disappears, never to used again for eg. page-cache in periods of
> low network traffic.

Just for clarification: network tree allocator gets 512kb and then
increases cache size when it is required. Default value can be changed
of course.

-- 
	Evgeniy Polyakov
