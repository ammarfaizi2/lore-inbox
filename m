Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbTELTqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTELTqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:46:42 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:61960 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id S262485AbTELTql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:46:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
Date: Mon, 12 May 2003 21:59:18 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Jeff Garzik <jgarzik@pobox.com>
References: <200305111647.32113.daniel.ritz@gmx.ch> <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305122159.18843.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 May 2003 18:13, Zwane Mwaikambo wrote:
> On Sun, 11 May 2003, Daniel Ritz wrote:
> > hi
> >
> > i see that one on shutdown with a xircom ce3 10/100 16bit pcmcia network
> > card, driver xirc2ps_cs. the netdevice also never gets free, so the
> > shutdown never finishs. 2.5.68 also doesn't work, 2.5.67 does work.
>
> Interesting, eject with one of my PCMCIA (smc91c92) network cards also
> triggers an unhandled interrupt. I think the IRQ_NONE is incorrect here as
> the device really may have an interrupt to service.
>

ok, i tried that one, but no luck. still nobody cares. so it's that one:
  if (int_status == 0xff) { /* card may be ejected */
        DEBUG(3, "%s: interrupt %d for dead card\n", dev->name, irq);
        handled = 0;
        goto leave;
    }

but it's not ejected, only a modpobe -r...

> Index: linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c,v
> retrieving revision 1.19
> diff -u -p -B -r1.19 xirc2ps_cs.c
> --- linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c	8 May 2003 05:16:27
> -0000	1.19 +++ linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c	11 May 2003
> 15:20:03 -0000 @@ -1312,7 +1312,7 @@ xirc2ps_interrupt(int irq, void
> *dev_id,
>  				  */
>
>      if (!netif_device_present(dev))
> -	return IRQ_NONE;
> +	goto out;
>
>      ioaddr = dev->base_addr;
>      if (lp->mohawk) { /* must disable the interrupt */
> @@ -1515,6 +1515,7 @@ xirc2ps_interrupt(int irq, void *dev_id,
>       * force an interrupt with this command:
>       *	  PutByte(XIRCREG_CR, EnableIntr|ForceIntr);
>       */
> +  out:
>      return IRQ_RETVAL(handled);
>  } /* xirc2ps_interrupt */
>
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 2
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 2
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 2
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 2
>
> I can reproduce this, i'll have a look.

