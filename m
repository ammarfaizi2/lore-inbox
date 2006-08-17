Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWHQTRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWHQTRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWHQTRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:17:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36558 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751143AbWHQTR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:17:29 -0400
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Daniel Phillips <phillips@google.com>, David Miller <davem@davemloft.net>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060817184206.GA2873@2ka.mipt.ru>
References: <1155127040.12225.25.camel@twins>
	 <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins>
	 <20060809.165431.118952392.davem@davemloft.net>
	 <1155189988.12225.100.camel@twins> <44DF888F.1010601@google.com>
	 <20060814051323.GA1335@2ka.mipt.ru> <44E3F525.3060303@google.com>
	 <20060817053636.GA30920@2ka.mipt.ru> <44E4AF10.5030308@google.com>
	 <20060817184206.GA2873@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 21:15:14 +0200
Message-Id: <1155842114.5696.310.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 22:42 +0400, Evgeniy Polyakov wrote:
> On Thu, Aug 17, 2006 at 11:01:52AM -0700, Daniel Phillips (phillips@google.com) wrote:
> > *** The system is not OOM, it is in reclaim, a transient condition ***
> 
> It does not matter how condition when not every user can get memory is
> called. And actually no one can know in advance how long it will be.

Well, we have a direct influence here, we're working on code-paths that
are called from reclaim. If we stall, the box is dead.

> > Which Peter already told you!  Please, let's get our facts straight,
> > then we can look intelligently at whether your work is appropriate to
> > solve the block IO network starvation problem that Peter and I are
> > working on.
> 
> I got openssh as example of situation when system does not know in 
> advance, what sockets must be marked as critical.
> OpenSSH works with network and unix sockets in parallel, so you need to
> hack openssh code to be able to allow it to use reserve when there is 
> not enough memory.

OpenSSH or any other user-space program will never ever have the problem
we are trying to solve. Nor could it be fixed the way we are solving it,
user-space programs can be stalled indefinite. We are concerned with
kernel services, and the continued well being of the kernel, not
user-space. (well therefore indirectly also user-space of course)

>  Actually all sockets must be able to get data, since
> kernel can not diffirentiate between telnetd and a process which will 
> receive an ack for swapped page or other significant information.

Oh, but it does, the kernel itself controls those sockets: NBD / iSCSI
and AoE are all kernel services, not user-space. And it is the core of
our work to provide this information to the kernel; to distinguish these
few critical sockets.

> So network must behave separately from main allocator in that period of 
> time, but since it is possible that reserve can be not filled or has not
> enough space or something other, it must be preallocated in far advance
> and should be quite big, but then why netwrok should use it at all, when
> being separated from main allocations solves the problem?

You still need to guarantee data-paths to these services, and you need
to make absolutely sure that your last bit of memory is used to service
these critical sockets, not some random blocked user-space process.

You cannot pre-allocate enough memory _ever_ to satisfy the total
capacity of the network stack. You _can_ allot a certain amount of
memory to the network stack (avoiding DoS), and drop packets once you
exceed that. But still, you need to make sure these few critical
_kernel_ services get their data.

> I do not argue that your approach is bad or does not solve the problem,
> I'm just trying to show that further evolution of that idea eventually
> ends up in separated allocator (as long as all most robust systems
> separate operations), which can improve things in a lot of other sides
> too.

Not a separate allocator per-se, separate socket group, they are
serviced by the kernel, they will never refuse to process data, and it
is critical for the continued well-being of your kernel that they get
their data.

Also, I do not think people would like it if say 100M of their 1G system
just disappears, never to used again for eg. page-cache in periods of
low network traffic.



