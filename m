Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422860AbWJPTjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422860AbWJPTjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWJPTjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:39:04 -0400
Received: from web50610.mail.yahoo.com ([206.190.38.249]:5270 "HELO
	web50610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1422785AbWJPTjC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:39:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Nlhffppz7s4QP9BBfw+/9j6zdsMEmzXjqsiPxA3wcR/Gtq/57ZsPB8FMDBZWu0PB3mD7RX3FXxs71q//dPtqhTpSHlRkVm6uZpoF+rohnq7nVMsuERPh2UkmelXJJ3ioFtzfFL61wQNsedStnu0p9YtNUj2+pMDphg+V9x5kE+M=  ;
Message-ID: <20061016193900.96651.qmail@web50610.mail.yahoo.com>
Date: Mon, 16 Oct 2006 12:39:00 -0700 (PDT)
From: Joan Raventos <jraventos@yahoo.com>
Subject: Re: poll problem with PF_PACKET when using PACKET_RX_RING
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>Is this a bug in PF_PACKET? Should the socket queue be
>>>>emptied by packet_set_ring (called via setsockopt when
>>>>PACKET_RX_RING is used) so the above cannot happen?
>>>>Should the user-space app drain the socket queue with
>>>>recvfrom prior to (4) -quite unlikely in practice-?
>> 
>>
>>>I guess the best way is not to bind the socket before having
>>>completed setup. We could still flush the queue to make life
>>>easier for userspace, not sure about that ..
> 
> 
>> Even w/o bind, packet_create is doing a dev_add_pack, which I think will make pkts arrive to that socket (ie. in netif_receive_skb one can see the loops over the rcu for both ptype_all and type-specific which seem match whenever !ptype->dev || ptype->dev==skb->dev).
>> 
>> Also the packet_mmap.txt doc does not mention bind, which probably is more a mechanism to closely specify a dev than to signal socket readiness.

> packet_create only calls dev_add_pack if a protocol is given.
> You can use a protocol number of 0 and then bind the socket
> after setting it up properly.

Currently I'm using ETH_P_ALL on the socket call. If I understand your proposal correctly you suggest to pass 0 on the socket call, so dev_add_pack is not called, and afterwards use a sockaddr_ll with bind to set the sll_protocol to whatever value (ETH_P_ALL in my case). Correct?

> According to your description, you first used setsockopt(...,
> PACKET_RX_RING), then mmap. In that case the receive queue
> should already get flushed by packet_set_ring (about line 1710).

Ok, I see... I guess if mmap has not been issued by the time setsockopt is called then po->mapped == 0 and the code you point out is triggered, specifically skb_queue_purge.

> How did you verify that the receive queue still contains packets?

You are totally right! non-block recv to the descriptor returns EAGAIN, so the queues are empty. After further instrumentation of the ring code, I'm suspecting of an issue with the ring read index at the user-space app...

Nevertheless the whole ring communication between kernel and user-space seems to be based on marking pkts via a flag in each pkt slot in the ring (tp_status). I guess it works fine because the assignments are atomic (like the one on af_packet.c:671). Correct?
BTW what's the purpose of mb() and why is it exactly needed in that position in the code?

Thx again!

Salu2,
J.



