Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287558AbSALV5g>; Sat, 12 Jan 2002 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287572AbSALV50>; Sat, 12 Jan 2002 16:57:26 -0500
Received: from colorfullife.com ([216.156.138.34]:51217 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287558AbSALV5R>;
	Sat, 12 Jan 2002 16:57:17 -0500
Message-ID: <3C40B134.3FE631B4@colorfullife.com>
Date: Sat, 12 Jan 2002 22:57:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Tim Hockin <thockin@sun.com>, linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com
Subject: Re: [PATCH] Rx FIFO Overrun error found
In-Reply-To: <200201122111.g0CLBhK00442@www.hockin.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> >       if (dspcfg != DSPCFG_VAL) {
> >               if (!netif_queue_stopped(dev)) {
> > +                     spin_unlock_irq(&np->lock);
> >                       printk(KERN_INFO
> >                               "%s: possible phy reset: re-initializing\n",
> >                               dev->name);
> >                       disable_irq(dev->irq);
> >                       spin_lock_irq(&np->lock);
> > +                     natsemi_reset(dev);
> > +                     reinit_ring(dev);
> >                       init_registers(dev);
> >                       spin_unlock_irq(&np->lock);
> >                       enable_irq(dev->irq);
> 
> I'm not sure you want or need a natsemi_reset here - I'll need to check my
> notes on this when I get back to work.  Can I ask why this change was made?
> This is a very hard case to reproduce, so I'm not very comfortable changing
> the codepath :)  We've had National looking at this buggy behavior for
> months now, with little result.
>

init_registers() reinitialized the rx and tx ring pointers as seen by
the nic. You called it without init_ring(), i.e. the ring pointers as
seen by the driver didn't match the values used by the nic. It probably
only worked by chance. And changing the ring pointers while the nic is
in the middle of a data transfers just asks for trouble.
I agree that natsemi_stop_rxtx() instead of reset would be enough.

> >               /* enable the WOL interrupt.
> >                * Could be used to send a netlink message.
> >                */
> > -             writel(readl(ioaddr + IntrMask) | WOLPkt, ioaddr + IntrMask);
> > +             writel(WOLPkt, ioaddr + IntrMask);
> > +             writel(1, ioaddr + IntrEnable);
> 
> is this intended to blow away the other bits in IntrMask?  Keep in mind
> that Wake-On-Phy requires the PHY interrupt enabled, but I don't know if it
> needs it on in intrmask or just in the Phy intr reg.
>

Yes, they are always 0. Actually the code is (and was) never executed.
Everyone calls enable_wol_mode(,0).

--
        Manfred

