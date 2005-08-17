Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVHQOTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVHQOTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHQOTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:19:50 -0400
Received: from static-151-204-232-50.bos.east.verizon.net ([151.204.232.50]:54146
	"EHLO mail2.sicortex.com") by vger.kernel.org with ESMTP
	id S1751138AbVHQOTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:19:49 -0400
From: Joshua Wise <Joshua.Wise@sicortex.com>
Organization: SiCortex
To: linux-kernel@vger.kernel.org
Subject: Re: NAPI poll routine happens in interrupt context?
Date: Wed, 17 Aug 2005 10:19:45 -0400
User-Agent: KMail/1.8.1
Cc: Aaron Brooks <aaron.brooks@sicortex.com>
References: <200508170932.10441.Joshua.Wise@sicortex.com>
In-Reply-To: <200508170932.10441.Joshua.Wise@sicortex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508171019.45593.Joshua.Wise@sicortex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has come to my attention that the link that I posted previously was 
nonfunctional. It has been fixed.

As well, here are some other pertinent details:

This is kernel 2.6.13-rc2, the latest that works with MIPS SMP.

Here is a trace:
Debug: sleeping function called from invalid context at 
arch/mips/math-emu/dsemul.c:137
in_atomic():1, irqs_disabled():0
Call Trace:
 [<ffffffff801406e0>] __might_sleep+0x180/0x198
 [<ffffffff802cec00>] ipv6_rcv+0xc0/0x440
 [<ffffffff80140428>] do_dsemulret+0x68/0x1a0
 [<ffffffff8010b3a4>] do_ade+0x24/0x550
 [<ffffffff80102964>] handle_adel_int+0x3c/0x58
 [<ffffffff80268160>] netif_receive_skb+0x1b0/0x2e0
 [<ffffffff802cec04>] ipv6_rcv+0xc4/0x440
 [<ffffffff80268160>] netif_receive_skb+0x1b0/0x2e0
 [<ffffffff802572c8>] lanlan_poll+0x3e0/0x440
 [<ffffffff8026868c>] net_rx_action+0x16c/0x370
 [<ffffffff802686a8>] net_rx_action+0x188/0x370
 [<ffffffff80154f28>] __do_softirq+0x118/0x250
 [<ffffffff80154f28>] __do_softirq+0x118/0x250
 [<ffffffff80155110>] do_softirq+0xb0/0xe0
 [<ffffffff80101930>] mipsIRQ+0x130/0x1e0
 [<ffffffff80101c90>] r4k_wait+0x0/0x10
 [<ffffffff80103e6c>] cpu_idle+0x4c/0x68
 [<ffffffff80103e64>] cpu_idle+0x44/0x68
 [<ffffffff8037fcfc>] start_kernel+0x454/0x4e8
 [<ffffffff8037fcf4>] start_kernel+0x44c/0x4e8

Apologies for any inconvenience.

joshua

On Wednesday 17 August 2005 09:32, Joshua Wise wrote:
> Hello LKML,
>
> I have recently been working on a network driver for an emulated
> ultra-simple network card, and I've run into a few snags with the NAPI. My
> current issue is that it seems to me that my poll routine is being called
> from an atomic context, so when poll calls rx, and rx calls
> netif_receive_skb, I end up with lots of __might_sleep warnings in the
> various network layers.
>
> This is not so good. I need every cycle I can get, as this emulator is
> incredibly slow, so burning cycles by printing out the reported badness is
> not really acceptible. Conceivably the badness itself is also an issue.
>
> Before posting here, I did search Google for "lkml napi poll interrupt",
> although I did not find anything relevant to my issue.
>
> If interested, the code is available at http://joshuawise.com/lanlan.c .
> Some notes:
>
> The virtual lan-lan is a very very simple device. It consists of an ioreg
> that maintains state of the device, as described by the ioreg bit defines.
> It also has an ioctlreg that can pass through ioctls to the Linux kernel
> tap device that it's sitting on top of. (This goes with the ifreq seen in
> the struct.) One must always write and read in word-aligned chunks to and
> from it, for simplicity's sake.
>
> Feel free to suggest any modifications that this device might need to make
> it more fully functional. Hopefully we can bring this driver to such a
> state where it will be usable as a replacement skeleton driver for the
> NAPI.
>
> Please cc: Aaron and myself, as neither of us are subscribed to lkml.
>
> Thanks in advance,
> joshua
