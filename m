Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTH0VIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTH0VIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 17:08:21 -0400
Received: from www.13thfloor.at ([212.16.59.250]:22999 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262321AbTH0VIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 17:08:18 -0400
Date: Wed, 27 Aug 2003 23:08:30 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Peter Osterlund <petero2@telia.com>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Netconsole debugging tool for 2.6
Message-ID: <20030827210830.GF26817@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030811085508.GH31810@waste.org> <m2vfsk16iv.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <m2vfsk16iv.fsf@p4.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 10:57:28PM +0200, Peter Osterlund wrote:
> Matt Mackall <mpm@selenic.com> writes:
> 
> > I've decided to take a stab at resurrecting Ingo's netconsole patch.
> > 
> > For those who missed it the first time around (for 2.4.10), this
> > module is a "serial console over networks" which lets you catch kernel
> > messages, oopses and so on that can't be caught by syslog.

hmm, sounds somewhat familiar, could you give
the location of the patches/tools/etc ...

> > I've also added support for a third NIC (TLAN). Accepting patches for
> > other cards (only about 10 lines of code each).

hmm, which cards are (un)supported ...
(read: I'm interrested ;)

TIA,
Herbert

> 
> It works fine on my computer with the patch below. The only problem is
> that it taints the kernel because of missing module license information.
> 
> Netconsole support for the 8139too NIC.
> 
> 
>  linux-petero/Documentation/networking/netlogging.txt |    1 
>  linux-petero/drivers/net/8139too.c                   |   22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff -puN Documentation/networking/netlogging.txt~netconsole-8139too Documentation/networking/netlogging.txt
> --- linux/Documentation/networking/netlogging.txt~netconsole-8139too	2003-08-26 22:21:43.000000000 +0200
> +++ linux-petero/Documentation/networking/netlogging.txt	2003-08-26 22:21:43.000000000 +0200
> @@ -52,3 +52,4 @@ Currently supported network drivers:
>   eepro100
>   tulip
>   tlan
> + 8139too
> diff -puN drivers/net/8139too.c~netconsole-8139too drivers/net/8139too.c
> --- linux/drivers/net/8139too.c~netconsole-8139too	2003-08-26 22:22:06.000000000 +0200
> +++ linux-petero/drivers/net/8139too.c	2003-08-26 22:26:46.000000000 +0200
> @@ -625,6 +625,7 @@ static struct net_device_stats *rtl8139_
>  static void rtl8139_set_rx_mode (struct net_device *dev);
>  static void __set_rx_mode (struct net_device *dev);
>  static void rtl8139_hw_start (struct net_device *dev);
> +static void poll_8139 (struct net_device *dev);
>  
>  #ifdef USE_IO_OPS
>  
> @@ -973,6 +974,9 @@ static int __devinit rtl8139_init_one (s
>  	dev->do_ioctl = netdev_ioctl;
>  	dev->tx_timeout = rtl8139_tx_timeout;
>  	dev->watchdog_timeo = TX_TIMEOUT;
> +#ifdef HAVE_POLL_CONTROLLER
> +	dev->poll_controller = &poll_8139;
> +#endif
>  
>  	/* note: the hardware is not capable of sg/csum/highdma, however
>  	 * through the use of skb_copy_and_csum_dev we enable these
> @@ -2596,6 +2600,24 @@ static int rtl8139_resume (struct pci_de
>  
>  #endif /* CONFIG_PM */
>  
> +#ifdef HAVE_POLL_CONTROLLER
> +
> +/*
> + * Polling 'interrupt' - used by things like netconsole to send skbs
> + * without having to re-enable interrupts. It's not called while
> + * the interrupt routine is executing.
> + */
> +
> +static void poll_8139 (struct net_device *dev)
> +{
> +       disable_irq(dev->irq);
> +       rtl8139_interrupt (dev->irq, dev, NULL);
> +       enable_irq(dev->irq);
> +}
> +
> +#endif
> +
> +
>  
>  static struct pci_driver rtl8139_pci_driver = {
>  	.name		= DRV_NAME,
> 
> _
> 
> -- 
> Peter Osterlund - petero2@telia.com
> http://w1.894.telia.com/~u89404340
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
