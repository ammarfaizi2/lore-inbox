Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRJTNRp>; Sat, 20 Oct 2001 09:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRJTNRf>; Sat, 20 Oct 2001 09:17:35 -0400
Received: from colorfullife.com ([216.156.138.34]:61968 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273213AbRJTNRX>;
	Sat, 20 Oct 2001 09:17:23 -0400
Message-ID: <3BD17986.177A92D0@colorfullife.com>
Date: Sat, 20 Oct 2001 15:17:58 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jgarzik@mandrakesoft.com
Subject: Re: [PATCH] try #2 even bigger natsemi patch
In-Reply-To: <3BD0CDED.3850B31D@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
>  static void netdev_timer(unsigned long data)
>  {
>         struct net_device *dev = (struct net_device *)data;
>         struct netdev_private *np = dev->priv;
> -       int next_tick = 60*HZ;
> +       int next_tick = 5*HZ;
> +       long ioaddr = dev->base_addr;
> +       u16 dspcfg;
> 
>         if (debug > 3) {
>                 /* DO NOT read the IntrStatus register,
> @@ -933,10 +1107,27 @@
>                            dev->name);
>         }
>         spin_lock_irq(&np->lock);
> -       check_link(dev);
> +
> +       /* check for a nasty random phy-reset - use dspcfg as a flag */
> +       writew(1, ioaddr+PGSEL);
> +       dspcfg = readw(ioaddr+DSPCFG);
> +       writew(0, ioaddr+PGSEL);
> +       if (dspcfg != DSPCFG_VAL) {
> +               if (!netif_queue_stopped(dev)) {
> +                       printk(KERN_INFO
> +                               "%s: possible phy reset: re-initializing\n",
> +                               dev->name);
> +                       init_registers(dev);
That's not SMP safe:
The interrupt handler acquires np->lock only for packet tx and errors,
not for packet rx.
Thus an rx interrupt could be running during init_registers - and
init_registers modifies the rx ring.
I think you must first check for the phy reset, and if you find a reset
then lock rx interrupts out with disable_irq.

	disable_irq(dev->irq);
	spin_lock_irq(&np->lock);

Calling disable_irq() always is probably too slow.

--
	Manfred
