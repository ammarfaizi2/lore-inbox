Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129795AbRB0TsV>; Tue, 27 Feb 2001 14:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129797AbRB0TsL>; Tue, 27 Feb 2001 14:48:11 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:16132 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129795AbRB0TsA>;
	Tue, 27 Feb 2001 14:48:00 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102271941.WAA21025@ms2.inr.ac.ru>
Subject: Re: possible bug x86 2.4.2 SMP in IP receive stack
To: feldy@myri.COM (Bob Felderman)
Date: Tue, 27 Feb 2001 22:41:10 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102232259.OAA20943@frisbee.myri.com> from "Bob Felderman" at Feb 24, 1 02:15:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Feb 23 12:42:30 rcc2 kernel: Warning: kfree_skb passed an skb still on a list (from c01f58dc).

BTW, that's didactic example of bug which results in similar behaviour.

Alexey


> From: andrewm@uow.EDU.AU (Andrew Morton)
> Subject: Re: Failed assertion
> Date: 27 Feb 2001 04:15:01 +0300
> 
> "David S. Miller" wrote:
> > 
> > Ralf Baechle writes:
> >  > No backtrace, the machine did continue as you'd suspect after a print.
> >  > The machine is a dual CPU Origin 200 with an IOC3 NIC.
> > 
> > What is your current kernel based upon, some older 2.4.x or
> > even 2.3.x variant?  Or is it sync'd to current?
> 
> Could this be a driver problem?  This code:
> 
>             netif_rx(skb);
> 
>             ip->rx_skbs[rx_entry] = NULL;   /* Poison  */
> 
>             new_skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
>             if (!new_skb) {
>                 /* Ouch, drop packet and just recycle packet
>                    to keep the ring filled.  */
>                 ip->stats.rx_dropped++;
>                 new_skb = skb;
>                 goto next;
>             }
> 
> looks scary.  We've passed an skb to the network stack,
> but we can continue to make it available to the device
> driver at the same time.
> 
> I'd suggest a printk() in there, plus perhaps do the
> alloc_skb _before_ the netif_rx().  Don't pass the skb
> to the stack if it is to be recycled.
