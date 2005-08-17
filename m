Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVHQRVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVHQRVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVHQRVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:21:33 -0400
Received: from static-151-204-232-50.bos.east.verizon.net ([151.204.232.50]:63638
	"EHLO mail2.sicortex.com") by vger.kernel.org with ESMTP
	id S1751179AbVHQRVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:21:32 -0400
From: Joshua Wise <Joshua.Wise@sicortex.com>
Organization: SiCortex
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: NAPI poll routine happens in interrupt context?
Date: Wed, 17 Aug 2005 13:21:18 -0400
User-Agent: KMail/1.8.1
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org, Aaron Brooks <aaron.brooks@sicortex.com>
References: <200508170932.10441.Joshua.Wise@sicortex.com> <20050817094317.3437607e@dxpl.pdx.osdl.net>
In-Reply-To: <20050817094317.3437607e@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508171321.20094.Joshua.Wise@sicortex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 August 2005 12:43, Stephen Hemminger wrote:
> You will get more response to network issues on netdev@vger.kernel.org
Okay. Thanks.

> NAPI poll is usually called from softirq context.  This means that
> hardware interrupts are enabled, but it is not in a thread context that
> can sleep.
Okay. I wasn't aware of quite how it was "supposed" to be.

> You shouldn't be calling things that could sleep! If you are it
> is a bug.
I guess I'd better track down this bug, then :)

> Harald Welte is working on a generic virtual Ethernet device, perhaps
> you could collaborate with him.
I assume he is on this mailing list?

> The bug is that ipv6 is doing an operation to handle MIB statistics and
> the MIPS architecture math routines seem to need to sleep.
> Previous versions of SNMP code may have done atomic operations, but
> current 2.6 code uses per-cpu variables.
> Also, there is no might sleep in the current 2.6 MIPS code either
> so the problem is probably fixed if you use current 2.6.12 or later
> kernel.
Hm -- I am using 2.6.13-rc2.
Here is a new trace, showing the same issue with IPv4:

Debug: sleeping function called from invalid context at 
arch/mips/math-emu/dsemul.c:137 
in_atomic():1, irqs_disabled():0
Call Trace:
 [<ffffffff801406e0>] __might_sleep+0x180/0x198 (kernel/sched.c:5223)
 [<ffffffff80101930>] mipsIRQ+0x130/0x1e0 (arch/mips/sc1000/mipsIRQ.S:95)
 [<ffffffff802860fc>] ip_rcv+0x9c/0x7b0 (net/ipv4/ip_input.c:381)
 [<ffffffff80140428>] do_dsemulret+0x68/0x1a0 
(arch/mips/math-emu/dsemul.c:137)
 [<ffffffff8010b3a4>] do_ade+0x24/0x550 (arch/mips/kernel/unaligned.c:506)
 [<ffffffff80102964>] handle_adel_int+0x3c/0x58 (arch/mips/kernel/genex.S:281)
 [<ffffffff80268260>] netif_receive_skb+0x1b0/0x2e0 (net/core/dev.c:1646)
 [<ffffffff80286100>] ip_rcv+0xa0/0x7b0 (net/ipv4/ip_input.c:394)
 [<ffffffff8014da5c>] printk+0x2c/0x38 (kernel/printk.c:515)
 [<ffffffff80268260>] netif_receive_skb+0x1b0/0x2e0 (net/core/dev.c:1646)
 [<ffffffff802573c8>] lanlan_poll+0x3e0/0x440 (drivers/net/lanlan.c:246)
etc, etc.

CC:'ing to linux-mips for obvious reasons. This seems to stem from an 
unaligned access. If this is no longer appropriate for linux-kernel, feel 
free to stop CCing to there, and I will follow.

Thanks,
joshua
