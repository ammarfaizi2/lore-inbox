Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWHQX0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWHQX0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWHQX0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:26:49 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31079 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030312AbWHQX0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:26:48 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=HaZYM0rSq/j/8kwF4JWVj0Yh/AVfQGZj+xmV7m+Jn66UxKKOwtPS5zx8gh67Dmlla
	IU1Z9T8x6as5CuMAeXzTw==
Message-ID: <44E4FAAA.2050104@google.com>
Date: Thu, 17 Aug 2006 16:24:26 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
References: <1155130353.12225.53.camel@twins> <20060809.165431.118952392.davem@davemloft.net> <1155189988.12225.100.camel@twins> <44DF888F.1010601@google.com> <20060814051323.GA1335@2ka.mipt.ru> <44E3F525.3060303@google.com> <20060817053636.GA30920@2ka.mipt.ru> <44E4AF10.5030308@google.com> <20060817184206.GA2873@2ka.mipt.ru> <1155842114.5696.310.camel@twins> <20060817194850.GA19647@2ka.mipt.ru>
In-Reply-To: <20060817194850.GA19647@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Thu, Aug 17, 2006 at 09:15:14PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> 
>>>I got openssh as example of situation when system does not know in 
>>>advance, what sockets must be marked as critical.
>>>OpenSSH works with network and unix sockets in parallel, so you need to
>>>hack openssh code to be able to allow it to use reserve when there is 
>>>not enough memory.
>>
>>OpenSSH or any other user-space program will never ever have the problem
>>we are trying to solve. Nor could it be fixed the way we are solving it,
>>user-space programs can be stalled indefinite. We are concerned with
>>kernel services, and the continued well being of the kernel, not
>>user-space. (well therefore indirectly also user-space of course)
> 
> 
> You limit your system here - it is possible that userspace should send
> some command when kernel agent requires some negotiation.
> And even for them it is possible to require ARP request and/or ICMP
> processing.
> 
> 
>>> Actually all sockets must be able to get data, since
>>>kernel can not diffirentiate between telnetd and a process which will 
>>>receive an ack for swapped page or other significant information.
>>
>>Oh, but it does, the kernel itself controls those sockets: NBD / iSCSI
>>and AoE are all kernel services, not user-space. And it is the core of
>>our work to provide this information to the kernel; to distinguish these
>>few critical sockets.
> 
> 
> As I stated above it is not enough.
> And even if you will cover all kernel-only network allocations, which are
> used for your selected datapath, problem still there - admin is unable
> to connect although it can be critical connection too.
> 
> 
>>>So network must behave separately from main allocator in that period of 
>>>time, but since it is possible that reserve can be not filled or has not
>>>enough space or something other, it must be preallocated in far advance
>>>and should be quite big, but then why netwrok should use it at all, when
>>>being separated from main allocations solves the problem?
>>
>>You still need to guarantee data-paths to these services, and you need
>>to make absolutely sure that your last bit of memory is used to service
>>these critical sockets, not some random blocked user-space process.
>>
>>You cannot pre-allocate enough memory _ever_ to satisfy the total
>>capacity of the network stack. You _can_ allot a certain amount of
>>memory to the network stack (avoiding DoS), and drop packets once you
>>exceed that. But still, you need to make sure these few critical
>>_kernel_ services get their data.
> 
> Feel free to implement any receiving policy inside _separated_ allocator
> to meet your needs, but if allocator depends on main system's memory
> conditions it is always possible that it will fail to make forward
> progress.

Wrong.  Our main allocator has a special reserve that can be accessed
only by a task that has its PF_MEMALLOC flag set.  This reserve exists
in order to guarantee forward progress in just such situations as the
network runs into when it is trying to receive responses from a remote
disk.  Anything otherwise is a bug.

>>>I do not argue that your approach is bad or does not solve the problem,
>>>I'm just trying to show that further evolution of that idea eventually
>>>ends up in separated allocator (as long as all most robust systems
>>>separate operations), which can improve things in a lot of other sides
>>>too.
>>
>>Not a separate allocator per-se, separate socket group, they are
>>serviced by the kernel, they will never refuse to process data, and it
>>is critical for the continued well-being of your kernel that they get
>>their data.

The memalloc reserve is indeed a separate reserve, however it is a
reserve that already exists, and you are busy creating another separate
reserve to further partition memory.  Partitioning memory is not the
direction we should be going, we should be trying to unify our reserves
wherever possible, and find ways such as Andrew and others propose to
implement "reserve on demand", or in other words, take advantage of
"easily freeable" pages.

If your allocation code is so much more efficient than slab then why
don't you fix slab instead of replicating functionality that already
exists elsewhere in the system, and has since day one?

> You do not know in advance which sockets must be separated (since only
> in the simplest situation it is the same as in NBD and is
> kernelspace-only),

Yes we do, they are exactly those sockets that lie in the block IO path.
The VM cannot deadlock on any others.

> you can not solve problem with ARP/ICMP/route changes and other control
> messages, netfilter, IPsec and compression which still can happen in your 
> setup, 

If you bothered to read the patches you would know that ICMP is indeed
handled.  ARP I don't think so, we may need to do that since ARP can
believably be required for remote disk interface failover.  Anybody
who designs ssh into remote disk failover is an idiot.  Ssh for
configuration, monitoring and administration is fine.  Ssh for fencing
or whatever is just plain stupid, unless the nodes running both server
and client are not allowed to mount the remote disk.

> if something goes wrong and receiving will require additional
> allocation from network datapath, system is dead,
> this strict conditions does not allow flexible control over possible
> connections and does not allow to create additional connections.

You know that how?

>>Also, I do not think people would like it if say 100M of their 1G system
>>just disappears, never to used again for eg. page-cache in periods of
>>low network traffic.
> 
> Just for clarification: network tree allocator gets 512kb and then
> increases cache size when it is required. Default value can be changed
> of course.

Great.  Now why does the network layer need its own, invented-in-netland
allocator?  Why can't everybody use your allocator if it is better?

Also, please don't get the idea that your allocator by itself solves the
block IO receive starvation problem.  At the very least you need to do
something about network traffic that is unrelated to forward progress of
memory writeout, yet can starve the memory writeout.  Oh wait, our patch
set already does that.

Regards,

Daniel
