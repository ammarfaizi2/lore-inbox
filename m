Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWF2LkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWF2LkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWF2LkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:40:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:48612 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751484AbWF2Lj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:39:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=Sn2r/ZXRfpgUXZjWnpKLgkfH8GNeSX9FnKgC6cr4GT8nj84pf3IrKDzI0JzCBUBjnrrrGADf/f/jGCPuMpaeUMgTiJiX7VDAToew1ESotNevcHxsQ7TpbQZyHdMujCaLjtE9lplac2jof7inCrpWpeR3Y/Sk1EVaEM0RmkbWMZg=
Date: Thu, 29 Jun 2006 13:40:15 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Milan Svoboda <msvoboda@ra.rockwell.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
In-Reply-To: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com>
Message-ID: <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jun 2006, Milan Svoboda wrote:

>>>
>>>> Thank you for your answer, I look at it too...
>>>>
>>>
>>> eepro100 seems to be SMP safe, so it shouldn't be there.
>>> Have anyone else used eepro100 with preempt-realtime?
>
>> I use to use it a while back ago, when e100 would screw up my network
>> card. But that has been fixed so I don't use eepro100 and I would
>> recommend anyone else to switch to e100.
>
> I have been using it because the same reason as you, but simply didn't
> noticed that e100 works now ;-)
>
> I switched to e100 and turned debug messages on and got many of these:
>
> BUG: scheduling with irqs disabled: softirq-net-rx//0x00000000/6
> caller is schedule+0x10/0x114
> [<c0024e24>] (dump_stack+0x0/0x28) from [<c01ae528>] (schedule+0xf8/0x114)
> [<c01ae430>] (schedule+0x0/0x114) from [<c01afb60>]
> (rt_lock_slowlock+0x100/0x240)
> r5 = C01F070C  r4 = C4150000
> [<c01afa60>] (rt_lock_slowlock+0x0/0x240) from [<c01aff28>]
> (__lock_text_start+0x18/0x1c)
> [<c01aff10>] (__lock_text_start+0x0/0x1c) from [<c0078b08>]
> (kfree+0x2c/0x84)
> [<c0078adc>] (kfree+0x0/0x84) from [<c002aab0>]
> (dma_unmap_single+0x110/0x1a8)
> r5 = C4124BE0  r4 = C7C4B6E0
> [<c002a9a0>] (dma_unmap_single+0x0/0x1a8) from [<c012766c>]
> (e100_poll+0x2e0/0x59c)
> r8 = C432A3A0  r7 = C41C9BA0  r6 = C41C9B60  r5 = 00000001
> r4 = FFC881C0
> [<c012738c>] (e100_poll+0x0/0x59c) from [<c0148280>]
> (net_rx_action+0xa0/0x1a4)
> [<c01481e0>] (net_rx_action+0x0/0x1a4) from [<c0039020>]
> (ksoftirqd+0x110/0x1b0)
> [<c0038f10>] (ksoftirqd+0x0/0x1b0) from [<c00490d8>] (kthread+0x110/0x13c)
> [<c0048fc8>] (kthread+0x0/0x13c) from [<c0035054>] (do_exit+0x0/0x998)
> r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
> r4 = 00000000
> ---------------------------
> | preempt count: 00000000 ]
> | 0-level deep critical section nesting:
> ----------------------------------------
>

It seems that dma_unmap_single() on arm contains
 	local_irq_save(flags);

 	unmap_single(dev, dma_addr, size, dir);

 	local_irq_restore(flags);

I don't know the dma code on arm. It doesn't look like a per-cpu code but it
seems to me that it is not SMP safe and therefore not preempt-realtime 
safe, either.

The hard thing is to figure out which datastructures exactly is protected 
by those irq-disable and put in a spinlock..

I added Deepak Saxena on CC as he seems to be the last one who touched the 
file.


Esben

> These messages are different as their source seems to be softirq-net-rx. I
> cannot reproduce
> the original bug now...
>
>
> PS: Is latency tracing working on arm platform? I'm unable to get this
> statistic...
>
> Milan
>
>
