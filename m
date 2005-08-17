Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVHQQmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVHQQmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 12:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVHQQmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 12:42:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751160AbVHQQms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 12:42:48 -0400
Date: Wed, 17 Aug 2005 09:43:17 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Joshua Wise <Joshua.Wise@sicortex.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NAPI poll routine happens in interrupt context?
Message-ID: <20050817094317.3437607e@dxpl.pdx.osdl.net>
In-Reply-To: <200508170932.10441.Joshua.Wise@sicortex.com>
References: <200508170932.10441.Joshua.Wise@sicortex.com>
X-Mailer: Sylpheed-Claws 1.9.11 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005 09:32:10 -0400
Joshua Wise <Joshua.Wise@sicortex.com> wrote:

> Hello LKML,

You will get more response to network issues on netdev@vger.kernel.org
 
> I have recently been working on a network driver for an emulated ultra-simple 
> network card, and I've run into a few snags with the NAPI. My current issue 
> is that it seems to me that my poll routine is being called from an atomic 
> context, so when poll calls rx, and rx calls netif_receive_skb, I end up with 
> lots of __might_sleep warnings in the various network layers.

NAPI poll is usually called from softirq context.  This means that
hardware interrupts are enabled, but it is not in a thread context that
can sleep.

> This is not so good. I need every cycle I can get, as this emulator is 
> incredibly slow, so burning cycles by printing out the reported badness is 
> not really acceptible. Conceivably the badness itself is also an issue.

You shouldn't be calling things that could sleep! If you are it
is a bug.

> Before posting here, I did search Google for "lkml napi poll interrupt", 
> although I did not find anything relevant to my issue.
> 
> If interested, the code is available at http://joshuawise.com/lanlan.c . Some 
> notes:
> 
> The virtual lan-lan is a very very simple device. It consists of an ioreg that 
> maintains state of the device, as described by the ioreg bit defines. It also 
> has an ioctlreg that can pass through ioctls to the Linux kernel tap device 
> that it's sitting on top of. (This goes with the ifreq seen in the struct.) 
> One must always write and read in word-aligned chunks to and from it, for 
> simplicity's sake.

Harald Welte is working on a generic virtual Ethernet device, perhaps
you could collaborate with him.

> Feel free to suggest any modifications that this device might need to make it 
> more fully functional. Hopefully we can bring this driver to such a state 
> where it will be usable as a replacement skeleton driver for the NAPI.

> Here is a trace:
> Debug: sleeping function called from invalid context at 
> arch/mips/math-emu/dsemul.c:137
> in_atomic():1, irqs_disabled():0
> Call Trace:
>  [<ffffffff801406e0>] __might_sleep+0x180/0x198
>  [<ffffffff802cec00>] ipv6_rcv+0xc0/0x440
>  [<ffffffff80140428>] do_dsemulret+0x68/0x1a0
>  [<ffffffff8010b3a4>] do_ade+0x24/0x550
>  [<ffffffff80102964>] handle_adel_int+0x3c/0x58
>  [<ffffffff80268160>] netif_receive_skb+0x1b0/0x2e0
>  [<ffffffff802cec04>] ipv6_rcv+0xc4/0x440
>  [<ffffffff80268160>] netif_receive_skb+0x1b0/0x2e0
>  [<ffffffff802572c8>] lanlan_poll+0x3e0/0x440
>  [<ffffffff8026868c>] net_rx_action+0x16c/0x370
>  [<ffffffff802686a8>] net_rx_action+0x188/0x370
>  [<ffffffff80154f28>] __do_softirq+0x118/0x250
>  [<ffffffff80154f28>] __do_softirq+0x118/0x250
>  [<ffffffff80155110>] do_softirq+0xb0/0xe0
>  [<ffffffff80101930>] mipsIRQ+0x130/0x1e0
>  [<ffffffff80101c90>] r4k_wait+0x0/0x10
>  [<ffffffff80103e6c>] cpu_idle+0x4c/0x68
>  [<ffffffff80103e64>] cpu_idle+0x44/0x68
>  [<ffffffff8037fcfc>] start_kernel+0x454/0x4e8
>  [<ffffffff8037fcf4>] start_kernel+0x44c/0x4e8

The bug is that ipv6 is doing an operation to handle MIB statistics and
the MIPS architecture math routines seem to need to sleep. 
Previous versions of SNMP code may have done atomic operations, but
current 2.6 code uses per-cpu variables. 
Also, there is no might sleep in the current 2.6 MIPS code either
so the problem is probably fixed if you use current 2.6.12 or later 
kernel.

Thanks
Steve
