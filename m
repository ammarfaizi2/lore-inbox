Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUINWDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUINWDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUINWBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:01:10 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:6079 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269590AbUINRKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:10:00 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.9-rc1-mm5 bug in tcp_recvmsg?
Date: Tue, 14 Sep 2004 10:09:44 -0700
User-Agent: KMail/1.7
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org> <200409131654.27727.jbarnes@engr.sgi.com> <20040913165557.568cdffb.davem@davemloft.net>
In-Reply-To: <20040913165557.568cdffb.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409141009.44996.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 13, 2004 4:55 pm, David S. Miller wrote:
> diff -Nru a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> --- a/net/sched/sch_generic.c 2004-09-13 16:38:39 -07:00
> +++ b/net/sched/sch_generic.c 2004-09-13 16:38:39 -07:00
> @@ -148,8 +148,10 @@
>       spin_lock(&dev->queue_lock);
>       return -1;
>      }
> -    if (ret == NETDEV_TX_LOCKED && nolock)
> +    if (ret == NETDEV_TX_LOCKED && nolock) {
> +     spin_lock(&dev->queue_lock);
>       goto collision;
> +    }
>     }
>
>     /* NETDEV_TX_BUSY - we need to requeue */

Ok, is *this* the sort of thing you'd expect this patch to fix?  I've seen it 
on a couple of different machines now (one 32p and one 8p), but I haven't 
seen it since applying the above to the BK tree as of this morning.  Either 
way, I'll keep pounding on different machines using the BK tree + your patch 
to see what problems I run into.

Thanks,
Jesse

bad: scheduling while atomic!

Call Trace:
 [<a000000100017320>] show_stack+0x80/0xa0
                                sp=e00002bc38dffbd0 bsp=e00002bc38df9250
 [<a000000100017370>] dump_stack+0x30/0x60
                                sp=e00002bc38dffda0 bsp=e00002bc38df9238
 [<a0000001006a7500>] schedule+0x1160/0x1520
                                sp=e00002bc38dffda0 bsp=e00002bc38df9128
 [<a0000001006a8430>] schedule_timeout+0xf0/0x200
                                sp=e00002bc38dffdc0 bsp=e00002bc38df90f0
 [<a000000100192e40>] sys_poll+0x520/0x7c0
                                sp=e00002bc38dffe00 bsp=e00002bc38df9018
 [<a00000010000f4c0>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00002bc38dffe30 bsp=e00002bc38df8fd8
Warning: kfree_skb on hard IRQ a0000001005dcba0
bad: scheduling while atomic!

Call Trace:
 [<a000000100017320>] show_stack+0x80/0xa0
                                sp=e00002bc38dffc40 bsp=e00002bc38df9100
 [<a000000100017370>] dump_stack+0x30/0x60
                                sp=e00002bc38dffe10 bsp=e00002bc38df90e8
 [<a0000001006a7500>] schedule+0x1160/0x1520
                                sp=e00002bc38dffe10 bsp=e00002bc38df8fd8
 [<a00000010000fa20>] skip_rbs_switch+0x90/0xf0
                                sp=e00002bc38dffe30 bsp=e00002bc38df8fd8
Unable to handle kernel paging request at virtual address 20000000001bcab0
ls[11638]: Oops 4294967296 [1]
Modules linked in:

Pid: 11638, CPU 2, comm:                   ls
psr : 00001013081a6018 ifs : 8000000000000003 ip  : [<20000000001bcab0>]    
Nottainted
ip is at 0x20000000001bcab0
unat: 0000000000000000 pfs : c000000000000207 rsc : 000000000000000f
rnat: 0000000000000000 bsps: 60000fff7fffc3f0 pr  : 0000000005a6a9e9
ldrs: 0000000000880000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : 20000000001b9390 b6  : 20000000001b9360 b7  : 2000000000173d30
f6  : 1003ecccccccccccccccd f7  : 1003e0000000000000007
f8  : 1000c9404000000000000 f9  : 0ffff8000000000000000
f10 : 1003e0000000000002501 f11 : 1000c9403fffff6bfc000
r1  : 200000000029c200 r2  : 2000000000304e58 r3  : 60000fffffffafb0
r8  : 0000000000000009 r9  : 00000000fbad8001 r10 : 0000000000000c00
r11 : 20000000002ffa98 r12 : 60000fffffffafb0 r13 : 2000000000081de0
r14 : 20000000000a9238 r15 : 20000000000a9240 r16 : 000000000011d360
r17 : 20000000001b9360 r18 : 200000000009c000 r19 : 200000000009c228
r20 : 0000000200000000 r21 : 0000000100000000 r22 : 0000000000000000
r23 : 200000000003e16c r24 : 4000000000001bd0 r25 : 200000000003e0d0
r26 : 6000000000001da8 r27 : 200000000029c200 r28 : 20000000003008d0
r29 : 20000000003008c8 r30 : 20000000000804c8 r31 : 000000000000142b
r32 : 0000000000000000 r33 : 60000fffffffb42c r34 : 400000000000ba00
Kernel panic - not syncing: Aiee, killing interrupt handler!
Rebooting in 5 seconds..
